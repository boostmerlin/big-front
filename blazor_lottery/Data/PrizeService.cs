namespace blazor_lottery.Data;
using Blazored.LocalStorage;
using System.Collections.Generic;

public class Prize
{
    public string? name { get; set; }
    public int? count { get; set; }

    public void Deconstruct(out string name, out int? count) 
    {
        name = this.name!;
        count = this.count;
    }

    public override string ToString()
    {
        return $"{name}-{count}";
    }
}

public class PrizeService
{
    private const string STORAGE = "prizes";
    private readonly static Prize[] _defaultPrizes = new Prize[] {
        new Prize { name = "文具一套", count = 10 },
        new Prize { name = "书籍一本", count = 9 },
        new Prize { name = "玩游戏一小时", count = 8 },
        new Prize { name = "刷抖音一小时", count = 7 },
        new Prize { name = "写代码一小时", count = 6 },
    };

    private Prize[] prizes = _defaultPrizes;

    public async Task<Prize[]> loadPrizes(ILocalStorageService localStorage)
    {
        Prize[] savedPrizes = await localStorage.GetItemAsync<Prize[]>(STORAGE);
        if (savedPrizes != null)
        {
            prizes = savedPrizes;
        }
        return prizes;
    }

    public async Task<Prize[]> savePrizes(ILocalStorageService localStorage)
    {
        await localStorage.SetItemAsync<Prize[]>(STORAGE, prizes);
        return prizes;
    }

    public async Task<Prize[]> takePrize(ILocalStorageService localStorage, Prize prize)
    {
        Prize p = prizes!.First(p => p.name == prize.name);
        if (p?.count > 0)
        {
            p.count--;
            await savePrizes(localStorage);
        }
        return prizes!;
    }

    public async Task<Prize[]> addPrize(ILocalStorageService localStorageService)
    {
        prizes = prizes.Append<Prize>(new Prize { name = "", count = 0 }).ToArray();
        return await savePrizes(localStorageService);
    }

    public async Task<Prize[]> updatePrize(ILocalStorageService localStorageService, int index, Prize changes)
    {
        if (index < 0 || index >= prizes.Length)
        {
            return prizes;
        }

        prizes[index] = new Prize
        {
            name = changes.name ?? prizes[index].name,
            count = changes.count ?? prizes[index].count
        };
        return await savePrizes(localStorageService);
    }

    public async Task<Prize[]> removePrize(ILocalStorageService localStorageService, int index)
    {
        if (index < 0 || index >= prizes.Length)
        {
            return prizes;
        }
        var list = new List<Prize>(prizes);
        list.RemoveAt(index);
        prizes = list.ToArray();
        return await savePrizes(localStorageService);
    }

    public bool hasAnyPrize()
    {
        if (prizes.Length == 0)
        {
            return false;
        }
        return prizes.Any(p => p?.count > 0);
    }

    public int totalPrizes()
    {
        if (prizes.Length == 0)
        {
            return 0;
        }
        return (int)prizes.Sum(p => p.count ?? 0);
    }
}
