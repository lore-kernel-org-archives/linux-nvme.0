From: newhorizons009@gmail.com (Linux User)
Date: Fri, 19 May 2017 13:47:40 -0400
Subject: NVMe sluggish
In-Reply-To: <CAKKYfmHRYHeLtNfg9tjanHtwf5TseRLr=MO0A7_PJOkRvKxzWg@mail.gmail.com>
References: <CA+12NBLYg47+yJp8u0+Oq=+t0qfwRLUePep9N4uaomnJ6Y6+SQ@mail.gmail.com>
 <CA+12NBJP2jkpSqNfYRd59HLcwSNnrrpBjFFaH2pYBvdu9_=8Zg@mail.gmail.com>
 <CAKKYfmFvoKGcfXEVXor2fnkgQ8C+i1GtdrtzYSUyRRVMMoYx7Q@mail.gmail.com>
 <CA+12NBJrTyFkSoK0WzZMyn7QX6kG3S9tPJYthitoa6eGqMLUMQ@mail.gmail.com>
 <CAKKYfmHRYHeLtNfg9tjanHtwf5TseRLr=MO0A7_PJOkRvKxzWg@mail.gmail.com>
Message-ID: <CA+12NBKPL_W+LVrhbKcAJZAf+WqRTBRrp31dcQrxgM07G3ZtxA@mail.gmail.com>

The name of the mount point is jffs, but it has nothing to do with
jffs2. The partition on the nvme is actually formatted to ext4 and
mounted as ext4 as well (See below). Mounting goes quick, right after
mounting, we chmod all files on that partition to 777. Thats where it
turns into a bear and takes forever, same operation on ahci took 2
seconds.

To give more info,
The files on the paritions, look as below, i've got 10K or so.

I have tried, Toshiba NVMe as well, and does the same thing.

-rw-r--r--    1 root     root        856844 May 19 14:54
2017_05_19_14_53.cff_1spc-d
-rw-r--r--    1 root     root        856844 May 19 14:55
2017_05_19_14_54.cff_1spc-d
-rw-r--r--    1 root     root        856844 May 19 14:56
2017_05_19_14_55.cff_1spc-d
-rw-r--r--    1 root     root        856844 May 19 14:57
2017_05_19_14_56.cff_1spc-d
-rw-r--r--    1 root     root        856844 May 19 14:58
2017_05_19_14_57.cff_1spc-d
-rw-r--r--    1 root     root        856844 May 19 14:59
2017_05_19_14_58.cff_1spc-d
-rw-r--r--    1 root     root        856844 May 19 15:00
2017_05_19_14_59.cff_1spc-d


You can see from the boot log,
/dev/nvme0n1p1: clean, 1907/7634944 files, 578820/30519475 blocks
/dev/nvme0n1p2: clean, 11/61824 files, 4196/246999 blocks
EXT4-fs (nvme0n1p1): mounted filesystem without journal. Opts: data=ordered


