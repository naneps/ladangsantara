import 'dart:io';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:ladangsantara/app/common/buttons/x_button.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/ui/x_appbar.dart';
import 'package:ladangsantara/app/common/utils.dart';
import 'package:ladangsantara/app/models/recipe_model.dart';
import 'package:ladangsantara/app/providers/recipe_provider.dart';
import 'package:ladangsantara/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controller/classifier.dart';
import 'styles.dart';

const _labelsFileName = 'assets/models/labels.txt';
const _modelFileName = 'models/model_unquant.tflite';

class FreshnessRecognize extends StatefulWidget {
  const FreshnessRecognize({super.key});

  @override
  State<FreshnessRecognize> createState() => _FreshnessRecognizeState();
}

enum _ResultStatus {
  notStarted,
  notFound,
  found,
}

class _FreshnessRecognizeState extends State<FreshnessRecognize> {
  bool _isAnalyzing = false;
  final picker = ImagePicker();
  File? _selectedImageFile;
  final recipeProvider = Get.put<RecipeProvider>(RecipeProvider());
  // Result
  _ResultStatus _resultStatus = _ResultStatus.notStarted;
  String _plantLabel = ''; // Name of Error Message
  List<RecipeModel> recipes = <RecipeModel>[];
  late Classifier _classifier;

  @override
  void initState() {
    super.initState();
    _loadClassifier();
  }

  void getRecipes(String label) async {
    await recipeProvider.getRecipes(search: label).then((res) {
      if (res.statusCode == 200) {
        setState(() {
          recipes = res.body['data'];
        });
      }
    });
  }

  Future<void> _loadClassifier() async {
    debugPrint(
      'Start loading of Classifier with '
      'labels at $_labelsFileName, '
      'model at $_modelFileName',
    );

    final classifier = await Classifier.loadWith(
      labelsFileName: _labelsFileName,
      modelFileName: _modelFileName,
    );
    _classifier = classifier!;
    print('ini nih : $_classifier');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        RoundedContainer(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: XButton(
                  hasIcon: true,
                  icon: MdiIcons.camera,
                  onPressed: () {
                    _onPickPhoto(ImageSource.camera);
                  },
                  text: "Ambil Gambar",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: XButton(
                  hasIcon: true,
                  icon: MdiIcons.image,
                  onPressed: () {
                    _onPickPhoto(ImageSource.gallery);
                  },
                  text: "Pilih Gambar",
                ),
              ),
            ],
          ),
        ),
      ],
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // _loadClassifier();
            //clear state
            // setState(() {
            //   _selectedImageFile = null;
            //   _resultStatus = _ResultStatus.notStarted;
            //   _plantLabel = '';
            // });
          },
          child: RoundedContainer(
            child: ListView(
              children: [
                XAppBar(
                  title: "Deteksi Kesegaran",
                  hasRightIcon: false,
                  leftIcon: MdiIcons.chevronLeft,
                  onTapRightIcon: () {},
                ),
                _buildPhotoView(),
                Visibility(
                  visible: _plantLabel.isEmpty,
                  child: RoundedContainer(
                    padding: const EdgeInsets.all(10),
                    color: ThemeApp.secondaryColor,
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      "Yuk Cek Kesegaran Sayur dan Buahmu!",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: ThemeApp.darkColor,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _plantLabel.isNotEmpty,
                  child: Column(
                    children: [
                      RoundedContainer(
                        child: const Text(
                          'Hasil Analisis',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: kColorTextGreen,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      RoundedContainer(
                        padding: const EdgeInsets.all(10),
                        width: Get.width,
                        margin: const EdgeInsets.all(10),
                        color: ThemeApp.infoColor,
                        child: Text(
                          _plantLabel,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: ThemeApp.darkColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _isAnalyzing,
                  child: Utils.loadingWidget(
                    size: 50,
                  ),
                ),
                _buildRecipeList()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoView() {
    return RoundedContainer(
      hasBorder: true,
      height: 300,
      width: Get.width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: _selectedImageFile == null
          ? Image.asset(
              'assets/images/vegetarians.jpg',
              fit: BoxFit.cover,
            )
          : RoundedContainer(
              width: 100,
              height: 100,
              child: Image.file(
                _selectedImageFile!,
                fit: BoxFit.contain,
              ).animate().flipH(),
            ),
    );
  }

  void _setAnalyzing(bool flag) {
    setState(() {
      _isAnalyzing = flag;
    });
  }

  void _onPickPhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      return;
    }

    final imageFile = File(pickedFile.path);
    setState(() {
      _selectedImageFile = imageFile;
    });

    print(_selectedImageFile);
    _analyzeImage(imageFile);
  }

  void _analyzeImage(File image) {
    _setAnalyzing(true);

    final imageInput = img.decodeImage(image.readAsBytesSync())!;
    print('ini imageInput $imageInput');

    final resultCategory = _classifier.predict(imageInput);
    print('ini resultCategory $resultCategory');

    final result = resultCategory.score >= 0.8
        ? _ResultStatus.found
        : _ResultStatus.notFound;
    final plantLabel = resultCategory.label;

    _setAnalyzing(false);

    setState(() {
      _resultStatus = result;
      _plantLabel = plantLabel;
    });
    if (_resultStatus == _ResultStatus.found) {
      getRecipes(_plantLabel);
    }
  }

  Widget _buildRecipeList() {
    return RoundedContainer(
      hasBorder: true,
      width: Get.width,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoundedContainer(
            width: Get.width,
            padding: const EdgeInsets.all(10),
            color: ThemeApp.infoColor,
            radius: 5,
            child: const Center(
              child: Text(
                "Rekomendasi Resep Dari Hasil Analisis ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          RoundedContainer(
            constraints: const BoxConstraints(maxHeight: 300),
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return ExpansionTile(
                  title: Text(
                    recipe.name!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    RoundedContainer(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Deskripsi",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ExpandableText(
                            recipe.description!,
                            expandText: "Selengkapnya",
                            collapseText: "Sembunyikan",
                            linkColor: ThemeApp.darkColor,
                          )
                        ],
                      ),
                    ),
                    RoundedContainer(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Bahan-Bahan",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ExpandableText(
                            recipe.ingredient!,
                            expandText: "Selengkapnya",
                            collapseText: "Sembunyikan",
                            linkColor: ThemeApp.darkColor,
                          )
                        ],
                      ),
                    ),
                    RoundedContainer(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Cara Memasak",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ExpandableText(
                            recipe.steps!,
                            expandText: "Selengkapnya",
                            collapseText: "Sembunyikan",
                            linkColor: ThemeApp.darkColor,
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
