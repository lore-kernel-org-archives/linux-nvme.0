From: shiraz.saleem@intel.com (Saleem, Shiraz)
Date: Fri, 18 Jan 2019 18:36:29 +0000
Subject: NVMEoF regression on i40iw for 5.0-rc
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A5A0B747@fmsmsx124.amr.corp.intel.com>

Hi Sagi,

There is a regression introduced in 5.0.0-rcx with this commit b65bb777ef22 (" nvme-rdma: support separate queue maps for read and write")
on the initiator side while running NVMEoF on i40iw device.

The crash is at https://elixir.bootlin.com/linux/v5.0-rc2/source/drivers/nvme/host/rdma.c#L303

It appears it's because the nvme rdma queue data struct being referenced in 
nvme_rdma_init_request() has not been setup yet via nvme_rdma_alloc_queue().
Any idea why this might be the case?
 
Console
--------------
Using 16 io queues
connecting to nvmf on 100.0.0.90

Crash Log
----------------

[  298.645434] i40iw_open: i40iw_open completed
[  303.992293] nvme_rdma: nvme_rdma_create_ctrl: ctrl->ctrl.queue_count [17]
[  303.992405] nvme_rdma: nvme_rdma_create_queue_ib: qidx [0] queue [0xffff8bc7c16ef000] device [0xffff8bc75f774d80] cm_id [0xffff8bdf588cdc00]
[  303.996486] nvme_rdma: nvme_rdma_alloc_queue: idx [0] queue [0xffff8bc7c16ef000] cm_id [0xffff8bdf588cdc00] 
[  303.996554] nvme_rdma: nvme_rdma_init_request: queue_idx [0] hctx_idx [0] queue [0xffff8bc7c16ef000] queue->device 00000000a929f61d 
[  303.996557] nvme_rdma: nvme_rdma_init_request: queue_idx [0] hctx_idx [0] queue [0xffff8bc7c16ef000] queue->device 00000000a929f61d 

[....]

[  303.996821] nvme_rdma: nvme_rdma_init_request: queue_idx [0] hctx_idx [0] queue [0xffff8bc7c16ef000] queue->device 00000000a929f61d 
[  303.997243] nvme nvme0: ANA group 1: optimized.
[  303.997273] nvme nvme0: creating 1 I/O queues. comp_vectors 1 
[  303.997288] nvme_rdma: nvme_rdma_create_queue_ib: qidx [1] queue [0xffff8bc7c16ef070] device [0xffff8bc75f774d80] cm_id [0xffff8bc758f44c00]
[  304.005458] nvme_rdma: nvme_rdma_alloc_queue: idx [1] queue [0xffff8bc7c16ef070] cm_id [0xffff8bc758f44c00] 
[  304.005471] nvme_rdma: nvme_rdma_map_queues: ctrl->ctrl.opts->nr_io_queues [16] ctrl->ctrl.opts->nr_write_queues [0] 
[  304.005511] nvme_rdma: nvme_rdma_init_request: queue_idx [1] hctx_idx [0] queue [0xffff8bc7c16ef070] queue->device 00000000a929f61d 
[  304.005514] nvme_rdma: nvme_rdma_init_request: queue_idx [1] hctx_idx [0] queue [0xffff8bc7c16ef070] queue->device 00000000a929f61d

[....]

