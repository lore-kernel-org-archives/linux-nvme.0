Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C189C4363A
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 23:15:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A8C223BF
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 23:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oqG5n3wX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z92NH8+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A8C223BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TtyifNM4KzuJxeGhU9PYpXTqVuufR4InG6PRsP3QoFo=; b=oqG5n3wX7VUdKQGxkOYEU5bkWq
	r8h9Vg4dzuscVfeyTSW7zveofVBPZ8WTQ4LFnw5HNMkW5d0bgctQsdRkmq1t1QVjEmpt8NsTfMX3n
	7vvU+FnIjMadixW6hcU6MndSvUCjjP65q93kHxok9Rz2Xo/ttKglY0TKBuUyFyVElE6GgS9EKPjVo
	c0XWNrJ/rhCiK7V9eI0s+vI1o3ZYrLD1TL7+lwr2JnAYw1cfnWD+lSNJOgmJHskrKsobx7fzoi8vy
	loSL+dLYkoJUR2kwM4fg6+IjRtKLfsaQeafjkkQMNclhaFn+J4uGAftemieVIMuQ1wCcS5fyjKfV1
	1gqk+VPA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kV0qD-00018f-Fg; Tue, 20 Oct 2020 23:14:53 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kV0qA-00017o-Jy
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 23:14:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603235691; x=1634771691;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DDQuUfvgnMW5owilVjUbdJk1Igmnbz8mcWPP8qskF90=;
 b=Z92NH8+LX2tLxcSui75kk48cZsfIRR6CWZ+FcZXzHDnIyjQFTBT0o5hW
 R2FMldEojXSfiXkvUJFMujT4WxEVrmWvEU0Z0z8CXmXsuPMezBVX7HxhJ
 YISiQL5X3B0r6pqzJMkWax90T3GDJyc2c2k17K4I/CMrZvZmbK9TTRu46
 erSKxJB8H29Vz6/HP839ZUsD+PdBn4CbnnYPpyt9ttVuZmvJxXlANGjc8
 SyONMYCaW8wJXVeWzNEQlY/+Qeg5udz74rh/KkDldDF+aVwHr0vGgqhhD
 Jvf3iZ649IL0NvmJjCjOUwsq96h3h0HlICPuN4poN7zntrgzG+GoxBkjr g==;
IronPort-SDR: BZt8z0Wf9SuJo0Tgw7MUkZ1hlE7nvlUlCLJJ1QgDn9hnHOEYAvVs0v6rj0NpcvdfGzeIXyH6xN
 7ODZwUnNyHsP2z9eh3OEsaHW4LrxaSswU5lu5hyDV2oeCkBSc+asGmlG8MQpDGVJo+DnPDD7kK
 onA0DJ068boNLfF4aj4NWqaxiKtNkvIepVNv1OcikKNlez2Wdd5DrDGqJVD98a83TKJR6O0xww
 DbQpW3TJT+th4kX0/Bvf7c2y/d+qilYPrHqUNzfmqrdM4Jol9BgEFVvbfLXNWErYS79ys/MMSG
 aUs=
X-IronPort-AV: E=Sophos;i="5.77,399,1596470400"; d="scan'208";a="150547165"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2020 07:14:48 +0800
IronPort-SDR: tV2cFio9HxG17qrPV41g0Q9lmxPe0kM6B0ePAG1/RidZpnzV+1b5GayWdpywCc4qu78TfCCw5Y
 gklqF254kHiD1ah06/U5obI37EcJykG/wft4VuiwjdlKvDM4us0Mr8GTqnBvy762eZGcaEHaH2
 p07N5u8WEzmacCyMmxrmyxZh9yZnmKjaAY19p2lJmp9kxpqDH+qoy5pSq9oIeV/SqWmJbXpnJb
 6p0cfqshBY2A3UFoXMFjSBHw3SWBqV0B4dAl89wPfsfyEAn5sfUTq/C4kGBogy7mC9UnhBvGPC
 klkeHGY8mwdpWMVLLIES2lCR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2020 16:00:21 -0700
IronPort-SDR: UaSIXm5PUg60wXmI8cZFQzx0+r8nQurjBTXj3V/bRXuZ3mJu7PkHI732MUQfqKvhcqmemp2eES
 i1QHNgvU6T7yx/87oVpi9ZOdi2F7dA1bKD0S3cHPvHYr0nyjA6AuF6AgGSm5YtfZ7yKkbvCw4r
 hZ5qvMtgCe9nrsIu3wPgm3zRnHSG0xHWnQfRc1ikC4Mrl0pkB2S9zeytv1hCS85Pl3yRZmNC0k
 u9/HrAmOU00zFyYTf6DG/YJRj+/wnyU5PhgFSl4tECJap4ZUdR9uKY+5gj6nKkEv6FanaFHXjx
 txg=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 20 Oct 2020 16:14:48 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 0/1] nvmet: don't use BLK_MQ_REQ_NOWAIT for passthru
