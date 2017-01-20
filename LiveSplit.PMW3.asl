state("PMA_W32_M")
{
    byte levelNumber : "PMA_W32_M.exe", 0x3CDF50, 0x18f0;
    byte bossHealth : "PMA_W32_M.exe", 0x3CDED0, 0x41c;
    byte startState : "PMA_W32_M.exe", 0x45D4DC, 0x32c, 0x50f;
}

start
{
    return current.levelNumber == 44 && old.startState == 0 && current.startState == 1;
}

reset
{
    return current.levelNumber == 44 && old.levelNumber != 44;
}

split
{
    return current.levelNumber > old.levelNumber || (current.levelNumber == 17 && current.bossHealth == 0 && old.bossHealth > 0);
}