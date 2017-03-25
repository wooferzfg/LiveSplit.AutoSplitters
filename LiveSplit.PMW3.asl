state("PMA_W32_M")
{
    byte levelNumber : "PMA_W32_M.exe", 0x3CDF50, 0x18F0;
    byte bossHealth : "PMA_W32_M.exe", 0x3CDED0, 0x41C;
    byte easyStartState : "PMA_W32_M.exe", 0x45D4DC, 0x32C, 0x50F;
    byte normalStartState : "PMA_W32_M.exe", 0x45D4DC, 0x1D8, 0x6C4, 0x4F0, 0x4DF;
    byte backToMain : "PMA_W32_M.exe", 0x47D67C, 0x554, 0x2CC;
    byte backToTitle : "PMA_W32_M.exe", 0x47D67C, 0x6B0, 0x64C;
    byte notLoading : "PMA_W32_M.exe", 0x3CDF4C, 0x14;
	
	byte pacStatues : "PMA_W32_M.exe", 0x003CDC84, 0x2B0;
	byte galaxians : "PMA_W32_M.exe", 0x003CDC84, 0x274;
	byte watermelons : "PMA_W32_M.exe", 0x003CDC84, 0x448;
	byte apples : "PMA_W32_M.exe", 0x003CDC84, 0x444;
	byte oranges : "PMA_W32_M.exe", 0x003CDC84, 0x440;
	byte strawberries : "PMA_W32_M.exe", 0x003CDC84, 0x43C;
	byte cherries : "PMA_W32_M.exe", 0x003CDC84, 0x438;
}

startup
{
	settings.Add("hundo", false, "Split For All Fruit, Statues, and Galaxians");
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
	var currentFruit = current.pacStatues + current.galaxians + current.watermelons + current.apples + current.oranges + current.strawberries + current.cherries;
	var oldFruit = old.pacStatues + old.galaxians + old.watermelons + old.apples + old.oranges + old.strawberries + old.cherries;
    return (settings["hundo"] && currentFruit > oldFruit)
		|| (current.levelNumber > old.levelNumber && old.levelNumber != 4)
        || (current.levelNumber == 17 && current.bossHealth == 0 && old.bossHealth > 0 && old.bossHealth < 5) 
	&& timer.CurrentTime.RealTime - (timer.CurrentSplitIndex > 0 ? timer.Run[timer.CurrentSplitIndex - 1].SplitTime.RealTime : TimeSpan.Zero) > TimeSpan.FromSeconds(0.25);
}

isLoading
{
    return current.notLoading == 0;
}