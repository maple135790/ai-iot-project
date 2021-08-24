Map<String, List<Map<String, String>>> indications = {
  "Ultracet": [
    {"name": "Panadol", "indication": "止痛、退燒"},
    {"name": "Asprin", "indication": "止痛、降低發燒"},
    {"name": "Ibuprofen", "indication": "止痛、退燒、經痛"},
    {"name": "Ketoprofen", "indication": "消炎、解熱、鎮痛"},
    {"name": "Naproxen", "indication": "消炎、痛風、鎮痛"},
    {"name": "Piroxicam", "indication": "消炎、痛風、鎮痛"},
  ],
  "Novamin": [
    {"name": "Trihexyphenidyl", "indication": "帕金森氏症"},
    {"name": "Biperiden", "indication": "帕金森氏症"},
    {"name": "Diphenhydreamine", "indication": "皮膚疾病"},
    {"name": "Amantadine", "indication": "帕金森氏症、預防及治療A型流感"},
    {"name": "Lorazepam", "indication": "抗焦慮"},
    {"name": "Clonazepam", "indication": "癲癇"},
    {"name": "Propranolol", "indication": "狹心症、不整律"},
  ],
  "Xanax": [
    {"name": "Erispan", "indication": "焦慮狀態"},
    {"name": "Eurodin", "indication": "失眠"},
    {"name": "Ativan", "indication": "焦慮狀態"},
    {"name": "Valium", "indication": "焦慮狀態、肌肉痙攣、失眠"},
    {"name": "Dormicum", "indication": "知覺鎮靜、手術前給藥"},
    {"name": "Rivotil", "indication": "癲癇"},
  ],
};
Map<String, String> cautions = {
  "Trihexyphenidyl": "避免老人使用",
  "Biperiden": "避免老人使用",
  "Diphenhydreamine": "可能出現呼吸抑制",
  "Amantadine": "可能出現呼吸抑制",
  "Lorazepam": "可能出現呼吸抑制",
  "Clonazepam": "",
  "Propranolol": "有可能出現心跳過慢及掩蓋低血糖症狀",
  "Erispan": "嗜睡、倦怠感",
  "Eurodin": "容易成癮",
  "Ativan": "虛弱及情緒不穩",
  "Valium": "失意",
  "Dormicum": "血栓靜脈炎",
  "Rivotil": "易怒狂怒或攻擊行為"
};

List bzdList = [
  "Xanax",
  "Erispan",
  "Eurodin",
  "Ativan",
  "Valium",
  "Dormicum",
  "Rivotil",
];
