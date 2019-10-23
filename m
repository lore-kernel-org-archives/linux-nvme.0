Return-Path: <SRS0=6M3L=YQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DAECA9EB9
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2019 20:17:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D04D2064A
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2019 20:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JJDbNVcu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n09TgvFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D04D2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=qiA0RFs1FaFztmmPwqom09jb+WFckCEeUvC5aVbp3HY=; b=JJD
	bNVcutquM6Nwn4qSKV/QiuYz/b+N0ZAXXzCb42JiZkenEWu9uR1/dvKk6/fWBoRDj2ZU5tIjjGZ8w
	KmhQuDQsRm//JjbKozVzfwUq8JAoCZucd0Sl79Hpo5mMPd907ntiCy3gpoJBSinmPAuE+BIPFm5Au
	Y7SbpS043spDLjRvdUMbpLi+hmDUjAIRQ96GUpCue/GcKkoRl8JdKEAT9ZyDfbAAP4PCfLJTOoAwH
	OPYF2bL3SX2aGss+MokBRVH1OhNrkD3elYcm1P6ZpKvxXtd5cJOSTi+PcZ6m6VzLOnRO4xbEGSx2h
	GYWTVsHIFtmPRXH14CH0yLhh8ESuKyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iNN4e-0001Jv-Uu; Wed, 23 Oct 2019 20:17:40 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNN4a-0001J8-G1
 for linux-nvme@lists.infradead.org; Wed, 23 Oct 2019 20:17:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1571861856; x=1603397856;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7Llyp96RmhVmIRt+1FH405B9Tz+aXGpGBhOxuyddyuo=;
 b=n09TgvFjAuDut2zpYTDL7/oelccEjzUdNBKDc52nm6dlVq2iWSF8UBlM
 3oZUKRd+mX3sqKWmCmHQIe+VWQ6ihh8Sz5W/muObmiW+TxkBukYOxZ3pF
 +pNlRoNSaFQ/BPdJi2friBRq359naFcNTGkQb+eHgdqOKCxbZhe4TdwKL
 wrugToC6UHA1rRXmC6uzSIZeRSEswbh+ETU8a8BpnoIAevMEmDtTgUq9Q
 /oRI+1JJvAx9Gds1vJ3O8Z/CGeDw6o51q0VqsHN2VjTG+fS2L2RKEv7qp
 VgeJqLLiQW2uXmhOGHuvqQIC/O6Sc9JMcz+1VXlxlP3IDUP4r80aNKeTp w==;
IronPort-SDR: YgJabzjAO+Of/Hp0nI16J0jtZDmPXpT3m56T4Y6t5e6MTGi6DBZ8sNXWzIEnoqeZW2dsMhAZAu
 wl3h4pcP3fezn+dE9MZFeXaMzNQxz22ynd72LzzzpX9ZQHIXEAtRCfikhtrX6Sp8PJnKNqZjay
 /cEB1A3ErhzaYNKQPlC2LbUy6EY7FkgwHzTOaGX4jv+CLJqg1FnUymV1qHt5DtX2Sb9Mh0belz
 /4B6gBonBFawSuvVDVpo0BBGRNiHdyCCbbMwbw+lKFIjOaTIpC3tevhvk/hWDcAJE7XEotaeoi
 4r4=
X-IronPort-AV: E=Sophos;i="5.68,222,1569254400"; d="scan'208";a="228310230"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2019 04:17:20 +0800
IronPort-SDR: Vz2Qlh810k8NPMX2giPGv69kS353FoI0WVaqZ2JaZI5P69nhKKUhdkQ86jX9iyeGzsYUpKjYd/
 TOmTgk+UMwp52S9LPVFOusVis+dm991e6kGDqDkfPBSj/wGVfm5DJQ4EKRHwEpD2s1IdJCDNb5
 83vXTOWEzMBmAAE9oQVQbHc5RndbptWFgQqutn3BYTsXaziGLfL+XXxzN1Isiob8OlVd0JwxEY
 F5v3SBM+gYriagd4wDzTUcpbmyzqd09s1lopldggEFpd6QXFs4tv9DH6D37FOAmY99DeB3ATwe
 hae4pZKBB3SdBKwLjFW/Fl1R
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2019 13:12:49 -0700
IronPort-SDR: A53j/yqU6zZHuzALXMcDkarQ8uJuxvAIab8kORGaJAe4OAi3uzESIexvYg4KoFH+ltWfd6NOya
 tx16z38CaxV9XfeDqkN1PduBjpRkc8jcUmI+5p1pwgjOADJo9Oah7y8qHHbTh/BayKba7St3So
 2H0GMgM+Uu9CrSjKcm4cdXG0c0sGaCi6WUI8pW3SDNsPiU/din4JNQzHXX2hXPQfl//4xJFPjP
 GVqHBZSZpmD3J0ejHqiwPPfvCo5nbsOHJrWmCi0K0TiePa5H6F6RUuBLNCod3+t9c9OhRIiX1k
 Jsg=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2019 13:17:20 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: introduce use_vfs ns-attr
