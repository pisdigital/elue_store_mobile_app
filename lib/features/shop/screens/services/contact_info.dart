import 'package:country_flags/country_flags.dart';
import 'package:elue_store/common/widgets/appbar/appbar.dart';
import 'package:elue_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text('Contact Information',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            USInformationWidget(),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            ETInformationWidget(),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const Text(
              "All Rights Reserved © Eluestore 2024",
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}

class USInformationWidget extends StatelessWidget {
  const USInformationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CountryFlag.fromCountryCode(
              'US',
              width: 30,
              height: 25,
              // shape: const RoundedRectangle(6),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            const Text(
              "USA CUSTOMER SERVICE NUMBER",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            )
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 50.0),
          padding: EdgeInsets.all(30.0),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000), // Color with alpha value
                  blurRadius: 15,
                  spreadRadius: 0,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(10.0)),
          child: const Column(
            children: [
              Text(
                "206-375-7327",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Divider(),
              Text(
                "206-535-0886",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )
            ],
          ),
        )
      ],
    );
  }
}

class ETInformationWidget extends StatelessWidget {
  const ETInformationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CountryFlag.fromCountryCode(
              'ET',
              width: 30,
              height: 25,
              // shape: const RoundedRectangle(6),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            const Text(
              "ET CUSTOMER SERVICE NUMBER",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            )
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 50.0),
          padding: EdgeInsets.all(30.0),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000), // Color with alpha value
                  blurRadius: 15,
                  spreadRadius: 0,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(10.0)),
          child: const Column(
            children: [
              Text(
                "+251-911-595-158",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Divider(),
              Text(
                "+251-913-834-466",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Divider(),
              Text(
                "+251-913-665-631",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Divider(),
              Text(
                "+251-911-639-755",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Divider(),
              Text(
                "+251-913-035-102",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Divider(),
              Text(
                "+251-953-222-275",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )
            ],
          ),
        )
      ],
    );
  }
}
