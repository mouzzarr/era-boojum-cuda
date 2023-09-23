// clang-format off
#pragma once

#include "goldilocks.cuh"

namespace poseidon_common {

using namespace goldilocks;

constexpr unsigned RATE = %RATE%;
constexpr unsigned CAPACITY = %CAPACITY%;
constexpr unsigned STATE_WIDTH = RATE + CAPACITY;
constexpr unsigned HALF_NUM_FULL_ROUNDS = %HALF_NUM_FULL_ROUNDS%;
constexpr unsigned NUM_FULL_ROUNDS_TOTAL = 2 * HALF_NUM_FULL_ROUNDS;
constexpr unsigned NUM_PARTIAL_ROUNDS = %NUM_PARTIAL_ROUNDS%;
constexpr unsigned TOTAL_NUM_ROUNDS = NUM_FULL_ROUNDS_TOTAL + NUM_PARTIAL_ROUNDS;

__constant__ constexpr base_field ALL_ROUND_CONSTANTS[TOTAL_NUM_ROUNDS][STATE_WIDTH] = {%ALL_ROUND_CONSTANTS%};

} // namespace poseidon_common

namespace poseidon {

using namespace poseidon_common;

//__constant__ constexpr unsigned MDS_MATRIX_EXPS[STATE_WIDTH] = {%MDS_MATRIX_EXPS%};
//
//__constant__ constexpr unsigned MDS_MATRIX_EXPS_ORDER[STATE_WIDTH] = {%MDS_MATRIX_EXPS_ORDER%};
//
//__constant__ constexpr unsigned MDS_MATRIX_SHIFTS[STATE_WIDTH] = {%MDS_MATRIX_SHIFTS%};

__constant__ constexpr unsigned MDS_MATRIX_EXPS[STATE_WIDTH] = {0,0,1,0,3,5,1,8,12,3,16,10,};

__constant__ constexpr unsigned MDS_MATRIX_EXPS_ORDER[STATE_WIDTH] = {10,8,11,7,5,9,4,6,2,3,1,0,};

__constant__ constexpr unsigned MDS_MATRIX_SHIFTS[STATE_WIDTH] = {4,2,2,3,2,0,2,0,1,0,0,0,};

#ifdef POSEIDON_OPTIMIZED

//__constant__ constexpr base_field ROUND_CONSTANTS_FUSED_LAST_FULL_AND_FIRST_PARTIAL[STATE_WIDTH] = {%ROUND_CONSTANTS_FUSED_LAST_FULL_AND_FIRST_PARTIAL%};
//
//__constant__ constexpr base_field FUSED_DENSE_MATRIX_LAST_FULL_AND_FIRST_PARTIAL[STATE_WIDTH][STATE_WIDTH] = {%FUSED_DENSE_MATRIX_LAST_FULL_AND_FIRST_PARTIAL%};
//
//__constant__ constexpr base_field ROUND_CONSTANTS_FOR_FUSED_S_BOXES[NUM_PARTIAL_ROUNDS] = {%ROUND_CONSTANTS_FOR_FUSED_S_BOXES%};
//
//__constant__ constexpr base_field VS_FOR_PARTIAL_ROUNDS[NUM_PARTIAL_ROUNDS][STATE_WIDTH - 1] = {%VS_FOR_PARTIAL_ROUNDS%};
//
//__constant__ constexpr base_field W_HATS_FOR_PARTIAL_ROUNDS[NUM_PARTIAL_ROUNDS][STATE_WIDTH - 1] = {%W_HATS_FOR_PARTIAL_ROUNDS%};

__constant__ constexpr base_field ROUND_CONSTANTS_FUSED_LAST_FULL_AND_FIRST_PARTIAL[STATE_WIDTH] = {{0x6b59c25c,0x84e4af5a},{0x13562787,0xb27cbd80},{0xfbd3951d,0x7ba22b97},{0xe39c1a86,0x00639bc7},{0x95278250,0x60f14526},{0xfe75b0bd,0x046d5768},{0xa956b99d,0x6b2e91dc},{0x97e7f0ad,0xbc07cccf},{0x22ec57b5,0x787b8852},{0x03e05666,0x795f1537},{0xcb0dd061,0x470dd42f},{0x301c6061,0x0250ab6a},};

__constant__ constexpr base_field FUSED_DENSE_MATRIX_LAST_FULL_AND_FIRST_PARTIAL[STATE_WIDTH][STATE_WIDTH] = {
  {{0x00000001,0x00000000},{0x00000001,0x00000000},{0x00000002,0x00000000},{0x00000001,0x00000000},{0x00000008,0x00000000},{0x00000020,0x00000000},{0x00000002,0x00000000},{0x00000100,0x00000000},{0x00001000,0x00000000},{0x00000008,0x00000000},{0x00010000,0x00000000},{0x00000400,0x00000000},},
  {{0x09a6d3cf,0x1bd92497},{0xb3f7d59f,0x5d2f0bbd},{0x82a4c673,0x8987a17b},{0x54e981da,0xb06c64ea},{0x0dea998e,0xe5e0c738},{0xf3ff2a7d,0x6dd065fc},{0x61a3a1e3,0xaed01f17},{0x62c76aea,0x9fd0589b},{0x9aecad3e,0x98c86f26},{0xe370b012,0xd5a1b486},{0x0dbd7afb,0x39c5526e},{0x4556d5c9,0xe22970d2},},
  {{0xd9936f0a,0x7cc3fbf3},{0xdda9224c,0x6fe014a8},{0x16760de3,0x4e20757a},{0xc647c1bf,0xf797a923},{0x1c5c8df8,0x6c64d4e7},{0xf685b388,0x30abb56a},{0x440b6a06,0x8fc29e22},{0x22365fb1,0xcadcef95},{0xe3c562ef,0x80364aa2},{0xaad90648,0x91e095e8},{0xed9ee94c,0x5f6c398d},{0x0dbd7afb,0x39c5526e},},
  {{0x109257da,0xdb606d34},{0x8b1c80ba,0xe4985afc},{0x25ef5c91,0x2fcb53fb},{0x7de32430,0xd8f93107},{0x5143ab11,0xa90faad0},{0xb021bc7e,0x7e48fd16},{0xa6bfcd3b,0x2ed2c4be},{0xaee9f88d,0x95dd45e6},{0xbd406669,0xb25a0610},{0x3ca55fd2,0xe582cd6e},{0xaad90648,0x91e095e8},{0xe370b012,0xd5a1b486},},
  {{0xc2c3dec2,0x49ba17d3},{0x09f42b98,0xa031b0ec},{0x8e88b96d,0x4de77cf8},{0xbd35dab7,0x5735f467},{0xfb39973c,0xc1e1b75e},{0x931f6b9a,0x5af7fb36},{0xb66d4e2b,0xda0a7125},{0x1d3a9ac8,0x0fd17f14},{0x190051f5,0x189fe463},{0xbd406669,0xb25a0610},{0xe3c562ef,0x80364aa2},{0x9aecad3e,0x98c86f26},},
  {{0xbf3de311,0x604fa87e},{0x06d746ce,0xa862d07f},{0x0c91aa69,0x513f7209},{0xfcfd4069,0x375c131a},{0x201cb64e,0x4fe7e4c6},{0x37bd0d8f,0xc4e144af},{0xcca953f6,0x88ea5c8d},{0x776dd0ff,0x6d2f4db1},{0x1d3a9ac8,0x0fd17f14},{0xaee9f88d,0x95dd45e6},{0x22365fb1,0xcadcef95},{0x62c76aea,0x9fd0589b},},
  {{0xf3d29d2c,0x3f0afdee},{0x15275b34,0x1ae83290},{0x847ecfd6,0xa353eca9},{0x437c24a0,0x3587858d},{0xb7e99e90,0xc61cdb10},{0xeaa4c22e,0x49083456},{0x6b019b13,0xa9a893c1},{0xcca953f6,0x88ea5c8d},{0xb66d4e2b,0xda0a7125},{0xa6bfcd3b,0x2ed2c4be},{0x440b6a06,0x8fc29e22},{0x61a3a1e3,0xaed01f17},},
  {{0x449fb60a,0x5081ad5c},{0x345adbdc,0x0f4abea5},{0x42e94c3d,0x21eaf277},{0x0106ae23,0xcc395a28},{0x5a3eab25,0x3f7f9093},{0xb2821c13,0x85467283},{0xeaa4c22e,0x49083456},{0x37bd0d8f,0xc4e144af},{0x931f6b9a,0x5af7fb36},{0xb021bc7e,0x7e48fd16},{0xf685b388,0x30abb56a},{0xf3ff2a7d,0x6dd065fc},},
  {{0x597e74b4,0xbe9a47ef},{0xc285b0a6,0x54606a62},{0x70c480cf,0xc649e0ce},{0x4d2fa0ea,0xea31cfd5},{0xc0273f7d,0xa8654e2b},{0x5a3eab25,0x3f7f9093},{0xb7e99e90,0xc61cdb10},{0x201cb64e,0x4fe7e4c6},{0xfb39973c,0xc1e1b75e},{0x5143ab11,0xa90faad0},{0x1c5c8df8,0x6c64d4e7},{0x0dea998e,0xe5e0c738},},
  {{0x654e35f8,0x9632dac7},{0xb1eef091,0x01abfa8c},{0x536a48bf,0x71c0976a},{0xb5144f39,0xd34a74dc},{0x4d2fa0ea,0xea31cfd5},{0x0106ae23,0xcc395a28},{0x437c24a0,0x3587858d},{0xfcfd4069,0x375c131a},{0xbd35dab7,0x5735f467},{0x7de32430,0xd8f93107},{0xc647c1bf,0xf797a923},{0x54e981da,0xb06c64ea},},
  {{0x5035b31d,0x663fe330},{0xd32ba75d,0x799775a4},{0x2e1803a7,0xf5ff3fdc},{0x536a48bf,0x71c0976a},{0x70c480cf,0xc649e0ce},{0x42e94c3d,0x21eaf277},{0x847ecfd6,0xa353eca9},{0x0c91aa69,0x513f7209},{0x8e88b96d,0x4de77cf8},{0x25ef5c91,0x2fcb53fb},{0x16760de3,0x4e20757a},{0x82a4c673,0x8987a17b},},
  {{0x6b5e858f,0xe972ef3f},{0x0307a15f,0xde8b0806},{0xd32ba75d,0x799775a4},{0xb1eef091,0x01abfa8c},{0xc285b0a6,0x54606a62},{0x345adbdc,0x0f4abea5},{0x15275b34,0x1ae83290},{0x06d746ce,0xa862d07f},{0x09f42b98,0xa031b0ec},{0x8b1c80ba,0xe4985afc},{0xdda9224c,0x6fe014a8},{0xb3f7d59f,0x5d2f0bbd},},
};

__constant__ constexpr base_field ROUND_CONSTANTS_FOR_FUSED_S_BOXES[NUM_PARTIAL_ROUNDS] = {{0x86a84545,0x5aac244c},{0x7b8c5f14,0xc6958603},{0x10dca556,0x57c6ce56},{0x77cfe972,0x70b101e6},{0x676339dc,0x259e5211},{0xf8e9070b,0x07c32667},{0x9d8fd700,0x18cc593a},{0xb027909e,0xf2308b63},{0x61b53f49,0xe45e0385},{0x0f985740,0x962427fb},{0xd87512d7,0x96aee573},{0x39e0eb3a,0x81f05055},{0x28fb1dce,0x7def1e8f},{0x5e2accc2,0xc638bfc5},{0x1da0b0e4,0xed1c65b5},{0x0e3d5434,0xc318208a},{0xf23504f3,0xac653516},{0xade4c5fd,0x69750800},{0xb73fc812,0xd32c58ad},{0xe66d8df9,0x63b1e15a},{0x0e6892b9,0x35376ed5},{0x046d48ec,0x9da41449},};

__constant__ constexpr base_field VS_FOR_PARTIAL_ROUNDS[NUM_PARTIAL_ROUNDS][STATE_WIDTH - 1] = {
  {{0x73d3aeca,0x54accab2},{0x3b1f1da9,0x12fecae3},{0x49ea9a27,0x573bb854},{0x9f172aad,0x6b5ddc13},{0x34465d4c,0xd2b6d0ca},{0xbddfc269,0x51cf0aaf},{0x79e7a403,0x6075e646},{0x41900ac9,0x678316c0},{0xb343fc57,0x10019c84},{0x0922f644,0xde5b8128},{0xb2f2f305,0x42490a86},},
  {{0xf7bacc46,0x337c5930},{0xf1afb921,0x334792a4},{0x426e540e,0xc97ea5f1},{0x337bd780,0x5fc74568},{0x391d80ef,0xfd5718cc},{0x337d923c,0xef90b77a},{0x8f153fea,0xb2856199},{0x894345aa,0xed5f65b8},{0x985893a7,0x7e2aacb5},{0xb644fcf0,0xcbde536c},{0xa07fc43b,0x07338300},},
  {{0xfcc8b4c1,0xd4c9ad02},{0xa1caa815,0x2890dac7},{0xc45f5db2,0x7d62bc45},{0xdb5deac2,0x0a902300},{0x307f62a4,0x663f3726},{0xc7d8eb3b,0x050bda7d},{0xf051c5b6,0xd9db68f3},{0xa38210aa,0xc5110194},{0x6533be0e,0x40386213},{0x3d9b227d,0x20039e05},{0x262c5f3c,0xe2c90d16},},
  {{0x3396c755,0x6578da96},{0x6bc1e86f,0xea6b546e},{0xc66c2be3,0x4e562ef0},{0xe0f9d22e,0x35b839da},{0x857b058c,0x4aab3d88},{0x7ac462d3,0x4f7443e0},{0xc385e50f,0x93c2c5bb},{0xea023ce2,0xc0c0c5c8},{0x4b62965d,0x8409c53d},{0x8135dcd1,0x0489f225},{0xc736aec9,0x32958358},},
  {{0x15b0a455,0xe13b50ca},{0x2b5d4547,0x9878071e},{0xb4172b30,0xb8e50d27},{0x8d3ea142,0xbf312f82},{0x3020e6e8,0x5b851057},{0x9d8d6afa,0x7c3091c2},{0x50f194fa,0x7e2d900a},{0x0d0b0409,0xb236d508},{0xc3b99320,0x08f148b6},{0xadbe604c,0x679c6b9c},{0x2ad9b9f2,0x6b0313be},},
  {{0x20459b0e,0x12038ac3},{0xb25cd8e0,0x7abd36c6},{0x930e5a13,0x37cc3583},{0x446a691d,0xafe725c4},{0xdeb38d80,0x99d89cca},{0x5528ec36,0x96c820be},{0xdc84ede6,0x9b63969f},{0x5ad78c48,0x8f8f21cf},{0xbc3c2d8b,0x1a4d3573},{0xe771866e,0x9f5a7bd9},{0xb72497fc,0x5bcef938},},
  {{0xbe6add7a,0x5f969817},{0xae5a4c6d,0x572b04c1},{0xac9a287b,0x8d219b8f},{0x6372f434,0x4566b3c5},{0x08bf4441,0xdd3f46f1},{0xaa3912c4,0xd7e1469b},{0x68e071fc,0xac36377b},{0x201d771a,0xf348c609},{0xe2ebdd96,0x0bb926a5},{0xaee4705a,0x30efa780},{0x3691146a,0xb24ff267},},
  {{0xa1dab6e2,0x5d0324b3},{0xcc9e564b,0xbd1491a0},{0xb528ef99,0xb8699e13},{0x753ee023,0x7743d9a8},{0xcdb5bcbc,0xce577363},{0x4f006774,0xc056688d},{0x10d7fdf2,0x61f9363c},{0x30f6e06d,0x5f730e55},{0x3adf0072,0x25efb9ef},{0xe21a8aa7,0xcf971d58},{0xd0d70680,0xd830d7e8},},
  {{0xac42f39d,0x36e69157},{0xddf62d3e,0x3e7aca69},{0xac42bb30,0xbbbef86c},{0x56c27043,0xa2e793ae},{0xbc40c8a0,0x2a315dc4},{0xf3b3af55,0x84022758},{0x4e7a470d,0x668809e7},{0xfdee1820,0xf2d91eaa},{0x16d03294,0x50f19afd},{0x223bcd4b,0x30c087d3},{0x458cc633,0xf5739d95},},
  {{0x75028317,0x15266b5a},{0xc9f88799,0x8059f198},{0x86c65244,0x437a0703},{0x3942929d,0xc70e0bb7},{0x7ae137ea,0xa8b32cb3},{0x8323a459,0xc2e55627},{0x54091692,0xbc486da7},{0x67d6b541,0x7815a234},{0x930e8be6,0x3e6dba4e},{0x915d56ba,0x6b4277b0},{0xc7922ea0,0x20212bfa},},
  {{0x067b0c8b,0xeeba270c},{0x8941f29a,0xa4d57645},{0x8c8c83be,0xecdf04a2},{0x215d7dda,0xc808f0af},{0xecced0fb,0x424f4bfb},{0xc10e58b3,0xe4cbf6c0},{0xfa09c031,0x66a87beb},{0x43d5f0a4,0x614ffc94},{0xf7b7975a,0x96c96636},{0x6f860cc5,0x58d4222a},{0x5bf50169,0x2d4f51c7},},
  {{0xec55310f,0xab43452a},{0xec2b398c,0x0a719e77},{0xa3f5f74f,0x8f946888},{0x9f7ad4fb,0x7b447e0d},{0xb40ef226,0x7a2887ce},{0xc1c49e50,0x8840b904},{0x0b0eaddc,0xd91ea251},{0xa1a220fb,0x6617fa40},{0xa845cb45,0xb1c41a72},{0x81868092,0x02c27152},{0x46ca37bd,0xaf5b1b6c},},
  {{0xdbcbe631,0xe27649b9},{0x1d5e73b2,0x4afdf11d},{0x99160910,0x05285a0e},{0x7ed8d3ba,0x23bfd619},{0x28792aab,0xb1e62920},{0x14e05cae,0xc997f6cc},{0x55a555bd,0x34793ec2},{0x5a76dd03,0xeb4f2da3},{0xc9910f3a,0x767a5552},{0x7c30a447,0x4c4cc698},{0x20578f8d,0x64da2b69},},
  {{0xcc0720ac,0xe97ce2fe},{0xfcdeae8a,0x99fc5741},{0x8b345692,0x0ac47be5},{0x1f2cccda,0x75a44612},{0x02691c8e,0xf38e40a1},{0x594714ef,0xdbe5d707},{0xab92e450,0x6ab183bd},{0x0dc10451,0x0aed8385},{0xa4373c93,0x66e16941},{0x3e1034a1,0x22af15bb},{0x2ed23ccc,0xab2136f2},},
  {{0x3c4c46c1,0xb0d3214d},{0x4053346c,0x3983bffd},{0x2a6a9e64,0xab1239b7},{0x2406c089,0x669bcbda},{0xe563feda,0xf3118af8},{0xd43a9c95,0x58323dbd},{0x0b51fd8c,0x5438aa91},{0x573f7e4f,0xcbf071f9},{0x40075e51,0x476c8fde},{0xc77d8bed,0xa10f54d3},{0xc7346beb,0xfecafe7e},},
  {{0x16f68fa8,0x79e00c69},{0xc11400d6,0x80e39c20},{0xa7c116b7,0x242e2b46},{0x074fcff6,0xea660990},{0xa4c9272b,0x18e3369d},{0x8be33b80,0xfa6471be},{0x83a4574a,0xede2ed2a},{0x0deaaed6,0x9e595d61},{0xfcacdc58,0xc7d2cf35},{0xa9af2302,0xc65cf113},{0x0cac5fde,0x35a74c3d},},
  {{0x9aeabd4b,0x35d6cf1a},{0xb64954c3,0x4dc004b0},{0x210b4c8f,0xcb67ab54},{0x0621d28e,0xa2359b77},{0x5e315bf6,0x027a0a0a},{0x92a86ef6,0xed6aad04},{0x8969232c,0x127074e2},{0x354d396f,0x3e3d68e6},{0x96edf7c6,0x3cf204ab},{0xb70c18bf,0x513a9050},{0x9a3f5281,0x73b3b739},},
  {{0x5b7cd620,0x0af9319d},{0xcd8a897d,0x0514fbce},{0x46738f8d,0x542dd32e},{0x25e9bd45,0x49248ae4},{0xc36e53ea,0x8bb9ef7a},{0xc414a723,0x97981020},{0xc024e0c8,0xe587f186},{0x8e990ad2,0x14f01dd2},{0xe19ea756,0x4d3fca72},{0x1ee8e7f1,0x01a3824f},{0x575f250e,0xb048d25b},},
  {{0x6c6aa236,0xe78a4cfe},{0xdefd3b04,0x4840deff},{0x28e63e47,0x6e0952d0},{0x1d93304d,0x249d49fb},{0x49f7fbb3,0xd41ce9ed},{0x8ea77466,0xba255e80},{0xc2005436,0x5ce52e6d},{0xcd881a04,0x8b5bf13a},{0x3ac011d1,0xf80f439f},{0x2cc3f916,0x1d3618fb},{0x37e14938,0xf41489c8},},
  {{0x5af15054,0x41e06566},{0x6d1bba64,0x71752ac8},{0xf8ceadeb,0x9bfddd30},{0x6c985767,0x4f59dd5e},{0x8ecaa657,0x8aa3e071},{0xd4199ca2,0x355f734e},{0xaec4d693,0x110f361b},{0xe134b5b1,0x283a46e9},{0x6f5c6514,0x4fda3337},{0x565e7d13,0xcca192f9},{0xb1c24c39,0x2251835d},},
  {{0x5970a849,0xc583f62f},{0x41cd89dd,0xb6cc3257},{0x7f07ac1f,0xf8328846},{0x64b845e7,0xfd826249},{0x00a49fdd,0x11967e4e},{0xe9f72577,0x2fb200fa},{0x3c7d5da7,0xd6fb3191},{0x8dd090cc,0xfad9ae57},{0x741ea5d8,0xcd13b2be},{0xf54b0c27,0xc1c54f9c},{0x1b657cce,0x29520a76},},
  {{0xa2b39f4a,0x0ac0e496},{0x59e27953,0x20571abb},{0x579a1d30,0xe9971143},{0xdba518cb,0x980359c3},{0x85b427c4,0x05ecee5a},{0xad0b5366,0x4620dd90},{0x5b859365,0x95c98f9c},{0xfbc56995,0x0fbb1806},{0x802afae2,0xfe4526fd},{0x31084092,0x70e37864},{0x94939111,0xa8d78a04},},
};

__constant__ constexpr base_field W_HATS_FOR_PARTIAL_ROUNDS[NUM_PARTIAL_ROUNDS][STATE_WIDTH - 1] = {
  {{0xc32e6569,0x9a5dd25d},{0x0e7510fa,0xd4b82de0},{0xb344404a,0x165bdcd7},{0x6b8edfd4,0xa85b4c12},{0x92ab4f96,0xcd2735bf},{0x7da8ac41,0xdc07742c},{0xfc5ae49f,0x953fc266},{0xbfc847bf,0x0a151c20},{0xf5afedb5,0x0c550cae},{0x888c5fa8,0x74d28901},{0x30cc1741,0xdc51b68c},},
  {{0x4246c828,0x4f765e0a},{0xdd477a84,0xbbdc8cba},{0x7de2344c,0x052a5abd},{0x4d9c7fab,0xab88daa0},{0xbee798ef,0xbc8fd7ac},{0x0d8a7a09,0xe55d796c},{0xed2c556c,0x40824732},{0x6eabeaa4,0x298a94d5},{0x11312b6c,0x719fcd5e},{0x131d1ac7,0x1ec9a560},{0x497f7fd1,0xabc54a42},},
  {{0xeeeeb0d6,0xb51f81e6},{0x7161d1ef,0xc6f3c34e},{0x255eed5b,0x1e93b9e2},{0x3ec48cc2,0xa78338e6},{0xc7220a56,0xea6e89d1},{0xc2814bc5,0xaa52f6a1},{0x5e09fba0,0x5896b639},{0x8d5f1eee,0xf7fc97a1},{0x111823e8,0xf2712e64},{0xf1f857f4,0x4f84821b},{0xd72da206,0x02041415},},
  {{0x4a391e77,0x39286a4a},{0xebc97214,0x4ac16c7b},{0xb895a01f,0x7427cbbc},{0x0b14759b,0x2ef8491d},{0xe20fa616,0xbec7625e},{0xaf749b6f,0x7c64393f},{0xc9826dc5,0x0f61c751},{0xe8ccb8a7,0x700e6f3e},{0x47ef8667,0x5bdea3b4},{0xa6e97588,0xa0f569a5},{0x5d7cae2d,0xcc9e7811},},
  {{0xb678e5ee,0x0933079a},{0x33c54a28,0xed6861bf},{0x1749a497,0x62503e6e},{0xdea83ac6,0x745a9c65},{0x6e700cf0,0x20ce351f},{0x30fafb8a,0x2ec0b18d},{0x22b5f299,0x0312f54c},{0x18fd6cd5,0x52229772},{0x45868eec,0x82662e84},{0x5040265d,0xc4cab633},{0x9efb9217,0x12e5790e},},
  {{0x63871f55,0x0d829aec},{0x5086dd8c,0x384d8a42},{0x657bfd3e,0x13e78b54},{0x03093566,0x2a45a17a},{0x6233b9be,0x7b687265},{0xb12bbb4c,0xddc0281b},{0x0652d7c8,0xa224ebff},{0x7780ea5c,0xc5ca9720},{0x4d3586ba,0x48423619},{0x4a44f3f7,0x432a56d4},{0x862fc532,0xc41f926f},},
  {{0xd9ef5e06,0x9366cd7e},{0x8175f223,0xd7f94109},{0xe1c9f2b1,0x9af7dda3},{0xa03525f5,0x9a0ec6d0},{0xfb0fb387,0x3ab244f4},{0xeb1d5778,0xd8c4e357},{0xe25edbbb,0xe62157e2},{0xf841f1f8,0xafcd6630},{0x738708fb,0xc3969199},{0x1e6a551f,0xa8224d31},{0xc655fd9f,0xc2c0a01f},},
  {{0x013cd9b6,0xd78498f2},{0x00b2908c,0x675d21a2},{0x9e88c707,0x70bfd23b},{0xcfd078e3,0x85472dcb},{0xcfffd574,0x5658c961},{0xda3ca315,0x89e05a2c},{0xf8186a9f,0x1b51ae1f},{0x6c7822cb,0xca648f8c},{0x47957f4d,0x7233c926},{0x62d37ffa,0x520bf21c},{0x407a2ca7,0x897496c7},},
  {{0xca4eee19,0x8e80cf5b},{0x6bc1afcf,0x75477912},{0x4b379cb0,0x07e88776},{0x12f91d5e,0x7dc7c14e},{0xfb6b0264,0xc8f5dab5},{0x021f9176,0x1c842cf8},{0x2e2db2c0,0x69b56a7e},{0x7fef3445,0xf30253f7},{0x919efb99,0x14bb3a62},{0x24a5d89c,0xff9976d4},{0x0331a202,0x59dde7be},},
  {{0x126330a2,0xdbe04b62},{0x8da1eaec,0x0409b213},{0xb2262691,0x7bd4558e},{0x8d52b05b,0xafa86cfa},{0x97d8c584,0xb83f5701},{0x13990ac1,0xb3ded6cc},{0xb072c9e1,0xfd33937c},{0x41d92952,0xe3b39893},{0xca949ad9,0xd26e76d6},{0x48f88e86,0x35c89a85},{0x940c3b43,0x8af785bd},},
  {{0x01c790da,0xcbf3b867},{0xe29f4005,0x63634f67},{0x82363b81,0x008f9039},{0xd6eb0229,0xc2b07f99},{0xd15e2558,0xa8344b83},{0xd103b7b0,0x880f4e5f},{0xa5929072,0xd40eddb0},{0xee571f49,0x476e27cc},{0xb989f9eb,0xe71439b4},{0xf852b2fe,0x97e55074},{0x37e1a2c5,0xdd258c21},},
  {{0x6d23259b,0x982b9036},{0xaa76b306,0xb2667eac},{0x2020ede1,0xecf233e8},{0x7d4a88c7,0x3cee7ac0},{0xfe5a5854,0x31428be2},{0x55c4c4db,0xf1beea1d},{0x80f1ffd2,0x584fd6b5},{0xc8ba0d0b,0x6e2381c3},{0xbafc0611,0x21ab749c},{0x9aba3001,0x8ed389f3},{0xf2b42f13,0xa24ba694},},
  {{0xb02606f9,0xdb30cd9d},{0x682ba257,0x1b0d6736},{0xf5808443,0x0d3bcdec},{0x1dbd3dbd,0x31c33000},{0x70447946,0x9684d223},{0x426c6935,0xde0e24e6},{0xd081ef69,0xf487270d},{0x48f2b252,0xd943f4ef},{0xd1c52d24,0x4c52a7fd},{0x29ea139d,0xc2930820},{0x3da0468a,0xc2ba73ab},},
  {{0xcc74e0d1,0xd093bd0d},{0xce6a98e5,0xe91428f9},{0x6909dc21,0x673dee71},{0x548219d7,0xf22e3223},{0x881a1300,0x3297978d},{0x8218d77c,0x51157b1e},{0x07843889,0x0e3b0a5c},{0xa36752b6,0x273b48df},{0x23576866,0x5dbf2c63},{0x763df9a7,0x1c032b70},{0x159ecbf4,0x1a8d7ed4},},
  {{0xa6c4f3ad,0x8e40b29f},{0xa91daa9b,0x43bc06db},{0x0dd6d846,0x445df162},{0x68c45c46,0xae1e72ed},{0x93ade46d,0x496ee4e5},{0xdce9118f,0x1d3642ed},{0xbd8fd755,0x71a88114},{0x2514943d,0x4a10d6b2},{0xd4d72fee,0x56dca305},{0x95fa62bf,0xe2e4d9ce},{0x47b50b0a,0xfb6bfffd},},
  {{0x6cc557ee,0x4c6c1494},{0xc7ba3226,0x9b1bcbaa},{0x1fa0dd20,0xdd741036},{0xbaf95b26,0x9c8a098c},{0x93503adf,0x3da4f265},{0xcd3bf859,0xffb07b45},{0xaf54a559,0xaf034373},{0x407146bb,0xd6b9bace},{0x972f4ec6,0x7b92c04c},{0x165b9845,0xfe71df71},{0xdc9ebe51,0xad0134b9},},
  {{0xec88aa7c,0xfdaa64ce},{0xd815525c,0x565342e2},{0x259429a8,0xe382458f},{0xd5d1d1ca,0x0f6ba5af},{0x12439a41,0xcba85de4},{0x049ccb1a,0x212d3c62},{0x950267e3,0x930c0bf5},{0x3fc560d8,0x60f87fe4},{0xd878a33b,0x8f1fbdbc},{0xbf9af16f,0xd28b789a},{0x4fa0eb07,0xd921f043},},
  {{0x635e7c18,0xd69c2c80},{0x772f293f,0x5a3d78c8},{0x2ad1ceb5,0x844fe5e7},{0x910dc916,0x81b217e5},{0xb7c8ba85,0x2951409f},{0x5693e367,0x5c135dd9},{0xf9f7ebd2,0xc2e8a723},{0x5d63f38d,0x10bb79bf},{0x50385a89,0x34625b15},{0x8d791163,0xdc623532},{0xed4d5133,0x1eb12b7a},},
  {{0xa89577d0,0x01426fac},{0x36ac4fd0,0x003ca901},{0xdc45a17f,0x00289223},{0x04320612,0x00099217},{0x3669e451,0x0007efae},{0x06b3349d,0x006499f2},{0x9b5dcfe1,0x1001120d},{0x7db4da94,0x000e3aa4},{0x39d35692,0x0320dc83},{0x6247ecbd,0x4030a0a1},{0x9c160a6b,0x04368a65},},
  {{0x37b408f0,0x00000012},{0xc8f1b79c,0x00000004},{0x46de5309,0x00000004},{0xa3e2d4ac,0x00000032},{0x7600eeb7,0x00000c00},{0x0ee771b0,0x00010004},{0x394d0817,0x00000198},{0x10a981ba,0x00003018},{0x37d86f5a,0x0000030f},{0xb1cc04d4,0x0000030a},{0xe7c0b7e9,0x000000c0},},
  {{0x000234a0,0x00000000},{0x00114630,0x00000000},{0x0800260c,0x00000000},{0x00005288,0x00000001},{0x00900194,0x00000000},{0x200800a3,0x00000000},{0x02011034,0x00000000},{0x0105100e,0x00000000},{0x00604025,0x00000000},{0x00114a03,0x00000000},{0x00061481,0x00000000},},
  {{0x00000400,0x00000000},{0x00010000,0x00000000},{0x00000008,0x00000000},{0x00001000,0x00000000},{0x00000100,0x00000000},{0x00000002,0x00000000},{0x00000020,0x00000000},{0x00000008,0x00000000},{0x00000001,0x00000000},{0x00000002,0x00000000},{0x00000001,0x00000000},},
};

#endif

} // namespace poseidon

namespace poseidon2 {

using namespace poseidon_common;

// Helps define diagonal elements of M_I for poseidon2: M_I[i, i] = 2^LOG_MU_MINUS_ONE[i] + 1
__device__ static constexpr unsigned LOG_MU_MINUS_ONE[STATE_WIDTH] = {4, 14, 11, 8, 0, 5, 2, 9, 13, 6, 3, 12};

// Poseidon2 math often breaks down into actions on tiles of 4 adjacent state elements.
constexpr unsigned TILE = 4;
constexpr unsigned TILES_PER_STATE = STATE_WIDTH / TILE;

} // namespace poseidon2

// clang-format on