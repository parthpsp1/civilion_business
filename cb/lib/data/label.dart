class LocalData {
  static List<String> labels = [
    "Architect",
    "Structural",
    "Transporters",
    "Machineries",
    "Contractor",
    "Surveyor",
    "Quality Testing",
    "Project Manager",
  ];

  static Map<String, List<String>> specialityLabels = {
    "Architect": [
      "Interior & Exterior Designer",
      "Landscaping",
      "MEP",
    ],
    "Structural": [
      "RCC & Steel Designer",
      "Structural Audit",
    ],
    "Transporters": [
      "Personal Vehicle",
      "Company Vechicle",
    ],
    "Machineries": [
      "JCB",
      "Cutter",
      "Power Shovel",
      "Dump Truck",
      "Tractor",
      "Compactor",
      "RMC Truck",
      "Cemcent Gang",
      "Cranes",
      "Pile & Boring Equipment"
    ],
    "Contractor": [
      "Centring",
      "Electrical",
      "Fabrication",
      "Carpenter",
      "Labor",
      "Brickwork",
      "Plumbing",
      "Flooring",
      "Painting",
      "Security",
      "Developer"
    ],
    "Surveyor": [
      "Quantity",
      "Land surveyor",
      "Valuation",
    ],
    "Quality Testing": [
      "Soil Testing",
      "Water Testing",
      "NDT",
    ],
  };
  static Map<String, String> labelImagePaths = {
    "Architect": "assets/labels/architect.jpg",
    "Structural": "assets/labels/structural.jpg",
    "Transporters": "assets/labels/transporters.jpg",
    "Machineries": "assets/labels/machineries.jpg",
    "Contractor": "assets/labels/contractor.jpg",
    "Surveyor": "assets/labels/surveyor.jpg",
    "Quality Testing": "assets/labels/quality_testing.jpg",
    "Project Manager": "assets/labels/project_manager.jpg",
  };
}
