state("PMA_W32_M")
{
    int livesPtr : "PMA_W32_M.exe", 0x3CDF4C;
    int lives : "PMA_W32_M.exe", 0x3CDF4C, 0x10C;
}

update
{
    if (current.lives <= 6) {
        memory.WriteBytes((IntPtr)current.livesPtr + 0x10C, BitConverter.GetBytes(6));
    }
}