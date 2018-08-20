From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 20 Aug 2018 13:47:02 -0700
Subject: [resend] Crash in nvmet_req_init() - null req->rsp pointer
In-Reply-To: <d35d93e6-2e7b-a681-039b-75edaea7a9a2@opengridcomputing.com>
References: <1eb5a94a-07ed-1c2a-47fe-cc9a4bf32466@opengridcomputing.com>
 <d35d93e6-2e7b-a681-039b-75edaea7a9a2@opengridcomputing.com>
Message-ID: <31a08853-e2a7-709a-9251-e6c64fda22dd@grimberg.me>


> Resending in plain text...
> 
> ----
> 
> Hey guys,
> 
> I'm debugging a nvmet_rdma crash on the linux-4.14.52 stable kernel
> code.? Under heavy load, including 80 nvmf devices, after 13 hours of
> running, I see an Oops [1] when the target is processing a new ingress
> nvme command.? It crashes in nvmet_req_init() because req->rsp is NULL:
> 
>    493   bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
>    494                   struct nvmet_sq *sq, struct nvmet_fabrics_ops *ops)
>    495   {
>    496           u8 flags = req->cmd->common.flags;
>    497           u16 status;
>    498
>    499           req->cq = cq;
>    500           req->sq = sq;
>    501           req->ops = ops;
>    502           req->sg = NULL;
>    503           req->sg_cnt = 0;
>    504           req->rsp->status = 0; <-- HERE
> 
> The? nvme command opcode is nvme_cmd_write.? The nvmet_rdma_queue state
> is NVMET_RDMA_Q_LIVE.? The nvmet_req looks valid [2].? IE not garbage.
> But it seems very bad that req->rsp is NULL! :)
> 
> Any thoughts?? I didn't see anything like this in recent nvmf fixes...

Is it possible that you ran out of rsps and got a corrupted rsp?

