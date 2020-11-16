Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4507C5519F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:06:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F1822450
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WLVEF4sq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d73ns3M7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F1822450
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3zGAP5Qjme7bvt4fTYgsnsF75fGemwB9BsvFy2Jr47M=; b=WLVEF4sqLoVl9tlPKQydbf3mg
	6Pc6wws8oM31HFtE5XN09EE52QP8qVEbilPJ9eyT67yzwxmhM8m85OUBDAV5muX3ipbkfP6MIgDYi
	1gGuPXYP6Boe3MGbRcoYQIZFocUxbqlOmNaUl2o/bPU+iemslQmvKPa+a43VvnJpUUg4PH/1IeGAu
	KB2Aqs+0rOPwIbNqaKpD5d4KS9KhgbkHCz0QKAOIakFoWHpPTQP86wIW9VEPDWnPeLzuWReJwUFd+
	ms7RVBcZdRDnv5bKgrgRlJLXuISg8uz7vUu8rr2FG03sh/zDQU65Nv2jpeKd6i5ctzINyYYYysefE
	M+TS7/3sg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keg55-0000Wb-MU; Mon, 16 Nov 2020 15:06:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyF-0003hZ-0E
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:59:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=ISq8BehFRmfA7X2bUEKuKNCEzkzF+ixwO2P3vH2Ca4g=; b=d73ns3M7F3JRR21anbEXFxuf9g
 A1xWTv4tBpopyBGHuve4hdPzPLwGluE0C2j9u+A4uk1WzPvrWwUq+wvI0IfwLikycPsXYuDfNoqOe
 m8TfyEmDYqxSeCEPv8OHRnRxlZa2BK0Mb/DUIm1Z0f6pGaDzcvBobxYIJlmaIdSdeUSaf89GVeTXM
 JufiFirvEUqjxlNXxHVTpo2WhwYvjUKrOkF5h55ecknCMyA1me/y2F2FdynUFWj9zZc5XKzC9ijl9
 HJGyPVpfezAKOMvhyISvMkEFsLN1uvdIFVszTvvkCN35wOb/aMbNL+Xc75GBLtiIukt+24033x1tu
 55Dk0zgg==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyD-0003xZ-0p; Mon, 16 Nov 2020 14:59:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 39/78] block: add an optional probe callback to major_names
Date: Mon, 16 Nov 2020 15:57:30 +0100
Message-Id: <20201116145809.410558-40-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a callback to the major_names array that allows a driver to override
how to probe for dev_t that doesn't currently have a gendisk registered.
This will help separating the lookup of the gendisk by dev_t vs probe
action for a not currently registered dev_t.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/genhd.c         | 21 ++++++++++++++++++---
 include/linux/genhd.h |  5 ++++-
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 8391e7d83a6920..dc8690bc281c16 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -399,6 +399,7 @@ static struct blk_major_name {
 	struct blk_major_name *next;
 	int major;
 	char name[16];
+	void (*probe)(dev_t devt);
 } *major_names[BLKDEV_MAJOR_HASH_SIZE];
 static DEFINE_MUTEX(major_names_lock);
 
@@ -441,7 +442,8 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
  * See Documentation/admin-guide/devices.txt for the list of allocated
  * major numbers.
  */
-int register_blkdev(unsigned int major, const char *name)
+int __register_blkdev(unsigned int major, const char *name,
+		void (*probe)(dev_t devt))
 {
 	struct blk_major_name **n, *p;
 	int index, ret = 0;
@@ -480,6 +482,7 @@ int register_blkdev(unsigned int major, const char *name)
 	}
 
 	p->major = major;
+	p->probe = probe;
 	strlcpy(p->name, name, sizeof(p->name));
 	p->next = NULL;
 	index = major_to_index(major);
@@ -502,8 +505,7 @@ int register_blkdev(unsigned int major, const char *name)
 	mutex_unlock(&major_names_lock);
 	return ret;
 }
-
-EXPORT_SYMBOL(register_blkdev);
+EXPORT_SYMBOL(__register_blkdev);
 
 void unregister_blkdev(unsigned int major, const char *name)
 {
@@ -1030,6 +1032,19 @@ static ssize_t disk_badblocks_store(struct device *dev,
 
 static void request_gendisk_module(dev_t devt)
 {
+	unsigned int major = MAJOR(devt);
+	struct blk_major_name **n;
+
+	mutex_lock(&major_names_lock);
+	for (n = &major_names[major_to_index(major)]; *n; n = &(*n)->next) {
+		if ((*n)->major == major && (*n)->probe) {
+			(*n)->probe(devt);
+			mutex_unlock(&major_names_lock);
+			return;
+		}
+	}
+	mutex_unlock(&major_names_lock);
+
 	if (request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt)) > 0)
 		/* Make old-style 2.4 aliases work */
 		request_module("block-major-%d", MAJOR(devt));
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 8427ad8bef520d..04f6a6bf577a90 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -366,7 +366,10 @@ extern void blk_unregister_region(dev_t devt, unsigned long range);
 
 #define alloc_disk(minors) alloc_disk_node(minors, NUMA_NO_NODE)
 
-int register_blkdev(unsigned int major, const char *name);
+int __register_blkdev(unsigned int major, const char *name,
+		void (*probe)(dev_t devt));
+#define register_blkdev(major, name) \
+	__register_blkdev(major, name, NULL)
 void unregister_blkdev(unsigned int major, const char *name);
 
 void revalidate_disk_size(struct gendisk *disk, bool verbose);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
