From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 9 Apr 2017 15:47:35 +0300
Subject: kmemleak complaints in nvme PM
Message-ID: <006f3319-0cd8-9d47-95cd-454b775a9b04@grimberg.me>

Hi folks,

I got this kmemleak complaint [1] on nvme-loop (but I'm pretty
confident it should happen with any nvme transport).

Initial code stare tells me that
dev_pm_qos_update_user_latency_tolerance() can (and usually will
in controller initializaion) allocate a dev_pm_qos_request, but I
didn't see a pairing free of that request.

I'll try to find some time looking into it, but thought it might
be a good idea to throw it out here in the mean time...


[1]:
--
unreferenced object 0xffff9d87f7f65b00 (size 64):
   comm "nvme", pid 1088, jiffies 4295242789 (age 37.036s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<ffffffffaf84312a>] kmemleak_alloc+0x4a/0xa0
     [<ffffffffaf1ff780>] kmem_cache_alloc_trace+0x110/0x230
     [<ffffffffaf579fbc>] 
dev_pm_qos_update_user_latency_tolerance+0x7c/0x100
     [<ffffffffc06b9b9c>] nvme_init_ctrl+0x21c/0x250 [nvme_core]
     [<ffffffffc06bc52a>] nvme_probe_ctrl+0x9a/0x1c0 [nvme_core]
     [<ffffffffc0736b9f>] nvme_loop_create_ctrl+0xbf/0x150 [nvme_loop]
     [<ffffffffc053e3f2>] nvmf_dev_write+0x7a2/0x9d7 [nvme_fabrics]
     [<ffffffffaf225fc8>] __vfs_write+0x28/0x140
     [<ffffffffaf2268d8>] vfs_write+0xb8/0x1b0
     [<ffffffffaf227d86>] SyS_write+0x46/0xa0
     [<ffffffffaf84dffb>] entry_SYSCALL_64_fastpath+0x1e/0xad
     [<ffffffffffffffff>] 0xffffffffffffffff
--