How about trying out this patch to add more information:
--
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index e7f43d1e1779..890d9c45ca33 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -66,6 +66,7 @@ struct nvmet_rdma_rsp {

         struct nvmet_req        req;

+       bool                    allocated;
         u8                      n_rdma;
         u32                     flags;
         u32                     invalidate_rkey;
@@ -174,11 +175,20 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
         unsigned long flags;

         spin_lock_irqsave(&queue->rsps_lock, flags);
-       rsp = list_first_entry(&queue->free_rsps,
+       rsp = list_first_entry_or_null(&queue->free_rsps,
                                 struct nvmet_rdma_rsp, free_list);
-       list_del(&rsp->free_list);
+       if (rsp) {
+               list_del(&rsp->free_list);
+               rsp->allocated = false;
+       }
         spin_unlock_irqrestore(&queue->rsps_lock, flags);

+       if (!rsp) {
+               pr_debug("dynamically allocated rsp\n");
+               rsp = kmalloc(sizeof(*rsp), GFP_KERNEL);
+               rsp->allocated = true;
+       }
+
         return rsp;
  }

@@ -187,6 +197,11 @@ nvmet_rdma_put_rsp(struct nvmet_rdma_rsp *rsp)
  {
         unsigned long flags;

+       if (rsp->allocated) {
+               kfree(rsp);
+               return;
+       }
+
         spin_lock_irqsave(&rsp->queue->rsps_lock, flags);
         list_add_tail(&rsp->free_list, &rsp->queue->free_rsps);
         spin_unlock_irqrestore(&rsp->queue->rsps_lock, flags);
--

> 
> Thanks,
> 
> Steve.
> 
> [1]? Oops stack trace:
> 
> [45259.588347] BUG: unable to handle kernel NULL pointer dereference at
> 000000000000000e
> [45259.597112] IP: nvmet_req_init+0x3d/0x120 [nvmet]
> [45259.602687] PGD 0 P4D 0
> [45259.606083] Oops: 0002 [#1] SMP PTI
> [45259.610421] Modules linked in: tcp_lp t4_tom(OE) toecore(OE)
> nvmet_rdma nvmet rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi
> scsi_transport_iscsi ib_srpt target_core_mod ib_srp scsi_transport_srp
> ib_ipoib rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_cm
> iw_cxgb4(OE) ib_core cxgb4(OE) dm_mirror dm_region_hash dm_log
> intel_rapl vfat nls_utf8 fat isofs x86_pkg_temp_thermal intel_powerclamp
> coretemp kvm_intel kvm loop irqbypass crct10dif_pclmul crc32_pclmul
> ghash_clmulni_intel pcbc aesni_intel crypto_simd glue_helper dm_mod
> iTCO_wdt iTCO_vendor_support pcspkr lpc_ich joydev shpchp i2c_i801 sg
> ipmi_si wmi ipmi_devintf ipmi_msghandler nfsd auth_rpcgss nfs_acl lockd
> grace sunrpc ip_tables ext4 mbcache jbd2 ast drm_kms_helper syscopyarea
> sysfillrect sysimgblt fb_sys_fops sd_mod ttm igb drm ptp ahci
> [45259.687761]? libahci pps_core libata crc32c_intel dca i2c_algo_bit
> i2c_core nvme nvme_core
> [45259.697067] CPU: 15 PID: 4259 Comm: kworker/15:1H Tainted:
> G?????????? OE?? 4.14.52 #1
> [45259.706042] Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.0b
> 06/12/2017
> [45259.714204] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
> [45259.720873] task: ffff8bb54c2c0000 task.stack: ffffadd60a334000
> [45259.727802] RIP: 0010:nvmet_req_init+0x3d/0x120 [nvmet]
> [45259.734140] RSP: 0000:ffffadd60a337dc8 EFLAGS: 00010246
> [45259.740373] RAX: 0000000000000040 RBX: ffff8bb3ecf4f748 RCX:
> 0000000000000000
> [45259.748508] RDX: 0000000000000000 RSI: ffff8bb3ecf4f830 RDI:
> ffff8bb3ecf4f748
> [45259.756662] RBP: ffff8bb3ecf4f838 R08: 0000000000000000 R09:
> ffffadd60a337d4c
> [45259.764818] R10: 0000000000000000 R11: 0000000000001000 R12:
> ffff8bb3ecf4f748
> [45259.773006] R13: 0000000000000000 R14: 0000000000000010 R15:
> ffff8bb498ec7400
> [45259.781187] FS:? 0000000000000000(0000) GS:ffff8bb5575c0000(0000)
> knlGS:0000000000000000
> [45259.790256] CS:? 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [45259.796985] CR2: 000000000000000e CR3: 000000070980a003 CR4:
> 00000000003606e0
> [45259.805113] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [45259.813256] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [45259.821382] Call Trace:
> [45259.824794]? nvmet_rdma_handle_command+0xab/0x2a0 [nvmet_rdma]
> [45259.831603]? __ib_process_cq+0x71/0xc0 [ib_core]
> [45259.837219]? ib_cq_poll_work+0x24/0x60 [ib_core]
> [45259.842829]? process_one_work+0x14f/0x360
> [45259.847800]? worker_thread+0x47/0x3e0
> [45259.852470]? kthread+0xfc/0x130
> [45259.856538]? ? max_active_store+0x80/0x80
> [45259.861476]? ? __kthread_parkme+0x90/0x90
> [45259.866427]? ret_from_fork+0x35/0x40
> [45259.870910] Code: 40 01 48 89 77 18 48 89 53 10 48 8b 57 08 48 89 8f
> 58 01 00 00 31 c9 48 c7 47 28 00 00 00 00 c7 87 38 01 00 00 00 00 00 00
> a8 03 <66> 89 4a 0e 75 51 83 e0 c0 3c 40 75 4a 48 8b 47 10 48 8b 10 48
> [45259.891681] RIP: nvmet_req_init+0x3d/0x120 [nvmet] RSP: ffffadd60a337dc8
> [45259.899369] CR2: 000000000000000e
> [45259.903653] ---[ end trace 3bf559cbf4cd1ab5 ]---
> 
> [2]? various structs:
> 
> crash> nvmet_req ffff8bb3ecf4f748
> struct nvmet_req {
>  ? cmd = 0xffff8bb4cfd64b40,
>  ? rsp = 0x0,
>  ? sq = 0xffff8bb3ecf4f838,
>  ? cq = 0xffff8bb3ecf4f830,
>  ? ns = 0xb5000000b92,
>  ? sg = 0x0,
>  ? inline_bio = {
>  ??? bi_next = 0x3c0,
>  ??? bi_disk = 0x1000f0,
>  ??? bi_opf = 0,
>  ??? bi_flags = 24216,
>  ??? bi_ioprio = 41863,
>  ??? bi_write_hint = 0,
>  ??? bi_status = 0 '\000',
>  ??? bi_partno = 0 '\000',
>  ??? bi_phys_segments = 9,
>  ??? bi_seg_front_size = 0,
>  ??? bi_seg_back_size = 0,
>  ??? bi_iter = {
>  ????? bi_sector = 0,
>  ????? bi_size = 15728648,
>  ????? bi_idx = 13500636,
>  ????? bi_done = 272,
>  ????? bi_bvec_done = 704
>  ??? },
>  ??? __bi_remaining = {
>  ????? counter = 1426761728
>  ??? },
>  ??? bi_end_io = 0xffff8bb4550aa8ce,
>  ??? bi_private = 0x100001050,
>  ??? bi_ioc = 0x1,
>  ??? bi_css = 0x0,
>  ??? {
>  ????? bi_integrity = 0x0
>  ??? },
>  ??? bi_vcnt = 0,
>  ??? bi_max_vecs = 0,
>  ??? __bi_cnt = {
>  ????? counter = 0
>  ??? },
>  ??? bi_io_vec = 0x0,
>  ??? bi_pool = 0x0,
>  ??? bi_inline_vecs = 0xffff8bb3ecf4f800
>  ? },
>  ? inline_bvec = {{
>  ????? bv_page = 0xffff8bb498ec4c00,
>  ????? bv_len = 2832033792,
>  ????? bv_offset = 4294937516
>  ??? }, {
>  ????? bv_page = 0xffff8bb46af86800,
>  ????? bv_len = 7,
>  ????? bv_offset = 0
>  ??? }, {
>  ????? bv_page = 0xffff8bb4039c9900,
>  ????? bv_len = 0,
>  ????? bv_offset = 1
>  ??? }, {
>  ????? bv_page = 0x200003,
>  ????? bv_len = 3463016448,
>  ????? bv_offset = 4294937524
>  ??? }, {
>  ????? bv_page = 0x8000000000000001,
>  ????? bv_len = 2822996336,
>  ????? bv_offset = 16928
>  ??? }, {
>  ????? bv_page = 0xffffffffc0c530f0 <nvmet_sq_free>,
>  ????? bv_len = 0,
>  ????? bv_offset = 0
>  ??? }, {
>  ????? bv_page = 0x0,
>  ????? bv_len = 0,
>  ????? bv_offset = 0
>  ??? }, {
>  ????? bv_page = 0x0,
>  ????? bv_len = 2097155,
>  ????? bv_offset = 19
>  ??? }},
>  ? sg_cnt = 0,
>  ? data_len = 0,
>  ? port = 0xffff8baca8cd6800,
>  ? execute = 0xffff8bb3ecf4f890,
>  ? ops = 0xffffffffc08a3100 <nvmet_rdma_ops>
> }
> crash> nvmet_rdma_cmd 0xffff8bb50b83d200
> struct nvmet_rdma_cmd {
>  ? sge = {{
>  ????? addr = 42141633344,
>  ????? length = 64,
>  ????? lkey = 0
>  ??? }, {
>  ????? addr = 40797528064,
>  ????? length = 4096,
>  ????? lkey = 0
>  ??? }},
>  ? cqe = {
>  ??? done = 0xffffffffc08a05f0 <nvmet_rdma_recv_done>
>  ? },
>  ? wr = {
>  ??? next = 0x0,
>  ??? {
>  ????? wr_id = 18446616208431370784,
>  ????? wr_cqe = 0xffff8bb50b83d220
>  ??? },
>  ??? sg_list = 0xffff8bb50b83d200,
>  ??? num_sge = 2
>  ? },
>  ? inline_sg = {
>  ??? page_link = 18446694492170806146,
>  ??? offset = 0,
>  ??? length = 4096,
>  ??? dma_address = 0,
>  ??? dma_length = 0
>  ? },
>  ? inline_page = 0xffffd2e7e5fee380,
>  ? nvme_cmd = 0xffff8bb4cfd64b40,
>  ? queue = 0xffff8bb3ecf4f800
> }
> crash> nvme_command.rw 0xffff8bb4cfd64b40
>  ??? rw = {
>  ????? opcode = 1 '\001',
>  ????? flags = 64 '@',
>  ????? command_id = 27,
>  ????? nsid = 38,
>  ????? rsvd2 = 0,
>  ????? metadata = 0,
>  ????? dptr = {
>  ??????? {
>  ????????? prp1 = 30590726144,
>  ????????? prp2 = 5692787825389355008
>  ??????? },
>  ??????? sgl = {
>  ????????? addr = 30590726144,
>  ????????? length = 2449489920,
>  ????????? rsvd = <incomplete sequence \330>,
>  ????????? type = 79 'O'
>  ??????? },
>  ??????? ksgl = {
>  ????????? addr = 30590726144,
>  ????????? length = "\000@",
>  ????????? key = "\222", <incomplete sequence \330>,
>  ????????? type = 79 'O'
>  ??????? }
>  ????? },
>  ????? slba = 1001032,
>  ????? length = 31,
>  ????? control = 0,
>  ????? dsmgmt = 0,
>  ????? reftag = 0,
>  ????? apptag = 0,
>  ????? appmask = 0
>  ??? }
> crash> nvmet_rdma_queue 0xffff8bb3ecf4f800
> struct nvmet_rdma_queue {
>  ? cm_id = 0xffff8bb498ec4c00,
>  ? port = 0xffff8baca8cd6800,
>  ? cq = 0xffff8bb46af86800,
>  ? sq_wr_avail = {
>  ??? counter = 7
>  ? },
>  ? dev = 0xffff8bb4039c9900,
>  ? state_lock = {
>  ??? {
>  ????? rlock = {
>  ??????? raw_lock = {
>  ????????? val = {
>  ??????????? counter = 0
>  ????????? }
>  ??????? }
>  ????? }
>  ??? }
>  ? },
>  ? state = NVMET_RDMA_Q_LIVE,
>  ? nvme_cq = {
>  ??? qid = 3,
>  ??? size = 32
>  ? },
>  ? nvme_sq = {
>  ??? ctrl = 0xffff8bb4ce697000,
>  ??? ref = {
>  ????? count = {
>  ??????? counter = -9223372036854775807
>  ????? },
>  ????? percpu_count_ptr = 72708029383024,
>  ????? release = 0xffffffffc0c530f0 <nvmet_sq_free>,
>  ????? confirm_switch = 0x0,
>  ????? force_atomic = false,
>  ????? rcu = {
>  ??????? next = 0x0,
>  ??????? func = 0x0
>  ????? }
>  ??? },
>  ??? qid = 3,
>  ??? size = 32,
>  ??? sqhd = 19,
>  ??? free_done = {
>  ????? done = 0,
>  ????? wait = {
>  ??????? lock = {
>  ????????? {
>  ??????????? rlock = {
>  ????????????? raw_lock = {
>  ??????????????? val = {
>  ????????????????? counter = 0
>  ??????????????? }
>  ????????????? }
>  ??????????? }
>  ????????? }
>  ??????? },
>  ??????? head = {
>  ????????? next = 0xffff8baca8cd6800,
>  ????????? prev = 0xffff8bb3ecf4f890
>  ??????? }
>  ????? }
>  ??? },
>  ??? confirm_done = {
>  ????? done = 3230281984,
>  ????? wait = {
>  ??????? lock = {
>  ????????? {
>  ??????????? rlock = {
>  ????????????? raw_lock = {
>  ??????????????? val = {
>  ????????????????? counter = 0
>  ??????????????? }
>  ????????????? }
>  ??????????? }
>  ????????? }
>  ??????? },
>  ??????? head = {
>  ????????? next = 0xffff8bb3ecf4f8b0,
>  ????????? prev = 0xffff8bb3ecf4f8b0
>  ??????? }
>  ????? }
>  ??? }
>  ? },
>  ? rsps = 0xffff8bb4cd9c0000,
>  ? free_rsps = {
>  ??? next = 0xdead000000000100,
>  ??? prev = 0xdead000000000200
>  ? },
>  ? rsps_lock = {
>  ??? {
>  ????? rlock = {
>  ??????? raw_lock = {
>  ????????? val = {
>  ??????????? counter = 0
>  ????????? }
>  ??????? }
>  ????? }
>  ??? }
>  ? },
>  ? cmds = 0xffff8bb50b83d000,
>  ? release_work = {
>  ??? data = {
>  ????? counter = 68719476704
>  ??? },
>  ??? entry = {
>  ????? next = 0xffff8bb3ecf4f8f0,
>  ????? prev = 0xffff8bb3ecf4f8f0
>  ??? },
>  ??? func = 0xffffffffc089f0d0 <nvmet_rdma_release_queue_work>
>  ? },
>  ? rsp_wait_list = {
>  ??? next = 0xffff8bb3ecf4f908,
>  ??? prev = 0xffff8bb3ecf4f908
>  ? },
>  ? rsp_wr_wait_list = {
>  ??? next = 0xffff8bb3ecf4f918,
>  ??? prev = 0xffff8bb3ecf4f918
>  ? },
>  ? rsp_wr_wait_lock = {
>  ??? {
>  ????? rlock = {
>  ??????? raw_lock = {
>  ????????? val = {
>  ??????????? counter = 0
>  ????????? }
>  ??????? }
>  ????? }
>  ??? }
>  ? },
>  ? idx = 151,
>  ? host_qid = 3,
>  ? recv_queue_size = 32,
>  ? send_queue_size = 32,
>  ? queue_list = {
>  ??? next = 0xffff8bb464686540,
>  ??? prev = 0xffff8bb3ecf4d140
>  ? }
> }
> crash> ib_wc ffff8bb498ec7400
> struct ib_wc {
>  ? {
>  ??? wr_id = 18446616208431370784,
>  ??? wr_cqe = 0xffff8bb50b83d220
>  ? },
>  ? status = IB_WC_SUCCESS,
>  ? opcode = IB_WC_RECV,
>  ? vendor_err = 0,
>  ? byte_len = 64,
>  ? qp = 0xffff8bb4d9759c00,
>  ? ex = {
>  ??? imm_data = 282903233,
>  ??? invalidate_rkey = 282903233
>  ? },
>  ? src_qp = 283165377,
>  ? slid = 283427521,
>  ? wc_flags = 0,
>  ? pkey_index = 49857,
>  ? sl = 236 '\354',
>  ? dlid_path_bits = 16 '\020',
>  ? port_num = 193 '\301',
>  ? smac = "\302\360\020\301\302", <incomplete sequence \364>,
>  ? vlan_id = 49857,
>  ? network_hdr_type = 248 '\370'
> }
> 
> 
> 
