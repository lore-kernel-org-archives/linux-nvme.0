From: pmenzel+linux-nvme@molgen.mpg.de (Paul Menzel)
Date: Mon, 22 Jan 2018 22:02:12 +0100
Subject: Report long suspend times of NVMe devices (mostly firmware/device
 issues)
Message-ID: <9e398971-762d-bb1a-f798-bf0b18cb5b6b@molgen.mpg.de>

Dear Linux folks,


Benchmarking the ACPI S3 suspend and resume times with `sleepgraph.py 
-config config/suspend-callgraph.cfg` [1], shows that the NVMe disk 
SAMSUNG MZVKW512HMJP-00000 in the TUXEDO Book BU1406 takes between 0.3 
and 1.4 seconds, holding up the suspend cycle.

The time is spent in `nvme_shutdown_ctrl()`.

### Linux 4.14.1-041401-generic

> nvme @ 0000:04:00.0 {nvme} async_device (Total Suspend: 1439.299 ms Total Resume: 19.865 ms)

### Linux 4.15-rc9

> nvme @ 0000:04:00.0 {nvme} async_device (Total Suspend: 362.239 ms Total Resume: 19.897 m
It?d be useful, if the Linux kernel logged such issues visibly to the 
user, so that the hardware manufacturer can be contacted to fix the 
device (probably the firmware).

In my opinion anything longer than 200 ms should be reported similar to 
[2], and maybe worded like below.

> NVMe took more than 200 ms to do suspend routine

What do you think?


Kind regards,

Paul


[1] https://github.com/01org/pm-graph
[2] https://patchwork.kernel.org/patch/10135925/
-------------- next part --------------
[    0.000000] Linux version 4.15.0-rc9+ (helmuth at helmuth-N24-25BU) (gcc version 7.2.0 (Ubuntu 7.2.0-8ubuntu3)) #18 SMP Mon Jan 22 20:04:46 CET 2018
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.15.0-rc9+ root=UUID=66c28cf8-41b0-4ae7-998d-8e3e76a3fed7 ro quiet splash acpi_os_name=Linux acpi_osi= acpi_backlight=vendor initcall_debug log_buf_len=32M trace_buf_size=524288K trace_clock=global trace_options=nooverwrite,funcgraph-abstime,funcgraph-cpu,funcgraph-duration,funcgraph-proc,funcgraph-tail,nofuncgraph-overhead,context-info,graph-time ftrace=function_graph ftrace_graph_max_depth=15 ftrace_graph_filter=do_one_initcall
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007a4f0fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a4f1000-0x000000007a4f1fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007a4f2000-0x000000007a4f2fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007a4f3000-0x000000007eb49fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007eb4a000-0x000000007f4bafff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007f4bb000-0x000000007f592fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007f593000-0x000000007f904fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007f905000-0x000000007ffa3fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007ffa4000-0x000000007fffefff] type 20
[    0.000000] BIOS-e820: [mem 0x000000007ffff000-0x000000007fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000080000000-0x000000008abfffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000008743fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.50 by American Megatrends
[    0.000000] efi:  ACPI 2.0=0x7f893000  ACPI=0x7f893000  SMBIOS=0x7ff17000  SMBIOS 3.0=0x7ff16000  ESRT=0x7da36ad8 
[    0.000000] random: fast init done
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 07/07/2017
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x874400 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.000000]   1 base 00A0000000 mask 7FE0000000 uncachable
[    0.000000]   2 base 0090000000 mask 7FF0000000 uncachable
[    0.000000]   3 base 008C000000 mask 7FFC000000 uncachable
[    0.000000]   4 base 008A000000 mask 7FFE000000 uncachable
[    0.000000]   5 base 0089000000 mask 7FFF000000 uncachable
[    0.000000]   6 base 0088800000 mask 7FFF800000 uncachable
[    0.000000]   7 base 0088400000 mask 7FFFC00000 uncachable
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: last_pfn = 0x80000 max_arch_pfn = 0x400000000
[    0.000000] esrt: Reserving ESRT space from 0x000000007da36ad8 to 0x000000007da36b10.
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [        (ptrval)] 97000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x7c9ba5000, 0x7c9ba5fff] PGTABLE
[    0.000000] BRK [0x7c9ba6000, 0x7c9ba6fff] PGTABLE
[    0.000000] BRK [0x7c9ba7000, 0x7c9ba7fff] PGTABLE
[    0.000000] BRK [0x7c9ba8000, 0x7c9ba8fff] PGTABLE
[    0.000000] BRK [0x7c9ba9000, 0x7c9ba9fff] PGTABLE
[    0.000000] BRK [0x7c9baa000, 0x7c9baafff] PGTABLE
[    0.000000] BRK [0x7c9bab000, 0x7c9babfff] PGTABLE
[    0.000000] BRK [0x7c9bac000, 0x7c9bacfff] PGTABLE
[    0.000000] BRK [0x7c9bad000, 0x7c9badfff] PGTABLE
[    0.000000] BRK [0x7c9bae000, 0x7c9baefff] PGTABLE
[    0.000000] log_buf_len: 33554432 bytes
[    0.000000] early log buf free: 256388(97%)
[    0.000000] Secure boot could not be determined
[    0.000000] RAMDISK: [mem 0x30a2d000-0x3450dfff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000007F893000 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x000000007F8930A8 0000CC (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x000000007F8AE6C8 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x000000007F893208 01B4BF (v02 ALASKA A M I    01072009 INTL 20160422)
[    0.000000] ACPI: FACS 0x000000007F8ECC40 000040
[    0.000000] ACPI: APIC 0x000000007F8AE7E0 000084 (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x000000007F8AE868 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x000000007F8AE8B0 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
[    0.000000] ACPI: SSDT 0x000000007F8AE8F0 000322 (v01 SataRe SataTabl 00001000 INTL 20160422)
[    0.000000] ACPI: FIDT 0x000000007F8AEC18 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x000000007F8AECB8 003295 (v02 SaSsdt SaSsdt   00003000 INTL 20160422)
[    0.000000] ACPI: HPET 0x000000007F8B1F50 000038 (v01 INTEL  KBL-ULT  00000001 MSFT 0000005F)
[    0.000000] ACPI: SSDT 0x000000007F8B1F88 000024 (v02 INTEL  xh_OEMBD 00000000 INTL 20160422)
[    0.000000] ACPI: UEFI 0x000000007F8B1FB0 000042 (v01 INTEL  EDK2     00000002      01000013)
[    0.000000] ACPI: SSDT 0x000000007F8B1FF8 000EDE (v02 CpuRef CpuSsdt  00003000 INTL 20160422)
[    0.000000] ACPI: LPIT 0x000000007F8B2ED8 000094 (v01 INTEL  KBL-ULT  00000000 MSFT 0000005F)
[    0.000000] ACPI: WSMT 0x000000007F8B2F70 000028 (v01 INTEL  KBL-ULT  00000000 MSFT 0000005F)
[    0.000000] ACPI: SSDT 0x000000007F8B2F98 00029F (v02 INTEL  sensrhub 00000000 INTL 20160422)
[    0.000000] ACPI: SSDT 0x000000007F8B3238 003002 (v02 INTEL  PtidDevc 00001000 INTL 20160422)
[    0.000000] ACPI: DBGP 0x000000007F8B6240 000034 (v01 INTEL           00000002 MSFT 0000005F)
[    0.000000] ACPI: DBG2 0x000000007F8B6278 000054 (v00 INTEL           00000002 MSFT 0000005F)
[    0.000000] ACPI: BGRT 0x000000007F8B62D0 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: DMAR 0x000000007F8B6308 0000A8 (v01 INTEL  KBL      00000001 INTL 00000001)
[    0.000000] ACPI: TPM2 0x000000007F8B63B0 000034 (v03        Tpm2Tabl 00000001 AMI  00000000)
[    0.000000] ACPI: ASF! 0x000000007F8B63E8 0000A0 (v32 INTEL   HCG     00000001 TFSM 000F4240)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x00000008743fffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x8723fb000-0x8723fffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000008743fffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.000000]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000007a4f0fff]
[    0.000000]   node   0: [mem 0x000000007a4f3000-0x000000007eb49fff]
[    0.000000]   node   0: [mem 0x000000007f4bb000-0x000000007f592fff]
[    0.000000]   node   0: [mem 0x000000007ffff000-0x000000007fffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x00000008743fffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x00000008743fffff]
[    0.000000] On node 0 totalpages: 8335293
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 23 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 8049 pages used for memmap
[    0.000000]   DMA32 zone: 515105 pages, LIFO batch:31
[    0.000000]   Normal zone: 122128 pages used for memmap
[    0.000000]   Normal zone: 7816192 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 98 pages
[    0.000000] Reserving Intel graphics memory at 0x0000000088c00000-0x000000008abfffff
[    0.000000] ACPI: PM-Timer IO Port: 0x1808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x7a4f1000-0x7a4f1fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7a4f2000-0x7a4f2fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7eb4a000-0x7f4bafff]
[    0.000000] PM: Registered nosave memory: [mem 0x7f593000-0x7f904fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7f905000-0x7ffa3fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7ffa4000-0x7fffefff]
[    0.000000] PM: Registered nosave memory: [mem 0x80000000-0x8abfffff]
[    0.000000] PM: Registered nosave memory: [mem 0x8ac00000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xfdffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed01000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0x8ac00000-0xdfffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 45 pages/cpu @        (ptrval) s146264 r8192 d29864 u524288
[    0.000000] pcpu-alloc: s146264 r8192 d29864 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 8205029
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.15.0-rc9+ root=UUID=66c28cf8-41b0-4ae7-998d-8e3e76a3fed7 ro quiet splash acpi_os_name=Linux acpi_osi= acpi_backlight=vendor initcall_debug log_buf_len=32M trace_buf_size=524288K trace_clock=global trace_options=nooverwrite,funcgraph-abstime,funcgraph-cpu,funcgraph-duration,funcgraph-proc,funcgraph-tail,nofuncgraph-overhead,context-info,graph-time ftrace=function_graph ftrace_graph_max_depth=15 ftrace_graph_filter=do_one_initcall
[    0.000000] ACPI: _OSI method disabled
[    0.000000] Memory: 32548100K/33341172K available (18444K kernel code, 13987K rwdata, 3932K rodata, 1824K init, 1224K bss, 793072K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] ftrace: allocating 38292 entries in 150 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 16640, nr_irqs: 1024, preallocated irqs: 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] ACPI: Core revision 20170831
[    0.000000] ACPI: Overriding _OS definition to 'Linux'
[    0.000000] ACPI: 7 ACPI AML tables successfully acquired and loaded
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.000000] hpet clockevent registered
[    0.004000] APIC: Switch to symmetric I/O mode setup
[    0.004000] DMAR: Host address width 39
[    0.004000] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.004000] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    0.004000] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.004000] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.004000] DMAR: RMRR base: 0x0000007ef47000 end: 0x0000007ef66fff
[    0.004000] DMAR: RMRR base: 0x00000088400000 end: 0x0000008abfffff
[    0.004000] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.004000] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.004000] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.004000] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.004000] x2apic enabled
[    0.004000] Switched APIC routing to cluster x2apic.
[    0.008000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.028000] tsc: Detected 2900.000 MHz processor
[    0.028000] tsc: Detected 2904.000 MHz TSC
[    0.028000] Calibrating delay loop (skipped), value calculated using timer frequency.. 5808.00 BogoMIPS (lpj=11616000)
[    0.028000] pid_max: default: 32768 minimum: 301
[    0.028000] Security Framework initialized
[    0.028000] Yama: becoming mindful.
[    0.028000] AppArmor: AppArmor initialized
[    0.032329] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.034157] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.034229] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.034288] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.034468] CPU: Physical Processor ID: 0
[    0.034469] CPU: Processor Core ID: 0
[    0.034476] mce: CPU supports 8 MCE banks
[    0.034484] CPU0: Thermal monitoring enabled (TM1)
[    0.034498] process: using mwait in idle threads
[    0.034501] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.034502] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.034504] Spectre V2 mitigation: Vulnerable: Minimal generic ASM retpoline
[    0.034505] Spectre V2 mitigation: Filling RSB on context switch
[    0.034688] Freeing SMP alternatives memory: 36K
[    0.038492] TSC deadline timer enabled
[    0.038503] smpboot: CPU0: Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz (family: 0x6, model: 0x8e, stepping: 0x9)
[    0.038830] calling  trace_init_flags_sys_exit+0x0/0xf @ 1
[    0.038841] initcall trace_init_flags_sys_exit+0x0/0xf returned 0 after 0 usecs
[    0.038851] calling  trace_init_flags_sys_enter+0x0/0xf @ 1
[    0.038859] initcall trace_init_flags_sys_enter+0x0/0xf returned 0 after 0 usecs
[    0.038868] calling  init_hw_perf_events+0x0/0x7e2 @ 1
[    0.038871] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.039041] ... version:                4
[    0.039043] ... bit width:              48
[    0.039046] ... generic registers:      4
[    0.039050] ... value mask:             0000ffffffffffff
[    0.039054] ... max period:             00007fffffffffff
[    0.039056] ... fixed-purpose events:   3
[    0.039060] ... event mask:             000000070000000f
[    0.039153] initcall init_hw_perf_events+0x0/0x7e2 returned 0 after 0 usecs
[    0.039160] calling  init_real_mode+0x0/0x31a @ 1
[    0.039196] initcall init_real_mode+0x0/0x31a returned 0 after 0 usecs
[    0.039204] calling  trace_init_perf_perm_irq_work_exit+0x0/0x13 @ 1
[    0.039211] initcall trace_init_perf_perm_irq_work_exit+0x0/0x13 returned 0 after 0 usecs
[    0.039221] calling  register_nmi_cpu_backtrace_handler+0x0/0x16 @ 1
[    0.039230] initcall register_nmi_cpu_backtrace_handler+0x0/0x16 returned 0 after 0 usecs
[    0.039238] calling  numachip_system_init+0x0/0x67 @ 1
[    0.039246] initcall numachip_system_init+0x0/0x67 returned 0 after 0 usecs
[    0.039257] calling  early_efi_map_fb+0x0/0x4d @ 1
[    0.039269] initcall early_efi_map_fb+0x0/0x4d returned 0 after 0 usecs
[    0.039275] calling  spawn_ksoftirqd+0x0/0x4c @ 1
[    0.039355] initcall spawn_ksoftirqd+0x0/0x4c returned 0 after 0 usecs
[    0.039363] calling  migration_init+0x0/0x98 @ 1
[    0.039370] initcall migration_init+0x0/0x98 returned 0 after 0 usecs
[    0.039379] calling  check_cpu_stall_init+0x0/0x1b @ 1
[    0.039389] initcall check_cpu_stall_init+0x0/0x1b returned 0 after 0 usecs
[    0.039398] calling  srcu_bootup_announce+0x0/0x30 @ 1
[    0.039400] Hierarchical SRCU implementation.
[    0.039409] initcall srcu_bootup_announce+0x0/0x30 returned 0 after 0 usecs
[    0.039418] calling  rcu_spawn_gp_kthread+0x0/0x147 @ 1
[    0.039513] initcall rcu_spawn_gp_kthread+0x0/0x147 returned 0 after 0 usecs
[    0.039523] calling  cpu_stop_init+0x0/0x13d @ 1
[    0.039587] initcall cpu_stop_init+0x0/0x13d returned 0 after 0 usecs
[    0.039593] calling  init_events+0x0/0xfa @ 1
[    0.039624] initcall init_events+0x0/0xfa returned 0 after 0 usecs
[    0.039630] calling  init_trace_printk+0x0/0xc @ 1
[    0.039637] initcall init_trace_printk+0x0/0xc returned 0 after 0 usecs
[    0.039645] calling  event_trace_enable_again+0x0/0x21 @ 1
[    0.039653] initcall event_trace_enable_again+0x0/0x21 returned 0 after 0 usecs
[    0.039662] calling  jump_label_init_module+0x0/0x11 @ 1
[    0.039670] initcall jump_label_init_module+0x0/0x11 returned 0 after 0 usecs
[    0.039682] calling  dynamic_debug_init+0x0/0x2fe @ 1
[    0.040000] initcall dynamic_debug_init+0x0/0x2fe returned 0 after 0 usecs
[    0.040000] calling  rand_initialize+0x0/0x130 @ 1
[    0.040207] initcall rand_initialize+0x0/0x130 returned 0 after 3906 usecs
[    0.040217] calling  initialize_ptr_random+0x0/0x68 @ 1
[    0.040230] initcall initialize_ptr_random+0x0/0x68 returned 0 after 0 usecs
[    0.041817] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.041882] smp: Bringing up secondary CPUs ...
[    0.072667] x86: Booting SMP configuration:
[    0.072668] .... node  #0, CPUs:      #1 #2 #3
[    0.121083] smp: Brought up 1 node, 4 CPUs
[    0.121083] smpboot: Max logical packages: 1
[    0.121083] smpboot: Total of 4 processors activated (23232.00 BogoMIPS)
[    0.124655] devtmpfs: initialized
[    0.124655] x86/mm: Memory block size: 128MB
[    0.126152] calling  ipc_ns_init+0x0/0xc7 @ 1
[    0.126155] initcall ipc_ns_init+0x0/0xc7 returned 0 after 0 usecs
[    0.126156] calling  init_mmap_min_addr+0x0/0x16 @ 1
[    0.126158] initcall init_mmap_min_addr+0x0/0x16 returned 0 after 0 usecs
[    0.126159] calling  evm_display_config+0x0/0x43 @ 1
[    0.126160] evm: security.selinux
[    0.126160] evm: security.SMACK64
[    0.126161] evm: security.SMACK64EXEC
[    0.126161] evm: security.SMACK64TRANSMUTE
[    0.126162] evm: security.SMACK64MMAP
[    0.126162] evm: security.apparmor
[    0.126162] evm: security.ima
[    0.126163] evm: security.capability
[    0.126164] initcall evm_display_config+0x0/0x43 returned 0 after 0 usecs
[    0.126166] calling  init_cpufreq_transition_notifier_list+0x0/0x1b @ 1
[    0.126170] initcall init_cpufreq_transition_notifier_list+0x0/0x1b returned 0 after 0 usecs
[    0.126172] calling  jit_init+0x0/0x8 @ 1
[    0.126173] initcall jit_init+0x0/0x8 returned 0 after 0 usecs
[    0.126175] calling  net_ns_init+0x0/0x18d @ 1
[    0.126188] initcall net_ns_init+0x0/0x18d returned 0 after 0 usecs
[    0.126188] calling  xen_pvh_gnttab_setup+0x0/0x4d @ 1
[    0.126188] initcall xen_pvh_gnttab_setup+0x0/0x4d returned -19 after 0 usecs
[    0.126188] calling  e820__register_nvs_regions+0x0/0x91 @ 1
[    0.126188] PM: Registering ACPI NVS region [mem 0x7a4f1000-0x7a4f1fff] (4096 bytes)
[    0.126188] PM: Registering ACPI NVS region [mem 0x7f593000-0x7f904fff] (3612672 bytes)
[    0.126188] initcall e820__register_nvs_regions+0x0/0x91 returned 0 after 0 usecs
[    0.126188] calling  cpufreq_register_tsc_scaling+0x0/0x5e @ 1
[    0.126188] initcall cpufreq_register_tsc_scaling+0x0/0x5e returned 0 after 0 usecs
[    0.126188] calling  init_cpu_syscore+0x0/0xf @ 1
[    0.126188] initcall init_cpu_syscore+0x0/0xf returned 0 after 0 usecs
[    0.126188] calling  reboot_init+0x0/0x3d @ 1
[    0.126188] initcall reboot_init+0x0/0x3d returned 0 after 0 usecs
[    0.126188] calling  init_lapic_sysfs+0x0/0x3b @ 1
[    0.126188] initcall init_lapic_sysfs+0x0/0x3b returned 0 after 0 usecs
[    0.126188] calling  cpu_hotplug_pm_sync_init+0x0/0x14 @ 1
[    0.126188] initcall cpu_hotplug_pm_sync_init+0x0/0x14 returned 0 after 0 usecs
[    0.126188] calling  alloc_frozen_cpus+0x0/0x8 @ 1
[    0.126188] initcall alloc_frozen_cpus+0x0/0x8 returned 0 after 0 usecs
[    0.126188] calling  wq_sysfs_init+0x0/0x2b @ 1
[    0.126188] initcall wq_sysfs_init+0x0/0x2b returned 0 after 0 usecs
[    0.126188] calling  ksysfs_init+0x0/0xb0 @ 1
[    0.126188] initcall ksysfs_init+0x0/0xb0 returned 0 after 0 usecs
[    0.126188] calling  pm_init+0x0/0x98 @ 1
[    0.126188] initcall pm_init+0x0/0x98 returned 0 after 0 usecs
[    0.126188] calling  pm_disk_init+0x0/0x18 @ 1
[    0.126188] initcall pm_disk_init+0x0/0x18 returned 0 after 0 usecs
[    0.126188] calling  swsusp_header_init+0x0/0x30 @ 1
[    0.126188] initcall swsusp_header_init+0x0/0x30 returned 0 after 0 usecs
[    0.126188] calling  rcu_spawn_tasks_kthread+0x0/0x81 @ 1
[    0.126188] initcall rcu_spawn_tasks_kthread+0x0/0x81 returned 0 after 0 usecs
[    0.126188] calling  rcu_set_runtime_mode+0x0/0x12 @ 1
[    0.126188] initcall rcu_set_runtime_mode+0x0/0x12 returned 0 after 0 usecs
[    0.126188] calling  init_jiffies_clocksource+0x0/0x18 @ 1
[    0.126188] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.126188] initcall init_jiffies_clocksource+0x0/0x18 returned 0 after 0 usecs
[    0.126188] calling  futex_init+0x0/0x24c @ 1
[    0.126188] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.126188] initcall futex_init+0x0/0x24c returned 0 after 0 usecs
[    0.126188] calling  cgroup_wq_init+0x0/0x3a @ 1
[    0.126188] initcall cgroup_wq_init+0x0/0x3a returned 0 after 0 usecs
[    0.126188] calling  cgroup1_wq_init+0x0/0x3a @ 1
[    0.126188] initcall cgroup1_wq_init+0x0/0x3a returned 0 after 0 usecs
[    0.126188] calling  ftrace_mod_cmd_init+0x0/0xc @ 1
[    0.126188] initcall ftrace_mod_cmd_init+0x0/0xc returned 0 after 0 usecs
[    0.126188] calling  init_wakeup_tracer+0x0/0x2d @ 1
[    0.126188] initcall init_wakeup_tracer+0x0/0x2d returned 0 after 0 usecs
[    0.126188] calling  init_graph_trace+0x0/0x5d @ 1
[    0.126188] Starting tracer 'function_graph'
[    0.266908] initcall init_graph_trace+0x0/0x5d returned 0 after 140625 usecs
[    0.266923] calling  init_per_zone_wmark_min+0x0/0x70 @ 1
[    0.267000] initcall init_per_zone_wmark_min+0x0/0x70 returned 0 after 0 usecs
[    0.267034] calling  init_zero_pfn+0x0/0x60 @ 1
[    0.267064] initcall init_zero_pfn+0x0/0x60 returned 0 after 0 usecs
[    0.267092] calling  memory_failure_init+0x0/0x164 @ 1
[    0.267122] initcall memory_failure_init+0x0/0x164 returned 0 after 0 usecs
[    0.267149] calling  cma_init_reserved_areas+0x0/0x28a @ 1
[    0.267179] initcall cma_init_reserved_areas+0x0/0x28a returned 0 after 0 usecs
[    0.267207] calling  fsnotify_init+0x0/0x49 @ 1
[    0.267315] initcall fsnotify_init+0x0/0x49 returned 0 after 0 usecs
[    0.267343] calling  filelock_init+0x0/0xfc @ 1
[    0.267595] initcall filelock_init+0x0/0xfc returned 0 after 0 usecs
[    0.267623] calling  init_script_binfmt+0x0/0x16 @ 1
[    0.267655] initcall init_script_binfmt+0x0/0x16 returned 0 after 0 usecs
[    0.267683] calling  init_elf_binfmt+0x0/0x16 @ 1
[    0.267715] initcall init_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
[    0.267743] calling  init_compat_elf_binfmt+0x0/0x16 @ 1
[    0.267775] initcall init_compat_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
[    0.267802] calling  debugfs_init+0x0/0x53 @ 1
[    0.267887] initcall debugfs_init+0x0/0x53 returned 0 after 0 usecs
[    0.267915] calling  tracefs_init+0x0/0x3b @ 1
[    0.267965] initcall tracefs_init+0x0/0x3b returned 0 after 0 usecs
[    0.267993] calling  securityfs_init+0x0/0x69 @ 1
[    0.268310] initcall securityfs_init+0x0/0x69 returned 0 after 0 usecs
[    0.268339] calling  prandom_init+0x0/0x124 @ 1
[    0.268375] initcall prandom_init+0x0/0x124 returned 0 after 0 usecs
[    0.268403] calling  pinctrl_init+0x0/0xae @ 1
[    0.268426] pinctrl core: initialized pinctrl subsystem
[    0.268765] initcall pinctrl_init+0x0/0xae returned 0 after 0 usecs
[    0.268794] calling  gpiolib_dev_init+0x0/0x10f @ 1
[    0.269029] initcall gpiolib_dev_init+0x0/0x10f returned 0 after 0 usecs
[    0.269057] calling  sfi_sysfs_init+0x0/0x11c @ 1
[    0.269088] initcall sfi_sysfs_init+0x0/0x11c returned 0 after 0 usecs
[    0.269115] calling  virtio_init+0x0/0x30 @ 1
[    0.269296] initcall virtio_init+0x0/0x30 returned 0 after 0 usecs
[    0.269325] calling  regulator_init+0x0/0x8c @ 1
[    0.270274] initcall regulator_init+0x0/0x8c returned 0 after 0 usecs
[    0.270289] calling  iommu_init+0x0/0x37 @ 1
[    0.270339] initcall iommu_init+0x0/0x37 returned 0 after 0 usecs
[    0.270354] calling  early_resume_init+0x0/0x1c0 @ 1
[    0.270460] RTC time: 19:41:48, date: 01/22/18
[    0.270478] initcall early_resume_init+0x0/0x1c0 returned 0 after 0 usecs
[    0.270493] calling  opp_debug_init+0x0/0x3c @ 1
[    0.270536] initcall opp_debug_init+0x0/0x3c returned 0 after 0 usecs
[    0.270551] calling  cpufreq_core_init+0x0/0x58 @ 1
[    0.270584] initcall cpufreq_core_init+0x0/0x58 returned 0 after 0 usecs
[    0.270599] calling  cpuidle_init+0x0/0x3b @ 1
[    0.270651] initcall cpuidle_init+0x0/0x3b returned 0 after 0 usecs
[    0.270666] calling  capsule_reboot_register+0x0/0x11 @ 1
[    0.270685] initcall capsule_reboot_register+0x0/0x11 returned 0 after 0 usecs
[    0.270701] calling  bsp_pm_check_init+0x0/0x14 @ 1
[    0.270720] initcall bsp_pm_check_init+0x0/0x14 returned 0 after 0 usecs
[    0.270735] calling  sock_init+0x0/0xa6 @ 1
[    0.271090] initcall sock_init+0x0/0xa6 returned 0 after 0 usecs
[    0.271106] calling  net_inuse_init+0x0/0x24 @ 1
[    0.271135] initcall net_inuse_init+0x0/0x24 returned 0 after 0 usecs
[    0.271150] calling  net_defaults_init+0x0/0x24 @ 1
[    0.271170] initcall net_defaults_init+0x0/0x24 returned 0 after 0 usecs
[    0.271186] calling  init_default_flow_dissectors+0x0/0x50 @ 1
[    0.271204] initcall init_default_flow_dissectors+0x0/0x50 returned 0 after 0 usecs
[    0.271219] calling  netpoll_init+0x0/0x31 @ 1
[    0.271236] initcall netpoll_init+0x0/0x31 returned 0 after 0 usecs
[    0.271251] calling  netlink_proto_init+0x0/0x240 @ 1
[    0.271491] NET: Registered protocol family 16
[    0.271572] initcall netlink_proto_init+0x0/0x240 returned 0 after 0 usecs
[    0.271588] calling  __gnttab_init+0x0/0x50 @ 1
[    0.271605] initcall __gnttab_init+0x0/0x50 returned -19 after 0 usecs
[    0.271757] calling  irq_sysfs_init+0x0/0xb5 @ 1
[    0.273292] initcall irq_sysfs_init+0x0/0xb5 returned 0 after 3906 usecs
[    0.273308] calling  audit_init+0x0/0x1c1 @ 1
[    0.273345] audit: initializing netlink subsys (disabled)
[    0.276117] audit: type=2000 audit(1516650107.276:1): state=initialized audit_enabled=0 res=1
[    0.276137] initcall audit_init+0x0/0x1c1 returned 0 after 0 usecs
[    0.276152] calling  bdi_class_init+0x0/0x61 @ 1
[    0.276222] initcall bdi_class_init+0x0/0x61 returned 0 after 0 usecs
[    0.276237] calling  mm_sysfs_init+0x0/0x29 @ 1
[    0.276267] initcall mm_sysfs_init+0x0/0x29 returned 0 after 0 usecs
[    0.276283] calling  gpiolib_sysfs_init+0x0/0xc4 @ 1
[    0.276350] initcall gpiolib_sysfs_init+0x0/0xc4 returned 0 after 0 usecs
[    0.276365] calling  pcibus_class_init+0x0/0x18 @ 1
[    0.276405] initcall pcibus_class_init+0x0/0x18 returned 0 after 0 usecs
[    0.276420] calling  pci_driver_init+0x0/0x11 @ 1
[    0.276533] initcall pci_driver_init+0x0/0x11 returned 0 after 0 usecs
[    0.276549] calling  rio_bus_init+0x0/0x43 @ 1
[    0.276701] initcall rio_bus_init+0x0/0x43 returned 0 after 0 usecs
[    0.276716] calling  backlight_class_init+0x0/0xf0 @ 1
[    0.276763] initcall backlight_class_init+0x0/0xf0 returned 0 after 0 usecs
[    0.276779] calling  xenbus_init+0x0/0x31c @ 1
[    0.276795] initcall xenbus_init+0x0/0x31c returned -19 after 0 usecs
[    0.276811] calling  tty_class_init+0x0/0x4c @ 1
[    0.276852] initcall tty_class_init+0x0/0x4c returned 0 after 0 usecs
[    0.276867] calling  vtconsole_class_init+0x0/0xef @ 1
[    0.277140] initcall vtconsole_class_init+0x0/0xef returned 0 after 0 usecs
[    0.277155] calling  iommu_dev_init+0x0/0x18 @ 1
[    0.277193] initcall iommu_dev_init+0x0/0x18 returned 0 after 0 usecs
[    0.277209] calling  mipi_dsi_bus_init+0x0/0x11 @ 1
[    0.277311] initcall mipi_dsi_bus_init+0x0/0x11 returned 0 after 0 usecs
[    0.277326] calling  wakeup_sources_debugfs_init+0x0/0x24 @ 1
[    0.277368] initcall wakeup_sources_debugfs_init+0x0/0x24 returned 0 after 0 usecs
[    0.277383] calling  isa_bus_init+0x0/0x3c @ 1
[    0.277663] initcall isa_bus_init+0x0/0x3c returned 0 after 0 usecs
[    0.277678] calling  register_node_type+0x0/0x2f @ 1
[    0.277978] initcall register_node_type+0x0/0x2f returned 0 after 0 usecs
[    0.277993] calling  regmap_initcall+0x0/0xd @ 1
[    0.278037] initcall regmap_initcall+0x0/0xd returned 0 after 0 usecs
[    0.278052] calling  sram_init+0x0/0x13 @ 1
[    0.278132] initcall sram_init+0x0/0x13 returned 0 after 0 usecs
[    0.278147] calling  syscon_init+0x0/0x13 @ 1
[    0.278226] initcall syscon_init+0x0/0x13 returned 0 after 0 usecs
[    0.278242] calling  spi_init+0x0/0x97 @ 1
[    0.278369] initcall spi_init+0x0/0x97 returned 0 after 0 usecs
[    0.278385] calling  i2c_init+0x0/0xb4 @ 1
[    0.278591] initcall i2c_init+0x0/0xb4 returned 0 after 0 usecs
[    0.278591] calling  init_ladder+0x0/0x3c @ 1
[    0.278591] cpuidle: using governor ladder
[    0.278591] initcall init_ladder+0x0/0x3c returned 0 after 0 usecs
[    0.278591] calling  init_menu+0x0/0x11 @ 1
[    0.278591] cpuidle: using governor menu
[    0.278591] initcall init_menu+0x0/0x11 returned 0 after 0 usecs
[    0.278591] calling  pcc_init+0x0/0x469 @ 1
[    0.278591] initcall pcc_init+0x0/0x469 returned -19 after 0 usecs
[    0.278591] calling  amd_postcore_init+0x0/0x111 @ 1
[    0.278591] initcall amd_postcore_init+0x0/0x111 returned 0 after 0 usecs
[    0.278591] calling  kobject_uevent_init+0x0/0xc @ 1
[    0.278591] initcall kobject_uevent_init+0x0/0xc returned 0 after 0 usecs
[    0.278591] calling  bts_init+0x0/0xef @ 1
[    0.278591] initcall bts_init+0x0/0xef returned -19 after 0 usecs
[    0.278591] calling  pt_init+0x0/0x475 @ 1
[    0.278591] initcall pt_init+0x0/0x475 returned 0 after 0 usecs
[    0.278591] calling  boot_params_ksysfs_init+0x0/0x336 @ 1
[    0.278591] initcall boot_params_ksysfs_init+0x0/0x336 returned 0 after 0 usecs
[    0.278591] calling  sbf_init+0x0/0xcb @ 1
[    0.278591] initcall sbf_init+0x0/0xcb returned 0 after 0 usecs
[    0.278591] calling  arch_kdebugfs_init+0x0/0x24 @ 1
[    0.278591] initcall arch_kdebugfs_init+0x0/0x24 returned 0 after 0 usecs
[    0.278591] calling  mtrr_if_init+0x0/0xc0 @ 1
[    0.278591] initcall mtrr_if_init+0x0/0xc0 returned 0 after 0 usecs
[    0.278591] calling  ffh_cstate_init+0x0/0x44 @ 1
[    0.278591] initcall ffh_cstate_init+0x0/0x44 returned 0 after 0 usecs
[    0.278591] calling  activate_jump_labels+0x0/0x32 @ 1
[    0.278591] initcall activate_jump_labels+0x0/0x32 returned 0 after 0 usecs
[    0.278591] calling  gigantic_pages_init+0x0/0x49 @ 1
[    0.278591] initcall gigantic_pages_init+0x0/0x49 returned 0 after 0 usecs
[    0.278591] calling  kcmp_cookies_init+0x0/0xdf @ 1
[    0.278591] initcall kcmp_cookies_init+0x0/0xdf returned 0 after 0 usecs
[    0.278591] calling  acpi_pci_init+0x0/0x62 @ 1
[    0.278591] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.278591] ACPI: bus type PCI registered
[    0.278591] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.278591] initcall acpi_pci_init+0x0/0x62 returned 0 after 3906 usecs
[    0.278591] calling  dma_bus_init+0x0/0x121 @ 1
[    0.278591] initcall dma_bus_init+0x0/0x121 returned 0 after 0 usecs
[    0.278591] calling  dma_channel_table_init+0x0/0x1a9 @ 1
[    0.278591] initcall dma_channel_table_init+0x0/0x1a9 returned 0 after 0 usecs
[    0.278591] calling  setup_vcpu_hotplug_event+0x0/0x4b @ 1
[    0.278591] initcall setup_vcpu_hotplug_event+0x0/0x4b returned -19 after 0 usecs
[    0.278591] calling  register_xen_pci_notifier+0x0/0x36 @ 1
[    0.278591] initcall register_xen_pci_notifier+0x0/0x36 returned 0 after 0 usecs
[    0.278591] calling  xen_pcpu_init+0x0/0xb4 @ 1
[    0.278591] initcall xen_pcpu_init+0x0/0xb4 returned -19 after 0 usecs
[    0.278591] calling  dmi_id_init+0x0/0x7f9 @ 1
[    0.278591] initcall dmi_id_init+0x0/0x7f9 returned 0 after 0 usecs
[    0.278591] calling  numachip_timer_init+0x0/0x54 @ 1
[    0.278591] initcall numachip_timer_init+0x0/0x54 returned -19 after 0 usecs
[    0.278591] calling  pci_arch_init+0x0/0x66 @ 1
[    0.278591] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.278591] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.278591] PCI: Using configuration type 1 for base access
[    0.278591] initcall pci_arch_init+0x0/0x66 returned 0 after 0 usecs
[    0.278591] calling  init_vdso+0x0/0x40 @ 1
[    0.280005] initcall init_vdso+0x0/0x40 returned 0 after 0 usecs
[    0.280005] calling  sysenter_setup+0x0/0x14 @ 1
[    0.280005] initcall sysenter_setup+0x0/0x14 returned 0 after 0 usecs
[    0.280005] calling  fixup_ht_bug+0x0/0xa2 @ 1
[    0.280005] initcall fixup_ht_bug+0x0/0xa2 returned 0 after 0 usecs
[    0.280005] calling  topology_init+0x0/0xc8 @ 1
[    0.288804] initcall topology_init+0x0/0xc8 returned 0 after 7812 usecs
[    0.288820] calling  mtrr_init_finialize+0x0/0x57 @ 1
[    0.288837] initcall mtrr_init_finialize+0x0/0x57 returned 0 after 0 usecs
[    0.288852] calling  uid_cache_init+0x0/0x10f @ 1
[    0.288883] initcall uid_cache_init+0x0/0x10f returned 0 after 0 usecs
[    0.288898] calling  param_sysfs_init+0x0/0x220 @ 1
[    0.314791] initcall param_sysfs_init+0x0/0x220 returned 0 after 27343 usecs
[    0.314806] calling  user_namespace_sysctl_init+0x0/0x4c @ 1
[    0.314858] initcall user_namespace_sysctl_init+0x0/0x4c returned 0 after 0 usecs
[    0.314873] calling  proc_schedstat_init+0x0/0x1f @ 1
[    0.314896] initcall proc_schedstat_init+0x0/0x1f returned 0 after 0 usecs
[    0.314911] calling  pm_sysrq_init+0x0/0x19 @ 1
[    0.314963] initcall pm_sysrq_init+0x0/0x19 returned 0 after 0 usecs
[    0.314979] calling  create_proc_profile+0x0/0xd0 @ 1
[    0.314995] initcall create_proc_profile+0x0/0xd0 returned 0 after 0 usecs
[    0.315011] calling  crash_save_vmcoreinfo_init+0x0/0x5c3 @ 1
[    0.315085] initcall crash_save_vmcoreinfo_init+0x0/0x5c3 returned 0 after 0 usecs
[    0.315101] calling  crash_notes_memory_init+0x0/0x36 @ 1
[    0.315128] initcall crash_notes_memory_init+0x0/0x36 returned 0 after 0 usecs
[    0.315143] calling  cgroup_sysfs_init+0x0/0x18 @ 1
[    0.315192] initcall cgroup_sysfs_init+0x0/0x18 returned 0 after 0 usecs
[    0.315208] calling  cgroup_namespaces_init+0x0/0x8 @ 1
[    0.315224] initcall cgroup_namespaces_init+0x0/0x8 returned 0 after 0 usecs
[    0.315240] calling  user_namespaces_init+0x0/0x2d @ 1
[    0.315272] initcall user_namespaces_init+0x0/0x2d returned 0 after 0 usecs
[    0.315287] calling  hung_task_init+0x0/0x4f @ 1
[    0.316026] initcall hung_task_init+0x0/0x4f returned 0 after 0 usecs
[    0.316044] calling  dev_map_init+0x0/0x14 @ 1
[    0.316065] initcall dev_map_init+0x0/0x14 returned 0 after 0 usecs
[    0.316080] calling  bpf_offload_init+0x0/0x14 @ 1
[    0.316100] initcall bpf_offload_init+0x0/0x14 returned 0 after 0 usecs
[    0.316115] calling  oom_init+0x0/0x30 @ 1
[    0.316150] initcall oom_init+0x0/0x30 returned 0 after 0 usecs
[    0.316150] calling  default_bdi_init+0x0/0x3b @ 1
[    0.316365] initcall default_bdi_init+0x0/0x3b returned 0 after 0 usecs
[    0.316380] calling  percpu_enable_async+0x0/0xf @ 1
[    0.316397] initcall percpu_enable_async+0x0/0xf returned 0 after 0 usecs
[    0.316416] calling  kcompactd_init+0x0/0x90 @ 1
[    0.316416] initcall kcompactd_init+0x0/0x90 returned 0 after 0 usecs
[    0.316416] calling  init_reserve_notifier+0x0/0x1f @ 1
[    0.316416] initcall init_reserve_notifier+0x0/0x1f returned 0 after 0 usecs
[    0.316416] calling  init_admin_reserve+0x0/0x60 @ 1
[    0.316416] initcall init_admin_reserve+0x0/0x60 returned 0 after 0 usecs
[    0.316416] calling  init_user_reserve+0x0/0x60 @ 1
[    0.316416] initcall init_user_reserve+0x0/0x60 returned 0 after 0 usecs
[    0.316416] calling  swap_init_sysfs+0x0/0x63 @ 1
[    0.316416] initcall swap_init_sysfs+0x0/0x63 returned 0 after 0 usecs
[    0.316416] calling  swapfile_init+0x0/0x101 @ 1
[    0.316416] initcall swapfile_init+0x0/0x101 returned 0 after 0 usecs
[    0.316416] calling  hugetlb_init+0x0/0x62c @ 1
[    0.316416] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.316416] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.316627] initcall hugetlb_init+0x0/0x62c returned 0 after 0 usecs
[    0.316642] calling  ksm_init+0x0/0x197 @ 1
[    0.320202] initcall ksm_init+0x0/0x197 returned 0 after 3906 usecs
[    0.320217] calling  hugepage_init+0x0/0x19f @ 1
[    0.320445] initcall hugepage_init+0x0/0x19f returned 0 after 0 usecs
[    0.320445] calling  mem_cgroup_swap_init+0x0/0x52 @ 1
[    0.320445] initcall mem_cgroup_swap_init+0x0/0x52 returned 0 after 0 usecs
[    0.320445] calling  mem_cgroup_init+0x0/0x354 @ 1
[    0.320445] initcall mem_cgroup_init+0x0/0x354 returned 0 after 0 usecs
[    0.320445] calling  page_idle_init+0x0/0x2f @ 1
[    0.320445] initcall page_idle_init+0x0/0x2f returned 0 after 0 usecs
[    0.320445] calling  sel_ib_pkey_init+0x0/0x109 @ 1
[    0.320445] initcall sel_ib_pkey_init+0x0/0x109 returned 0 after 0 usecs
[    0.320445] calling  crypto_wq_init+0x0/0x31 @ 1
[    0.320445] initcall crypto_wq_init+0x0/0x31 returned 0 after 0 usecs
[    0.320445] calling  cryptomgr_init+0x0/0x11 @ 1
[    0.320445] initcall cryptomgr_init+0x0/0x11 returned 0 after 0 usecs
[    0.320445] calling  init_bio+0x0/0x1d6 @ 1
[    0.320445] initcall init_bio+0x0/0x1d6 returned 0 after 0 usecs
[    0.320445] calling  blk_settings_init+0x0/0x2a @ 1
[    0.320445] initcall blk_settings_init+0x0/0x2a returned 0 after 0 usecs
[    0.320445] calling  blk_ioc_init+0x0/0x2a @ 1
[    0.320445] initcall blk_ioc_init+0x0/0x2a returned 0 after 0 usecs
[    0.320445] calling  blk_softirq_init+0x0/0x129 @ 1
[    0.320445] initcall blk_softirq_init+0x0/0x129 returned 0 after 0 usecs
[    0.320445] calling  blk_mq_init+0x0/0x2a @ 1
[    0.320445] initcall blk_mq_init+0x0/0x2a returned 0 after 0 usecs
[    0.320445] calling  genhd_device_init+0x0/0x76 @ 1
[    0.320480] initcall genhd_device_init+0x0/0x76 returned 0 after 0 usecs
[    0.320480] calling  irq_poll_setup+0x0/0x124 @ 1
[    0.320480] initcall irq_poll_setup+0x0/0x124 returned 0 after 0 usecs
[    0.320480] calling  sx150x_init+0x0/0x13 @ 1
[    0.320480] initcall sx150x_init+0x0/0x13 returned 0 after 0 usecs
[    0.320480] calling  byt_gpio_init+0x0/0x13 @ 1
[    0.320532] initcall byt_gpio_init+0x0/0x13 returned 0 after 0 usecs
[    0.320547] calling  gpiolib_debugfs_init+0x0/0x24 @ 1
[    0.320590] initcall gpiolib_debugfs_init+0x0/0x24 returned 0 after 0 usecs
[    0.320606] calling  lp_gpio_init+0x0/0x13 @ 1
[    0.320686] initcall lp_gpio_init+0x0/0x13 returned 0 after 0 usecs
[    0.320702] calling  rc5t583_gpio_init+0x0/0x13 @ 1
[    0.320782] initcall rc5t583_gpio_init+0x0/0x13 returned 0 after 0 usecs
[    0.320797] calling  palmas_gpio_init+0x0/0x13 @ 1
[    0.320877] initcall palmas_gpio_init+0x0/0x13 returned 0 after 0 usecs
[    0.320892] calling  tps6586x_gpio_init+0x0/0x13 @ 1
[    0.320973] initcall tps6586x_gpio_init+0x0/0x13 returned 0 after 0 usecs
[    0.320988] calling  tps65910_gpio_init+0x0/0x13 @ 1
[    0.321068] initcall tps65910_gpio_init+0x0/0x13 returned 0 after 0 usecs
[    0.321084] calling  pwm_debugfs_init+0x0/0x24 @ 1
[    0.321126] initcall pwm_debugfs_init+0x0/0x24 returned 0 after 0 usecs
[    0.321142] calling  pwm_sysfs_init+0x0/0x18 @ 1
[    0.321294] initcall pwm_sysfs_init+0x0/0x18 returned 0 after 0 usecs
[    0.321310] calling  pci_slot_init+0x0/0x50 @ 1
[    0.321342] initcall pci_slot_init+0x0/0x50 returned 0 after 0 usecs
[    0.321357] calling  fbmem_init+0x0/0xd5 @ 1
[    0.321431] initcall fbmem_init+0x0/0xd5 returned 0 after 0 usecs
[    0.321431] calling  scan_for_dmi_ipmi+0x0/0x1a2 @ 1
[    0.321431] initcall scan_for_dmi_ipmi+0x0/0x1a2 returned 0 after 0 usecs
[    0.321431] calling  acpi_init+0x0/0x3a0 @ 1
[    0.321431] ACPI: Added _OSI(Module Device)
[    0.321431] ACPI: Added _OSI(Processor Device)
[    0.321431] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.321431] ACPI: Added _OSI(Processor Aggregator Device)
[    0.339039] ACPI: Executed 26 blocks of module-level executable AML code
[    0.713196] ACPI: Dynamic OEM Table Load:
[    0.713209] ACPI: SSDT 0xFFFF93DC6C1F4000 0006F6 (v02 PmRef  Cpu0Ist  00003000 INTL 20160422)
[    0.713461] ACPI: Executed 1 blocks of module-level executable AML code
[    0.713888] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    0.734635] ACPI: Dynamic OEM Table Load:
[    0.734646] ACPI: SSDT 0xFFFF93DC4B6EF000 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160422)
[    0.734864] ACPI: Executed 1 blocks of module-level executable AML code
[    0.738833] ACPI: Dynamic OEM Table Load:
[    0.738844] ACPI: SSDT 0xFFFF93DC6C1F1800 00065C (v02 PmRef  ApIst    00003000 INTL 20160422)
[    0.739589] ACPI: Executed 1 blocks of module-level executable AML code
[    0.740633] ACPI: Dynamic OEM Table Load:
[    0.740643] ACPI: SSDT 0xFFFF93DC4B5DD600 00018A (v02 PmRef  ApCst    00003000 INTL 20160422)
[    0.740868] ACPI: Executed 1 blocks of module-level executable AML code
[    0.766852] ACPI: EC: EC started
[    0.766865] ACPI: EC: interrupt blocked
[    0.773894] ACPI: \_SB_.PCI0.LPCB.EC__: Used as first EC
[    0.773916] ACPI: \_SB_.PCI0.LPCB.EC__: GPE=0x50, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.773938] ACPI: \_SB_.PCI0.LPCB.EC__: Used as boot DSDT EC to handle transactions
[    0.773951] ACPI: Interpreter enabled
[    0.774463] ACPI: (supports S0 S3 S4 S5)
[    0.774477] ACPI: Using IOAPIC for interrupt routing
[    0.775003] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.788542] ================================================================================
[    0.788605] UBSAN: Undefined behaviour in drivers/acpi/sysfs.c:849:33
[    0.788655] shift exponent 64 is too large for 64-bit type 'long long unsigned int'
[    0.788713] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc9+ #18
[    0.788725] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 07/07/2017
[    0.788738] Call Trace:
[    0.788768]  ? ftrace_graph_caller+0x98/0x98
[    0.788784]  dump_stack+0x70/0xae
[    0.788820]  ubsan_epilogue+0x9/0x40
[    0.788842]  __ubsan_handle_shift_out_of_bounds+0x12b/0x170
[    0.788869]  ? ftrace_graph_caller+0x68/0x98
[    0.788950]  ? acpi_gpe_apply_masked_gpes+0x50/0xa9
[    0.788970]  acpi_gpe_apply_masked_gpes+0x50/0xa9
[    0.789005]  ? ftrace_graph_caller+0x98/0x98
[    0.789020]  acpi_scan_init+0x145/0x2e4
[    0.789042]  ? acpi_sleep_proc_init+0x24/0x24
[    0.789070]  ? acpi_sleep_proc_init+0x24/0x24
[    0.789086]  ? ftrace_graph_caller+0x98/0x98
[    0.789101]  acpi_init+0x340/0x3a0
[    0.789159]  ? ftrace_graph_caller+0x98/0x98
[    0.789175]  do_one_initcall+0x173/0x200
[    0.789212]  ? acpi_sleep_proc_init+0x24/0x24
[    0.789233]  ? do_one_initcall+0x5/0x200
[    0.789274]  ? ftrace_graph_caller+0x98/0x98
[    0.789289]  kernel_init_freeable+0x305/0x395
[    0.789315]  ? rest_init+0xd0/0xd0
[    0.789352]  kernel_init+0xb/0x120
[    0.789369]  ? rest_init+0xd0/0xd0
[    0.789386]  ret_from_fork+0x35/0x40
[    0.789482] ================================================================================
[    0.789687] ACPI: Enabled 6 GPEs in block 00 to 7F
[    1.000550] ACPI Error: [_OSI] Namespace lookup failure, AE_NOT_FOUND (20170831/psargs-364)
[    1.000563] ACPI Error: Method parse/execution failed \_SB.PAGD._STA, AE_NOT_FOUND (20170831/psparse-550)
[    1.000828] ACPI Error: [_OSI] Namespace lookup failure, AE_NOT_FOUND (20170831/psargs-364)
[    1.000836] ACPI Error: Method parse/execution failed \_SB.PAGD._STA, AE_NOT_FOUND (20170831/psparse-550)
[    1.068175] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    1.068201] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    1.068401] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    1.069594] PCI host bridge to bus 0000:00
[    1.069600] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.069605] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.069610] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.069614] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
[    1.069619] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    1.069623] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
[    1.069628] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
[    1.069632] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    1.069637] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    1.069641] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    1.069646] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    1.069650] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
[    1.069655] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
[    1.069659] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
[    1.069664] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
[    1.069669] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fffff window]
[    1.069673] pci_bus 0000:00: root bus resource [mem 0x8ac00000-0xdfffffff window]
[    1.069678] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    1.069684] pci_bus 0000:00: root bus resource [bus 00-fe]
[    1.069698] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000
[    1.069923] pci 0000:00:02.0: [8086:5916] type 00 class 0x030000
[    1.069936] pci 0000:00:02.0: reg 0x10: [mem 0xde000000-0xdeffffff 64bit]
[    1.069942] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit pref]
[    1.069947] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    1.070230] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
[    1.070243] pci 0000:00:08.0: reg 0x10: [mem 0xdf42f000-0xdf42ffff 64bit]
[    1.070504] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    1.070528] pci 0000:00:14.0: reg 0x10: [mem 0xdf410000-0xdf41ffff 64bit]
[    1.070599] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    1.070959] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    1.070980] pci 0000:00:14.2: reg 0x10: [mem 0xdf42e000-0xdf42efff 64bit]
[    1.071244] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    1.071264] pci 0000:00:16.0: reg 0x10: [mem 0xdf42d000-0xdf42dfff 64bit]
[    1.071319] pci 0000:00:16.0: PME# supported from D3hot
[    1.071607] pci 0000:00:17.0: [8086:9d03] type 00 class 0x010601
[    1.071628] pci 0000:00:17.0: reg 0x10: [mem 0xdf428000-0xdf429fff]
[    1.071637] pci 0000:00:17.0: reg 0x14: [mem 0xdf42c000-0xdf42c0ff]
[    1.071646] pci 0000:00:17.0: reg 0x18: [io  0xf090-0xf097]
[    1.071655] pci 0000:00:17.0: reg 0x1c: [io  0xf080-0xf083]
[    1.071664] pci 0000:00:17.0: reg 0x20: [io  0xf060-0xf07f]
[    1.071673] pci 0000:00:17.0: reg 0x24: [mem 0xdf42b000-0xdf42b7ff]
[    1.071718] pci 0000:00:17.0: PME# supported from D3hot
[    1.071996] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    1.072067] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.072388] pci 0000:00:1c.2: [8086:9d12] type 01 class 0x060400
[    1.072459] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    1.072780] pci 0000:00:1c.5: [8086:9d15] type 01 class 0x060400
[    1.072848] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    1.073171] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
[    1.073239] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.073588] pci 0000:00:1f.0: [8086:9d58] type 00 class 0x060100
[    1.073943] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    1.073958] pci 0000:00:1f.2: reg 0x10: [mem 0xdf424000-0xdf427fff]
[    1.074243] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
[    1.074271] pci 0000:00:1f.3: reg 0x10: [mem 0xdf420000-0xdf423fff 64bit]
[    1.074296] pci 0000:00:1f.3: reg 0x20: [mem 0xdf400000-0xdf40ffff 64bit]
[    1.074348] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    1.074684] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    1.074745] pci 0000:00:1f.4: reg 0x10: [mem 0xdf42a000-0xdf42a0ff 64bit]
[    1.074814] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
[    1.075270] pci 0000:01:00.0: [1b21:1242] type 00 class 0x0c0330
[    1.075305] pci 0000:01:00.0: reg 0x10: [mem 0xdf300000-0xdf307fff 64bit]
[    1.075363] pci 0000:01:00.0: enabling Extended Tags
[    1.075439] pci 0000:01:00.0: PME# supported from D3hot D3cold
[    1.084025] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.084030] pci 0000:00:1c.0:   bridge window [mem 0xdf300000-0xdf3fffff]
[    1.084205] pci 0000:02:00.0: [8086:24f3] type 00 class 0x028000
[    1.084266] pci 0000:02:00.0: reg 0x10: [mem 0xdf200000-0xdf201fff 64bit]
[    1.084455] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    1.096050] pci 0000:00:1c.2: PCI bridge to [bus 02]
[    1.096055] pci 0000:00:1c.2:   bridge window [mem 0xdf200000-0xdf2fffff]
[    1.096203] pci 0000:03:00.0: [10ec:5287] type 00 class 0xff0000
[    1.096232] pci 0000:03:00.0: reg 0x10: [mem 0xdf115000-0xdf115fff]
[    1.096277] pci 0000:03:00.0: reg 0x30: [mem 0xdf100000-0xdf10ffff pref]
[    1.096367] pci 0000:03:00.0: supports D1 D2
[    1.096369] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    1.096495] pci 0000:03:00.1: [10ec:8168] type 00 class 0x020000
[    1.096522] pci 0000:03:00.1: reg 0x10: [io  0xe000-0xe0ff]
[    1.096544] pci 0000:03:00.1: reg 0x18: [mem 0xdf114000-0xdf114fff 64bit]
[    1.096559] pci 0000:03:00.1: reg 0x20: [mem 0xdf110000-0xdf113fff 64bit]
[    1.096651] pci 0000:03:00.1: supports D1 D2
[    1.096653] pci 0000:03:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    1.108033] pci 0000:00:1c.5: PCI bridge to [bus 03]
[    1.108036] pci 0000:00:1c.5:   bridge window [io  0xe000-0xefff]
[    1.108039] pci 0000:00:1c.5:   bridge window [mem 0xdf100000-0xdf1fffff]
[    1.108173] pci 0000:04:00.0: [144d:a804] type 00 class 0x010802
[    1.108203] pci 0000:04:00.0: reg 0x10: [mem 0xdf000000-0xdf003fff 64bit]
[    1.120024] pci 0000:00:1d.0: PCI bridge to [bus 04]
[    1.120029] pci 0000:00:1d.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[    1.130020] ACPI Error: [_OSI] Namespace lookup failure, AE_NOT_FOUND (20170831/psargs-364)
[    1.130033] ACPI Error: Method parse/execution failed \_SB.PAGD._STA, AE_NOT_FOUND (20170831/psparse-550)
[    1.130629] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.131356] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    1.132089] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.132811] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.133533] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.134256] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.134976] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.135699] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.140557] ACPI: EC: interrupt unblocked
[    1.140574] ACPI: EC: event unblocked
[    1.140617] ACPI: \_SB_.PCI0.LPCB.EC__: GPE=0x50, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    1.140620] ACPI: \_SB_.PCI0.LPCB.EC__: Used as boot DSDT EC to handle transactions and events
[    1.141062] initcall acpi_init+0x0/0x3a0 returned 0 after 800781 usecs
[    1.141078] calling  pnp_init+0x0/0x11 @ 1
[    1.141182] initcall pnp_init+0x0/0x11 returned 0 after 0 usecs
[    1.141197] calling  balloon_init+0x0/0x2ce @ 1
[    1.141214] initcall balloon_init+0x0/0x2ce returned -19 after 0 usecs
[    1.141231] calling  xen_setup_shutdown_event+0x0/0x30 @ 1
[    1.141248] initcall xen_setup_shutdown_event+0x0/0x30 returned -19 after 0 usecs
[    1.141263] calling  xenbus_probe_backend_init+0x0/0x4e @ 1
[    1.141368] initcall xenbus_probe_backend_init+0x0/0x4e returned 0 after 0 usecs
[    1.141384] calling  xenbus_probe_frontend_init+0x0/0x4e @ 1
[    1.141488] initcall xenbus_probe_frontend_init+0x0/0x4e returned 0 after 0 usecs
[    1.141503] calling  xen_acpi_pad_init+0x0/0x45 @ 1
[    1.141520] initcall xen_acpi_pad_init+0x0/0x45 returned -19 after 0 usecs
[    1.141536] calling  misc_init+0x0/0xca @ 1
[    1.141598] initcall misc_init+0x0/0xca returned 0 after 0 usecs
[    1.141613] calling  tpm_init+0x0/0xd1 @ 1
[    1.141684] initcall tpm_init+0x0/0xd1 returned 0 after 0 usecs
[    1.141699] calling  vga_arb_device_init+0x0/0x338 @ 1
[    1.141978] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    1.141978] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.141978] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.141978] vgaarb: loaded
[    1.141978] initcall vga_arb_device_init+0x0/0x338 returned 0 after 0 usecs
[    1.141978] calling  cn_init+0x0/0xe0 @ 1
[    1.141978] initcall cn_init+0x0/0xe0 returned 0 after 0 usecs
[    1.141978] calling  pm860x_i2c_init+0x0/0x2c @ 1
[    1.141978] initcall pm860x_i2c_init+0x0/0x2c returned 0 after 0 usecs
[    1.141978] calling  wm8400_module_init+0x0/0x2c @ 1
[    1.141978] initcall wm8400_module_init+0x0/0x2c returned 0 after 0 usecs
[    1.141978] calling  wm831x_i2c_init+0x0/0x2c @ 1
[    1.141978] initcall wm831x_i2c_init+0x0/0x2c returned 0 after 0 usecs
[    1.141978] calling  wm831x_spi_init+0x0/0x28 @ 1
[    1.141978] initcall wm831x_spi_init+0x0/0x28 returned 0 after 0 usecs
[    1.141978] calling  wm8350_i2c_init+0x0/0x13 @ 1
[    1.141978] initcall wm8350_i2c_init+0x0/0x13 returned 0 after 0 usecs
[    1.141978] calling  tps65910_i2c_init+0x0/0x13 @ 1
[    1.141978] initcall tps65910_i2c_init+0x0/0x13 returned 0 after 0 usecs
[    1.141978] calling  tps80031_init+0x0/0x13 @ 1
[    1.141978] initcall tps80031_init+0x0/0x13 returned 0 after 0 usecs
[    1.141978] calling  ezx_pcap_init+0x0/0x13 @ 1
[    1.141978] initcall ezx_pcap_init+0x0/0x13 returned 0 after 0 usecs
[    1.141978] calling  da903x_init+0x0/0x13 @ 1
[    1.141978] initcall da903x_init+0x0/0x13 returned 0 after 0 usecs
[    1.141978] calling  da9052_spi_init+0x0/0x2c @ 1
[    1.141978] initcall da9052_spi_init+0x0/0x2c returned 0 after 0 usecs
[    1.141978] calling  da9052_i2c_init+0x0/0x2c @ 1
[    1.141978] initcall da9052_i2c_init+0x0/0x2c returned 0 after 0 usecs
[    1.141978] calling  lp8788_init+0x0/0x13 @ 1
[    1.141978] initcall lp8788_init+0x0/0x13 returned 0 after 0 usecs
[    1.141978] calling  da9055_i2c_init+0x0/0x2c @ 1
[    1.141978] initcall da9055_i2c_init+0x0/0x2c returned 0 after 0 usecs
[    1.141978] calling  max77843_i2c_init+0x0/0x13 @ 1
[    1.141978] initcall max77843_i2c_init+0x0/0x13 returned 0 after 0 usecs
[    1.141978] calling  max8925_i2c_init+0x0/0x2c @ 1
[    1.141978] initcall max8925_i2c_init+0x0/0x2c returned 0 after 0 usecs
[    1.141978] calling  max8997_i2c_init+0x0/0x13 @ 1
[    1.141978] initcall max8997_i2c_init+0x0/0x13 returned 0 after 0 usecs
[    1.141978] calling  max8998_i2c_init+0x0/0x13 @ 1
[    1.141978] initcall max8998_i2c_init+0x0/0x13 returned 0 after 0 usecs
[    1.141978] calling  ab3100_i2c_init+0x0/0x13 @ 1
[    1.141978] initcall ab3100_i2c_init+0x0/0x13 returned 0 after 0 usecs
[    1.141978] calling  tps6586x_init+0x0/0x13 @ 1
[    1.144034] initcall tps6586x_init+0x0/0x13 returned 0 after 0 usecs
[    1.144049] calling  tps65090_init+0x0/0x13 @ 1
[    1.144129] initcall tps65090_init+0x0/0x13 returned 0 after 0 usecs
[    1.144145] calling  aat2870_init+0x0/0x13 @ 1
[    1.144243] initcall aat2870_init+0x0/0x13 returned 0 after 0 usecs
[    1.144259] calling  palmas_i2c_init+0x0/0x13 @ 1
[    1.144339] initcall palmas_i2c_init+0x0/0x13 returned 0 after 0 usecs
[    1.144354] calling  rc5t583_i2c_init+0x0/0x13 @ 1
[    1.144434] initcall rc5t583_i2c_init+0x0/0x13 returned 0 after 0 usecs
[    1.144449] calling  sec_pmic_init+0x0/0x13 @ 1
[    1.144530] initcall sec_pmic_init+0x0/0x13 returned 0 after 0 usecs
[    1.144545] calling  as3711_i2c_init+0x0/0x13 @ 1
[    1.144625] initcall as3711_i2c_init+0x0/0x13 returned 0 after 0 usecs
[    1.144640] calling  libnvdimm_init+0x0/0x3c @ 1
[    1.144976] initcall libnvdimm_init+0x0/0x3c returned 0 after 0 usecs
[    1.144991] calling  dax_fs_init+0x0/0xd3 @ 1
[    1.145153] initcall dax_fs_init+0x0/0xd3 returned 0 after 0 usecs
[    1.145169] calling  dma_buf_init+0x0/0xdb @ 1
[    1.145239] initcall dma_buf_init+0x0/0xdb returned 0 after 0 usecs
[    1.145254] calling  init_scsi+0x0/0xa5 @ 1
[    1.146148] SCSI subsystem initialized
[    1.146164] initcall init_scsi+0x0/0xa5 returned 0 after 0 usecs
[    1.146179] calling  ata_init+0x0/0x41d @ 1
[    1.146326] libata version 3.00 loaded.
[    1.146326] initcall ata_init+0x0/0x41d returned 0 after 0 usecs
[    1.146326] calling  phy_init+0x0/0x4e @ 1
[    1.146326] initcall phy_init+0x0/0x4e returned 0 after 0 usecs
[    1.146326] calling  usb_init+0x0/0x178 @ 1
[    1.146326] ACPI: bus type USB registered
[    1.146326] usbcore: registered new interface driver usbfs
[    1.146326] usbcore: registered new interface driver hub
[    1.146326] usbcore: registered new device driver usb
[    1.146326] initcall usb_init+0x0/0x178 returned 0 after 0 usecs
[    1.146326] calling  serio_init+0x0/0x2a @ 1
[    1.146326] initcall serio_init+0x0/0x2a returned 0 after 0 usecs
[    1.146326] calling  input_init+0x0/0xfd @ 1
[    1.146326] initcall input_init+0x0/0xfd returned 0 after 0 usecs
[    1.146326] calling  rtc_init+0x0/0x65 @ 1
[    1.146326] initcall rtc_init+0x0/0x65 returned 0 after 0 usecs
[    1.146326] calling  dw_i2c_init_driver+0x0/0x13 @ 1
[    1.146326] initcall dw_i2c_init_driver+0x0/0x13 returned 0 after 0 usecs
[    1.146326] calling  power_supply_class_init+0x0/0x58 @ 1
[    1.146326] initcall power_supply_class_init+0x0/0x58 returned 0 after 3906 usecs
[    1.146326] calling  hwmon_init+0x0/0xf9 @ 1
[    1.148185] initcall hwmon_init+0x0/0xf9 returned 0 after 0 usecs
[    1.148200] calling  md_init+0x0/0x161 @ 1
[    1.148353] initcall md_init+0x0/0x161 returned 0 after 0 usecs
[    1.148353] calling  edac_init+0x0/0x70 @ 1
[    1.148353] EDAC MC: Ver: 3.0.0
[    1.148985] initcall edac_init+0x0/0x70 returned 0 after 0 usecs
[    1.148985] calling  mmc_init+0x0/0x35 @ 1
[    1.148985] initcall mmc_init+0x0/0x35 returned 0 after 0 usecs
[    1.148985] calling  leds_init+0x0/0x54 @ 1
[    1.148985] initcall leds_init+0x0/0x54 returned 0 after 0 usecs
[    1.148985] calling  dmi_init+0x0/0x114 @ 1
[    1.148985] initcall dmi_init+0x0/0x114 returned 0 after 0 usecs
[    1.148985] calling  efisubsys_init+0x0/0x328 @ 1
[    1.148985] Registered efivars operations
[    1.165194] initcall efisubsys_init+0x0/0x328 returned 0 after 15625 usecs
[    1.165210] calling  devfreq_init+0x0/0xbb @ 1
[    1.165332] initcall devfreq_init+0x0/0xbb returned 0 after 0 usecs
[    1.165332] calling  devfreq_event_init+0x0/0x67 @ 1
[    1.165332] initcall devfreq_event_init+0x0/0x67 returned 0 after 0 usecs
[    1.165332] calling  devfreq_simple_ondemand_init+0x0/0x11 @ 1
[    1.165332] initcall devfreq_simple_ondemand_init+0x0/0x11 returned 0 after 0 usecs
[    1.165332] calling  devfreq_performance_init+0x0/0x11 @ 1
[    1.165332] initcall devfreq_performance_init+0x0/0x11 returned 0 after 0 usecs
[    1.165332] calling  devfreq_powersave_init+0x0/0x11 @ 1
[    1.165332] initcall devfreq_powersave_init+0x0/0x11 returned 0 after 0 usecs
[    1.165332] calling  devfreq_userspace_init+0x0/0x11 @ 1
[    1.165332] initcall devfreq_userspace_init+0x0/0x11 returned 0 after 0 usecs
[    1.165332] calling  devfreq_passive_init+0x0/0x11 @ 1
[    1.165332] initcall devfreq_passive_init+0x0/0x11 returned 0 after 0 usecs
[    1.165332] calling  vme_init+0x0/0x11 @ 1
[    1.165332] initcall vme_init+0x0/0x11 returned 0 after 0 usecs
[    1.165332] calling  ras_init+0x0/0xf @ 1
[    1.165332] initcall ras_init+0x0/0xf returned 0 after 0 usecs
[    1.165332] calling  nvmem_init+0x0/0x11 @ 1
[    1.165332] initcall nvmem_init+0x0/0x11 returned 0 after 0 usecs
[    1.165332] calling  pci_subsys_init+0x0/0x88 @ 1
[    1.165332] PCI: Using ACPI for IRQ routing
[    1.199416] PCI: pci_cache_line_size set to 64 bytes
[    1.199878] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    1.199894] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    1.199910] e820: reserve RAM buffer [mem 0x7a4f1000-0x7bffffff]
[    1.199926] e820: reserve RAM buffer [mem 0x7eb4a000-0x7fffffff]
[    1.199944] e820: reserve RAM buffer [mem 0x7f593000-0x7fffffff]
[    1.199961] e820: reserve RAM buffer [mem 0x874400000-0x877ffffff]
[    1.199983] initcall pci_subsys_init+0x0/0x88 returned 0 after 35156 usecs
[    1.199999] calling  proto_init+0x0/0x11 @ 1
[    1.200020] initcall proto_init+0x0/0x11 returned 0 after 0 usecs
[    1.200036] calling  net_dev_init+0x0/0x386 @ 1
[    1.200562] initcall net_dev_init+0x0/0x386 returned 0 after 0 usecs
[    1.200577] calling  neigh_init+0x0/0x80 @ 1
[    1.200598] initcall neigh_init+0x0/0x80 returned 0 after 0 usecs
[    1.200614] calling  fib_notifier_init+0x0/0x11 @ 1
[    1.200634] initcall fib_notifier_init+0x0/0x11 returned 0 after 0 usecs
[    1.200649] calling  fib_rules_init+0x0/0xac @ 1
[    1.200677] initcall fib_rules_init+0x0/0xac returned 0 after 0 usecs
[    1.200693] calling  init_cgroup_netprio+0x0/0x14 @ 1
[    1.200714] initcall init_cgroup_netprio+0x0/0x14 returned 0 after 0 usecs
[    1.200730] calling  bpf_lwt_init+0x0/0x16 @ 1
[    1.200747] initcall bpf_lwt_init+0x0/0x16 returned 0 after 0 usecs
[    1.200763] calling  pktsched_init+0x0/0x10f @ 1
[    1.200800] initcall pktsched_init+0x0/0x10f returned 0 after 0 usecs
[    1.200815] calling  tc_filter_init+0x0/0x83 @ 1
[    1.200879] initcall tc_filter_init+0x0/0x83 returned 0 after 0 usecs
[    1.200895] calling  tc_action_init+0x0/0x69 @ 1
[    1.200925] initcall tc_action_init+0x0/0x69 returned 0 after 0 usecs
[    1.200940] calling  genl_init+0x0/0x36 @ 1
[    1.201000] initcall genl_init+0x0/0x36 returned 0 after 0 usecs
[    1.201015] calling  ipv4_netfilter_init+0x0/0x11 @ 1
[    1.201033] initcall ipv4_netfilter_init+0x0/0x11 returned 0 after 0 usecs
[    1.201048] calling  cipso_v4_init+0x0/0xcf @ 1
[    1.201066] initcall cipso_v4_init+0x0/0xcf returned 0 after 0 usecs
[    1.201082] calling  wireless_nlevent_init+0x0/0x3c @ 1
[    1.201108] initcall wireless_nlevent_init+0x0/0x3c returned 0 after 0 usecs
[    1.201123] calling  netlbl_init+0x0/0x79 @ 1
[    1.201136] NetLabel: Initializing
[    1.201147] NetLabel:  domain hash size = 128
[    1.201159] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.201335] NetLabel:  unlabeled traffic allowed by default
[    1.201351] initcall netlbl_init+0x0/0x79 returned 0 after 0 usecs
[    1.201366] calling  rfkill_init+0x0/0x16a @ 1
[    1.201643] initcall rfkill_init+0x0/0x16a returned 0 after 0 usecs
[    1.201643] calling  xen_mcfg_late+0x0/0x115 @ 1
[    1.201643] initcall xen_mcfg_late+0x0/0x115 returned 0 after 0 usecs
[    1.201643] calling  watchdog_init+0x0/0x103 @ 1
[    1.201643] initcall watchdog_init+0x0/0x103 returned 0 after 0 usecs
[    1.201643] calling  nmi_warning_debugfs+0x0/0x27 @ 1
[    1.201643] initcall nmi_warning_debugfs+0x0/0x27 returned 0 after 0 usecs
[    1.201643] calling  save_microcode_in_initrd+0x0/0xdc @ 1
[    1.201643] initcall save_microcode_in_initrd+0x0/0xdc returned 0 after 0 usecs
[    1.201643] calling  hpet_late_init+0x0/0x169 @ 1
[    1.201643] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.201643] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    1.202583] initcall hpet_late_init+0x0/0x169 returned 0 after 3906 usecs
[    1.202598] calling  init_amd_nbs+0x0/0x157 @ 1
[    1.202708] initcall init_amd_nbs+0x0/0x157 returned 0 after 0 usecs
[    1.202723] calling  sugov_register+0x0/0x11 @ 1
[    1.202742] initcall sugov_register+0x0/0x11 returned 0 after 0 usecs
[    1.202758] calling  clocksource_done_booting+0x0/0x42 @ 1
[    1.204009] clocksource: Switched to clocksource hpet
[    1.204009] initcall clocksource_done_booting+0x0/0x42 returned 0 after 24 usecs
[    1.204009] calling  tracer_init_tracefs+0x0/0x227 @ 1
[    1.210050] initcall tracer_init_tracefs+0x0/0x227 returned 0 after 5844 usecs
[    1.210066] calling  init_trace_printk_function_export+0x0/0x2d @ 1
[    1.210177] initcall init_trace_printk_function_export+0x0/0x2d returned 0 after 90 usecs
[    1.210192] calling  init_graph_tracefs+0x0/0x2d @ 1
[    1.210240] initcall init_graph_tracefs+0x0/0x2d returned 0 after 29 usecs
[    1.210255] calling  event_trace_init+0x0/0x312 @ 1
[    1.483384] initcall event_trace_init+0x0/0x312 returned 0 after 266705 usecs
[    1.483400] calling  init_kprobe_trace+0x0/0x8a @ 1
[    1.483476] initcall init_kprobe_trace+0x0/0x8a returned 0 after 56 usecs
[    1.483491] calling  bpf_init+0x0/0x4a @ 1
[    1.483529] initcall bpf_init+0x0/0x4a returned 0 after 19 usecs
[    1.483544] calling  init_pipe_fs+0x0/0x47 @ 1
[    1.483649] initcall init_pipe_fs+0x0/0x47 returned 0 after 84 usecs
[    1.483664] calling  cgroup_writeback_init+0x0/0x2b @ 1
[    1.483801] initcall cgroup_writeback_init+0x0/0x2b returned 0 after 115 usecs
[    1.483816] calling  inotify_user_setup+0x0/0x48 @ 1
[    1.483866] initcall inotify_user_setup+0x0/0x48 returned 0 after 30 usecs
[    1.483881] calling  eventpoll_init+0x0/0xcf @ 1
[    1.484056] initcall eventpoll_init+0x0/0xcf returned 0 after 152 usecs
[    1.484071] calling  anon_inode_init+0x0/0x73 @ 1
[    1.484179] initcall anon_inode_init+0x0/0x73 returned 0 after 87 usecs
[    1.484194] calling  init_dax_wait_table+0x0/0x40 @ 1
[    1.485859] initcall init_dax_wait_table+0x0/0x40 returned 0 after 1606 usecs
[    1.485874] calling  proc_locks_init+0x0/0x1f @ 1
[    1.485905] initcall proc_locks_init+0x0/0x1f returned 0 after 11 usecs
[    1.485920] calling  dquot_init+0x0/0x1cd @ 1
[    1.485936] VFS: Disk quotas dquot_6.6.0
[    1.486091] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.486114] initcall dquot_init+0x0/0x1cd returned 0 after 171 usecs
[    1.486129] calling  quota_init+0x0/0x24 @ 1
[    1.486212] initcall quota_init+0x0/0x24 returned 0 after 62 usecs
[    1.486227] calling  proc_cmdline_init+0x0/0x1f @ 1
[    1.486256] initcall proc_cmdline_init+0x0/0x1f returned 0 after 10 usecs
[    1.486272] calling  proc_consoles_init+0x0/0x1f @ 1
[    1.486301] initcall proc_consoles_init+0x0/0x1f returned 0 after 10 usecs
[    1.486316] calling  proc_cpuinfo_init+0x0/0x1f @ 1
[    1.486345] initcall proc_cpuinfo_init+0x0/0x1f returned 0 after 10 usecs
[    1.486360] calling  proc_devices_init+0x0/0x1f @ 1
[    1.486389] initcall proc_devices_init+0x0/0x1f returned 0 after 10 usecs
[    1.486404] calling  proc_interrupts_init+0x0/0x1f @ 1
[    1.486433] initcall proc_interrupts_init+0x0/0x1f returned 0 after 10 usecs
[    1.486448] calling  proc_loadavg_init+0x0/0x1f @ 1
[    1.486476] initcall proc_loadavg_init+0x0/0x1f returned 0 after 10 usecs
[    1.486491] calling  proc_meminfo_init+0x0/0x1f @ 1
[    1.486520] initcall proc_meminfo_init+0x0/0x1f returned 0 after 9 usecs
[    1.486535] calling  proc_stat_init+0x0/0x1f @ 1
[    1.486564] initcall proc_stat_init+0x0/0x1f returned 0 after 10 usecs
[    1.486579] calling  proc_uptime_init+0x0/0x1f @ 1
[    1.486608] initcall proc_uptime_init+0x0/0x1f returned 0 after 10 usecs
[    1.486623] calling  proc_version_init+0x0/0x1f @ 1
[    1.486652] initcall proc_version_init+0x0/0x1f returned 0 after 10 usecs
[    1.486667] calling  proc_softirqs_init+0x0/0x1f @ 1
[    1.486696] initcall proc_softirqs_init+0x0/0x1f returned 0 after 10 usecs
[    1.486711] calling  proc_kcore_init+0x0/0x238 @ 1
[    1.486777] initcall proc_kcore_init+0x0/0x238 returned 0 after 45 usecs
[    1.486792] calling  vmcore_init+0x0/0x45c @ 1
[    1.486816] initcall vmcore_init+0x0/0x45c returned 0 after 5 usecs
[    1.486831] calling  proc_kmsg_init+0x0/0x22 @ 1
[    1.486861] initcall proc_kmsg_init+0x0/0x22 returned 0 after 10 usecs
[    1.486876] calling  proc_page_init+0x0/0x56 @ 1
[    1.486917] initcall proc_page_init+0x0/0x56 returned 0 after 22 usecs
[    1.486932] calling  init_ramfs_fs+0x0/0x1f @ 1
[    1.486955] initcall init_ramfs_fs+0x0/0x1f returned 0 after 4 usecs
[    1.486970] calling  init_hugetlbfs_fs+0x0/0x356 @ 1
[    1.487254] initcall init_hugetlbfs_fs+0x0/0x356 returned 0 after 259 usecs
[    1.487269] calling  tomoyo_initerface_init+0x0/0x19e @ 1
[    1.487292] initcall tomoyo_initerface_init+0x0/0x19e returned 0 after 4 usecs
[    1.487307] calling  aa_create_aafs+0x0/0x47b @ 1
[    1.489003] AppArmor: AppArmor Filesystem Enabled
[    1.489022] initcall aa_create_aafs+0x0/0x47b returned 0 after 1655 usecs
[    1.489038] calling  blk_scsi_ioctl_init+0x0/0x38c @ 1
[    1.489061] initcall blk_scsi_ioctl_init+0x0/0x38c returned 0 after 4 usecs
[    1.489076] calling  dynamic_debug_init_debugfs+0x0/0x62 @ 1
[    1.489152] initcall dynamic_debug_init_debugfs+0x0/0x62 returned 0 after 55 usecs
[    1.489167] calling  simplefb_init+0x0/0x13 @ 1
[    1.489296] initcall simplefb_init+0x0/0x13 returned 0 after 108 usecs
[    1.489311] calling  acpi_event_init+0x0/0x2d @ 1
[    1.489388] initcall acpi_event_init+0x0/0x2d returned 0 after 56 usecs
[    1.489403] calling  pnp_system_init+0x0/0x11 @ 1
[    1.489503] initcall pnp_system_init+0x0/0x11 returned 0 after 79 usecs
[    1.489519] calling  pnpacpi_init+0x0/0x6e @ 1
[    1.489534] pnp: PnP ACPI init
[    1.493205] system 00:00: [io  0x0680-0x069f] has been reserved
[    1.493208] system 00:00: [io  0xffff] has been reserved
[    1.493209] system 00:00: [io  0xffff] has been reserved
[    1.493211] system 00:00: [io  0xffff] has been reserved
[    1.493213] system 00:00: [io  0x1800-0x18fe] has been reserved
[    1.493214] system 00:00: [io  0x164e-0x164f] has been reserved
[    1.493216] system 00:00: [io  0x3322-0x3323] has been reserved
[    1.493238] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.494251] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.494982] system 00:02: [io  0x1854-0x1857] has been reserved
[    1.495002] system 00:02: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    1.495370] pnp 00:03: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.497221] pnp 00:04: Plug and Play ACPI device, IDs SYN1217 PNP0f13 (active)
[    1.500031] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
[    1.500033] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
[    1.500035] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
[    1.500037] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
[    1.500038] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.500040] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    1.500042] system 00:05: [mem 0xfed45000-0xfed8ffff] has been reserved
[    1.500044] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    1.500046] system 00:05: [mem 0xfee00000-0xfeefffff] could not be reserved
[    1.500048] system 00:05: [mem 0xdffe0000-0xdfffffff] has been reserved
[    1.500068] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.500837] system 00:06: [mem 0xfd000000-0xfdabffff] has been reserved
[    1.500839] system 00:06: [mem 0xfdad0000-0xfdadffff] has been reserved
[    1.500841] system 00:06: [mem 0xfdb00000-0xfdffffff] has been reserved
[    1.500843] system 00:06: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    1.500845] system 00:06: [mem 0xfe036000-0xfe03bfff] has been reserved
[    1.500846] system 00:06: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    1.500848] system 00:06: [mem 0xfe410000-0xfe7fffff] has been reserved
[    1.500868] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.501985] system 00:07: [io  0xff00-0xfffe] has been reserved
[    1.502006] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.509058] system 00:08: [mem 0xfe029000-0xfe029fff] has been reserved
[    1.509060] system 00:08: [mem 0xfe028000-0xfe028fff] has been reserved
[    1.509062] system 00:08: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    1.509064] system 00:08: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    1.509065] system 00:08: [mem 0xfdac0000-0xfdacffff] has been reserved
[    1.509086] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.516508] ACPI Error: [_OSI] Namespace lookup failure, AE_NOT_FOUND (20170831/psargs-364)
[    1.516537] ACPI Error: Method parse/execution failed \_SB.PAGD._STA, AE_NOT_FOUND (20170831/psparse-550)
[    1.523518] pnp: PnP ACPI: found 9 devices
[    1.523539] initcall pnpacpi_init+0x0/0x6e returned 0 after 33203 usecs
[    1.523555] calling  chr_dev_init+0x0/0x15f @ 1
[    1.542118] initcall chr_dev_init+0x0/0x15f returned 0 after 18108 usecs
[    1.542133] calling  firmware_class_init+0x0/0xff @ 1
[    1.542201] initcall firmware_class_init+0x0/0xff returned 0 after 47 usecs
[    1.542216] calling  thermal_init+0x0/0xf1 @ 1
[    1.542341] initcall thermal_init+0x0/0xf1 returned 0 after 105 usecs
[    1.542356] calling  cpufreq_gov_performance_init+0x0/0x11 @ 1
[    1.542382] initcall cpufreq_gov_performance_init+0x0/0x11 returned 0 after 7 usecs
[    1.542397] calling  map_properties+0x0/0x695 @ 1
[    1.542420] initcall map_properties+0x0/0x695 returned 0 after 4 usecs
[    1.542435] calling  init_acpi_pm_clocksource+0x0/0xd7 @ 1
[    1.546957] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.546981] initcall init_acpi_pm_clocksource+0x0/0xd7 returned 0 after 4421 usecs
[    1.546996] calling  pcibios_assign_resources+0x0/0x187 @ 1
[    1.547159] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.547185] pci 0000:00:1c.0:   bridge window [mem 0xdf300000-0xdf3fffff]
[    1.547222] pci 0000:00:1c.2: PCI bridge to [bus 02]
[    1.547247] pci 0000:00:1c.2:   bridge window [mem 0xdf200000-0xdf2fffff]
[    1.547284] pci 0000:00:1c.5: PCI bridge to [bus 03]
[    1.547301] pci 0000:00:1c.5:   bridge window [io  0xe000-0xefff]
[    1.547324] pci 0000:00:1c.5:   bridge window [mem 0xdf100000-0xdf1fffff]
[    1.547360] pci 0000:00:1d.0: PCI bridge to [bus 04]
[    1.547385] pci 0000:00:1d.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[    1.547422] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.547435] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.547449] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.547462] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
[    1.547475] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
[    1.547489] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
[    1.547502] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
[    1.547515] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
[    1.547529] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
[    1.547542] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
[    1.547555] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
[    1.547568] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff window]
[    1.547582] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff window]
[    1.547595] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff window]
[    1.547608] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff window]
[    1.547622] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff window]
[    1.547635] pci_bus 0000:00: resource 20 [mem 0x8ac00000-0xdfffffff window]
[    1.547648] pci_bus 0000:00: resource 21 [mem 0xfd000000-0xfe7fffff window]
[    1.547663] pci_bus 0000:01: resource 1 [mem 0xdf300000-0xdf3fffff]
[    1.547678] pci_bus 0000:02: resource 1 [mem 0xdf200000-0xdf2fffff]
[    1.547693] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
[    1.547707] pci_bus 0000:03: resource 1 [mem 0xdf100000-0xdf1fffff]
[    1.547722] pci_bus 0000:04: resource 1 [mem 0xdf000000-0xdf0fffff]
[    1.551404] initcall pcibios_assign_resources+0x0/0x187 returned 0 after 4285 usecs
[    1.551420] calling  sysctl_core_init+0x0/0x2b @ 1
[    1.551492] initcall sysctl_core_init+0x0/0x2b returned 0 after 52 usecs
[    1.551508] calling  eth_offload_init+0x0/0x14 @ 1
[    1.551533] initcall eth_offload_init+0x0/0x14 returned 0 after 5 usecs
[    1.551548] calling  inet_init+0x0/0x2d3 @ 1
[    1.551788] NET: Registered protocol family 2
[    1.554170] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    1.555322] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.555435] TCP: Hash tables configured (established 262144 bind 65536)
[    1.555962] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    1.556519] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    1.556997] initcall inet_init+0x0/0x2d3 returned 0 after 5303 usecs
[    1.557013] calling  ipv4_offload_init+0x0/0x74 @ 1
[    1.557039] initcall ipv4_offload_init+0x0/0x74 returned 0 after 7 usecs
[    1.557054] calling  af_unix_init+0x0/0x4e @ 1
[    1.557088] NET: Registered protocol family 1
[    1.557140] initcall af_unix_init+0x0/0x4e returned 0 after 66 usecs
[    1.557155] calling  ipv6_offload_init+0x0/0x7f @ 1
[    1.557182] initcall ipv6_offload_init+0x0/0x7f returned 0 after 8 usecs
[    1.557198] calling  pci_apply_final_quirks+0x0/0x110 @ 1
[    1.557245] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.558659] PCI: CLS 64 bytes, default 64
[    1.558679] initcall pci_apply_final_quirks+0x0/0x110 returned 0 after 1426 usecs
[    1.558695] calling  acpi_reserve_resources+0x0/0xeb @ 1
[    1.558744] initcall acpi_reserve_resources+0x0/0xeb returned 0 after 29 usecs
[    1.558759] calling  populate_rootfs+0x0/0x101 @ 1
[    1.559368] Trying to unpack rootfs image as initramfs...
[    3.510411] Freeing initrd memory: 60292K
[    3.510437] initcall populate_rootfs+0x0/0x101 returned 0 after 1905913 usecs
[    3.510454] calling  pci_iommu_init+0x0/0x3c @ 1
[    3.510743] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    3.510756] software IO TLB [mem 0x755a6000-0x795a6000] (64MB) mapped at [000000006c67359c-00000000786b2711]
[    3.510776] initcall pci_iommu_init+0x0/0x3c returned 0 after 296 usecs
[    3.510792] calling  ir_dev_scope_init+0x0/0x33 @ 1
[    3.510817] initcall ir_dev_scope_init+0x0/0x33 returned 0 after 6 usecs
[    3.510972] calling  ia32_binfmt_init+0x0/0x14 @ 1
[    3.511012] initcall ia32_binfmt_init+0x0/0x14 returned 0 after 20 usecs
[    3.511027] calling  amd_uncore_init+0x0/0x2c7 @ 1
[    3.511050] initcall amd_uncore_init+0x0/0x2c7 returned -19 after 4 usecs
[    3.511065] calling  amd_ibs_init+0x0/0x21b @ 1
[    3.511088] initcall amd_ibs_init+0x0/0x21b returned -19 after 4 usecs
[    3.511103] calling  amd_iommu_pc_init+0x0/0x322 @ 1
[    3.511127] initcall amd_iommu_pc_init+0x0/0x322 returned -19 after 4 usecs
[    3.511142] calling  msr_init+0x0/0x333 @ 1
[    3.511178] initcall msr_init+0x0/0x333 returned 0 after 17 usecs
[    3.511194] calling  intel_uncore_init+0x0/0x354 @ 1
[    3.511698] initcall intel_uncore_init+0x0/0x354 returned 0 after 473 usecs
[    3.511713] calling  register_kernel_offset_dumper+0x0/0x1b @ 1
[    3.511738] initcall register_kernel_offset_dumper+0x0/0x1b returned 0 after 5 usecs
[    3.511753] calling  i8259A_init_ops+0x0/0x21 @ 1
[    3.511778] initcall i8259A_init_ops+0x0/0x21 returned 0 after 6 usecs
[    3.511793] calling  init_tsc_clocksource+0x0/0x124 @ 1
[    3.511811] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x29dc05e54fc, max_idle_ns: 440795291716 ns
[    3.511839] initcall init_tsc_clocksource+0x0/0x124 returned 0 after 26 usecs
[    3.511854] calling  add_rtc_cmos+0x0/0xdc @ 1
[    3.511879] initcall add_rtc_cmos+0x0/0xdc returned 0 after 6 usecs
[    3.511894] calling  i8237A_init_ops+0x0/0x14 @ 1
[    3.511919] initcall i8237A_init_ops+0x0/0x14 returned 0 after 6 usecs
[    3.511935] calling  thermal_throttle_init_device+0x0/0x42 @ 1
[    3.512148] initcall thermal_throttle_init_device+0x0/0x42 returned 0 after 190 usecs
[    3.512164] calling  ioapic_init_ops+0x0/0x14 @ 1
[    3.512189] initcall ioapic_init_ops+0x0/0x14 returned 0 after 6 usecs
[    3.512204] calling  register_e820_pmem+0x0/0x42 @ 1
[    3.512269] initcall register_e820_pmem+0x0/0x42 returned 0 after 45 usecs
[    3.512284] calling  add_pcspkr+0x0/0x6f @ 1
[    3.512607] initcall add_pcspkr+0x0/0x6f returned 0 after 296 usecs
[    3.512623] calling  start_periodic_check_for_corruption+0x0/0x50 @ 1
[    3.512639] Scanning for low memory corruption every 60 seconds
[    3.512676] initcall start_periodic_check_for_corruption+0x0/0x50 returned 0 after 33 usecs
[    3.512691] calling  sysfb_init+0x0/0xcf @ 1
[    3.513028] initcall sysfb_init+0x0/0xcf returned 0 after 310 usecs
[    3.513043] calling  audit_classes_init+0x0/0xaf @ 1
[    3.513101] initcall audit_classes_init+0x0/0xaf returned 0 after 38 usecs
[    3.513116] calling  pt_dump_init+0x0/0x32 @ 1
[    3.513140] initcall pt_dump_init+0x0/0x32 returned 0 after 4 usecs
[    3.513155] calling  crc32c_intel_mod_init+0x0/0x6e @ 1
[    3.513332] initcall crc32c_intel_mod_init+0x0/0x6e returned 0 after 153 usecs
[    3.513347] calling  iosf_mbi_init+0x0/0xb8 @ 1
[    3.513683] initcall iosf_mbi_init+0x0/0xb8 returned 0 after 309 usecs
[    3.513698] calling  proc_execdomains_init+0x0/0x1f @ 1
[    3.513728] initcall proc_execdomains_init+0x0/0x1f returned 0 after 12 usecs
[    3.513743] calling  register_warn_debugfs+0x0/0x24 @ 1
[    3.513791] initcall register_warn_debugfs+0x0/0x24 returned 0 after 29 usecs
[    3.513806] calling  cpuhp_sysfs_init+0x0/0x6d @ 1
[    3.514022] initcall cpuhp_sysfs_init+0x0/0x6d returned 0 after 192 usecs
[    3.514037] calling  ioresources_init+0x0/0x36 @ 1
[    3.514074] initcall ioresources_init+0x0/0x36 returned 0 after 17 usecs
[    3.514089] calling  init_sched_debug_procfs+0x0/0x29 @ 1
[    3.514118] initcall init_sched_debug_procfs+0x0/0x29 returned 0 after 10 usecs
[    3.514133] calling  snapshot_device_init+0x0/0x11 @ 1
[    3.514429] initcall snapshot_device_init+0x0/0x11 returned 0 after 270 usecs
[    3.514444] calling  irq_gc_init_ops+0x0/0x14 @ 1
[    3.514469] initcall irq_gc_init_ops+0x0/0x14 returned 0 after 6 usecs
[    3.514484] calling  irq_pm_init_ops+0x0/0x14 @ 1
[    3.514508] initcall irq_pm_init_ops+0x0/0x14 returned 0 after 6 usecs
[    3.514523] calling  klp_init+0x0/0x29 @ 1
[    3.514561] initcall klp_init+0x0/0x29 returned 0 after 18 usecs
[    3.514576] calling  timekeeping_init_ops+0x0/0x14 @ 1
[    3.514601] initcall timekeeping_init_ops+0x0/0x14 returned 0 after 6 usecs
[    3.514616] calling  init_clocksource_sysfs+0x0/0x69 @ 1
[    3.515122] initcall init_clocksource_sysfs+0x0/0x69 returned 0 after 475 usecs
[    3.515138] calling  init_timer_list_procfs+0x0/0x29 @ 1
[    3.515167] initcall init_timer_list_procfs+0x0/0x29 returned 0 after 10 usecs
[    3.515182] calling  alarmtimer_init+0x0/0x134 @ 1
[    3.515647] initcall alarmtimer_init+0x0/0x134 returned 0 after 435 usecs
[    3.515662] calling  init_posix_timers+0x0/0x2a @ 1
[    3.515747] initcall init_posix_timers+0x0/0x2a returned 0 after 65 usecs
[    3.515763] calling  clockevents_init_sysfs+0x0/0x137 @ 1
[    3.517196] initcall clockevents_init_sysfs+0x0/0x137 returned 0 after 1381 usecs
[    3.517212] calling  proc_dma_init+0x0/0x1f @ 1
[    3.517242] initcall proc_dma_init+0x0/0x1f returned 0 after 10 usecs
[    3.517257] calling  proc_modules_init+0x0/0x1f @ 1
[    3.517286] initcall proc_modules_init+0x0/0x1f returned 0 after 10 usecs
[    3.517301] calling  kallsyms_init+0x0/0x22 @ 1
[    3.517330] initcall kallsyms_init+0x0/0x22 returned 0 after 10 usecs
[    3.517346] calling  pid_namespaces_init+0x0/0x40 @ 1
[    3.517442] initcall pid_namespaces_init+0x0/0x40 returned 0 after 75 usecs
[    3.517457] calling  audit_watch_init+0x0/0x3a @ 1
[    3.517483] initcall audit_watch_init+0x0/0x3a returned 0 after 7 usecs
[    3.517499] calling  audit_fsnotify_init+0x0/0x3a @ 1
[    3.517525] initcall audit_fsnotify_init+0x0/0x3a returned 0 after 7 usecs
[    3.517540] calling  audit_tree_init+0x0/0xb4 @ 1
[    3.517566] initcall audit_tree_init+0x0/0xb4 returned 0 after 7 usecs
[    3.517581] calling  init_kprobes+0x0/0x308 @ 1
[    3.518871] initcall init_kprobes+0x0/0x308 returned 0 after 1240 usecs
[    3.518886] calling  seccomp_sysctl_init+0x0/0x2c @ 1
[    3.518928] initcall seccomp_sysctl_init+0x0/0x2c returned 0 after 21 usecs
[    3.518943] calling  utsname_sysctl_init+0x0/0x14 @ 1
[    3.518981] initcall utsname_sysctl_init+0x0/0x14 returned 0 after 17 usecs
[    3.518996] calling  init_tracepoints+0x0/0x28 @ 1
[    3.519022] initcall init_tracepoints+0x0/0x28 returned 0 after 6 usecs
[    3.519041] calling  stack_trace_init+0x0/0xb0 @ 1
[    3.519141] initcall stack_trace_init+0x0/0xb0 returned 0 after 80 usecs
[    3.519156] calling  init_mmio_trace+0x0/0xc @ 1
[    3.519188] initcall init_mmio_trace+0x0/0xc returned 0 after 13 usecs
[    3.519203] calling  init_blk_tracer+0x0/0x50 @ 1
[    3.519308] initcall init_blk_tracer+0x0/0x50 returned 0 after 84 usecs
[    3.519323] calling  perf_event_sysfs_init+0x0/0x97 @ 1
[    3.522653] initcall perf_event_sysfs_init+0x0/0x97 returned 0 after 3233 usecs
[    3.522668] calling  padata_driver_init+0x0/0x39 @ 1
[    3.522694] initcall padata_driver_init+0x0/0x39 returned 0 after 7 usecs
[    3.522710] calling  system_trusted_keyring_init+0x0/0x127 @ 1
[    3.522725] Initialise system trusted keyrings
[    3.522802] initcall system_trusted_keyring_init+0x0/0x127 returned 0 after 72 usecs
[    3.522818] calling  kswapd_init+0x0/0x85 @ 1
[    3.522941] initcall kswapd_init+0x0/0x85 returned 0 after 101 usecs
[    3.522956] calling  extfrag_debug_init+0x0/0x78 @ 1
[    3.523057] initcall extfrag_debug_init+0x0/0x78 returned 0 after 80 usecs
[    3.523072] calling  mm_compute_batch_init+0x0/0x19 @ 1
[    3.523098] initcall mm_compute_batch_init+0x0/0x19 returned 0 after 7 usecs
[    3.523113] calling  slab_proc_init+0x0/0x22 @ 1
[    3.523143] initcall slab_proc_init+0x0/0x22 returned 0 after 10 usecs
[    3.523158] calling  workingset_init+0x0/0x9d @ 1
[    3.523175] workingset: timestamp_bits=40 max_order=23 bucket_order=0
[    3.523206] initcall workingset_init+0x0/0x9d returned 0 after 27 usecs
[    3.523221] calling  proc_vmalloc_init+0x0/0x22 @ 1
[    3.523250] initcall proc_vmalloc_init+0x0/0x22 returned 0 after 10 usecs
[    3.523266] calling  procswaps_init+0x0/0x1f @ 1
[    3.523296] initcall procswaps_init+0x0/0x1f returned 0 after 10 usecs
[    3.523310] calling  init_frontswap+0x0/0x91 @ 1
[    3.523462] initcall init_frontswap+0x0/0x91 returned 0 after 130 usecs
[    3.523477] calling  slab_sysfs_init+0x0/0x120 @ 1
[    3.553963] initcall slab_sysfs_init+0x0/0x120 returned 0 after 29753 usecs
[    3.553979] calling  init_cleancache+0x0/0x91 @ 1
[    3.554132] initcall init_cleancache+0x0/0x91 returned 0 after 132 usecs
[    3.554147] calling  init_zbud+0x0/0x20 @ 1
[    3.554163] zbud: loaded
[    3.554183] initcall init_zbud+0x0/0x20 returned 0 after 16 usecs
[    3.554198] calling  zs_init+0x0/0x74 @ 1
[    3.554360] initcall zs_init+0x0/0x74 returned 0 after 140 usecs
[    3.554375] calling  hmm_init+0x0/0x64 @ 1
[    3.554430] initcall hmm_init+0x0/0x64 returned 0 after 35 usecs
[    3.554445] calling  fcntl_init+0x0/0x2a @ 1
[    3.554506] initcall fcntl_init+0x0/0x2a returned 0 after 41 usecs
[    3.554521] calling  proc_filesystems_init+0x0/0x1f @ 1
[    3.554550] initcall proc_filesystems_init+0x0/0x1f returned 0 after 10 usecs
[    3.554565] calling  start_dirtytime_writeback+0x0/0x2a @ 1
[    3.554594] initcall start_dirtytime_writeback+0x0/0x2a returned 0 after 10 usecs
[    3.554609] calling  blkdev_init+0x0/0x2a @ 1
[    3.554696] initcall blkdev_init+0x0/0x2a returned 0 after 67 usecs
[    3.554711] calling  dio_init+0x0/0x2d @ 1
[    3.555160] initcall dio_init+0x0/0x2d returned 0 after 420 usecs
[    3.555175] calling  dnotify_init+0x0/0x79 @ 1
[    3.555268] initcall dnotify_init+0x0/0x79 returned 0 after 72 usecs
[    3.555283] calling  fanotify_user_setup+0x0/0x77 @ 1
[    3.555413] initcall fanotify_user_setup+0x0/0x77 returned 0 after 108 usecs
[    3.555428] calling  userfaultfd_init+0x0/0x2e @ 1
[    3.555839] initcall userfaultfd_init+0x0/0x2e returned 0 after 382 usecs
[    3.555854] calling  aio_setup+0x0/0xa1 @ 1
[    3.556111] initcall aio_setup+0x0/0xa1 returned 0 after 233 usecs
[    3.556126] calling  fscrypt_init+0x0/0xa4 @ 1
[    3.557117] initcall fscrypt_init+0x0/0xa4 returned 0 after 949 usecs
[    3.557133] calling  init_sys32_ioctl+0x0/0x28 @ 1
[    3.560094] initcall init_sys32_ioctl+0x0/0x28 returned 0 after 2873 usecs
[    3.560110] calling  mbcache_init+0x0/0x31 @ 1
[    3.560574] initcall mbcache_init+0x0/0x31 returned 0 after 435 usecs
[    3.560590] calling  init_devpts_fs+0x0/0x28 @ 1
[    3.560635] initcall init_devpts_fs+0x0/0x28 returned 0 after 26 usecs
[    3.560650] calling  ext4_init_fs+0x0/0x1ab @ 1
[    3.562503] initcall ext4_init_fs+0x0/0x1ab returned 0 after 1791 usecs
[    3.562518] calling  journal_init+0x0/0x118 @ 1
[    3.563539] initcall journal_init+0x0/0x118 returned 0 after 978 usecs
[    3.563554] calling  init_squashfs_fs+0x0/0x6b @ 1
[    3.563947] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    3.563965] initcall init_squashfs_fs+0x0/0x6b returned 0 after 384 usecs
[    3.563980] calling  init_fat_fs+0x0/0x4a @ 1
[    3.564819] initcall init_fat_fs+0x0/0x4a returned 0 after 801 usecs
[    3.564834] calling  init_vfat_fs+0x0/0x11 @ 1
[    3.564859] initcall init_vfat_fs+0x0/0x11 returned 0 after 6 usecs
[    3.564874] calling  ecryptfs_init+0x0/0x215 @ 1
[    3.566443] initcall ecryptfs_init+0x0/0x215 returned 0 after 1513 usecs
[    3.566458] calling  init_nls_cp437+0x0/0x13 @ 1
[    3.566482] initcall init_nls_cp437+0x0/0x13 returned 0 after 5 usecs
[    3.566496] calling  fuse_init+0x0/0x1d9 @ 1
[    3.566512] fuse init (API version 7.26)
[    3.567589] initcall fuse_init+0x0/0x1d9 returned 0 after 1048 usecs
[    3.567604] calling  init_pstore_fs+0x0/0x4a @ 1
[    3.567638] initcall init_pstore_fs+0x0/0x4a returned 0 after 15 usecs
[    3.567653] calling  efivarfs_init+0x0/0x46 @ 1
[    3.567678] initcall efivarfs_init+0x0/0x46 returned 0 after 6 usecs
[    3.567693] calling  ipc_init+0x0/0x4c @ 1
[    3.567752] initcall ipc_init+0x0/0x4c returned 0 after 40 usecs
[    3.567767] calling  ipc_sysctl_init+0x0/0x14 @ 1
[    3.567806] initcall ipc_sysctl_init+0x0/0x14 returned 0 after 20 usecs
[    3.567821] calling  init_mqueue_fs+0x0/0x1d3 @ 1
[    3.568380] initcall init_mqueue_fs+0x0/0x1d3 returned 0 after 528 usecs
[    3.568395] calling  key_proc_init+0x0/0x58 @ 1
[    3.568431] initcall key_proc_init+0x0/0x58 returned 0 after 17 usecs
[    3.568446] calling  selinux_nf_ip_init+0x0/0x3b @ 1
[    3.568469] initcall selinux_nf_ip_init+0x0/0x3b returned 0 after 4 usecs
[    3.568483] calling  init_sel_fs+0x0/0xa1 @ 1
[    3.568506] initcall init_sel_fs+0x0/0xa1 returned 0 after 4 usecs
[    3.568521] calling  selnl_init+0x0/0x7d @ 1
[    3.568582] initcall selnl_init+0x0/0x7d returned 0 after 41 usecs
[    3.568597] calling  sel_netif_init+0x0/0x9c @ 1
[    3.568620] initcall sel_netif_init+0x0/0x9c returned 0 after 4 usecs
[    3.568635] calling  sel_netnode_init+0x0/0x109 @ 1
[    3.568657] initcall sel_netnode_init+0x0/0x109 returned 0 after 4 usecs
[    3.568672] calling  sel_netport_init+0x0/0x109 @ 1
[    3.568695] initcall sel_netport_init+0x0/0x109 returned 0 after 4 usecs
[    3.568710] calling  aurule_init+0x0/0x2b @ 1
[    3.568735] initcall aurule_init+0x0/0x2b returned 0 after 6 usecs
[    3.568750] calling  init_smk_fs+0x0/0x10a @ 1
[    3.568773] initcall init_smk_fs+0x0/0x10a returned 0 after 4 usecs
[    3.568787] calling  smack_nf_ip_init+0x0/0x29 @ 1
[    3.568810] initcall smack_nf_ip_init+0x0/0x29 returned 0 after 4 usecs
[    3.568826] calling  crypto_algapi_init+0x0/0xd @ 1
[    3.568855] initcall crypto_algapi_init+0x0/0xd returned 0 after 10 usecs
[    3.568870] calling  seqiv_module_init+0x0/0x11 @ 1
[    3.568899] initcall seqiv_module_init+0x0/0x11 returned 0 after 9 usecs
[    3.568914] calling  dh_init+0x0/0x20 @ 1
[    3.569060] initcall dh_init+0x0/0x20 returned 0 after 123 usecs
[    3.569076] calling  rsa_init+0x0/0x50 @ 1
[    3.569212] initcall rsa_init+0x0/0x50 returned 0 after 114 usecs
[    3.569227] calling  hmac_module_init+0x0/0x11 @ 1
[    3.569255] initcall hmac_module_init+0x0/0x11 returned 0 after 9 usecs
[    3.569270] calling  crypto_null_mod_init+0x0/0x48 @ 1
[    3.569724] initcall crypto_null_mod_init+0x0/0x48 returned 0 after 424 usecs
[    3.569739] calling  md5_mod_init+0x0/0x11 @ 1
[    3.569868] initcall md5_mod_init+0x0/0x11 returned 0 after 106 usecs
[    3.569883] calling  sha1_generic_mod_init+0x0/0x11 @ 1
[    3.570013] initcall sha1_generic_mod_init+0x0/0x11 returned 0 after 109 usecs
[    3.570029] calling  sha256_generic_mod_init+0x0/0x16 @ 1
[    3.570258] initcall sha256_generic_mod_init+0x0/0x16 returned 0 after 205 usecs
[    3.570273] calling  sha512_generic_mod_init+0x0/0x16 @ 1
[    3.570504] initcall sha512_generic_mod_init+0x0/0x16 returned 0 after 206 usecs
[    3.570519] calling  crypto_ecb_module_init+0x0/0x11 @ 1
[    3.570547] initcall crypto_ecb_module_init+0x0/0x11 returned 0 after 9 usecs
[    3.570562] calling  crypto_cbc_module_init+0x0/0x11 @ 1
[    3.570590] initcall crypto_cbc_module_init+0x0/0x11 returned 0 after 9 usecs
[    3.570605] calling  crypto_cts_module_init+0x0/0x11 @ 1
[    3.570633] initcall crypto_cts_module_init+0x0/0x11 returned 0 after 9 usecs
[    3.570648] calling  crypto_module_init+0x0/0x11 @ 1
[    3.570676] initcall crypto_module_init+0x0/0x11 returned 0 after 9 usecs
[    3.570691] calling  crypto_ctr_module_init+0x0/0x3c @ 1
[    3.570723] initcall crypto_ctr_module_init+0x0/0x3c returned 0 after 13 usecs
[    3.570739] calling  crypto_gcm_module_init+0x0/0xbe @ 1
[    3.570782] initcall crypto_gcm_module_init+0x0/0xbe returned 0 after 24 usecs
[    3.570797] calling  aes_init+0x0/0x11 @ 1
[    3.570927] initcall aes_init+0x0/0x11 returned 0 after 108 usecs
[    3.570943] calling  crc32c_mod_init+0x0/0x11 @ 1
[    3.571073] initcall crc32c_mod_init+0x0/0x11 returned 0 after 109 usecs
[    3.571089] calling  crct10dif_mod_init+0x0/0x11 @ 1
[    3.571218] initcall crct10dif_mod_init+0x0/0x11 returned 0 after 107 usecs
[    3.571233] calling  lzo_mod_init+0x0/0x3a @ 1
[    3.571478] initcall lzo_mod_init+0x0/0x3a returned 0 after 220 usecs
[    3.571493] calling  drbg_init+0x0/0xec @ 1
[    3.573929] initcall drbg_init+0x0/0xec returned 0 after 2360 usecs
[    3.573944] calling  jent_mod_init+0x0/0x2e @ 1
[    3.575006] initcall jent_mod_init+0x0/0x2e returned 0 after 1017 usecs
[    3.575021] calling  ghash_mod_init+0x0/0x11 @ 1
[    3.575153] initcall ghash_mod_init+0x0/0x11 returned 0 after 110 usecs
[    3.575169] calling  asymmetric_key_init+0x0/0x11 @ 1
[    3.575187] Key type asymmetric registered
[    3.575206] initcall asymmetric_key_init+0x0/0x11 returned 0 after 18 usecs
[    3.575221] calling  x509_key_init+0x0/0x11 @ 1
[    3.575239] Asymmetric key parser 'x509' registered
[    3.575258] initcall x509_key_init+0x0/0x11 returned 0 after 17 usecs
[    3.575273] calling  proc_genhd_init+0x0/0x36 @ 1
[    3.575325] initcall proc_genhd_init+0x0/0x36 returned 0 after 32 usecs
[    3.575340] calling  bsg_init+0x0/0x2b7 @ 1
[    3.575834] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    3.575853] initcall bsg_init+0x0/0x2b7 returned 0 after 482 usecs
[    3.575869] calling  throtl_init+0x0/0x41 @ 1
[    3.576147] initcall throtl_init+0x0/0x41 returned 0 after 252 usecs
[    3.576162] calling  noop_init+0x0/0x11 @ 1
[    3.576180] io scheduler noop registered
[    3.576199] initcall noop_init+0x0/0x11 returned 0 after 18 usecs
[    3.576215] calling  deadline_init+0x0/0x11 @ 1
[    3.576233] io scheduler deadline registered (default)
[    3.576252] initcall deadline_init+0x0/0x11 returned 0 after 18 usecs
[    3.576267] calling  cfq_init+0x0/0x74 @ 1
[    3.577154] io scheduler cfq registered
[    3.577173] initcall cfq_init+0x0/0x74 returned 0 after 866 usecs
[    3.577189] calling  deadline_init+0x0/0x11 @ 1
[    3.577208] io scheduler mq-deadline registered (default)
[    3.577227] initcall deadline_init+0x0/0x11 returned 0 after 19 usecs
[    3.577242] calling  kyber_init+0x0/0x11 @ 1
[    3.577262] io scheduler kyber registered
[    3.577281] initcall kyber_init+0x0/0x11 returned 0 after 19 usecs
[    3.577296] calling  btree_module_init+0x0/0x25 @ 1
[    3.577347] initcall btree_module_init+0x0/0x25 returned 0 after 31 usecs
[    3.577362] calling  crc_t10dif_mod_init+0x0/0x39 @ 1
[    3.577394] initcall crc_t10dif_mod_init+0x0/0x39 returned 0 after 13 usecs
[    3.577410] calling  percpu_counter_startup+0x0/0x51 @ 1
[    3.577598] initcall percpu_counter_startup+0x0/0x51 returned 0 after 164 usecs
[    3.577613] calling  sg_pool_init+0x0/0x361 @ 1
[    3.577848] initcall sg_pool_init+0x0/0x361 returned 0 after 211 usecs
[    3.577864] calling  phy_core_init+0x0/0x63 @ 1
[    3.577913] initcall phy_core_init+0x0/0x63 returned 0 after 29 usecs
[    3.577928] calling  amd_gpio_driver_init+0x0/0x13 @ 1
[    3.578093] initcall amd_gpio_driver_init+0x0/0x13 returned 0 after 141 usecs
[    3.578108] calling  crystalcove_pwm_driver_init+0x0/0x13 @ 1
[    3.578231] initcall crystalcove_pwm_driver_init+0x0/0x13 returned 0 after 101 usecs
[    3.578247] calling  pci_proc_init+0x0/0x66 @ 1
[    3.578522] initcall pci_proc_init+0x0/0x66 returned 0 after 249 usecs
[    3.578537] calling  pcie_portdrv_init+0x0/0x86 @ 1
[    3.579985] initcall pcie_portdrv_init+0x0/0x86 returned 0 after 1394 usecs
[    3.580001] calling  aer_service_init+0x0/0x32 @ 1
[    3.580160] initcall aer_service_init+0x0/0x32 returned 0 after 65 usecs
[    3.580176] calling  pcie_pme_service_init+0x0/0x11 @ 1
[    3.580262] initcall pcie_pme_service_init+0x0/0x11 returned 0 after 65 usecs
[    3.580278] calling  dpc_service_init+0x0/0x11 @ 1
[    3.580361] initcall dpc_service_init+0x0/0x11 returned 0 after 62 usecs
[    3.580377] calling  pci_hotplug_init+0x0/0x49 @ 1
[    3.580400] initcall pci_hotplug_init+0x0/0x49 returned 0 after 4 usecs
[    3.580416] calling  pcied_init+0x0/0x8c @ 1
[    3.580503] initcall pcied_init+0x0/0x8c returned 0 after 66 usecs
[    3.580518] calling  dw_plat_pcie_driver_init+0x0/0x13 @ 1
[    3.580621] initcall dw_plat_pcie_driver_init+0x0/0x13 returned 0 after 81 usecs
[    3.580636] calling  imsttfb_init+0x0/0x17f @ 1
[    3.580794] initcall imsttfb_init+0x0/0x17f returned 0 after 136 usecs
[    3.580809] calling  asiliantfb_init+0x0/0x32 @ 1
[    3.580964] initcall asiliantfb_init+0x0/0x32 returned 0 after 133 usecs
[    3.580979] calling  vesafb_driver_init+0x0/0x13 @ 1
[    3.581101] initcall vesafb_driver_init+0x0/0x13 returned 0 after 101 usecs
[    3.581116] calling  efifb_driver_init+0x0/0x13 @ 1
[    3.581238] initcall efifb_driver_init+0x0/0x13 returned 0 after 101 usecs
[    3.581253] calling  intel_idle_init+0x0/0x81a @ 1
[    3.581271] intel_idle: MWAIT substates: 0x11142120
[    3.581283] intel_idle: v0.4.1 model 0x8E
[    3.581786] intel_idle: lapic_timer_reliable_states 0xffffffff
[    3.581805] initcall intel_idle_init+0x0/0x81a returned 0 after 520 usecs
[    3.581821] calling  acpi_ac_init+0x0/0x16b @ 1
[    3.584437] ACPI: AC Adapter [AC] (off-line)
[    3.584557] initcall acpi_ac_init+0x0/0x16b returned 0 after 2653 usecs
[    3.584573] calling  acpi_button_driver_init+0x0/0x11 @ 1
[    3.585054] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    3.585152] ACPI: Power Button [PWRB]
[    3.585334] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
[    3.585412] ACPI: Sleep Button [SLPB]
[    3.585610] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
[    3.585696] ACPI: Lid Switch [LID0]
[    3.585887] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    3.585963] ACPI: Power Button [PWRF]
[    3.586069] initcall acpi_button_driver_init+0x0/0x11 returned 0 after 1441 usecs
[    3.586084] calling  acpi_fan_driver_init+0x0/0x13 @ 1
[    3.586241] initcall acpi_fan_driver_init+0x0/0x13 returned 0 after 135 usecs
[    3.586256] calling  acpi_processor_driver_init+0x0/0x98 @ 1
[    3.587086] initcall acpi_processor_driver_init+0x0/0x98 returned 0 after 791 usecs
[    3.587101] calling  acpi_thermal_init+0x0/0x7f @ 1
[    3.588037] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    3.588184] thermal LNXTHERM:00: registered as thermal_zone0
[    3.588186] ACPI: Thermal Zone [TZ0] (48 C)
[    3.588291] initcall acpi_thermal_init+0x0/0x7f returned 0 after 1142 usecs
[    3.588306] calling  acpi_battery_init+0x0/0x30 @ 1
[    3.588348] initcall acpi_battery_init+0x0/0x30 returned 0 after 22 usecs
[    3.588363] calling  acpi_hed_driver_init+0x0/0x11 @ 1
[    3.588782] initcall acpi_hed_driver_init+0x0/0x11 returned 0 after 390 usecs
[    3.588797] calling  bgrt_init+0x0/0xb5 @ 1
[    3.588918] initcall bgrt_init+0x0/0xb5 returned 0 after 99 usecs
[    3.588933] calling  erst_init+0x0/0x32e @ 1
[    3.588961] initcall erst_init+0x0/0x32e returned 0 after 9 usecs
[    3.588976] calling  ghes_init+0x0/0x1ac @ 1
[    3.588999] initcall ghes_init+0x0/0x1ac returned -19 after 4 usecs
[    3.589015] calling  gpio_clk_driver_init+0x0/0x13 @ 1
[    3.589138] initcall gpio_clk_driver_init+0x0/0x13 returned 0 after 102 usecs
[    3.589154] calling  plt_clk_driver_init+0x0/0x13 @ 1
[    3.589226] ACPI: Battery Slot [BAT0] (battery present)
[    3.589276] initcall plt_clk_driver_init+0x0/0x13 returned 0 after 101 usecs
[    3.589292] calling  virtio_mmio_init+0x0/0x13 @ 1
[    3.589447] initcall virtio_mmio_init+0x0/0x13 returned 0 after 133 usecs
[    3.589462] calling  virtio_pci_driver_init+0x0/0x1a @ 1
[    3.589662] initcall virtio_pci_driver_init+0x0/0x1a returned 0 after 176 usecs
[    3.589678] calling  virtio_balloon_driver_init+0x0/0x11 @ 1
[    3.589766] initcall virtio_balloon_driver_init+0x0/0x11 returned 0 after 67 usecs
[    3.589781] calling  xenbus_probe_initcall+0x0/0x4a @ 1
[    3.589805] initcall xenbus_probe_initcall+0x0/0x4a returned -19 after 4 usecs
[    3.589820] calling  xenbus_init+0x0/0x36 @ 1
[    3.589843] initcall xenbus_init+0x0/0x36 returned -19 after 4 usecs
[    3.589858] calling  xenbus_backend_init+0x0/0x4a @ 1
[    3.589882] initcall xenbus_backend_init+0x0/0x4a returned -19 after 4 usecs
[    3.589897] calling  hypervisor_subsys_init+0x0/0x3b @ 1
[    3.589920] initcall hypervisor_subsys_init+0x0/0x3b returned -19 after 4 usecs
[    3.589935] calling  hyper_sysfs_init+0x0/0x188 @ 1
[    3.589959] initcall hyper_sysfs_init+0x0/0x188 returned -19 after 4 usecs
[    3.589974] calling  platform_driver_init+0x0/0x1a @ 1
[    3.590129] initcall platform_driver_init+0x0/0x1a returned 0 after 133 usecs
[    3.590145] calling  xen_late_init_mcelog+0x0/0x63 @ 1
[    3.590168] initcall xen_late_init_mcelog+0x0/0x63 returned -19 after 4 usecs
[    3.590183] calling  xen_acpi_processor_init+0x0/0x338 @ 1
[    3.590207] initcall xen_acpi_processor_init+0x0/0x338 returned -19 after 5 usecs
[    3.590222] calling  n_null_init+0x0/0x2b @ 1
[    3.590247] initcall n_null_init+0x0/0x2b returned 0 after 5 usecs
[    3.590262] calling  pty_init+0x0/0x3cb @ 1
[    3.590631] initcall pty_init+0x0/0x3cb returned 0 after 341 usecs
[    3.590647] calling  sysrq_init+0x0/0x63 @ 1
[    3.590685] initcall sysrq_init+0x0/0x63 returned 0 after 19 usecs
[    3.590701] calling  xen_hvc_init+0x0/0x3fb @ 1
[    3.590724] initcall xen_hvc_init+0x0/0x3fb returned -19 after 4 usecs
[    3.590739] calling  serial8250_init+0x0/0x1b7 @ 1
[    3.590756] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    3.607637] initcall serial8250_init+0x0/0x1b7 returned 0 after 16482 usecs
[    3.607653] calling  serial_pci_driver_init+0x0/0x1a @ 1
[    3.607823] initcall serial_pci_driver_init+0x0/0x1a returned 0 after 147 usecs
[    3.607838] calling  exar_pci_driver_init+0x0/0x1a @ 1
[    3.607994] initcall exar_pci_driver_init+0x0/0x1a returned 0 after 133 usecs
[    3.608069] calling  max310x_uart_init+0x0/0x35 @ 1
[    3.608233] initcall max310x_uart_init+0x0/0x35 returned 0 after 143 usecs
[    3.608248] calling  sccnxp_uart_driver_init+0x0/0x13 @ 1
[    3.608375] initcall sccnxp_uart_driver_init+0x0/0x13 returned 0 after 105 usecs
[    3.608391] calling  init_kgdboc+0x0/0x16 @ 1
[    3.608421] initcall init_kgdboc+0x0/0x16 returned 0 after 10 usecs
[    3.608436] calling  ttyprintk_init+0x0/0x115 @ 1
[    3.608792] initcall ttyprintk_init+0x0/0x115 returned 0 after 328 usecs
[    3.608808] calling  init+0x0/0x12e @ 1
[    3.609068] initcall init+0x0/0x12e returned 0 after 234 usecs
[    3.609083] calling  hpet_init+0x0/0x65 @ 1
[    3.609981] initcall hpet_init+0x0/0x65 returned 0 after 858 usecs
[    3.609996] calling  hwrng_modinit+0x0/0x7d @ 1
[    3.610346] initcall hwrng_modinit+0x0/0x7d returned 0 after 323 usecs
[    3.610361] calling  agp_init+0x0/0x24 @ 1
[    3.610377] Linux agpgart interface v0.103
[    3.610395] initcall agp_init+0x0/0x24 returned 0 after 15 usecs
[    3.610410] calling  agp_amd64_mod_init+0x0/0x20 @ 1
[    3.610847] initcall agp_amd64_mod_init+0x0/0x20 returned -19 after 409 usecs
[    3.610862] calling  agp_intel_init+0x0/0x29 @ 1
[    3.611020] initcall agp_intel_init+0x0/0x29 returned 0 after 136 usecs
[    3.611035] calling  agp_via_init+0x0/0x29 @ 1
[    3.611190] initcall agp_via_init+0x0/0x29 returned 0 after 133 usecs
[    3.611205] calling  init_tis+0x0/0x128 @ 1
[    3.638524] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1A, rev-id 16)
[    3.766615] initcall init_tis+0x0/0x128 returned 0 after 151746 usecs
[    3.766632] calling  cn_proc_init+0x0/0x36 @ 1
[    3.766660] initcall cn_proc_init+0x0/0x36 returned 0 after 9 usecs
[    3.766675] calling  _nvm_misc_init+0x0/0x11 @ 1
[    3.766996] initcall _nvm_misc_init+0x0/0x11 returned 0 after 295 usecs
[    3.767017] calling  topology_sysfs_init+0x0/0x30 @ 1
[    3.767332] initcall topology_sysfs_init+0x0/0x30 returned 0 after 288 usecs
[    3.767347] calling  cacheinfo_sysfs_init+0x0/0x2c @ 1
[    3.768140] initcall cacheinfo_sysfs_init+0x0/0x2c returned 169 after 754 usecs
[    3.768156] calling  devcoredump_init+0x0/0x18 @ 1
[    3.768216] initcall devcoredump_init+0x0/0x18 returned 0 after 40 usecs
[    3.768231] calling  brd_init+0x0/0x26a @ 1
[    3.797388] brd: module loaded
[    3.797408] initcall brd_init+0x0/0x26a returned 0 after 28473 usecs
[    3.797424] calling  loop_init+0x0/0x214 @ 1
[    3.821070] loop: module loaded
[    3.821091] initcall loop_init+0x0/0x214 returned 0 after 23093 usecs
[    3.821107] calling  xlblk_init+0x0/0xea @ 1
[    3.821130] initcall xlblk_init+0x0/0xea returned -19 after 4 usecs
[    3.821145] calling  htcpld_core_init+0x0/0x2d @ 1
[    3.821376] initcall htcpld_core_init+0x0/0x2d returned -19 after 207 usecs
[    3.821391] calling  tps65912_i2c_driver_init+0x0/0x13 @ 1
[    3.821479] initcall tps65912_i2c_driver_init+0x0/0x13 returned 0 after 67 usecs
[    3.821494] calling  tps65912_spi_driver_init+0x0/0x13 @ 1
[    3.821581] initcall tps65912_spi_driver_init+0x0/0x13 returned 0 after 67 usecs
[    3.821597] calling  twl_driver_init+0x0/0x13 @ 1
[    3.821684] initcall twl_driver_init+0x0/0x13 returned 0 after 67 usecs
[    3.821699] calling  twl4030_audio_driver_init+0x0/0x13 @ 1
[    3.821825] initcall twl4030_audio_driver_init+0x0/0x13 returned 0 after 105 usecs
[    3.821840] calling  twl6040_driver_init+0x0/0x13 @ 1
[    3.821927] initcall twl6040_driver_init+0x0/0x13 returned 0 after 66 usecs
[    3.821942] calling  smsc_i2c_driver_init+0x0/0x13 @ 1
[    3.822044] initcall smsc_i2c_driver_init+0x0/0x13 returned 0 after 81 usecs
[    3.822059] calling  da9063_i2c_driver_init+0x0/0x13 @ 1
[    3.822145] initcall da9063_i2c_driver_init+0x0/0x13 returned 0 after 66 usecs
[    3.822160] calling  max14577_i2c_init+0x0/0x13 @ 1
[    3.822247] initcall max14577_i2c_init+0x0/0x13 returned 0 after 66 usecs
[    3.822262] calling  max77693_i2c_driver_init+0x0/0x13 @ 1
[    3.822351] initcall max77693_i2c_driver_init+0x0/0x13 returned 0 after 68 usecs
[    3.822366] calling  adp5520_driver_init+0x0/0x13 @ 1
[    3.822452] initcall adp5520_driver_init+0x0/0x13 returned 0 after 65 usecs
[    3.822468] calling  intel_soc_pmic_i2c_driver_init+0x0/0x13 @ 1
[    3.822555] initcall intel_soc_pmic_i2c_driver_init+0x0/0x13 returned 0 after 67 usecs
[    3.822570] calling  e820_pmem_driver_init+0x0/0x13 @ 1
[    3.822696] initcall e820_pmem_driver_init+0x0/0x13 returned 0 after 104 usecs
[    3.822712] calling  init_sd+0x0/0x1ae @ 1
[    3.822981] initcall init_sd+0x0/0x1ae returned 0 after 244 usecs
[    3.822996] calling  init_sr+0x0/0x46 @ 1
[    3.823082] initcall init_sr+0x0/0x46 returned 0 after 66 usecs
[    3.823097] calling  init_sg+0x0/0x179 @ 1
[    3.823201] initcall init_sg+0x0/0x179 returned 0 after 83 usecs
[    3.823216] calling  nvme_core_init+0x0/0xcd @ 1
[    3.823780] initcall nvme_core_init+0x0/0xcd returned 0 after 531 usecs
[    3.823795] calling  nvme_init+0x0/0x1a @ 1
[    3.824102] nvme nvme0: pci function 0000:04:00.0
[    3.824264] initcall nvme_init+0x0/0x1a returned 0 after 439 usecs
[    3.824279] calling  piix_init+0x0/0x29 @ 1
[    3.824508] initcall piix_init+0x0/0x29 returned 0 after 205 usecs
[    3.824524] calling  sis_pci_driver_init+0x0/0x1a @ 1
[    3.824723] initcall sis_pci_driver_init+0x0/0x1a returned 0 after 176 usecs
[    3.824738] calling  ata_generic_pci_driver_init+0x0/0x1a @ 1
[    3.824939] initcall ata_generic_pci_driver_init+0x0/0x1a returned 0 after 176 usecs
[    3.824954] calling  net_olddevs_init+0x0/0x5d @ 1
[    3.824995] initcall net_olddevs_init+0x0/0x5d returned 0 after 21 usecs
[    3.825010] calling  fixed_mdio_bus_init+0x0/0xf3 @ 1
[    3.825755] libphy: Fixed MDIO Bus: probed
[    3.825774] initcall fixed_mdio_bus_init+0x0/0xf3 returned 0 after 727 usecs
[    3.825789] calling  tun_init+0x0/0x9f @ 1
[    3.825805] tun: Universal TUN/TAP device driver, 1.6
[    3.826134] initcall tun_init+0x0/0x9f returned 0 after 317 usecs
[    3.826149] calling  ppp_init+0x0/0x107 @ 1
[    3.826165] PPP generic driver version 2.4.2
[    3.826548] initcall ppp_init+0x0/0x107 returned 0 after 370 usecs
[    3.826564] calling  netif_init+0x0/0x69 @ 1
[    3.826587] initcall netif_init+0x0/0x69 returned -19 after 4 usecs
[    3.826602] calling  cdrom_init+0x0/0x16 @ 1
[    3.826645] initcall cdrom_init+0x0/0x16 returned 0 after 23 usecs
[    3.826661] calling  dwc2_platform_driver_init+0x0/0x13 @ 1
[    3.826794] initcall dwc2_platform_driver_init+0x0/0x13 returned 0 after 111 usecs
[    3.826809] calling  ehci_hcd_init+0x0/0xf0 @ 1
[    3.826826] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.826872] initcall ehci_hcd_init+0x0/0xf0 returned 0 after 42 usecs
[    3.826887] calling  ehci_pci_init+0x0/0x65 @ 1
[    3.826903] ehci-pci: EHCI PCI platform driver
[    3.827059] initcall ehci_pci_init+0x0/0x65 returned 0 after 149 usecs
[    3.827075] calling  ehci_platform_init+0x0/0x48 @ 1
[    3.827091] ehci-platform: EHCI generic platform driver
[    3.827252] initcall ehci_platform_init+0x0/0x48 returned 0 after 154 usecs
[    3.827267] calling  ohci_hcd_mod_init+0x0/0x8d @ 1
[    3.827284] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.827328] initcall ohci_hcd_mod_init+0x0/0x8d returned 0 after 41 usecs
[    3.827343] calling  ohci_pci_init+0x0/0x65 @ 1
[    3.827360] ohci-pci: OHCI PCI platform driver
[    3.827511] initcall ohci_pci_init+0x0/0x65 returned 0 after 145 usecs
[    3.827527] calling  ohci_platform_init+0x0/0x48 @ 1
[    3.827543] ohci-platform: OHCI generic platform driver
[    3.827667] initcall ohci_platform_init+0x0/0x48 returned 0 after 118 usecs
[    3.827682] calling  uhci_hcd_init+0x0/0x12c @ 1
[    3.827699] uhci_hcd: USB Universal Host Controller Interface driver
[    3.827972] initcall uhci_hcd_init+0x0/0x12c returned 0 after 264 usecs
[    3.827987] calling  xhci_hcd_init+0x0/0x1f @ 1
[    3.828113] initcall xhci_hcd_init+0x0/0x1f returned 0 after 30 usecs
[    3.828128] calling  xhci_pci_init+0x0/0x43 @ 1
[    3.828467] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    3.828476] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    3.829576] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00109810
[    3.829581] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    3.829766] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.829767] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.829769] usb usb1: Product: xHCI Host Controller
[    3.829770] usb usb1: Manufacturer: Linux 4.15.0-rc9+ xhci-hcd
[    3.829771] usb usb1: SerialNumber: 0000:00:14.0
[    3.829943] hub 1-0:1.0: USB hub found
[    3.829960] hub 1-0:1.0: 12 ports detected
[    3.830950] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    3.830959] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    3.831029] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    3.831031] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.831033] usb usb2: Product: xHCI Host Controller
[    3.831034] usb usb2: Manufacturer: Linux 4.15.0-rc9+ xhci-hcd
[    3.831036] usb usb2: SerialNumber: 0000:00:14.0
[    3.831204] hub 2-0:1.0: USB hub found
[    3.831216] hub 2-0:1.0: 6 ports detected
[    3.832264] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    3.832272] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 3
[    3.891181] xhci_hcd 0000:01:00.0: hcc params 0x0200eec1 hci version 0x110 quirks 0x00000010
[    3.891458] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    3.891459] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.891461] usb usb3: Product: xHCI Host Controller
[    3.891462] usb usb3: Manufacturer: Linux 4.15.0-rc9+ xhci-hcd
[    3.891463] usb usb3: SerialNumber: 0000:01:00.0
[    3.891617] hub 3-0:1.0: USB hub found
[    3.891626] hub 3-0:1.0: 2 ports detected
[    3.891762] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    3.891771] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 4
[    3.891780] xhci_hcd 0000:01:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    3.891822] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    3.891853] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[    3.891855] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.891857] usb usb4: Product: xHCI Host Controller
[    3.891858] usb usb4: Manufacturer: Linux 4.15.0-rc9+ xhci-hcd
[    3.891860] usb usb4: SerialNumber: 0000:01:00.0
[    3.892048] hub 4-0:1.0: USB hub found
[    3.892058] hub 4-0:1.0: 2 ports detected
[    3.892297] initcall xhci_pci_init+0x0/0x43 returned 0 after 62644 usecs
[    3.892313] calling  kgdbdbgp_start_thread+0x0/0x4d @ 1
[    3.892336] initcall kgdbdbgp_start_thread+0x0/0x4d returned 0 after 4 usecs
[    3.892352] calling  ledtrig_usb_init+0x0/0x2e @ 1
[    3.892388] initcall ledtrig_usb_init+0x0/0x2e returned 0 after 16 usecs
[    3.892403] calling  i8042_init+0x0/0x4ae @ 1
[    3.892796] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:SYNM] at 0x60,0x64 irq 1,12
[    3.896666] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.896679] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.896834] initcall i8042_init+0x0/0x4ae returned 0 after 4307 usecs
[    3.896849] calling  mousedev_init+0x0/0x81 @ 1
[    3.897488] mousedev: PS/2 mouse device common for all mice
[    3.897508] initcall mousedev_init+0x0/0x81 returned 0 after 623 usecs
[    3.897523] calling  evdev_init+0x0/0x11 @ 1
[    3.898701] initcall evdev_init+0x0/0x11 returned 0 after 1130 usecs
[    3.898716] calling  atkbd_init+0x0/0x26 @ 1
[    3.898873] initcall atkbd_init+0x0/0x26 returned 0 after 134 usecs
[    3.898889] calling  uinput_misc_init+0x0/0x11 @ 1
[    3.899226] initcall uinput_misc_init+0x0/0x11 returned 0 after 310 usecs
[    3.899242] calling  cmos_init+0x0/0x86 @ 1
[    3.899359] rtc_cmos 00:01: RTC can wake from S4
[    3.899824] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    3.899944] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    3.900097] initcall cmos_init+0x0/0x86 returned 0 after 816 usecs
[    3.900113] calling  i2c_dev_init+0x0/0xd1 @ 1
[    3.900129] i2c /dev entries driver
[    3.900184] initcall i2c_dev_init+0x0/0xd1 returned 0 after 51 usecs
[    3.900199] calling  restart_poweroff_driver_init+0x0/0x13 @ 1
[    3.900372] initcall restart_poweroff_driver_init+0x0/0x13 returned 0 after 151 usecs
[    3.900387] calling  watchdog_gov_noop_register+0x0/0x11 @ 1
[    3.900415] initcall watchdog_gov_noop_register+0x0/0x11 returned 0 after 9 usecs
[    3.900430] calling  dm_init+0x0/0xeb @ 1
[    3.900972] device-mapper: uevent: version 1.0.3
[    3.901945] device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised: dm-devel at redhat.com
[    3.901965] initcall dm_init+0x0/0xeb returned 0 after 1480 usecs
[    3.901980] calling  cpufreq_gov_powersave_init+0x0/0x11 @ 1
[    3.902006] initcall cpufreq_gov_powersave_init+0x0/0x11 returned 0 after 7 usecs
[    3.902021] calling  cpufreq_gov_userspace_init+0x0/0x11 @ 1
[    3.902046] initcall cpufreq_gov_userspace_init+0x0/0x11 returned 0 after 6 usecs
[    3.902061] calling  cpufreq_gov_dbs_init+0x0/0x11 @ 1
[    3.902086] initcall cpufreq_gov_dbs_init+0x0/0x11 returned 0 after 6 usecs
[    3.902100] calling  cpufreq_gov_dbs_init+0x0/0x11 @ 1
[    3.902126] initcall cpufreq_gov_dbs_init+0x0/0x11 returned 0 after 7 usecs
[    3.902140] calling  intel_pstate_init+0x0/0x479 @ 1
[    3.902165] intel_pstate: Intel P-state driver initializing
[    3.902450] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
[    3.903779] intel_pstate: HWP enabled
[    3.903794] initcall intel_pstate_init+0x0/0x479 returned 0 after 1598 usecs
[    3.903806] calling  ledtrig_disk_init+0x0/0x2e @ 1
[    3.903834] initcall ledtrig_disk_init+0x0/0x2e returned 0 after 13 usecs
[    3.903845] calling  ledtrig_mtd_init+0x0/0x2e @ 1
[    3.903896] initcall ledtrig_mtd_init+0x0/0x2e returned 0 after 36 usecs
[    3.903908] calling  ledtrig_cpu_init+0x0/0x121 @ 1
[    3.904216] ledtrig-cpu: registered to indicate activity on CPUs
[    3.904231] initcall ledtrig_cpu_init+0x0/0x121 returned 0 after 301 usecs
[    3.904242] calling  ledtrig_panic_init+0x0/0x39 @ 1
[    3.904267] initcall ledtrig_panic_init+0x0/0x39 returned 0 after 9 usecs
[    3.904278] calling  efivars_sysfs_init+0x0/0x2a0 @ 1
[    3.904292] EFI Variables Facility v0.08 2004-May-17
[    3.926372] initcall efivars_sysfs_init+0x0/0x2a0 returned 0 after 21560 usecs
[    3.926384] calling  esrt_sysfs_init+0x0/0x3b1 @ 1
[    3.926549] initcall esrt_sysfs_init+0x0/0x3b1 returned 0 after 145 usecs
[    3.926560] calling  skein_generic_init+0x0/0x56 @ 1
[    3.926969] initcall skein_generic_init+0x0/0x56 returned 0 after 383 usecs
[    3.926981] calling  intel_pmc_core_driver_init+0x0/0x1a @ 1
[    3.927091] intel_pmc_core 0000:00:1f.2: enabling device (0000 -> 0002)
[    3.927239] initcall intel_pmc_core_driver_init+0x0/0x1a returned 0 after 236 usecs
[    3.927251] calling  pmc_atom_init+0x0/0x296 @ 1
[    3.927342] initcall pmc_atom_init+0x0/0x296 returned -19 after 73 usecs
[    3.927354] calling  extcon_class_init+0x0/0x17 @ 1
[    3.927411] initcall extcon_class_init+0x0/0x17 returned 0 after 39 usecs
[    3.927423] calling  powercap_init+0x0/0x5b9 @ 1
[    3.927614] initcall powercap_init+0x0/0x5b9 returned 0 after 171 usecs
[    3.927626] calling  pm_check_save_msr+0x0/0x20 @ 1
[    3.927647] initcall pm_check_save_msr+0x0/0x20 returned 0 after 5 usecs
[    3.927659] calling  sock_diag_init+0x0/0x40 @ 1
[    3.927788] initcall sock_diag_init+0x0/0x40 returned 0 after 110 usecs
[    3.927800] calling  blackhole_init+0x0/0x11 @ 1
[    3.927824] initcall blackhole_init+0x0/0x11 returned 0 after 8 usecs
[    3.927836] calling  gre_offload_init+0x0/0x49 @ 1
[    3.927868] initcall gre_offload_init+0x0/0x49 returned 0 after 5 usecs
[    3.927879] calling  sysctl_ipv4_init+0x0/0x4c @ 1
[    3.927945] initcall sysctl_ipv4_init+0x0/0x4c returned 0 after 50 usecs
[    3.927956] calling  cubictcp_register+0x0/0x115 @ 1
[    3.927976] initcall cubictcp_register+0x0/0x115 returned 0 after 4 usecs
[    3.927987] calling  inet6_init+0x0/0x3af @ 1
[    3.929612] NET: Registered protocol family 10
[    3.930637] Segment Routing with IPv6
[    3.930716] initcall inet6_init+0x0/0x3af returned 0 after 2650 usecs
[    3.930728] calling  packet_init+0x0/0x42 @ 1
[    3.930742] NET: Registered protocol family 17
[    3.930778] initcall packet_init+0x0/0x42 returned 0 after 34 usecs
[    3.930789] calling  strp_mod_init+0x0/0x31 @ 1
[    3.930973] initcall strp_mod_init+0x0/0x31 returned 0 after 165 usecs
[    3.930985] calling  dcbnl_init+0x0/0x7e @ 1
[    3.931004] initcall dcbnl_init+0x0/0x7e returned 0 after 4 usecs
[    3.931015] calling  init_dns_resolver+0x0/0xcc @ 1
[    3.931047] Key type dns_resolver registered
[    3.931063] initcall init_dns_resolver+0x0/0xcc returned 0 after 32 usecs
[    3.931074] calling  nsh_init_module+0x0/0x14 @ 1
[    3.931093] initcall nsh_init_module+0x0/0x14 returned 0 after 4 usecs
[    3.931105] calling  mcheck_init_device+0x0/0x152 @ 1
[    3.931648] initcall mcheck_init_device+0x0/0x152 returned 0 after 515 usecs
[    3.931763] calling  tboot_late_init+0x0/0x2e4 @ 1
[    3.931782] initcall tboot_late_init+0x0/0x2e4 returned 0 after 4 usecs
[    3.931794] calling  intel_rdt_late_init+0x0/0x532 @ 1
[    3.931814] initcall intel_rdt_late_init+0x0/0x532 returned -19 after 5 usecs
[    3.931825] calling  mcheck_late_init+0x0/0x88 @ 1
[    3.931884] initcall mcheck_late_init+0x0/0x88 returned 0 after 43 usecs
[    3.931895] calling  severities_debugfs_init+0x0/0x3b @ 1
[    3.931933] initcall severities_debugfs_init+0x0/0x3b returned 0 after 22 usecs
[    3.931945] calling  microcode_init+0x0/0x24b @ 1
[    3.932324] microcode: sig=0x806e9, pf=0x80, revision=0x62
[    3.932736] microcode: Microcode Update Driver: v2.2.
[    3.932752] initcall microcode_init+0x0/0x24b returned 0 after 772 usecs
[    3.932764] calling  hpet_insert_resource+0x0/0x23 @ 1
[    3.932785] initcall hpet_insert_resource+0x0/0x23 returned 0 after 6 usecs
[    3.932797] calling  update_mp_table+0x0/0xccf @ 1
[    3.932815] initcall update_mp_table+0x0/0xccf returned 0 after 4 usecs
[    3.932826] calling  lapic_insert_resource+0x0/0x3f @ 1
[    3.932859] initcall lapic_insert_resource+0x0/0x3f returned 0 after 5 usecs
[    3.932870] calling  print_ICs+0x0/0x1ba @ 1
[    3.932890] initcall print_ICs+0x0/0x1ba returned 0 after 4 usecs
[    3.932902] calling  pat_memtype_list_init+0x0/0x4a @ 1
[    3.932942] initcall pat_memtype_list_init+0x0/0x4a returned 0 after 24 usecs
[    3.932953] calling  create_tlb_single_page_flush_ceiling+0x0/0x29 @ 1
[    3.932992] initcall create_tlb_single_page_flush_ceiling+0x0/0x29 returned 0 after 22 usecs
[    3.933004] calling  create_init_pkru_value+0x0/0x29 @ 1
[    3.933043] initcall create_init_pkru_value+0x0/0x29 returned 0 after 23 usecs
[    3.933055] calling  init_oops_id+0x0/0x40 @ 1
[    3.933078] initcall init_oops_id+0x0/0x40 returned 0 after 7 usecs
[    3.933090] calling  sched_clock_init_late+0x0/0x90 @ 1
[    3.933103] sched_clock: Marking stable (3932705613, 0)->(3915562367, 17143246)
[    3.933547] initcall sched_clock_init_late+0x0/0x90 returned 0 after 431 usecs
[    3.933558] calling  sched_init_debug+0x0/0x3e @ 1
[    3.933614] initcall sched_init_debug+0x0/0x3e returned 0 after 41 usecs
[    3.933625] calling  pm_qos_power_init+0x0/0x173 @ 1
[    3.934508] initcall pm_qos_power_init+0x0/0x173 returned 0 after 847 usecs
[    3.934518] calling  pm_debugfs_init+0x0/0x24 @ 1
[    3.934591] initcall pm_debugfs_init+0x0/0x24 returned 0 after 57 usecs
[    3.934604] calling  printk_late_init+0x0/0x128 @ 1
[    3.934627] initcall printk_late_init+0x0/0x128 returned 0 after 8 usecs
[    3.934638] calling  tk_debug_sleep_time_init+0x0/0x3c @ 1
[    3.934674] initcall tk_debug_sleep_time_init+0x0/0x3c returned 0 after 21 usecs
[    3.934685] calling  debugfs_kprobe_init+0x0/0xd2 @ 1
[    3.934775] initcall debugfs_kprobe_init+0x0/0xd2 returned 0 after 74 usecs
[    3.934786] calling  taskstats_init+0x0/0x37 @ 1
[    3.934820] registered taskstats version 1
[    3.934835] initcall taskstats_init+0x0/0x37 returned 0 after 33 usecs
[    3.934845] calling  init_hwlat_tracer+0x0/0xaf @ 1
[    3.934926] initcall init_hwlat_tracer+0x0/0xaf returned 0 after 65 usecs
[    3.934937] calling  kdb_ftrace_register+0x0/0x2d @ 1
[    3.934956] initcall kdb_ftrace_register+0x0/0x2d returned 0 after 4 usecs
[    3.934967] calling  load_system_certificate_list+0x0/0x173 @ 1
[    3.934979] Loading compiled-in X.509 certificates
[    3.934993] initcall load_system_certificate_list+0x0/0x173 returned 0 after 12 usecs
[    3.935004] calling  fault_around_debugfs+0x0/0x35 @ 1
[    3.935040] initcall fault_around_debugfs+0x0/0x35 returned 0 after 21 usecs
[    3.935051] calling  max_swapfiles_check+0x0/0x8 @ 1
[    3.935070] initcall max_swapfiles_check+0x0/0x8 returned 0 after 4 usecs
[    3.935081] calling  init_zswap+0x0/0x466 @ 1
[    3.935190] zswap: loaded using pool lzo/zbud
[    3.935624] initcall init_zswap+0x0/0x466 returned 0 after 516 usecs
[    3.935635] calling  split_huge_pages_debugfs+0x0/0x35 @ 1
[    3.935671] initcall split_huge_pages_debugfs+0x0/0x35 returned 0 after 21 usecs
[    3.935681] calling  check_early_ioremap_leak+0x0/0xae @ 1
[    3.935700] initcall check_early_ioremap_leak+0x0/0xae returned 0 after 4 usecs
[    3.935710] calling  init_root_keyring+0x0/0xa @ 1
[    3.935775] initcall init_root_keyring+0x0/0xa returned 0 after 49 usecs
[    3.935786] calling  big_key_init+0x0/0x95 @ 1
[    3.940904] Key type big_key registered
[    3.940921] initcall big_key_init+0x0/0x95 returned 0 after 4999 usecs
[    3.940933] calling  init_trusted+0x0/0xaf @ 1
[    3.943304] Key type trusted registered
[    3.943320] initcall init_trusted+0x0/0xaf returned 0 after 2315 usecs
[    3.943331] calling  init_encrypted+0x0/0x10c @ 1
[    3.945920] Key type encrypted registered
[    3.945935] initcall init_encrypted+0x0/0x10c returned 0 after 2528 usecs
[    3.945946] calling  init_profile_hash+0x0/0xab @ 1
[    3.945965] AppArmor: AppArmor sha1 policy hashing enabled
[    3.945979] initcall init_profile_hash+0x0/0xab returned 0 after 18 usecs
[    3.945990] calling  init_ima+0x0/0x35 @ 1
[    4.058661]  nvme0n1: p1 p2 p3 p4
[    4.164182] usb 1-5: new full-speed USB device number 2 using xhci_hcd
[    4.308545] initcall init_ima+0x0/0x35 returned 0 after 354030 usecs
[    4.308558] calling  init_evm+0x0/0x3e @ 1
[    4.308569] evm: HMAC attrs: 0x1
[    4.308601] initcall init_evm+0x0/0x3e returned 0 after 29 usecs
[    4.308612] calling  prandom_reseed+0x0/0x2a @ 1
[    4.308650] initcall prandom_reseed+0x0/0x2a returned 0 after 22 usecs
[    4.308661] calling  pci_resource_alignment_sysfs_init+0x0/0x18 @ 1
[    4.308691] initcall pci_resource_alignment_sysfs_init+0x0/0x18 returned 0 after 14 usecs
[    4.308701] calling  pci_sysfs_init+0x0/0x50 @ 1
[    4.312995] usb 1-5: New USB device found, idVendor=8087, idProduct=0a2b
[    4.312996] usb 1-5: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.316976] initcall pci_sysfs_init+0x0/0x50 returned 0 after 8064 usecs
[    4.316988] calling  bert_init+0x0/0x2bb @ 1
[    4.317010] initcall bert_init+0x0/0x2bb returned 0 after 7 usecs
[    4.317020] calling  clk_debug_init+0x0/0x13e @ 1
[    4.317131] initcall clk_debug_init+0x0/0x13e returned 0 after 93 usecs
[    4.317142] calling  boot_wait_for_devices+0x0/0x29 @ 1
[    4.317161] initcall boot_wait_for_devices+0x0/0x29 returned -19 after 4 usecs
[    4.317172] calling  dmar_free_unused_resources+0x0/0x15b @ 1
[    4.317190] initcall dmar_free_unused_resources+0x0/0x15b returned 0 after 4 usecs
[    4.317201] calling  deferred_probe_initcall+0x0/0x30 @ 1
[    4.317246] initcall deferred_probe_initcall+0x0/0x30 returned 0 after 30 usecs
[    4.317258] calling  late_resume_init+0x0/0x310 @ 1
[    4.317270]   Magic number: 2:770:698
[    4.317382] initcall late_resume_init+0x0/0x310 returned 0 after 107 usecs
[    4.317393] calling  genpd_debug_init+0x0/0x176 @ 1
[    4.317447] initcall genpd_debug_init+0x0/0x176 returned 0 after 39 usecs
[    4.317458] calling  genpd_power_off_unused+0x0/0xac @ 1
[    4.317477] initcall genpd_power_off_unused+0x0/0xac returned 0 after 5 usecs
[    4.317488] calling  sync_debugfs_init+0x0/0x5b @ 1
[    4.317560] initcall sync_debugfs_init+0x0/0x5b returned 0 after 56 usecs
[    4.317572] calling  rtc_hctosys+0x0/0x178 @ 1
[    4.317755] rtc_cmos 00:01: setting system clock to 2018-01-22 19:41:52 UTC (1516650112)
[    4.317771] initcall rtc_hctosys+0x0/0x178 returned 0 after 180 usecs
[    4.317782] calling  charger_manager_init+0x0/0xb8 @ 1
[    4.318106] initcall charger_manager_init+0x0/0xb8 returned 0 after 302 usecs
[    4.318117] calling  acpi_cpufreq_init+0x0/0x3a0 @ 1
[    4.318136] initcall acpi_cpufreq_init+0x0/0x3a0 returned -17 after 4 usecs
[    4.318147] calling  powernowk8_init+0x0/0x1d0 @ 1
[    4.318166] initcall powernowk8_init+0x0/0x1d0 returned -19 after 4 usecs
[    4.318176] calling  pcc_cpufreq_init+0x0/0x530 @ 1
[    4.318214] initcall pcc_cpufreq_init+0x0/0x530 returned -19 after 23 usecs
[    4.318225] calling  centrino_init+0x0/0x28 @ 1
[    4.318243] initcall centrino_init+0x0/0x28 returned -19 after 4 usecs
[    4.318254] calling  edd_init+0x0/0x45b @ 1
[    4.318267] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    4.318275] EDD information not available.
[    4.318289] initcall edd_init+0x0/0x45b returned -19 after 20 usecs
[    4.318299] calling  firmware_memmap_init+0x0/0x4b @ 1
[    4.319114] initcall firmware_memmap_init+0x0/0x4b returned 0 after 781 usecs
[    4.319130] calling  register_update_efi_random_seed+0x0/0x20 @ 1
[    4.319149] initcall register_update_efi_random_seed+0x0/0x20 returned 0 after 4 usecs
[    4.319160] calling  efi_shutdown_init+0x0/0x56 @ 1
[    4.319178] initcall efi_shutdown_init+0x0/0x56 returned 0 after 4 usecs
[    4.319189] calling  itmt_legacy_init+0x0/0x6f @ 1
[    4.319207] initcall itmt_legacy_init+0x0/0x6f returned -19 after 4 usecs
[    4.319218] calling  pci_mmcfg_late_insert_resources+0x0/0x64 @ 1
[    4.319238] initcall pci_mmcfg_late_insert_resources+0x0/0x64 returned 0 after 5 usecs
[    4.319249] calling  tcp_congestion_default+0x0/0x18 @ 1
[    4.319269] initcall tcp_congestion_default+0x0/0x18 returned 0 after 5 usecs
[    4.319280] calling  software_resume+0x0/0x350 @ 1
[    4.319299] initcall software_resume+0x0/0x350 returned -2 after 5 usecs
[    4.319310] calling  clear_boot_tracer+0x0/0x26 @ 1
[    4.319329] initcall clear_boot_tracer+0x0/0x26 returned 0 after 4 usecs
[    4.319340] calling  clk_disable_unused+0x0/0x200 @ 1
[    4.319359] initcall clk_disable_unused+0x0/0x200 returned 0 after 5 usecs
[    4.319370] calling  regulator_init_complete+0x0/0x36 @ 1
[    4.319393] initcall regulator_init_complete+0x0/0x36 returned 0 after 8 usecs
[    4.321164] Freeing unused kernel memory: 1824K
[    4.321165] Write protecting the kernel read-only data: 24576k
[    4.321739] Freeing unused kernel memory: 2008K
[    4.322267] Freeing unused kernel memory: 164K
[    4.339833] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    4.339834] x86/mm: Checking user space page tables
[    4.356970] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    4.440039] usb 1-6: new high-speed USB device number 3 using xhci_hcd
[    4.469832] calling  fjes_init_module+0x0/0xed [fjes] @ 163
[    4.470232] calling  acpi_video_init+0x0/0x1000 [video] @ 161
[    4.470403] initcall acpi_video_init+0x0/0x1000 [video] returned 0 after 136 usecs
[    4.474313] initcall fjes_init_module+0x0/0xed [fjes] returned -19 after 4329 usecs
[    4.489857] calling  acpi_wmi_init+0x0/0x1000 [wmi] @ 170
[    4.491271] initcall acpi_wmi_init+0x0/0x1000 [wmi] returned 0 after 1354 usecs
[    4.511986] calling  rtsx_pci_driver_init+0x0/0x1000 [rtsx_pci] @ 159
[    4.512030] calling  drm_core_init+0x0/0xe2 [drm] @ 172
[    4.512383] rtsx_pci 0000:03:00.0: enabling device (0000 -> 0002)
[    4.512879] calling  psmouse_init+0x0/0x8a [psmouse] @ 162
[    4.513284] initcall psmouse_init+0x0/0x8a [psmouse] returned 0 after 366 usecs
[    4.514722] calling  ahci_pci_driver_init+0x0/0x1000 [ahci] @ 168
[    4.514901] ahci 0000:00:17.0: version 3.0
[    4.515430] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x1 impl SATA mode
[    4.515434] ahci 0000:00:17.0: flags: 64bit ncq pm led clo only pio slum part deso sadm sds apst 
[    4.515602] initcall drm_core_init+0x0/0xe2 [drm] returned 0 after 3336 usecs
[    4.516616] initcall rtsx_pci_driver_init+0x0/0x1000 [rtsx_pci] returned 0 after 4383 usecs
[    4.516916] scsi host0: ahci
[    4.517444] calling  rtl8169_pci_driver_init+0x0/0x1000 [r8169] @ 160
[    4.517685] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    4.517702] r8169 0000:03:00.1: can't disable ASPM; OS doesn't have ASPM control
[    4.517712] r8169 0000:03:00.1: enabling device (0000 -> 0003)
[    4.518622] scsi host1: ahci
[    4.518737] ata1: SATA max UDMA/133 abar m2048 at 0xdf42b000 port 0xdf42b100 irq 133
[    4.518739] ata2: DUMMY
[    4.519116] initcall ahci_pci_driver_init+0x0/0x1000 [ahci] returned 0 after 4267 usecs
[    4.533142] r8169 0000:03:00.1 eth0: RTL8411 at 0x0000000012b01cfb, 80:fa:5b:3b:dd:f0, XID 1c800800 IRQ 134
[    4.533147] r8169 0000:03:00.1 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    4.533576] initcall rtl8169_pci_driver_init+0x0/0x1000 [r8169] returned 0 after 15724 usecs
[    4.540241] clocksource: Switched to clocksource tsc
[    4.548130] calling  drm_kms_helper_init+0x0/0x14 [drm_kms_helper] @ 172
[    4.548260] initcall drm_kms_helper_init+0x0/0x14 [drm_kms_helper] returned 0 after 94 usecs
[    4.567095] r8169 0000:03:00.1 enp3s0f1: renamed from eth0
[    4.600573] calling  rtsx_pci_sdmmc_driver_init+0x0/0x1000 [rtsx_pci_sdmmc] @ 159
[    4.602170] initcall rtsx_pci_sdmmc_driver_init+0x0/0x1000 [rtsx_pci_sdmmc] returned 0 after 1543 usecs
[    4.603636] calling  i915_init+0x0/0x59 [i915] @ 172
[    4.606550] [drm] Memory usable by graphics device = 4096M
[    4.606555] [drm] Replacing VGA console driver
[    4.612181] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    4.612182] [drm] Driver supports precise vblank timestamp query.
[    4.614365] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    4.614736] [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_01.bin (v1.1)
[    4.632692] usb 1-6: New USB device found, idVendor=5986, idProduct=1112
[    4.632694] usb 1-6: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    4.632695] usb 1-6: Product: BisonCam,NB Pro
[    4.632697] usb 1-6: Manufacturer: Bison
[    4.632698] usb 1-6: SerialNumber: 200901010001
[    4.640467] [drm] Initialized i915 1.6.0 20171023 for 0000:00:02.0 on minor 0
[    4.642710] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    4.643046] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input7
[    4.643483] initcall i915_init+0x0/0x59 [i915] returned 0 after 38859 usecs
[    4.677459] fbcon: inteldrmfb (fb0) is primary device
[    4.828179] ata1: SATA link down (SStatus 4 SControl 300)
[    5.317642] psmouse serio1: synaptics: queried max coordinates: x [..5718], y [..4908]
[    5.355812] psmouse serio1: synaptics: queried min coordinates: x [1238..], y [956..]
[    5.355815] psmouse serio1: synaptics: The touchpad can support a better bus than the too old PS/2 protocol. Make sure MOUSE_PS2_SYNAPTICS_SMBUS and RMI4_SMB are enabled to get a better touchpad experience.
[    5.423197] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf00223/0x840300/0x26800/0x0, board id: 3175, fw id: 2330500
[    5.467586] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input6
[    5.820340] [drm] RC6 on
[    5.834576] Console: switching to colour frame buffer device 240x67
[    5.855345] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    5.984842] calling  dm_dirty_log_init+0x0/0x1000 [dm_log] @ 234
[    5.984861] initcall dm_dirty_log_init+0x0/0x1000 [dm_log] returned 0 after 3 usecs
[    5.987563] calling  dm_mirror_init+0x0/0x1000 [dm_mirror] @ 234
[    5.987588] initcall dm_mirror_init+0x0/0x1000 [dm_mirror] returned 0 after 4 usecs
[    5.990546] calling  linear_init+0x0/0x1000 [linear] @ 239
[    5.990566] initcall linear_init+0x0/0x1000 [linear] returned 0 after 1 usecs
[    5.993529] calling  multipath_init+0x0/0x1000 [multipath] @ 242
[    5.993548] initcall multipath_init+0x0/0x1000 [multipath] returned 0 after 1 usecs
[    5.996495] calling  raid0_init+0x0/0x1000 [raid0] @ 245
[    5.996515] initcall raid0_init+0x0/0x1000 [raid0] returned 0 after 2 usecs
[    5.999873] calling  raid_init+0x0/0x1000 [raid1] @ 248
[    5.999894] initcall raid_init+0x0/0x1000 [raid1] returned 0 after 1 usecs
[    6.002779] calling  libcrc32c_mod_init+0x0/0x1000 [libcrc32c] @ 251
[    6.002812] initcall libcrc32c_mod_init+0x0/0x1000 [libcrc32c] returned 0 after 14 usecs
[    6.004401] calling  init_module+0x0/0x1000 [raid6_pq] @ 251
[    6.072037] raid6: sse2x1   gen()  9305 MB/s
[    6.140037] raid6: sse2x1   xor()  5991 MB/s
[    6.208033] raid6: sse2x2   gen() 10701 MB/s
[    6.276032] raid6: sse2x2   xor()  6887 MB/s
[    6.344031] raid6: sse2x4   gen() 11956 MB/s
[    6.412031] raid6: sse2x4   xor()  7880 MB/s
[    6.480040] raid6: avx2x1   gen() 15342 MB/s
[    6.548031] raid6: avx2x1   xor()  9414 MB/s
[    6.616034] raid6: avx2x2   gen() 17393 MB/s
[    6.684032] raid6: avx2x2   xor() 10273 MB/s
[    6.752034] raid6: avx2x4   gen() 19023 MB/s
[    6.820033] raid6: avx2x4   xor() 11380 MB/s
[    6.820060] raid6: using algorithm avx2x4 gen() 19023 MB/s
[    6.820068] raid6: .... xor() 11380 MB/s, rmw enabled
[    6.820076] raid6: using avx2x2 recovery algorithm
[    6.820092] initcall init_module+0x0/0x1000 [raid6_pq] returned 0 after 796553 usecs
[    6.821142] calling  calibrate_xor_blocks+0x0/0xf0e [xor] @ 251
[    6.821151] xor: automatically using best checksumming function   avx       
[    6.821163] initcall calibrate_xor_blocks+0x0/0xf0e [xor] returned 0 after 9 usecs
[    6.822061] calling  async_tx_init+0x0/0x1000 [async_tx] @ 251
[    6.822077] async_tx: api initialized (async)
[    6.822092] initcall async_tx_init+0x0/0x1000 [async_tx] returned 0 after 15 usecs
[    6.824278] calling  async_pq_init+0x0/0x1000 [async_pq] @ 251
[    6.824297] initcall async_pq_init+0x0/0x1000 [async_pq] returned 0 after 4 usecs
[    6.830183] calling  raid5_init+0x0/0x1000 [raid456] @ 251
[    6.830529] initcall raid5_init+0x0/0x1000 [raid456] returned 0 after 319 usecs
[    6.837472] calling  raid_init+0x0/0x1000 [raid10] @ 268
[    6.837487] initcall raid_init+0x0/0x1000 [raid10] returned 0 after 1 usecs
[    6.920455] calling  init_btrfs_fs+0x0/0x129 [btrfs] @ 283
[    6.925414] Btrfs loaded, crc32c=crc32c-intel
[    6.925471] initcall init_btrfs_fs+0x0/0x129 [btrfs] returned 0 after 4849 usecs
[   11.988432] EXT4-fs (nvme0n1p3): mounted filesystem with ordered data mode. Opts: (null)
[   12.111211] calling  init_autofs4_fs+0x0/0x26 [autofs4] @ 1
[   12.111410] initcall init_autofs4_fs+0x0/0x26 [autofs4] returned 0 after 181 usecs
[   12.115786] calling  xt_init+0x0/0x1000 [x_tables] @ 1
[   12.115811] initcall xt_init+0x0/0x1000 [x_tables] returned 0 after 12 usecs
[   12.117725] calling  ip_tables_init+0x0/0x1000 [ip_tables] @ 1
[   12.117757] ip_tables: (C) 2000-2006 Netfilter Core Team
[   12.117769] initcall ip_tables_init+0x0/0x1000 [ip_tables] returned 0 after 31 usecs
[   12.154844] systemd[1]: systemd 234 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN default-hierarchy=hybrid)
[   12.172103] systemd[1]: Detected architecture x86-64.
[   12.172949] systemd[1]: Set hostname to <helmuth-N24-25BU>.
[   12.237495] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   12.237715] systemd[1]: Created slice System Slice.
[   12.238370] systemd[1]: Mounting POSIX Message Queue File System...
[   12.239068] systemd[1]: Mounting Kernel Debug File System...
[   12.239191] systemd[1]: Listening on Journal Socket.
[   12.240238] systemd[1]: Starting Set the console keyboard layout...
[   12.241594] systemd[1]: Starting Nameserver information manager...
[   12.258574] calling  dm_crypt_init+0x0/0x1000 [dm_crypt] @ 357
[   12.258603] initcall dm_crypt_init+0x0/0x1000 [dm_crypt] returned 0 after 4 usecs
[   12.267918] calling  parport_default_proc_register+0x0/0x1000 [parport] @ 357
[   12.268348] initcall parport_default_proc_register+0x0/0x1000 [parport] returned 0 after 392 usecs
[   12.271876] calling  lp_init_module+0x0/0x1000 [lp] @ 357
[   12.276554] lp: driver loaded but no devices found
[   12.276605] initcall lp_init_module+0x0/0x1000 [lp] returned 0 after 4591 usecs
[   12.279752] calling  ppdev_init+0x0/0x1000 [ppdev] @ 357
[   12.282549] ppdev: user-space parallel port driver
[   12.282575] initcall ppdev_init+0x0/0x1000 [ppdev] returned 0 after 2732 usecs
[   12.287523] calling  parport_pc_init+0x0/0xec5 [parport_pc] @ 357
[   12.295182] initcall parport_pc_init+0x0/0xec5 [parport_pc] returned 0 after 7451 usecs
[   12.353382] EXT4-fs (nvme0n1p3): re-mounted. Opts: (null)
[   12.425724] systemd-journald[361]: Received request to flush runtime journal from PID 1
[   12.619943] calling  fjes_init_module+0x0/0xed [fjes] @ 443
[   12.621234] calling  mac_hid_init+0x0/0x1000 [mac_hid] @ 439
[   12.621293] initcall mac_hid_init+0x0/0x1000 [mac_hid] returned 0 after 30 usecs
[   12.625512] calling  acpi_pad_init+0x0/0x1000 [acpi_pad] @ 450
[   12.625841] initcall fjes_init_module+0x0/0xed [fjes] returned -19 after 5725 usecs
[   12.642598] initcall acpi_pad_init+0x0/0x1000 [acpi_pad] returned 0 after 16657 usecs
[   12.642609] calling  crb_acpi_driver_init+0x0/0x1000 [tpm_crb] @ 452
[   12.647543] initcall crb_acpi_driver_init+0x0/0x1000 [tpm_crb] returned 0 after 4798 usecs
[   12.713426] calling  fjes_init_module+0x0/0xed [fjes] @ 445
[   12.720923] initcall fjes_init_module+0x0/0xed [fjes] returned -19 after 7289 usecs
[   12.798669] calling  intel_pch_thermal_driver_init+0x0/0x1000 [intel_pch_thermal] @ 453
[   12.799291] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   12.800920] initcall intel_pch_thermal_driver_init+0x0/0x1000 [intel_pch_thermal] returned 0 after 2172 usecs
[   12.802341] calling  shpcd_init+0x0/0x1000 [shpchp] @ 451
[   12.802684] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   12.802710] initcall shpcd_init+0x0/0x1000 [shpchp] returned 0 after 333 usecs
[   12.805823] calling  init_soundcore+0x0/0x1000 [soundcore] @ 440
[   12.805939] initcall init_soundcore+0x0/0x1000 [soundcore] returned 0 after 86 usecs
[   12.812269] calling  mei_init+0x0/0xac [mei] @ 438
[   12.812554] initcall mei_init+0x0/0xac [mei] returned 0 after 249 usecs
[   12.834858] calling  alsa_sound_init+0x0/0x82 [snd] @ 440
[   12.835076] initcall alsa_sound_init+0x0/0x82 [snd] returned 0 after 184 usecs
[   12.843747] calling  memstick_init+0x0/0x1000 [memstick] @ 451
[   12.848399] initcall memstick_init+0x0/0x1000 [memstick] returned 0 after 4513 usecs
[   12.852336] calling  rtsx_pci_ms_driver_init+0x0/0x1000 [rtsx_pci_ms] @ 451
[   12.855437] initcall rtsx_pci_ms_driver_init+0x0/0x1000 [rtsx_pci_ms] returned 0 after 2999 usecs
[   12.877752] calling  serio_raw_drv_init+0x0/0x1000 [serio_raw] @ 441
[   12.878008] initcall serio_raw_drv_init+0x0/0x1000 [serio_raw] returned 0 after 222 usecs
[   12.878261] calling  alsa_timer_init+0x0/0x1000 [snd_timer] @ 440
[   12.878916] initcall alsa_timer_init+0x0/0x1000 [snd_timer] returned 0 after 614 usecs
[   12.880794] calling  mei_me_driver_init+0x0/0x1000 [mei_me] @ 438
[   12.881129] initcall mei_me_driver_init+0x0/0x1000 [mei_me] returned 0 after 261 usecs
[   12.885623] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[   12.890023] calling  input_leds_init+0x0/0x1000 [input_leds] @ 451
[   12.891007] initcall input_leds_init+0x0/0x1000 [input_leds] returned 0 after 935 usecs
[   12.891558] calling  cfg80211_init+0x0/0xcb [cfg80211] @ 445
[   12.895655] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   12.901537] calling  alsa_pcm_init+0x0/0x1000 [snd_pcm] @ 440
[   12.901603] initcall alsa_pcm_init+0x0/0x1000 [snd_pcm] returned 0 after 33 usecs
[   12.908096] calling  alsa_hwdep_init+0x0/0x1000 [snd_hwdep] @ 440
[   12.908155] initcall alsa_hwdep_init+0x0/0x1000 [snd_hwdep] returned 0 after 32 usecs
[   12.912187] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   12.913059] initcall cfg80211_init+0x0/0xcb [cfg80211] returned 0 after 20949 usecs
[   12.913205] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   12.913208] cfg80211: failed to load regulatory.db
[   12.916326] calling  joydev_init+0x0/0x1000 [joydev] @ 447
[   12.916395] initcall joydev_init+0x0/0x1000 [joydev] returned 0 after 42 usecs
[   12.955984] calling  hda_bus_init+0x0/0x11 [snd_hda_core] @ 440
[   12.956560] initcall hda_bus_init+0x0/0x11 [snd_hda_core] returned 0 after 531 usecs
[   12.957898] calling  aes_init+0x0/0x1000 [aes_x86_64] @ 522
[   12.961046] initcall aes_init+0x0/0x1000 [aes_x86_64] returned 0 after 3046 usecs
[   12.965699] calling  cryptd_init+0x0/0x1000 [cryptd] @ 522
[   12.965756] initcall cryptd_init+0x0/0x1000 [cryptd] returned 0 after 29 usecs
[   12.977785] calling  aesni_init+0x0/0x363 [aesni_intel] @ 522
[   12.977805] AVX2 version of gcm_enc/dec engaged.
[   12.977822] AES CTR mode by8 optimization enabled
[   13.001963] calling  rapl_pmu_init+0x0/0x1000 [intel_rapl_perf] @ 454
[   13.002320] calling  iwl_drv_init+0x0/0xc8 [iwlwifi] @ 445
[   13.002340] Intel(R) Wireless WiFi driver for Linux
[   13.002356] Copyright(c) 2003- 2015 Intel Corporation
[   13.002656] iwlwifi 0000:02:00.0: enabling device (0000 -> 0002)
[   13.004243] initcall iwl_drv_init+0x0/0xc8 [iwlwifi] returned 0 after 1836 usecs
[   13.004398] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-8000C-34.ucode failed with error -2
[   13.004557] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-8000C-33.ucode failed with error -2
[   13.004695] iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-8000C-32.ucode failed with error -2
[   13.004863] random: crng init done
[   13.009522] iwlwifi 0000:02:00.0: loaded firmware version 31.560484.0 op_mode iwlmvm
[   13.012348] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[   13.012366] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   13.012383] RAPL PMU: hw unit of domain package 2^-14 Joules
[   13.012400] RAPL PMU: hw unit of domain dram 2^-14 Joules
[   13.012416] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[   13.012433] RAPL PMU: hw unit of domain psys 2^-14 Joules
[   13.012460] initcall rapl_pmu_init+0x0/0x1000 [intel_rapl_perf] returned 0 after 10224 usecs
[   13.016965] calling  cstate_pmu_init+0x0/0xeef [intel_cstate] @ 438
[   13.020788] initcall cstate_pmu_init+0x0/0xeef [intel_cstate] returned 0 after 3703 usecs
[   13.073049] calling  init_nls_iso8859_1+0x0/0x1000 [nls_iso8859_1] @ 580
[   13.073079] initcall init_nls_iso8859_1+0x0/0x1000 [nls_iso8859_1] returned 0 after 2 usecs
[   13.079247] calling  azx_driver_init+0x0/0xfd8 [snd_hda_intel] @ 440
[   13.079531] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[   13.079902] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[   13.081310] initcall azx_driver_init+0x0/0xfd8 [snd_hda_intel] returned 0 after 1985 usecs
[   13.091049] calling  ieee80211_init+0x0/0x35 [mac80211] @ 558
[   13.091129] initcall ieee80211_init+0x0/0x35 [mac80211] returned 0 after 30 usecs
[   13.112855] calling  crypto_pcbc_module_init+0x0/0x1000 [pcbc] @ 618
[   13.112894] initcall crypto_pcbc_module_init+0x0/0x1000 [pcbc] returned 0 after 10 usecs
[   13.116416] calling  iwl_mvm_init+0x0/0x1000 [iwlmvm] @ 558
[   13.116573] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band Wireless AC 8260, REV=0x208
[   13.125238] initcall aesni_init+0x0/0x363 [aesni_intel] returned 0 after 143962 usecs
[   13.130741] calling  generic_driver_init+0x0/0x1000 [snd_hda_codec_generic] @ 626
[   13.131049] initcall generic_driver_init+0x0/0x1000 [snd_hda_codec_generic] returned 0 after 272 usecs
[   13.134571] calling  padlock_init+0x0/0x1000 [padlock_aes] @ 522
[   13.134597] initcall padlock_init+0x0/0x1000 [padlock_aes] returned -19 after 1 usecs
[   13.138742] calling  ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] @ 447
[   13.139794] initcall ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] returned 0 after 1000 usecs
[   13.143269] calling  crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] @ 454
[   13.146932] calling  realtek_driver_init+0x0/0x1000 [snd_hda_codec_realtek] @ 626
[   13.147549] initcall crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] returned 0 after 4138 usecs
[   13.147640] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC269VC: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   13.147645] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   13.147648] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
[   13.147652] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   13.147655] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   13.147663] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
[   13.147668] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
[   13.151534] calling  crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] @ 438
[   13.153288] initcall crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] returned 0 after 1667 usecs
[   13.157623] initcall realtek_driver_init+0x0/0x1000 [snd_hda_codec_realtek] returned 0 after 10409 usecs
[   13.187130] EXT4-fs (nvme0n1p4): mounted filesystem with ordered data mode. Opts: (null)
[   13.196073] calling  hdmi_driver_init+0x0/0x1000 [snd_hda_codec_hdmi] @ 655
[   13.198074] iwlwifi 0000:02:00.0: base HW address: e4:a7:a0:c4:b7:3d
[   13.207016] initcall hdmi_driver_init+0x0/0x1000 [snd_hda_codec_hdmi] returned 0 after 10655 usecs
[   13.208981] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input8
[   13.209117] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input9
[   13.209248] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input10
[   13.209378] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input11
[   13.209511] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[   13.209645] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[   13.209776] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[   13.248821] calling  init_misc_binfmt+0x0/0x1000 [binfmt_misc] @ 688
[   13.248853] initcall init_misc_binfmt+0x0/0x1000 [binfmt_misc] returned 0 after 7 usecs
[   13.286576] calling  arc4_init+0x0/0x1000 [arc4] @ 715
[   13.287881] initcall arc4_init+0x0/0x1000 [arc4] returned 0 after 1254 usecs
[   13.291399] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[   13.293248] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[   13.293367] thermal thermal_zone2: failed to read out thermal zone (-61)
[   13.294892] initcall iwl_mvm_init+0x0/0x1000 [iwlmvm] returned 0 after 174260 usecs
[   13.297664] calling  vmx_init+0x0/0xe0c [kvm_intel] @ 687
[   13.305216] initcall vmx_init+0x0/0xe0c [kvm_intel] returned 0 after 7347 usecs
[   13.309805] calling  coretemp_init+0x0/0x1000 [coretemp] @ 447
[   13.311598] initcall coretemp_init+0x0/0x1000 [coretemp] returned 0 after 1723 usecs
[   13.329608] calling  powerclamp_init+0x0/0x1000 [intel_powerclamp] @ 438
[   13.330111] initcall powerclamp_init+0x0/0x1000 [intel_powerclamp] returned 0 after 464 usecs
[   13.335845] calling  pkg_temp_thermal_init+0x0/0x1000 [x86_pkg_temp_thermal] @ 450
[   13.342590] initcall pkg_temp_thermal_init+0x0/0x1000 [x86_pkg_temp_thermal] returned 0 after 6557 usecs
[   13.347488] calling  rapl_init+0x0/0x1000 [intel_rapl] @ 454
[   13.347902] intel_rapl: Found RAPL domain package
[   13.347905] intel_rapl: Found RAPL domain core
[   13.347907] intel_rapl: Found RAPL domain uncore
[   13.347909] intel_rapl: Found RAPL domain dram
[   13.349259] initcall rapl_init+0x0/0x1000 [intel_rapl] returned 0 after 1702 usecs
[   13.404138] audit: type=1400 audit(1516650121.582:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/sbin/dhclient" pid=788 comm="apparmor_parser"
[   13.404145] audit: type=1400 audit(1516650121.582:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=788 comm="apparmor_parser"
[   13.404151] audit: type=1400 audit(1516650121.582:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=788 comm="apparmor_parser"
[   13.404156] audit: type=1400 audit(1516650121.582:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/connman/scripts/dhclient-script" pid=788 comm="apparmor_parser"
[   13.404648] audit: type=1400 audit(1516650121.582:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/freshclam" pid=793 comm="apparmor_parser"
[   13.405175] audit: type=1400 audit(1516650121.582:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/lightdm/lightdm-guest-session" pid=787 comm="apparmor_parser"
[   13.405182] audit: type=1400 audit(1516650121.582:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/lightdm/lightdm-guest-session//chromium" pid=787 comm="apparmor_parser"
[   13.407323] audit: type=1400 audit(1516650121.582:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-senddoc" pid=795 comm="apparmor_parser"
[   13.407527] audit: type=1400 audit(1516650121.582:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-oopslash" pid=794 comm="apparmor_parser"
[   13.411978] audit: type=1400 audit(1516650121.586:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-xpdfimport" pid=797 comm="apparmor_parser"
[   13.541721] iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
[   13.645593] Adding 8388092k swap on /dev/mapper/cryptswap1.  Priority:-2 extents:1 across:8388092k SSFS
[   14.006833] calling  alsa_seq_device_init+0x0/0x1000 [snd_seq_device] @ 1416
[   14.007098] initcall alsa_seq_device_init+0x0/0x1000 [snd_seq_device] returned 0 after 235 usecs
[   14.015371] calling  alsa_seq_init+0x0/0x4b [snd_seq] @ 1416
[   14.015990] initcall alsa_seq_init+0x0/0x4b [snd_seq] returned 0 after 575 usecs
[   14.029336] calling  snd_hrtimer_init+0x0/0x1000 [snd_hrtimer] @ 1437
[   14.029372] initcall snd_hrtimer_init+0x0/0x1000 [snd_hrtimer] returned 0 after 9 usecs
[   14.415793] IPv6: ADDRCONF(NETDEV_UP): enp3s0f1: link is not ready
[   14.438220] r8169 0000:03:00.1 enp3s0f1: link down
[   14.438342] IPv6: ADDRCONF(NETDEV_UP): enp3s0f1: link is not ready
[   14.442391] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
[   14.673480] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
[   14.753720] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
[   18.499029] calling  media_devnode_init+0x0/0x1000 [media] @ 450
[   18.499049] media: Linux media interface: v0.10
[   18.499363] initcall media_devnode_init+0x0/0x1000 [media] returned 0 after 298 usecs
[   18.517287] calling  videodev_init+0x0/0x7e [videodev] @ 450
[   18.517306] Linux video capture interface: v2.00
[   18.517475] initcall videodev_init+0x0/0x7e [videodev] returned 0 after 150 usecs
[   18.547193] calling  uvc_init+0x0/0x1000 [uvcvideo] @ 450
[   18.662660] uvcvideo: Found UVC 1.00 device BisonCam,NB Pro (5986:1112)
[   18.666653] uvcvideo 1-6:1.0: Entity type for entity Realtek Extended Controls Unit was not initialized!
[   18.666664] uvcvideo 1-6:1.0: Entity type for entity Extension 4 was not initialized!
[   18.666675] uvcvideo 1-6:1.0: Entity type for entity Processing 2 was not initialized!
[   18.666684] uvcvideo 1-6:1.0: Entity type for entity Camera 1 was not initialized!
[   18.666887] input: BisonCam,NB Pro: BisonCam,NB Pr as /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.0/input/input15
[   18.667277] usbcore: registered new interface driver uvcvideo
[   18.667288] USB Video Class driver (1.1.1)
[   18.667310] initcall uvc_init+0x0/0x1000 [uvcvideo] returned 0 after 117273 usecs
[   18.983151] wlp2s0: authenticate with c8:3a:35:0f:68:f8
[   18.992077] wlp2s0: send auth to c8:3a:35:0f:68:f8 (try 1/3)
[   18.999048] wlp2s0: authenticated
[   19.000054] wlp2s0: associate with c8:3a:35:0f:68:f8 (try 1/3)
[   19.003437] wlp2s0: RX AssocResp from c8:3a:35:0f:68:f8 (capab=0x411 status=0 aid=1)
[   19.017794] wlp2s0: associated
[   19.046013] calling  crypto_ccm_module_init+0x0/0x1000 [ccm] @ 6838
[   19.046058] initcall crypto_ccm_module_init+0x0/0x1000 [ccm] returned 0 after 24 usecs
[   19.061707] IPv6: ADDRCONF(NETDEV_CHANGE): wlp2s0: link becomes ready
[   19.712305] Could not find key with description: [8ac72712aa32e6df]
[   19.712311] process_request_key_err: No key
[   19.712312] Could not find valid key in user session keyring for sig specified in mount option: [8ac72712aa32e6df]
[   19.712315] One or more global auth toks could not properly register; rc = [-2]
[   19.712318] Error parsing options; rc = [-2]
[   24.170968] calling  ecdh_init+0x0/0x20 [ecdh_generic] @ 449
[   24.171169] initcall ecdh_init+0x0/0x20 [ecdh_generic] returned 0 after 167 usecs
[   24.189969] calling  bt_init+0x0/0xae [bluetooth] @ 449
[   24.189988] Bluetooth: Core ver 2.22
[   24.190199] NET: Registered protocol family 31
[   24.190217] Bluetooth: HCI device and connection manager initialized
[   24.190251] Bluetooth: HCI socket layer initialized
[   24.190284] Bluetooth: L2CAP socket layer initialized
[   24.190428] Bluetooth: SCO socket layer initialized
[   24.190508] initcall bt_init+0x0/0xae [bluetooth] returned 0 after 485 usecs
[   24.206978] calling  btusb_driver_init+0x0/0x1000 [btusb] @ 449
[   24.341121] usbcore: registered new interface driver btusb
[   24.341148] initcall btusb_driver_init+0x0/0x1000 [btusb] returned 0 after 131000 usecs
[   24.341377] Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
[   24.348394] Bluetooth: hci0: Device revision is 5
[   24.348397] Bluetooth: hci0: Secure boot is enabled
[   24.348398] Bluetooth: hci0: OTP lock is enabled
[   24.348400] Bluetooth: hci0: API lock is enabled
[   24.348401] Bluetooth: hci0: Debug lock is disabled
[   24.348403] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   24.351166] Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
[   25.772785] Bluetooth: hci0: Waiting for firmware download to complete
[   25.773373] Bluetooth: hci0: Firmware loaded in 1399103 usecs
[   25.773434] Bluetooth: hci0: Waiting for device to boot
[   25.784359] Bluetooth: hci0: Device booted in 10688 usecs
[   25.786013] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.ddc
[   25.790367] Bluetooth: hci0: Applying Intel DDC parameters completed
[   28.778209] calling  bnep_init+0x0/0x9b [bnep] @ 15554
[   28.778227] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   28.778242] Bluetooth: BNEP filters: protocol multicast
[   28.778270] Bluetooth: BNEP socket layer initialized
[   28.778291] initcall bnep_init+0x0/0x9b [bnep] returned 0 after 57 usecs
[   28.790182] calling  rfcomm_init+0x0/0xd1 [rfcomm] @ 15556
[   28.790612] Bluetooth: RFCOMM TTY layer initialized
[   28.790634] Bluetooth: RFCOMM socket layer initialized
[   28.790670] Bluetooth: RFCOMM ver 1.11
[   28.790711] initcall rfcomm_init+0x0/0xd1 [rfcomm] returned 0 after 493 usecs
[   29.968133] calling  crypto_cmac_module_init+0x0/0x1000 [cmac] @ 15617
[   29.968162] initcall crypto_cmac_module_init+0x0/0x1000 [cmac] returned 0 after 7 usecs
[ 2335.392861] PM: suspend entry (deep)
[ 2335.392865] PM: Syncing filesystems ... done.
[ 2335.407905] Freezing user space processes ... (elapsed 0.016 seconds) done.
[ 2335.424438] OOM killer disabled.
[ 2335.424452] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
[ 2335.427567] Suspending console(s) (use no_console_suspend to debug)
[ 2335.435323] calling  rfkill1+ @ 20130, parent: hci0
[ 2335.435338] call rfkill1+ returned 0 after 6 usecs
[ 2335.435354] calling  input15+ @ 20130, parent: 1-6:1.0
[ 2335.435367] call input15+ returned 0 after 4 usecs
[ 2335.435394] calling  coretemp.0+ @ 20130, parent: platform
[ 2335.435406] call coretemp.0+ returned 0 after 3 usecs
[ 2335.435421] calling  rfkill0+ @ 20130, parent: phy0
[ 2335.435436] call rfkill0+ returned 0 after 6 usecs
[ 2335.435450] calling  phy0-led+ @ 20130, parent: 0000:02:00.0
[ 2335.435455] calling  phy0+ @ 53, parent: 0000:02:00.0
[ 2335.435469] call phy0-led+ returned 0 after 5 usecs
[ 2335.435485] calling  input14+ @ 20130, parent: card0
[ 2335.435489] wlp2s0: deauthenticating from c8:3a:35:0f:68:f8 by local choice (Reason: 3=DEAUTH_LEAVING)
[ 2335.435504] call input14+ returned 0 after 6 usecs
[ 2335.435521] calling  input13+ @ 20130, parent: card0
[ 2335.435539] call input13+ returned 0 after 5 usecs
[ 2335.435555] calling  input12+ @ 20130, parent: card0
[ 2335.435572] call input12+ returned 0 after 5 usecs
[ 2335.435583] calling  input11+ @ 20130, parent: card0
[ 2335.435595] call input11+ returned 0 after 3 usecs
[ 2335.435606] calling  input10+ @ 20130, parent: card0
[ 2335.435618] call input10+ returned 0 after 3 usecs
[ 2335.435629] calling  input9+ @ 20130, parent: card0
[ 2335.435641] call input9+ returned 0 after 3 usecs
[ 2335.435652] calling  input8+ @ 20130, parent: card0
[ 2335.435664] call input8+ returned 0 after 3 usecs
[ 2335.435713] calling  regulatory.0+ @ 20130, parent: platform
[ 2335.435725] call regulatory.0+ returned 0 after 3 usecs
[ 2335.435732] calling  hdaudioC0D2+ @ 19614, parent: 0000:00:1f.3
[ 2335.435735] calling  hdaudioC0D0+ @ 18870, parent: 0000:00:1f.3
[ 2335.435737] calling  input4::scrolllock+ @ 20130, parent: input4
[ 2335.435748] call input4::scrolllock+ returned 0 after 3 usecs
[ 2335.435755] call hdaudioC0D0+ returned 0 after 8 usecs
[ 2335.435758] call hdaudioC0D2+ returned 0 after 8 usecs
[ 2335.435759] calling  input4::capslock+ @ 20130, parent: input4
[ 2335.435770] call input4::capslock+ returned 0 after 3 usecs
[ 2335.435780] calling  input4::numlock+ @ 20130, parent: input4
[ 2335.435791] call input4::numlock+ returned 0 after 3 usecs
[ 2335.435825] calling  input6+ @ 20130, parent: serio1
[ 2335.435838] call input6+ returned 0 after 4 usecs
[ 2335.435851] calling  input7+ @ 20130, parent: LNXVIDEO:00
[ 2335.435864] call input7+ returned 0 after 4 usecs
[ 2335.435886] calling  intel_backlight+ @ 20130, parent: card0-eDP-1
[ 2335.435899] call intel_backlight+ returned 0 after 5 usecs
[ 2335.435932] calling  rtsx_pci_ms.0+ @ 20130, parent: 0000:03:00.0
[ 2335.435971] calling  1-6+ @ 18870, parent: usb1
[ 2335.435975] calling  host1+ @ 19614, parent: ata2
[ 2335.435993] call host1+ returned 0 after 7 usecs
[ 2335.435995] call 1-6+ returned 0 after 7 usecs
[ 2335.436001] calling  host0+ @ 20136, parent: ata1
[ 2335.436062] call host0+ returned 0 after 46 usecs
[ 2335.436065] call rtsx_pci_ms.0+ returned 0 after 120 usecs
[ 2335.436077] calling  rtsx_pci_sdmmc.0+ @ 20130, parent: 0000:03:00.0
[ 2335.436089] call rtsx_pci_sdmmc.0+ returned 0 after 3 usecs
[ 2335.436110] calling  ata2+ @ 20136, parent: 0000:00:17.0
[ 2335.436128] call ata2+ returned 0 after 5 usecs
[ 2335.436145] calling  ata1+ @ 20136, parent: 0000:00:17.0
[ 2335.436163] call ata1+ returned 0 after 5 usecs
[ 2335.436165] calling  microcode+ @ 20130, parent: platform
[ 2335.436180] call microcode+ returned 0 after 5 usecs
[ 2335.436187] calling  1-5+ @ 5, parent: usb1
[ 2335.436203] call 1-5+ returned 0 after 5 usecs
[ 2335.436206] calling  input4+ @ 20130, parent: serio0
[ 2335.436220] call input4+ returned 0 after 4 usecs
[ 2335.436231] calling  rtc0+ @ 20130, parent: 00:01
[ 2335.436243] call rtc0+ returned 0 after 3 usecs
[ 2335.436262] calling  serio1+ @ 20130, parent: i8042
[ 2335.451351] wlp2s0: failed to remove key (1, ff:ff:ff:ff:ff:ff) from hardware (-22)
[ 2335.478983] call phy0+ returned 0 after 42487 usecs
[ 2335.481023] call serio1+ returned 0 after 43694 usecs
[ 2335.481057] calling  serio0+ @ 20130, parent: i8042
[ 2335.481741] call serio0+ returned 0 after 641 usecs
[ 2335.481775] calling  i8042+ @ 20130, parent: platform
[ 2335.483188] call i8042+ returned 0 after 1355 usecs
[ 2335.483364] calling  Fixed MDIO bus.0+ @ 20130, parent: platform
[ 2335.483420] call Fixed MDIO bus.0+ returned 0 after 16 usecs
[ 2335.483478] calling  usb4+ @ 53, parent: 0000:01:00.0
[ 2335.483511] calling  usb3+ @ 18870, parent: 0000:01:00.0
[ 2335.483682] calling  usb1+ @ 20136, parent: 0000:00:14.0
[ 2335.483751] calling  usb2+ @ 5, parent: 0000:00:14.0
[ 2335.483993] calling  serial8250+ @ 20130, parent: platform
[ 2335.484039] call serial8250+ returned 0 after 15 usecs
[ 2335.484102] calling  input3+ @ 20130, parent: LNXPWRBN:00
[ 2335.484144] call input3+ returned 0 after 13 usecs
[ 2335.484172] calling  input2+ @ 20130, parent: PNP0C0D:00
[ 2335.484208] call input2+ returned 0 after 11 usecs
[ 2335.484236] calling  input1+ @ 20130, parent: PNP0C0E:00
[ 2335.484273] call input1+ returned 0 after 12 usecs
[ 2335.484300] calling  input0+ @ 20130, parent: PNP0C0C:00
[ 2335.484337] call input0+ returned 0 after 13 usecs
[ 2335.484428] calling  alarmtimer+ @ 20130, parent: platform
[ 2335.484473] call alarmtimer+ returned 0 after 20 usecs
[ 2335.484512] calling  platform-framebuffer.0+ @ 20130, parent: platform
[ 2335.484546] call platform-framebuffer.0+ returned 0 after 10 usecs
[ 2335.484573] calling  pcspkr+ @ 20130, parent: platform
[ 2335.484607] call pcspkr+ returned 0 after 9 usecs
[ 2335.484899] calling  00:08+ @ 20130, parent: pnp0
[ 2335.484938] call 00:08+ returned 0 after 14 usecs
[ 2335.484965] calling  00:07+ @ 20130, parent: pnp0
[ 2335.485019] call 00:07+ returned 0 after 22 usecs
[ 2335.485057] calling  00:06+ @ 20130, parent: pnp0
[ 2335.485093] call 00:06+ returned 0 after 12 usecs
[ 2335.485120] calling  00:05+ @ 20130, parent: pnp0
[ 2335.485157] call 00:05+ returned 0 after 12 usecs
[ 2335.485184] calling  00:04+ @ 20130, parent: pnp0
[ 2335.485221] call 00:04+ returned 0 after 12 usecs
[ 2335.485248] calling  00:03+ @ 20130, parent: pnp0
[ 2335.485284] call 00:03+ returned 0 after 12 usecs
[ 2335.485311] calling  00:02+ @ 20130, parent: pnp0
[ 2335.485348] call 00:02+ returned 0 after 12 usecs
[ 2335.485375] calling  00:01+ @ 20130, parent: pnp0
[ 2335.485569] call 00:01+ returned 0 after 166 usecs
[ 2335.485597] calling  00:00+ @ 20130, parent: pnp0
[ 2335.485633] call 00:00+ returned 0 after 12 usecs
[ 2335.485685] calling  LNXPWRBN:00+ @ 20130, parent: LNXSYSTM:00
[ 2335.485720] call LNXPWRBN:00+ returned 0 after 10 usecs
[ 2335.485748] calling  PNP0C14:00+ @ 20130, parent: platform
[ 2335.485791] call PNP0C14:00+ returned 0 after 18 usecs
[ 2335.485818] calling  PNP0C0A:00+ @ 20130, parent: platform
[ 2335.485852] call PNP0C0A:00+ returned 0 after 10 usecs
[ 2335.485879] calling  ACPI0003:00+ @ 20130, parent: platform
[ 2335.485913] call ACPI0003:00+ returned 0 after 10 usecs
[ 2335.485940] calling  PNP0C0D:00+ @ 20130, parent: platform
[ 2335.485974] call PNP0C0D:00+ returned 0 after 10 usecs
[ 2335.486002] calling  PNP0C0E:00+ @ 20130, parent: platform
[ 2335.486035] call PNP0C0E:00+ returned 0 after 9 usecs
[ 2335.486062] calling  PNP0C0C:00+ @ 20130, parent: platform
[ 2335.486096] call PNP0C0C:00+ returned 0 after 9 usecs
[ 2335.486123] calling  MSFT0101:00+ @ 20130, parent: platform
[ 2335.506007] call usb2+ returned 0 after 21696 usecs
[ 2335.506234] call usb1+ returned 0 after 21990 usecs
[ 2335.527075] call usb3+ returned 0 after 42498 usecs
[ 2335.527114] call usb4+ returned 0 after 42566 usecs
[ 2335.557261] call MSFT0101:00+ returned 0 after 69442 usecs
[ 2335.557296] calling  INT0E0C:00+ @ 20130, parent: platform
[ 2335.557331] call INT0E0C:00+ returned 0 after 11 usecs
[ 2335.557360] calling  ACPI000C:00+ @ 20130, parent: platform
[ 2335.557394] call ACPI000C:00+ returned 0 after 9 usecs
[ 2335.557422] calling  PNP0C09:00+ @ 20130, parent: 0000:00:1f.0
[ 2335.557456] call PNP0C09:00+ returned 0 after 9 usecs
[ 2335.557484] calling  PNP0103:00+ @ 20130, parent: 0000:00:1f.0
[ 2335.557517] call PNP0103:00+ returned 0 after 9 usecs
[ 2335.557545] calling  INT0800:00+ @ 20130, parent: 0000:00:1f.0
[ 2335.557578] call INT0800:00+ returned 0 after 9 usecs
[ 2335.557689] calling  0000:04:00.0+ @ 53, parent: 0000:00:1d.0
[ 2335.557701] calling  LNXTHERM:00+ @ 20130, parent: LNXSYBUS:01
[ 2335.557729] calling  0000:03:00.1+ @ 18870, parent: 0000:00:1c.5
[ 2335.557769] calling  0000:03:00.0+ @ 20136, parent: 0000:00:1c.5
[ 2335.557801] call LNXTHERM:00+ returned 0 after 50 usecs
[ 2335.557816] calling  0000:02:00.0+ @ 5, parent: 0000:00:1c.2
[ 2335.557880] calling  PNP0C0D:00+ @ 20130, parent: LNXSYBUS:00
[ 2335.557886] call 0000:02:00.0+ returned 0 after 26 usecs
[ 2335.557932] calling  0000:01:00.0+ @ 5, parent: 0000:00:1c.0
[ 2335.557938] call PNP0C0D:00+ returned 0 after 15 usecs
[ 2335.557970] calling  PNP0C0E:00+ @ 20130, parent: LNXSYBUS:00
[ 2335.558022] call PNP0C0E:00+ returned 0 after 13 usecs
[ 2335.558061] calling  PNP0C0C:00+ @ 20130, parent: LNXSYBUS:00
[ 2335.558113] call PNP0C0C:00+ returned 0 after 14 usecs
[ 2335.558213] call 0000:03:00.1+ returned 0 after 427 usecs
[ 2335.558271] calling  0000:00:1f.4+ @ 18870, parent: pci0000:00
[ 2335.558340] call 0000:00:1f.4+ returned 0 after 23 usecs
[ 2335.558396] calling  0000:00:1f.3+ @ 18870, parent: pci0000:00
[ 2335.558570] calling  0000:00:1f.2+ @ 20139, parent: pci0000:00
[ 2335.558877] call 0000:00:1f.2+ returned 0 after 255 usecs
[ 2335.559070] calling  PNP0C09:00+ @ 20130, parent: device:20
[ 2335.559142] call PNP0C09:00+ returned 0 after 24 usecs
[ 2335.559471] calling  0000:00:1f.0+ @ 20138, parent: pci0000:00
[ 2335.559540] call 0000:00:1f.0+ returned 0 after 22 usecs
[ 2335.559594] call 0000:01:00.0+ returned 0 after 1581 usecs
[ 2335.559641] calling  reg-dummy+ @ 20130, parent: platform
[ 2335.559696] call reg-dummy+ returned 0 after 16 usecs
[ 2335.559766] calling  0000:00:1c.2+ @ 19614, parent: pci0000:00
[ 2335.559855] call 0000:00:1c.2+ returned 0 after 42 usecs
[ 2335.559901] calling  0000:00:1c.0+ @ 19614, parent: pci0000:00
[ 2335.559959] call 0000:00:1c.0+ returned 0 after 28 usecs
[ 2335.559997] calling  0000:00:17.0+ @ 19614, parent: pci0000:00
[ 2335.560056] calling  0000:00:16.0+ @ 20139, parent: pci0000:00
[ 2335.560324] calling  0000:00:14.2+ @ 20140, parent: pci0000:00
[ 2335.560396] call 0000:00:14.2+ returned 0 after 33 usecs
[ 2335.560448] calling  0000:00:14.0+ @ 20140, parent: pci0000:00
[ 2335.560476] calling  0000:00:08.0+ @ 20141, parent: pci0000:00
[ 2335.560533] call 0000:00:08.0+ returned 0 after 18 usecs
[ 2335.560580] calling  0000:00:02.0+ @ 20141, parent: pci0000:00
[ 2335.560632] calling  0000:00:00.0+ @ 20142, parent: pci0000:00
[ 2335.560700] call 0000:00:00.0+ returned 0 after 23 usecs
[ 2335.560711] call 0000:00:14.0+ returned 0 after 218 usecs
[ 2335.578791] call 0000:03:00.0+ returned 0 after 20482 usecs
[ 2335.578876] calling  0000:00:1c.5+ @ 5, parent: pci0000:00
[ 2335.578968] call 0000:00:1c.5+ returned 0 after 48 usecs
[ 2335.579380] call 0000:00:17.0+ returned 0 after 18899 usecs
[ 2335.583349] call 0000:00:16.0+ returned 0 after 22708 usecs
[ 2335.599165] call 0000:00:1f.3+ returned 0 after 39772 usecs
[ 2335.870480] call 0000:00:02.0+ returned 0 after 302598 usecs
[ 2335.900862] call 0000:04:00.0+ returned 0 after 335088 usecs
[ 2335.900963] calling  0000:00:1d.0+ @ 20138, parent: pci0000:00
[ 2335.901021] call 0000:00:1d.0+ returned 0 after 29 usecs
[ 2335.903188] calling  PNP0C14:00+ @ 20130, parent: platform
[ 2335.903235] call PNP0C14:00+ returned 0 after 18 usecs
[ 2335.903283] calling  MSFT0101:00+ @ 20130, parent: platform
[ 2335.903327] call MSFT0101:00+ returned 0 after 17 usecs
[ 2335.903413] calling  0000:04:00.0+ @ 20141, parent: 0000:00:1d.0
[ 2335.903475] call 0000:04:00.0+ returned 0 after 20 usecs
[ 2335.903488] calling  0000:03:00.1+ @ 20136, parent: 0000:00:1c.5
[ 2335.903502] calling  0000:03:00.0+ @ 18870, parent: 0000:00:1c.5
[ 2335.903539] calling  0000:02:00.0+ @ 20141, parent: 0000:00:1c.2
[ 2335.903553] call 0000:03:00.1+ returned 0 after 28 usecs
[ 2335.903583] call 0000:03:00.0+ returned 0 after 29 usecs
[ 2335.903615] call 0000:02:00.0+ returned 0 after 26 usecs
[ 2335.903623] calling  0000:01:00.0+ @ 20136, parent: 0000:00:1c.0
[ 2335.903639] calling  0000:00:1f.4+ @ 18870, parent: pci0000:00
[ 2335.903677] calling  0000:00:1f.3+ @ 20141, parent: pci0000:00
[ 2335.903686] call 0000:01:00.0+ returned 0 after 26 usecs
[ 2335.903716] call 0000:00:1f.4+ returned 0 after 26 usecs
[ 2335.903731] calling  0000:00:1f.2+ @ 20136, parent: pci0000:00
[ 2335.903755] call 0000:00:1f.3+ returned 0 after 28 usecs
[ 2335.903780] calling  0000:00:1f.0+ @ 18870, parent: pci0000:00
[ 2335.903793] call 0000:00:1f.2+ returned 0 after 27 usecs
[ 2335.903812] calling  0000:00:1d.0+ @ 20141, parent: pci0000:00
[ 2335.903839] calling  0000:00:1c.5+ @ 20136, parent: pci0000:00
[ 2335.903856] call 0000:00:1f.0+ returned 0 after 24 usecs
[ 2335.903887] call 0000:00:1d.0+ returned 0 after 25 usecs
[ 2335.903916] call 0000:00:1c.5+ returned 0 after 25 usecs
[ 2335.903923] calling  0000:00:1c.2+ @ 18870, parent: pci0000:00
[ 2335.903947] calling  0000:00:1c.0+ @ 20141, parent: pci0000:00
[ 2335.903975] calling  0000:00:17.0+ @ 20136, parent: pci0000:00
[ 2335.903983] call 0000:00:1c.2+ returned 0 after 23 usecs
[ 2335.904022] call 0000:00:1c.0+ returned 0 after 25 usecs
[ 2335.904030] calling  0000:00:16.0+ @ 18870, parent: pci0000:00
[ 2335.904051] call 0000:00:17.0+ returned 0 after 26 usecs
[ 2335.904081] calling  0000:00:14.2+ @ 20141, parent: pci0000:00
[ 2335.904092] call 0000:00:16.0+ returned 0 after 27 usecs
[ 2335.904109] calling  0000:00:14.0+ @ 20136, parent: pci0000:00
[ 2335.904136] calling  0000:00:08.0+ @ 18870, parent: pci0000:00
[ 2335.904159] call 0000:00:14.2+ returned 0 after 26 usecs
[ 2335.904183] call 0000:00:14.0+ returned 0 after 24 usecs
[ 2335.904208] call 0000:00:08.0+ returned 0 after 25 usecs
[ 2335.904223] calling  0000:00:02.0+ @ 20141, parent: pci0000:00
[ 2335.904240] calling  0000:00:00.0+ @ 20136, parent: pci0000:00
[ 2335.904314] call 0000:00:00.0+ returned 0 after 24 usecs
[ 2335.922824] call 0000:00:02.0+ returned 0 after 18125 usecs
[ 2335.923548] calling  PNP0C14:00+ @ 20130, parent: platform
[ 2335.923562] call PNP0C14:00+ returned 0 after 5 usecs
[ 2335.923577] calling  MSFT0101:00+ @ 20130, parent: platform
[ 2335.923590] call MSFT0101:00+ returned 0 after 4 usecs
[ 2335.923616] calling  0000:04:00.0+ @ 53, parent: 0000:00:1d.0
[ 2335.923626] calling  0000:03:00.0+ @ 20136, parent: 0000:00:1c.5
[ 2335.923638] calling  0000:01:00.0+ @ 18870, parent: 0000:00:1c.0
[ 2335.923650] call 0000:03:00.0+ returned 0 after 10 usecs
[ 2335.923668] calling  0000:00:1f.4+ @ 20136, parent: pci0000:00
[ 2335.923818] call 0000:00:1f.4+ returned 0 after 133 usecs
[ 2335.923836] calling  0000:00:1f.3+ @ 20136, parent: pci0000:00
[ 2335.923913] calling  PNP0C09:00+ @ 20130, parent: device:20
[ 2335.923936] call PNP0C09:00+ returned 0 after 7 usecs
[ 2335.924046] calling  0000:00:1f.2+ @ 19614, parent: pci0000:00
[ 2335.924057] calling  0000:00:1f.0+ @ 20138, parent: pci0000:00
[ 2335.924181] call 0000:00:1f.2+ returned 0 after 115 usecs
[ 2335.924185] calling  0000:02:00.0+ @ 20141, parent: 0000:00:1c.2
[ 2335.924192] call 0000:00:1f.0+ returned 0 after 116 usecs
[ 2335.924205] calling  0000:03:00.1+ @ 20140, parent: 0000:00:1c.5
[ 2335.924800] calling  0000:00:17.0+ @ 20143, parent: pci0000:00
[ 2335.925005] calling  0000:00:16.0+ @ 20142, parent: pci0000:00
[ 2335.925183] calling  0000:00:14.2+ @ 20144, parent: pci0000:00
[ 2335.925225] calling  0000:00:14.0+ @ 20145, parent: pci0000:00
[ 2335.925262] calling  0000:00:08.0+ @ 20146, parent: pci0000:00
[ 2335.925299] calling  0000:00:02.0+ @ 20147, parent: pci0000:00
[ 2335.925322] call 0000:00:02.0+ returned 0 after 8 usecs
[ 2335.925343] calling  0000:00:00.0+ @ 20147, parent: pci0000:00
[ 2335.925485] call 0000:00:08.0+ returned 0 after 203 usecs
[ 2335.925499] call 0000:00:00.0+ returned 0 after 140 usecs
[ 2335.942741] call 0000:04:00.0+ returned 0 after 18659 usecs
[ 2335.942744] call 0000:00:17.0+ returned 0 after 17508 usecs
[ 2335.942776] calling  0000:00:1d.0+ @ 19614, parent: pci0000:00
[ 2335.943020] call 0000:02:00.0+ returned 0 after 18379 usecs
[ 2335.943024] call 0000:00:16.0+ returned 0 after 17581 usecs
[ 2335.943040] call 0000:03:00.1+ returned 0 after 18376 usecs
[ 2335.943144] call 0000:01:00.0+ returned 0 after 19030 usecs
[ 2335.943199] call 0000:00:14.2+ returned 0 after 17576 usecs
[ 2335.943249] calling  0000:00:1c.0+ @ 20139, parent: pci0000:00
[ 2335.943574] calling  0000:00:1c.5+ @ 20138, parent: pci0000:00
[ 2335.943674] calling  0000:00:1c.2+ @ 5, parent: pci0000:00
[ 2335.943866] call 0000:00:1f.3+ returned 0 after 19531 usecs
[ 2335.962758] call 0000:00:1c.0+ returned 0 after 19015 usecs
[ 2335.962766] call 0000:00:1d.0+ returned 0 after 19490 usecs
[ 2335.962773] call 0000:00:1c.2+ returned 0 after 18608 usecs
[ 2335.962781] call 0000:00:1c.5+ returned 0 after 18711 usecs
[ 2335.967251] call 0000:00:14.0+ returned 0 after 41023 usecs
[ 2335.968274] ACPI: Preparing to enter system sleep state S3
[ 2335.989968] ACPI: EC: event blocked
[ 2335.989990] ACPI: EC: EC stopped
[ 2335.990016] PM: Saving platform NVS memory
[ 2335.990086] Disabling non-boot CPUs ...
[ 2336.003857] IRQ 135: no longer affine to CPU1
[ 2336.005739] smpboot: CPU 1 is now offline
[ 2336.027687] IRQ 123: no longer affine to CPU2
[ 2336.027699] IRQ 125: no longer affine to CPU2
[ 2336.027708] IRQ 126: no longer affine to CPU2
[ 2336.027721] IRQ 133: no longer affine to CPU2
[ 2336.029629] smpboot: CPU 2 is now offline
[ 2336.059665] IRQ 1: no longer affine to CPU3
[ 2336.059675] IRQ 8: no longer affine to CPU3
[ 2336.059683] IRQ 9: no longer affine to CPU3
[ 2336.059691] IRQ 12: no longer affine to CPU3
[ 2336.059703] IRQ 124: no longer affine to CPU3
[ 2336.060801] smpboot: CPU 3 is now offline
[ 2336.063711] PM: Calling kvm_suspend+0x0/0x20 [kvm]
[ 2336.063750] PM: Calling mce_syscore_suspend+0x0/0x20
[ 2336.063786] PM: Calling ledtrig_cpu_syscore_suspend+0x0/0x20
[ 2336.063828] PM: Calling timekeeping_suspend+0x0/0x440
[ 2336.063995] PM: Calling irq_gc_suspend+0x0/0x90
[ 2336.064032] PM: Calling save_ioapic_entries+0x0/0x300
[ 2336.065645] PM: Calling i8259A_suspend+0x0/0x30
[ 2336.065684] PM: Calling fw_suspend+0x0/0x20
[ 2336.065718] PM: Calling acpi_save_bm_rld+0x0/0x20
[ 2336.065762] PM: Calling lapic_suspend+0x0/0x340
[ 2336.067836] ACPI: Low-level resume complete
[ 2336.067960] ACPI: EC: EC started
[ 2336.067961] PM: Restoring platform NVS memory
[ 2336.067998] PM: Calling bsp_resume+0x0/0x40
[ 2336.068011] PM: Calling lapic_resume+0x0/0x500
[ 2336.068066] PM: Calling acpi_restore_bm_rld+0x0/0x60
[ 2336.068084] PM: Calling irqrouter_resume+0x0/0x60
[ 2336.068097] PM: Calling i8259A_resume+0x0/0x30
[ 2336.068276] PM: Calling i8237A_resume+0x0/0x80
[ 2336.068417] PM: Calling ioapic_resume+0x0/0x320
[ 2336.068672] PM: Calling irq_gc_resume+0x0/0xa0
[ 2336.068684] PM: Calling irq_pm_syscore_resume+0x0/0x10
[ 2336.069113] PM: Calling timekeeping_resume+0x0/0x2e0
[ 2336.069280] PM: Calling ledtrig_cpu_syscore_resume+0x0/0x10
[ 2336.069295] PM: Calling mce_syscore_resume+0x0/0x50
[ 2336.069338] PM: Calling mc_bp_resume+0x0/0x170
[ 2336.069369] PM: Calling kvm_resume+0x0/0x30 [kvm]
[ 2336.069410] Enabling non-boot CPUs ...
[ 2336.069651] x86: Booting SMP configuration:
[ 2336.069660] smpboot: Booting Node 0 Processor 1 APIC 0x2
[ 2336.071878]  cache: parent cpu1 should not be sleeping
[ 2336.072172] CPU1 is up
[ 2336.072360] smpboot: Booting Node 0 Processor 2 APIC 0x1
[ 2336.072959]  cache: parent cpu2 should not be sleeping
[ 2336.073211] CPU2 is up
[ 2336.073396] smpboot: Booting Node 0 Processor 3 APIC 0x3
[ 2336.073925]  cache: parent cpu3 should not be sleeping
[ 2336.074181] CPU3 is up
[ 2336.079076] ACPI: Waking up from system sleep state S3
[ 2336.223484] calling  0000:00:00.0+ @ 5, parent: pci0000:00
[ 2336.223486] calling  0000:00:02.0+ @ 20145, parent: pci0000:00
[ 2336.223532] calling  0000:00:08.0+ @ 20138, parent: pci0000:00
[ 2336.223602] call 0000:00:00.0+ returned 0 after 103 usecs
[ 2336.223616] calling  0000:00:14.0+ @ 5, parent: pci0000:00
[ 2336.223681] call 0000:00:08.0+ returned 0 after 133 usecs
[ 2336.223684] calling  0000:00:14.2+ @ 20139, parent: pci0000:00
[ 2336.223696] calling  0000:00:16.0+ @ 20138, parent: pci0000:00
[ 2336.223731] calling  0000:00:17.0+ @ 19614, parent: pci0000:00
[ 2336.223774] calling  0000:00:1c.0+ @ 20136, parent: pci0000:00
[ 2336.223783] calling  0000:00:1c.2+ @ 20144, parent: pci0000:00
[ 2336.223788] calling  0000:00:1c.5+ @ 18870, parent: pci0000:00
[ 2336.223823] calling  0000:00:1d.0+ @ 20140, parent: pci0000:00
[ 2336.223863] calling  0000:00:1f.0+ @ 20141, parent: pci0000:00
[ 2336.223869] calling  0000:00:1f.2+ @ 20142, parent: pci0000:00
[ 2336.223875] calling  0000:00:1f.3+ @ 53, parent: pci0000:00
[ 2336.223984] calling  PNP0C09:00+ @ 20130, parent: device:20
[ 2336.224002] call PNP0C09:00+ returned 0 after 5 usecs
[ 2336.224032] call 0000:00:1f.0+ returned 0 after 155 usecs
[ 2336.224043] calling  0000:00:1f.4+ @ 20141, parent: pci0000:00
[ 2336.224078] call 0000:00:1f.2+ returned 0 after 190 usecs
[ 2336.224154] call 0000:00:1f.4+ returned 0 after 100 usecs
[ 2336.240477] call 0000:00:16.0+ returned 0 after 16366 usecs
[ 2336.240784] call 0000:00:1d.0+ returned 0 after 16541 usecs
[ 2336.240825] call 0000:00:1c.5+ returned 0 after 16612 usecs
[ 2336.240831] call 0000:00:1c.2+ returned 0 after 16626 usecs
[ 2336.240879] calling  0000:02:00.0+ @ 20141, parent: 0000:00:1c.2
[ 2336.240886] calling  0000:03:00.1+ @ 20148, parent: 0000:00:1c.5
[ 2336.241299] calling  0000:03:00.0+ @ 20143, parent: 0000:00:1c.5
[ 2336.241338] call 0000:00:1c.0+ returned 0 after 17138 usecs
[ 2336.241384] calling  0000:01:00.0+ @ 20142, parent: 0000:00:1c.0
[ 2336.241426] calling  0000:04:00.0+ @ 20147, parent: 0000:00:1d.0
[ 2336.241435] calling  MSFT0101:00+ @ 20130, parent: platform
[ 2336.241442] call 0000:00:17.0+ returned 0 after 17273 usecs
[ 2336.241482] call MSFT0101:00+ returned 0 after 20 usecs
[ 2336.241539] calling  PNP0C14:00+ @ 20130, parent: platform
[ 2336.241595] call PNP0C14:00+ returned 0 after 19 usecs
[ 2336.241874] call 0000:00:14.2+ returned 0 after 17748 usecs
[ 2336.242120] call 0000:00:02.0+ returned 0 after 18185 usecs
[ 2336.248266] call 0000:00:1f.3+ returned 0 after 23802 usecs
[ 2336.261315] call 0000:04:00.0+ returned 0 after 19387 usecs
[ 2336.261431] calling  i8042+ @ 20130, parent: platform
[ 2336.261479] call i8042+ returned 0 after 14 usecs
[ 2336.261566] call 0000:01:00.0+ returned 0 after 19671 usecs
[ 2336.261673] call 0000:02:00.0+ returned 0 after 20266 usecs
[ 2336.261710] call 0000:03:00.1+ returned 0 after 20308 usecs
[ 2336.262300] call 0000:03:00.0+ returned 0 after 20477 usecs
[ 2336.268322] call 0000:00:14.0+ returned 0 after 43642 usecs
[ 2336.268921] calling  0000:00:02.0+ @ 20189, parent: pci0000:00
[ 2336.270485] calling  MSFT0101:00+ @ 20130, parent: platform
[ 2336.270525] call MSFT0101:00+ returned 0 after 17 usecs
[ 2336.270561] calling  PNP0C14:00+ @ 20130, parent: platform
[ 2336.270599] call PNP0C14:00+ returned 0 after 16 usecs
[ 2336.274532] call 0000:00:02.0+ returned 0 after 5448 usecs
[ 2336.274905] calling  0000:00:00.0+ @ 20189, parent: pci0000:00
[ 2336.274959] calling  0000:00:02.0+ @ 20172, parent: pci0000:00
[ 2336.274964] call 0000:00:00.0+ returned 0 after 22 usecs
[ 2336.274980] calling  0000:00:08.0+ @ 20171, parent: pci0000:00
[ 2336.275001] calling  0000:00:14.0+ @ 20189, parent: pci0000:00
[ 2336.275045] call 0000:00:08.0+ returned 0 after 26 usecs
[ 2336.275095] calling  0000:00:14.2+ @ 20171, parent: pci0000:00
[ 2336.275164] call 0000:00:14.2+ returned 0 after 27 usecs
[ 2336.275210] calling  0000:00:16.0+ @ 20171, parent: pci0000:00
[ 2336.276116] calling  reg-dummy+ @ 20130, parent: platform
[ 2336.276182] call reg-dummy+ returned 0 after 19 usecs
[ 2336.276481] calling  PNP0C09:00+ @ 20130, parent: device:20
[ 2336.276534] ACPI: EC: event unblocked
[ 2336.276638] call PNP0C09:00+ returned 0 after 114 usecs
[ 2336.276655] calling  0000:00:17.0+ @ 20191, parent: pci0000:00
[ 2336.276792] call 0000:00:17.0+ returned 0 after 94 usecs
[ 2336.276842] calling  0000:00:1c.0+ @ 20191, parent: pci0000:00
[ 2336.276918] call 0000:00:1c.0+ returned 0 after 33 usecs
[ 2336.276963] calling  0000:00:1c.2+ @ 20191, parent: pci0000:00
[ 2336.277035] call 0000:00:1c.2+ returned 0 after 31 usecs
[ 2336.277078] calling  0000:00:1c.5+ @ 20191, parent: pci0000:00
[ 2336.277118] call 0000:00:14.0+ returned 0 after 2027 usecs
[ 2336.277151] call 0000:00:1c.5+ returned 0 after 35 usecs
[ 2336.277167] calling  0000:00:1d.0+ @ 20189, parent: pci0000:00
[ 2336.277199] calling  0000:00:1f.0+ @ 20191, parent: pci0000:00
[ 2336.277243] call 0000:00:1d.0+ returned 0 after 34 usecs
[ 2336.277264] call 0000:00:1f.0+ returned 0 after 24 usecs
[ 2336.277277] calling  PNP0C0C:00+ @ 20130, parent: LNXSYBUS:00
[ 2336.277293] calling  0000:00:1f.2+ @ 20189, parent: pci0000:00
[ 2336.277312] calling  0000:00:1f.3+ @ 20191, parent: pci0000:00
[ 2336.277339] call PNP0C0C:00+ returned 0 after 16 usecs
[ 2336.277382] calling  PNP0C0E:00+ @ 20130, parent: LNXSYBUS:00
[ 2336.277399] call 0000:00:1f.2+ returned 0 after 64 usecs
[ 2336.277439] call PNP0C0E:00+ returned 0 after 15 usecs
[ 2336.277448] calling  0000:00:1f.4+ @ 20189, parent: pci0000:00
[ 2336.277487] calling  PNP0C0D:00+ @ 20130, parent: LNXSYBUS:00
[ 2336.277506] call 0000:00:1f.4+ returned 0 after 27 usecs
[ 2336.277519] calling  0000:01:00.0+ @ 20173, parent: 0000:00:1c.0
[ 2336.277555] calling  0000:02:00.0+ @ 20189, parent: 0000:00:1c.2
[ 2336.277676] call 0000:02:00.0+ returned 0 after 78 usecs
[ 2336.277726] calling  0000:03:00.0+ @ 20189, parent: 0000:00:1c.5
[ 2336.278022] calling  0000:03:00.1+ @ 20188, parent: 0000:00:1c.5
[ 2336.278452] call 0000:03:00.0+ returned 0 after 667 usecs
[ 2336.278502] calling  0000:04:00.0+ @ 20189, parent: 0000:00:1d.0
[ 2336.278590] call 0000:04:00.0+ returned 0 after 46 usecs
[ 2336.278635] calling  usb1+ @ 20189, parent: 0000:00:14.0
[ 2336.279874] ACPI: button: The lid device is not compliant to SW_LID.
[ 2336.280193] call PNP0C0D:00+ returned 0 after 2601 usecs
[ 2336.280241] calling  ACPI0003:00+ @ 20130, parent: LNXSYBUS:00
[ 2336.284549] call 0000:01:00.0+ returned 0 after 6824 usecs
[ 2336.285126] calling  usb2+ @ 20159, parent: 0000:00:14.0
[ 2336.286332] call usb2+ returned 0 after 1136 usecs
[ 2336.286389] calling  usb3+ @ 20159, parent: 0000:01:00.0
[ 2336.286653] calling  usb4+ @ 20154, parent: 0000:01:00.0
[ 2336.287006] calling  ata1+ @ 20143, parent: 0000:00:17.0
[ 2336.287132] calling  ata2+ @ 20185, parent: 0000:00:17.0
[ 2336.287169] call ata1+ returned 0 after 110 usecs
[ 2336.287222] calling  host0+ @ 20143, parent: ata1
[ 2336.287295] call usb4+ returned 0 after 590 usecs
[ 2336.287308] call host0+ returned 0 after 41 usecs
[ 2336.287316] call ata2+ returned 0 after 132 usecs
[ 2336.287358] calling  host1+ @ 20154, parent: ata2
[ 2336.287410] call usb3+ returned 0 after 962 usecs
[ 2336.287440] call host1+ returned 0 after 39 usecs
[ 2336.287528] calling  phy0+ @ 20193, parent: 0000:02:00.0
[ 2336.287632] call 0000:00:16.0+ returned 0 after 12093 usecs
[ 2336.296476] call 0000:03:00.1+ returned 0 after 17984 usecs
[ 2336.298425] call 0000:00:1f.3+ returned 0 after 20579 usecs
[ 2336.298464] calling  hdaudioC0D0+ @ 20184, parent: 0000:00:1f.3
[ 2336.298504] call hdaudioC0D0+ returned 0 after 15 usecs
[ 2336.298546] calling  hdaudioC0D2+ @ 20153, parent: 0000:00:1f.3
[ 2336.298583] call hdaudioC0D2+ returned 0 after 12 usecs
[ 2336.298738] r8169 0000:03:00.1 enp3s0f1: link down
[ 2336.302221] call ACPI0003:00+ returned 0 after 21427 usecs
[ 2336.302237] calling  PNP0C0A:00+ @ 20130, parent: LNXSYBUS:00
[ 2336.303353] call PNP0C0A:00+ returned 0 after 1076 usecs
[ 2336.303371] calling  LNXTHERM:00+ @ 20130, parent: LNXSYBUS:01
[ 2336.303404] call LNXTHERM:00+ returned 0 after 22 usecs
[ 2336.303434] calling  INT0800:00+ @ 20130, parent: 0000:00:1f.0
[ 2336.303450] call INT0800:00+ returned 0 after 4 usecs
[ 2336.303461] calling  PNP0103:00+ @ 20130, parent: 0000:00:1f.0
[ 2336.303476] call PNP0103:00+ returned 0 after 4 usecs
[ 2336.303488] calling  PNP0C09:00+ @ 20130, parent: 0000:00:1f.0
[ 2336.303502] call PNP0C09:00+ returned 0 after 4 usecs
[ 2336.303514] calling  ACPI000C:00+ @ 20130, parent: platform
[ 2336.303528] call ACPI000C:00+ returned 0 after 4 usecs
[ 2336.303540] calling  INT0E0C:00+ @ 20130, parent: platform
[ 2336.303554] call INT0E0C:00+ returned 0 after 4 usecs
[ 2336.303566] calling  MSFT0101:00+ @ 20130, parent: platform
[ 2336.303582] call MSFT0101:00+ returned 0 after 4 usecs
[ 2336.303593] calling  PNP0C0C:00+ @ 20130, parent: platform
[ 2336.303608] call PNP0C0C:00+ returned 0 after 4 usecs
[ 2336.303620] calling  PNP0C0E:00+ @ 20130, parent: platform
[ 2336.303634] call PNP0C0E:00+ returned 0 after 4 usecs
[ 2336.303646] calling  PNP0C0D:00+ @ 20130, parent: platform
[ 2336.303660] call PNP0C0D:00+ returned 0 after 4 usecs
[ 2336.303672] calling  ACPI0003:00+ @ 20130, parent: platform
[ 2336.303686] call ACPI0003:00+ returned 0 after 4 usecs
[ 2336.303698] calling  PNP0C0A:00+ @ 20130, parent: platform
[ 2336.303712] call PNP0C0A:00+ returned 0 after 4 usecs
[ 2336.303725] calling  LNXPWRBN:00+ @ 20130, parent: LNXSYSTM:00
[ 2336.303740] call LNXPWRBN:00+ returned 0 after 4 usecs
[ 2336.303758] calling  00:00+ @ 20130, parent: pnp0
[ 2336.303775] call 00:00+ returned 0 after 5 usecs
[ 2336.303786] calling  00:01+ @ 20130, parent: pnp0
[ 2336.304219] call 00:01+ returned 0 after 412 usecs
[ 2336.304231] calling  00:02+ @ 20130, parent: pnp0
[ 2336.304247] call 00:02+ returned 0 after 5 usecs
[ 2336.304258] calling  00:03+ @ 20130, parent: pnp0
[ 2336.304274] call 00:03+ returned 0 after 5 usecs
[ 2336.304285] calling  00:04+ @ 20130, parent: pnp0
[ 2336.304301] call 00:04+ returned 0 after 5 usecs
[ 2336.304312] calling  00:05+ @ 20130, parent: pnp0
[ 2336.304328] call 00:05+ returned 0 after 5 usecs
[ 2336.304339] calling  00:06+ @ 20130, parent: pnp0
[ 2336.304355] call 00:06+ returned 0 after 4 usecs
[ 2336.304366] calling  00:07+ @ 20130, parent: pnp0
[ 2336.304381] call 00:07+ returned 0 after 4 usecs
[ 2336.304393] calling  00:08+ @ 20130, parent: pnp0
[ 2336.304408] call 00:08+ returned 0 after 4 usecs
[ 2336.304504] calling  pcspkr+ @ 20130, parent: platform
[ 2336.304522] call pcspkr+ returned 0 after 5 usecs
[ 2336.304536] calling  platform-framebuffer.0+ @ 20130, parent: platform
[ 2336.304553] call platform-framebuffer.0+ returned 0 after 5 usecs
[ 2336.304569] calling  alarmtimer+ @ 20130, parent: platform
[ 2336.304592] call alarmtimer+ returned 0 after 10 usecs
[ 2336.304654] calling  input0+ @ 20130, parent: PNP0C0C:00
[ 2336.304679] call input0+ returned 0 after 9 usecs
[ 2336.304697] calling  input1+ @ 20130, parent: PNP0C0E:00
[ 2336.304722] call input1+ returned 0 after 8 usecs
[ 2336.304736] calling  input2+ @ 20130, parent: PNP0C0D:00
[ 2336.304752] call input2+ returned 0 after 5 usecs
[ 2336.304763] calling  input3+ @ 20130, parent: LNXPWRBN:00
[ 2336.304779] call input3+ returned 0 after 5 usecs
[ 2336.304800] calling  serial8250+ @ 20130, parent: platform
[ 2336.304816] call serial8250+ returned 0 after 5 usecs
[ 2336.304935] calling  Fixed MDIO bus.0+ @ 20130, parent: platform
[ 2336.304950] call Fixed MDIO bus.0+ returned 0 after 4 usecs
[ 2336.304968] calling  i8042+ @ 20130, parent: platform
[ 2336.306077] call i8042+ returned 0 after 1073 usecs
[ 2336.306089] calling  serio0+ @ 20130, parent: i8042
[ 2336.306129] call serio0+ returned 0 after 28 usecs
[ 2336.306160] calling  serio1+ @ 20130, parent: i8042
[ 2336.306199] call serio1+ returned 0 after 27 usecs
[ 2336.306223] calling  rtc0+ @ 20130, parent: 00:01
[ 2336.306239] call rtc0+ returned 0 after 5 usecs
[ 2336.306252] calling  input4+ @ 20130, parent: serio0
[ 2336.306288] call input4+ returned 0 after 24 usecs
[ 2336.306322] calling  microcode+ @ 20130, parent: platform
[ 2336.306344] call microcode+ returned 0 after 9 usecs
[ 2336.306436] calling  rtsx_pci_sdmmc.0+ @ 20130, parent: 0000:03:00.0
[ 2336.306461] call rtsx_pci_sdmmc.0+ returned 0 after 7 usecs
[ 2336.306484] calling  rtsx_pci_ms.0+ @ 20130, parent: 0000:03:00.0
[ 2336.306517] call rtsx_pci_ms.0+ returned 0 after 21 usecs
[ 2336.388115] call usb1+ returned 0 after 106873 usecs
[ 2336.388212] calling  1-5+ @ 20192, parent: usb1
[ 2336.388292] calling  1-6+ @ 20159, parent: usb1
[ 2336.518958] usb 1-5: reset full-speed USB device number 2 using xhci_hcd
[ 2336.542475] call phy0+ returned 0 after 248934 usecs
[ 2336.555585] call 0000:00:02.0+ returned 0 after 274007 usecs
[ 2336.555701] calling  intel_backlight+ @ 20130, parent: card0-eDP-1
[ 2336.555744] call intel_backlight+ returned 0 after 17 usecs
[ 2336.555794] calling  input7+ @ 20130, parent: LNXVIDEO:00
[ 2336.555831] call input7+ returned 0 after 12 usecs
[ 2336.555867] calling  input6+ @ 20130, parent: serio1
[ 2336.555903] call input6+ returned 0 after 11 usecs
[ 2336.556112] calling  input4::numlock+ @ 20130, parent: input4
[ 2336.556146] call input4::numlock+ returned 0 after 10 usecs
[ 2336.556174] calling  input4::capslock+ @ 20130, parent: input4
[ 2336.556207] call input4::capslock+ returned 0 after 9 usecs
[ 2336.556234] calling  input4::scrolllock+ @ 20130, parent: input4
[ 2336.556268] call input4::scrolllock+ returned 0 after 9 usecs
[ 2336.556295] calling  regulatory.0+ @ 20130, parent: platform
[ 2336.556329] call regulatory.0+ returned 0 after 10 usecs
[ 2336.556403] calling  input8+ @ 20130, parent: card0
[ 2336.556439] call input8+ returned 0 after 11 usecs
[ 2336.556468] calling  input9+ @ 20130, parent: card0
[ 2336.556504] call input9+ returned 0 after 11 usecs
[ 2336.556532] calling  input10+ @ 20130, parent: card0
[ 2336.556568] call input10+ returned 0 after 11 usecs
[ 2336.556597] calling  input11+ @ 20130, parent: card0
[ 2336.556633] call input11+ returned 0 after 11 usecs
[ 2336.556662] calling  input12+ @ 20130, parent: card0
[ 2336.556697] call input12+ returned 0 after 11 usecs
[ 2336.556726] calling  input13+ @ 20130, parent: card0
[ 2336.556761] call input13+ returned 0 after 11 usecs
[ 2336.556790] calling  input14+ @ 20130, parent: card0
[ 2336.556825] call input14+ returned 0 after 11 usecs
[ 2336.556856] calling  phy0-led+ @ 20130, parent: 0000:02:00.0
[ 2336.556889] call phy0-led+ returned 0 after 9 usecs
[ 2336.556917] calling  rfkill0+ @ 20130, parent: phy0
[ 2336.557007] call rfkill0+ returned 0 after 64 usecs
[ 2336.557048] calling  coretemp.0+ @ 20130, parent: platform
[ 2336.557083] call coretemp.0+ returned 0 after 10 usecs
[ 2336.604094] ata1: SATA link down (SStatus 4 SControl 300)
[ 2336.674561] call 1-5+ returned 0 after 279606 usecs
[ 2336.792755] usb 1-6: reset high-speed USB device number 3 using xhci_hcd
[ 2336.984303] call 1-6+ returned 0 after 581995 usecs
[ 2336.984429] calling  input15+ @ 20130, parent: 1-6:1.0
[ 2336.984472] call input15+ returned 0 after 15 usecs
[ 2336.988841] usb 1-5:1.0: rebind failed: -517
[ 2336.989079] usb 1-5:1.1: rebind failed: -517
[ 2337.012470] Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
[ 2337.012733] OOM killer enabled.
[ 2337.012783] Restarting tasks ... 
[ 2337.022172] [drm] RC6 on
[ 2337.027904] Bluetooth: hci0: Device revision is 5
[ 2337.027907] Bluetooth: hci0: Secure boot is enabled
[ 2337.027909] Bluetooth: hci0: OTP lock is enabled
[ 2337.027911] Bluetooth: hci0: API lock is enabled
[ 2337.027913] Bluetooth: hci0: Debug lock is disabled
[ 2337.027915] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[ 2337.027921] Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
[ 2337.042194] done.
[ 2337.065826] PM: suspend exit
[ 2337.077613] psmouse serio1: synaptics: queried max coordinates: x [..5718], y [..4908]
[ 2337.116481] psmouse serio1: synaptics: queried min coordinates: x [1238..], y [956..]
[ 2338.402261] Bluetooth: hci0: Waiting for firmware download to complete
[ 2338.402363] Bluetooth: hci0: Firmware loaded in 1357998 usecs
[ 2338.402426] Bluetooth: hci0: Waiting for device to boot
[ 2338.413370] Bluetooth: hci0: Device booted in 10744 usecs
[ 2338.413374] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.ddc
[ 2338.417379] Bluetooth: hci0: Applying Intel DDC parameters completed
[ 2340.607291] wlp2s0: authenticate with c8:3a:35:0f:68:f8
[ 2340.613674] wlp2s0: send auth to c8:3a:35:0f:68:f8 (try 1/3)
[ 2340.621258] wlp2s0: authenticated
[ 2340.624058] wlp2s0: associate with c8:3a:35:0f:68:f8 (try 1/3)
[ 2340.627721] wlp2s0: RX AssocResp from c8:3a:35:0f:68:f8 (capab=0x411 status=0 aid=1)
[ 2340.632957] wlp2s0: associated
[ 2993.827995] [drm:intel_pipe_update_end [i915]] *ERROR* Atomic update failure on pipe A (start=39452 end=39453) time 137 us, min 1073, max 1079, scanline start 1071, end 1080
[ 3351.702728] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[ 3352.005613] ata1: SATA link down (SStatus 4 SControl 300)
