From: jikos@kernel.org (Jiri Kosina)
Date: Fri, 24 May 2019 17:22:30 +0200 (CEST)
Subject: [5.2-rc1 regression]: nvme vs. hibernation
Message-ID: <nycvar.YFH.7.76.1905241706280.1962@cbobk.fhfr.pm>

Hi,

Something is broken in Linus' tree (4dde821e429) with respec to 
hibernation on my thinkpad x270, and it seems to be nvme related.

I reliably see the warning below during hibernation, and then sometimes 
resume sort of works but the machine misbehaves here and there (seems like 
lost IRQs), sometimes it never comes back from the hibernated state.

I will not have too much have time to look into this over weekend, so I am 
sending this out as-is in case anyone has immediate idea. Otherwise I'll 
bisect it on monday (I don't even know at the moment what exactly was the 
last version that worked reliably, I'll have to figure that out as well 
later).




 WARNING: CPU: 0 PID: 363 at kernel/irq/chip.c:210 irq_startup+0xff/0x110
 Modules linked in: bnep ccm af_packet fuse 8021q garp stp mrp llc tun ip6table_mangle ip6table_filter ip6_tables iptable_mangle xt_DSCP xt_tcpudp xt_conntrac
  snd_hda_core aes_x86_64 glue_helper crypto_simd snd_pcm cryptd e1000e ptp pcspkr joydev pps_core snd_timer i2c_i801 cfg80211 mei_me mei intel_pch_thermal th
 CPU: 0 PID: 363 Comm: kworker/u8:4 Not tainted 5.1.0-08122-ga2d635decbfa #9
 Hardware name: LENOVO 20K5S22R00/20K5S22R00, BIOS R0IET38W (1.16 ) 05/31/2017
 Workqueue: events_unbound async_run_entry_fn
 RIP: 0010:irq_startup+0xff/0x110
 Code: f6 4c 89 e7 e8 92 34 00 00 85 c0 75 21 4c 89 e7 31 d2 4c 89 ee e8 e1 cc ff ff 48 89 df e8 89 fe ff ff 41 89 c4 e9 37 ff ff ff <0f> 0b eb b0 0f 0b eb ac 66 0f 1f 84 00 00 
 44 00 00
 RSP: 0018:ffffa05100f13bd0 EFLAGS: 00010002
 RAX: 0000000000000200 RBX: ffff9168e360ec00 RCX: 0000000000000200
 RDX: 0000000000000200 RSI: ffffffff9f383600 RDI: ffff9168e360ec18
 RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000007
 R10: 000000007a6a7b55 R11: 0000000000000000 R12: 0000000000000001
 R13: ffff9168e360ec18 R14: ffff9168e6c97000 R15: ffff9168df76c000
 FS:  0000000000000000(0000) GS:ffff9168e7280000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fc942c4bf60 CR3: 00000001f1210002 CR4: 00000000003606e0
 Call Trace:
  ? __irq_get_desc_lock+0x4e/0x90
  enable_irq+0x39/0x70
  nvme_poll_irqdisable+0x3a3/0x470 [nvme]
  __nvme_disable_io_queues.isra.42+0x16a/0x1d0 [nvme]
  nvme_dev_disable+0x17e/0x1e0 [nvme]
  ? pci_pm_poweroff+0xf0/0xf0
  nvme_suspend+0x13/0x20 [nvme]
  pci_pm_freeze+0x52/0xd0
  dpm_run_callback+0x6b/0x2e0
  __device_suspend+0x147/0x630
  ? dpm_show_time+0xe0/0xe0
  async_suspend+0x1a/0x90
  async_run_entry_fn+0x39/0x160
  process_one_work+0x1f0/0x5b0
  ? process_one_work+0x16a/0x5b0
  worker_thread+0x4c/0x3f0
  kthread+0x103/0x140
  ? process_one_work+0x5b0/0x5b0
  ? kthread_bind+0x10/0x10
  ret_from_fork+0x3a/0x50
 irq event stamp: 381230
 hardirqs last  enabled at (381229): [<ffffffff9e90910d>] _raw_spin_unlock_irqrestore+0x4d/0x70
 hardirqs last disabled at (381230): [<ffffffff9e908fa4>] _raw_spin_lock_irqsave+0x24/0x60
 softirqs last  enabled at (381104): [<ffffffffc0eeb734>] __iwl_mvm_mac_stop+0xa4/0x1a0 [iwlmvm]
 softirqs last disabled at (381102): [<ffffffffc0eeeda6>] iwl_mvm_async_handlers_purge+0x26/0xa0 [iwlmvm]

-- 
Jiri Kosina
SUSE Labs