Date: Wed, 23 Oct 2019 13:17:15 -0700
Message-Id: <20191023201715.4236-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191023_131736_550407_53B41089 
X-CRM114-Status: GOOD (  18.13  )
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
Cc: MRuijter@onestopsystems.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: multipart/mixed; boundary="===============7671814761547574389=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============7671814761547574389==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

From: Mark Ruijter <MRuijter@onestopsystems.com>

With reference to the following issue reported on the mailing list :-
http://lists.infradead.org/pipermail/linux-nvme/2019-October/027604.html
This patch adds a new attrubute use_vfs so that any block device can be
used in the file backend.

We can see the follwoing performance improvement in the I/Os with
the setup described in the link when new attribute use_vfs=1 and
device_path configured as /dev/md0.

Performance numbers :-

1. With this patch using /dev/md0 as namespace backend where use_vfs=0:-
  write: IOPS=66.1k, BW=258MiB/s (271MB/s)(7750MiB/30002msec)
  write: IOPS=65.8k, BW=257MiB/s (269MB/s)(7709MiB/30002msec)
  write: IOPS=64.8k, BW=253MiB/s (266MB/s)(7599MiB/30002msec)

2. With this patch using /dev/md0 as namespace backend where use_vfs=1:-
  write: IOPS=153k, BW=598MiB/s (627MB/s)(17.5GiB/30001msec)
  write: IOPS=152k, BW=594MiB/s (623MB/s)(17.4GiB/30001msec)
  write: IOPS=151k, BW=589MiB/s (617MB/s)(17.2GiB/30002msec)

Signed-off-by: Mark Ruijter <MRuijter@onestopsystems.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Hi,

This work is originally done by Mark Ruijter
(MRuijter@onestopsystems.com), I've fixed couple of coding style issues,
tested, validated performance numbers with nvme-loop.

Setup Info md0 with 2 memory backed null_blk devices :-
# lsblk | grep null 
nullb1            252:1    0    2G  0 disk  
└─nullb1p1        259:1    0    2G  0 part  
nullb0            252:0    0    2G  0 disk  
└─nullb0p1        259:2    0    2G  0 part  
# mdadm -E /dev/nullb0
/dev/nullb0:
   MBR Magic : aa55
Partition[0] :      4192256 sectors at         2048 (type fd)
# mdadm -E /dev/nullb1
/dev/nullb1:
   MBR Magic : aa55
Partition[0] :      4192256 sectors at         2048 (type fd)
# mdadm --detail /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Tue Oct 22 15:45:48 2019
        Raid Level : raid1
        Array Size : 2095104 (2046.00 MiB 2145.39 MB)
     Used Dev Size : 2095104 (2046.00 MiB 2145.39 MB)
      Raid Devices : 2
     Total Devices : 2
       Persistence : Superblock is persistent

       Update Time : Tue Oct 22 23:22:22 2019
             State : clean 
    Active Devices : 2
   Working Devices : 2
    Failed Devices : 0
     Spare Devices : 0

Consistency Policy : resync

              Name : cvenusqemu:0  (local to host cvenusqemu)
              UUID : 28141eb1:94d31044:e2692981:08ccd882
            Events : 17

    Number   Major   Minor   RaidDevice State
       0     259        2        0      active sync   /dev/nullb0p1
       1     259        1        1      active sync   /dev/nullb1p1

Performance numbers :-
1. With this patch using /dev/md0 as namespace backend where use_vfs=0:-
  write: IOPS=66.1k, BW=258MiB/s (271MB/s)(7750MiB/30002msec)
  write: IOPS=65.8k, BW=257MiB/s (269MB/s)(7709MiB/30002msec)
  write: IOPS=64.8k, BW=253MiB/s (266MB/s)(7599MiB/30002msec)

2. With this patch using /dev/md0 as namespace backend where use_vfs=1:-
  write: IOPS=153k, BW=598MiB/s (627MB/s)(17.5GiB/30001msec)
  write: IOPS=152k, BW=594MiB/s (623MB/s)(17.4GiB/30001msec)
  write: IOPS=151k, BW=589MiB/s (617MB/s)(17.2GiB/30002msec)

