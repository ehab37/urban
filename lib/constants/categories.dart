import 'data/cementAndSand.dart';
import 'data/ceramic.dart';
import 'data/chemicals.dart';
import 'data/electricity_info.dart';
import 'data/kitchen.dart';
import 'data/main_info.dart';
import 'data/paints_info.dart';
import 'data/plumbing_info.dart';
import 'data/steel.dart';

const String companies = 'companies';
const String kinds = 'kinds';
Map<String, Map<String, Map<String, List<String>>>> categories = {
  finishes: {
    paints: {companies: paintsCompaniesList, kinds: paintsKindsList},
    plumbing: {companies: plumbingCompaniesList, kinds: plumbingsKindsList},
    electricity: {
      companies: electricityCompaniesList,
      kinds: electricityKindsList
    },
    kitchen: {companies: kitchenCompaniesList, kinds: kitchenKindsList},
    ceramic: {companies: ceramicCompaniesList, kinds: ceramicKindsList},
  },
  constructions: {
    paints: {companies: paintsCompaniesList, kinds: paintsKindsList2},
    plumbing: {companies: plumbingCompaniesList, kinds: plumbingsKindsList2},
    electricity: {
      companies: electricityCompaniesList,
      kinds: electricityKindsList2
    },
    chemicals: {companies: chemicalsCompaniesList, kinds: chemicalsKindsList},
    cementAndSand: {
      companies: cementAndSandCompaniesList,
      kinds: cementAndSandKindsList
    },
    steel: {companies: steelCompaniesList, kinds: steelKindsList},
  },
};
