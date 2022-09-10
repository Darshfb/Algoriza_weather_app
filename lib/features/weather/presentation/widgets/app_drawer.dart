import 'package:flutter/material.dart';
import 'package:weather/core/shared/Local/cache_helper.dart';
import 'package:weather/core/shared/component/custom_button.dart';
import 'package:weather/core/shared/component/custom_text_form_field.dart';
import 'package:weather/features/weather/presentation/bloc/weather_cubit.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key}) : super(key: key);
  final controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Container(
          width: MediaQuery.of(context).size.width / 1.3,
          color: const Color(0xff636b8b),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15.0,
                    ),
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide.none),
                      child: CustomTextFormField(
                        controller: controller,
                        validatorText: 'Search text must\'t be empty',
                        textInputType: TextInputType.text,
                        isDense: true,
                        labelText: 'Search',
                        hintText: 'Write your city',
                        onSubmit: (value) {
                          CacheHelper.saveData(
                              key: 'Cached', value: controller.text);
                          WeatherCubit.get(context)
                              .getWeatherData(cityName: controller.text);
                          Navigator.pop(context);
                          controller.clear();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomButton(
                          backgroundColor: Colors.grey,
                          radius: 5,
                          minWidth: double.infinity,
                          onPressed: () {
                            CacheHelper.saveData(
                                key: 'Cached', value: controller.text);
                            WeatherCubit.get(context)
                                .getWeatherData(cityName: controller.text);
                            Navigator.pop(context);
                            controller.clear();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Search',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Icon(
                                Icons.content_paste_search,
                                color: Colors.white,
                                size: 18,
                              )
                            ],
                          )),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Divider(
                        thickness: 1,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.location_on_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Last Location',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    if (CacheHelper.getData(key: 'Cached') != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: CustomButton(
                            backgroundColor: Colors.grey,
                            radius: 20,
                            onPressed: () {
                              WeatherCubit.get(context).getWeatherData(
                                  cityName: CacheHelper.getData(key: 'Cached'));
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 14.0,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  CacheHelper.getData(key: 'Cached'),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Divider(
                        thickness: 1,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: CustomButton(
                        backgroundColor: Colors.grey,
                        minWidth: double.infinity,
                        radius: 25.0,
                        onPressed: () {},
                        child: const Text(
                          'Manage Locations',
                          style: TextStyle(color: Colors.white,
                          fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Divider(
                        thickness: 1,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const[
                          Icon(
                            Icons.info_outline,
                            color: Colors.white,
                          ),
                          SizedBox(width: 18.0,),
                          Text(
                            'Report Wrong Location',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18.0,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const[
                          Icon(
                            Icons.headset_mic,
                            color: Colors.white,
                          ),
                          SizedBox(width: 18.0,),
                          Text(
                            'Contact us',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
