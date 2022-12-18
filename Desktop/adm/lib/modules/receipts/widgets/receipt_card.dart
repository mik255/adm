import 'package:adm/models/receipt.dart';
import 'package:adm/models/story.model.dart';
import 'package:adm/shared/extensions/currence.dart';
import 'package:flutter/material.dart';


class ReceiptCard extends StatelessWidget {
  ReceiptCard({Key? key,required this.story}) : super(key: key);
  Story story;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffececec),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.store,
                        color: Color(0xff545454),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text (story.name,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Color(0xff545454),
                              fontSize: 20,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                            )),
                      ),
               
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    story.paymentType!,
                    style: const TextStyle(
                      color: Color(0xff9a9a9a),
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        "${story.productList.length} itens",
                        style: const TextStyle(
                          color: Color(0xff9a9a9a),
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                      left: BorderSide(color: Color(0xffff9811), width: 2))),
              child: Column(
                children: [
                  ...story.productList.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${e.count}x "
                                "${e.name}",
                                style: const TextStyle(
                                  color: Color(0xff9a9a9a),
                                  fontSize: 12,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                e.getTotal().toCurrence(),
                                style: const TextStyle(
                                  color: Color(0xff9a9a9a),
                                  fontSize: 14,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            width: 40,
                            height: 40,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    e.urlImg,
                                  ),
                                  fit: BoxFit.cover),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                    offset: Offset(2, 2))
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