[  304.005955] nvme_rdma: nvme_rdma_init_request: queue_idx [1] hctx_idx [0] queue [0xffff8bc7c16ef070] queue->device 00000000a929f61d 
[  304.006083] nvme_rdma: nvme_rdma_init_hctx: hctx_idx [0]
[  304.006087] nvme_rdma: nvme_rdma_init_request: queue_idx [1] hctx_idx [0] queue [0xffff8bc7c16ef070] queue->device 00000000a929f61d 
[  304.006122] nvme_rdma: nvme_rdma_init_request: queue_idx [2] hctx_idx [1] queue [0xffff8bc7c16ef0e0] queue->device           (null) 
[  304.006130] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[  304.006131] #PF error: [normal kernel read fault]
[  304.006133] PGD 8000003019169067 P4D 8000003019169067 PUD 301916a067 PMD 0 
[  304.006139] Oops: 0000 [#1] SMP PTI
[  304.006143] CPU: 25 PID: 9779 Comm: start_host Kdump: loaded Not tainted 5.0.0-rc1+ #8
[  304.006145] Hardware name: Dell Inc. PowerEdge T630/0W9WXC, BIOS 1.0.4 08/29/2014
[  304.006151] RIP: 0010:nvme_rdma_init_request+0x5d/0x160 [nvme_rdma]
[  304.006154] Code: 48 c7 c7 30 c8 da c0 31 c0 49 81 c4 f8 02 00 00 4c 8b 4d 20 49 89 e8 e8 b5 ea 34 f6 48 8b 45 20 ba 40 00 00 00 be c0 80 60 00 <4c> 8b 28 4c 89 a3 38 01 00 00 48 8b 3d 82 31 18 f7 e8 cd ef 48 f6
[  304.006156] RSP: 0018:ffffa0598eb7fbb0 EFLAGS: 00010246
[  304.006159] RAX: 0000000000000000 RBX: ffff8bdf39170000 RCX: 0000000000000006
[  304.006161] RDX: 0000000000000040 RSI: 00000000006080c0 RDI: ffff8bdf5f5168b0
[  304.006163] RBP: ffff8bc7c16ef0e0 R08: 0000000000000000 R09: 00000000000158ac
[  304.006165] R10: 0000000000000000 R11: ffffa0598eb7f920 R12: ffff8bdf588d02f8
[  304.006167] R13: ffff8bdf59f14600 R14: 0000000000000000 R15: ffff8bdf39170000
[  304.006170] FS:  0000152b1ad05740(0000) GS:ffff8bdf5f500000(0000) knlGS:0000000000000000
[  304.006172] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  304.006175] CR2: 0000000000000000 CR3: 0000002ff9064002 CR4: 00000000001606e0
[  304.006177] Call Trace:
[  304.006189]  blk_mq_alloc_rqs+0x1f0/0x290
[  304.006194]  __blk_mq_alloc_rq_map+0x46/0x80
[  304.006198]  blk_mq_map_swqueue+0x17f/0x280
[  304.006202]  blk_mq_init_allocated_queue+0x3d2/0x450
[  304.006205]  blk_mq_init_queue+0x35/0x60
[  304.006209]  ? nvme_rdma_alloc_tagset+0x1af/0x320 [nvme_rdma]
[  304.006213]  nvme_rdma_setup_ctrl+0x627/0x770 [nvme_rdma]
[  304.006217]  nvme_rdma_create_ctrl+0x2c7/0x400 [nvme_rdma]
[  304.006225]  nvmf_dev_write+0x9c0/0xb80
[  304.006231]  __vfs_write+0x36/0x1b0
[  304.006237]  ? __alloc_fd+0x44/0x170
[  304.006240]  ? set_close_on_exec+0x30/0x70
[  304.006243]  vfs_write+0xad/0x1b0
[  304.006246]  ksys_write+0x52/0xc0
[  304.006253]  do_syscall_64+0x5b/0x180
[  304.006260]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  304.006263] RIP: 0033:0x152b1a3f5840
[  304.006266] Code: 73 01 c3 48 8b 0d 48 26 2d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 3d 87 2d 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ce c6 01 00 48 89 04 24
[  304.006268] RSP: 002b:00007ffc4abf99e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  304.006271] RAX: ffffffffffffffda RBX: 0000000000000056 RCX: 0000152b1a3f5840
[  304.006273] RDX: 0000000000000056 RSI: 0000152b1ad15000 RDI: 0000000000000001
[  304.006275] RBP: 0000152b1ad15000 R08: 000000000000000a R09: 0000152b1ad05740
[  304.006277] R10: 0000000000000055 R11: 0000000000000246 R12: 0000152b1a6c9400
[  304.006279] R13: 0000000000000056 R14: 0000000000000001 R15: 0000000000000000
[  304.006282] Modules linked in: nvme_rdma nvme i40iw xt_CHECKSUM iptable_mangle ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ipt_REJECT nf_reject_ipv4 tun bridge ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter rpcsec_gss_krb5 nfsv4 bnx2fc dns_resolver nfs cnic uio fcoe 8021q libfcoe garp mrp libfc stp llc fscache scsi_transport_fc ib_isert iscsi_target_mod ib_srpt target_core_mod ib_srp scsi_transport_srp dm_mirror dm_region_hash ib_ipoib dm_log dm_mod ib_umad intel_rapl rpcrdma sb_edac x86_pkg_temp_thermal rdma_ucm intel_powerclamp coretemp ib_uverbs kvm_intel kvm ib_iser rdma_cm ib_cm libiscsi scsi_transport_iscsi iw_cm irqbypass nfsd crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd ib_core auth_rpcgss cryptd nfs_acl glue_helper lockd ipmi_ssif iTCO_wdt mei_me iTCO_vendor_support ipmi_si dcdbas pcspkr mei lpc_ich grace sg ipmi_devintf pcc_cpufreq sunrpc ipmi_msghandler
[  304.006332]  acpi_power_meter acpi_cpufreq wmi ip_tables ext4 mbcache jbd2 sr_mod cdrom sd_mod crc32c_intel i40e mgag200 drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm igb dca i2c_algo_bit i2c_core ahci libahci libata megaraid_sas [last unloaded: i40iw]
[  304.006351] CR2: 0000000000000000


Shiraz
