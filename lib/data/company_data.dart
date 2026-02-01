import '../models/company.dart';

// ---------- INDIVIDUAL COMPANY INSTANCES ----------

final brightPulse = Company(
  name: 'BrightPulse Clinics',
  sector: 'Medical',
  description: 'A network of small neighborhood health centers.',
  longDescription: 'BrightPulse runs many small health centers in neighborhoods...',
  risk: RiskLevel.low,
);

final viraCure = Company(
  name: 'ViraCure Biolabs',
  sector: 'Medical Research',
  description: 'Studies viruses to develop medicines and vaccines.',
  longDescription: 'ViraCure researches viruses and tries to make medicines...',
  risk: RiskLevel.high,
);

final quickGrow = Company(
  name: 'QuickGrow Research',
  sector: 'Research',
  description: 'Improves crops so farmers can grow more food with less water.',
  longDescription: 'QuickGrow develops crops that need less water...',
  risk: RiskLevel.medium,
);

final pixelTrail = Company(
  name: 'PixelTrail Studios',
  sector: 'Technology',
  description: 'Designs and develops video games for computers and consoles.',
  longDescription: 'PixelTrail makes video games. Their money comes from sales...',
  risk: RiskLevel.high,
);

final safeLink = Company(
  name: 'SafeLink Cyber',
  sector: 'Technology',
  description: 'Develops software to protect computers and phones.',
  longDescription: 'SafeLink sells protection software to companies...',
  risk: RiskLevel.low,
);

final homeBot = Company(
  name: 'HomeBot Innovations',
  sector: 'Technology',
  description: 'Builds small robots for household chores.',
  longDescription: 'HomeBot builds helper robots. Products are popular...',
  risk: RiskLevel.high,
);

final stoneBridge = Company(
  name: 'StoneBridge Builders',
  sector: 'Construction',
  description: 'Builds houses, schools, and small office buildings.',
  longDescription: 'StoneBridge builds homes and public buildings...',
  risk: RiskLevel.medium,
);

final greenFrame = Company(
  name: 'GreenFrame Construction',
  sector: 'Construction',
  description: 'Focuses on eco-friendly buildings.',
  longDescription: 'GreenFrame builds energy-saving buildings...',
  risk: RiskLevel.medium,
);

final silverStream = Company(
  name: 'SilverStream Resources',
  sector: 'Natural Resources',
  description: 'Extracts useful minerals for electronics.',
  longDescription: 'SilverStream mines minerals used in electronics...',
  risk: RiskLevel.high,
);

final earthCore = Company(
  name: 'EarthCore Aggregates',
  sector: 'Natural Resources',
  description: 'Provides sand, gravel, and stone for construction.',
  longDescription: 'EarthCore sells sand, gravel, and stone...',
  risk: RiskLevel.low,
);

final windWay = Company(
  name: 'WindWay Power',
  sector: 'Energy',
  description: 'Runs wind farms that generate electricity.',
  longDescription: 'WindWay runs wind farms and sells electricity...',
  risk: RiskLevel.low,
);

final coalCore = Company(
  name: 'CoalCore Energy',
  sector: 'Energy',
  description: 'Generates electricity by burning fossil fuels.',
  longDescription: 'CoalCore produces electricity from coal...',
  risk: RiskLevel.high,
);

final aquaPure = Company(
  name: 'AquaPure Filters',
  sector: 'Water Treatment',
  description: 'Makes systems that clean dirty water.',
  longDescription: 'AquaPure makes water cleaning systems...',
  risk: RiskLevel.medium,
);

final cozyNest = Company(
  name: 'CozyNest Furniture',
  sector: 'Manufacturing',
  description: 'Designs and builds simple home furniture.',
  longDescription: 'CozyNest makes home furniture...',
  risk: RiskLevel.low,
);

final trailGuard = Company(
  name: 'TrailGuard Gear',
  sector: 'Outdoor Equipment',
  description: 'Makes backpacks, tents, and camping tools.',
  longDescription: 'TrailGuard sells camping and hiking gear...',
  risk: RiskLevel.medium,
);

final brightSign = Company(
  name: 'BrightSign Printing',
  sector: 'Printing Services',
  description: 'Prints posters, signs, and books.',
  longDescription: 'BrightSign prints signs and books...',
  risk: RiskLevel.medium,
);

final cityCycle = Company(
  name: 'CityCycle Repair',
  sector: 'Bicycle Services',
  description: 'Fixes bikes and sells parts.',
  longDescription: 'CityCycle fixes bikes and sells parts...',
  risk: RiskLevel.low,
);

final petalPatch = Company(
  name: 'PetalPatch Gardens',
  sector: 'Landscaping',
  description: 'Plants and maintains gardens and green spaces.',
  longDescription: 'PetalPatch designs and maintains gardens...',
  risk: RiskLevel.low,
);

final numberNest = Company(
  name: 'NumberNest Accounting',
  sector: 'Finance',
  description: 'Helps people and small businesses manage money.',
  longDescription: 'NumberNest helps people manage taxes...',
  risk: RiskLevel.low,
);

final fusionSpring = Company(
  name: 'FusionSpring Energy',
  sector: 'Energy',
  description: 'Trying to create clean energy using nuclear fusion.',
  longDescription: 'FusionSpring is working on fusion reactors...',
  risk: RiskLevel.high,
);

final neuroWeave = Company(
  name: 'NeuroWeave Interfaces',
  sector: 'Technology',
  description: 'Develops brain-computer interface devices.',
  longDescription: 'NeuroWeave is building BCI implants...',
  risk: RiskLevel.high,
);

final holoLife = Company(
  name: 'HoloLife Systems',
  sector: 'Augmented Reality Platforms',
  description: 'Creates advanced AR glasses.',
  longDescription: 'HoloLife builds lightweight AR glasses...',
  risk: RiskLevel.medium,
);

// ---------- GLOBAL LIST ----------
// I updated this name to 'allCompanies' to match what your HomePage expects!
final List<Company> allCompanies = [
  brightPulse, viraCure, quickGrow, pixelTrail, safeLink,
  homeBot, stoneBridge, greenFrame, silverStream, earthCore,
  windWay, coalCore, aquaPure, cozyNest, trailGuard,
  brightSign, cityCycle, petalPatch, numberNest, fusionSpring,
  neuroWeave, holoLife,
];

// Optional: Keep 'companies' as an alias just in case you used it elsewhere
final List<Company> companies = allCompanies;