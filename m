From: ckulkarnilinux@gmail.com (chaitany kulkarni)
Date: Mon, 14 May 2018 15:17:51 -0700
Subject: [PATCH] nvmet-loop: use nr_phys_segments when map rq to sgl
In-Reply-To: <20180514083245.GA32761@infradead.org>
References: <20180511063815.14911-1-chaitanya.kulkarni@wdc.com>
 <20180514083245.GA32761@infradead.org>
Message-ID: <CAK0tqinRpkb5JQY8W4jSA2onOHXbmnrzH8jOP8BGjfScmTJ1eg@mail.gmail.com>

Sorry for the long email but want to provide all the setup details and test log.

Our write zero patches for NVMe-core got rejected last time, I've following
write-zeroes implementation (Kernel :- 4.17.0-rc4.) that I'm trying to test with
NVMe PCIe controller and NVMeOF nvme_loop ctrl:-

Write Zeroes Debug patch:-

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 99b857e5a7a9..7a72c59ca5c1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -518,6 +518,21 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
        cmnd->common.nsid = cpu_to_le32(ns->head->ns_id);
 }

+static inline void nvme_setup_write_zeroes(struct nvme_ns *ns,
+               struct request *req, struct nvme_command *cmnd)
+{
+       struct nvme_write_zeroes_cmd *write_zeroes = &cmnd->write_zeroes;
+
+       memset(cmnd, 0, sizeof(*cmnd));
+       write_zeroes->opcode = nvme_cmd_write_zeroes;
+       write_zeroes->nsid = cpu_to_le32(ns->head->ns_id);
+       write_zeroes->slba =
+               cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+       write_zeroes->length =
+               cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
+       write_zeroes->control = 0;
+}
+
 static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
                struct nvme_command *cmnd)
 {
@@ -632,6 +647,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns,
struct request *req,
                nvme_setup_flush(ns, cmd);
                break;
        case REQ_OP_WRITE_ZEROES:
+               nvme_setup_write_zeroes(ns, req, cmd);
+               break;
                /* currently only aliased to deallocate for a few ctrls: */
        case REQ_OP_DISCARD:
                ret = nvme_setup_discard(ns, req, cmd);
@@ -1432,6 +1449,10 @@ static void nvme_update_disk_info(struct gendisk *disk,

        if (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)
                nvme_config_discard(ns->ctrl, stream_alignment, disk->queue);
+
+       if (ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES)
+               blk_queue_max_write_zeroes_sectors(ns->queue,
+                               ((u32)(USHRT_MAX + 1) * bs) >> 9);
        blk_mq_unfreeze_queue(disk->queue);
 }

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 17a0190bd88f..7616047312ff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -880,6 +880,13 @@ static blk_status_t nvme_queue_rq(struct
blk_mq_hw_ctx *hctx,
        if (ret)
                goto out_free_cmd;

+       if (req_op(req) == REQ_OP_WRITE_ZEROES)
+               pr_info("%s %d opcode 0x%x
blk_rq_nr_phys_segments(req) %u blk_rq_payload_bytes %u\n",
+                       __func__, __LINE__,
+                       cmnd.common.opcode,
+                       blk_rq_nr_phys_segments(req),
+                       blk_rq_payload_bytes(req));
+
        if (blk_rq_nr_phys_segments(req)) {
                ret = nvme_map_data(dev, req, &cmnd);
                if (ret)
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index cd2344179673..c174f8aae67f 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -171,6 +171,7 @@ static void nvmet_execute_write_zeroes(struct
nvmet_req *req)
        sector_t sector;
        sector_t nr_sector;

+       pr_info("%s %d\n", __func__, __LINE__);
        sector = le64_to_cpu(write_zeroes->slba) <<
                (req->ns->blksize_shift - 9);
        nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
@@ -221,6 +222,7 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
                return 0;
        case nvme_cmd_write_zeroes:
                req->execute = nvmet_execute_write_zeroes;
+               req->data_len = 0;
                return 0;
        default:
                pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 27a8561c0cb9..99d93114a224 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -174,7 +174,14 @@ static blk_status_t nvme_loop_queue_rq(struct
blk_mq_hw_ctx *hctx,
                        &queue->nvme_sq, &nvme_loop_ops))
                return BLK_STS_OK;

-       if (blk_rq_payload_bytes(req)) {
+       if (req_op(req) == REQ_OP_WRITE_ZEROES)
+               pr_info("%s %d opcode 0x%x
blk_rq_nr_phys_segments(req) %u blk_rq_payload_bytes %u\n",
+                       __func__, __LINE__,
+                       iod->cmd.common.opcode,
+                       blk_rq_nr_phys_segments(req),
+                       blk_rq_payload_bytes(req));
+
+       if (blk_rq_nr_phys_segments(req)) {
                iod->sg_table.sgl = iod->first_sgl;
                if (sg_alloc_table_chained(&iod->sg_table,
                                blk_rq_nr_phys_segments(req),

NVMe Test Device:-

[root at mercury linux]# nvme list
Node             SN                   Model
        Namespace Usage                      Format           FW Rev
---------------- --------------------
---------------------------------------- ---------
-------------------------- ---------------- --------
/dev/nvme0n1     CJH002000557         HUSMR7632BDP301
        1         646.39  GB / 646.39  GB      4 KiB +  0 B   KNGNP100
/dev/nvme0n2     CJH002000557         HUSMR7632BDP301
        2          64.64  GB /  64.64  GB      4 KiB +  0 B   KNGNP100
/dev/nvme0n3     CJH002000557         HUSMR7632BDP301
        3          64.64  GB /  64.64  GB      4 KiB +  0 B   KNGNP100
/dev/nvme0n4     CJH002000557         HUSMR7632BDP301
        4           1.26  GB /   1.26  GB      4 KiB +  0 B   KNGNP100

Based on this patch I ran following simple test script:-
[root at mercury linux]# cat test.sh
set -x
DEV=$1
od -Ad -c pat

dd if=/dev/zero of=${DEV} bs=4k
cat pat > ${DEV}

for i in 2 4 6 8 10 12 14 16 18 20; do let offset=$i*4096; blkdiscard
-o $offset -l 4096 -z ${DEV} ; done
od -Ad -c ${DEV}

for i in 196608 397312 598016 798720 ; do let offset=$i; blkdiscard -o
$offset -l 40960 -z ${DEV} ; done

od -Ad -c ${DEV}
set +x

I can see the data being zeroed on the PCIe device:-
[root at mercury linux]# sh ./test.sh /dev/nvme0n4
+ DEV=/dev/nvme0n4
+ od -Ad -c pat
0000000   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
4915200
+ dd if=/dev/zero of=/dev/nvme0n4 bs=4k
dd: error writing ?/dev/nvme0n4?: No space left on device
308225+0 records in
308224+0 records out
1262485504 bytes (1.3 GB) copied, 1.75985 s, 717 MB/s
+ cat pat
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=2*4096'
+ blkdiscard -o 8192 -l 4096 -z /dev/nvme0n4
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=4*4096'
+ blkdiscard -o 16384 -l 4096 -z /dev/nvme0n4
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=6*4096'
+ blkdiscard -o 24576 -l 4096 -z /dev/nvme0n4
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=8*4096'
+ blkdiscard -o 32768 -l 4096 -z /dev/nvme0n4
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=10*4096'
+ blkdiscard -o 40960 -l 4096 -z /dev/nvme0n4
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=12*4096'
+ blkdiscard -o 49152 -l 4096 -z /dev/nvme0n4
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=14*4096'
+ blkdiscard -o 57344 -l 4096 -z /dev/nvme0n4
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=16*4096'
+ blkdiscard -o 65536 -l 4096 -z /dev/nvme0n4
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=18*4096'
+ blkdiscard -o 73728 -l 4096 -z /dev/nvme0n4
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=20*4096'
+ blkdiscard -o 81920 -l 4096 -z /dev/nvme0n4
+ od -Ad -c /dev/nvme0n4
0000000   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0008192  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0012288   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0016384  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0020480   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0024576  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0028672   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0032768  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0036864   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0040960  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0045056   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0049152  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0053248   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0057344  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0061440   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0065536  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0069632   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0073728  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0077824   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0081920  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0086016   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
4915200  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
1262485504
+ for i in 196608 397312 598016 798720
+ let offset=196608
+ blkdiscard -o 196608 -l 40960 -z /dev/nvme0n4
+ for i in 196608 397312 598016 798720
+ let offset=397312
+ blkdiscard -o 397312 -l 40960 -z /dev/nvme0n4
+ for i in 196608 397312 598016 798720
+ let offset=598016
+ blkdiscard -o 598016 -l 40960 -z /dev/nvme0n4
+ for i in 196608 397312 598016 798720
+ let offset=798720
+ blkdiscard -o 798720 -l 40960 -z /dev/nvme0n4
+ od -Ad -c /dev/nvme0n4
0000000   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0008192  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0012288   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0016384  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0020480   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0024576  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0028672   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0032768  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0036864   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0040960  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0045056   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0049152  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0053248   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0057344  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0061440   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0065536  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0069632   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0073728  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0077824   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0081920  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0086016   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0196608  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0237568   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0397312  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0438272   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0598016  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0638976   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0798720  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0839680   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
4915200  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
1262485504
+ set +x

With the above debug patch I can also see the following dmsg output:-

[330082.506588] nvme nvme0: pci function 0000:83:00.0
[330201.829003] nvme_queue_rq 888 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330201.832690] nvme_queue_rq 888 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330201.846602] nvme_queue_rq 888 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330201.847931] nvme_queue_rq 888 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330201.861560] nvme_queue_rq 888 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330201.862716] nvme_queue_rq 888 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330201.863831] nvme_queue_rq 888 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330201.864921] nvme_queue_rq 888 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330201.865990] nvme_queue_rq 888 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330201.867146] nvme_queue_rq 888 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330204.906180] nvme_queue_rq 888 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 40960
[330204.914592] nvme_queue_rq 888 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 40960
[330204.915681] nvme_queue_rq 888 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 40960
[330204.926548] nvme_queue_rq 888 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 40960


