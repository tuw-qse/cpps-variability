Attribute "length": {
    description: "Length of an object in mm",
    defaultValue: 1.0,
    type: "Number",
    unit: "mm"
}

Attribute "partialProduct": {
    description: "Specifies if the given product is a partial one",
    defaultValue: "false",
    type: "String"
}

Product "Fork": {
    name: "Fork",
    isAbstract: true,
    partialProduct: "true"
}

Product "Fork3": {
    name: "Fork 3",
    length: 30,
    implements: [ "Fork" ],
    requires: ["Fork5"],
    partialProduct: "true"
}
Product "Fork4": {
    name: "Fork 4",
    length: 30,
    implements: [ "Fork" ],
    requires: ["Fork5"],
    partialProduct: "true"
}
Product "Fork5": {
    name: "Fork 5",
    implements: [ "Fork" ],
    length: 50,
    partialProduct: "true"
}

Product "Pipe": {
    name: "Abstract Pipe",
    isAbstract: true,
    partialProduct: "true"
}
Product "Pipe2": {
    name: "Pipe 2",
    implements: ["Pipe"],
    excludes: [ "Pipe3", "Pipe8" ],
    length: 20,
    partialProduct: "true"
}
Product "Pipe3": {
    name: "Pipe 3",
    implements: ["Pipe"],
    excludes: [ "Pipe2", "Pipe8" ],
    length: 30,
    partialProduct: "true"
}
Product "Pipe8": {
    name: "Pipe 8",
    implements: ["Pipe"],
    excludes: [ "Pipe3", "Pipe2" ],
    length: 30,
    partialProduct: "true"
}

Product "Lock": {
    name: "Abstract Lock",
    isAbstract: true,
    requires: ["Pipe"],
    partialProduct: "true"
}

Product "Lock1": {
    name: "Lock 1",
    implements: ["Lock"],
    excludes: [ "Lock2", "Lock3" ],
    length: 30,
    partialProduct: "true"
}

Product "Lock2": {
    name: "Lock 2",
    implements: ["Lock"],
    excludes: [ "Lock1", "Lock3" ],
    length: 20,
    partialProduct: "true"
}

Product "Lock3": {
    name: "Lock 3",
    implements: ["Lock"],
    excludes: [ "Lock1", "Lock2" ],
    length: 30,
    partialProduct: "true"
}

Product "Barrel1": {
    name: "Barrel 1",
    length:50,
    requires: ["Pipe"],
    partialProduct: "true"
}

Product "Screw": {
    name:"Screw",
    requires: ["Ring1", "Jack1"],
    partialProduct: "true"
}

Product "Ring1": {
    name: "Ring 1",
    requires: ["Pipe"],
    partialProduct: "true"
}

Product "O-Ring": {
    name: "O-Ring",
    requires: ["Ring1", "Jack1"],
    partialProduct: "true"
}

Product "Jack1": {
    name: "Jack 1",
    requires: ["Pipe"],
    partialProduct: "true"
}

Product "ForkProduct": {
    name: "ForkProduct",
    isAbstract: true,
    children: [ "Barrel1", "Screw", "Jack1", "Ring1", "O-Ring", "Fork3", "Fork4", "Fork5", "Pipe", "Lock"],
    requires: [ "Barrel1", "Screw", "Jack1", "Ring1", "O-Ring", "Fork3", "Fork4", "Fork5", "Pipe", "Lock"],
}
Product "Fork-13": {
    name: "Fork 13",
    implements: ["ForkProduct"],
    requires: ["Pipe8", "Lock3"]
}
Product "Fork-2R": {
    name: "Fork 2R",
    implements: ["ForkProduct"],
    requires: ["Pipe3", "Lock2"]
}
Product "Fork-46": {
    name: "Fork 46",
    implements: ["ForkProduct"],
    requires: ["Pipe3", "Lock1"]
}
Product "Fork-57": {
    name: "Fork 57",
    implements: ["ForkProduct"],
    requires: ["Pipe2", "Lock1"]
}

Process "InsertPipe": {
    name: "InsertPipe",
    isAbstract: true,
    inputs: [ {productId: "Pipe"} ],
    outputs: [ {OP1: {productId: "Pipe", costWeight: 1.0}} ]
}

