From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 20 Dec 2018 17:11:15 +0800
Subject: nvme pci: warning during power down
Message-ID: <20181220091114.GA6817@ming.t460p>

Hi,

The following warning can be triggered every time during power down, and
kernel is the latest for-4.21/block.

[   22.342120] WARNING: CPU: 1 PID: 1 at kernel/irq/chip.c:210 irq_startup+0x63/0xc9
[   22.343285] Modules linked in: ip6table_filter ip6_tables xt_CHECKSUM iptable_mangle ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c bridge stp llc iptable_filter ip_tables fuse sd_mod sg usb_storage crc32c_intel ahci libahci lpc_ich libata mfd_core virtio_scsi binfmt_misc floppy qemu_fw_cfg ib_iser dm_mod rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi null_blk configs [last unloaded: ebtables]
[   22.348879] CPU: 1 PID: 1 Comm: systemd-shutdow Not tainted 4.20.0-rc6-00373-g164e3875dbe1 #968
[   22.350368] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.9.3-1.fc25 04/01/2014
[   22.351858] RIP: 0010:irq_startup+0x63/0xc9
[   22.352858] Code: e0 15 73 40 25 ff ff 7f ff 83 cf ff 48 89 ee 89 02 48 c7 c2 a0 8e 1e 82 e8 89 0d 58 00 3b 05 66 3c 11 01 72 09 45 84 ed 74 2b <0f> 0b eb 27 4c 8d 6b 28 31 f6 4c 89 ef e8 6c 29 00 00 85 c0 74 23
[   22.355992] RSP: 0018:ffffc90000c57c48 EFLAGS: 00010002
[   22.357148] RAX: 0000000000000008 RBX: ffff888273bf5800 RCX: 0000000000000040
[   22.358522] RDX: 0000000000000000 RSI: ffffffff821e8ea0 RDI: ffff888277a751e0
[   22.359690] RBP: ffff888277a751e0 R08: 0000000000000000 R09: ffff8881078003d0
[   22.360729] R10: 0000000000000000 R11: ffffffff82062be0 R12: 0000000000000001
[   22.361780] R13: 0000000000000001 R14: ffff888106ffa000 R15: 00000000ffffffff
[   22.362775] FS:  00007f8fb2ffb840(0000) GS:ffff888277a40000(0000) knlGS:0000000000000000
[   22.364174] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.364983] CR2: 00007ffc270d3a48 CR3: 0000000273cf6003 CR4: 00000000003606e0
[   22.365982] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   22.366989] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   22.368047] Call Trace:
[   22.368582]  enable_irq+0x69/0x87
[   22.369264]  nvme_poll_irqdisable+0x190/0x1ad
[   22.370084]  nvme_disable_io_queues+0x196/0x1ce
[   22.370833]  ? nvme_del_queue_end+0x1f/0x1f
[   22.371565]  nvme_dev_disable+0xc1/0x1e3
[   22.372269]  pci_device_shutdown+0x32/0x52
[   22.372967]  device_shutdown+0x112/0x193
[   22.373722]  kernel_power_off+0x31/0x64
[   22.374417]  __se_sys_reboot+0x142/0x1cc
[   22.375090]  ? do_writev+0x68/0xdb
[   22.375728]  ? do_writev+0x68/0xdb
[   22.376417]  do_syscall_64+0x7e/0x139
[   22.377209]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   22.378073] RIP: 0033:0x7f8fb24dafd6
[   22.378834] Code: 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 63 d7 be 69 19 12 28 48 c7 c7 ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 f3 c3 48 8b 15 91 5e 2c 00 f7 d8 64 89 02
[   22.381394] RSP: 002b:00007ffc270d4468 EFLAGS: 00000202 ORIG_RAX: 00000000000000a9
[   22.382742] RAX: ffffffffffffffda RBX: 00005581fc1dbbcd RCX: 00007f8fb24dafd6
[   22.383767] RDX: 000000004321fedc RSI: 0000000028121969 RDI: fffffffffee1dead
[   22.384747] RBP: 0000000000000000 R08: 0000000000000040 R09: 0000000000000005
[   22.385642] R10: 00007f8fb2ffb6c0 R11: 0000000000000202 R12: 0000000000000000
[   22.386700] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   22.387813] ---[ end trace 62fe07acc29a9454 ]---
[   22.398351] ACPI: Preparing to enter system sleep state S5
[   22.399894] reboot: Power down
[   22.401412] acpi_power_off called


Thanks, 
Ming
