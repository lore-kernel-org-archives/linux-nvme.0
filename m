Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA65C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 20:48:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B856164E60
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 20:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B856164E60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QOiAH+fXgxHytXMCEq85/wLeZL4KYNW2ZK06+Tn5k98=; b=k99PohvOfLrhTDdNm2mdqhnkCW
	LyrFNgQtwABe96dHDvOTsEjteiJ0lJeUit6TmZ1y/xrSdqmndiVu+SVmNd/BbAsMgpKprPgLr6hVH
	+2GTOo/ng60tamRoXVwag38P3w3hMec5QyaLHifXEAlrUfn6d4uK0De4gcwBh/lzFRXua53bgfdeR
	HIheRYhiQXBtCGoaXfOAkPRuJfT6goEHQvnHlVGqqCB5sAYdoe1gKVqQNzGLA+BqEBJ29xKHtgJzj
	OdIR3rGVeAru7vVRoTiusnkAVJb1vVBmqKtN2zt6Gm2/EqP6zhe2nWihudSsSyCmb9WoZN1GB2CQB
	/sBgOyJg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEeb0-0004Xx-7G; Tue, 23 Feb 2021 20:47:50 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEeaw-0004X7-Tr
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 20:47:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614113994; x=1645649994;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Pu7K4yXMJAoDeJfaLOlSUKNho3AIZvlJH0SliL7B2PI=;
 b=O93gV/bdKbd+r7lo5MClqtpC5V7pGFlm1O2Z7ZQ6Tvfsmm+sE31o0xdc
 s2aemHnRo5B/Q1Lr06jenl4enGohOSl8Pw2nuRgVipX1idRvnMLqZJw0X
 VgXHF2qj3ZoMPbVIQMhUpAVeeBiy7eqd7gO5dQzT+VNkA+jzMc2IrvPS9
 UiHBfbYjxPM22OhQr27R967APj+x4topq2BmsByg9dPL2bKP/AaS7NsvA
 3/PCFINvUiw+0ojd9iC2ywhC1N4Alr6NFHGcn8jzqMEp+gdp3i/6FoJk8
 WNtrkO27X5LeV38ZNMo7j7J1D7J3rfsrIUboJ+neJR6Rrji3kvjxVLZe2 A==;
IronPort-SDR: f30NGCvjvO5p4tOVp3ztLYJwGBQ5FZ4WDhFUkxtyiIwClPvVc1NLrjtukMKjjUrT4guAOPDKXE
 FKQfB7vI45H/YoKOWuQGTMuI1VCeXrAPw3e25FFq0YMcPrPfSvmhRk3PoA4K4Q9mUzo0/P88ks
 VKY7Rs+aRgvEgwZ/l/UVHRzE6zJrXL9vTB0dL5oWdU5LlXOPxtVrLraws1FIVY2Xw8cVTc00py
 DOw/afvuzfq51psa1NNCeypx8iWgKnl5Yb03j5bUpZPGtfuv5o8GxPOLWJ12zBBShItuoLyA7E
 2BM=
X-IronPort-AV: E=Sophos;i="5.81,200,1610380800"; d="scan'208";a="264833724"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2021 04:59:50 +0800
IronPort-SDR: 1uMbrU3Sft8is7vOpXgKxj+9HquSYpMaHssryKSxx/K5Jh5D1slqgfDJaSxsKnYRdBzdsS8+Gi
 xyX7t5+EcX6tA+t+g+zT1nHXdPDANH7HbWz57oNfGwePe+U0y3v4FYOT6+7/lzRCoJ7s5MqwMW
 ldFdt23hkfJ4+6aAqczWfa/M/GCc40rXj7MYw9EVlnR90Hwymil9MpMIvU1bkhT99CUTPF6qh5
 NwOQO9I+CrN9JaaBieUIpEEIGnFJOHK47huh2kLotBqxG7uKj/oHOTgnKH9E/Immz3iig+OcMY
 vdI60paJG3oBKQmruQYf+LQu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2021 12:29:10 -0800
IronPort-SDR: eNetApVRwkxy4qQqfLI9Ur8dn5H1LqpBiezFDX/v5H1Q6agJrMnfbHkDHqE9jiiT92CbuulAcq
 ReCcJFIT4HZAsTCC55j3qvoXbem2K1uicavSwghP6yFLLyR5NBpp6vL7bS6jLlyMZFWMdBkjQ0
 C+PNlguNA091edcf7lRjOCM0jAjvojxPy3RnvhGhahhizY9rjlAYI1AEJtSpXpQ4w8LMLh5UTx
 vWM+YGFsj9E3egd/aoKghFLyschfj4pfPUu1oT4I+VKXkBFzQd7mQ5s8oMvUfuES8YItiLNi4T
 fK0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Feb 2021 12:47:44 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 0/2] nvme-pci: remove the barriers in nvme_irq()