Process "InsertPipe2": {
    name: "InsertPipe2",
    isAbstract: false,
    implements: ["InsertPipe"],
    inputs: [ {productId: "Pipe2"} ],
    outputs: [ {OP2: {productId: "Pipe2", costWeight: 1.0}} ]
}

Process "InsertPipe3": {
    name: "InsertPipe3",
    isAbstract: false,
    implements: ["InsertPipe"],
    inputs: [ {productId: "Pipe3"} ],
    outputs: [ {OP3: {productId: "Pipe3", costWeight: 1.0}} ]
}

Process "InsertPipe8": {
    name: "InsertPipe8",
    isAbstract: false,
    implements: ["InsertPipe"],
    inputs: [ {productId: "Pipe8"} ],
    outputs: [ {OP4: {productId: "Pipe8", costWeight: 1.0}} ]
}

Process "InsertBarrel1": {
    name: "InsertBarrel1",
    isAbstract: false,
    inputs: [ {productId: "Barrel1"} ],
    outputs: [ {OP5: {productId: "Barrel1", costWeight: 1.0}} ]
}

Process "PressBarrel1": {
    name: "PressBarrel1",
    isAbstract: false,
    requires: [ "InsertBarrel1", "InsertPipe" ],
    inputs: [ {productId: "Barrel1"}, {productId: "Pipe"} ],
    outputs: [ {OP6: {productId: "ForkProduct", costWeight: 1.0}} ]
}

Process "InsertJack1": {
    name: "InsertJack1",
    isAbstract: false,
    inputs: [ {productId: "Jack1"} ],
    outputs: [ {OP7: {productId: "Jack1", costWeight: 1.0}} ]
}

Process "PressJack1": {
    name: "PressJack1",
    isAbstract: false,
    requires: [ "InsertJack1", "InsertPipe" ],
    inputs: [ {productId: "Jack1"}, {productId: "Pipe"} ],
    outputs: [ {OP8: {productId: "ForkProduct", costWeight: 1.0}} ]
}

Process "InsertRing1": {
    name: "InsertRing1",
    isAbstract: false,
    inputs: [ {productId: "Ring1"} ],
    outputs: [ {OP9: {productId: "Ring1", costWeight: 1.0}}]
}

Process "PressRing1": {
    name: "PressRing1",
    isAbstract: false,
    requires: [ "InsertRing1", "InsertPipe" ],
    inputs: [ {productId: "Ring1"}, {productId: "Pipe"} ],
    outputs: [ {OP10: {productId: "ForkProduct", costWeight: 1.0}}]
}

Process "InsertORing": {
    name: "InsertORing",
    isAbstract: false,
    inputs: [ {productId: "O-Ring"} ],
    outputs: [ {OP11: {productId: "O-Ring", costWeight: 1.0}}]
}

Process "PressORing": {
    name: "InsertORing",
    isAbstract: false,
    requires: [ "InsertORing", "PressJack1", "PressRing1" ],
    inputs: [ {productId: "O-Ring"}, {productId: "Pipe"}, {productId: "Jack1"}, {productId: "Ring1"} ],
    outputs: [ {OP12: {productId: "ForkProduct", costWeight: 1.0}}]
}

Process "InsertScrew": {
    name: "InsertScrew",
    isAbstract: false,
    inputs: [ {productId: "Screw"} ],
    outputs: [ {OP13: {productId: "Screw", costWeight: 1.0}}]
}

Process "PressScrew": {
    name: "InsertScrew",
    isAbstract: false,
    requires: [ "InsertScrew", "PressJack1", "PressRing1" ],
    inputs: [ {productId: "Screw"}, {productId: "Pipe"}, {productId: "Jack1"}, {productId: "Ring1"} ],
    outputs: [ {OP14: {productId: "ForkProduct", costWeight: 1.0}}]
}

Process "InsertFork5": {
    name: "InsertFork5",
    isAbstract: false,
    inputs: [ {productId: "Fork5"} ],
    outputs: [ {OP15: {productId: "Fork5", costWeight: 1.0}}]
}

Process "WeldFork5": {
    name: "WeldFork5",
    isAbstract: false,
    requires: [ "InsertFork5", "InsertPipe" ],
    inputs: [ {productId: "Fork5"}, {productId: "Pipe"} ],
    outputs: [ {OP16: {productId: "ForkProduct", costWeight: 1.0}}]
}

