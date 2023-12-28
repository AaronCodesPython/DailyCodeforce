int pseudoRandom(int seed, int n) {
  const int a = 1664525;
  const int c = 1013904223;
  const int m = 4294967296; // 2^32

  seed = (a * seed + c) % m;
  return seed % n;
}
