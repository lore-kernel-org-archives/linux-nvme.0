From: fin4478@hotmail.com (fin4478 fin4478)
Date: Thu, 4 Apr 2019 08:23:59 +0000
Subject: A kernel warning when entering suspend
Message-ID: <AM6PR06MB50637026B0E7D87341BF47A3A1500@AM6PR06MB5063.eurprd06.prod.outlook.com>

Hi,

I do not use suspend/resume but noticed this kernel warning when testing it. This warning is present in earlier kernels too. My system works fine after resume.
If there is a patch to fix this, I can test it.

[   53.403033] PM: suspend entry (deep)
[   53.403034] PM: Syncing filesystems ... done.
[   53.404775] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   53.405972] OOM killer disabled.
[   53.405973] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   53.407036] printk: Suspending console(s) (use no_console_suspend to debug)
[   53.407491] ACPI Debug:  "RRIO"
[   53.407505] serial 00:03: disabled
[   53.407560] r8169 0000:07:00.0 enp7s0: Link is Down
[   53.415042] sd 5:0:0:0: [sda] Synchronizing SCSI cache
[   53.415065] sd 5:0:0:0: [sda] Stopping disk
[   53.428943] WARNING: CPU: 10 PID: 3127 at kernel/irq/chip.c:210 irq_startup+0xd6/0xe0
[   53.428944] Modules linked in: rtl2832_sdr videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common videodev cmac r820t cxd2841er rtl2832 i2c_mux bnep btusb btrtl btbcm btintel bluetooth dvb_usb_rtl28xxu dvb_usb_v2 dvb_core ecdh_generic input_leds cfg80211 8021q amdgpu snd_hda_codec_realtek snd_hda_codec_generic mfd_core snd_hda_codec_hdmi chash kvm_amd amd_iommu_v2 gpu_sched snd_hda_intel kvm snd_hda_codec snd_hda_core irqbypass k10temp nft_masq mq_deadline nft_counter nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink snd_aloop snd_pcm ip_tables x_tables ipv6 r8169 realtek xhci_pci nvme xhci_hcd nvme_core
[   53.428961] CPU: 10 PID: 3127 Comm: kworker/u64:22 Not tainted 5.1.0-rc3 #1
[   53.428962] Hardware name: System manufacturer System Product Name/PRIME B350M-K, BIOS 4602 03/07/2019
[   53.428964] Workqueue: events_unbound async_run_entry_fn
[   53.428966] RIP: 0010:irq_startup+0xd6/0xe0
[   53.428967] Code: 31 f6 4c 89 ef e8 1a 2a 00 00 85 c0 75 20 48 89 ee 31 d2 4c 89 ef e8 39 d6 ff ff 48 89 df e8 d1 fe ff ff 89 c5 e9 57 ff ff ff <0f> 0b eb b9 0f 0b eb b5 66 90 55 48 89 fd 53 48 8b 47 38 89 f3 8b
[   53.428967] RSP: 0018:ffffc900012c7c90 EFLAGS: 00010002
[   53.428968] RAX: 0000000000000040 RBX: ffff888214b2aa00 RCX: 0000000000000040
[   53.428969] RDX: 0000000000000000 RSI: ffffffff822a5e20 RDI: ffff888214b2aa18
[   53.428969] RBP: ffff888214b2aa18 R08: 0000000000000000 R09: ffff888215c008a8
[   53.428970] R10: 0000000000000000 R11: ffffffff822396a8 R12: 0000000000000001
[   53.428970] R13: 0000000000000001 R14: 0000000000000000 R15: ffff88821413e800
[   53.428971] FS:  0000000000000000(0000) GS:ffff888216880000(0000) knlGS:0000000000000000
[   53.428971] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   53.428972] CR2: 000055ed5a3d2486 CR3: 00000001d83aa000 CR4: 00000000003406e0
[   53.428972] Call Trace:
[   53.428975]  enable_irq+0x41/0x80
[   53.428978]  nvme_poll_irqdisable+0xd4/0x2d0 [nvme]
[   53.428980]  __nvme_disable_io_queues+0x1ae/0x1e0 [nvme]
[   53.428981]  ? nvme_del_queue_end+0x20/0x20 [nvme]
[   53.428982]  nvme_dev_disable+0x1b6/0x1d0 [nvme]
[   53.428984]  nvme_suspend+0x11/0x20 [nvme]
[   53.428986]  pci_pm_suspend+0x6b/0x1b0
[   53.428987]  ? pci_pm_suspend_noirq+0x270/0x270
[   53.428989]  dpm_run_callback.isra.20+0xf/0x30
[   53.428990]  __device_suspend+0xdd/0x2f0
[   53.428991]  async_suspend+0x15/0x90
[   53.428992]  async_run_entry_fn+0x2c/0xd0
[   53.428994]  process_one_work+0x1c9/0x360
[   53.428995]  worker_thread+0x28/0x3c0
[   53.428996]  ? process_one_work+0x360/0x360
[   53.428997]  kthread+0x106/0x120
[   53.428998]  ? kthread_create_on_node+0x60/0x60
[   53.429000]  ret_from_fork+0x1f/0x30
[   53.429001] ---[ end trace 57f482be77daad27 ]---
[   53.764133] ACPI: Preparing to enter system sleep state S3
[   54.073201] ACPI Debug:  "SIOS"

I have  the Asgard 256GB nvme drive and using a non debug 1000Hz timer
kernel from kernel.org. My System: 

Kernel: 5.1.0-rc3 x86_64 bits: 64 
Desktop: Xfce 4.13.2 Distro: Debian GNU/Linux buster/sid 
Machine:   Type: Desktop Mobo: ASUSTeK model: PRIME B350M-K
v: Rev X.0x serial: <root required> UEFI [Legacy]: American Megatrends
v: 4602 date: 03/07/2019 
CPU:       6-Core: AMD Ryzen 5 1600 type: MT MCP speed: 3392 MHz 
Graphics:  Device-1: Advanced Micro Devices
[AMD/ATI] Ellesmere [Radeon RX 470/480] driver: amdgpu v: kernel
Display: x11 server: X.Org 1.20.4 driver: amdgpu resolution:
3840x2160~60Hz OpenGL: renderer: Radeon RX 570 Series (POLARIS10 DRM
3.30.0 5.1.0-rc3 LLVM 9.0.0) v: 4.5 Mesa 19.1.0-devel - padoka PPA
Network:   Device-1: Realtek RTL8111/8168/8411 PCI Express Gigabit
Ethernet driver: r8169 Drives:    Local Storage: total: 476.95 GiB
used: 282.82 GiB (59.3%) Info:      Processes: 235 Uptime: 26m Memory:
7.79 GiB used: 1.29 GiB (16.6%) Shell: bash inxi: 3.0.32 