And on the nvme_loop target:-

[root at mercury linux]# ls -lrth  /mnt//test0
-rw-r--r--. 1 root root 512M May 14 17:22 /mnt//test0
[root at mercury linux]# losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE
/dev/loop0         0      0         0  0 /mnt/test0
[root at mercury linux]# nvme list
Node             SN                   Model
        Namespace Usage                      Format           FW Rev
---------------- --------------------
---------------------------------------- ---------
-------------------------- ---------------- --------
/dev/nvme0n1     CJH002000557         HUSMR7632BDP301
        1         646.39  GB / 646.39  GB      4 KiB +  0 B   KNGNP100
/dev/nvme0n2     CJH002000557         HUSMR7632BDP301
        2          64.64  GB /  64.64  GB      4 KiB +  0 B   KNGNP100
/dev/nvme0n3     CJH002000557         HUSMR7632BDP301
        3          64.64  GB /  64.64  GB      4 KiB +  0 B   KNGNP100
/dev/nvme0n4     CJH002000557         HUSMR7632BDP301
        4           1.26  GB /   1.26  GB      4 KiB +  0 B   KNGNP100
/dev/nvme1n1     0285f91919e03fd8     Linux
        1         536.87  MB / 536.87  MB    512   B +  0 B   4.17.0-r
