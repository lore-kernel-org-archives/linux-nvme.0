From: pmenzel+linux-nvme@molgen.mpg.de (Paul Menzel)
Date: Mon, 15 Jan 2018 13:53:12 +0100
Subject: UBSAN: Undefined behaviour in drivers/nvme/host/pci.c:456:17:
 division by zero
Message-ID: <aa574bc6-59a5-c034-a5c0-347c16eec053@molgen.mpg.de>

Dear Linux folks,


There is a regression from Linux 4.15-rc7 to 4.15-rc8+ causing undefined 
behavior sanitizer showing the error below. At least, I haven?t seen 
this error before.

```
UBSAN: Undefined behaviour in drivers/nvme/host/pci.c:456:17
division by zero
CPU: 0 PID: 53 Comm: kworker/u8:1 Not tainted 4.15.0-rc8+ #17
Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 
5.12 07/07/2017
Workqueue: nvme-wq nvme_reset_work
Call Trace:
  dump_stack+0x70/0xae
  ubsan_epilogue+0x9/0x40
  __ubsan_handle_divrem_overflow+0x99/0xe0
  ? nvme_queue_rq+0xd1a/0x14f0
  nvme_queue_rq+0xd1a/0x14f0
  ? ftrace_graph_caller+0x68/0x98
  ? trace_graph_entry+0xdc/0x2b0
  ? blk_mq_make_request+0xa70/0xa70
  ? blk_mq_sched_dispatch_requests+0x1f3/0x2e0
  blk_mq_dispatch_rq_list+0xb5/0xd50
  blk_mq_sched_dispatch_requests+0x1f3/0x2e0
  __blk_mq_delay_run_hw_queue+0x8f/0xd0
  blk_mq_run_hw_queue+0x2f/0xd0
  blk_mq_sched_insert_request+0x167/0x320
  blk_execute_rq+0x63/0xe0
  __nvme_submit_sync_cmd+0xa6/0x130
  nvme_set_features+0x67/0xd0
  nvme_set_queue_count+0x53/0x100
  nvme_reset_work+0x842/0x1ab0
  ? ftrace_graph_caller+0x68/0x98
  ? worker_thread+0x64/0x670
  ? prepare_ftrace_return+0xaa/0x170
  process_one_work+0x277/0x800
  worker_thread+0x64/0x670
  ? process_one_work+0x800/0x800
  kthread+0x173/0x230
  ? kthread+0x5/0x230
  ? kthread_create_worker_on_cpu+0x70/0x70
  ret_from_fork+0x32/0x40```


Kind regards,