Date: Tue, 20 Oct 2020 16:14:03 -0700
Message-Id: <20201020231404.9365-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_191450_816819_9800B006 
X-CRM114-Status: GOOD (  14.29  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

When using NVMeOF target in the passthru mode we allocate the request
with BLK_MQ_REQ_NOWAIT flag. This allocates the request in the following
manner :-

nvme_alloc_request()
 blk_mq_alloc_request()
  blk_mq_queue_enter()
   if (flag & BLK_MQ_REQ_NOWAIT)
  	return -EBUSY; <-- return if busy.

On the NVMe controller which I've the fio random write workload running
parallel on 32 namespaces with higher queue depth results in I/O error,
where blk_mq_queue_enter() returning -EBUSY as shown above. This problem
is not easy to reproduce but occurs once in a while with following error
(See 1 for detailed log) :-

fio: io_u error on file /dev/nvme2n27: Input/output error:
write offset=1417535488, buflen=4096

Removing the BLK_MQ_REQ_NOWAIT flag fixes the error See [2].

Regards,
Chaitanya

* Changes from V1:-

1. Remove the configfs param which was added to retain the default
   behaviour.

Chaitanya Kulkarni (1):
  nvmet: don't use BLK_MQ_REQ_NOWAIT for passthru

 drivers/nvme/target/passthru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

1. FIO workload resulting in the I/O error with default behavior :-
-------------------------------------------------------------------
fio-3.8-5-g464b
Starting 32 processes
fio: io_u error on file /dev/nvme2n27: Input/output error: write offset=1417535488, buflen=4096
fio: io_u error on file /dev/nvme2n27: Input/output error: write offset=3086512128, buflen=4096
fio: pid=7351, err=5/file:io_u.c:1744, func=io_u error, error=Input/output error

test1: (groupid=0, jobs=32): err= 5 (file:io_u.c:1744, func=io_u error, error=Input/output error): pid=7231: Tue Oct 20 15:58:39 2020
  write: IOPS=371k, BW=1449MiB/s (1519MB/s)(28.3GiB/20008msec)
    slat (usec): min=7, max=4395.1k, avg=80.28, stdev=7346.51
    clat (usec): min=59, max=4950.2k, avg=10959.88, stdev=85948.79
     lat (usec): min=269, max=4950.3k, avg=11040.29, stdev=86297.65
    clat percentiles (msec):
     |  1.00th=[    5],  5.00th=[    7], 10.00th=[    8], 20.00th=[    8],
     | 30.00th=[    8], 40.00th=[    8], 50.00th=[    9], 60.00th=[    9],
     | 70.00th=[    9], 80.00th=[   11], 90.00th=[   12], 95.00th=[   13],
     | 99.00th=[   14], 99.50th=[   14], 99.90th=[  266], 99.95th=[ 2198],
     | 99.99th=[ 3977]
   bw (  KiB/s): min=   56, max=135872, per=3.63%, avg=53903.52, stdev=14740.26, samples=1096
   iops        : min=   14, max=33968, avg=13475.80, stdev=3685.05, samples=1096
  lat (usec)   : 100=0.01%, 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=0.69%, 10=77.71%, 20=21.43%, 50=0.05%
  lat (msec)   : 250=0.01%, 500=0.02%, 750=0.01%, 1000=0.01%
  cpu          : usr=2.13%, sys=29.35%, ctx=615306, majf=0, minf=425
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwts: total=0,7420387,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=128

Run status group 0 (all jobs):
  WRITE: bw=1449MiB/s (1519MB/s), 1449MiB/s-1449MiB/s (1519MB/s-1519MB/s), io=28.3GiB (30.4GB), run=20008-20008msec

Disk stats (read/write):
  nvme2n1: ios=0/197898, merge=0/0, ticks=0/228729, in_queue=228730, util=33.25%
  nvme2n2: ios=40/224130, merge=0/0, ticks=4/228306, in_queue=228310, util=39.41%
  nvme2n3: ios=40/239787, merge=0/0, ticks=4/228579, in_queue=228584, util=41.12%
  nvme2n4: ios=40/233169, merge=0/0, ticks=7/238798, in_queue=238806, util=41.18%
  nvme2n5: ios=40/211806, merge=0/0, ticks=8/213539, in_queue=213547, util=38.52%
  nvme2n6: ios=40/274195, merge=0/0, ticks=6/228864, in_queue=228871, util=47.11%
  nvme2n7: ios=40/233491, merge=0/0, ticks=6/231474, in_queue=231481, util=43.22%
  nvme2n8: ios=40/218498, merge=0/0, ticks=8/231410, in_queue=231419, util=42.28%
  nvme2n9: ios=40/212493, merge=0/0, ticks=6/224277, in_queue=224284, util=40.88%
  nvme2n10: ios=0/228695, merge=0/0, ticks=0/219852, in_queue=219853, util=45.08%
  nvme2n11: ios=0/231399, merge=0/0, ticks=0/223938, in_queue=223938, util=46.55%
  nvme2n12: ios=0/235817, merge=0/0, ticks=0/210005, in_queue=210005, util=47.22%
  nvme2n13: ios=0/206752, merge=0/0, ticks=0/217374, in_queue=217375, util=42.48%
  nvme2n14: ios=0/238433, merge=0/0, ticks=0/231576, in_queue=231576, util=49.51%
  nvme2n15: ios=0/243670, merge=0/0, ticks=0/242351, in_queue=242352, util=52.40%
  nvme2n16: ios=0/236602, merge=0/0, ticks=0/235182, in_queue=235183, util=51.65%
  nvme2n17: ios=0/221305, merge=0/0, ticks=0/221968, in_queue=221968, util=51.56%
  nvme2n18: ios=0/243352, merge=0/0, ticks=0/226829, in_queue=226829, util=55.10%
  nvme2n19: ios=0/228293, merge=0/0, ticks=0/240925, in_queue=240926, util=55.47%
  nvme2n20: ios=0/228712, merge=0/0, ticks=0/234262, in_queue=234262, util=57.27%
  nvme2n21: ios=0/222757, merge=0/0, ticks=0/218464, in_queue=218465, util=56.75%
  nvme2n22: ios=0/221461, merge=0/0, ticks=0/230017, in_queue=230017, util=59.04%
  nvme2n23: ios=0/251562, merge=0/0, ticks=0/238324, in_queue=238324, util=63.18%
  nvme2n24: ios=0/227673, merge=0/0, ticks=0/227511, in_queue=227512, util=61.54%
  nvme2n25: ios=0/224529, merge=0/0, ticks=0/232201, in_queue=232201, util=64.99%
  nvme2n26: ios=0/213535, merge=0/0, ticks=0/220483, in_queue=220484, util=62.53%
  nvme2n27: ios=0/215235, merge=0/0, ticks=0/226286, in_queue=226286, util=66.75%
  nvme2n28: ios=0/234016, merge=0/0, ticks=0/236245, in_queue=236246, util=71.34%
  nvme2n29: ios=0/263185, merge=0/0, ticks=0/244128, in_queue=244129, util=78.04%
  nvme2n30: ios=0/234893, merge=0/0, ticks=0/242473, in_queue=242473, util=77.01%
  nvme2n31: ios=0/252381, merge=0/0, ticks=0/234862, in_queue=234862, util=79.70%
  nvme2n32: ios=0/229931, merge=0/0, ticks=0/241206, in_queue=241206, util=78.84%

2. FIO workload without any error when not using BLK_MQ_REQ_NOWAIT :-
---------------------------------------------------------------------
fio-3.8-5-g464b
Starting 32 processes
Jobs: 32 (f=32): [w(32)][100.0%][r=0KiB/s,w=1586MiB/s][r=0,w=406k IOPS][eta 00m:00s]
test1: (groupid=0, jobs=32): err= 0: pid=8355: Tue Oct 20 16:01:38 2020
  write: IOPS=379k, BW=1482MiB/s (1554MB/s)(86.8GiB/60001msec)
    slat (usec): min=7, max=2921.9k, avg=77.70, stdev=2888.32
    clat (usec): min=66, max=3151.7k, avg=10718.84, stdev=34419.95
     lat (usec): min=138, max=3151.7k, avg=10796.67, stdev=34562.09
    clat percentiles (msec):
     |  1.00th=[    7],  5.00th=[    8], 10.00th=[    8], 20.00th=[    9],
     | 30.00th=[    9], 40.00th=[    9], 50.00th=[   10], 60.00th=[   10],
     | 70.00th=[   10], 80.00th=[   12], 90.00th=[   14], 95.00th=[   15],
     | 99.00th=[   16], 99.50th=[   17], 99.90th=[  249], 99.95th=[  550],
     | 99.99th=[ 2106]
   bw (  KiB/s): min=   56, max=86480, per=3.24%, avg=49129.37, stdev=10469.48, samples=3676
   iops        : min=   14, max=21620, avg=12282.27, stdev=2617.36, samples=3676
  lat (usec)   : 100=0.01%, 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=0.01%, 10=70.74%, 20=28.99%, 50=0.13%
  lat (msec)   : 100=0.01%, 250=0.02%, 500=0.04%, 750=0.03%, 1000=0.01%
  cpu          : usr=2.33%, sys=33.88%, ctx=2147232, majf=0, minf=400
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwts: total=0,22760015,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=128

Run status group 0 (all jobs):
  WRITE: bw=1482MiB/s (1554MB/s), 1482MiB/s-1482MiB/s (1554MB/s-1554MB/s), io=86.8GiB (93.2GB), run=60001-60001msec

Disk stats (read/write):
  nvme2n1: ios=0/706667, merge=0/0, ticks=0/599438, in_queue=599439, util=67.26%
  nvme2n2: ios=40/708959, merge=0/0, ticks=7/597489, in_queue=597496, util=68.74%
  nvme2n3: ios=40/708004, merge=0/0, ticks=9/597836, in_queue=597846, util=68.69%
  nvme2n4: ios=40/748019, merge=0/0, ticks=5/605254, in_queue=605259, util=72.55%
  nvme2n5: ios=40/730666, merge=0/0, ticks=8/590529, in_queue=590538, util=71.24%
  nvme2n6: ios=40/713818, merge=0/0, ticks=6/557329, in_queue=557336, util=70.82%
  nvme2n7: ios=40/706833, merge=0/0, ticks=8/596236, in_queue=596245, util=70.51%
  nvme2n8: ios=40/701539, merge=0/0, ticks=6/584228, in_queue=584235, util=70.79%
  nvme2n9: ios=40/715091, merge=0/0, ticks=7/566007, in_queue=566014, util=72.27%
  nvme2n10: ios=0/709021, merge=0/0, ticks=0/583441, in_queue=583441, util=72.46%
  nvme2n11: ios=0/682020, merge=0/0, ticks=0/555933, in_queue=555934, util=71.22%
  nvme2n12: ios=0/692200, merge=0/0, ticks=0/595379, in_queue=595379, util=73.53%
  nvme2n13: ios=0/692685, merge=0/0, ticks=0/575632, in_queue=575632, util=73.10%
  nvme2n14: ios=0/712976, merge=0/0, ticks=0/580104, in_queue=580104, util=75.03%
  nvme2n15: ios=0/695618, merge=0/0, ticks=0/572385, in_queue=572386, util=75.13%
  nvme2n16: ios=0/704321, merge=0/0, ticks=0/569438, in_queue=569438, util=76.12%
  nvme2n17: ios=0/682198, merge=0/0, ticks=0/574509, in_queue=574509, util=76.62%
  nvme2n18: ios=0/698455, merge=0/0, ticks=0/580754, in_queue=580755, util=78.41%
  nvme2n19: ios=0/705429, merge=0/0, ticks=0/582465, in_queue=582466, util=79.51%
  nvme2n20: ios=0/719166, merge=0/0, ticks=0/573492, in_queue=573492, util=82.13%
  nvme2n21: ios=0/708253, merge=0/0, ticks=0/572174, in_queue=572174, util=81.47%
  nvme2n22: ios=0/730410, merge=0/0, ticks=0/600699, in_queue=600700, util=83.61%
  nvme2n23: ios=0/718952, merge=0/0, ticks=0/574481, in_queue=574482, util=83.71%
  nvme2n24: ios=0/711723, merge=0/0, ticks=0/582901, in_queue=582902, util=84.12%
  nvme2n25: ios=0/714620, merge=0/0, ticks=0/597742, in_queue=597742, util=85.40%
  nvme2n26: ios=0/713391, merge=0/0, ticks=0/608668, in_queue=608668, util=86.62%
  nvme2n27: ios=0/685253, merge=0/0, ticks=0/583583, in_queue=583584, util=85.96%
  nvme2n28: ios=0/720086, merge=0/0, ticks=0/586675, in_queue=586675, util=87.49%
  nvme2n29: ios=0/722030, merge=0/0, ticks=0/594997, in_queue=594998, util=90.26%
  nvme2n30: ios=0/730508, merge=0/0, ticks=0/601446, in_queue=601446, util=92.39%
  nvme2n31: ios=0/747852, merge=0/0, ticks=0/598947, in_queue=598947, util=93.79%
  nvme2n32: ios=0/698092, merge=0/0, ticks=0/584146, in_queue=584147, util=90.58%
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