Date: Tue, 23 Feb 2021 12:47:39 -0800
Message-Id: <20210223204741.38301-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_154747_158193_497ECBC8 
X-CRM114-Status: GOOD (  12.56  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@fb.com, kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

The first patch removes barrier from the nvme_irq() and second patch
does the code cleanup for the same.

Below is the test log for the fio verify.

-ck

Chaitanya Kulkarni (2):
  nvme-pci; remove the barriers nvme_irq()
  nvme-pci: cleanup nvme_irq()

 drivers/nvme/host/pci.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

# gitlog -2
157098245bab (HEAD -> nvme-5.12) nvme-pci: cleanup nvme_irq()
42d531edfe67 nvme-pci; remove the barriers nvme_irq()
# ./compile_nvme.sh 
+ umount /mnt/nvme0n1
+ clear_dmesg
umount: /mnt/nvme0n1: not mounted
+ modprobe -r nvme-fabrics
+ modprobe -r nvme_loop
+ modprobe -r nvmet
+ modprobe -r nvme
+ sleep 1
+ modprobe -r nvme-core
+ lsmod
+ grep nvme
+ git apply ./all-fixes.diff
+ git diff
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d77f3f26d8d3..cedf704adac6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1167,7 +1167,8 @@ static int nvme_submit_user_cmd(struct request_queue *q,
                if (ret)
                        goto out;
                bio = req->bio;
-               bio_set_dev(bio, bdev);
+               if(bdev)
+                       bio_set_dev(bio, bdev);
                if (bdev && meta_buffer && meta_len) {
                        meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
                                        meta_seed, write);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index cb6f86572b24..38fffee6b85e 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -688,7 +688,8 @@ static struct nvmf_transport_ops nvme_loop_transport = {
        .name           = "loop",
        .module         = THIS_MODULE,
        .create_ctrl    = nvme_loop_create_ctrl,
-       .allowed_opts   = NVMF_OPT_TRADDR,
+       .allowed_opts   = NVMF_OPT_TRADDR | NVMF_OPT_CTRL_LOSS_TMO,
+
 };
 
 static int __init nvme_loop_init_module(void)
++ nproc
+ make -j 64 M=drivers/nvme/ modules
+ HOST=drivers/nvme/host
+ TARGET=drivers/nvme/target
++ uname -r
+ HOST_DEST=/lib/modules/5.11.0-rc5nvme+/kernel/drivers/nvme/host/
++ uname -r
+ TARGET_DEST=/lib/modules/5.11.0-rc5nvme+/kernel/drivers/nvme/target/
+ cp drivers/nvme/host/nvme-core.ko drivers/nvme/host/nvme-fabrics.ko drivers/nvme/host/nvme-fc.ko drivers/nvme/host/nvme.ko drivers/nvme/host/nvme-rdma.ko drivers/nvme/host/nvme-tcp.ko /lib/modules/5.11.0-rc5nvme+/kernel/drivers/nvme/host//
+ cp drivers/nvme/target/nvme-fcloop.ko drivers/nvme/target/nvme-loop.ko drivers/nvme/target/nvmet-fc.ko drivers/nvme/target/nvmet.ko drivers/nvme/target/nvmet-rdma.ko drivers/nvme/target/nvmet-tcp.ko /lib/modules/5.11.0-rc5nvme+/kernel/drivers/nvme/target//
+ ls -lrth /lib/modules/5.11.0-rc5nvme+/kernel/drivers/nvme/host/ /lib/modules/5.11.0-rc5nvme+/kernel/drivers/nvme/target//
/lib/modules/5.11.0-rc5nvme+/kernel/drivers/nvme/host/:
total 8.0M
-rw-r--r--. 1 root 3.0M Feb 23 12:30 nvme-core.ko
-rw-r--r--. 1 root 643K Feb 23 12:30 nvme-fabrics.ko
-rw-r--r--. 1 root 1.2M Feb 23 12:30 nvme-fc.ko
-rw-r--r--. 1 root 1.1M Feb 23 12:30 nvme.ko
-rw-r--r--. 1 root 1.2M Feb 23 12:30 nvme-rdma.ko
-rw-r--r--. 1 root 1.1M Feb 23 12:30 nvme-tcp.ko

/lib/modules/5.11.0-rc5nvme+/kernel/drivers/nvme/target//:
total 8.2M
-rw-r--r--. 1 root 712K Feb 23 12:30 nvme-fcloop.ko
-rw-r--r--. 1 root 619K Feb 23 12:30 nvme-loop.ko
-rw-r--r--. 1 root 1.1M Feb 23 12:30 nvmet-fc.ko
-rw-r--r--. 1 root 4.0M Feb 23 12:30 nvmet.ko
-rw-r--r--. 1 root 1.1M Feb 23 12:30 nvmet-rdma.ko
-rw-r--r--. 1 root 852K Feb 23 12:30 nvmet-tcp.ko
+ modprobe nvme
# 
# cat fio/verify.fio 
[write-and-verify]
rw=randwrite
bs=4k
direct=1
ioengine=libaio
iodepth=4
norandommap
randrepeat=1
verify=crc32c
size=950m
group_reporting
# fio fio/verify.fio --filename=/dev/nvme0n1 
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=4
fio-3.8-5-g464b
Starting 1 process
Jobs: 1 (f=1): [f(1)][100.0%][r=104MiB/s,w=0KiB/s][r=26.6k,w=0 IOPS][eta 00m:00s]      
write-and-verify: (groupid=0, jobs=1): err= 0: pid=37040: Tue Feb 23 12:31:35 2021
   read: IOPS=26.4k, BW=103MiB/s (108MB/s)(602MiB/5831msec)
    slat (usec): min=11, max=5211, avg=32.40, stdev=24.38
    clat (usec): min=6, max=6821, avg=116.81, stdev=37.38
     lat (usec): min=65, max=6838, avg=149.39, stdev=45.87
    clat percentiles (usec):
     |  1.00th=[   81],  5.00th=[   98], 10.00th=[  103], 20.00th=[  105],
     | 30.00th=[  108], 40.00th=[  111], 50.00th=[  113], 60.00th=[  115],
     | 70.00th=[  118], 80.00th=[  123], 90.00th=[  133], 95.00th=[  153],
     | 99.00th=[  219], 99.50th=[  243], 99.90th=[  302], 99.95th=[  338],
     | 99.99th=[  482]
  write: IOPS=24.2k, BW=94.4MiB/s (99.0MB/s)(950MiB/10062msec)
    slat (usec): min=14, max=4146, avg=37.36, stdev=22.06
    clat (usec): min=56, max=4261, avg=126.98, stdev=27.62
     lat (usec): min=84, max=4327, avg=164.52, stdev=35.50
    clat percentiles (usec):
     |  1.00th=[   84],  5.00th=[   95], 10.00th=[  108], 20.00th=[  116],
     | 30.00th=[  120], 40.00th=[  124], 50.00th=[  126], 60.00th=[  127],
     | 70.00th=[  129], 80.00th=[  135], 90.00th=[  143], 95.00th=[  157],
     | 99.00th=[  225], 99.50th=[  258], 99.90th=[  351], 99.95th=[  404],
     | 99.99th=[  486]
   bw (  KiB/s): min=12344, max=99056, per=95.83%, avg=92647.62, stdev=18427.63, samples=21
   iops        : min= 3086, max=24764, avg=23161.90, stdev=4606.91, samples=21
  lat (usec)   : 10=0.01%, 50=0.01%, 100=6.46%, 250=93.05%, 500=0.48%
  lat (usec)   : 750=0.01%
  lat (msec)   : 4=0.01%, 10=0.01%
  cpu          : usr=12.95%, sys=86.81%, ctx=174, majf=0, minf=3626
  IO depths    : 1=0.1%, 2=0.1%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=154025,243200,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=4

Run status group 0 (all jobs):
   READ: bw=103MiB/s (108MB/s), 103MiB/s-103MiB/s (108MB/s-108MB/s), io=602MiB (631MB), run=5831-5831msec
  WRITE: bw=94.4MiB/s (99.0MB/s), 94.4MiB/s-94.4MiB/s (99.0MB/s-99.0MB/s), io=950MiB (996MB), run=10062-10062msec

Disk stats (read/write):
  nvme0n1: ios=154119/243200, merge=0/0, ticks=8957/14742, in_queue=23699, util=99.49%
# modprobe -r nvme 
# 

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
