import 'package:currency_converter/screens/converter_Screen/converter_viewmodel.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyConverter extends StatelessWidget {
  CurrencyConverter({super.key});

  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, value, child) {
      Provider.of<CurrencyProvider>(context).checkIfOnline(context);

      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(Provider.of<CurrencyProvider>(context).connection.toString()),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width / 3,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Enter Amount"),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        enabled: true,
                        // onChanged: ((value) {
                        //   context.watch<CurrencyProvider>().setAmount(value);
                        // }),
                        onSubmitted: ((value) async {
                          context.read<CurrencyProvider>().setAmount(value);
                          await context.read<CurrencyProvider>().convert();
                        }),
                        controller: fromController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey,
                            border: InputBorder.none),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              showCurrencyPicker(
                                context: context,
                                showFlag: true,
                                showCurrencyName: true,
                                showCurrencyCode: true,
                                onSelect: (Currency currency) {
                                  print('Select currency: ${currency.name}');
                                  context
                                      .read<CurrencyProvider>()
                                      .putFromCode(currency.code);
                                },
                                currencyFilter: <String>[
                                  'EUR',
                                  'GBP',
                                  'USD',
                                  'AUD',
                                  'CAD',
                                  'JPY',
                                  'HKD',
                                  'CHF',
                                  'SEK',
                                  'ILS'
                                ],
                              );
                            },
                            icon: Icon(Icons.arrow_drop_down)),
                        Text("From"),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 40,
                            color: Colors.grey[500],
                            child: Text(
                                "${context.watch<CurrencyProvider>().fromCode}"),
                          ),
                        ),
                        Text("To"),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 40,
                            color: Colors.grey[500],
                            child: Text(
                                "${context.watch<CurrencyProvider>().toCode}"),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              showCurrencyPicker(
                                context: context,
                                showFlag: true,
                                showCurrencyName: true,
                                showCurrencyCode: true,
                                onSelect: (Currency currency) {
                                  print('Select currency: ${currency.name}');
                                  context
                                      .read<CurrencyProvider>()
                                      .putToCode(currency.code);
                                },
                                currencyFilter: <String>[
                                  'EUR',
                                  'GBP',
                                  'USD',
                                  'AUD',
                                  'CAD',
                                  'JPY',
                                  'HKD',
                                  'CHF',
                                  'SEK',
                                  'ILS'
                                ],
                              );
                            },
                            icon: Icon(Icons.arrow_drop_down)),
                      ],
                    ),
                    if (context.watch<CurrencyProvider>().Onlineresult !=
                        null) ...[
                      Container(
                        alignment: Alignment.center,
                        color: Colors.grey[400],
                        height: 40,
                        child: Text(context
                                .watch<CurrencyProvider>()
                                .Onlineresult!
                                .result
                                .toString() +
                            "  " +
                            context.watch<CurrencyProvider>().toCode),
                      ),
                    ] else if (context
                            .watch<CurrencyProvider>()
                            .offlineresult !=
                        null) ...[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Text("fixed"),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      color: Colors.grey[500],
                                      child: Text(context
                                              .watch<CurrencyProvider>()
                                              .offlineresult['fixed']
                                              .toString() +
                                          "  " +
                                          context
                                              .watch<CurrencyProvider>()
                                              .toCode),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Text("floating"),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      color: Colors.grey[500],
                                      child: Text(context
                                              .watch<CurrencyProvider>()
                                              .offlineresult['floating']
                                              .toString() +
                                          "  " +
                                          context
                                              .watch<CurrencyProvider>()
                                              .toCode),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      Container(
                        color: Colors.grey[400],
                        height: 40,
                        child: Text("Result"),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }));
  }
}
