import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;
  ChartBar({
    @required this.label,
    @required this.spendingAmount,
    @required this.spendingPctOfTotal,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrain) {
        return Column(
          children: [
            Container(
              height: constrain.maxHeight * .1,
              child: FittedBox(
                child: Text(
                  '\$${spendingAmount.toStringAsFixed(0)}',
                ),
              ),
            ),
            SizedBox(
              height: constrain.maxHeight * .1,
            ),
            Container(
              height: constrain.maxHeight * .6,
              width: 8,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurple),
                  ),
                  FractionallySizedBox(
                    heightFactor: 1 - spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constrain.maxHeight * .1,
            ),
            Container(
              height: constrain.maxHeight * .1,
              child: FittedBox(
                child: Text('$label'),
              ),
            ),
          ],
        );
      },
    );
  }
}