Paul
-------------- next part --------------
-- Logs begin at Mon 2017-10-23 08:26:54 CEST, end at Mon 2018-01-15 13:43:32 CET. --
Jan 15 13:37:57 helmuth-N24-25BU kernel: microcode: microcode updated early to revision 0x80, date = 2018-01-04
Jan 15 13:37:57 helmuth-N24-25BU kernel: Linux version 4.15.0-rc8+ (helmuth at helmuth-N24-25BU) (gcc version 7.2.0 (Ubuntu 7.2.0-8ubuntu3)) #17 SMP Mon Jan 15 13:11:47 CET 2018
Jan 15 13:37:57 helmuth-N24-25BU kernel: Command line: BOOT_IMAGE=/boot/vmlinuz-4.15.0-rc8+ root=UUID=66c28cf8-41b0-4ae7-998d-8e3e76a3fed7 ro quiet splash acpi_os_name=Linux acpi_osi= acpi_backlight=vendor initcall_debug log_buf_len=32M trace_buf_size=524288K trace_clock=global trace_options=nooverwrite,funcgraph-abstime,funcgraph-cpu,funcgraph-duration,funcgraph-proc,funcgraph-tail,nofuncgraph-overhead,context-info,graph-time ftrace=function_graph ftrace_graph_max_depth=15 ftrace_graph_filter=do_one_initcall
Jan 15 13:37:57 helmuth-N24-25BU kernel: KERNEL supported cpus:
Jan 15 13:37:57 helmuth-N24-25BU kernel:   Intel GenuineIntel
Jan 15 13:37:57 helmuth-N24-25BU kernel:   AMD AuthenticAMD
Jan 15 13:37:57 helmuth-N24-25BU kernel:   Centaur CentaurHauls
Jan 15 13:37:57 helmuth-N24-25BU kernel: x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
Jan 15 13:37:57 helmuth-N24-25BU kernel: x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
Jan 15 13:37:57 helmuth-N24-25BU kernel: x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
Jan 15 13:37:57 helmuth-N24-25BU kernel: x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
Jan 15 13:37:57 helmuth-N24-25BU kernel: x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
Jan 15 13:37:57 helmuth-N24-25BU kernel: x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
Jan 15 13:37:57 helmuth-N24-25BU kernel: x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
Jan 15 13:37:57 helmuth-N24-25BU kernel: x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
Jan 15 13:37:57 helmuth-N24-25BU kernel: x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
Jan 15 13:37:57 helmuth-N24-25BU kernel: e820: BIOS-provided physical RAM map:
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x000000000009e000-0x00000000000fffff] reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x0000000000100000-0x000000007a4f0fff] usable
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x000000007a4f1000-0x000000007a4f1fff] ACPI NVS
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x000000007a4f2000-0x000000007a4f2fff] reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x000000007a4f3000-0x000000007eb49fff] usable
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x000000007eb4a000-0x000000007f4bafff] reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x000000007f4bb000-0x000000007f592fff] usable
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x000000007f593000-0x000000007f904fff] ACPI NVS
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x000000007f905000-0x000000007ffa3fff] reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x000000007ffa4000-0x000000007fffefff] type 20
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x000000007ffff000-0x000000007fffffff] usable
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x0000000080000000-0x000000008abfffff] reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS-e820: [mem 0x0000000100000000-0x00000008743fffff] usable
Jan 15 13:37:57 helmuth-N24-25BU kernel: NX (Execute Disable) protection: active
Jan 15 13:37:57 helmuth-N24-25BU kernel: efi: EFI v2.50 by American Megatrends
Jan 15 13:37:57 helmuth-N24-25BU kernel: efi:  ACPI 2.0=0x7f893000  ACPI=0x7f893000  SMBIOS=0x7ff17000  SMBIOS 3.0=0x7ff16000  ESRT=0x7da36ad8 
Jan 15 13:37:57 helmuth-N24-25BU kernel: random: fast init done
Jan 15 13:37:57 helmuth-N24-25BU kernel: SMBIOS 3.0.0 present.
Jan 15 13:37:57 helmuth-N24-25BU kernel: DMI: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 07/07/2017
Jan 15 13:37:57 helmuth-N24-25BU kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
Jan 15 13:37:57 helmuth-N24-25BU kernel: e820: last_pfn = 0x874400 max_arch_pfn = 0x400000000
Jan 15 13:37:57 helmuth-N24-25BU kernel: MTRR default type: write-back
Jan 15 13:37:57 helmuth-N24-25BU kernel: MTRR fixed ranges enabled:
Jan 15 13:37:57 helmuth-N24-25BU kernel:   00000-9FFFF write-back
Jan 15 13:37:57 helmuth-N24-25BU kernel:   A0000-BFFFF uncachable
Jan 15 13:37:57 helmuth-N24-25BU kernel:   C0000-FFFFF write-protect
Jan 15 13:37:57 helmuth-N24-25BU kernel: MTRR variable ranges enabled:
Jan 15 13:37:57 helmuth-N24-25BU kernel:   0 base 00C0000000 mask 7FC0000000 uncachable
Jan 15 13:37:57 helmuth-N24-25BU kernel:   1 base 00A0000000 mask 7FE0000000 uncachable
Jan 15 13:37:57 helmuth-N24-25BU kernel:   2 base 0090000000 mask 7FF0000000 uncachable
Jan 15 13:37:57 helmuth-N24-25BU kernel:   3 base 008C000000 mask 7FFC000000 uncachable
Jan 15 13:37:57 helmuth-N24-25BU kernel:   4 base 008A000000 mask 7FFE000000 uncachable
Jan 15 13:37:57 helmuth-N24-25BU kernel:   5 base 0089000000 mask 7FFF000000 uncachable
Jan 15 13:37:57 helmuth-N24-25BU kernel:   6 base 0088800000 mask 7FFF800000 uncachable
Jan 15 13:37:57 helmuth-N24-25BU kernel:   7 base 0088400000 mask 7FFFC00000 uncachable
Jan 15 13:37:57 helmuth-N24-25BU kernel:   8 disabled
Jan 15 13:37:57 helmuth-N24-25BU kernel:   9 disabled
Jan 15 13:37:57 helmuth-N24-25BU kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
Jan 15 13:37:57 helmuth-N24-25BU kernel: e820: last_pfn = 0x80000 max_arch_pfn = 0x400000000
Jan 15 13:37:57 helmuth-N24-25BU kernel: esrt: Reserving ESRT space from 0x000000007da36ad8 to 0x000000007da36b10.
Jan 15 13:37:57 helmuth-N24-25BU kernel: Scanning 1 areas for low memory corruption
Jan 15 13:37:57 helmuth-N24-25BU kernel: Base memory trampoline at [        (ptrval)] 97000 size 24576
Jan 15 13:37:57 helmuth-N24-25BU kernel: Using GB pages for direct mapping
Jan 15 13:37:57 helmuth-N24-25BU kernel: BRK [0x36aba3000, 0x36aba3fff] PGTABLE
Jan 15 13:37:57 helmuth-N24-25BU kernel: BRK [0x36aba4000, 0x36aba4fff] PGTABLE
Jan 15 13:37:57 helmuth-N24-25BU kernel: BRK [0x36aba5000, 0x36aba5fff] PGTABLE
Jan 15 13:37:57 helmuth-N24-25BU kernel: BRK [0x36aba6000, 0x36aba6fff] PGTABLE
Jan 15 13:37:57 helmuth-N24-25BU kernel: BRK [0x36aba7000, 0x36aba7fff] PGTABLE
Jan 15 13:37:57 helmuth-N24-25BU kernel: BRK [0x36aba8000, 0x36aba8fff] PGTABLE
Jan 15 13:37:57 helmuth-N24-25BU kernel: BRK [0x36aba9000, 0x36aba9fff] PGTABLE
Jan 15 13:37:57 helmuth-N24-25BU kernel: BRK [0x36abaa000, 0x36abaafff] PGTABLE
Jan 15 13:37:57 helmuth-N24-25BU kernel: BRK [0x36abab000, 0x36ababfff] PGTABLE
Jan 15 13:37:57 helmuth-N24-25BU kernel: BRK [0x36abac000, 0x36abacfff] PGTABLE
Jan 15 13:37:57 helmuth-N24-25BU kernel: log_buf_len: 33554432 bytes
Jan 15 13:37:57 helmuth-N24-25BU kernel: early log buf free: 256300(97%)
Jan 15 13:37:57 helmuth-N24-25BU kernel: Secure boot could not be determined
Jan 15 13:37:57 helmuth-N24-25BU kernel: RAMDISK: [mem 0x30a17000-0x34502fff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Early table checksum verification disabled
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: RSDP 0x000000007F893000 000024 (v02 ALASKA)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: XSDT 0x000000007F8930A8 0000CC (v01 ALASKA A M I    01072009 AMI  00010013)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: FACP 0x000000007F8AE6C8 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: DSDT 0x000000007F893208 01B4BF (v02 ALASKA A M I    01072009 INTL 20160422)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: FACS 0x000000007F8ECC40 000040
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: APIC 0x000000007F8AE7E0 000084 (v03 ALASKA A M I    01072009 AMI  00010013)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: FPDT 0x000000007F8AE868 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: MCFG 0x000000007F8AE8B0 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: SSDT 0x000000007F8AE8F0 000322 (v01 SataRe SataTabl 00001000 INTL 20160422)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: FIDT 0x000000007F8AEC18 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: SSDT 0x000000007F8AECB8 003295 (v02 SaSsdt SaSsdt   00003000 INTL 20160422)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: HPET 0x000000007F8B1F50 000038 (v01 INTEL  KBL-ULT  00000001 MSFT 0000005F)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: SSDT 0x000000007F8B1F88 000024 (v02 INTEL  xh_OEMBD 00000000 INTL 20160422)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: UEFI 0x000000007F8B1FB0 000042 (v01 INTEL  EDK2     00000002      01000013)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: SSDT 0x000000007F8B1FF8 000EDE (v02 CpuRef CpuSsdt  00003000 INTL 20160422)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: LPIT 0x000000007F8B2ED8 000094 (v01 INTEL  KBL-ULT  00000000 MSFT 0000005F)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: WSMT 0x000000007F8B2F70 000028 (v01 INTEL  KBL-ULT  00000000 MSFT 0000005F)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: SSDT 0x000000007F8B2F98 00029F (v02 INTEL  sensrhub 00000000 INTL 20160422)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: SSDT 0x000000007F8B3238 003002 (v02 INTEL  PtidDevc 00001000 INTL 20160422)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: DBGP 0x000000007F8B6240 000034 (v01 INTEL           00000002 MSFT 0000005F)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: DBG2 0x000000007F8B6278 000054 (v00 INTEL           00000002 MSFT 0000005F)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: BGRT 0x000000007F8B62D0 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: DMAR 0x000000007F8B6308 0000A8 (v01 INTEL  KBL      00000001 INTL 00000001)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: TPM2 0x000000007F8B63B0 000034 (v03        Tpm2Tabl 00000001 AMI  00000000)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: ASF! 0x000000007F8B63E8 0000A0 (v32 INTEL   HCG     00000001 TFSM 000F4240)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Local APIC address 0xfee00000
Jan 15 13:37:57 helmuth-N24-25BU kernel: No NUMA configuration found
Jan 15 13:37:57 helmuth-N24-25BU kernel: Faking a node at [mem 0x0000000000000000-0x00000008743fffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: NODE_DATA(0) allocated [mem 0x8723fb000-0x8723fffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: Zone ranges:
Jan 15 13:37:57 helmuth-N24-25BU kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel:   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel:   Normal   [mem 0x0000000100000000-0x00000008743fffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel:   Device   empty
Jan 15 13:37:57 helmuth-N24-25BU kernel: Movable zone start for each node
Jan 15 13:37:57 helmuth-N24-25BU kernel: Early memory node ranges
Jan 15 13:37:57 helmuth-N24-25BU kernel:   node   0: [mem 0x0000000000001000-0x0000000000057fff]
Jan 15 13:37:57 helmuth-N24-25BU kernel:   node   0: [mem 0x0000000000059000-0x000000000009dfff]
Jan 15 13:37:57 helmuth-N24-25BU kernel:   node   0: [mem 0x0000000000100000-0x000000007a4f0fff]
Jan 15 13:37:57 helmuth-N24-25BU kernel:   node   0: [mem 0x000000007a4f3000-0x000000007eb49fff]
Jan 15 13:37:57 helmuth-N24-25BU kernel:   node   0: [mem 0x000000007f4bb000-0x000000007f592fff]
Jan 15 13:37:57 helmuth-N24-25BU kernel:   node   0: [mem 0x000000007ffff000-0x000000007fffffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel:   node   0: [mem 0x0000000100000000-0x00000008743fffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: Initmem setup node 0 [mem 0x0000000000001000-0x00000008743fffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: On node 0 totalpages: 8335293
Jan 15 13:37:57 helmuth-N24-25BU kernel:   DMA zone: 64 pages used for memmap
Jan 15 13:37:57 helmuth-N24-25BU kernel:   DMA zone: 23 pages reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel:   DMA zone: 3996 pages, LIFO batch:0
Jan 15 13:37:57 helmuth-N24-25BU kernel:   DMA32 zone: 8049 pages used for memmap
Jan 15 13:37:57 helmuth-N24-25BU kernel:   DMA32 zone: 515105 pages, LIFO batch:31
Jan 15 13:37:57 helmuth-N24-25BU kernel:   Normal zone: 122128 pages used for memmap
Jan 15 13:37:57 helmuth-N24-25BU kernel:   Normal zone: 7816192 pages, LIFO batch:31
Jan 15 13:37:57 helmuth-N24-25BU kernel: Reserved but unavailable: 98 pages
Jan 15 13:37:57 helmuth-N24-25BU kernel: Reserving Intel graphics memory at 0x0000000088c00000-0x000000008abfffff
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: PM-Timer IO Port: 0x1808
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Local APIC address 0xfee00000
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
Jan 15 13:37:57 helmuth-N24-25BU kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: IRQ0 used by override.
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: IRQ9 used by override.
Jan 15 13:37:57 helmuth-N24-25BU kernel: Using ACPI (MADT) for SMP configuration information
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: HPET id: 0x8086a201 base: 0xfed00000
Jan 15 13:37:57 helmuth-N24-25BU kernel: smpboot: Allowing 4 CPUs, 0 hotplug CPUs
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0x00058000-0x00058fff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0x0009e000-0x000fffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0x7a4f1000-0x7a4f1fff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0x7a4f2000-0x7a4f2fff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0x7eb4a000-0x7f4bafff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0x7f593000-0x7f904fff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0x7f905000-0x7ffa3fff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0x7ffa4000-0x7fffefff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0x80000000-0x8abfffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0x8ac00000-0xdfffffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0xf0000000-0xfdffffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0xfed01000-0xfedfffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: e820: [mem 0x8ac00000-0xdfffffff] available for PCI devices
Jan 15 13:37:57 helmuth-N24-25BU kernel: Booting paravirtualized kernel on bare hardware
Jan 15 13:37:57 helmuth-N24-25BU kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
Jan 15 13:37:57 helmuth-N24-25BU kernel: setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:4 nr_node_ids:1
Jan 15 13:37:57 helmuth-N24-25BU kernel: percpu: Embedded 45 pages/cpu @        (ptrval) s146264 r8192 d29864 u524288
Jan 15 13:37:57 helmuth-N24-25BU kernel: pcpu-alloc: s146264 r8192 d29864 u524288 alloc=1*2097152
Jan 15 13:37:57 helmuth-N24-25BU kernel: pcpu-alloc: [0] 0 1 2 3 
Jan 15 13:37:57 helmuth-N24-25BU kernel: Built 1 zonelists, mobility grouping on.  Total pages: 8205029
Jan 15 13:37:57 helmuth-N24-25BU kernel: Policy zone: Normal
Jan 15 13:37:57 helmuth-N24-25BU kernel: Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.15.0-rc8+ root=UUID=66c28cf8-41b0-4ae7-998d-8e3e76a3fed7 ro quiet splash acpi_os_name=Linux acpi_osi= acpi_backlight=vendor initcall_debug log_buf_len=32M trace_buf_size=524288K trace_clock=global trace_options=nooverwrite,funcgraph-abstime,funcgraph-cpu,funcgraph-duration,funcgraph-proc,funcgraph-tail,nofuncgraph-overhead,context-info,graph-time ftrace=function_graph ftrace_graph_max_depth=15 ftrace_graph_filter=do_one_initcall
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: _OSI method disabled
Jan 15 13:37:57 helmuth-N24-25BU kernel: Memory: 32548064K/33341172K available (18444K kernel code, 13986K rwdata, 3932K rodata, 1820K init, 1224K bss, 793108K reserved, 0K cma-reserved)
Jan 15 13:37:57 helmuth-N24-25BU kernel: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Jan 15 13:37:57 helmuth-N24-25BU kernel: Kernel/User page tables isolation: enabled
Jan 15 13:37:57 helmuth-N24-25BU kernel: ftrace: allocating 38286 entries in 150 pages
Jan 15 13:37:57 helmuth-N24-25BU kernel: Hierarchical RCU implementation.
Jan 15 13:37:57 helmuth-N24-25BU kernel:         RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
Jan 15 13:37:57 helmuth-N24-25BU kernel:         Tasks RCU enabled.
Jan 15 13:37:57 helmuth-N24-25BU kernel: RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
Jan 15 13:37:57 helmuth-N24-25BU kernel: NR_IRQS: 16640, nr_irqs: 1024, preallocated irqs: 16
Jan 15 13:37:57 helmuth-N24-25BU kernel: Console: colour dummy device 80x25
Jan 15 13:37:57 helmuth-N24-25BU kernel: console [tty0] enabled
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Core revision 20170831
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Overriding _OS definition to 'Linux'
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: 7 ACPI AML tables successfully acquired and loaded
Jan 15 13:37:57 helmuth-N24-25BU kernel: clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
Jan 15 13:37:57 helmuth-N24-25BU kernel: hpet clockevent registered
Jan 15 13:37:57 helmuth-N24-25BU kernel: APIC: Switch to symmetric I/O mode setup
Jan 15 13:37:57 helmuth-N24-25BU kernel: DMAR: Host address width 39
Jan 15 13:37:57 helmuth-N24-25BU kernel: DMAR: DRHD base: 0x000000fed90000 flags: 0x0
Jan 15 13:37:57 helmuth-N24-25BU kernel: DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
Jan 15 13:37:57 helmuth-N24-25BU kernel: DMAR: DRHD base: 0x000000fed91000 flags: 0x1
Jan 15 13:37:57 helmuth-N24-25BU kernel: DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
Jan 15 13:37:57 helmuth-N24-25BU kernel: DMAR: RMRR base: 0x0000007ef47000 end: 0x0000007ef66fff
Jan 15 13:37:57 helmuth-N24-25BU kernel: DMAR: RMRR base: 0x00000088400000 end: 0x0000008abfffff
Jan 15 13:37:57 helmuth-N24-25BU kernel: DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: DMAR-IR: HPET id 0 under DRHD base 0xfed91000
Jan 15 13:37:57 helmuth-N24-25BU kernel: DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
Jan 15 13:37:57 helmuth-N24-25BU kernel: DMAR-IR: Enabled IRQ remapping in x2apic mode
Jan 15 13:37:57 helmuth-N24-25BU kernel: x2apic enabled
Jan 15 13:37:57 helmuth-N24-25BU kernel: Switched APIC routing to cluster x2apic.
Jan 15 13:37:57 helmuth-N24-25BU kernel: ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
Jan 15 13:37:57 helmuth-N24-25BU kernel: tsc: Detected 2900.000 MHz processor
Jan 15 13:37:57 helmuth-N24-25BU kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 5808.00 BogoMIPS (lpj=11616000)
Jan 15 13:37:57 helmuth-N24-25BU kernel: pid_max: default: 32768 minimum: 301
Jan 15 13:37:57 helmuth-N24-25BU kernel: Security Framework initialized
Jan 15 13:37:57 helmuth-N24-25BU kernel: Yama: becoming mindful.
Jan 15 13:37:57 helmuth-N24-25BU kernel: AppArmor: AppArmor initialized
Jan 15 13:37:57 helmuth-N24-25BU kernel: Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
Jan 15 13:37:57 helmuth-N24-25BU kernel: Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
Jan 15 13:37:57 helmuth-N24-25BU kernel: Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
Jan 15 13:37:57 helmuth-N24-25BU kernel: Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
Jan 15 13:37:57 helmuth-N24-25BU kernel: CPU: Physical Processor ID: 0
Jan 15 13:37:57 helmuth-N24-25BU kernel: CPU: Processor Core ID: 0
Jan 15 13:37:57 helmuth-N24-25BU kernel: mce: CPU supports 8 MCE banks
Jan 15 13:37:57 helmuth-N24-25BU kernel: CPU0: Thermal monitoring enabled (TM1)
Jan 15 13:37:57 helmuth-N24-25BU kernel: process: using mwait in idle threads
Jan 15 13:37:57 helmuth-N24-25BU kernel: Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
Jan 15 13:37:57 helmuth-N24-25BU kernel: Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
Jan 15 13:37:57 helmuth-N24-25BU kernel: Spectre V2 mitigation: Vulnerable: Minimal generic ASM retpoline
Jan 15 13:37:57 helmuth-N24-25BU kernel: Freeing SMP alternatives memory: 36K
Jan 15 13:37:57 helmuth-N24-25BU kernel: TSC deadline timer enabled
Jan 15 13:37:57 helmuth-N24-25BU kernel: smpboot: CPU0: Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz (family: 0x6, model: 0x8e, stepping: 0x9)
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  trace_init_flags_sys_exit+0x0/0xf @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall trace_init_flags_sys_exit+0x0/0xf returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  trace_init_flags_sys_enter+0x0/0xf @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall trace_init_flags_sys_enter+0x0/0xf returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_hw_perf_events+0x0/0x7e2 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
Jan 15 13:37:57 helmuth-N24-25BU kernel: ... version:                4
Jan 15 13:37:57 helmuth-N24-25BU kernel: ... bit width:              48
Jan 15 13:37:57 helmuth-N24-25BU kernel: ... generic registers:      4
Jan 15 13:37:57 helmuth-N24-25BU kernel: ... value mask:             0000ffffffffffff
Jan 15 13:37:57 helmuth-N24-25BU kernel: ... max period:             00007fffffffffff
Jan 15 13:37:57 helmuth-N24-25BU kernel: ... fixed-purpose events:   3
Jan 15 13:37:57 helmuth-N24-25BU kernel: ... event mask:             000000070000000f
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_hw_perf_events+0x0/0x7e2 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_real_mode+0x0/0x31a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_real_mode+0x0/0x31a returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  trace_init_perf_perm_irq_work_exit+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall trace_init_perf_perm_irq_work_exit+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  register_nmi_cpu_backtrace_handler+0x0/0x16 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall register_nmi_cpu_backtrace_handler+0x0/0x16 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  numachip_system_init+0x0/0x67 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall numachip_system_init+0x0/0x67 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  early_efi_map_fb+0x0/0x4d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall early_efi_map_fb+0x0/0x4d returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  spawn_ksoftirqd+0x0/0x4c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall spawn_ksoftirqd+0x0/0x4c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  migration_init+0x0/0x98 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall migration_init+0x0/0x98 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  check_cpu_stall_init+0x0/0x1b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall check_cpu_stall_init+0x0/0x1b returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  srcu_bootup_announce+0x0/0x30 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: Hierarchical SRCU implementation.
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall srcu_bootup_announce+0x0/0x30 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  rcu_spawn_gp_kthread+0x0/0x147 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall rcu_spawn_gp_kthread+0x0/0x147 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cpu_stop_init+0x0/0x13d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cpu_stop_init+0x0/0x13d returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_events+0x0/0xfa @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_events+0x0/0xfa returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_trace_printk+0x0/0xc @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_trace_printk+0x0/0xc returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  event_trace_enable_again+0x0/0x21 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall event_trace_enable_again+0x0/0x21 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  jump_label_init_module+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall jump_label_init_module+0x0/0x11 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dynamic_debug_init+0x0/0x2fe @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dynamic_debug_init+0x0/0x2fe returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  rand_initialize+0x0/0x130 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall rand_initialize+0x0/0x130 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  initialize_ptr_random+0x0/0x68 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall initialize_ptr_random+0x0/0x68 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: smp: Bringing up secondary CPUs ...
Jan 15 13:37:57 helmuth-N24-25BU kernel: x86: Booting SMP configuration:
Jan 15 13:37:57 helmuth-N24-25BU kernel: .... node  #0, CPUs:      #1
Jan 15 13:37:57 helmuth-N24-25BU kernel: NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
Jan 15 13:37:57 helmuth-N24-25BU kernel:  #2 #3
Jan 15 13:37:57 helmuth-N24-25BU kernel: smp: Brought up 1 node, 4 CPUs
Jan 15 13:37:57 helmuth-N24-25BU kernel: smpboot: Max logical packages: 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: smpboot: Total of 4 processors activated (23232.00 BogoMIPS)
Jan 15 13:37:57 helmuth-N24-25BU kernel: devtmpfs: initialized
Jan 15 13:37:57 helmuth-N24-25BU kernel: x86/mm: Memory block size: 128MB
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ipc_ns_init+0x0/0xc7 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ipc_ns_init+0x0/0xc7 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_mmap_min_addr+0x0/0x16 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_mmap_min_addr+0x0/0x16 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  evm_display_config+0x0/0x43 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: evm: security.selinux
Jan 15 13:37:57 helmuth-N24-25BU kernel: evm: security.SMACK64
Jan 15 13:37:57 helmuth-N24-25BU kernel: evm: security.SMACK64EXEC
Jan 15 13:37:57 helmuth-N24-25BU kernel: evm: security.SMACK64TRANSMUTE
Jan 15 13:37:57 helmuth-N24-25BU kernel: evm: security.SMACK64MMAP
Jan 15 13:37:57 helmuth-N24-25BU kernel: evm: security.apparmor
Jan 15 13:37:57 helmuth-N24-25BU kernel: evm: security.ima
Jan 15 13:37:57 helmuth-N24-25BU kernel: evm: security.capability
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall evm_display_config+0x0/0x43 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_cpufreq_transition_notifier_list+0x0/0x1b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_cpufreq_transition_notifier_list+0x0/0x1b returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  jit_init+0x0/0x8 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall jit_init+0x0/0x8 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  net_ns_init+0x0/0x18d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall net_ns_init+0x0/0x18d returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  xen_pvh_gnttab_setup+0x0/0x4d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall xen_pvh_gnttab_setup+0x0/0x4d returned -19 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  e820__register_nvs_regions+0x0/0x91 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registering ACPI NVS region [mem 0x7a4f1000-0x7a4f1fff] (4096 bytes)
Jan 15 13:37:57 helmuth-N24-25BU kernel: PM: Registering ACPI NVS region [mem 0x7f593000-0x7f904fff] (3612672 bytes)
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall e820__register_nvs_regions+0x0/0x91 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cpufreq_register_tsc_scaling+0x0/0x5e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cpufreq_register_tsc_scaling+0x0/0x5e returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_cpu_syscore+0x0/0xf @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_cpu_syscore+0x0/0xf returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  reboot_init+0x0/0x3d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall reboot_init+0x0/0x3d returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_lapic_sysfs+0x0/0x3b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_lapic_sysfs+0x0/0x3b returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cpu_hotplug_pm_sync_init+0x0/0x14 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cpu_hotplug_pm_sync_init+0x0/0x14 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  alloc_frozen_cpus+0x0/0x8 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall alloc_frozen_cpus+0x0/0x8 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  wq_sysfs_init+0x0/0x2b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall wq_sysfs_init+0x0/0x2b returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ksysfs_init+0x0/0xb0 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ksysfs_init+0x0/0xb0 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pm_init+0x0/0x98 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pm_init+0x0/0x98 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pm_disk_init+0x0/0x18 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pm_disk_init+0x0/0x18 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  swsusp_header_init+0x0/0x30 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall swsusp_header_init+0x0/0x30 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  rcu_spawn_tasks_kthread+0x0/0x81 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall rcu_spawn_tasks_kthread+0x0/0x81 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  rcu_set_runtime_mode+0x0/0x12 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall rcu_set_runtime_mode+0x0/0x12 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_jiffies_clocksource+0x0/0x18 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_jiffies_clocksource+0x0/0x18 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  futex_init+0x0/0x24c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: futex hash table entries: 1024 (order: 4, 65536 bytes)
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall futex_init+0x0/0x24c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cgroup_wq_init+0x0/0x3a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cgroup_wq_init+0x0/0x3a returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cgroup1_wq_init+0x0/0x3a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cgroup1_wq_init+0x0/0x3a returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ftrace_mod_cmd_init+0x0/0xc @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ftrace_mod_cmd_init+0x0/0xc returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_wakeup_tracer+0x0/0x2d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_wakeup_tracer+0x0/0x2d returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_graph_trace+0x0/0x5d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: Starting tracer 'function_graph'
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_graph_trace+0x0/0x5d returned 0 after 140625 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_per_zone_wmark_min+0x0/0x70 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_per_zone_wmark_min+0x0/0x70 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_zero_pfn+0x0/0x60 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_zero_pfn+0x0/0x60 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  memory_failure_init+0x0/0x164 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall memory_failure_init+0x0/0x164 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cma_init_reserved_areas+0x0/0x28a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cma_init_reserved_areas+0x0/0x28a returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  fsnotify_init+0x0/0x49 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall fsnotify_init+0x0/0x49 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  filelock_init+0x0/0xfc @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall filelock_init+0x0/0xfc returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_script_binfmt+0x0/0x16 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_script_binfmt+0x0/0x16 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_elf_binfmt+0x0/0x16 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_compat_elf_binfmt+0x0/0x16 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_compat_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  debugfs_init+0x0/0x53 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall debugfs_init+0x0/0x53 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tracefs_init+0x0/0x3b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tracefs_init+0x0/0x3b returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  securityfs_init+0x0/0x69 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall securityfs_init+0x0/0x69 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  prandom_init+0x0/0x124 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall prandom_init+0x0/0x124 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pinctrl_init+0x0/0xae @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: pinctrl core: initialized pinctrl subsystem
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pinctrl_init+0x0/0xae returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  gpiolib_dev_init+0x0/0x10f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall gpiolib_dev_init+0x0/0x10f returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sfi_sysfs_init+0x0/0x11c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sfi_sysfs_init+0x0/0x11c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  virtio_init+0x0/0x30 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall virtio_init+0x0/0x30 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  regulator_init+0x0/0x8c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall regulator_init+0x0/0x8c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  iommu_init+0x0/0x37 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall iommu_init+0x0/0x37 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  early_resume_init+0x0/0x1c0 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: RTC time: 12:37:45, date: 01/15/18
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall early_resume_init+0x0/0x1c0 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  opp_debug_init+0x0/0x3c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall opp_debug_init+0x0/0x3c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cpufreq_core_init+0x0/0x58 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cpufreq_core_init+0x0/0x58 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cpuidle_init+0x0/0x3b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cpuidle_init+0x0/0x3b returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  capsule_reboot_register+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall capsule_reboot_register+0x0/0x11 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  bsp_pm_check_init+0x0/0x14 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall bsp_pm_check_init+0x0/0x14 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sock_init+0x0/0xa6 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sock_init+0x0/0xa6 returned 0 after 3906 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  net_inuse_init+0x0/0x24 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall net_inuse_init+0x0/0x24 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  net_defaults_init+0x0/0x24 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall net_defaults_init+0x0/0x24 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_default_flow_dissectors+0x0/0x50 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_default_flow_dissectors+0x0/0x50 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  netpoll_init+0x0/0x31 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall netpoll_init+0x0/0x31 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  netlink_proto_init+0x0/0x240 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: NET: Registered protocol family 16
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall netlink_proto_init+0x0/0x240 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  __gnttab_init+0x0/0x50 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall __gnttab_init+0x0/0x50 returned -19 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  irq_sysfs_init+0x0/0xb5 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall irq_sysfs_init+0x0/0xb5 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  audit_init+0x0/0x1c1 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: audit: initializing netlink subsys (disabled)
Jan 15 13:37:57 helmuth-N24-25BU kernel: audit: type=2000 audit(1516019865.272:1): state=initialized audit_enabled=0 res=1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall audit_init+0x0/0x1c1 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  bdi_class_init+0x0/0x61 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall bdi_class_init+0x0/0x61 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  mm_sysfs_init+0x0/0x29 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall mm_sysfs_init+0x0/0x29 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  gpiolib_sysfs_init+0x0/0xc4 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall gpiolib_sysfs_init+0x0/0xc4 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pcibus_class_init+0x0/0x18 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pcibus_class_init+0x0/0x18 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pci_driver_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pci_driver_init+0x0/0x11 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  rio_bus_init+0x0/0x43 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall rio_bus_init+0x0/0x43 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  backlight_class_init+0x0/0xf0 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall backlight_class_init+0x0/0xf0 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  xenbus_init+0x0/0x31c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall xenbus_init+0x0/0x31c returned -19 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tty_class_init+0x0/0x4c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tty_class_init+0x0/0x4c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  vtconsole_class_init+0x0/0xef @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall vtconsole_class_init+0x0/0xef returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  iommu_dev_init+0x0/0x18 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall iommu_dev_init+0x0/0x18 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  mipi_dsi_bus_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall mipi_dsi_bus_init+0x0/0x11 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  wakeup_sources_debugfs_init+0x0/0x24 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall wakeup_sources_debugfs_init+0x0/0x24 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  isa_bus_init+0x0/0x3c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall isa_bus_init+0x0/0x3c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  register_node_type+0x0/0x2f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall register_node_type+0x0/0x2f returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  regmap_initcall+0x0/0xd @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall regmap_initcall+0x0/0xd returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sram_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sram_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  syscon_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall syscon_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  spi_init+0x0/0x97 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall spi_init+0x0/0x97 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  i2c_init+0x0/0xb4 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall i2c_init+0x0/0xb4 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_ladder+0x0/0x3c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: cpuidle: using governor ladder
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_ladder+0x0/0x3c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_menu+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: cpuidle: using governor menu
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_menu+0x0/0x11 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pcc_init+0x0/0x469 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pcc_init+0x0/0x469 returned -19 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  amd_postcore_init+0x0/0x111 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall amd_postcore_init+0x0/0x111 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  kobject_uevent_init+0x0/0xc @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall kobject_uevent_init+0x0/0xc returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  bts_init+0x0/0xef @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall bts_init+0x0/0xef returned -19 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pt_init+0x0/0x475 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pt_init+0x0/0x475 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  boot_params_ksysfs_init+0x0/0x336 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall boot_params_ksysfs_init+0x0/0x336 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sbf_init+0x0/0xcb @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sbf_init+0x0/0xcb returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  arch_kdebugfs_init+0x0/0x24 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall arch_kdebugfs_init+0x0/0x24 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  mtrr_if_init+0x0/0xc0 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall mtrr_if_init+0x0/0xc0 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ffh_cstate_init+0x0/0x44 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ffh_cstate_init+0x0/0x44 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  activate_jump_labels+0x0/0x32 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall activate_jump_labels+0x0/0x32 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  gigantic_pages_init+0x0/0x49 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall gigantic_pages_init+0x0/0x49 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  kcmp_cookies_init+0x0/0xdf @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall kcmp_cookies_init+0x0/0xdf returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  acpi_pci_init+0x0/0x62 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: bus type PCI registered
Jan 15 13:37:57 helmuth-N24-25BU kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall acpi_pci_init+0x0/0x62 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dma_bus_init+0x0/0x121 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dma_bus_init+0x0/0x121 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dma_channel_table_init+0x0/0x1a9 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dma_channel_table_init+0x0/0x1a9 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  setup_vcpu_hotplug_event+0x0/0x4b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall setup_vcpu_hotplug_event+0x0/0x4b returned -19 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  register_xen_pci_notifier+0x0/0x36 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall register_xen_pci_notifier+0x0/0x36 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  xen_pcpu_init+0x0/0xb4 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall xen_pcpu_init+0x0/0xb4 returned -19 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dmi_id_init+0x0/0x7f9 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dmi_id_init+0x0/0x7f9 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  numachip_timer_init+0x0/0x54 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall numachip_timer_init+0x0/0x54 returned -19 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pci_arch_init+0x0/0x66 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
Jan 15 13:37:57 helmuth-N24-25BU kernel: PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
Jan 15 13:37:57 helmuth-N24-25BU kernel: PCI: Using configuration type 1 for base access
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pci_arch_init+0x0/0x66 returned 0 after 3906 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_vdso+0x0/0x40 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_vdso+0x0/0x40 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sysenter_setup+0x0/0x14 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sysenter_setup+0x0/0x14 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  fixup_ht_bug+0x0/0xa2 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall fixup_ht_bug+0x0/0xa2 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  topology_init+0x0/0xc8 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall topology_init+0x0/0xc8 returned 0 after 7812 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  mtrr_init_finialize+0x0/0x57 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall mtrr_init_finialize+0x0/0x57 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  uid_cache_init+0x0/0x10f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall uid_cache_init+0x0/0x10f returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  param_sysfs_init+0x0/0x220 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall param_sysfs_init+0x0/0x220 returned 0 after 27343 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  user_namespace_sysctl_init+0x0/0x4c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall user_namespace_sysctl_init+0x0/0x4c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_schedstat_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_schedstat_init+0x0/0x1f returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pm_sysrq_init+0x0/0x19 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pm_sysrq_init+0x0/0x19 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  create_proc_profile+0x0/0xd0 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall create_proc_profile+0x0/0xd0 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  crash_save_vmcoreinfo_init+0x0/0x5c3 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall crash_save_vmcoreinfo_init+0x0/0x5c3 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  crash_notes_memory_init+0x0/0x36 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall crash_notes_memory_init+0x0/0x36 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cgroup_sysfs_init+0x0/0x18 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cgroup_sysfs_init+0x0/0x18 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cgroup_namespaces_init+0x0/0x8 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cgroup_namespaces_init+0x0/0x8 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  user_namespaces_init+0x0/0x2d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall user_namespaces_init+0x0/0x2d returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  hung_task_init+0x0/0x4f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall hung_task_init+0x0/0x4f returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dev_map_init+0x0/0x14 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dev_map_init+0x0/0x14 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  bpf_offload_init+0x0/0x14 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall bpf_offload_init+0x0/0x14 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  oom_init+0x0/0x30 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall oom_init+0x0/0x30 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  default_bdi_init+0x0/0x3b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall default_bdi_init+0x0/0x3b returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  percpu_enable_async+0x0/0xf @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall percpu_enable_async+0x0/0xf returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  kcompactd_init+0x0/0x90 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall kcompactd_init+0x0/0x90 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_reserve_notifier+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_reserve_notifier+0x0/0x1f returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_admin_reserve+0x0/0x60 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_admin_reserve+0x0/0x60 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_user_reserve+0x0/0x60 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_user_reserve+0x0/0x60 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  swap_init_sysfs+0x0/0x63 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall swap_init_sysfs+0x0/0x63 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  swapfile_init+0x0/0x101 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall swapfile_init+0x0/0x101 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  hugetlb_init+0x0/0x62c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
Jan 15 13:37:57 helmuth-N24-25BU kernel: HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall hugetlb_init+0x0/0x62c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ksm_init+0x0/0x197 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ksm_init+0x0/0x197 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  hugepage_init+0x0/0x19f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall hugepage_init+0x0/0x19f returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  mem_cgroup_swap_init+0x0/0x52 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall mem_cgroup_swap_init+0x0/0x52 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  mem_cgroup_init+0x0/0x354 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall mem_cgroup_init+0x0/0x354 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  page_idle_init+0x0/0x2f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall page_idle_init+0x0/0x2f returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sel_ib_pkey_init+0x0/0x109 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sel_ib_pkey_init+0x0/0x109 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  crypto_wq_init+0x0/0x31 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall crypto_wq_init+0x0/0x31 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cryptomgr_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cryptomgr_init+0x0/0x11 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_bio+0x0/0x1d6 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_bio+0x0/0x1d6 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  blk_settings_init+0x0/0x2a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall blk_settings_init+0x0/0x2a returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  blk_ioc_init+0x0/0x2a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall blk_ioc_init+0x0/0x2a returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  blk_softirq_init+0x0/0x129 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall blk_softirq_init+0x0/0x129 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  blk_mq_init+0x0/0x2a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall blk_mq_init+0x0/0x2a returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  genhd_device_init+0x0/0x76 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall genhd_device_init+0x0/0x76 returned 0 after 3906 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  irq_poll_setup+0x0/0x124 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall irq_poll_setup+0x0/0x124 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sx150x_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sx150x_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  byt_gpio_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall byt_gpio_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  gpiolib_debugfs_init+0x0/0x24 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall gpiolib_debugfs_init+0x0/0x24 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  lp_gpio_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall lp_gpio_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  rc5t583_gpio_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall rc5t583_gpio_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  palmas_gpio_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall palmas_gpio_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tps6586x_gpio_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tps6586x_gpio_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tps65910_gpio_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tps65910_gpio_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pwm_debugfs_init+0x0/0x24 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pwm_debugfs_init+0x0/0x24 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pwm_sysfs_init+0x0/0x18 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pwm_sysfs_init+0x0/0x18 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pci_slot_init+0x0/0x50 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pci_slot_init+0x0/0x50 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  fbmem_init+0x0/0xd5 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall fbmem_init+0x0/0xd5 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  scan_for_dmi_ipmi+0x0/0x1a2 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall scan_for_dmi_ipmi+0x0/0x1a2 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  acpi_init+0x0/0x3a0 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Added _OSI(Module Device)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Added _OSI(Processor Device)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Added _OSI(Processor Aggregator Device)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Executed 26 blocks of module-level executable AML code
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Dynamic OEM Table Load:
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: SSDT 0xFFFF9DE0CCF15800 0006F6 (v02 PmRef  Cpu0Ist  00003000 INTL 20160422)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Executed 1 blocks of module-level executable AML code
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Dynamic OEM Table Load:
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: SSDT 0xFFFF9DE08B5A4800 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160422)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Executed 1 blocks of module-level executable AML code
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Dynamic OEM Table Load:
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: SSDT 0xFFFF9DE0CCF12800 00065C (v02 PmRef  ApIst    00003000 INTL 20160422)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Executed 1 blocks of module-level executable AML code
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Dynamic OEM Table Load:
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: SSDT 0xFFFF9DE08B710800 00018A (v02 PmRef  ApCst    00003000 INTL 20160422)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Executed 1 blocks of module-level executable AML code
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: EC: EC started
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: EC: interrupt blocked
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: \_SB_.PCI0.LPCB.EC__: Used as first EC
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: \_SB_.PCI0.LPCB.EC__: GPE=0x50, EC_CMD/EC_SC=0x66, EC_DATA=0x62
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: \_SB_.PCI0.LPCB.EC__: Used as boot DSDT EC to handle transactions
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Interpreter enabled
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: (supports S0 S3 S4 S5)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Using IOAPIC for interrupt routing
Jan 15 13:37:57 helmuth-N24-25BU kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Jan 15 13:37:57 helmuth-N24-25BU kernel: ================================================================================
Jan 15 13:37:57 helmuth-N24-25BU kernel: UBSAN: Undefined behaviour in drivers/acpi/sysfs.c:849:33
Jan 15 13:37:57 helmuth-N24-25BU kernel: shift exponent 64 is too large for 64-bit type 'long long unsigned int'
Jan 15 13:37:57 helmuth-N24-25BU kernel: CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc8+ #17
Jan 15 13:37:57 helmuth-N24-25BU kernel: Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 07/07/2017
Jan 15 13:37:57 helmuth-N24-25BU kernel: Call Trace:
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? ftrace_graph_caller+0x98/0x98
Jan 15 13:37:57 helmuth-N24-25BU kernel:  dump_stack+0x70/0xae
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ubsan_epilogue+0x9/0x40
Jan 15 13:37:57 helmuth-N24-25BU kernel:  __ubsan_handle_shift_out_of_bounds+0x12b/0x170
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? ftrace_graph_caller+0x68/0x98
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? acpi_gpe_apply_masked_gpes+0x50/0xa9
Jan 15 13:37:57 helmuth-N24-25BU kernel:  acpi_gpe_apply_masked_gpes+0x50/0xa9
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? ftrace_graph_caller+0x98/0x98
Jan 15 13:37:57 helmuth-N24-25BU kernel:  acpi_scan_init+0x145/0x2e4
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? acpi_sleep_proc_init+0x24/0x24
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? acpi_sleep_proc_init+0x24/0x24
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? ftrace_graph_caller+0x98/0x98
Jan 15 13:37:57 helmuth-N24-25BU kernel:  acpi_init+0x340/0x3a0
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? ftrace_graph_caller+0x98/0x98
Jan 15 13:37:57 helmuth-N24-25BU kernel:  do_one_initcall+0x173/0x200
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? acpi_sleep_proc_init+0x24/0x24
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? do_one_initcall+0x5/0x200
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? ftrace_graph_caller+0x98/0x98
Jan 15 13:37:57 helmuth-N24-25BU kernel:  kernel_init_freeable+0x305/0x395
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? rest_init+0xd0/0xd0
Jan 15 13:37:57 helmuth-N24-25BU kernel:  kernel_init+0xb/0x120
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? rest_init+0xd0/0xd0
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ret_from_fork+0x32/0x40
Jan 15 13:37:57 helmuth-N24-25BU kernel: ================================================================================
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Enabled 6 GPEs in block 00 to 7F
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI Error: [_OSI] Namespace lookup failure, AE_NOT_FOUND (20170831/psargs-364)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI Error: Method parse/execution failed \_SB.PAGD._STA, AE_NOT_FOUND (20170831/psparse-550)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI Error: [_OSI] Namespace lookup failure, AE_NOT_FOUND (20170831/psargs-364)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI Error: Method parse/execution failed \_SB.PAGD._STA, AE_NOT_FOUND (20170831/psparse-550)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
Jan 15 13:37:57 helmuth-N24-25BU kernel: acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
Jan 15 13:37:57 helmuth-N24-25BU kernel: acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
Jan 15 13:37:57 helmuth-N24-25BU kernel: PCI host bridge to bus 0000:00
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fffff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [mem 0x8ac00000-0xdfffffff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: root bus resource [bus 00-fe]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:00.0: [8086:5904] type 00 class 0x060000
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:02.0: [8086:5916] type 00 class 0x030000
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:02.0: reg 0x10: [mem 0xde000000-0xdeffffff 64bit]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit pref]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:08.0: reg 0x10: [mem 0xdf42f000-0xdf42ffff 64bit]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:14.0: reg 0x10: [mem 0xdf410000-0xdf41ffff 64bit]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:14.0: PME# supported from D3hot D3cold
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:14.2: reg 0x10: [mem 0xdf42e000-0xdf42efff 64bit]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:16.0: reg 0x10: [mem 0xdf42d000-0xdf42dfff 64bit]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:16.0: PME# supported from D3hot
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:17.0: [8086:9d03] type 00 class 0x010601
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:17.0: reg 0x10: [mem 0xdf428000-0xdf429fff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:17.0: reg 0x14: [mem 0xdf42c000-0xdf42c0ff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:17.0: reg 0x18: [io  0xf090-0xf097]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:17.0: reg 0x1c: [io  0xf080-0xf083]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:17.0: reg 0x20: [io  0xf060-0xf07f]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:17.0: reg 0x24: [mem 0xdf42b000-0xdf42b7ff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:17.0: PME# supported from D3hot
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.2: [8086:9d12] type 01 class 0x060400
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.5: [8086:9d15] type 01 class 0x060400
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1f.0: [8086:9d58] type 00 class 0x060100
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1f.2: reg 0x10: [mem 0xdf424000-0xdf427fff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1f.3: reg 0x10: [mem 0xdf420000-0xdf423fff 64bit]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1f.3: reg 0x20: [mem 0xdf400000-0xdf40ffff 64bit]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1f.3: PME# supported from D3hot D3cold
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1f.4: reg 0x10: [mem 0xdf42a000-0xdf42a0ff 64bit]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:01:00.0: [1b21:1242] type 00 class 0x0c0330
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:01:00.0: reg 0x10: [mem 0xdf300000-0xdf307fff 64bit]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:01:00.0: enabling Extended Tags
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:01:00.0: PME# supported from D3hot D3cold
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.0: PCI bridge to [bus 01]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.0:   bridge window [mem 0xdf300000-0xdf3fffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:02:00.0: [8086:24f3] type 00 class 0x028000
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:02:00.0: reg 0x10: [mem 0xdf200000-0xdf201fff 64bit]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.2: PCI bridge to [bus 02]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.2:   bridge window [mem 0xdf200000-0xdf2fffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:03:00.0: [10ec:5287] type 00 class 0xff0000
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:03:00.0: reg 0x10: [mem 0xdf115000-0xdf115fff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:03:00.0: reg 0x30: [mem 0xdf100000-0xdf10ffff pref]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:03:00.0: supports D1 D2
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:03:00.1: [10ec:8168] type 00 class 0x020000
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:03:00.1: reg 0x10: [io  0xe000-0xe0ff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:03:00.1: reg 0x18: [mem 0xdf114000-0xdf114fff 64bit]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:03:00.1: reg 0x20: [mem 0xdf110000-0xdf113fff 64bit]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:03:00.1: supports D1 D2
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:03:00.1: PME# supported from D0 D1 D2 D3hot D3cold
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.5: PCI bridge to [bus 03]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.5:   bridge window [io  0xe000-0xefff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.5:   bridge window [mem 0xdf100000-0xdf1fffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:04:00.0: [144d:a804] type 00 class 0x010802
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:04:00.0: reg 0x10: [mem 0xdf000000-0xdf003fff 64bit]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1d.0: PCI bridge to [bus 04]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1d.0:   bridge window [mem 0xdf000000-0xdf0fffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI Error: [_OSI] Namespace lookup failure, AE_NOT_FOUND (20170831/psargs-364)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI Error: Method parse/execution failed \_SB.PAGD._STA, AE_NOT_FOUND (20170831/psparse-550)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: EC: interrupt unblocked
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: EC: event unblocked
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: \_SB_.PCI0.LPCB.EC__: GPE=0x50, EC_CMD/EC_SC=0x66, EC_DATA=0x62
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: \_SB_.PCI0.LPCB.EC__: Used as boot DSDT EC to handle transactions and events
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall acpi_init+0x0/0x3a0 returned 0 after 792968 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pnp_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pnp_init+0x0/0x11 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  balloon_init+0x0/0x2ce @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall balloon_init+0x0/0x2ce returned -19 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  xen_setup_shutdown_event+0x0/0x30 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall xen_setup_shutdown_event+0x0/0x30 returned -19 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  xenbus_probe_backend_init+0x0/0x4e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall xenbus_probe_backend_init+0x0/0x4e returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  xenbus_probe_frontend_init+0x0/0x4e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall xenbus_probe_frontend_init+0x0/0x4e returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  xen_acpi_pad_init+0x0/0x45 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall xen_acpi_pad_init+0x0/0x45 returned -19 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  misc_init+0x0/0xca @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall misc_init+0x0/0xca returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tpm_init+0x0/0xd1 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tpm_init+0x0/0xd1 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  vga_arb_device_init+0x0/0x338 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:02.0: vgaarb: setting as boot VGA device
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:02.0: vgaarb: bridge control possible
Jan 15 13:37:57 helmuth-N24-25BU kernel: vgaarb: loaded
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall vga_arb_device_init+0x0/0x338 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cn_init+0x0/0xe0 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cn_init+0x0/0xe0 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pm860x_i2c_init+0x0/0x2c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pm860x_i2c_init+0x0/0x2c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  wm8400_module_init+0x0/0x2c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall wm8400_module_init+0x0/0x2c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  wm831x_i2c_init+0x0/0x2c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall wm831x_i2c_init+0x0/0x2c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  wm831x_spi_init+0x0/0x28 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall wm831x_spi_init+0x0/0x28 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  wm8350_i2c_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall wm8350_i2c_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tps65910_i2c_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tps65910_i2c_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tps80031_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tps80031_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ezx_pcap_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ezx_pcap_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  da903x_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall da903x_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  da9052_spi_init+0x0/0x2c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall da9052_spi_init+0x0/0x2c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  da9052_i2c_init+0x0/0x2c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall da9052_i2c_init+0x0/0x2c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  lp8788_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall lp8788_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  da9055_i2c_init+0x0/0x2c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall da9055_i2c_init+0x0/0x2c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  max77843_i2c_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall max77843_i2c_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  max8925_i2c_init+0x0/0x2c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall max8925_i2c_init+0x0/0x2c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  max8997_i2c_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall max8997_i2c_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  max8998_i2c_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall max8998_i2c_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ab3100_i2c_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ab3100_i2c_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tps6586x_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tps6586x_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tps65090_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tps65090_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  aat2870_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall aat2870_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  palmas_i2c_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall palmas_i2c_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  rc5t583_i2c_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall rc5t583_i2c_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sec_pmic_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sec_pmic_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  as3711_i2c_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall as3711_i2c_init+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  libnvdimm_init+0x0/0x3c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall libnvdimm_init+0x0/0x3c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dax_fs_init+0x0/0xd3 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dax_fs_init+0x0/0xd3 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dma_buf_init+0x0/0xdb @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dma_buf_init+0x0/0xdb returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_scsi+0x0/0xa5 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: SCSI subsystem initialized
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_scsi+0x0/0xa5 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ata_init+0x0/0x41d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: libata version 3.00 loaded.
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ata_init+0x0/0x41d returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  phy_init+0x0/0x4e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall phy_init+0x0/0x4e returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  usb_init+0x0/0x178 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: bus type USB registered
Jan 15 13:37:57 helmuth-N24-25BU kernel: usbcore: registered new interface driver usbfs
Jan 15 13:37:57 helmuth-N24-25BU kernel: usbcore: registered new interface driver hub
Jan 15 13:37:57 helmuth-N24-25BU kernel: usbcore: registered new device driver usb
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall usb_init+0x0/0x178 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  serio_init+0x0/0x2a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall serio_init+0x0/0x2a returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  input_init+0x0/0xfd @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall input_init+0x0/0xfd returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  rtc_init+0x0/0x65 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall rtc_init+0x0/0x65 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dw_i2c_init_driver+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dw_i2c_init_driver+0x0/0x13 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  power_supply_class_init+0x0/0x58 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall power_supply_class_init+0x0/0x58 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  hwmon_init+0x0/0xf9 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall hwmon_init+0x0/0xf9 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  md_init+0x0/0x161 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall md_init+0x0/0x161 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  edac_init+0x0/0x70 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: EDAC MC: Ver: 3.0.0
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall edac_init+0x0/0x70 returned 0 after 3906 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  mmc_init+0x0/0x35 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall mmc_init+0x0/0x35 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  leds_init+0x0/0x54 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall leds_init+0x0/0x54 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dmi_init+0x0/0x114 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dmi_init+0x0/0x114 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  efisubsys_init+0x0/0x328 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: Registered efivars operations
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall efisubsys_init+0x0/0x328 returned 0 after 15625 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  devfreq_init+0x0/0xbb @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall devfreq_init+0x0/0xbb returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  devfreq_event_init+0x0/0x67 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall devfreq_event_init+0x0/0x67 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  devfreq_simple_ondemand_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall devfreq_simple_ondemand_init+0x0/0x11 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  devfreq_performance_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall devfreq_performance_init+0x0/0x11 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  devfreq_powersave_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall devfreq_powersave_init+0x0/0x11 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  devfreq_userspace_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall devfreq_userspace_init+0x0/0x11 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  devfreq_passive_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall devfreq_passive_init+0x0/0x11 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  vme_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall vme_init+0x0/0x11 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ras_init+0x0/0xf @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ras_init+0x0/0xf returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  nvmem_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall nvmem_init+0x0/0x11 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pci_subsys_init+0x0/0x88 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: PCI: Using ACPI for IRQ routing
Jan 15 13:37:57 helmuth-N24-25BU kernel: PCI: pci_cache_line_size set to 64 bytes
Jan 15 13:37:57 helmuth-N24-25BU kernel: e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: e820: reserve RAM buffer [mem 0x7a4f1000-0x7bffffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: e820: reserve RAM buffer [mem 0x7eb4a000-0x7fffffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: e820: reserve RAM buffer [mem 0x7f593000-0x7fffffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: e820: reserve RAM buffer [mem 0x874400000-0x877ffffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pci_subsys_init+0x0/0x88 returned 0 after 31250 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proto_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proto_init+0x0/0x11 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  net_dev_init+0x0/0x386 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall net_dev_init+0x0/0x386 returned 0 after 3906 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  neigh_init+0x0/0x80 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall neigh_init+0x0/0x80 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  fib_notifier_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall fib_notifier_init+0x0/0x11 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  fib_rules_init+0x0/0xac @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall fib_rules_init+0x0/0xac returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_cgroup_netprio+0x0/0x14 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_cgroup_netprio+0x0/0x14 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  bpf_lwt_init+0x0/0x16 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall bpf_lwt_init+0x0/0x16 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pktsched_init+0x0/0x10f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pktsched_init+0x0/0x10f returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tc_filter_init+0x0/0x83 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tc_filter_init+0x0/0x83 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tc_action_init+0x0/0x69 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tc_action_init+0x0/0x69 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  genl_init+0x0/0x36 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall genl_init+0x0/0x36 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ipv4_netfilter_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ipv4_netfilter_init+0x0/0x11 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cipso_v4_init+0x0/0xcf @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cipso_v4_init+0x0/0xcf returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  wireless_nlevent_init+0x0/0x3c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall wireless_nlevent_init+0x0/0x3c returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  netlbl_init+0x0/0x79 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: NetLabel: Initializing
Jan 15 13:37:57 helmuth-N24-25BU kernel: NetLabel:  domain hash size = 128
Jan 15 13:37:57 helmuth-N24-25BU kernel: NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
Jan 15 13:37:57 helmuth-N24-25BU kernel: NetLabel:  unlabeled traffic allowed by default
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall netlbl_init+0x0/0x79 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  rfkill_init+0x0/0x16a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall rfkill_init+0x0/0x16a returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  xen_mcfg_late+0x0/0x115 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall xen_mcfg_late+0x0/0x115 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  watchdog_init+0x0/0x103 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall watchdog_init+0x0/0x103 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  nmi_warning_debugfs+0x0/0x27 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall nmi_warning_debugfs+0x0/0x27 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  save_microcode_in_initrd+0x0/0xdc @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall save_microcode_in_initrd+0x0/0xdc returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  hpet_late_init+0x0/0x169 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
Jan 15 13:37:57 helmuth-N24-25BU kernel: hpet0: 8 comparators, 64-bit 24.000000 MHz counter
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall hpet_late_init+0x0/0x169 returned 0 after 3906 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_amd_nbs+0x0/0x157 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_amd_nbs+0x0/0x157 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sugov_register+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sugov_register+0x0/0x11 returned 0 after 0 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  clocksource_done_booting+0x0/0x42 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: clocksource: Switched to clocksource hpet
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall clocksource_done_booting+0x0/0x42 returned 0 after 24 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tracer_init_tracefs+0x0/0x227 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tracer_init_tracefs+0x0/0x227 returned 0 after 5787 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_trace_printk_function_export+0x0/0x2d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_trace_printk_function_export+0x0/0x2d returned 0 after 28 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_graph_tracefs+0x0/0x2d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_graph_tracefs+0x0/0x2d returned 0 after 28 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  event_trace_init+0x0/0x312 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall event_trace_init+0x0/0x312 returned 0 after 264416 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_kprobe_trace+0x0/0x8a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_kprobe_trace+0x0/0x8a returned 0 after 55 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  bpf_init+0x0/0x4a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall bpf_init+0x0/0x4a returned 0 after 19 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_pipe_fs+0x0/0x47 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_pipe_fs+0x0/0x47 returned 0 after 86 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cgroup_writeback_init+0x0/0x2b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cgroup_writeback_init+0x0/0x2b returned 0 after 111 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  inotify_user_setup+0x0/0x48 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall inotify_user_setup+0x0/0x48 returned 0 after 29 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  eventpoll_init+0x0/0xcf @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall eventpoll_init+0x0/0xcf returned 0 after 167 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  anon_inode_init+0x0/0x73 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall anon_inode_init+0x0/0x73 returned 0 after 115 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_dax_wait_table+0x0/0x40 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_dax_wait_table+0x0/0x40 returned 0 after 1582 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_locks_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_locks_init+0x0/0x1f returned 0 after 12 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dquot_init+0x0/0x1cd @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: VFS: Disk quotas dquot_6.6.0
Jan 15 13:37:57 helmuth-N24-25BU kernel: VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dquot_init+0x0/0x1cd returned 0 after 169 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  quota_init+0x0/0x24 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall quota_init+0x0/0x24 returned 0 after 59 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_cmdline_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_cmdline_init+0x0/0x1f returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_consoles_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_consoles_init+0x0/0x1f returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_cpuinfo_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_cpuinfo_init+0x0/0x1f returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_devices_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_devices_init+0x0/0x1f returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_interrupts_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_interrupts_init+0x0/0x1f returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_loadavg_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_loadavg_init+0x0/0x1f returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_meminfo_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_meminfo_init+0x0/0x1f returned 0 after 9 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_stat_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_stat_init+0x0/0x1f returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_uptime_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_uptime_init+0x0/0x1f returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_version_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_version_init+0x0/0x1f returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_softirqs_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_softirqs_init+0x0/0x1f returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_kcore_init+0x0/0x238 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_kcore_init+0x0/0x238 returned 0 after 45 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  vmcore_init+0x0/0x45c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall vmcore_init+0x0/0x45c returned 0 after 5 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_kmsg_init+0x0/0x22 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_kmsg_init+0x0/0x22 returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_page_init+0x0/0x56 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_page_init+0x0/0x56 returned 0 after 21 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_ramfs_fs+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_ramfs_fs+0x0/0x1f returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_hugetlbfs_fs+0x0/0x356 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_hugetlbfs_fs+0x0/0x356 returned 0 after 241 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tomoyo_initerface_init+0x0/0x19e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tomoyo_initerface_init+0x0/0x19e returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  aa_create_aafs+0x0/0x47b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: AppArmor: AppArmor Filesystem Enabled
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall aa_create_aafs+0x0/0x47b returned 0 after 1566 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  blk_scsi_ioctl_init+0x0/0x38c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall blk_scsi_ioctl_init+0x0/0x38c returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dynamic_debug_init_debugfs+0x0/0x62 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dynamic_debug_init_debugfs+0x0/0x62 returned 0 after 53 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  simplefb_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall simplefb_init+0x0/0x13 returned 0 after 105 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  acpi_event_init+0x0/0x2d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall acpi_event_init+0x0/0x2d returned 0 after 57 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pnp_system_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pnp_system_init+0x0/0x11 returned 0 after 64 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pnpacpi_init+0x0/0x6e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: pnp: PnP ACPI init
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:00: [io  0x0680-0x069f] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:00: [io  0xffff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:00: [io  0xffff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:00: [io  0xffff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:00: [io  0x1800-0x18fe] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:00: [io  0x164e-0x164f] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:00: [io  0x3322-0x3323] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
Jan 15 13:37:57 helmuth-N24-25BU kernel: pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:02: [io  0x1854-0x1857] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:02: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
Jan 15 13:37:57 helmuth-N24-25BU kernel: pnp 00:03: Plug and Play ACPI device, IDs PNP0303 (active)
Jan 15 13:37:57 helmuth-N24-25BU kernel: pnp 00:04: Plug and Play ACPI device, IDs SYN1217 PNP0f13 (active)
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:05: [mem 0xfed45000-0xfed8ffff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:05: [mem 0xff000000-0xffffffff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:05: [mem 0xfee00000-0xfeefffff] could not be reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:05: [mem 0xdffe0000-0xdfffffff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:06: [mem 0xfd000000-0xfdabffff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:06: [mem 0xfdad0000-0xfdadffff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:06: [mem 0xfdb00000-0xfdffffff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:06: [mem 0xfe000000-0xfe01ffff] could not be reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:06: [mem 0xfe036000-0xfe03bfff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:06: [mem 0xfe03d000-0xfe3fffff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:06: [mem 0xfe410000-0xfe7fffff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:07: [io  0xff00-0xfffe] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:08: [mem 0xfe029000-0xfe029fff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:08: [mem 0xfe028000-0xfe028fff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:08: [mem 0xfdaf0000-0xfdafffff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:08: [mem 0xfdae0000-0xfdaeffff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:08: [mem 0xfdac0000-0xfdacffff] has been reserved
Jan 15 13:37:57 helmuth-N24-25BU kernel: system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI Error: [_OSI] Namespace lookup failure, AE_NOT_FOUND (20170831/psargs-364)
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI Error: Method parse/execution failed \_SB.PAGD._STA, AE_NOT_FOUND (20170831/psparse-550)
Jan 15 13:37:57 helmuth-N24-25BU kernel: pnp: PnP ACPI: found 9 devices
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pnpacpi_init+0x0/0x6e returned 0 after 32942 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  chr_dev_init+0x0/0x15f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall chr_dev_init+0x0/0x15f returned 0 after 18485 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  firmware_class_init+0x0/0xff @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall firmware_class_init+0x0/0xff returned 0 after 48 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  thermal_init+0x0/0xf1 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall thermal_init+0x0/0xf1 returned 0 after 104 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cpufreq_gov_performance_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cpufreq_gov_performance_init+0x0/0x11 returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  map_properties+0x0/0x695 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall map_properties+0x0/0x695 returned 0 after 5 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_acpi_pm_clocksource+0x0/0xd7 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_acpi_pm_clocksource+0x0/0xd7 returned 0 after 4420 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pcibios_assign_resources+0x0/0x187 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.0: PCI bridge to [bus 01]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.0:   bridge window [mem 0xdf300000-0xdf3fffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.2: PCI bridge to [bus 02]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.2:   bridge window [mem 0xdf200000-0xdf2fffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.5: PCI bridge to [bus 03]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.5:   bridge window [io  0xe000-0xefff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1c.5:   bridge window [mem 0xdf100000-0xdf1fffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1d.0: PCI bridge to [bus 04]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:1d.0:   bridge window [mem 0xdf000000-0xdf0fffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: resource 20 [mem 0x8ac00000-0xdfffffff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:00: resource 21 [mem 0xfd000000-0xfe7fffff window]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:01: resource 1 [mem 0xdf300000-0xdf3fffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:02: resource 1 [mem 0xdf200000-0xdf2fffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:03: resource 1 [mem 0xdf100000-0xdf1fffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci_bus 0000:04: resource 1 [mem 0xdf000000-0xdf0fffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pcibios_assign_resources+0x0/0x187 returned 0 after 4208 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sysctl_core_init+0x0/0x2b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sysctl_core_init+0x0/0x2b returned 0 after 47 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  eth_offload_init+0x0/0x14 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall eth_offload_init+0x0/0x14 returned 0 after 5 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  inet_init+0x0/0x2d3 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: NET: Registered protocol family 2
Jan 15 13:37:57 helmuth-N24-25BU kernel: TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
Jan 15 13:37:57 helmuth-N24-25BU kernel: TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Jan 15 13:37:57 helmuth-N24-25BU kernel: TCP: Hash tables configured (established 262144 bind 65536)
Jan 15 13:37:57 helmuth-N24-25BU kernel: UDP hash table entries: 16384 (order: 7, 524288 bytes)
Jan 15 13:37:57 helmuth-N24-25BU kernel: UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall inet_init+0x0/0x2d3 returned 0 after 5312 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ipv4_offload_init+0x0/0x74 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ipv4_offload_init+0x0/0x74 returned 0 after 7 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  af_unix_init+0x0/0x4e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: NET: Registered protocol family 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall af_unix_init+0x0/0x4e returned 0 after 65 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ipv6_offload_init+0x0/0x7f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ipv6_offload_init+0x0/0x7f returned 0 after 8 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pci_apply_final_quirks+0x0/0x110 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
Jan 15 13:37:57 helmuth-N24-25BU kernel: PCI: CLS 64 bytes, default 64
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pci_apply_final_quirks+0x0/0x110 returned 0 after 1463 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  acpi_reserve_resources+0x0/0xeb @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall acpi_reserve_resources+0x0/0xeb returned 0 after 29 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  populate_rootfs+0x0/0x101 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: Trying to unpack rootfs image as initramfs...
Jan 15 13:37:57 helmuth-N24-25BU kernel: Freeing initrd memory: 60336K
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall populate_rootfs+0x0/0x101 returned 0 after 1874249 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pci_iommu_init+0x0/0x3c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Jan 15 13:37:57 helmuth-N24-25BU kernel: software IO TLB [mem 0x755a6000-0x795a6000] (64MB) mapped at [0000000001e738b7-000000003267fa5d]
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pci_iommu_init+0x0/0x3c returned 0 after 299 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ir_dev_scope_init+0x0/0x33 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ir_dev_scope_init+0x0/0x33 returned 0 after 72 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ia32_binfmt_init+0x0/0x14 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ia32_binfmt_init+0x0/0x14 returned 0 after 20 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  amd_uncore_init+0x0/0x2c7 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall amd_uncore_init+0x0/0x2c7 returned -19 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  amd_ibs_init+0x0/0x21b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall amd_ibs_init+0x0/0x21b returned -19 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  amd_iommu_pc_init+0x0/0x322 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall amd_iommu_pc_init+0x0/0x322 returned -19 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  msr_init+0x0/0x333 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall msr_init+0x0/0x333 returned 0 after 16 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  intel_uncore_init+0x0/0x354 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall intel_uncore_init+0x0/0x354 returned 0 after 468 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  register_kernel_offset_dumper+0x0/0x1b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall register_kernel_offset_dumper+0x0/0x1b returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  i8259A_init_ops+0x0/0x21 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall i8259A_init_ops+0x0/0x21 returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_tsc_clocksource+0x0/0x124 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x29dc05e54fc, max_idle_ns: 440795291716 ns
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_tsc_clocksource+0x0/0x124 returned 0 after 28 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  add_rtc_cmos+0x0/0xdc @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall add_rtc_cmos+0x0/0xdc returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  i8237A_init_ops+0x0/0x14 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall i8237A_init_ops+0x0/0x14 returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  thermal_throttle_init_device+0x0/0x42 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall thermal_throttle_init_device+0x0/0x42 returned 0 after 161 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ioapic_init_ops+0x0/0x14 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ioapic_init_ops+0x0/0x14 returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  register_e820_pmem+0x0/0x42 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall register_e820_pmem+0x0/0x42 returned 0 after 39 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  add_pcspkr+0x0/0x6f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall add_pcspkr+0x0/0x6f returned 0 after 279 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  start_periodic_check_for_corruption+0x0/0x50 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: Scanning for low memory corruption every 60 seconds
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall start_periodic_check_for_corruption+0x0/0x50 returned 0 after 32 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sysfb_init+0x0/0xcf @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sysfb_init+0x0/0xcf returned 0 after 309 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  audit_classes_init+0x0/0xaf @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall audit_classes_init+0x0/0xaf returned 0 after 38 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pt_dump_init+0x0/0x32 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pt_dump_init+0x0/0x32 returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  crc32c_intel_mod_init+0x0/0x6e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall crc32c_intel_mod_init+0x0/0x6e returned 0 after 153 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  iosf_mbi_init+0x0/0xb8 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall iosf_mbi_init+0x0/0xb8 returned 0 after 247 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_execdomains_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_execdomains_init+0x0/0x1f returned 0 after 12 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  register_warn_debugfs+0x0/0x24 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall register_warn_debugfs+0x0/0x24 returned 0 after 28 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cpuhp_sysfs_init+0x0/0x6d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cpuhp_sysfs_init+0x0/0x6d returned 0 after 190 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ioresources_init+0x0/0x36 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ioresources_init+0x0/0x36 returned 0 after 16 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_sched_debug_procfs+0x0/0x29 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_sched_debug_procfs+0x0/0x29 returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  snapshot_device_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall snapshot_device_init+0x0/0x11 returned 0 after 279 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  irq_gc_init_ops+0x0/0x14 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall irq_gc_init_ops+0x0/0x14 returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  irq_pm_init_ops+0x0/0x14 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall irq_pm_init_ops+0x0/0x14 returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  klp_init+0x0/0x29 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall klp_init+0x0/0x29 returned 0 after 18 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  timekeeping_init_ops+0x0/0x14 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall timekeeping_init_ops+0x0/0x14 returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_clocksource_sysfs+0x0/0x69 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_clocksource_sysfs+0x0/0x69 returned 0 after 575 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_timer_list_procfs+0x0/0x29 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_timer_list_procfs+0x0/0x29 returned 0 after 26 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  alarmtimer_init+0x0/0x134 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall alarmtimer_init+0x0/0x134 returned 0 after 432 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_posix_timers+0x0/0x2a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_posix_timers+0x0/0x2a returned 0 after 65 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  clockevents_init_sysfs+0x0/0x137 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall clockevents_init_sysfs+0x0/0x137 returned 0 after 1293 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_dma_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_dma_init+0x0/0x1f returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_modules_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_modules_init+0x0/0x1f returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  kallsyms_init+0x0/0x22 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall kallsyms_init+0x0/0x22 returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pid_namespaces_init+0x0/0x40 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pid_namespaces_init+0x0/0x40 returned 0 after 74 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  audit_watch_init+0x0/0x3a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall audit_watch_init+0x0/0x3a returned 0 after 7 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  audit_fsnotify_init+0x0/0x3a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall audit_fsnotify_init+0x0/0x3a returned 0 after 7 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  audit_tree_init+0x0/0xb4 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall audit_tree_init+0x0/0xb4 returned 0 after 7 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_kprobes+0x0/0x308 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_kprobes+0x0/0x308 returned 0 after 1182 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  seccomp_sysctl_init+0x0/0x2c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall seccomp_sysctl_init+0x0/0x2c returned 0 after 78 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  utsname_sysctl_init+0x0/0x14 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall utsname_sysctl_init+0x0/0x14 returned 0 after 17 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_tracepoints+0x0/0x28 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_tracepoints+0x0/0x28 returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  stack_trace_init+0x0/0xb0 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall stack_trace_init+0x0/0xb0 returned 0 after 80 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_mmio_trace+0x0/0xc @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_mmio_trace+0x0/0xc returned 0 after 13 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_blk_tracer+0x0/0x50 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_blk_tracer+0x0/0x50 returned 0 after 83 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  perf_event_sysfs_init+0x0/0x97 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall perf_event_sysfs_init+0x0/0x97 returned 0 after 3151 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  padata_driver_init+0x0/0x39 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall padata_driver_init+0x0/0x39 returned 0 after 7 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  system_trusted_keyring_init+0x0/0x127 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: Initialise system trusted keyrings
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall system_trusted_keyring_init+0x0/0x127 returned 0 after 85 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  kswapd_init+0x0/0x85 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall kswapd_init+0x0/0x85 returned 0 after 161 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  extfrag_debug_init+0x0/0x78 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall extfrag_debug_init+0x0/0x78 returned 0 after 140 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  mm_compute_batch_init+0x0/0x19 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall mm_compute_batch_init+0x0/0x19 returned 0 after 7 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  slab_proc_init+0x0/0x22 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall slab_proc_init+0x0/0x22 returned 0 after 11 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  workingset_init+0x0/0x9d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: workingset: timestamp_bits=40 max_order=23 bucket_order=0
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall workingset_init+0x0/0x9d returned 0 after 27 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_vmalloc_init+0x0/0x22 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_vmalloc_init+0x0/0x22 returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  procswaps_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall procswaps_init+0x0/0x1f returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_frontswap+0x0/0x91 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_frontswap+0x0/0x91 returned 0 after 129 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  slab_sysfs_init+0x0/0x120 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall slab_sysfs_init+0x0/0x120 returned 0 after 29286 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_cleancache+0x0/0x91 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_cleancache+0x0/0x91 returned 0 after 131 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_zbud+0x0/0x20 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: zbud: loaded
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_zbud+0x0/0x20 returned 0 after 16 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  zs_init+0x0/0x74 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall zs_init+0x0/0x74 returned 0 after 149 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  hmm_init+0x0/0x64 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall hmm_init+0x0/0x64 returned 0 after 34 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  fcntl_init+0x0/0x2a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall fcntl_init+0x0/0x2a returned 0 after 40 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_filesystems_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_filesystems_init+0x0/0x1f returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  start_dirtytime_writeback+0x0/0x2a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall start_dirtytime_writeback+0x0/0x2a returned 0 after 9 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  blkdev_init+0x0/0x2a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall blkdev_init+0x0/0x2a returned 0 after 65 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dio_init+0x0/0x2d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dio_init+0x0/0x2d returned 0 after 419 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dnotify_init+0x0/0x79 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dnotify_init+0x0/0x79 returned 0 after 71 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  fanotify_user_setup+0x0/0x77 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall fanotify_user_setup+0x0/0x77 returned 0 after 123 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  userfaultfd_init+0x0/0x2e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall userfaultfd_init+0x0/0x2e returned 0 after 364 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  aio_setup+0x0/0xa1 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall aio_setup+0x0/0xa1 returned 0 after 174 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  fscrypt_init+0x0/0xa4 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall fscrypt_init+0x0/0xa4 returned 0 after 924 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_sys32_ioctl+0x0/0x28 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_sys32_ioctl+0x0/0x28 returned 0 after 2840 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  mbcache_init+0x0/0x31 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall mbcache_init+0x0/0x31 returned 0 after 426 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_devpts_fs+0x0/0x28 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_devpts_fs+0x0/0x28 returned 0 after 26 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ext4_init_fs+0x0/0x1ab @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ext4_init_fs+0x0/0x1ab returned 0 after 1789 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  journal_init+0x0/0x118 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall journal_init+0x0/0x118 returned 0 after 1005 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_squashfs_fs+0x0/0x6b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: squashfs: version 4.0 (2009/01/31) Phillip Lougher
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_squashfs_fs+0x0/0x6b returned 0 after 380 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_fat_fs+0x0/0x4a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_fat_fs+0x0/0x4a returned 0 after 704 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_vfat_fs+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_vfat_fs+0x0/0x11 returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ecryptfs_init+0x0/0x215 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ecryptfs_init+0x0/0x215 returned 0 after 1523 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_nls_cp437+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_nls_cp437+0x0/0x13 returned 0 after 5 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  fuse_init+0x0/0x1d9 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: fuse init (API version 7.26)
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall fuse_init+0x0/0x1d9 returned 0 after 1078 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_pstore_fs+0x0/0x4a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_pstore_fs+0x0/0x4a returned 0 after 15 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  efivarfs_init+0x0/0x46 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall efivarfs_init+0x0/0x46 returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ipc_init+0x0/0x4c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ipc_init+0x0/0x4c returned 0 after 40 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ipc_sysctl_init+0x0/0x14 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ipc_sysctl_init+0x0/0x14 returned 0 after 19 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_mqueue_fs+0x0/0x1d3 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_mqueue_fs+0x0/0x1d3 returned 0 after 505 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  key_proc_init+0x0/0x58 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall key_proc_init+0x0/0x58 returned 0 after 16 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  selinux_nf_ip_init+0x0/0x3b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall selinux_nf_ip_init+0x0/0x3b returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_sel_fs+0x0/0xa1 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_sel_fs+0x0/0xa1 returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  selnl_init+0x0/0x7d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall selnl_init+0x0/0x7d returned 0 after 35 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sel_netif_init+0x0/0x9c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sel_netif_init+0x0/0x9c returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sel_netnode_init+0x0/0x109 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sel_netnode_init+0x0/0x109 returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sel_netport_init+0x0/0x109 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sel_netport_init+0x0/0x109 returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  aurule_init+0x0/0x2b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall aurule_init+0x0/0x2b returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_smk_fs+0x0/0x10a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_smk_fs+0x0/0x10a returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  smack_nf_ip_init+0x0/0x29 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall smack_nf_ip_init+0x0/0x29 returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  crypto_algapi_init+0x0/0xd @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall crypto_algapi_init+0x0/0xd returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  seqiv_module_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall seqiv_module_init+0x0/0x11 returned 0 after 9 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dh_init+0x0/0x20 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dh_init+0x0/0x20 returned 0 after 140 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  rsa_init+0x0/0x50 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall rsa_init+0x0/0x50 returned 0 after 118 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  hmac_module_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall hmac_module_init+0x0/0x11 returned 0 after 8 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  crypto_null_mod_init+0x0/0x48 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall crypto_null_mod_init+0x0/0x48 returned 0 after 438 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  md5_mod_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall md5_mod_init+0x0/0x11 returned 0 after 110 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sha1_generic_mod_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sha1_generic_mod_init+0x0/0x11 returned 0 after 117 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sha256_generic_mod_init+0x0/0x16 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sha256_generic_mod_init+0x0/0x16 returned 0 after 207 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sha512_generic_mod_init+0x0/0x16 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sha512_generic_mod_init+0x0/0x16 returned 0 after 212 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  crypto_ecb_module_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall crypto_ecb_module_init+0x0/0x11 returned 0 after 9 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  crypto_cbc_module_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall crypto_cbc_module_init+0x0/0x11 returned 0 after 9 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  crypto_cts_module_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall crypto_cts_module_init+0x0/0x11 returned 0 after 8 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  crypto_module_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall crypto_module_init+0x0/0x11 returned 0 after 9 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  crypto_ctr_module_init+0x0/0x3c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall crypto_ctr_module_init+0x0/0x3c returned 0 after 13 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  crypto_gcm_module_init+0x0/0xbe @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall crypto_gcm_module_init+0x0/0xbe returned 0 after 24 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  aes_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall aes_init+0x0/0x11 returned 0 after 116 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  crc32c_mod_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall crc32c_mod_init+0x0/0x11 returned 0 after 110 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  crct10dif_mod_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall crct10dif_mod_init+0x0/0x11 returned 0 after 115 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  lzo_mod_init+0x0/0x3a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall lzo_mod_init+0x0/0x3a returned 0 after 294 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  drbg_init+0x0/0xec @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall drbg_init+0x0/0xec returned 0 after 2356 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  jent_mod_init+0x0/0x2e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall jent_mod_init+0x0/0x2e returned 0 after 1017 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ghash_mod_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ghash_mod_init+0x0/0x11 returned 0 after 116 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  asymmetric_key_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: Key type asymmetric registered
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall asymmetric_key_init+0x0/0x11 returned 0 after 18 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  x509_key_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: Asymmetric key parser 'x509' registered
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall x509_key_init+0x0/0x11 returned 0 after 17 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  proc_genhd_init+0x0/0x36 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall proc_genhd_init+0x0/0x36 returned 0 after 14 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  bsg_init+0x0/0x2b7 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall bsg_init+0x0/0x2b7 returned 0 after 473 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  throtl_init+0x0/0x41 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall throtl_init+0x0/0x41 returned 0 after 208 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  noop_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: io scheduler noop registered
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall noop_init+0x0/0x11 returned 0 after 17 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  deadline_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: io scheduler deadline registered (default)
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall deadline_init+0x0/0x11 returned 0 after 17 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cfq_init+0x0/0x74 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: io scheduler cfq registered
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cfq_init+0x0/0x74 returned 0 after 872 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  deadline_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: io scheduler mq-deadline registered (default)
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall deadline_init+0x0/0x11 returned 0 after 18 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  kyber_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: io scheduler kyber registered
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall kyber_init+0x0/0x11 returned 0 after 19 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  btree_module_init+0x0/0x25 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall btree_module_init+0x0/0x25 returned 0 after 47 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  crc_t10dif_mod_init+0x0/0x39 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall crc_t10dif_mod_init+0x0/0x39 returned 0 after 13 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  percpu_counter_startup+0x0/0x51 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall percpu_counter_startup+0x0/0x51 returned 0 after 170 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sg_pool_init+0x0/0x361 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sg_pool_init+0x0/0x361 returned 0 after 193 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  phy_core_init+0x0/0x63 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall phy_core_init+0x0/0x63 returned 0 after 29 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  amd_gpio_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall amd_gpio_driver_init+0x0/0x13 returned 0 after 138 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  crystalcove_pwm_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall crystalcove_pwm_driver_init+0x0/0x13 returned 0 after 100 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pci_proc_init+0x0/0x66 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pci_proc_init+0x0/0x66 returned 0 after 249 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pcie_portdrv_init+0x0/0x86 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pcie_portdrv_init+0x0/0x86 returned 0 after 1425 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  aer_service_init+0x0/0x32 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall aer_service_init+0x0/0x32 returned 0 after 65 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pcie_pme_service_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pcie_pme_service_init+0x0/0x11 returned 0 after 63 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dpc_service_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dpc_service_init+0x0/0x11 returned 0 after 66 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pci_hotplug_init+0x0/0x49 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pci_hotplug_init+0x0/0x49 returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pcied_init+0x0/0x8c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pcied_init+0x0/0x8c returned 0 after 62 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dw_plat_pcie_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dw_plat_pcie_driver_init+0x0/0x13 returned 0 after 81 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  imsttfb_init+0x0/0x17f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall imsttfb_init+0x0/0x17f returned 0 after 133 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  asiliantfb_init+0x0/0x32 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall asiliantfb_init+0x0/0x32 returned 0 after 133 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  vesafb_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall vesafb_driver_init+0x0/0x13 returned 0 after 101 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  efifb_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall efifb_driver_init+0x0/0x13 returned 0 after 100 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  intel_idle_init+0x0/0x81a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: intel_idle: MWAIT substates: 0x11142120
Jan 15 13:37:57 helmuth-N24-25BU kernel: intel_idle: v0.4.1 model 0x8E
Jan 15 13:37:57 helmuth-N24-25BU kernel: intel_idle: lapic_timer_reliable_states 0xffffffff
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall intel_idle_init+0x0/0x81a returned 0 after 515 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  acpi_ac_init+0x0/0x16b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: AC Adapter [AC] (off-line)
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall acpi_ac_init+0x0/0x16b returned 0 after 2595 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  acpi_button_driver_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Power Button [PWRB]
Jan 15 13:37:57 helmuth-N24-25BU kernel: input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Sleep Button [SLPB]
Jan 15 13:37:57 helmuth-N24-25BU kernel: input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Lid Switch [LID0]
Jan 15 13:37:57 helmuth-N24-25BU kernel: input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Power Button [PWRF]
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall acpi_button_driver_init+0x0/0x11 returned 0 after 1432 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  acpi_fan_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall acpi_fan_driver_init+0x0/0x13 returned 0 after 137 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  acpi_processor_driver_init+0x0/0x98 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall acpi_processor_driver_init+0x0/0x98 returned 0 after 798 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  acpi_thermal_init+0x0/0x7f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
Jan 15 13:37:57 helmuth-N24-25BU kernel: thermal LNXTHERM:00: registered as thermal_zone0
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Thermal Zone [TZ0] (53 C)
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall acpi_thermal_init+0x0/0x7f returned 0 after 1143 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  acpi_battery_init+0x0/0x30 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall acpi_battery_init+0x0/0x30 returned 0 after 25 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  acpi_hed_driver_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall acpi_hed_driver_init+0x0/0x11 returned 0 after 405 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  bgrt_init+0x0/0xb5 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall bgrt_init+0x0/0xb5 returned 0 after 82 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  erst_init+0x0/0x32e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall erst_init+0x0/0x32e returned 0 after 9 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ghes_init+0x0/0x1ac @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ghes_init+0x0/0x1ac returned -19 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  gpio_clk_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall gpio_clk_driver_init+0x0/0x13 returned 0 after 101 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  plt_clk_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall plt_clk_driver_init+0x0/0x13 returned 0 after 103 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Battery Slot [BAT0] (battery present)
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  virtio_mmio_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall virtio_mmio_init+0x0/0x13 returned 0 after 131 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  virtio_pci_driver_init+0x0/0x1a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall virtio_pci_driver_init+0x0/0x1a returned 0 after 175 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  virtio_balloon_driver_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall virtio_balloon_driver_init+0x0/0x11 returned 0 after 79 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  xenbus_probe_initcall+0x0/0x4a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall xenbus_probe_initcall+0x0/0x4a returned -19 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  xenbus_init+0x0/0x36 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall xenbus_init+0x0/0x36 returned -19 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  xenbus_backend_init+0x0/0x4a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall xenbus_backend_init+0x0/0x4a returned -19 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  hypervisor_subsys_init+0x0/0x3b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall hypervisor_subsys_init+0x0/0x3b returned -19 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  hyper_sysfs_init+0x0/0x188 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall hyper_sysfs_init+0x0/0x188 returned -19 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  platform_driver_init+0x0/0x1a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall platform_driver_init+0x0/0x1a returned 0 after 133 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  xen_late_init_mcelog+0x0/0x63 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall xen_late_init_mcelog+0x0/0x63 returned -19 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  xen_acpi_processor_init+0x0/0x338 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall xen_acpi_processor_init+0x0/0x338 returned -19 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  n_null_init+0x0/0x2b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall n_null_init+0x0/0x2b returned 0 after 5 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pty_init+0x0/0x3cb @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pty_init+0x0/0x3cb returned 0 after 333 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sysrq_init+0x0/0x63 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sysrq_init+0x0/0x63 returned 0 after 18 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  xen_hvc_init+0x0/0x3fb @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall xen_hvc_init+0x0/0x3fb returned -19 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  serial8250_init+0x0/0x1b7 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall serial8250_init+0x0/0x1b7 returned 0 after 15919 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  serial_pci_driver_init+0x0/0x1a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall serial_pci_driver_init+0x0/0x1a returned 0 after 142 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  exar_pci_driver_init+0x0/0x1a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall exar_pci_driver_init+0x0/0x1a returned 0 after 209 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  max310x_uart_init+0x0/0x35 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall max310x_uart_init+0x0/0x35 returned 0 after 132 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sccnxp_uart_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sccnxp_uart_driver_init+0x0/0x13 returned 0 after 107 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_kgdboc+0x0/0x16 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_kgdboc+0x0/0x16 returned 0 after 10 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ttyprintk_init+0x0/0x115 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ttyprintk_init+0x0/0x115 returned 0 after 312 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init+0x0/0x12e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init+0x0/0x12e returned 0 after 190 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  hpet_init+0x0/0x65 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall hpet_init+0x0/0x65 returned 0 after 865 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  hwrng_modinit+0x0/0x7d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall hwrng_modinit+0x0/0x7d returned 0 after 324 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  agp_init+0x0/0x24 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: Linux agpgart interface v0.103
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall agp_init+0x0/0x24 returned 0 after 15 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  agp_amd64_mod_init+0x0/0x20 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall agp_amd64_mod_init+0x0/0x20 returned -19 after 391 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  agp_intel_init+0x0/0x29 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall agp_intel_init+0x0/0x29 returned 0 after 135 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  agp_via_init+0x0/0x29 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall agp_via_init+0x0/0x29 returned 0 after 132 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_tis+0x0/0x128 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1A, rev-id 16)
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_tis+0x0/0x128 returned 0 after 151820 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cn_proc_init+0x0/0x36 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cn_proc_init+0x0/0x36 returned 0 after 8 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  _nvm_misc_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall _nvm_misc_init+0x0/0x11 returned 0 after 295 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  topology_sysfs_init+0x0/0x30 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall topology_sysfs_init+0x0/0x30 returned 0 after 282 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cacheinfo_sysfs_init+0x0/0x2c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cacheinfo_sysfs_init+0x0/0x2c returned 169 after 734 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  devcoredump_init+0x0/0x18 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall devcoredump_init+0x0/0x18 returned 0 after 41 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  brd_init+0x0/0x26a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: brd: module loaded
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall brd_init+0x0/0x26a returned 0 after 27889 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  loop_init+0x0/0x214 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: loop: module loaded
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall loop_init+0x0/0x214 returned 0 after 22886 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  xlblk_init+0x0/0xea @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall xlblk_init+0x0/0xea returned -19 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  htcpld_core_init+0x0/0x2d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall htcpld_core_init+0x0/0x2d returned -19 after 195 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tps65912_i2c_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tps65912_i2c_driver_init+0x0/0x13 returned 0 after 69 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tps65912_spi_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tps65912_spi_driver_init+0x0/0x13 returned 0 after 63 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  twl_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall twl_driver_init+0x0/0x13 returned 0 after 65 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  twl4030_audio_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall twl4030_audio_driver_init+0x0/0x13 returned 0 after 104 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  twl6040_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall twl6040_driver_init+0x0/0x13 returned 0 after 66 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  smsc_i2c_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall smsc_i2c_driver_init+0x0/0x13 returned 0 after 65 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  da9063_i2c_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall da9063_i2c_driver_init+0x0/0x13 returned 0 after 65 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  max14577_i2c_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall max14577_i2c_init+0x0/0x13 returned 0 after 80 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  max77693_i2c_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall max77693_i2c_driver_init+0x0/0x13 returned 0 after 81 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  adp5520_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall adp5520_driver_init+0x0/0x13 returned 0 after 65 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  intel_soc_pmic_i2c_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall intel_soc_pmic_i2c_driver_init+0x0/0x13 returned 0 after 65 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  e820_pmem_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall e820_pmem_driver_init+0x0/0x13 returned 0 after 103 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_sd+0x0/0x1ae @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_sd+0x0/0x1ae returned 0 after 244 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_sr+0x0/0x46 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_sr+0x0/0x46 returned 0 after 65 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_sg+0x0/0x179 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_sg+0x0/0x179 returned 0 after 81 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  nvme_core_init+0x0/0xcd @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall nvme_core_init+0x0/0xcd returned 0 after 484 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  nvme_init+0x0/0x1a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: nvme nvme0: pci function 0000:04:00.0
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall nvme_init+0x0/0x1a returned 0 after 415 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  piix_init+0x0/0x29 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall piix_init+0x0/0x29 returned 0 after 199 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sis_pci_driver_init+0x0/0x1a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sis_pci_driver_init+0x0/0x1a returned 0 after 174 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ata_generic_pci_driver_init+0x0/0x1a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ata_generic_pci_driver_init+0x0/0x1a returned 0 after 222 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  net_olddevs_init+0x0/0x5d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall net_olddevs_init+0x0/0x5d returned 0 after 22 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  fixed_mdio_bus_init+0x0/0xf3 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: libphy: Fixed MDIO Bus: probed
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall fixed_mdio_bus_init+0x0/0xf3 returned 0 after 722 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tun_init+0x0/0x9f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: tun: Universal TUN/TAP device driver, 1.6
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tun_init+0x0/0x9f returned 0 after 319 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ppp_init+0x0/0x107 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: PPP generic driver version 2.4.2
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ppp_init+0x0/0x107 returned 0 after 363 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  netif_init+0x0/0x69 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall netif_init+0x0/0x69 returned -19 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cdrom_init+0x0/0x16 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cdrom_init+0x0/0x16 returned 0 after 23 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dwc2_platform_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dwc2_platform_driver_init+0x0/0x13 returned 0 after 107 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ehci_hcd_init+0x0/0xf0 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ehci_hcd_init+0x0/0xf0 returned 0 after 42 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ehci_pci_init+0x0/0x65 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: ehci-pci: EHCI PCI platform driver
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ehci_pci_init+0x0/0x65 returned 0 after 148 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ehci_platform_init+0x0/0x48 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: ehci-platform: EHCI generic platform driver
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ehci_platform_init+0x0/0x48 returned 0 after 150 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ohci_hcd_mod_init+0x0/0x8d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ohci_hcd_mod_init+0x0/0x8d returned 0 after 41 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ohci_pci_init+0x0/0x65 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: ohci-pci: OHCI PCI platform driver
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ohci_pci_init+0x0/0x65 returned 0 after 145 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ohci_platform_init+0x0/0x48 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: ohci-platform: OHCI generic platform driver
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ohci_platform_init+0x0/0x48 returned 0 after 117 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  uhci_hcd_init+0x0/0x12c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: uhci_hcd: USB Universal Host Controller Interface driver
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall uhci_hcd_init+0x0/0x12c returned 0 after 275 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  xhci_hcd_init+0x0/0x1f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall xhci_hcd_init+0x0/0x1f returned 0 after 30 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  xhci_pci_init+0x0/0x43 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: xhci_hcd 0000:00:14.0: xHCI Host Controller
Jan 15 13:37:57 helmuth-N24-25BU kernel: xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00109810
Jan 15 13:37:57 helmuth-N24-25BU kernel: xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb1: Product: xHCI Host Controller
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb1: Manufacturer: Linux 4.15.0-rc8+ xhci-hcd
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb1: SerialNumber: 0000:00:14.0
Jan 15 13:37:57 helmuth-N24-25BU kernel: hub 1-0:1.0: USB hub found
Jan 15 13:37:57 helmuth-N24-25BU kernel: hub 1-0:1.0: 12 ports detected
Jan 15 13:37:57 helmuth-N24-25BU kernel: xhci_hcd 0000:00:14.0: xHCI Host Controller
Jan 15 13:37:57 helmuth-N24-25BU kernel: xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb2: Product: xHCI Host Controller
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb2: Manufacturer: Linux 4.15.0-rc8+ xhci-hcd
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb2: SerialNumber: 0000:00:14.0
Jan 15 13:37:57 helmuth-N24-25BU kernel: hub 2-0:1.0: USB hub found
Jan 15 13:37:57 helmuth-N24-25BU kernel: hub 2-0:1.0: 6 ports detected
Jan 15 13:37:57 helmuth-N24-25BU kernel: xhci_hcd 0000:01:00.0: xHCI Host Controller
Jan 15 13:37:57 helmuth-N24-25BU kernel: xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 3
Jan 15 13:37:57 helmuth-N24-25BU kernel: xhci_hcd 0000:01:00.0: hcc params 0x0200eec1 hci version 0x110 quirks 0x00000010
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb3: Product: xHCI Host Controller
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb3: Manufacturer: Linux 4.15.0-rc8+ xhci-hcd
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb3: SerialNumber: 0000:01:00.0
Jan 15 13:37:57 helmuth-N24-25BU kernel: hub 3-0:1.0: USB hub found
Jan 15 13:37:57 helmuth-N24-25BU kernel: hub 3-0:1.0: 2 ports detected
Jan 15 13:37:57 helmuth-N24-25BU kernel: xhci_hcd 0000:01:00.0: xHCI Host Controller
Jan 15 13:37:57 helmuth-N24-25BU kernel: xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 4
Jan 15 13:37:57 helmuth-N24-25BU kernel: xhci_hcd 0000:01:00.0: Host supports USB 3.1 Enhanced SuperSpeed
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb4: Product: xHCI Host Controller
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb4: Manufacturer: Linux 4.15.0-rc8+ xhci-hcd
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb usb4: SerialNumber: 0000:01:00.0
Jan 15 13:37:57 helmuth-N24-25BU kernel: hub 4-0:1.0: USB hub found
Jan 15 13:37:57 helmuth-N24-25BU kernel: hub 4-0:1.0: 2 ports detected
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall xhci_pci_init+0x0/0x43 returned 0 after 62605 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  kgdbdbgp_start_thread+0x0/0x4d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall kgdbdbgp_start_thread+0x0/0x4d returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ledtrig_usb_init+0x0/0x2e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ledtrig_usb_init+0x0/0x2e returned 0 after 17 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  i8042_init+0x0/0x4ae @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:SYNM] at 0x60,0x64 irq 1,12
Jan 15 13:37:57 helmuth-N24-25BU kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall i8042_init+0x0/0x4ae returned 0 after 4385 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  mousedev_init+0x0/0x81 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: mousedev: PS/2 mouse device common for all mice
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall mousedev_init+0x0/0x81 returned 0 after 696 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  evdev_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall evdev_init+0x0/0x11 returned 0 after 1212 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  atkbd_init+0x0/0x26 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall atkbd_init+0x0/0x26 returned 0 after 119 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  uinput_misc_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall uinput_misc_init+0x0/0x11 returned 0 after 327 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cmos_init+0x0/0x86 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: rtc_cmos 00:01: RTC can wake from S4
Jan 15 13:37:57 helmuth-N24-25BU kernel: rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
Jan 15 13:37:57 helmuth-N24-25BU kernel: rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cmos_init+0x0/0x86 returned 0 after 747 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  i2c_dev_init+0x0/0xd1 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: i2c /dev entries driver
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall i2c_dev_init+0x0/0xd1 returned 0 after 109 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  restart_poweroff_driver_init+0x0/0x13 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall restart_poweroff_driver_init+0x0/0x13 returned 0 after 109 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  watchdog_gov_noop_register+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall watchdog_gov_noop_register+0x0/0x11 returned 0 after 8 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dm_init+0x0/0xeb @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: device-mapper: uevent: version 1.0.3
Jan 15 13:37:57 helmuth-N24-25BU kernel: device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised: dm-devel at redhat.com
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dm_init+0x0/0xeb returned 0 after 1503 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cpufreq_gov_powersave_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cpufreq_gov_powersave_init+0x0/0x11 returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cpufreq_gov_userspace_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cpufreq_gov_userspace_init+0x0/0x11 returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cpufreq_gov_dbs_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cpufreq_gov_dbs_init+0x0/0x11 returned 0 after 88 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cpufreq_gov_dbs_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cpufreq_gov_dbs_init+0x0/0x11 returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  intel_pstate_init+0x0/0x479 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: intel_pstate: Intel P-state driver initializing
Jan 15 13:37:57 helmuth-N24-25BU kernel: intel_pstate: HWP enabled
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall intel_pstate_init+0x0/0x479 returned 0 after 1536 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ledtrig_disk_init+0x0/0x2e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ledtrig_disk_init+0x0/0x2e returned 0 after 13 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ledtrig_mtd_init+0x0/0x2e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ledtrig_mtd_init+0x0/0x2e returned 0 after 12 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ledtrig_cpu_init+0x0/0x121 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: ledtrig-cpu: registered to indicate activity on CPUs
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ledtrig_cpu_init+0x0/0x121 returned 0 after 250 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ledtrig_panic_init+0x0/0x39 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ledtrig_panic_init+0x0/0x39 returned 0 after 13 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  efivars_sysfs_init+0x0/0x2a0 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: EFI Variables Facility v0.08 2004-May-17
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall efivars_sysfs_init+0x0/0x2a0 returned 0 after 21768 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  esrt_sysfs_init+0x0/0x3b1 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall esrt_sysfs_init+0x0/0x3b1 returned 0 after 124 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  skein_generic_init+0x0/0x56 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall skein_generic_init+0x0/0x56 returned 0 after 496 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  intel_pmc_core_driver_init+0x0/0x1a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: intel_pmc_core 0000:00:1f.2: enabling device (0000 -> 0002)
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall intel_pmc_core_driver_init+0x0/0x1a returned 0 after 251 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pmc_atom_init+0x0/0x296 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pmc_atom_init+0x0/0x296 returned -19 after 73 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  extcon_class_init+0x0/0x17 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall extcon_class_init+0x0/0x17 returned 0 after 36 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  powercap_init+0x0/0x5b9 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall powercap_init+0x0/0x5b9 returned 0 after 131 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pm_check_save_msr+0x0/0x20 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pm_check_save_msr+0x0/0x20 returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sock_diag_init+0x0/0x40 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sock_diag_init+0x0/0x40 returned 0 after 120 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  blackhole_init+0x0/0x11 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall blackhole_init+0x0/0x11 returned 0 after 5 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  gre_offload_init+0x0/0x49 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall gre_offload_init+0x0/0x49 returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sysctl_ipv4_init+0x0/0x4c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sysctl_ipv4_init+0x0/0x4c returned 0 after 50 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  cubictcp_register+0x0/0x115 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall cubictcp_register+0x0/0x115 returned 0 after 5 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  inet6_init+0x0/0x3af @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: NET: Registered protocol family 10
Jan 15 13:37:57 helmuth-N24-25BU kernel: Segment Routing with IPv6
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall inet6_init+0x0/0x3af returned 0 after 2658 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  packet_init+0x0/0x42 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: NET: Registered protocol family 17
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall packet_init+0x0/0x42 returned 0 after 24 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  strp_mod_init+0x0/0x31 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall strp_mod_init+0x0/0x31 returned 0 after 132 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dcbnl_init+0x0/0x7e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dcbnl_init+0x0/0x7e returned 0 after 5 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_dns_resolver+0x0/0xcc @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: Key type dns_resolver registered
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_dns_resolver+0x0/0xcc returned 0 after 42 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  nsh_init_module+0x0/0x14 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall nsh_init_module+0x0/0x14 returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  mcheck_init_device+0x0/0x152 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall mcheck_init_device+0x0/0x152 returned 0 after 520 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tboot_late_init+0x0/0x2e4 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tboot_late_init+0x0/0x2e4 returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  intel_rdt_late_init+0x0/0x532 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall intel_rdt_late_init+0x0/0x532 returned -19 after 5 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  mcheck_late_init+0x0/0x88 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall mcheck_late_init+0x0/0x88 returned 0 after 42 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  severities_debugfs_init+0x0/0x3b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall severities_debugfs_init+0x0/0x3b returned 0 after 22 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  microcode_init+0x0/0x24b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: microcode: sig=0x806e9, pf=0x80, revision=0x80
Jan 15 13:37:57 helmuth-N24-25BU kernel: microcode: Microcode Update Driver: v2.2.
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall microcode_init+0x0/0x24b returned 0 after 753 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  hpet_insert_resource+0x0/0x23 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall hpet_insert_resource+0x0/0x23 returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  update_mp_table+0x0/0xccf @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall update_mp_table+0x0/0xccf returned 0 after 5 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  lapic_insert_resource+0x0/0x3f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall lapic_insert_resource+0x0/0x3f returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  print_ICs+0x0/0x1ba @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall print_ICs+0x0/0x1ba returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pat_memtype_list_init+0x0/0x4a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pat_memtype_list_init+0x0/0x4a returned 0 after 28 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  create_tlb_single_page_flush_ceiling+0x0/0x29 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall create_tlb_single_page_flush_ceiling+0x0/0x29 returned 0 after 22 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  create_init_pkru_value+0x0/0x29 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall create_init_pkru_value+0x0/0x29 returned 0 after 22 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_oops_id+0x0/0x40 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_oops_id+0x0/0x40 returned 0 after 7 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sched_clock_init_late+0x0/0x90 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: sched_clock: Marking stable (3892131320, 0)->(3873194734, 18936586)
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sched_clock_init_late+0x0/0x90 returned 0 after 421 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sched_init_debug+0x0/0x3e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sched_init_debug+0x0/0x3e returned 0 after 41 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pm_qos_power_init+0x0/0x173 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pm_qos_power_init+0x0/0x173 returned 0 after 856 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pm_debugfs_init+0x0/0x24 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pm_debugfs_init+0x0/0x24 returned 0 after 22 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  printk_late_init+0x0/0x128 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall printk_late_init+0x0/0x128 returned 0 after 8 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tk_debug_sleep_time_init+0x0/0x3c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tk_debug_sleep_time_init+0x0/0x3c returned 0 after 21 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  debugfs_kprobe_init+0x0/0xd2 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall debugfs_kprobe_init+0x0/0xd2 returned 0 after 75 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  taskstats_init+0x0/0x37 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: registered taskstats version 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall taskstats_init+0x0/0x37 returned 0 after 34 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_hwlat_tracer+0x0/0xaf @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_hwlat_tracer+0x0/0xaf returned 0 after 77 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  kdb_ftrace_register+0x0/0x2d @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall kdb_ftrace_register+0x0/0x2d returned 0 after 5 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  load_system_certificate_list+0x0/0x173 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: Loading compiled-in X.509 certificates
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall load_system_certificate_list+0x0/0x173 returned 0 after 12 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  fault_around_debugfs+0x0/0x35 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall fault_around_debugfs+0x0/0x35 returned 0 after 23 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  max_swapfiles_check+0x0/0x8 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall max_swapfiles_check+0x0/0x8 returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_zswap+0x0/0x466 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: zswap: loaded using pool lzo/zbud
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_zswap+0x0/0x466 returned 0 after 554 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  split_huge_pages_debugfs+0x0/0x35 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall split_huge_pages_debugfs+0x0/0x35 returned 0 after 21 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  check_early_ioremap_leak+0x0/0xae @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall check_early_ioremap_leak+0x0/0xae returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_root_keyring+0x0/0xa @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_root_keyring+0x0/0xa returned 0 after 43 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  big_key_init+0x0/0x95 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: Key type big_key registered
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall big_key_init+0x0/0x95 returned 0 after 5026 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_trusted+0x0/0xaf @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: Key type trusted registered
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_trusted+0x0/0xaf returned 0 after 2301 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_encrypted+0x0/0x10c @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: Key type encrypted registered
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_encrypted+0x0/0x10c returned 0 after 2343 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_profile_hash+0x0/0xab @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: AppArmor: AppArmor sha1 policy hashing enabled
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_profile_hash+0x0/0xab returned 0 after 19 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_ima+0x0/0x35 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: ================================================================================
Jan 15 13:37:57 helmuth-N24-25BU kernel: UBSAN: Undefined behaviour in drivers/nvme/host/pci.c:456:17
Jan 15 13:37:57 helmuth-N24-25BU kernel: division by zero
Jan 15 13:37:57 helmuth-N24-25BU kernel: CPU: 0 PID: 53 Comm: kworker/u8:1 Not tainted 4.15.0-rc8+ #17
Jan 15 13:37:57 helmuth-N24-25BU kernel: Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 07/07/2017
Jan 15 13:37:57 helmuth-N24-25BU kernel: Workqueue: nvme-wq nvme_reset_work
Jan 15 13:37:57 helmuth-N24-25BU kernel: Call Trace:
Jan 15 13:37:57 helmuth-N24-25BU kernel:  dump_stack+0x70/0xae
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ubsan_epilogue+0x9/0x40
Jan 15 13:37:57 helmuth-N24-25BU kernel:  __ubsan_handle_divrem_overflow+0x99/0xe0
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? nvme_queue_rq+0xd1a/0x14f0
Jan 15 13:37:57 helmuth-N24-25BU kernel:  nvme_queue_rq+0xd1a/0x14f0
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? ftrace_graph_caller+0x68/0x98
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? trace_graph_entry+0xdc/0x2b0
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? blk_mq_make_request+0xa70/0xa70
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? blk_mq_sched_dispatch_requests+0x1f3/0x2e0
Jan 15 13:37:57 helmuth-N24-25BU kernel:  blk_mq_dispatch_rq_list+0xb5/0xd50
Jan 15 13:37:57 helmuth-N24-25BU kernel:  blk_mq_sched_dispatch_requests+0x1f3/0x2e0
Jan 15 13:37:57 helmuth-N24-25BU kernel:  __blk_mq_delay_run_hw_queue+0x8f/0xd0
Jan 15 13:37:57 helmuth-N24-25BU kernel:  blk_mq_run_hw_queue+0x2f/0xd0
Jan 15 13:37:57 helmuth-N24-25BU kernel:  blk_mq_sched_insert_request+0x167/0x320
Jan 15 13:37:57 helmuth-N24-25BU kernel:  blk_execute_rq+0x63/0xe0
Jan 15 13:37:57 helmuth-N24-25BU kernel:  __nvme_submit_sync_cmd+0xa6/0x130
Jan 15 13:37:57 helmuth-N24-25BU kernel:  nvme_set_features+0x67/0xd0
Jan 15 13:37:57 helmuth-N24-25BU kernel:  nvme_set_queue_count+0x53/0x100
Jan 15 13:37:57 helmuth-N24-25BU kernel:  nvme_reset_work+0x842/0x1ab0
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? ftrace_graph_caller+0x68/0x98
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? worker_thread+0x64/0x670
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? prepare_ftrace_return+0xaa/0x170
Jan 15 13:37:57 helmuth-N24-25BU kernel:  process_one_work+0x277/0x800
Jan 15 13:37:57 helmuth-N24-25BU kernel:  worker_thread+0x64/0x670
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? process_one_work+0x800/0x800
Jan 15 13:37:57 helmuth-N24-25BU kernel:  kthread+0x173/0x230
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? kthread+0x5/0x230
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ? kthread_create_worker_on_cpu+0x70/0x70
Jan 15 13:37:57 helmuth-N24-25BU kernel:  ret_from_fork+0x32/0x40
Jan 15 13:37:57 helmuth-N24-25BU kernel: ================================================================================
Jan 15 13:37:57 helmuth-N24-25BU kernel:  nvme0n1: p1 p2 p3 p4
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb 1-5: new full-speed USB device number 2 using xhci_hcd
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_ima+0x0/0x35 returned 0 after 359245 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_evm+0x0/0x3e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: evm: HMAC attrs: 0x1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_evm+0x0/0x3e returned 0 after 29 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  prandom_reseed+0x0/0x2a @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb 1-5: New USB device found, idVendor=8087, idProduct=0a2b
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb 1-5: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall prandom_reseed+0x0/0x2a returned 0 after 54 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pci_resource_alignment_sysfs_init+0x0/0x18 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pci_resource_alignment_sysfs_init+0x0/0x18 returned 0 after 16 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pci_sysfs_init+0x0/0x50 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pci_sysfs_init+0x0/0x50 returned 0 after 7784 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  bert_init+0x0/0x2bb @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall bert_init+0x0/0x2bb returned 0 after 7 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  clk_debug_init+0x0/0x13e @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall clk_debug_init+0x0/0x13e returned 0 after 128 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  boot_wait_for_devices+0x0/0x29 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall boot_wait_for_devices+0x0/0x29 returned -19 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dmar_free_unused_resources+0x0/0x15b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dmar_free_unused_resources+0x0/0x15b returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  deferred_probe_initcall+0x0/0x30 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall deferred_probe_initcall+0x0/0x30 returned 0 after 30 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  late_resume_init+0x0/0x310 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel:   Magic number: 2:947:632
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall late_resume_init+0x0/0x310 returned 0 after 93 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  genpd_debug_init+0x0/0x176 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall genpd_debug_init+0x0/0x176 returned 0 after 39 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  genpd_power_off_unused+0x0/0xac @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall genpd_power_off_unused+0x0/0xac returned 0 after 5 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  sync_debugfs_init+0x0/0x5b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall sync_debugfs_init+0x0/0x5b returned 0 after 56 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  rtc_hctosys+0x0/0x178 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: rtc_cmos 00:01: setting system clock to 2018-01-15 12:37:49 UTC (1516019869)
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall rtc_hctosys+0x0/0x178 returned 0 after 178 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  charger_manager_init+0x0/0xb8 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall charger_manager_init+0x0/0xb8 returned 0 after 237 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  acpi_cpufreq_init+0x0/0x3a0 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall acpi_cpufreq_init+0x0/0x3a0 returned -17 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  powernowk8_init+0x0/0x1d0 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall powernowk8_init+0x0/0x1d0 returned -19 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pcc_cpufreq_init+0x0/0x530 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pcc_cpufreq_init+0x0/0x530 returned -19 after 23 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  centrino_init+0x0/0x28 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall centrino_init+0x0/0x28 returned -19 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  edd_init+0x0/0x45b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
Jan 15 13:37:57 helmuth-N24-25BU kernel: EDD information not available.
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall edd_init+0x0/0x45b returned -19 after 19 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  firmware_memmap_init+0x0/0x4b @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall firmware_memmap_init+0x0/0x4b returned 0 after 771 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  register_update_efi_random_seed+0x0/0x20 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall register_update_efi_random_seed+0x0/0x20 returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  efi_shutdown_init+0x0/0x56 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall efi_shutdown_init+0x0/0x56 returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  itmt_legacy_init+0x0/0x6f @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall itmt_legacy_init+0x0/0x6f returned -19 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  pci_mmcfg_late_insert_resources+0x0/0x64 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall pci_mmcfg_late_insert_resources+0x0/0x64 returned 0 after 6 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  tcp_congestion_default+0x0/0x18 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall tcp_congestion_default+0x0/0x18 returned 0 after 5 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  software_resume+0x0/0x350 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall software_resume+0x0/0x350 returned -2 after 5 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  clear_boot_tracer+0x0/0x26 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall clear_boot_tracer+0x0/0x26 returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  clk_disable_unused+0x0/0x200 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall clk_disable_unused+0x0/0x200 returned 0 after 5 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  regulator_init_complete+0x0/0x36 @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall regulator_init_complete+0x0/0x36 returned 0 after 8 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: Freeing unused kernel memory: 1820K
Jan 15 13:37:57 helmuth-N24-25BU kernel: Write protecting the kernel read-only data: 24576k
Jan 15 13:37:57 helmuth-N24-25BU kernel: Freeing unused kernel memory: 2008K
Jan 15 13:37:57 helmuth-N24-25BU kernel: Freeing unused kernel memory: 164K
Jan 15 13:37:57 helmuth-N24-25BU kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
Jan 15 13:37:57 helmuth-N24-25BU kernel: x86/mm: Checking user space page tables
Jan 15 13:37:57 helmuth-N24-25BU kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb 1-6: new high-speed USB device number 3 using xhci_hcd
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  fjes_init_module+0x0/0xed [fjes] @ 159
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  acpi_video_init+0x0/0x1000 [video] @ 161
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall acpi_video_init+0x0/0x1000 [video] returned 0 after 135 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall fjes_init_module+0x0/0xed [fjes] returned -19 after 6682 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  acpi_wmi_init+0x0/0x1000 [wmi] @ 163
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall acpi_wmi_init+0x0/0x1000 [wmi] returned 0 after 1502 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: clocksource: Switched to clocksource tsc
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  rtsx_pci_driver_init+0x0/0x1000 [rtsx_pci] @ 155
Jan 15 13:37:57 helmuth-N24-25BU kernel: rtsx_pci 0000:03:00.0: enabling device (0000 -> 0002)
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  rtl8169_pci_driver_init+0x0/0x1000 [r8169] @ 163
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall rtsx_pci_driver_init+0x0/0x1000 [rtsx_pci] returned 0 after 2173 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  drm_core_init+0x0/0xe2 [drm] @ 161
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall drm_core_init+0x0/0xe2 [drm] returned 0 after 158 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ahci_pci_driver_init+0x0/0x1000 [ahci] @ 166
Jan 15 13:37:57 helmuth-N24-25BU kernel: ahci 0000:00:17.0: version 3.0
Jan 15 13:37:57 helmuth-N24-25BU kernel: ahci 0000:00:17.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x1 impl SATA mode
Jan 15 13:37:57 helmuth-N24-25BU kernel: ahci 0000:00:17.0: flags: 64bit ncq pm led clo only pio slum part deso sadm sds apst 
Jan 15 13:37:57 helmuth-N24-25BU kernel: r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
Jan 15 13:37:57 helmuth-N24-25BU kernel: r8169 0000:03:00.1: can't disable ASPM; OS doesn't have ASPM control
Jan 15 13:37:57 helmuth-N24-25BU kernel: r8169 0000:03:00.1: enabling device (0000 -> 0003)
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  psmouse_init+0x0/0x8a [psmouse] @ 167
Jan 15 13:37:57 helmuth-N24-25BU kernel: scsi host0: ahci
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall psmouse_init+0x0/0x8a [psmouse] returned 0 after 414 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: scsi host1: ahci
Jan 15 13:37:57 helmuth-N24-25BU kernel: ata1: SATA max UDMA/133 abar m2048 at 0xdf42b000 port 0xdf42b100 irq 133
Jan 15 13:37:57 helmuth-N24-25BU kernel: ata2: DUMMY
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ahci_pci_driver_init+0x0/0x1000 [ahci] returned 0 after 8943 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  drm_kms_helper_init+0x0/0x14 [drm_kms_helper] @ 161
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall drm_kms_helper_init+0x0/0x14 [drm_kms_helper] returned 0 after 73 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: r8169 0000:03:00.1 eth0: RTL8411 at 0x00000000c484c527, 80:fa:5b:3b:dd:f0, XID 1c800800 IRQ 134
Jan 15 13:37:57 helmuth-N24-25BU kernel: r8169 0000:03:00.1 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall rtl8169_pci_driver_init+0x0/0x1000 [r8169] returned 0 after 22996 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  rtsx_pci_sdmmc_driver_init+0x0/0x1000 [rtsx_pci_sdmmc] @ 168
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall rtsx_pci_sdmmc_driver_init+0x0/0x1000 [rtsx_pci_sdmmc] returned 0 after 1487 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: r8169 0000:03:00.1 enp3s0f1: renamed from eth0
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  i915_init+0x0/0x59 [i915] @ 161
Jan 15 13:37:57 helmuth-N24-25BU kernel: [drm] Memory usable by graphics device = 4096M
Jan 15 13:37:57 helmuth-N24-25BU kernel: [drm] Replacing VGA console driver
Jan 15 13:37:57 helmuth-N24-25BU kernel: [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
Jan 15 13:37:57 helmuth-N24-25BU kernel: [drm] Driver supports precise vblank timestamp query.
Jan 15 13:37:57 helmuth-N24-25BU kernel: i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
Jan 15 13:37:57 helmuth-N24-25BU kernel: [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_01.bin (v1.1)
Jan 15 13:37:57 helmuth-N24-25BU kernel: [drm] Initialized i915 1.6.0 20171023 for 0000:00:02.0 on minor 0
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb 1-6: New USB device found, idVendor=5986, idProduct=1112
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb 1-6: New USB device strings: Mfr=3, Product=1, SerialNumber=2
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb 1-6: Product: BisonCam,NB Pro
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb 1-6: Manufacturer: Bison
Jan 15 13:37:57 helmuth-N24-25BU kernel: usb 1-6: SerialNumber: 200901010001
Jan 15 13:37:57 helmuth-N24-25BU kernel: ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
Jan 15 13:37:57 helmuth-N24-25BU kernel: input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input7
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall i915_init+0x0/0x59 [i915] returned 0 after 39461 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: fbcon: inteldrmfb (fb0) is primary device
Jan 15 13:37:57 helmuth-N24-25BU kernel: ata1: SATA link down (SStatus 4 SControl 300)
Jan 15 13:37:57 helmuth-N24-25BU kernel: psmouse serio1: synaptics: queried max coordinates: x [..5718], y [..4908]
Jan 15 13:37:57 helmuth-N24-25BU kernel: psmouse serio1: synaptics: queried min coordinates: x [1238..], y [956..]
Jan 15 13:37:57 helmuth-N24-25BU kernel: psmouse serio1: synaptics: The touchpad can support a better bus than the too old PS/2 protocol. Make sure MOUSE_PS2_SYNAPTICS_SMBUS and RMI4_SMB are enabled to get a better touchpad experience.
Jan 15 13:37:57 helmuth-N24-25BU kernel: psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf00223/0x840300/0x26800/0x0, board id: 3175, fw id: 2330500
Jan 15 13:37:57 helmuth-N24-25BU kernel: input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input6
Jan 15 13:37:57 helmuth-N24-25BU kernel: Console: switching to colour frame buffer device 240x67
Jan 15 13:37:57 helmuth-N24-25BU kernel: [drm] RC6 on
Jan 15 13:37:57 helmuth-N24-25BU kernel: i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dm_dirty_log_init+0x0/0x1000 [dm_log] @ 230
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dm_dirty_log_init+0x0/0x1000 [dm_log] returned 0 after 3 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dm_mirror_init+0x0/0x1000 [dm_mirror] @ 230
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dm_mirror_init+0x0/0x1000 [dm_mirror] returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  linear_init+0x0/0x1000 [linear] @ 235
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall linear_init+0x0/0x1000 [linear] returned 0 after 1 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  multipath_init+0x0/0x1000 [multipath] @ 238
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall multipath_init+0x0/0x1000 [multipath] returned 0 after 1 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  raid0_init+0x0/0x1000 [raid0] @ 241
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall raid0_init+0x0/0x1000 [raid0] returned 0 after 1 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  raid_init+0x0/0x1000 [raid1] @ 244
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall raid_init+0x0/0x1000 [raid1] returned 0 after 1 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  libcrc32c_mod_init+0x0/0x1000 [libcrc32c] @ 247
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall libcrc32c_mod_init+0x0/0x1000 [libcrc32c] returned 0 after 11 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_module+0x0/0x1000 [raid6_pq] @ 247
Jan 15 13:37:57 helmuth-N24-25BU kernel: raid6: sse2x1   gen()  9179 MB/s
Jan 15 13:37:57 helmuth-N24-25BU kernel: raid6: sse2x1   xor()  5942 MB/s
Jan 15 13:37:57 helmuth-N24-25BU kernel: raid6: sse2x2   gen() 10621 MB/s
Jan 15 13:37:57 helmuth-N24-25BU kernel: raid6: sse2x2   xor()  6828 MB/s
Jan 15 13:37:57 helmuth-N24-25BU kernel: raid6: sse2x4   gen() 11906 MB/s
Jan 15 13:37:57 helmuth-N24-25BU kernel: raid6: sse2x4   xor()  7872 MB/s
Jan 15 13:37:57 helmuth-N24-25BU kernel: raid6: avx2x1   gen() 15232 MB/s
Jan 15 13:37:57 helmuth-N24-25BU kernel: raid6: avx2x1   xor()  9316 MB/s
Jan 15 13:37:57 helmuth-N24-25BU kernel: raid6: avx2x2   gen() 17348 MB/s
Jan 15 13:37:57 helmuth-N24-25BU kernel: raid6: avx2x2   xor() 10261 MB/s
Jan 15 13:37:57 helmuth-N24-25BU kernel: raid6: avx2x4   gen() 19001 MB/s
Jan 15 13:37:57 helmuth-N24-25BU kernel: raid6: avx2x4   xor() 11465 MB/s
Jan 15 13:37:57 helmuth-N24-25BU kernel: raid6: using algorithm avx2x4 gen() 19001 MB/s
Jan 15 13:37:57 helmuth-N24-25BU kernel: raid6: .... xor() 11465 MB/s, rmw enabled
Jan 15 13:37:57 helmuth-N24-25BU kernel: raid6: using avx2x2 recovery algorithm
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_module+0x0/0x1000 [raid6_pq] returned 0 after 794348 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  calibrate_xor_blocks+0x0/0xf0e [xor] @ 247
Jan 15 13:37:57 helmuth-N24-25BU kernel: xor: automatically using best checksumming function   avx       
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall calibrate_xor_blocks+0x0/0xf0e [xor] returned 0 after 9 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  async_tx_init+0x0/0x1000 [async_tx] @ 247
Jan 15 13:37:57 helmuth-N24-25BU kernel: async_tx: api initialized (async)
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall async_tx_init+0x0/0x1000 [async_tx] returned 0 after 13 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  async_pq_init+0x0/0x1000 [async_pq] @ 247
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall async_pq_init+0x0/0x1000 [async_pq] returned 0 after 4 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  raid5_init+0x0/0x1000 [raid456] @ 247
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall raid5_init+0x0/0x1000 [raid456] returned 0 after 393 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  raid_init+0x0/0x1000 [raid10] @ 264
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall raid_init+0x0/0x1000 [raid10] returned 0 after 1 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_btrfs_fs+0x0/0x129 [btrfs] @ 280
Jan 15 13:37:57 helmuth-N24-25BU kernel: Btrfs loaded, crc32c=crc32c-intel
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_btrfs_fs+0x0/0x129 [btrfs] returned 0 after 4880 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: EXT4-fs (nvme0n1p3): mounted filesystem with ordered data mode. Opts: (null)
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_autofs4_fs+0x0/0x26 [autofs4] @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_autofs4_fs+0x0/0x26 [autofs4] returned 0 after 193 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  xt_init+0x0/0x1000 [x_tables] @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall xt_init+0x0/0x1000 [x_tables] returned 0 after 11 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ip_tables_init+0x0/0x1000 [ip_tables] @ 1
Jan 15 13:37:57 helmuth-N24-25BU kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ip_tables_init+0x0/0x1000 [ip_tables] returned 0 after 31 usecs
Jan 15 13:37:57 helmuth-N24-25BU systemd[1]: systemd 234 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN default-hierarchy=hybrid)
Jan 15 13:37:57 helmuth-N24-25BU systemd[1]: Detected architecture x86-64.
Jan 15 13:37:57 helmuth-N24-25BU systemd[1]: Set hostname to <helmuth-N24-25BU>.
Jan 15 13:37:57 helmuth-N24-25BU systemd[1]: Listening on fsck to fsckd communication Socket.
Jan 15 13:37:57 helmuth-N24-25BU systemd[1]: Listening on Journal Socket (/dev/log).
Jan 15 13:37:57 helmuth-N24-25BU systemd[1]: Listening on Syslog Socket.
Jan 15 13:37:57 helmuth-N24-25BU systemd[1]: Listening on udev Kernel Socket.
Jan 15 13:37:57 helmuth-N24-25BU systemd[1]: Listening on Journal Socket.
Jan 15 13:37:57 helmuth-N24-25BU systemd[1]: Reached target User and Group Name Lookups.
Jan 15 13:37:57 helmuth-N24-25BU systemd[1]: Started Forward Password Requests to Wall Directory Watch.
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  dm_crypt_init+0x0/0x1000 [dm_crypt] @ 349
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall dm_crypt_init+0x0/0x1000 [dm_crypt] returned 0 after 5 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  parport_default_proc_register+0x0/0x1000 [parport] @ 349
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall parport_default_proc_register+0x0/0x1000 [parport] returned 0 after 205 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  lp_init_module+0x0/0x1000 [lp] @ 349
Jan 15 13:37:57 helmuth-N24-25BU kernel: lp: driver loaded but no devices found
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall lp_init_module+0x0/0x1000 [lp] returned 0 after 8136 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  ppdev_init+0x0/0x1000 [ppdev] @ 349
Jan 15 13:37:57 helmuth-N24-25BU kernel: ppdev: user-space parallel port driver
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall ppdev_init+0x0/0x1000 [ppdev] returned 0 after 2902 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  parport_pc_init+0x0/0xec5 [parport_pc] @ 349
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall parport_pc_init+0x0/0xec5 [parport_pc] returned 0 after 8344 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: EXT4-fs (nvme0n1p3): re-mounted. Opts: (null)
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  acpi_pad_init+0x0/0x1000 [acpi_pad] @ 438
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall acpi_pad_init+0x0/0x1000 [acpi_pad] returned 0 after 4001 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  mac_hid_init+0x0/0x1000 [mac_hid] @ 442
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall mac_hid_init+0x0/0x1000 [mac_hid] returned 0 after 28 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  crb_acpi_driver_init+0x0/0x1000 [tpm_crb] @ 448
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall crb_acpi_driver_init+0x0/0x1000 [tpm_crb] returned 0 after 737 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  fjes_init_module+0x0/0xed [fjes] @ 449
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall fjes_init_module+0x0/0xed [fjes] returned -19 after 11720 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  fjes_init_module+0x0/0xed [fjes] @ 448
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall fjes_init_module+0x0/0xed [fjes] returned -19 after 8675 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  intel_pch_thermal_driver_init+0x0/0x1000 [intel_pch_thermal] @ 444
Jan 15 13:37:57 helmuth-N24-25BU kernel: (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall intel_pch_thermal_driver_init+0x0/0x1000 [intel_pch_thermal] returned 0 after 5874 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  mei_init+0x0/0xac [mei] @ 447
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall mei_init+0x0/0xac [mei] returned 0 after 388 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  fjes_init_module+0x0/0xed [fjes] @ 451
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall fjes_init_module+0x0/0xed [fjes] returned -19 after 5904 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  shpcd_init+0x0/0x1000 [shpchp] @ 446
Jan 15 13:37:57 helmuth-N24-25BU kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall shpcd_init+0x0/0x1000 [shpchp] returned 0 after 327 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  mei_me_driver_init+0x0/0x1000 [mei_me] @ 447
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall mei_me_driver_init+0x0/0x1000 [mei_me] returned 0 after 255 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: mei_me 0000:00:16.0: enabling device (0000 -> 0002)
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  memstick_init+0x0/0x1000 [memstick] @ 448
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall memstick_init+0x0/0x1000 [memstick] returned 0 after 2550 usecs
Jan 15 13:37:57 helmuth-N24-25BU kernel: calling  init_soundcore+0x0/0x1000 [soundcore] @ 446
Jan 15 13:37:57 helmuth-N24-25BU kernel: initcall init_soundcore+0x0/0x1000 [soundcore] returned 0 after 77 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  rtsx_pci_ms_driver_init+0x0/0x1000 [rtsx_pci_ms] @ 448
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall rtsx_pci_ms_driver_init+0x0/0x1000 [rtsx_pci_ms] returned 0 after 3327 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  serio_raw_drv_init+0x0/0x1000 [serio_raw] @ 448
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall serio_raw_drv_init+0x0/0x1000 [serio_raw] returned 0 after 225 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  alsa_sound_init+0x0/0x82 [snd] @ 446
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall alsa_sound_init+0x0/0x82 [snd] returned 0 after 175 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  joydev_init+0x0/0x1000 [joydev] @ 448
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall joydev_init+0x0/0x1000 [joydev] returned 0 after 42 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  rapl_pmu_init+0x0/0x1000 [intel_rapl_perf] @ 450
Jan 15 13:37:58 helmuth-N24-25BU kernel: RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
Jan 15 13:37:58 helmuth-N24-25BU kernel: RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
Jan 15 13:37:58 helmuth-N24-25BU kernel: RAPL PMU: hw unit of domain package 2^-14 Joules
Jan 15 13:37:58 helmuth-N24-25BU kernel: RAPL PMU: hw unit of domain dram 2^-14 Joules
Jan 15 13:37:58 helmuth-N24-25BU kernel: RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
Jan 15 13:37:58 helmuth-N24-25BU kernel: RAPL PMU: hw unit of domain psys 2^-14 Joules
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall rapl_pmu_init+0x0/0x1000 [intel_rapl_perf] returned 0 after 1819 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  input_leds_init+0x0/0x1000 [input_leds] @ 438
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall input_leds_init+0x0/0x1000 [input_leds] returned 0 after 1100 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  cstate_pmu_init+0x0/0xeef [intel_cstate] @ 441
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall cstate_pmu_init+0x0/0xeef [intel_cstate] returned 0 after 1433 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  alsa_timer_init+0x0/0x1000 [snd_timer] @ 446
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  cryptd_init+0x0/0x1000 [cryptd] @ 447
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall cryptd_init+0x0/0x1000 [cryptd] returned 0 after 22 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall alsa_timer_init+0x0/0x1000 [snd_timer] returned 0 after 6358 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  aes_init+0x0/0x1000 [aes_x86_64] @ 441
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall aes_init+0x0/0x1000 [aes_x86_64] returned 0 after 5254 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  aesni_init+0x0/0x363 [aesni_intel] @ 441
Jan 15 13:37:58 helmuth-N24-25BU kernel: AVX2 version of gcm_enc/dec engaged.
Jan 15 13:37:58 helmuth-N24-25BU kernel: AES CTR mode by8 optimization enabled
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  alsa_pcm_init+0x0/0x1000 [snd_pcm] @ 446
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall alsa_pcm_init+0x0/0x1000 [snd_pcm] returned 0 after 32 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  alsa_hwdep_init+0x0/0x1000 [snd_hwdep] @ 446
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall alsa_hwdep_init+0x0/0x1000 [snd_hwdep] returned 0 after 32 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  hda_bus_init+0x0/0x11 [snd_hda_core] @ 446
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall hda_bus_init+0x0/0x11 [snd_hda_core] returned 0 after 218 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  cfg80211_init+0x0/0xcb [cfg80211] @ 439
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  azx_driver_init+0x0/0xfd8 [snd_hda_intel] @ 446
Jan 15 13:37:58 helmuth-N24-25BU kernel: snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
Jan 15 13:37:58 helmuth-N24-25BU kernel: snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall azx_driver_init+0x0/0xfd8 [snd_hda_intel] returned 0 after 905 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: cfg80211: Loading compiled-in X.509 certificates for regulatory database
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  crypto_pcbc_module_init+0x0/0x1000 [pcbc] @ 585
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall crypto_pcbc_module_init+0x0/0x1000 [pcbc] returned 0 after 8 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall aesni_init+0x0/0x363 [aesni_intel] returned 0 after 80622 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  padlock_init+0x0/0x1000 [padlock_aes] @ 548
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall padlock_init+0x0/0x1000 [padlock_aes] returned -19 after 2 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] @ 450
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] returned 0 after 304 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
Jan 15 13:37:58 helmuth-N24-25BU kernel: platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
Jan 15 13:37:58 helmuth-N24-25BU kernel: cfg80211: failed to load regulatory.db
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall cfg80211_init+0x0/0xcb [cfg80211] returned 0 after 47661 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] @ 447
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  init_nls_iso8859_1+0x0/0x1000 [nls_iso8859_1] @ 604
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall init_nls_iso8859_1+0x0/0x1000 [nls_iso8859_1] returned 0 after 2 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] returned 0 after 5992 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  generic_driver_init+0x0/0x1000 [snd_hda_codec_generic] @ 611
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall generic_driver_init+0x0/0x1000 [snd_hda_codec_generic] returned 0 after 221 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] @ 447
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] returned 0 after 1632 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  realtek_driver_init+0x0/0x1000 [snd_hda_codec_realtek] @ 611
Jan 15 13:37:58 helmuth-N24-25BU kernel: snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC269VC: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
Jan 15 13:37:58 helmuth-N24-25BU kernel: snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
Jan 15 13:37:58 helmuth-N24-25BU kernel: snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
Jan 15 13:37:58 helmuth-N24-25BU kernel: snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
Jan 15 13:37:58 helmuth-N24-25BU kernel: snd_hda_codec_realtek hdaudioC0D0:    inputs:
Jan 15 13:37:58 helmuth-N24-25BU kernel: snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
Jan 15 13:37:58 helmuth-N24-25BU kernel: snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
Jan 15 13:37:58 helmuth-N24-25BU kernel: random: crng init done
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall realtek_driver_init+0x0/0x1000 [snd_hda_codec_realtek] returned 0 after 9339 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: EXT4-fs (nvme0n1p4): mounted filesystem with ordered data mode. Opts: (null)
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  hdmi_driver_init+0x0/0x1000 [snd_hda_codec_hdmi] @ 653
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall hdmi_driver_init+0x0/0x1000 [snd_hda_codec_hdmi] returned 0 after 5859 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  iwl_drv_init+0x0/0xc8 [iwlwifi] @ 439
Jan 15 13:37:58 helmuth-N24-25BU kernel: Intel(R) Wireless WiFi driver for Linux
Jan 15 13:37:58 helmuth-N24-25BU kernel: Copyright(c) 2003- 2015 Intel Corporation
Jan 15 13:37:58 helmuth-N24-25BU kernel: iwlwifi 0000:02:00.0: enabling device (0000 -> 0002)
Jan 15 13:37:58 helmuth-N24-25BU kernel: input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input8
Jan 15 13:37:58 helmuth-N24-25BU kernel: input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input9
Jan 15 13:37:58 helmuth-N24-25BU kernel: input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input10
Jan 15 13:37:58 helmuth-N24-25BU kernel: input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input11
Jan 15 13:37:58 helmuth-N24-25BU kernel: input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
Jan 15 13:37:58 helmuth-N24-25BU kernel: input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
Jan 15 13:37:58 helmuth-N24-25BU kernel: input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
Jan 15 13:37:58 helmuth-N24-25BU kernel: iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-8000C-34.ucode failed with error -2
Jan 15 13:37:58 helmuth-N24-25BU kernel: iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-8000C-33.ucode failed with error -2
Jan 15 13:37:58 helmuth-N24-25BU kernel: iwlwifi 0000:02:00.0: Direct firmware load for iwlwifi-8000C-32.ucode failed with error -2
Jan 15 13:37:58 helmuth-N24-25BU kernel: iwlwifi 0000:02:00.0: loaded firmware version 31.560484.0 op_mode iwlmvm
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall iwl_drv_init+0x0/0xc8 [iwlwifi] returned 0 after 20739 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  init_misc_binfmt+0x0/0x1000 [binfmt_misc] @ 694
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall init_misc_binfmt+0x0/0x1000 [binfmt_misc] returned 0 after 6 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  vmx_init+0x0/0xe0c [kvm_intel] @ 664
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall vmx_init+0x0/0xe0c [kvm_intel] returned 0 after 7091 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  ieee80211_init+0x0/0x35 [mac80211] @ 677
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall ieee80211_init+0x0/0x35 [mac80211] returned 0 after 29 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  coretemp_init+0x0/0x1000 [coretemp] @ 450
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall coretemp_init+0x0/0x1000 [coretemp] returned 0 after 7943 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  iwl_mvm_init+0x0/0x1000 [iwlmvm] @ 677
Jan 15 13:37:58 helmuth-N24-25BU kernel: iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band Wireless AC 8260, REV=0x208
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  powerclamp_init+0x0/0x1000 [intel_powerclamp] @ 447
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall powerclamp_init+0x0/0x1000 [intel_powerclamp] returned 0 after 475 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  pkg_temp_thermal_init+0x0/0x1000 [x86_pkg_temp_thermal] @ 441
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall pkg_temp_thermal_init+0x0/0x1000 [x86_pkg_temp_thermal] returned 0 after 2289 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  rapl_init+0x0/0x1000 [intel_rapl] @ 440
Jan 15 13:37:58 helmuth-N24-25BU kernel: intel_rapl: Found RAPL domain package
Jan 15 13:37:58 helmuth-N24-25BU kernel: intel_rapl: Found RAPL domain core
Jan 15 13:37:58 helmuth-N24-25BU kernel: intel_rapl: Found RAPL domain uncore
Jan 15 13:37:58 helmuth-N24-25BU kernel: intel_rapl: Found RAPL domain dram
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall rapl_init+0x0/0x1000 [intel_rapl] returned 0 after 1455 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: audit: type=1400 audit(1516019878.513:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/freshclam" pid=769 comm="apparmor_parser"
Jan 15 13:37:58 helmuth-N24-25BU kernel: audit: type=1400 audit(1516019878.517:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-oopslash" pid=770 comm="apparmor_parser"
Jan 15 13:37:58 helmuth-N24-25BU kernel: audit: type=1400 audit(1516019878.517:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/lightdm/lightdm-guest-session" pid=765 comm="apparmor_parser"
Jan 15 13:37:58 helmuth-N24-25BU kernel: audit: type=1400 audit(1516019878.517:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/lightdm/lightdm-guest-session//chromium" pid=765 comm="apparmor_parser"
Jan 15 13:37:58 helmuth-N24-25BU kernel: audit: type=1400 audit(1516019878.525:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/sbin/dhclient" pid=766 comm="apparmor_parser"
Jan 15 13:37:58 helmuth-N24-25BU kernel: audit: type=1400 audit(1516019878.525:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=766 comm="apparmor_parser"
Jan 15 13:37:58 helmuth-N24-25BU kernel: audit: type=1400 audit(1516019878.525:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=766 comm="apparmor_parser"
Jan 15 13:37:58 helmuth-N24-25BU kernel: audit: type=1400 audit(1516019878.525:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/connman/scripts/dhclient-script" pid=766 comm="apparmor_parser"
Jan 15 13:37:58 helmuth-N24-25BU kernel: audit: type=1400 audit(1516019878.525:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-senddoc" pid=771 comm="apparmor_parser"
Jan 15 13:37:58 helmuth-N24-25BU kernel: iwlwifi 0000:02:00.0: base HW address: e4:a7:a0:c4:b7:3d
Jan 15 13:37:58 helmuth-N24-25BU kernel: audit: type=1400 audit(1516019878.529:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-soffice" pid=772 comm="apparmor_parser"
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  arc4_init+0x0/0x1000 [arc4] @ 822
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall arc4_init+0x0/0x1000 [arc4] returned 0 after 5336 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
Jan 15 13:37:58 helmuth-N24-25BU kernel: (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
Jan 15 13:37:58 helmuth-N24-25BU kernel: thermal thermal_zone3: failed to read out thermal zone (-61)
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall iwl_mvm_init+0x0/0x1000 [iwlmvm] returned 0 after 168271 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  ecdh_init+0x0/0x20 [ecdh_generic] @ 439
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall ecdh_init+0x0/0x20 [ecdh_generic] returned 0 after 444 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  bt_init+0x0/0xae [bluetooth] @ 442
Jan 15 13:37:58 helmuth-N24-25BU kernel: Bluetooth: Core ver 2.22
Jan 15 13:37:58 helmuth-N24-25BU kernel: NET: Registered protocol family 31
Jan 15 13:37:58 helmuth-N24-25BU kernel: Bluetooth: HCI device and connection manager initialized
Jan 15 13:37:58 helmuth-N24-25BU kernel: Bluetooth: HCI socket layer initialized
Jan 15 13:37:58 helmuth-N24-25BU kernel: Bluetooth: L2CAP socket layer initialized
Jan 15 13:37:58 helmuth-N24-25BU kernel: Bluetooth: SCO socket layer initialized
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall bt_init+0x0/0xae [bluetooth] returned 0 after 668 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  media_devnode_init+0x0/0x1000 [media] @ 438
Jan 15 13:37:58 helmuth-N24-25BU kernel: media: Linux media interface: v0.10
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall media_devnode_init+0x0/0x1000 [media] returned 0 after 214 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  videodev_init+0x0/0x7e [videodev] @ 438
Jan 15 13:37:58 helmuth-N24-25BU kernel: Linux video capture interface: v2.00
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall videodev_init+0x0/0x7e [videodev] returned 0 after 89 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  btusb_driver_init+0x0/0x1000 [btusb] @ 442
Jan 15 13:37:58 helmuth-N24-25BU kernel: Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
Jan 15 13:37:58 helmuth-N24-25BU kernel: usbcore: registered new interface driver btusb
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall btusb_driver_init+0x0/0x1000 [btusb] returned 0 after 3345 usecs
Jan 15 13:37:58 helmuth-N24-25BU kernel: Bluetooth: hci0: Device revision is 5
Jan 15 13:37:58 helmuth-N24-25BU kernel: Bluetooth: hci0: Secure boot is enabled
Jan 15 13:37:58 helmuth-N24-25BU kernel: Bluetooth: hci0: OTP lock is enabled
Jan 15 13:37:58 helmuth-N24-25BU kernel: Bluetooth: hci0: API lock is enabled
Jan 15 13:37:58 helmuth-N24-25BU kernel: Bluetooth: hci0: Debug lock is disabled
Jan 15 13:37:58 helmuth-N24-25BU kernel: Bluetooth: hci0: Minimum firmware build 1 week 10 2014
Jan 15 13:37:58 helmuth-N24-25BU kernel: Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
Jan 15 13:37:58 helmuth-N24-25BU kernel: calling  uvc_init+0x0/0x1000 [uvcvideo] @ 438
Jan 15 13:37:58 helmuth-N24-25BU kernel: uvcvideo: Found UVC 1.00 device BisonCam,NB Pro (5986:1112)
Jan 15 13:37:58 helmuth-N24-25BU kernel: Adding 8388092k swap on /dev/mapper/cryptswap1.  Priority:-2 extents:1 across:8388092k SSFS
Jan 15 13:37:58 helmuth-N24-25BU kernel: uvcvideo 1-6:1.0: Entity type for entity Realtek Extended Controls Unit was not initialized!
Jan 15 13:37:58 helmuth-N24-25BU kernel: uvcvideo 1-6:1.0: Entity type for entity Extension 4 was not initialized!
Jan 15 13:37:58 helmuth-N24-25BU kernel: uvcvideo 1-6:1.0: Entity type for entity Processing 2 was not initialized!
Jan 15 13:37:58 helmuth-N24-25BU kernel: uvcvideo 1-6:1.0: Entity type for entity Camera 1 was not initialized!
Jan 15 13:37:58 helmuth-N24-25BU kernel: input: BisonCam,NB Pro: BisonCam,NB Pr as /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.0/input/input15
Jan 15 13:37:58 helmuth-N24-25BU kernel: usbcore: registered new interface driver uvcvideo
Jan 15 13:37:58 helmuth-N24-25BU kernel: USB Video Class driver (1.1.1)
Jan 15 13:37:58 helmuth-N24-25BU kernel: initcall uvc_init+0x0/0x1000 [uvcvideo] returned 0 after 8213 usecs
Jan 15 13:37:59 helmuth-N24-25BU kernel: calling  bnep_init+0x0/0x9b [bnep] @ 1572
Jan 15 13:37:59 helmuth-N24-25BU kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Jan 15 13:37:59 helmuth-N24-25BU kernel: Bluetooth: BNEP filters: protocol multicast
Jan 15 13:37:59 helmuth-N24-25BU kernel: Bluetooth: BNEP socket layer initialized
Jan 15 13:37:59 helmuth-N24-25BU kernel: initcall bnep_init+0x0/0x9b [bnep] returned 0 after 64 usecs
Jan 15 13:37:59 helmuth-N24-25BU kernel: calling  alsa_seq_device_init+0x0/0x1000 [snd_seq_device] @ 1617
Jan 15 13:37:59 helmuth-N24-25BU kernel: initcall alsa_seq_device_init+0x0/0x1000 [snd_seq_device] returned 0 after 2837 usecs
Jan 15 13:37:59 helmuth-N24-25BU kernel: calling  alsa_seq_init+0x0/0x4b [snd_seq] @ 1617
Jan 15 13:37:59 helmuth-N24-25BU kernel: initcall alsa_seq_init+0x0/0x4b [snd_seq] returned 0 after 619 usecs
Jan 15 13:37:59 helmuth-N24-25BU kernel: calling  snd_hrtimer_init+0x0/0x1000 [snd_hrtimer] @ 1634
Jan 15 13:37:59 helmuth-N24-25BU kernel: initcall snd_hrtimer_init+0x0/0x1000 [snd_hrtimer] returned 0 after 9 usecs
Jan 15 13:37:59 helmuth-N24-25BU kernel: IPv6: ADDRCONF(NETDEV_UP): enp3s0f1: link is not ready
Jan 15 13:37:59 helmuth-N24-25BU kernel: r8169 0000:03:00.1 enp3s0f1: link down
Jan 15 13:37:59 helmuth-N24-25BU kernel: IPv6: ADDRCONF(NETDEV_UP): enp3s0f1: link is not ready
Jan 15 13:37:59 helmuth-N24-25BU kernel: IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
Jan 15 13:38:00 helmuth-N24-25BU kernel: Bluetooth: hci0: Waiting for firmware download to complete
Jan 15 13:38:00 helmuth-N24-25BU kernel: Bluetooth: hci0: Firmware loaded in 1399347 usecs
Jan 15 13:38:00 helmuth-N24-25BU kernel: Bluetooth: hci0: Waiting for device to boot
Jan 15 13:38:00 helmuth-N24-25BU kernel: Bluetooth: hci0: Device booted in 10741 usecs
Jan 15 13:38:00 helmuth-N24-25BU kernel: Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.ddc
Jan 15 13:38:00 helmuth-N24-25BU kernel: Bluetooth: hci0: Applying Intel DDC parameters completed
Jan 15 13:38:01 helmuth-N24-25BU kernel: calling  rfcomm_init+0x0/0xd1 [rfcomm] @ 3357
Jan 15 13:38:01 helmuth-N24-25BU kernel: Bluetooth: RFCOMM TTY layer initialized
Jan 15 13:38:01 helmuth-N24-25BU kernel: Bluetooth: RFCOMM socket layer initialized
Jan 15 13:38:01 helmuth-N24-25BU kernel: Bluetooth: RFCOMM ver 1.11
Jan 15 13:38:01 helmuth-N24-25BU kernel: initcall rfcomm_init+0x0/0xd1 [rfcomm] returned 0 after 323 usecs
Jan 15 13:42:22 helmuth-N24-25BU kernel: Could not find key with description: [8ac72712aa32e6df]
Jan 15 13:42:22 helmuth-N24-25BU kernel: process_request_key_err: No key
Jan 15 13:42:22 helmuth-N24-25BU kernel: Could not find valid key in user session keyring for sig specified in mount option: [8ac72712aa32e6df]
Jan 15 13:42:22 helmuth-N24-25BU kernel: One or more global auth toks could not properly register; rc = [-2]
Jan 15 13:42:22 helmuth-N24-25BU kernel: Error parsing options; rc = [-2]
Jan 15 13:42:26 helmuth-N24-25BU kernel: calling  crypto_cmac_module_init+0x0/0x1000 [cmac] @ 8787
Jan 15 13:42:26 helmuth-N24-25BU kernel: initcall crypto_cmac_module_init+0x0/0x1000 [cmac] returned 0 after 8 usecs
Jan 15 13:42:59 helmuth-N24-25BU kernel: IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
Jan 15 13:42:59 helmuth-N24-25BU kernel: IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
Jan 15 13:43:04 helmuth-N24-25BU kernel: wlp2s0: authenticate with 6c:f3:7f:10:ae:18
Jan 15 13:43:04 helmuth-N24-25BU kernel: wlp2s0: send auth to 6c:f3:7f:10:ae:18 (try 1/3)
Jan 15 13:43:04 helmuth-N24-25BU kernel: wlp2s0: authenticated
Jan 15 13:43:04 helmuth-N24-25BU kernel: wlp2s0: associate with 6c:f3:7f:10:ae:18 (try 1/3)
Jan 15 13:43:04 helmuth-N24-25BU kernel: wlp2s0: RX AssocResp from 6c:f3:7f:10:ae:18 (capab=0x411 status=0 aid=3)
Jan 15 13:43:04 helmuth-N24-25BU kernel: wlp2s0: associated
Jan 15 13:43:04 helmuth-N24-25BU kernel: calling  crypto_ccm_module_init+0x0/0x1000 [ccm] @ 8927
Jan 15 13:43:04 helmuth-N24-25BU kernel: initcall crypto_ccm_module_init+0x0/0x1000 [ccm] returned 0 after 24 usecs
Jan 15 13:43:04 helmuth-N24-25BU kernel: IPv6: ADDRCONF(NETDEV_CHANGE): wlp2s0: link becomes ready
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180115/ac677810/attachment-0001.p7s>
