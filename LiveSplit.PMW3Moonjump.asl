state("PMA_W32_M")
{
    byte levelNumber : "PMA_W32_M.exe", 0x3CDF50, 0x18F0;
    byte bossHealth : "PMA_W32_M.exe", 0x3CDED0, 0x41C;
    byte easyStartState : "PMA_W32_M.exe", 0x45D4DC, 0x32C, 0x50F;
    byte normalStartState : "PMA_W32_M.exe", 0x45D4DC, 0x1D8, 0x6C4, 0x4F0, 0x4DF;
    byte backToMain : "PMA_W32_M.exe", 0x47D67C, 0x554, 0x2CC;
    byte backToTitle : "PMA_W32_M.exe", 0x47D67C, 0x6B0, 0x64C;
    byte notLoading : "PMA_W32_M.exe", 0x3CDF4C, 0x14;

    float height : "PMA_W32_M.exe", 0x3CDC84, 0x22C, 0x5D0, 0x68, 0x7C, 0x8;
    int heightPtr : "PMA_W32_M.exe", 0x3CDC84, 0x22C, 0x5D0, 0x68, 0x7C;
    byte button : "PMA_W32_M.exe", 0x43E070, 0x178, 0x74C;
}

update
{
    if (current.button == 248)
    {
        IntPtr height = (IntPtr)current.heightPtr + 0x8;
        memory.WriteBytes(height, BitConverter.GetBytes((float)current.height + 80));
    }
}

start
{
    return current.levelNumber == 44 
    && current.backToMain == 0 && current.backToTitle == 0 
    && ((old.easyStartState == 0 && current.easyStartState == 1)
    || (old.normalStartState == 0 && current.normalStartState == 1));
}

reset
{
    return current.levelNumber == 44 && old.levelNumber < 18;
}

split
{
    return (current.levelNumber > old.levelNumber && old.levelNumber != 4)
        || (current.levelNumber == 17 && current.bossHealth == 0 && old.bossHealth > 0 && old.bossHealth < 7) 
        && timer.CurrentTime.RealTime - (timer.CurrentSplitIndex > 0 ? (timer.Run[timer.CurrentSplitIndex - 1].SplitTime.RealTime ?? TimeSpan.Zero) : TimeSpan.Zero) > TimeSpan.FromSeconds(0.25);
}

isLoading
{
    return current.notLoading == 0;
}