On Fri, May 19, 2017@11:15 AM, Dennis Mungai <dmngaie@gmail.com> wrote:
> A small observation: Is there any particular reason as to why you're
> using JFFS2 on an NVMe drive?
>
> With JFFS2, all nodes must still be scanned at mount time. This is
> slow and is becoming an increasingly serious problem as flash devices
> gain larger capacities. Even with the Erase Block Summary (EBS) , the
> overhead of scanning nodes is still pretty high, and its' likely to
> worsen with NVMe drives.
>
> On 19 May 2017@17:17, Linux User <newhorizons009@gmail.com> wrote:
>> Hi Dennis,
>> Below is the output of lspci.
>> My NVMe ssd is Samsung model MZ - VPV1280
>> My system is a Altera Cyclone V based SoC. (Scroll past lspci log for more
>> info)
>> My boot log (Scroll past lscpi and lshw log)
>>
>> Thanks for you help.
>>
>>
>>>>>>>>>>>>>>>>>>>>>> output of lscpi -v >>>>>>>>>>>>>>>>>>>>>>>>
>> 00:00.0 Class 0604: Device 1172:e000 (rev 01)
>>         Flags: bus master, fast devsel, latency 0
>>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>         I/O behind bridge: 00000000-00000fff
>>         Memory behind bridge: c0000000-c00fffff
>>         Prefetchable memory behind bridge: 00000000-000fffff
>>         Capabilities: [50] MSI: Enable- Count=1/4 Maskable- 64bit+
>>         Capabilities: [78] Power Management version 3
>>         Capabilities: [80] Express Root Port (Slot-), MSI 00
>>         Capabilities: [100] Virtual Channel
>>         Capabilities: [200] Vendor Specific Information: ID=a000 Rev=0
>> Len=044 <
>> ?>
>>
>> 01:00.0 Class 0108: Device 144d:a802 (rev 01) (prog-if 02)
>>         Subsystem: Device 144d:a801
>>         Flags: bus master, fast devsel, latency 0, IRQ 72
>>         Memory at c0000000 (64-bit, non-prefetchable) [size=16K]
>>         I/O ports at <unassigned> [disabled]
>>         Capabilities: [40] Power Management version 3
>>         Capabilities: [50] MSI: Enable- Count=1/8 Maskable- 64bit+
>>         Capabilities: [70] Express Endpoint, MSI 00
>>         Capabilities: [b0] MSI-X: Enable- Count=9 Masked-
>>         Capabilities: [100] Advanced Error Reporting
>>         Capabilities: [148] Device Serial Number 00-00-00-00-00-00-00-00
>>         Capabilities: [158] Power Budgeting <?>
>>         Capabilities: [168] #19
>>         Capabilities: [188] Latency Tolerance Reporting
>>         Capabilities: [190] #1e
>>         Kernel driver in use: nvme
>>
>>>>>>>>>>>>>>>>>>>> output of the lshw >>>>>>>>>>>>>>>>>>>>>>>>>>>>
>> ./lshw
>>     description: Computer
>>     product: Altera SOCFPGA Cyclone V
>>     width: 32 bits
>>   *-core
>>        description: Motherboard
>>        physical id: 0
>>        capabilities: altr_socfpga-cyclone5 altr_socfpga
>>      *-cpu:0
>>           description: CPU
>>           product: cpu
>>           physical id: 1
>>           bus info: cpu at 0
>>      *-cpu:1 DISABLED
>>           description: CPU
>>           product: cpu
>>           physical id: 2
>>           bus info: cpu at 1
>>      *-memory
>>           description: System memory
>>           physical id: 3
>>           size: 1007MiB
>>      *-pci
>>           physical id: 0
>>           bus info: pci at 0000:00:00.0
>>           version: 01
>>           width: 32 bits
>>           clock: 33MHz
>>           capabilities: pci msi pm pciexpress bus_master cap_list
>>           resources: memory:c0000000-c00fffff
>>         *-storage
>>              physical id: 0
>>              bus info: pci at 0000:01:00.0
>>              version: 01
>>              width: 64 bits
>>              clock: 33MHz
>>              capabilities: storage pm msi pciexpress msix bus_master
>> cap_list
>>              configuration: driver=nvme latency=0
>>              resources: irq:72 memory:c0000000-c0003fff
>>   *-network:0
>>        description: Ethernet interface
>>        physical id: 1
>>        logical name: eth0
>>        serial: ea:d9:5a:9c:48:fd
>>        size: 1Gbit/s
>>        capacity: 1Gbit/s
>>        capabilities: ethernet physical tp aui bnc mii fibre 10bt 10bt-fd
>> 100bt 100bt-fd 1000bt 1000bt-fd autonegotiation
>>        configuration: autonegotiation=on broadcast=yes driver=st_gmac
>> driverversion=March_2013 duplex=full ip=42.42.42.10 link=yes multicast=yes
>> port=MII speed=1Gbit/s
>>   *-network:1
>>        description: Ethernet interface
>>        physical id: 2
>>        logical name: eth1
>>        serial: 00:11:cf:99:00:b1
>>        size: 100Mbit/s
>>        capacity: 1Gbit/s
>>        capabilities: ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd
>> 1000bt 1000bt-fd autonegotiation
>>        configuration: autonegotiation=off broadcast=yes driver=st_gmac
>> driverversion=March_2013 duplex=full ip=10.14.3.190 link=yes multicast=yes
>> port=MII speed=100Mbit/s
>>   *-network:2
>>        description: Ethernet interface
>>        physical id: 3
>>        logical name: eth2
>>        serial: 00:11:ca:99:00:b1
>>        size: 100Mbit/s
>>        capacity: 1Gbit/s
>>        capabilities: ethernet physical tp aui bnc mii fibre 10bt 10bt-fd
>> 100bt 100bt-fd 1000bt 1000bt-fd autonegotiation
>>        configuration: autonegotiation=on broadcast=yes driver=altera_tse
>> driverversion=v8.0 duplex=full firmware=v4096.0 ip=10.14.3.191 link=yes
>> multicast=yes port=MII speed=100Mbit/s
>>   *-network:3
>>        description: Ethernet interface
>>        physical id: 4
>>        logical name: eth3
>>        serial: 00:11:c0:99:00:b1
>>        size: 100Mbit/s
>>        capacity: 1Gbit/s
>>        capabilities: ethernet physical tp aui bnc mii fibre 10bt 10bt-fd
>> 100bt 100bt-fd 1000bt 1000bt-fd autonegotiation
>>        configuration: autonegotiation=on broadcast=yes driver=altera_tse
>> driverversion=v8.0 duplex=full firmware=v4096.0 ip=10.14.3.192 link=yes
>> multicast=yes port=MII speed=100Mbit/s
>>
>>>>>>>>>>>>>>>>>>>>> Boot Log >>>>>>>>>>>>>>>>>>>>>>>>>>
>> 311 bytes read in 3 ms (100.6 KiB/s)
>> ## Executing script at 02000000
>> Saving Environment to MMC...
>> Writing to MMC(0)... done
>> reading SCM.rbf
>> 3826564 bytes read in 338 ms (10.8 MiB/s)
>> ## Starting application at 0x3FF831BC ...
>> ## Application terminated, rc = 0xA
>> fpgaintf
>> ffd08028: 00000004    ....
>> fpga2sdram
>> ffc25080: 00000111    ....
>> axibridge
>> ffd0501c: 00000000    ....
>> gpio: pin 0 (bank/mask = 0/0x00000001)
>> gpio: pin 0 (gpio 0) value is 1
>> gpio: pin 9 (bank/mask = 0/0x00000200)
>> gpio: pin 9 (gpio 9) value is 0
>> gpio: pin 9 (bank/mask = 0/0x00000200)
>> gpio: pin 9 (gpio 9) value is 1
>> reading zImage
>> 3768152 bytes read in 331 ms (10.9 MiB/s)
>> reading SCM.dtb
>> 22382 bytes read in 6 ms (3.6 MiB/s)
>> ## Flattened Device Tree blob at 00000100
>>    Booting using the fdt blob at 0x00000100
>>    Loading Device Tree to 03ff7000, end 03fff76d ... OK
>>
>> Starting kernel ...
>>
>> Booting Linux on physical CPU 0x0
>> Initializing cgroup subsys cpuset
>> Linux version 3.10.37-ltsi-rt37 (namin at amuscorbld) (gcc version 4.7.3
>> 20121106 (prerelease) (crosstool-NG linaro-1.13.1-4.7-2012.11-20121123 -
>> Linaro GCC 2012.11) ) #1 SMP Fri May 19 10:01:29 EDT 2017
>> CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
>> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
>> Machine: Altera SOCFPGA, model: Altera SOCFPGA Cyclone V
>> Memory policy: ECC disabled, Data cache writealloc
>> PERCPU: Embedded 8 pages/cpu @80fda000 s11392 r8192 d13184 u32768
>> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
>> Kernel command line: console=ttyS0,115200 root=/dev/mmcblk0p5 rw
>> init=/linuxrc rootfstype=squashfs rootwait rw rootwait
>> PID hash table entries: 4096 (order: 2, 16384 bytes)
>> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
>> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
>> Memory: 1024MB = 1024MB total
>> Memory: 1031448k/1031448k available, 17128k reserved, 0K highmem
>> Virtual kernel memory layout:
>>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>>     vmalloc : 0xc0800000 - 0xff000000   (1000 MB)
>>     lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
>>     modules : 0x7f000000 - 0x80000000   (  16 MB)
>>       .text : 0x80008000 - 0x806f12fc   (7077 kB)
>>       .init : 0x806f2000 - 0x8074ac80   ( 356 kB)
>>       .data : 0x8074c000 - 0x8078ba10   ( 255 kB)
>>        .bss : 0x8078ba10 - 0x807cac7c   ( 253 kB)
>> SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
>> Hierarchical RCU implementation.
>> NR_IRQS:16 nr_irqs:16 16
>> sched_clock: 32 bits at 100MHz, resolution 10ns, wraps every 42949ms
>> Console: colour dummy device 80x30
>> Calibrating delay loop... 1594.16 BogoMIPS (lpj=7970816)
>> pid_max: default: 32768 minimum: 301
>> Mount-cache hash table entries: 512
>> CPU: Testing write buffer coherency: ok
>> ftrace: allocating 19376 entries in 57 pages
>> CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
>> Setting up static identity map for 0x80513990 - 0x805139e8
>> CPU1: Booted secondary processor
>> CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
>> Brought up 2 CPUs
>> SMP: Total of 2 processors activated (3188.32 BogoMIPS).
>> CPU: All CPU(s) started in SVC mode.
>> NET: Registered protocol family 16
>> fpga bridge driver
>> DMA: preallocated 256 KiB pool for atomic coherent allocations
>> L310 cache controller enabled
>> l2x0: 8 ways, CACHE_ID 0x410030c9, AUX_CTRL 0x32460000, Cache size: 524288 B
>> syscon ffd08000.sysmgr: regmap [mem 0xffd08000-0xffd0bfff] registered
>> syscon ffd05000.rstmgr: regmap [mem 0xffd05000-0xffd05fff] registered
>> syscon ff800000.l3regs: regmap [mem 0xff800000-0xff800fff] registered
>> syscon ffc25000.sdrctl: regmap [mem 0xffc25000-0xffc25fff] registered
>> hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
>> hw-breakpoint: maximum watchpoint size is 4 bytes.
>> altera_hps2fpga_bridge fpgabridge.3: fpga bridge [hps2fpga] registered as
>> device hps2fpga
>> altera_hps2fpga_bridge fpgabridge.3: init-val not specified
>> altera_hps2fpga_bridge fpgabridge.4: fpga bridge [lshps2fpga] registered as
>> device lwhps2fpga
>> altera_hps2fpga_bridge fpgabridge.4: init-val not specified
>> altera_hps2fpga_bridge fpgabridge.5: fpga bridge [fpga2hps] registered as
>> device fpga2hps
>> altera_hps2fpga_bridge fpgabridge.5: init-val not specified
>> bio: create slab <bio-0> at 0
>> PCI host bridge to bus 0000:00
>> pci_bus 0000:00: root bus resource [mem 0xc0000000-0xcfffffff]
>> pci_bus 0000:00: root bus resource [mem 0xd0000000-0xdfffffff pref]
>> pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
>> pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
>> PCI: bus0: Fast back to back transfers disabled
>> pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> PCI: bus1: Fast back to back transfers disabled
>> pci 0000:00:00.0: BAR 8: assigned [mem 0xc0000000-0xc00fffff]
>> pci 0000:01:00.0: BAR 0: assigned [mem 0xc0000000-0xc0003fff 64bit]
>> pci 0000:01:00.0: BAR 2: can't assign io (size 0x100)
>> pci 0000:00:00.0: PCI bridge to [bus 01]
>> pci 0000:00:00.0:   bridge window [mem 0xc0000000-0xc00fffff]
>> PCI: enabling device 0000:00:00.0 (0140 -> 0143)
>> FPGA Mangager framework driver
>> vgaarb: loaded
>> SCSI subsystem initialized
>> usbcore: registered new interface driver usbfs
>> usbcore: registered new interface driver hub
>> usbcore: registered new device driver usb
>> pps_core: LinuxPPS API ver. 1 registered
>> pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti
>> <giometti at linux.it>
>> PTP clock support registered
>> Switching to clocksource timer
>> NET: Registered protocol family 2
>> TCP established hash table entries: 8192 (order: 4, 65536 bytes)
>> TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
>> TCP: Hash tables configured (established 8192 bind 8192)
>> TCP: reno registered
>> UDP hash table entries: 512 (order: 2, 16384 bytes)
>> UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
>> NET: Registered protocol family 1
>> RPC: Registered named UNIX socket transport module.
>> RPC: Registered udp transport module.
>> RPC: Registered tcp transport module.
>> RPC: Registered tcp NFSv4.1 backchannel transport module.
>> hw perfevents: enabled with ARMv7 Cortex-A9 PMU driver, 7 counters available
>> arm-pmu arm-pmu: PMU:CTI successfully enabled for 2 cores
>> squashfs: version 4.0 (2009/01/31) Phillip Lougher
>> NFS: Registering the id_resolver key type
>> Key type id_resolver registered
>> Key type id_legacy registered
>> NTFS driver 2.1.30 [Flags: R/W].
>> jffs2: version 2.2. (NAND) ? 2001-2006 Red Hat, Inc.
>> aufs 3.10-20141215
>> msgmni has been set to 2014
>> io scheduler noop registered (default)
>> Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
>> ffc02000.serial: ttyS0 at MMIO 0xffc02000 (irq = 194) is a 16550A
>> console [ttyS0] enabled
>> ffc03000.serial: ttyS1 at MMIO 0xffc03000 (irq = 195) is a 16550A
>> ttyAL0 at MMIO 0xff200060 (irq = 79) is a Altera UART
>> ttyAL1 at MMIO 0xff200040 (irq = 76) is a Altera UART
>> altera_fpga_manager ff706000.fpgamgr: fpga manager [Altera FPGA Manager]
>> registered as minor 0
>> brd: module loaded
>> PCI: enabling device 0000:01:00.0 (0140 -> 0142)
>>  nvme0n1: p1 p2
>> at24 0-0050: 2048 byte 24c16 EEPROM, writable, 1 bytes/write
>> at24 1-0050: 32768 byte 24c256 EEPROM, writable, 64 bytes/write
>> at24 1-0051: 32768 byte 24c256 EEPROM, writable, 64 bytes/write
>> at24 1-0052: 32768 byte 24c256 EEPROM, writable, 64 bytes/write
>> at24 1-0053: 32768 byte 24c256 EEPROM, writable, 64 bytes/write
>> at24 1-0054: 32768 byte 24c256 EEPROM, writable, 64 bytes/write
>> at24 1-0055: 32768 byte 24c256 EEPROM, writable, 64 bytes/write
>> at24 1-0056: 32768 byte 24c256 EEPROM, writable, 64 bytes/write
>> at24 1-0057: 32768 byte 24c256 EEPROM, writable, 64 bytes/write
>> cadence-qspi ff705000.flash: cannot get qspi clk
>> cadence-qspi: probe of ff705000.flash failed with error -2
>> libphy: Fixed MDIO Bus: probed
>> stmmac - user ID: 0x10, Synopsys ID: 0x37
>>  Ring mode enabled
>>  DMA HW capability register supported
>>  Enhanced/Alternate descriptors
>>     Enabled extended descriptors
>>  RX Checksum Offload Engine supported (type 2)
>>  TX Checksum insertion supported
>>  Enable RX Mitigation via HW Watchdog Timer
>> libphy: stmmac: probed
>> eth0: PHY ID 02000140 at 0 IRQ POLL (stmmac-0:00) active
>> eth0: PHY ID 0b000280 at 1 IRQ POLL (stmmac-0:01)
>> eth0: PHY ID 00608018 at 2 IRQ POLL (stmmac-0:02)
>> eth0: PHY ID 020000a0 at 3 IRQ POLL (stmmac-0:03)
>> eth0: PHY ID 00200008 at 4 IRQ POLL (stmmac-0:04)
>> eth0: PHY ID 00000100 at 5 IRQ POLL (stmmac-0:05)
>> eth0: PHY ID 09000040 at 6 IRQ POLL (stmmac-0:06)
>> eth0: PHY ID 80002000 at 7 IRQ POLL (stmmac-0:07)
>> eth0: PHY ID 00000992 at 16 IRQ POLL (stmmac-0:10)
>> eth0: PHY ID 00000992 at 17 IRQ POLL (stmmac-0:11)
>> eth0: PHY ID 00000992 at 18 IRQ POLL (stmmac-0:12)
>> eth0: PHY ID 00000992 at 19 IRQ POLL (stmmac-0:13)
>> eth0: PHY ID 00000992 at 20 IRQ POLL (stmmac-0:14)
>> eth0: PHY ID 00000992 at 21 IRQ POLL (stmmac-0:15)
>> eth0: PHY ID 00000992 at 22 IRQ POLL (stmmac-0:16)
>> eth0: PHY ID 00000992 at 23 IRQ POLL (stmmac-0:17)
>> eth0: PHY ID 00000992 at 24 IRQ POLL (stmmac-0:18)
>> eth0: PHY ID 00000992 at 25 IRQ POLL (stmmac-0:19)
>> eth0: PHY ID 00000992 at 26 IRQ POLL (stmmac-0:1a)
>> eth0: PHY ID 00000000 at 27 IRQ POLL (stmmac-0:1b)
>> stmmac - user ID: 0x10, Synopsys ID: 0x37
>>  Ring mode enabled
>>  DMA HW capability register supported
>>  Enhanced/Alternate descriptors
>>     Enabled extended descriptors
>>  RX Checksum Offload Engine supported (type 2)
>>  TX Checksum insertion supported
>>  Enable RX Mitigation via HW Watchdog Timer
>> !!!!! reg0 0x1100
>> libphy: stmmac: probed
>> eth1: PHY ID 00221622 at 3 IRQ POLL (stmmac-1:03) active
>> libphy: altera_tse: probed
>> altera_tse ff202000.ethernet (unregistered net_device): MDIO bus
>> altera_tse-0: created
>> altera_tse ff202000.ethernet: Altera TSE MAC version 16.0 at 0xff202000 irq
>> 82/81
>> libphy: altera_tse: probed
>> altera_tse ff203000.ethernet (unregistered net_device): MDIO bus
>> altera_tse-1: created
>> altera_tse ff203000.ethernet: Altera TSE MAC version 16.0 at 0xff203000 irq
>> 84/83
>> dwc2 ffb40000.usb: DWC OTG Controller
>> dwc2 ffb40000.usb: new USB bus registered, assigned bus number 1
>> dwc2 ffb40000.usb: irq 160, io mem 0x00000000
>> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
>> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> usb usb1: Product: DWC OTG Controller
>> usb usb1: Manufacturer: Linux 3.10.37-ltsi-rt37 dwc2_hsotg
>> usb usb1: SerialNumber: ffb40000.usb
>> hub 1-0:1.0: USB hub found
>> hub 1-0:1.0: 1 port detected
>> usbcore: registered new interface driver usb-storage
>> mousedev: PS/2 mouse device common for all mice
>> rtc-ab18xx 0-0069: rtc core: registered ab1803 as rtc0
>> rtc-ab18xx 0-0069: 192 bytes nvram
>> i2c /dev entries driver
>> at24 2-0053: 32768 byte 24c256 EEPROM, writable, 16 bytes/write
>> at24 2-0051: 32768 byte 24c256 EEPROM, writable, 16 bytes/write
>> at24 2-0054: 32768 byte 24c256 EEPROM, writable, 1 bytes/write
>> pca953x_get_alt_pdata: device-tree property 'linux,gpio-base' is deprecated!
>> pca953x 2-0020: failed reading register
>> pca953x: probe of 2-0020 failed with error -5
>> usb 1-1: new high-speed USB device number 2 using dwc2
>> lm73 0-004c: hwmon2: sensor 'lm73'
>> Synopsys Designware Multimedia Card Interface Driver
>> dwmmc_socfpga ff704000.flash: Using internal DMA controller.
>> dwmmc_socfpga ff704000.flash: Version ID is 240a
>> dwmmc_socfpga ff704000.flash: DW MMC controller at irq 171, 32 bit host data
>> width, 1024 deep fifo
>> mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual
>> 396825HZ div = 63)
>> dwmmc_socfpga ff704000.flash: 1 slots initialized
>> leds-gpio leds.2: Skipping unavailable LED gpio -2 (fpga0)
>> leds-gpio leds.2: Skipping unavailable LED gpio -2 (fpga1)
>> leds-gpio leds.2: Skipping unavailable LED gpio -2 (fpga2)
>> ledtrig-cpu: registered to indicate activity on CPUs
>> usbcore: registered new interface driver usbhid
>> usbhid: USB HID core driver
>> oprofile: using arm/armv7-ca9
>> TCP: cubic registered
>> NET: Registered protocol family 10
>> sit: IPv6 over IPv4 tunneling driver
>> NET: Registered protocol family 17
>> NET: Registered protocol family 15
>> 8021q: 802.1Q VLAN Support v1.8
>> Key type dns_resolver registered
>> VFP support v0.3: mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req
>> 50000000Hz, actual 50000000HZ div = 0)
>> mmc0: new high speed SDHC card at address aaaa
>> mmcblk0: mmc0:aaaa SL08G 7.40 GiB
>>  mmcblk0: p1 p2 p3 p4 < p5 p6 p7 >
>> implementor 41 architecture 3 part 30 variant 9 rev 4
>> ThumbEE CPU extension supported.
>> Registering SWP/SWPB emulation handler
>> rtc-ab18xx 0-0069: setting system clock to 2017-05-19 14:10:37 UTC
>> (1495203037)
>> usb 1-1: New USB device found, idVendor=04b4, idProduct=6572
>> usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
>> usb 1-1: Product: USB2.0 Hub
>> hub 1-1:1.0: USB hub found
>> VFS: Mounted root (squashfs filesystem) readonly on device 179:5.
>> Freeing unused kernel memory: 352K (806f2000 - 8074a000)
>> hub 1-1:1.0: 4 ports detected
>> Mounting /proc...
>> Mounting /dev/pts...
>> Mounting /sys...
>> Mounting /tmp...
>> Mounting /dev/shm...
>> Setting MAC (if needed)...
>> mountinng home
>> mountinng var
>> mountinng www
>> mountinng data
>> aufs opt_add:805:mount[145]: lookup failed /ro/data (-2)
>> mount: mounting none on /data failed: Invalid argument
>> mountinng /etc/radiusclient
>> ...done
>>
>> init started: BusyBox v1.19.3 (2017-02-23 14:55:23 EST)
>>
>> starting pid 148, tty '': '/etc/rcS'
>> NVME SSD found
>> Partition NVME0N1P1 exists
>> Partition NVME0N1P2 exists
>> Mounting Data partition...Mounting data partition(/jffs) to SSD(NVME)
>> /dev/nvme0n1p1: clean, 1907/7634944 files, 578820/30519475 blocks
>> /dev/nvme0n1p2: clean, 11/61824 files, 4196/246999 blocks
>> EXT4-fs (nvme0n1p1): mounted filesystem without journal. Opts: data=ordered
>> chmod: /bin/busybox: Read-only file system
>> chmod: /home/admin/.ssh: No such file or directory
>> /jffs/core_dumps/core-%e-%s-%u-%g-%p-%h-%t
>>
>> starting pid 346, tty '': '/etc/rc start'
>> Starting service: crond
>> Starting service: syslogd
>> crond[405]: crond: crond (busybox 1.21.1) started, log level 8
>>
>>
>> On Thu, May 18, 2017@5:35 PM, Dennis Mungai <dmngaie@gmail.com> wrote:
>>>
>>> There's a lot of missing information here.
>>>
>>> For starters:What is the make of your system?
>>> dmidecode - t chassis and lspci output will help, plus the dmesg log.
>>>
>>> Also, if you can, provide the full model of the NVMe SSDs you're testing
>>> and the firmware versions, if known.
>>>
>>> Providing more details means a faster response.
>>>
>>> On May 18, 2017 6:31 PM, "Linux User" <newhorizons009@gmail.com> wrote:
>>>>
>>>> Any inputs ?
>>>>
>>>> On Wed, May 17, 2017 at 3:34 PM, Linux User <newhorizons009 at gmail.com>
>>>> wrote:
>>>> > Hello All,
>>>> >
>>>> >
>>>> > I switched my ssd from M.2 based ahci protocol to nvme protocol, with
>>>> > that, when i do chmod 777 -R /mnt/ssd it takes forever, however same
>>>> > step on the ahci based ssd takes a blink of an eye.
>>>> >
>>>> > Even doing ls at /mnt/ssd takes a long time.
>>>> >
>>>> >
>>>> > I am running 3.10-ltsi. Below are my fs creation params.
>>>> >
>>>> > mke2fs -F -t ext4 /dev/nvme0n1p1
>>>> >   tune2fs -o journal_data_writeback /dev/nvme0n1p1
>>>> >   tune2fs -O ^has_journal /dev/nvme0n1p1
>>>> >
>>>> >
>>>> > Below are my mounting options,
>>>> >
>>>> > mount -t ext4 -o data=ordered,noatime,nodiratime,norelatime
>>>> > /dev/nvme0n1p1
>>>> >
>>>> >
>>>> > Any clues ?
>>>> >
>>>> >
>>>> > Having said above, I did a fio random read test on both AHCI and NVMe,
>>>> > and that seems to have good results.
>>>> >
>>>> > Toshiba NVMe
>>>> >
>>>> > bw (KB  /s): min=14320, max=21496, per=100.00%, avg=19765.54,
>>>> > stdev=1813.54
>>>> >
>>>> >
>>>> >
>>>> > Samsung AHCI
>>>> >
>>>> > bw (KB  /s): min=15687, max=19720, per=99.52%, avg=17773.93,
>>>> > stdev=1236.09
>>>>
>>>> _______________________________________________
>>>> Linux-nvme mailing list
>>>> Linux-nvme at lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-nvme
>>
>>
