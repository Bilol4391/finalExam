import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/repostory/valyuta_repo.dart';
import '../../../model/valyuta_model.dart';
import '../../components/style/style.dart';

class NBUPage extends StatefulWidget {
  const NBUPage({Key? key}) : super(key: key);

  @override
  State<NBUPage> createState() => _NBUPageState();
}

class _NBUPageState extends State<NBUPage> {
  bool isLoading = true;

  List<Valyuta>? listOfV = [];
  List<String> listOfFlag = [
    "ua",
    'au',
    'ca',
    'ch',
    'cn',
    'gr',
    'cn',
    'ye',
    'ag',
    'ar',
    'am',
    'aw',
    'au',
    'at',
    'fk',
    'fo',
    'fj',
    'fi',
    'fr',
    'gf',
    'pf',
    'tr',
    'ua',
    'us'
  ];

  Future getV() async {
    isLoading = true;
    listOfV = await Repo.getValyut();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getV();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: listOfV?.length ?? 0,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 150,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  gradient: Style.customGeadient(color: Style.primaryColor),
                  color: Style.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: CircleFlag(
                        listOfFlag[index],
                        size: 32,
                      ),
                      title: Text(
                        listOfV?[index].title ?? "",
                        style: Style.primaryText(
                            size: 12, textColor: Style.whiteColor),
                      ),
                    ),
                    Text(
                      listOfV?[index].cbPrice ?? "",
                      style: Style.primaryText(textColor: Style.whiteColor),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
