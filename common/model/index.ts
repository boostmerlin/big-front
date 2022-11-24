const STORAGE = "prizes";

export interface Prize {
  name: string;
  count: number;
}

interface PrizeAttr {
  name?: string;
  count?: number;
}

const DEFAULT: Prize[] = [
  { name: "文具一套", count: 10 },
  { name: "书籍一本", count: 10 },
  { name: "玩游戏一小时", count: 3 },
  { name: "刷抖音一小时", count: 3 },
  { name: "写代码一小时", count: 3 },
];

let prizes = [...DEFAULT];

export const loadPrizes = () => {
  const store = localStorage.getItem(STORAGE);
  if (!store) {
    return prizes;
  }
  const values = JSON.parse(store);
  if (!Array.isArray(values)) {
    return prizes;
  }
  prizes = values;
  return prizes;
};

const savePrizes = (priz: Prize[]) => {
  localStorage.setItem(STORAGE, JSON.stringify(priz));
};

export const takePrize = (prize: Prize) => {
  const found = prizes.find((p) => p.name === prize.name);
  if (found?.count && found?.count > 0) {
    found.count -= 1;
    savePrizes(prizes);
  }
  return prizes;
};

export const addPrize = () => {
  prizes.push({ name: "", count: 0 });
  savePrizes(prizes);
  return prizes;
};
export const updatePrize = (index: number, changes: PrizeAttr) => {
  if (index < 0 || index >= prizes.length) {
    return prizes;
  }
  prizes[index] = { ...prizes[index], ...changes };
  savePrizes(prizes);
  return prizes;
};

export const removePrize = (index: number) => {
  if (index < 0 || index >= prizes.length) {
    return prizes;
  }

  prizes.splice(index, 1);
  savePrizes(prizes);
  return prizes;
};

export const hasAnyPrizes = () => {
  if (prizes.length === 0) {
    return false;
  }
  return prizes.some((p) => p.count && p.count > 0);
};

export const totalPrizes = () => {
  if (prizes.length === 0) {
    return 0;
  }
  return prizes.reduce((s, v) => {
    s += v.count || 0;
    return s;
  }, 0);
};
