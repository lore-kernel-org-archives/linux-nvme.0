From: Golden_Miller83@protonmail.ch (Jordan Glover)
Date: Sun, 24 Jun 2018 16:37:35 -0400
Subject: [4.18-rc2 regression] WARNING: CPU: 0 PID: 1 at
 drivers/nvme/host/pci.c:2570 nvme_probe+0x212/0x440
Message-ID: <Y7NwNf_cB9KfO8DYYkrQt_o4SQ6oFpyHC4ALTdU8K-1rKTpeY7zlAkEhN8mWm30q7cJTVBGDVqfJ65JvkV14hbUFcXQkwQ7CsrloyrFvglw=@protonmail.ch>


Hello, 

After update to Linux 4.18-rc2 I see the following warning at every boot.
It doesn't occur on Linux 4.18-rc1.

WARNING: CPU: 0 PID: 1 at drivers/nvme/host/pci.c:2570 nvme_probe+0x212/0x440
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                T 4.18.0 #1
Hardware name: LENOVO 20JJS0HD00/20JJS0HD00, BIOS R0HET49W (1.29 ) 06/12/2018
RIP: 0010:nvme_probe+0x212/0x440
Code: a8 0f 84 35 01 00 00 48 8d bb 98 01 00 00 4c 89 f1 48 c7 c2 40 fc ca 97 4c 89 fe e8 68 5f ff ff 89 c5 85 c0 0f 85 c7 00 00 00 <0f> 0b 41 b8 c0 00 60 00 45 89 e1 b9 e0 13 00 00 48 c7 c2 a0 0b 1a 
RSP: 0000:ffff9f15c0cbbd20 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff935ad769b018 RCX: 0000000000000000
RDX: ffff935ad78eddc0 RSI: 00000000000186a0 RDI: ffffffff980bfe40
RBP: 0000000000000000 R08: 0000000000000002 R09: ffff935ad7699010
R10: 00000000fffffffc R11: 0000000000000020 R12: 00000000ffffffff
R13: ffff935ad769e030 R14: 0000000000000000 R15: ffff935ad769e0d0
FS:  0000000000000000(0000) GS:ffff935ae1400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000006d008001 CR4: 00000000003606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 local_pci_probe+0x41/0x90
 pci_device_probe+0x189/0x1a0
 driver_probe_device+0x2b3/0x450
 __driver_attach+0xdd/0x110
 ? driver_probe_device+0x450/0x450
 ? driver_probe_device+0x450/0x450
 bus_for_each_dev+0x8c/0xd0
 bus_add_driver+0x151/0x230
 ? trace_event_define_fields_nvme_setup_nvm_cmd+0x1ce/0x1ce
 driver_register+0x6b/0xb0
 ? trace_event_define_fields_nvme_setup_nvm_cmd+0x1ce/0x1ce
 do_one_initcall+0x46/0x1fb
 kernel_init_freeable+0x335/0x434
 ? rest_init+0xc5/0xc5
 kernel_init+0xa/0x102
 ret_from_fork+0x35/0x40
---[ end trace 72e724386090a223 ]---
nvme nvme0: pci function 0000:05:00.0

Jordan
