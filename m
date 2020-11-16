Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BFFC4742C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:11:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A84E23A32
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X+utsrQA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hC2kUAEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A84E23A32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=K9Ml2C+xJ18V4mVlbvz2hbO9fnD+JjNR0CPzm2geE7Q=; b=X+utsrQAiVVv1T4x2/bruRbIc
	ktsCboOMgBTs4au0Skp+Jr4KKK5k/M5nk0Sezi1nnCv6mf6NUVEcnQlMqIPuRKpbeUY0Yiv3QBFxS
	DgqGOzBFbISTdieZjB5ayqFkyJ+DGwYU8FBZi6Qh/swZfMGluInNPZGl6jwPgr8rM9uB1hwlqiIhq
	g+ByqN+lRgjDotHKeSdncQm9yOracoi0NIs5qtJSGEn2vmjVBij94q2vRhHTUKOXKIOdNEZv4E2aS
	gf7WlVArGs8kJNwQr9UW0G/SjU0cXPn5/mNnaOyGO9Mwgbdbr+btbYAlSwpQz1r6ROWBofi29SPPr
	eQl4+Ptaw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keg9j-0002Hw-SU; Mon, 16 Nov 2020 15:10:59 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyf-0003xI-QT
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:59:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=AZC0zIud/sy36HL3UqpdhruuJxaP+dAsE+XWl7N2xio=; b=hC2kUAEWCYh9OryEptbmVZ4ebz
 NJfypqCrjvekFThEDQHeAH+KnX3FgqoOh2oFdElpy2UOUU8OYvMVMyDtZx5PgsNNgO5KvLRJtcx2F
 8Z2wJ6ZAecQ/tCcYHLbAlAGK62e/LPO1anzZqXyhoiZcnyM456rb6Ib/pV9REehr8DlazH4amfdur
 a7V1kHvqoU8gZ+KDoDs23F8OiOCpjlxcgAWIv7ZpBKEh+7hc5sOGW+853KLP0z+7cruWtWsL7L99a
 DSrjRt5uLPvZTcUNxbnqe7Ie7DIj2M7MWaG8rzW38nm4RM1CwtXe4KSgUM8q+WHYxhoTnZfd7fBBR
 Uej9O+GQ==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyd-000470-B8; Mon, 16 Nov 2020 14:59:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 57/78] init: refactor devt_from_partuuid
Date: Mon, 16 Nov 2020 15:57:48 +0100
Message-Id: <20201116145809.410558-58-hch@lst.de>
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
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The code in devt_from_partuuid is very convoluted.  Refactor a bit by
sanitizing the goto and variable name usage.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts.c | 68 ++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index aef2f24461c7f1..afa26a4028d25e 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -105,13 +105,10 @@ static int match_dev_by_uuid(struct device *dev, const void *data)
  */
 static dev_t devt_from_partuuid(const char *uuid_str)
 {
-	dev_t res = 0;
 	struct uuidcmp cmp;
 	struct device *dev = NULL;
-	struct gendisk *disk;
-	struct hd_struct *part;
+	dev_t devt = 0;
 	int offset = 0;
-	bool clear_root_wait = false;
 	char *slash;
 
 	cmp.uuid = uuid_str;
@@ -120,52 +117,49 @@ static dev_t devt_from_partuuid(const char *uuid_str)
 	/* Check for optional partition number offset attributes. */
 	if (slash) {
 		char c = 0;
+
 		/* Explicitly fail on poor PARTUUID syntax. */
-		if (sscanf(slash + 1,
-			   "PARTNROFF=%d%c", &offset, &c) != 1) {
-			clear_root_wait = true;
-			goto done;
-		}
+		if (sscanf(slash + 1, "PARTNROFF=%d%c", &offset, &c) != 1)
+			goto clear_root_wait;
 		cmp.len = slash - uuid_str;
 	} else {
 		cmp.len = strlen(uuid_str);
 	}
 
-	if (!cmp.len) {
-		clear_root_wait = true;
-		goto done;
-	}
+	if (!cmp.len)
+		goto clear_root_wait;
 
-	dev = class_find_device(&block_class, NULL, &cmp,
-				&match_dev_by_uuid);
+	dev = class_find_device(&block_class, NULL, &cmp, &match_dev_by_uuid);
 	if (!dev)
-		goto done;
-
-	res = dev->devt;
+		return 0;
 
-	/* Attempt to find the partition by offset. */
-	if (!offset)
-		goto no_offset;
+	if (offset) {
+		/*
+		 * Attempt to find the requested partition by adding an offset
+		 * to the partition number found by UUID.
+		 */
+		struct hd_struct *part;
 
-	res = 0;
-	disk = part_to_disk(dev_to_part(dev));
-	part = disk_get_part(disk, dev_to_part(dev)->partno + offset);
-	if (part) {
-		res = part_devt(part);
-		put_device(part_to_dev(part));
+		part = disk_get_part(dev_to_disk(dev),
+				     dev_to_part(dev)->partno + offset);
+		if (part) {
+			devt = part_devt(part);
+			put_device(part_to_dev(part));
+		}
+	} else {
+		devt = dev->devt;
 	}
 
-no_offset:
 	put_device(dev);
-done:
-	if (clear_root_wait) {
-		pr_err("VFS: PARTUUID= is invalid.\n"
-		       "Expected PARTUUID=<valid-uuid-id>[/PARTNROFF=%%d]\n");
-		if (root_wait)
-			pr_err("Disabling rootwait; root= is invalid.\n");
-		root_wait = 0;
-	}
-	return res;
+	return devt;
+
+clear_root_wait:
+	pr_err("VFS: PARTUUID= is invalid.\n"
+	       "Expected PARTUUID=<valid-uuid-id>[/PARTNROFF=%%d]\n");
+	if (root_wait)
+		pr_err("Disabling rootwait; root= is invalid.\n");
+	root_wait = 0;
+	return 0;
 }
 
 /**
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
