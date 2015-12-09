From: tim.seufert@roche.com (Seufert, Tim)
Date: Wed, 9 Dec 2015 14:14:37 -0800
Subject: kernel BUG at drivers/block/nvme-core.c:732!
Message-ID: <3AAC62DB-A747-48D7-9D9F-F96433D71FFE@roche.com>

Computer: i7-6700k CPU, Supermicro X11SS-Q motherboard, and a Samsung 950 Pro NVME SSD
Linux version: CentOS 6.7 with ElRepo kernel-ml 4.3.0

What led up to the event: This is a very new system and I had just put it together and copied over a KVM guest (the guest OS is also CentOS 6.7).  At the time the ?kernel BUG? occurred, the guest was midway through updating itself, so yum/rpm was generating plenty of I/O. Since its disk image file was located on the host?s 950 Pro, this was generating NVME traffic.  The BUG resulted in the guest hanging forever (couldn?t open new terminals, make SSH connections, or do anything else that required disk I/O), but oddly enough the host did not hang even though its root FS was on the same NVME SSD partition containing the guest image.  I had to reboot the host to recover.

I have since replaced the host OS installation with a fresh install of CentOS 7, but am still running kernel-ml 4.3.0.  So far I have not seen a repetition of this BUG.


A side question: Is the advice to not enable discard in Intel?s NVME driver reference guide (https://downloadmirror.intel.com/23929/eng/Intel_Linux_NVMe_Driver_Reference_Guide_330602-002.pdf) still considered valid? It claims "You want to allow the SSD manage blocks and its activity between the NVM (non-volatile memory) and host with more advanced and consistent approaches in the SSD Controller? but it?s not clear to me how the SSD controller can have a more advanced and consistent approach if it isn?t ever notified when blocks are okay to throw away.


Dec  1 19:08:52 verra kernel: ------------[ cut here ]------------
Dec  1 19:08:52 verra kernel: kernel BUG at drivers/block/nvme-core.c:732!
Dec  1 19:08:52 verra kernel: invalid opcode: 0000 [#1] SMP 
Dec  1 19:08:52 verra kernel: Modules linked in: ebtable_nat ebtables ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat xt_CHECKSUM iptable_mangle autofs4 cpufreq_powersave ipt_REJECT nf_reject_ipv4 nf_conntrack_ipv4 nf_defrag_ipv4 iptable_filter ip_tables ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables vhost_net macvtap macvlan vhost tun joydev input_leds hci_uart btintel btqca btbcm bluetooth rfkill i2c_hid 8250_fintek intel_lpss_acpi intel_lpss serio_raw igb dca coretemp hwmon x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm crct10dif_pclmul crc32_pclmul crc32c_intel microcode pcspkr acpi_pad snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic e1000e ptp pps_core i2c_i801 snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore shpchp fjes mei_me mei xhci_pci xhci_hcd ext4 jbd2 mbcache nvme drbg aesni_intel ablk_helper cryptd lrw gf128mul glue_helper aes_x86_64 ahci l
Dec  1 19:08:52 verra kernel: ibahci i915 video dm_mirror dm_region_hash dm_log dm_mod
Dec  1 19:08:52 verra kernel: CPU: 1 PID: 4019 Comm: qemu-kvm Not tainted 4.3.0-1.el6.elrepo.x86_64 #1
Dec  1 19:08:52 verra kernel: Hardware name: Supermicro X11SSQ/X11SSQ, BIOS 1.0 09/17/2015
Dec  1 19:08:52 verra kernel: task: ffff880847ce0580 ti: ffff88084a698000 task.ti: ffff88084a698000
Dec  1 19:08:52 verra kernel: RIP: 0010:[<ffffffffa01d4499>]  [<ffffffffa01d4499>] nvme_setup_prps.clone.0+0x249/0x250 [nvme]
Dec  1 19:08:52 verra kernel: RSP: 0018:ffff88084a69ba38  EFLAGS: 00010286
Dec  1 19:08:52 verra kernel: RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000001000
Dec  1 19:08:52 verra kernel: RDX: ffff8806818d3800 RSI: 0000000000000200 RDI: 0000000000000292
Dec  1 19:08:52 verra kernel: RBP: ffff88084a69bac8 R08: ffff880844cdf040 R09: ffff880846aabc00
Dec  1 19:08:52 verra kernel: R10: 000000000068f136 R11: 00000000000ffedf R12: 00000000ffffe400
Dec  1 19:08:52 verra kernel: R13: 000000000001d400 R14: 00000000ffec1000 R15: ffff8806818d3800
Dec  1 19:08:52 verra kernel: FS:  00007f09946609a0(0000) GS:ffff880872c40000(0000) knlGS:0000000000000000
Dec  1 19:08:52 verra kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Dec  1 19:08:52 verra kernel: CR2: 00007fccf48730a0 CR3: 0000000848f1b000 CR4: 00000000003426e0
Dec  1 19:08:52 verra kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Dec  1 19:08:52 verra kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Dec  1 19:08:52 verra kernel: Stack:
Dec  1 19:08:52 verra kernel: ffff88084ee98dc0 ffff880800001000 ffff880844cdf040 ffff880844cdf440
Dec  1 19:08:52 verra kernel: ffff8808481496c0 0001f40044cdf040 0000000000001000 ffff880844cdf000
Dec  1 19:08:52 verra kernel: 000010004a69bac8 00000200fffff000 ffff88084a69bac8 00000000fd09f800
Dec  1 19:08:52 verra kernel: Call Trace:
Dec  1 19:08:52 verra kernel: [<ffffffffa01d4d1c>] nvme_queue_rq+0x53c/0x690 [nvme]
Dec  1 19:08:52 verra kernel: [<ffffffff8116b5ab>] ? generic_file_direct_write+0x15b/0x160
Dec  1 19:08:52 verra kernel: [<ffffffff8116b8e5>] ? __generic_file_write_iter+0xd5/0x1f0
Dec  1 19:08:52 verra kernel: [<ffffffff811f3a20>] ? __pollwait+0xf0/0xf0
Dec  1 19:08:52 verra kernel: [<ffffffff812d9877>] __blk_mq_run_hw_queue+0x1e7/0x370
Dec  1 19:08:52 verra kernel: [<ffffffff812d9abf>] blk_mq_run_hw_queue+0x6f/0x80
Dec  1 19:08:52 verra kernel: [<ffffffff812da336>] blk_mq_insert_requests+0xd6/0x120
Dec  1 19:08:52 verra kernel: [<ffffffff812da4a5>] blk_mq_flush_plug_list+0x125/0x140
Dec  1 19:08:52 verra kernel: [<ffffffff812d0b46>] blk_flush_plug_list+0xc6/0x1f0
Dec  1 19:08:52 verra kernel: [<ffffffff812d0ca4>] blk_finish_plug+0x34/0x50
Dec  1 19:08:52 verra kernel: [<ffffffff8122a83e>] do_io_submit+0x13e/0x1d0
Dec  1 19:08:52 verra kernel: [<ffffffff8122a8e0>] SyS_io_submit+0x10/0x20
Dec  1 19:08:52 verra kernel: [<ffffffff817017ae>] entry_SYSCALL_64_fastpath+0x12/0x71
Dec  1 19:08:52 verra kernel: Code: ff ff 44 29 6d 9c e9 3a ff ff ff 48 8b 55 a8 4c 89 72 18 c7 42 08 ff ff ff ff 8b 75 9c 29 de 89 f3 01 cb 89 5d 9c e9 1a ff ff ff <0f> 0b eb fe 0f 1f 00 55 48 89 e5 41 57 41 89 cf 41 56 41 89 d6 
Dec  1 19:08:52 verra kernel: RIP  [<ffffffffa01d4499>] nvme_setup_prps.clone.0+0x249/0x250 [nvme]
Dec  1 19:08:52 verra kernel: RSP <ffff88084a69ba38>
Dec  1 19:08:52 verra kernel: ---[ end trace 4e220fd2439ddb08 ]---
