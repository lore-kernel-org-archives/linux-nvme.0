From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Thu, 9 Jun 2016 11:18:03 +0200 (CEST)
Subject: nvme-fabrics: crash at nvme connect-all
Message-ID: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>

Hello,
I'm testing the nvme-fabrics patchset and I get a kernel stall or errors when running 
nvme connect-all. Below you have the commands and kernel log I get when it outputs
errors. I'm going to debug it further today.

The commands I run:

./nvme discover -t rdma -a 10.0.0.3
Discovery Log Number of Records 1, Generation counter 1
=====Discovery Log Entry 0======
trtype:  ipv4
adrfam:  rdma
nqntype: 2
treq:    0
portid:  2
trsvcid: 4420
subnqn:  testnqn
traddr:  10.0.0.3
rdma_prtype: 0
rdma_qptype: 0
rdma_cms:    0
rdma_pkey: 0x0000

./nvme connect -t rdma -n testnqn -a 10.0.0.3
Failed to write to /dev/nvme-fabrics: Connection reset by peer

./nvme connect-all -t rdma  -a 10.0.0.3
<here the kernel crashes>

In the kernel log I have:
[  591.484708] nvmet_rdma: enabling port 2 (10.0.0.3:4420)
[  656.778004] nvmet: creating controller 1 for NQN nqn.2014-08.org.nvmexpress:NVMf:uuid:a2e92078-7f9f-4b19-bb4f-4250599bdb14.
[  656.778255] nvme nvme1: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 10.0.0.3:4420
[  656.778573] nvmet_rdma: freeing queue 0
[  703.195100] nvmet: creating controller 1 for NQN nqn.2014-08.org.nvmexpress:NVMf:uuid:a2e92078-7f9f-4b19-bb4f-4250599bdb14.
[  703.195339] nvme nvme1: creating 8 I/O queues.
[  703.239462] rdma_rw_init_mrs: failed to allocated 128 MRs
[  703.239498] failed to init MR pool ret= -12
[  703.239541] nvmet_rdma: failed to create_qp ret= -12
[  703.239582] nvmet_rdma: nvmet_rdma_alloc_queue: creating RDMA queue failed (-12).
[  703.243569] nvme nvme1: Connect rejected, no private data.
[  703.243615] nvme nvme1: rdma_resolve_addr wait failed (-104).
[  703.243625] nvme nvme1: failed to initialize i/o queue: -104
[  703.243739] nvmet_rdma: freeing queue 6
[  703.243824] nvmet_rdma: freeing queue 5
[  703.243931] nvmet_rdma: freeing queue 4
[  703.244014] nvmet_rdma: freeing queue 3
[  703.244148] nvmet_rdma: freeing queue 2
[  703.244247] nvmet_rdma: freeing queue 1
[  703.244310] nvmet_rdma: freeing queue 0
[  708.201593] nvme h-6-\xffffff88\xffffffff\xffffffffp-6-\xffffff88\xffffffff\xffffffffx-6-\xffffff88\xffffffff\xffffffffH-6-\xffffff88\xffffffff\xffffffffP-6-\xffffff88\xffffffff\xffffffffX-6-\xffffff88\xffffffff\xffffffff`-6-\xffffff88\xffffffff\xffffffff8-6-\xffffff88\xffffffff\xffffffff\xfffffff8,6-\xffffff88\xffffffff\xffffffff\xffffff88-6-\xffffff88\xffffffff\xffffffff\xffffff90-6-\xffffff88\xffffffff\xffffffff\xffffff98-6-\xffffff88\xffffffff\xffffffff\xffffffa0-6-\xffffff88\xffffffff\xffffffff\xffffffa8-6-\xffffff88\xffffffff\xffffffff\xffffffb0-6-\xffffff88\xffffffff\xffffffff\xffffffb8-6-\xffffff88\xffffffff\xffffffff\xffffffc0-6-\xffffff88\xffffffff\xffffffff\xffffffc8-6-\xffffff88\xffffffff\xffffffff\xffffffd0-6-\xffffff88\xffffffff\xffffffff\xffffffd8-6-\xffffff88\xffffffff\xffffffff\xffffffe0-6-\xffffff88\xffffffff\xffffffff\xffffffe8-6-\xffffff88\xffffffff\xffffffff\xfffffff0-6-\xffffff88\xffffffff\xffffffff\xfffffff8-6-\xffffff88\xffffffff\xffffffff: keep-alive failed
[  795.061742] ------------[ cut here ]------------
[  795.061756] WARNING: CPU: 0 PID: 3920 at include/linux/kref.h:46 nvmf_dev_write+0x89d/0x95c [nvme_fabrics]
[  795.061759] Modules linked in: nvmet_rdma nvme_rdma nvme_fabrics nvmet cts rpcsec_gss_krb5 nfsv4 dns_resolver nfsv3 nfs fscache ocrdma edac_core x86_pkg_temp_thermal intel_powerclamp iw_cxgb4 rpcrdma coretemp ib_isert iscsi_target_mod kvm_intel ib_iser libiscsi kvm scsi_transport_iscsi irqbypass ib_srpt crct10dif_pclmul crc32_pclmul snd_hda_codec_hdmi target_core_mod snd_hda_codec_ca0132 snd_hda_intel snd_hda_codec ib_srp crc32c_intel ghash_clmulni_intel aesni_intel lrw snd_hda_core gf128mul scsi_transport_srp glue_helper ib_ipoib snd_hwdep snd_seq snd_seq_device snd_pcm rdma_ucm ablk_helper ib_ucm cxgb4 ib_uverbs snd_timer cryptd nfsd snd ib_umad dm_mirror rdma_cm be2net ib_cm nuvoton_cir rc_core iTCO_wdt soundcore dm_region_hash iTCO_vendor_support iw_cm mxm_wmi mei_me auth_rpcgss i2c_i801 serio_raw
[  795.061817]  lpc_ich mfd_core wmi mei dm_log ib_core dm_mod nfs_acl lockd grace shpchp sunrpc uinput ext4 jbd2 mbcache sd_mod radeon i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm tg3 drm ptp ahci libahci pps_core mpt3sas libata firewire_ohci firewire_core nvme crc_itu_t raid_class nvme_core scsi_transport_sas i2c_dev i2c_core
[  795.061851] CPU: 0 PID: 3920 Comm: nvme Not tainted 4.7.0-rc2+ #1
[  795.061854] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X79 Extreme11, BIOS P3.30 02/14/2014
[  795.061856]  0000000000000286 00000000f124b0d3 ffff88040d68bd18 ffffffff8133b92f
[  795.061861]  0000000000000000 0000000000000000 ffff88040d68bd58 ffffffff810828f1
[  795.061865]  0000002e8134b2ac 0000000000000047 0000000000000000 ffff88040b7c5240
[  795.061869] Call Trace:
[  795.061877]  [<ffffffff8133b92f>] dump_stack+0x63/0x84
[  795.061882]  [<ffffffff810828f1>] __warn+0xd1/0xf0
[  795.061885]  [<ffffffff81082a2d>] warn_slowpath_null+0x1d/0x20
[  795.061890]  [<ffffffffa072f18d>] nvmf_dev_write+0x89d/0x95c [nvme_fabrics]
[  795.061896]  [<ffffffff812101d7>] __vfs_write+0x37/0x140
[  795.061901]  [<ffffffff8122fbd3>] ? __fd_install+0x33/0xe0
[  795.061904]  [<ffffffff81210ee2>] vfs_write+0xb2/0x1b0
[  795.061908]  [<ffffffff81212335>] SyS_write+0x55/0xc0
[  795.061913]  [<ffffffff81003b12>] do_syscall_64+0x62/0x110
[  795.061919]  [<ffffffff816aefa1>] entry_SYSCALL64_slow_path+0x25/0x25
[  795.061923] ---[ end trace 0147b15a80ad801a ]---
[  795.062175] cma acquire res 0
[  795.062411] cma acquire res 0
[  795.064339] nvmet: creating controller 1 for NQN nqn.2014-08.org.nvmexpress:NVMf:uuid:a2e92078-7f9f-4b19-bb4f-4250599bdb14.
[  795.064520] nvme nvme1: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 10.0.0.3:4420
[  840.409731] INFO: task kworker/7:1:232 blocked for more than 120 seconds.
[  840.409800]       Tainted: G        W       4.7.0-rc2+ #1
[  840.409848] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  840.409915] kworker/7:1     D ffff880423c8fb88     0   232      2 0x00000000
[  840.409930] Workqueue: nvme_rdma_wq nvme_rdma_reset_ctrl_work [nvme_rdma]
[  840.409933]  ffff880423c8fb88 ffff880423c8fbd0 ffff880423ca0000 00000001000711cc
[  840.409937]  ffff880423c90000 7fffffffffffffff ffff880423c8fce0 ffff880423ca0000
[  840.409941]  ffff880423ca0000 ffff880423c8fba0 ffffffff816ab1c5 ffff880423c8fce8
[  840.409945] Call Trace:
[  840.409954]  [<ffffffff816ab1c5>] schedule+0x35/0x80
[  840.409959]  [<ffffffff816ae171>] schedule_timeout+0x231/0x2d0
[  840.409964]  [<ffffffff816abcc1>] wait_for_completion+0xf1/0x130
[  840.409969]  [<ffffffff810ad2d0>] ? wake_up_q+0x80/0x80
[  840.409975]  [<ffffffff8109abe0>] flush_work+0x110/0x190
[  840.409978]  [<ffffffff81098cd0>] ? destroy_worker+0x90/0x90
[  840.409983]  [<ffffffff8109c821>] __cancel_work_timer+0xa1/0x1c0
[  840.409989]  [<ffffffff810b9f75>] ? put_prev_entity+0x35/0x700
[  840.409993]  [<ffffffff8109c973>] cancel_delayed_work_sync+0x13/0x20
[  840.410000]  [<ffffffffa002a50f>] nvme_stop_keep_alive+0x1f/0x30 [nvme_core]
[  840.410005]  [<ffffffffa07c0be0>] nvme_rdma_shutdown_ctrl+0x20/0xe0 [nvme_rdma]
[  840.410010]  [<ffffffffa07c11ee>] nvme_rdma_reset_ctrl_work+0x1e/0x120 [nvme_rdma]
[  840.410014]  [<ffffffff8109b842>] process_one_work+0x152/0x400
[  840.410018]  [<ffffffff8109c27c>] worker_thread+0x26c/0x4b0
[  840.410022]  [<ffffffff8109c010>] ? rescuer_thread+0x380/0x380
[  840.410027]  [<ffffffff810a1c68>] kthread+0xd8/0xf0
[  840.410032]  [<ffffffff816af0ff>] ret_from_fork+0x1f/0x40
[  840.410037]  [<ffffffff810a1b90>] ? kthread_park+0x60/0x60
[  840.410041] INFO: task kworker/7:2:301 blocked for more than 120 seconds.

Regards,

-- 

Marta Rybczynska 

Phone : +33 6 71 09 68 03 
mrybczyn at kalray.eu
