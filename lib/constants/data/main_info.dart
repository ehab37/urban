import 'package:urban/constants/data/electricity_info.dart';
import 'package:urban/constants/data/paints_info.dart';
import 'package:urban/constants/equipment.dart';

import 'cementAndSand.dart';
import 'ceramic.dart';
import 'chemicals.dart';
import 'kitchen.dart';
import 'plumbing_info.dart';
import 'steel.dart';

const String paints = 'paints';
const String plumbing = 'plumbing';
const String electricity = 'electricity';
const String kitchen = 'kitchen';
const String ceramic = 'ceramic';

const String cementAndSand = 'cement and sand';
const String steel = 'Steel';
const String chemicals = 'Chemicals';

const String finishes = 'finishes';
const String constructions = 'constructions';

const String materials = 'materials';

const List<String> finishesList = [
  paints,
  plumbing,
  electricity,
  kitchen,
  ceramic
];
const List<String> constructionList = [
  paints,
  plumbing,
  electricity,
  cementAndSand,
  steel,
  chemicals
];

const List<String> materialList = [finishes, constructions];

const Map<String, List<String>> materialCategories = {
  finishes: finishesList,
  constructions: constructionList
};

const Map<String, List<Map<String, String>>> suppliers = {
  //paints companies
  glc: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '3'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '4'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '5'},
  ],
  jotun: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  scib: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  sipes: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  orient: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  national: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  delta: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  kapci: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  //================================================================================================================
  //plumbing companies
  damixa: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  eltyeb: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  laufen: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '3'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '4'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '5'},
  ],
  ravak: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  //=========================================================================================================================================

//electricity companies

  alahram: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  elsewedy: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  tolba: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  //=========================================================================================================================================
  //kitchen companies

  ikea: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  ixina: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  golden: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  wren: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],

  //=========================================================================================================================================
  //ceramic companies
  lecico: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  mazloum: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '3'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '4'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '5'},
  ],
  coleopatra: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  royal: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],

//=======================================================================================

  //chemicals companies
  basf: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  cmp: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  sika: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],

  //=======================================================================================

  //cement companies
  cemex: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  elarabia: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  elsewedyForCement: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  swiz: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  titan: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '3'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '4'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '5'},
  ],

  //=======================================================================================

  //steel companies
  ezz: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  elmasryeen: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  elgarhy: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  elmarakby: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
  //=======================================================================================

  //
  //equipments
  elRowad: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],

  elArab: [
    {supplierName: 'sup1', supplierPhone: '015245244', supplierCityId: '1'},
    {supplierName: 'sup2', supplierPhone: '450450450', supplierCityId: '2'},
    {supplierName: 'sup3', supplierPhone: '450450400', supplierCityId: '20'},
    {supplierName: 'sup4', supplierPhone: '450045040', supplierCityId: '50'},
    {supplierName: 'sup5', supplierPhone: '450450400', supplierCityId: '70'},
  ],
};

const String logo = 'logo';

const String supplierName = 'name';
const String supplierPhone = 'phone';
const String supplierCityId = 'cityId';
const String url = 'url';
const String supplier = 'supplier';

const String callCenterCart = 'callCenterCart';