Process "InsertFork3": {
    name: "InsertFork3",
    isAbstract: false,
    inputs: [ {productId: "Fork3"}, {productId: "Pipe"} ],
    outputs: [ {OP17: {productId: "ForkProduct", costWeight: 1.0}}]
}

Process "WeldFork3": {
    name: "WeldFork3",
    isAbstract: false,
    requires: [ "InsertFork3", "WeldFork5" ],
    inputs: [ {productId: "Fork3"}, {productId: "Pipe"}, {productId: "Fork5"} ],
    outputs: [ {OP18: {productId: "ForkProduct", costWeight: 1.0}}]
}

Process "InsertFork4": {
    name: "InsertFork4",
    isAbstract: false,
    inputs: [ {productId: "Fork4"} ],
    outputs: [ {OP19: {productId: "Fork4", costWeight: 1.0}}]
}

Process "WeldFork4": {
    name: "WeldFork4",
    isAbstract: false,
    requires: [ "InsertFork4", "WeldFork5" ],
    inputs: [ {productId: "Fork4"}, {productId: "Pipe"}, {productId: "Fork5"} ],
    outputs: [ {OP20: {productId: "ForkProduct", costWeight: 1.0}}]
}

Process "InsertLock": {
    name: "InsertLock",
    isAbstract: true,
    inputs: [ {productId: "Lock"} ],
    outputs: [ {OP21: {productId: "Lock", costWeight: 1.0}}]
}

Process "InsertLock1": {
    name: "InsertLock1",
    isAbstract: false,
    implements: [ "InsertLock" ],
    inputs: [ {productId: "Lock1"} ],
    outputs: [ {OP22: {productId: "Lock1", costWeight: 1.0}}]
}

Process "InsertLock2": {
    name: "InsertLock2",
    isAbstract: false,
    implements: [ "InsertLock" ],
    inputs: [ {productId: "Lock2"} ],
    outputs: [ {OP23: {productId: "Lock2", costWeight: 1.0}}]
}

Process "InsertLock3": {
    name: "InsertLock3",
    isAbstract: false,
    implements: [ "InsertLock" ],
    inputs: [ {productId: "Lock3"} ],
    outputs: [ {OP24: {productId: "Lock3", costWeight: 1.0}}]
}

Process "WeldLock": {
    name: "WeldLock",
    isAbstract: true,
    requires: [ "InsertLock", "WeldFork3", "WeldFork4" ],
    inputs: [ {productId: "Lock"}, {productId: "Pipe"}, {productId: "Fork4"}, {productId: "Fork3"} ],
    outputs: [ {OP25: {productId: "ForkProduct", costWeight: 1.0}}]
}

Process "WeldLock1": {
    name: "WeldLock1",
    isAbstract: false,
    implements: [ "WeldLock" ],
    requires: [ "InsertLock1", "WeldFork3", "WeldFork4" ],
    inputs: [ {productId: "Lock1"}, {productId: "Pipe"}, {productId: "Fork4"}, {productId: "Fork3"} ],
    outputs: [ {OP26: {productId: "ForkProduct", costWeight: 1.0}}]
}

Process "WeldLock2": {
    name: "WeldLock2",
    isAbstract: false,
    implements: [ "WeldLock" ],
    requires: [ "InsertLock2", "WeldFork3", "WeldFork4" ],
    inputs: [ {productId: "Lock2"}, {productId: "Pipe"}, {productId: "Fork4"}, {productId: "Fork3"} ],
    outputs: [ {OP27: {productId: "ForkProduct", costWeight: 1.0}}]
}

Process "WeldLock3": {
    name: "WeldLock3",
    isAbstract: false,
    implements: [ "WeldLock" ],
    requires: [ "InsertLock3", "WeldFork3", "WeldFork4" ],
    inputs: [ {productId: "Lock3"}, {productId: "Pipe"}, {productId: "Fork4"}, {productId: "Fork3"} ],
    outputs: [ {OP28: {productId: "ForkProduct", costWeight: 1.0}}]
}

Constraint "Constraint1": {
    definition: "Lock1, Pipe2, Pipe3 -> Lock1 implies Pipe2 or Pipe3" 
}

Constraint "Constraint2": {
    definition: "Lock2, Pipe3 -> Lock2 implies Pipe3" 
}

Constraint "Constraint3": {
    definition: "Lock3, Pipe8 -> Lock3 implies Pipe8" 
}