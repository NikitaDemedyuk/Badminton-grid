import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

void main() {
  runApp(const TreeViewPageFromJson());
}

class TreeViewPageFromJson extends StatefulWidget {
  const TreeViewPageFromJson({super.key});

  @override
  TreeViewPageFromJsonState createState() => TreeViewPageFromJsonState();
}

class TreeViewPageFromJsonState extends State<TreeViewPageFromJson> {
  var json = {
    'nodes': [
      {'id': 1, 'label': '1'},
      {'id': 2, 'label': '2'},
      {'id': 3, 'label': '3'},
      {'id': 4, 'label': '4'},
      {'id': 5, 'label': '5'},
      {'id': 6, 'label': '6'},
      {'id': 7, 'label': '7'},
      {'id': 8, 'label': '8'},
      {'id': 9, 'label': '9'},
      {'id': 10, 'label': '10'},
      {'id': 11, 'label': '11'},
      {'id': 12, 'label': '12'},
      {'id': 13, 'label': '13'},
      {'id': 14, 'label': '14'},
      {'id': 15, 'label': '15'},
    ],
    'edges': [
      {'from': 1, 'to': 2},
      {'from': 1, 'to': 3},
      {'from': 2, 'to': 4},
      {'from': 2, 'to': 5},
      {'from': 3, 'to': 6},
      {'from': 3, 'to': 7},
      {'from': 4, 'to': 8},
      {'from': 4, 'to': 9},
      {'from': 5, 'to': 10},
      {'from': 5, 'to': 11},
      {'from': 6, 'to': 12},
      {'from': 6, 'to': 13},
      {'from': 7, 'to': 14},
      {'from': 7, 'to': 15},
    ]
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 444,
              child: InteractiveViewer(
                constrained: false,
                boundaryMargin: const EdgeInsets.all(100),
                minScale: 0.01,
                maxScale: 5.6,
                child: GraphView(
                  graph: graph,
                  algorithm:
                      BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
                  paint: Paint()
                    ..color = Colors.blue
                    ..strokeWidth = 1
                    ..style = PaintingStyle.stroke,
                  builder: (Node node) {
                    // I can decide what widget should be shown here based on the id
                    var a = node.key!.value as int?;
                    var nodes = json['nodes']!;
                    var nodeValue =
                        nodes.firstWhere((element) => element['id'] == a);
                    return rectangleWidget(nodeValue['label'] as String?);
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rectangleWidget(String? a) {
    return Container(
      height: 92,
      width: 302,
      color: Colors.white,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 4),
        itemBuilder: (context, index) => Container(
          height: 44,
          constraints: const BoxConstraints(
            maxHeight: 44,
            minHeight: 44,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.blue,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 10, 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 36,
                  width: 36,
                  constraints: const BoxConstraints(
                    maxWidth: 36,
                    maxHeight: 36,
                    minWidth: 36,
                    minHeight: 36,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Петров А.А.',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'R:1045',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '1',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    var edges = json['edges']!;
    for (var element in edges) {
      var fromNodeId = element['from'];
      var toNodeId = element['to'];
      graph.addEdge(Node.Id(fromNodeId), Node.Id(toNodeId));
    }

    builder
      ..siblingSeparation = (16)
      ..levelSeparation = (20)
      ..subtreeSeparation = (16)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_RIGHT_LEFT);
  }
}