[root at mercury linux]#
[root at mercury linux]# sh ./test.sh /dev/nvme1n1
+ DEV=/dev/nvme1n1
+ od -Ad -c pat
0000000   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
4915200
+ dd if=/dev/zero of=/dev/nvme1n1 bs=4k
dd: error writing ?/dev/nvme1n1?: No space left on device
131073+0 records in
131072+0 records out
536870912 bytes (537 MB) copied, 0.714807 s, 751 MB/s
+ cat pat
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=2*4096'
+ blkdiscard -o 8192 -l 4096 -z /dev/nvme1n1
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=4*4096'
+ blkdiscard -o 16384 -l 4096 -z /dev/nvme1n1
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=6*4096'
+ blkdiscard -o 24576 -l 4096 -z /dev/nvme1n1
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=8*4096'
+ blkdiscard -o 32768 -l 4096 -z /dev/nvme1n1
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=10*4096'
+ blkdiscard -o 40960 -l 4096 -z /dev/nvme1n1
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=12*4096'
+ blkdiscard -o 49152 -l 4096 -z /dev/nvme1n1
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=14*4096'
+ blkdiscard -o 57344 -l 4096 -z /dev/nvme1n1
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=16*4096'
+ blkdiscard -o 65536 -l 4096 -z /dev/nvme1n1
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=18*4096'
+ blkdiscard -o 73728 -l 4096 -z /dev/nvme1n1
+ for i in 2 4 6 8 10 12 14 16 18 20
+ let 'offset=20*4096'
+ blkdiscard -o 81920 -l 4096 -z /dev/nvme1n1
+ od -Ad -c /dev/nvme1n1
0000000   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0008192  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0012288   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0016384  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0020480   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0024576  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0028672   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0032768  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0036864   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0040960  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0045056   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0049152  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0053248   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0057344  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0061440   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0065536  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0069632   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0073728  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0077824   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0081920  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0086016   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
4915200  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
536870912
+ for i in 196608 397312 598016 798720
+ let offset=196608
+ blkdiscard -o 196608 -l 40960 -z /dev/nvme1n1
+ for i in 196608 397312 598016 798720
+ let offset=397312
+ blkdiscard -o 397312 -l 40960 -z /dev/nvme1n1
+ for i in 196608 397312 598016 798720
+ let offset=598016
+ blkdiscard -o 598016 -l 40960 -z /dev/nvme1n1
+ for i in 196608 397312 598016 798720
+ let offset=798720
+ blkdiscard -o 798720 -l 40960 -z /dev/nvme1n1
+ od -Ad -c /dev/nvme1n1
0000000   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0008192  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0012288   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0016384  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0020480   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0024576  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0028672   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0032768  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0036864   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0040960  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0045056   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0049152  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0053248   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0057344  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0061440   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0065536  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0069632   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0073728  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0077824   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0081920  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0086016   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0196608  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0237568   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0397312  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0438272   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0598016  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0638976   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
0798720  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0839680   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
*
4915200  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
536870912
+ set +x
[root at mercury linux]# dmesg -c
[330568.492173] loop: module loaded
[330569.023349] nvmet: adding nsid 1 to subsystem testnqn1
[330571.066754] nvmet: creating controller 1 for subsystem testnqn1
for NQN nqn.2014-08.org.nvmexpress:uuid:7d92752e-5f50-4de1-8167-acc8d519719b.
[330571.066881] nvme nvme1: creating 24 I/O queues.
[330571.074993] nvme nvme1: new ctrl: "testnqn1"
[330590.911639] nvme_loop: nvme_loop_queue_rq 182 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330590.911645] nvmet: nvmet_execute_write_zeroes 174
[330590.922524] nvme_loop: nvme_loop_queue_rq 182 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330590.922530] nvmet: nvmet_execute_write_zeroes 174
[330590.938459] nvme_loop: nvme_loop_queue_rq 182 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330590.938464] nvmet: nvmet_execute_write_zeroes 174
[330590.939906] nvme_loop: nvme_loop_queue_rq 182 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330590.939910] nvmet: nvmet_execute_write_zeroes 174
[330590.941491] nvme_loop: nvme_loop_queue_rq 182 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330590.941496] nvmet: nvmet_execute_write_zeroes 174
[330590.942956] nvme_loop: nvme_loop_queue_rq 182 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330590.942960] nvmet: nvmet_execute_write_zeroes 174
[330590.944506] nvme_loop: nvme_loop_queue_rq 182 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330590.944511] nvmet: nvmet_execute_write_zeroes 174
[330590.945949] nvme_loop: nvme_loop_queue_rq 182 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330590.945953] nvmet: nvmet_execute_write_zeroes 174
[330590.947474] nvme_loop: nvme_loop_queue_rq 182 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330590.947480] nvmet: nvmet_execute_write_zeroes 174
[330590.958436] nvme_loop: nvme_loop_queue_rq 182 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 4096
[330590.958442] nvmet: nvmet_execute_write_zeroes 174
[330592.334817] nvme_loop: nvme_loop_queue_rq 182 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 40960
[330592.334827] nvmet: nvmet_execute_write_zeroes 174
[330592.734544] nvme_loop: nvme_loop_queue_rq 182 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 40960
[330592.734548] nvmet: nvmet_execute_write_zeroes 174
[330592.735727] nvme_loop: nvme_loop_queue_rq 182 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 40960
[330592.735733] nvmet: nvmet_execute_write_zeroes 174
[330592.748490] nvme_loop: nvme_loop_queue_rq 182 opcode 0x8
blk_rq_nr_phys_segments(req) 0 blk_rq_payload_bytes 40960
[330592.748495] nvmet: nvmet_execute_write_zeroes 174
[root at mercury linux]#


With PCIe nvme_queue_rq() uses blk_rq_nr_phys_segments() so it worked fine,
but it will fail for loop.

Do you want me to send the entire series with test results and include
this patch?

-Chaitanya

On Mon, May 14, 2018@1:32 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, May 11, 2018@02:38:15AM -0400, Chaitanya Kulkarni wrote:
>> This patch replaces blk_rq_payload_bytes() with
>> blk_rq_nr_phys_segments(). For the payloadless requests like
>> write-zeroes it will trigger BUD_ON() at
>> sg_alloc_table_chained() since blk_rq_nr_phys_segments()
>> will evaluate to 0 due to nature of the request.
>
> Can you explain the exact setup?  If blk_rq_payload_bytes is non-zero
> we should always have at least one segment at this point, either
> because we got one passed down, or because we did set up the
> special_vec magic.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