We can see the significant performance improvement when use_vfs=1.

Note:- I've not tested entire patch with all the corner cases.
Once I get a feedback I'll send out well tested version.

Regards,
-Chaitanya

---
 drivers/nvme/target/configfs.c    | 29 +++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        |  1 +
 drivers/nvme/target/io-cmd-bdev.c |  5 +++++
 drivers/nvme/target/io-cmd-file.c | 31 +++++++++++++++++++++----------
 drivers/nvme/target/nvmet.h       |  1 +
 5 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a45bd3b..184555c19c03 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -545,12 +545,41 @@ static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, buffered_io);
 
+static ssize_t nvmet_ns_use_vfs_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", to_nvmet_ns(item)->use_vfs);
+}
+
+static ssize_t nvmet_ns_use_vfs_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	bool val;
+
+	if (strtobool(page, &val))
+		return -EINVAL;
+
+	mutex_lock(&ns->subsys->lock);
+	if (ns->enabled) {
+		pr_err("disable ns before setting use_vfs value.\n");
+		mutex_unlock(&ns->subsys->lock);
+		return -EINVAL;
+	}
+
+	ns->use_vfs = val;
+	mutex_unlock(&ns->subsys->lock);
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, use_vfs);
+
 static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
 	&nvmet_ns_attr_device_uuid,
 	&nvmet_ns_attr_ana_grpid,
 	&nvmet_ns_attr_enable,
+	&nvmet_ns_attr_use_vfs,
 	&nvmet_ns_attr_buffered_io,
 #ifdef CONFIG_PCI_P2PDMA
 	&nvmet_ns_attr_p2pmem,
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6b39cfc6ade1..1d7c6310d5f0 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -653,6 +653,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 	uuid_gen(&ns->uuid);
 	ns->buffered_io = false;
+	ns->use_vfs = false;
 
 	return ns;
 }
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f2618dc2ef3a..e0d8079de5c3 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -51,6 +51,11 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 {
 	int ret;
 
+	if (ns->use_vfs) {
+		pr_info("Force using the vfs layer\n");
+		return -ENOTBLK;
+	}
+
 	ns->bdev = blkdev_get_by_path(ns->device_path,
 			FMODE_READ | FMODE_WRITE, NULL);
 	if (IS_ERR(ns->bdev)) {
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 05453f5d1448..336ffda3261b 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -30,6 +30,7 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
 int nvmet_file_ns_enable(struct nvmet_ns *ns)
 {
 	int flags = O_RDWR | O_LARGEFILE;
+	struct block_device *bdev;
 	struct kstat stat;
 	int ret;
 
@@ -45,17 +46,27 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 
 	ret = vfs_getattr(&ns->file->f_path,
 			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC);
-	if (ret)
-		goto err;
-
-	ns->size = stat.size;
-	/*
-	 * i_blkbits can be greater than the universally accepted upper bound,
-	 * so make sure we export a sane namespace lba_shift.
-	 */
-	ns->blksize_shift = min_t(u8,
-			file_inode(ns->file)->i_blkbits, 12);
+	if (ret) {
+		pr_err("failed to stat device file %s\n",
+			ns->device_path);
+	}
 
+	if (stat.size == 0 && ns->use_vfs) {
+		bdev = blkdev_get_by_path(ns->device_path,
+					  FMODE_READ | FMODE_WRITE, NULL);
+		if (IS_ERR(bdev))
+			goto err;
+		ns->size = i_size_read(bdev->bd_inode);
+		ns->blksize_shift = blksize_bits(bdev_logical_block_size(bdev));
+	} else {
+		/*
+		 * i_blkbits can be greater than the universally accepted upper
+		 * bound, so make sure we export a sane namespace lba_shift.
+		 */
+		ns->size = stat.size;
+		ns->blksize_shift = min_t(u8,
+				file_inode(ns->file)->i_blkbits, 12);
+	}
 	ns->bvec_cache = kmem_cache_create("nvmet-bvec",
 			NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec),
 			0, SLAB_HWCACHE_ALIGN, NULL);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c51f8dd01dc4..20aa83077765 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -63,6 +63,7 @@ struct nvmet_ns {
 	u32			anagrpid;
 
 	bool			buffered_io;
+	bool			use_vfs;
 	bool			enabled;
 	struct nvmet_subsys	*subsys;
 	const char		*device_path;
-- 
2.22.1



--===============7671814761547574389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============7671814761547574389==--
