From: smj@fastmail.com (Sam McLeod)
Date: Thu, 14 Apr 2016 15:13:22 +1000
Subject: I/O 0 QID 0 timeout,
 disable controller - kernel 4.4 / 4.5 NVMe controller dropouts
Message-ID: <1DC99E13-F6CB-4B7F-AFD7-187825DEE523@fastmail.com>

We have 6 Supermicro servers all of the same (or very similar spec),

Since Kernel 4.4 / 4.5 we've had NVMe devices randomly dropping.
It does not relate to a particular server, disk, controller etc... and downgrading to kernel 4.1.

With kernel 4.4 the servers would load and the disk randomly disappear.
With 4.5 the server loads with one of the disks missing every time.


```
[   66.856719] nvme 0000:03:00.0: I/O 0 QID 0 timeout, disable controller
[   66.957911] nvme 0000:03:00.0: Identify Controller failed (-4)
[   66.957961] nvme 0000:03:00.0: Removing after probe failure status: -5
```

We have tried:

- Swapping the disk
- Swapping the NVMe cables
- Swapping the NVMe controller (motherboard)
- Swapping the backplane
- Downgrading from Kernel 4.5.0 to 4.4.2 given recent changes to the storage subsystem
- Upgrading disk and motherboard firmwares
- Swapping the motherboard

So it's essentially a whole new server except that we haven't done a reinstall - why? Because I want to understand the problem and if reinstalling fixes it we'll never know why it's happening on this machine and not on our other 5.

- No SMART or nvme-cli errors are reported on the drive when it is functioning.
- If the drive is swapped into another bay it works fine and whatever drive is replaced into that bay then eventually times out / fails.


- CentOS 7 (Latest patches installed)
- Kernel 4.5.0
- 2x Intel DC3600 NVMe (2.5" FF)
- Intel Corporation C610/X99 series chipset
- Full `lspci -tvv` output: https://gist.github.com/sammcj/8839c536b2cf6d4def8d2572eb1b4e8a
- Full kernel config: https://gist.github.com/sammcj/7d1e79775bf984424b92679d16c015c6
