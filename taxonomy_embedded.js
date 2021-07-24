let result = {
  "head": {
    "link": [],
    "vars": [
      "root_name",
      "parent_name",
      "child_name"
    ]
  },
  "results": {
    "distinct": false,
    "ordered": true,
    "bindings": [
      {
        "root_name": {
          "type": "literal",
          "value": "Homo"
        },
        "parent_name": {
          "type": "literal",
          "value": "Homo"
        },
        "child_name": {
          "type": "literal",
          "value": "Homo heidelbergensis"
        }
      },
      {
        "root_name": {
          "type": "literal",
          "value": "Homo"
        },
        "parent_name": {
          "type": "literal",
          "value": "Homo"
        },
        "child_name": {
          "type": "literal",
          "value": "Homo sapiens"
        }
      },
      {
        "root_name": {
          "type": "literal",
          "value": "Homo"
        },
        "parent_name": {
          "type": "literal",
          "value": "Homo"
        },
        "child_name": {
          "type": "literal",
          "value": "environmental samples"
        }
      },
      {
        "root_name": {
          "type": "literal",
          "value": "Homo"
        },
        "parent_name": {
          "type": "literal",
          "value": "Homo sapiens"
        },
        "child_name": {
          "type": "literal",
          "value": "Homo sapiens neanderthalensis"
        }
      },
      {
        "root_name": {
          "type": "literal",
          "value": "Homo"
        },
        "parent_name": {
          "type": "literal",
          "value": "Homo sapiens"
        },
        "child_name": {
          "type": "literal",
          "value": "Homo sapiens subsp. 'Denisova'"
        }
      },
      {
        "root_name": {
          "type": "literal",
          "value": "Homo"
        },
        "parent_name": {
          "type": "literal",
          "value": "environmental samples"
        },
        "child_name": {
          "type": "literal",
          "value": "Homo sapiens environmental sample"
        }
      }
    ]
  }
};


let nodeIdSet = new Set();
let pg = {nodes: [], edges: []};
let edgeSet = new Set();
for (let binding of result.results.bindings) {
  nodeIdSet.add(binding.parent_name.value);
  nodeIdSet.add(binding.child_name.value);
  pg.edges.push({from: binding.parent_name.value, to: binding.child_name.value, properties: {}, labels: []});
}

for (let nodeId of nodeIdSet) {
  pg.nodes.push({id: nodeId, properties: {}, labels: []});
}

let helloGraph;
window.addEventListener("load", function () {
  let container = document.getElementById('graph');
  helloGraph = new HelloGraph(container);
  let config =

    {
      node: {
        caption: ['id'],
        icon: {
          person: 'f3a0',
          graph: 'f341',
        },
        onClick: (node) => {
          if (node?.properties?.url)
            window.open(node?.properties?.url[0], '_blank');
        },
        saturation: '100%',
        brightness: '37%',
      },
      edge: {
        caption: ['label', 'date'],
        length: {
          distance: 'value',
        },
        width: {
          flow: 'throughput',
        },
        saturation: '100%',
        brightness: '50%',
      },

      layout: 'hierarchical',
      layoutSettings: {
        enabled: true,
        levelSeparation: 150,
        nodeSpacing: 100,
        treeSpacing: 200,
        blockShifting: true,
        edgeMinimization: true,
        parentCentralization: true,
        direction: 'LR',        // UD, DU, LR, RL
        sortMethod: 'directed',  // hubsize, directed
        shakeTowards: 'leaves'  // roots, leaves
      },
      /*  layout: 'custom',
        layoutSettings: {
          x: 'x',
          y: 'y'
        },*/
    }

  helloGraph.updateGraph(pg, config);
});
    