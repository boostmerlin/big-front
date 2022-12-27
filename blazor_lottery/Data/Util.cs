namespace blazor_lottery.Data;

public static class Util
{
    public static float ANI_TIME = 0.30f;
    const int numberOfCandidates = 6;
    const int numberOfCandidatesInAChunk = numberOfCandidates / 2;

    private static T[] take<T>(T[] array, int n)
    {
        int len = array.Length;
        if (len == 0)
        {
            return array;
        }

        if (len > n)
        {
            return array.SkipLast(len - n).ToArray<T>();
        }
        //fill with duplicated element to reach n
        var a = new List<T>(array);
        for (int i = len; i < n; i++)
        {
            int dup = Random.Shared.Next(len);
            a.Add(array[dup]);
            Console.WriteLine(a.Count + " " + dup + " " + array[dup]);
        }
        return a.ToArray();
    }

    private static T[] flattern<T>(T[][] cross)
    {
        return (
          from c in cross
          from cc in c
          select cc
        ).ToArray();
    }

    private static T[] shuffle<T>(T[] array)
    {
        return array.OrderBy(e => e!.GetHashCode() * Random.Shared.Next()).ToArray();
    }

    private static T[][] chunk<T>(T[] array, int size)
    {
        int r = array.Length / size + 1;
        T[][] ret = new T[r][];

        int j = 0;
        for (int i = 0; i < r; i++)
        {
            int left = array.Length - j;
            int n = Math.Min(left, size);
            T[] c = new T[n];
            for (int k = 0; k < n; k++)
            {
                c[k] = array[j++];
            }
            ret[i] = c;
        }
        return ret;
    }

    public static Prize[][] generateCandidates(Prize[] prizes)
    {
        return chunk(
          take(
            shuffle(
              flattern(
                prizes.Select((p, i) =>
                {
                    var a = new Prize[p.count ?? 0];
                    Array.Fill(a, new Prize { name = p.name, count = 1 });
                    return a;
                }).ToArray()
              )
            ),
            numberOfCandidates
          ), numberOfCandidatesInAChunk
        );
    }
}