From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 25 Jun 2019 17:17:07 +0800
Subject: [nvme] Invalid SGL for payload:91648 nents:3
In-Reply-To: <92778741dff3723fc94cd75df3043adc9c8bf21a.camel@rohdewald.de>
References: <92778741dff3723fc94cd75df3043adc9c8bf21a.camel@rohdewald.de>
Message-ID: <20190625091704.GA30606@ming.t460p>

Hi Wolfgang,

On Tue, Jun 25, 2019@09:51:04AM +0200, Wolfgang Rohdewald wrote:
> For some time now, I am getting this on an Intel SSD M.2, output of smartctl see below.
> This also happens with sgl_threshold=0.
> 
> Untainted kernel 5.1.14 (happens also with 5.1.8 and 5.1.15) on Ubuntu 19.04
> 
> I cannot say exactly when this started. I cannot trigger it with
> cp -a but after starting Virtualbox 6.0.6_Ubuntu r129722 with a Windows 10 client,
> it happens quickly. The first logged case is with Linux 5.1.11 but I did
> not use Virtualbox for some time before, so if that is what it triggers,
> the bug might be older.
> 
> I have a Samsung SSD 950 PRO 512GB for the root partition, the Intel SSD
> holds a separate ext4 file system. According to smartctl, the Samsung
> has no problems. Using Virtualbox there also gives me unexplainable
> print_req_error messages but nothing else.
> 
> After this happens, smartctl -a often says
> 
> Read Error Information Log failed: NVMe Status 0x02
> 
> Otherwise, smartctl finds no problems with the SSD, fsck -f is clean,
> fsck -c finds no bad blocks.
> 
> The sector numbers in the print_req_error message vary, see below.
> 
> smartctl 6.6 2017-11-05 r4594 [x86_64-linux-5.1.15-364] (local build)
> Copyright (C) 2002-17, Bruce Allen, Christian Franke, www.smartmontools.org
> 
> === START OF INFORMATION SECTION ===
> Model Number:                       INTEL SSDPEKNW020T8
> Serial Number:                      BTNH903409YJ2P0C
> Firmware Version:                   002C
> PCI Vendor/Subsystem ID:            0x8086
> IEEE OUI Identifier:                0x5cd2e4
> Controller ID:                      1
> Number of Namespaces:               1
> Namespace 1 Size/Capacity:          2.048.408.248.320 [2,04 TB]
> Namespace 1 Formatted LBA Size:     512
> Local Time is:                      Tue Jun 25 08:57:41 2019 CEST
> Firmware Updates (0x14):            2 Slots, no Reset required
> Optional Admin Commands (0x0017):   Security Format Frmw_DL Self_Test
> Optional NVM Commands (0x005f):     Comp Wr_Unc DS_Mngmt Wr_Zero Sav/Sel_Feat Timestmp
> Maximum Data Transfer Size:         32 Pages
> Warning  Comp. Temp. Threshold:     77 Celsius
> Critical Comp. Temp. Threshold:     80 Celsius
> 
> Supported Power States
> St Op     Max   Active     Idle   RL RT WL WT  Ent_Lat  Ex_Lat
>  0 +     5.50W       -        -    0  0  0  0        0       0
>  1 +     3.60W       -        -    1  1  1  1        0       0
>  2 +     2.60W       -        -    2  2  2  2        0       0
>  3 -   0.0300W       -        -    3  3  3  3     5000    5000
>  4 -   0.0040W       -        -    4  4  4  4     5000    9000
> 
> Supported LBA Sizes (NSID 0x1)
> Id Fmt  Data  Metadt  Rel_Perf
>  0 +     512       0         0
> 
> === START OF SMART DATA SECTION ===
> SMART overall-health self-assessment test result: PASSED
> 
> SMART/Health Information (NVMe Log 0x02, NSID 0x1)
> Critical Warning:                   0x00
> Temperature:                        32 Celsius
> Available Spare:                    100%
> Available Spare Threshold:          10%
> Percentage Used:                    0%
> Data Units Read:                    9.228.998 [4,72 TB]
> Data Units Written:                 3.245.879 [1,66 TB]
> Host Read Commands:                 41.518.159
> Host Write Commands:                14.046.787
> Controller Busy Time:               365
> Power Cycles:                       40
> Power On Hours:                     1.239
> Unsafe Shutdowns:                   11
> Media and Data Integrity Errors:    0
> Error Information Log Entries:      0
> Warning  Comp. Temperature Time:    0
> Critical Comp. Temperature Time:    0
> 
> Read Error Information Log failed: NVMe Status 0x02
> 
> 
> Jun 23 07:49:20 skull kernel: [  171.583390] vboxdrv: 0000000000000000 VBoxEhciR0.r0
> Jun 23 07:52:35 skull kernel: [  366.611276] sg[0] phys_addr:0x0000000372be9000 offset:0 length:60416 dma_address:0x0000000372be9000 dma_length:60416
> Jun 23 07:52:35 skull kernel: [  366.611277] sg[1] phys_addr:0x0000000372bf7c00 offset:3072 length:33792 dma_address:0x0000000372bf7c00 dma_length:33792
> Jun 23 07:52:35 skull kernel: [  366.611278] sg[2] phys_addr:0x0000000372929000 offset:0 length:36864 dma_address:0x0000000372929000 dma_length:36864

The above sg supposes to not be in same IO request, given each one is unaligned
wrt. virt_boundary limit, and bvec_split_segs() did check the limit.


> Jun 23 07:52:35 skull kernel: [  366.611281] ------------[ cut here ]------------
> Jun 23 07:52:35 skull kernel: [  366.611282] Invalid SGL for payload:131072 nents:3
> Jun 23 07:52:35 skull kernel: [  366.611294] WARNING: CPU: 2 PID: 7675 at drivers/nvme/host/pci.c:748 nvme_queue_rq+0x9ed/0xa40

So far, no idea how the issue is triggered, maybe we can find something
by dumping the request, could you apply the following patch against your
5.1 kernel source code and post the log after the issue is triggered?

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a90cf5d63aac..c7999e362434 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -656,6 +656,29 @@ static void nvme_print_sgl(struct scatterlist *sgl, int nents)
 	}
 }
 
+static void nvme_dump_rq(const struct request *rq)
+{
+	int i = 0;
+	struct req_iterator rq_iter;
+	struct bio_vec bvec;
+	struct bio *bio;
+
+	trace_printk("%s: bvec for %d(f:%x/%x, seg: %d)\n", __func__,
+			rq->tag, rq->cmd_flags, rq->rq_flags,
+			rq->nr_phys_segments);
+
+	__rq_for_each_bio(bio, rq)
+		printk("bio %d: %hx/%hx %u %llu %u\n", i++,
+			bio->bi_flags, bio->bi_opf,
+			bio->bi_phys_segments,
+			(unsigned long long)bio->bi_iter.bi_sector,
+			bio->bi_iter.bi_size);
+	i = 0;
+	rq_for_each_bvec(bvec, rq, rq_iter)
+		printk("%d: pfn %lu offset %u len %u\n", i++,
+				(unsigned long)page_to_pfn(bvec.bv_page),
+				bvec.bv_offset, bvec.bv_len);
+}
 static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 		struct request *req, struct nvme_rw_command *cmnd)
 {
@@ -746,6 +769,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 	WARN(DO_ONCE(nvme_print_sgl, iod->sg, iod->nents),
 			"Invalid SGL for payload:%d nents:%d\n",
 			blk_rq_payload_bytes(req), iod->nents);
+	nvme_dump_rq(req);
 	return BLK_STS_IOERR;
 }
 

Thanks,
Ming
