Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13507C5519F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 14:58:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B084D22263
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 14:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TpIwG3tZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FD7Das6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B084D22263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wkORPqU16gzAEZaw8yGNQPAGm35RkOkWR2wYhSvXvGU=; b=TpIwG3tZ+Os4BQScgbQelfSwT
	GDKFi+8GKMQyg30KZUH4zD8vJGDxSvKgt1v5ml7Fr0hQYzYPrzmsaNnHOCPukBnFjvLifpKXS+xUs
	7eq4RsQQ+YgA6wrRnDN3E+hqtQNNXIOSsMV4wgBcKDDHLLqSwmMHpztlwYkGuwd3PuMGaiJKKOEPT
	U19yLx46ru7gkEsUM57lLNtx1fnJqJnegrCF774QIaduelFeL2Q88QHwtERcIYO4rsufxX3rwB8hU
	bAoO1B/fcUnrDbeb4IfQxWqav/bm9Yd62ncjUMXrts5fVb6nh4SY9DFd3XgAu/QoQBx26xebcayaD
	HIqaeI0jA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kefy0-0003am-RM; Mon, 16 Nov 2020 14:58:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefxX-0003Mx-K3
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:58:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=P79Gf++XFU6hHqLQrw0lALqz5dNl+ctbqrznHTPStfQ=; b=FD7Das6TDEjq3rfmXkqaOjbFQ3
 YfESJ91RJF4/7NTkMH584g6c6YDfnvGQoeWsu171HgLMde/Ltz+y7z9vxMTbM/GcG5qcoNrWFfn4o
 ecJkINhlGAPVTLeyfzouxKX5BbYnqe4VXZaD61qR0oEVPbcvoQLvAWD4NKQpoy/sNyynJXDWVO3ca
 dqs8Eq34clhCkpk7c2M876zlKIlTQxn6KvJMSW0IiIB2lNOfm4s1SKx6u3jT3Ri5n8tVOnj2+CgIp
 CwShMZsSRHCj7jUKXC5s454mqxFeP7xg16Zyd8xVitmw1TSarsnO6hNOF7sNkAFXfVWKjRWpbsAnL
 tg/055FA==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefxW-0003lB-6P; Mon, 16 Nov 2020 14:58:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/78] nbd: validate the block size in nbd_set_size
Date: Mon, 16 Nov 2020 15:57:00 +0100
Message-Id: <20201116145809.410558-10-hch@lst.de>
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

Move the validation of the block from the callers into nbd_set_size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/nbd.c | 47 +++++++++++++++------------------------------
 1 file changed, 15 insertions(+), 32 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 6e8f2ff715c661..7478a5e02bc1ed 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -296,16 +296,21 @@ static void nbd_size_clear(struct nbd_device *nbd)
 	}
 }
 
-static void nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
+static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 		loff_t blksize)
 {
 	struct block_device *bdev;
 
+	if (!blksize)
+		blksize = NBD_DEF_BLKSIZE;
+	if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
+		return -EINVAL;
+
 	nbd->config->bytesize = bytesize;
 	nbd->config->blksize = blksize;
 
 	if (!nbd->task_recv)
-		return;
+		return 0;
 
 	if (nbd->config->flags & NBD_FLAG_SEND_TRIM) {
 		nbd->disk->queue->limits.discard_granularity = blksize;
@@ -325,6 +330,7 @@ static void nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 		bdput(bdev);
 	}
 	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
+	return 0;
 }
 
 static void nbd_complete_rq(struct request *req)
@@ -1304,8 +1310,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 		args->index = i;
 		queue_work(nbd->recv_workq, &args->work);
 	}
-	nbd_set_size(nbd, config->bytesize, config->blksize);
-	return error;
+	return nbd_set_size(nbd, config->bytesize, config->blksize);
 }
 
 static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *bdev)
@@ -1347,14 +1352,6 @@ static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
 		nbd_config_put(nbd);
 }
 
-static bool nbd_is_valid_blksize(unsigned long blksize)
-{
-	if (!blksize || !is_power_of_2(blksize) || blksize < 512 ||
-	    blksize > PAGE_SIZE)
-		return false;
-	return true;
-}
-
 static void nbd_set_cmd_timeout(struct nbd_device *nbd, u64 timeout)
 {
 	nbd->tag_set.timeout = timeout * HZ;
@@ -1379,19 +1376,12 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 	case NBD_SET_SOCK:
 		return nbd_add_socket(nbd, arg, false);
 	case NBD_SET_BLKSIZE:
-		if (!arg)
-			arg = NBD_DEF_BLKSIZE;
-		if (!nbd_is_valid_blksize(arg))
-			return -EINVAL;
-		nbd_set_size(nbd, config->bytesize, arg);
-		return 0;
+		return nbd_set_size(nbd, config->bytesize, arg);
 	case NBD_SET_SIZE:
-		nbd_set_size(nbd, arg, config->blksize);
-		return 0;
+		return nbd_set_size(nbd, arg, config->blksize);
 	case NBD_SET_SIZE_BLOCKS:
-		nbd_set_size(nbd, arg * config->blksize,
-			     config->blksize);
-		return 0;
+		return nbd_set_size(nbd, arg * config->blksize,
+				    config->blksize);
 	case NBD_SET_TIMEOUT:
 		nbd_set_cmd_timeout(nbd, arg);
 		return 0;
@@ -1809,18 +1799,11 @@ static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
 	if (info->attrs[NBD_ATTR_SIZE_BYTES])
 		bytes = nla_get_u64(info->attrs[NBD_ATTR_SIZE_BYTES]);
 
-	if (info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]) {
+	if (info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES])
 		bsize = nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
-		if (!bsize)
-			bsize = NBD_DEF_BLKSIZE;
-		if (!nbd_is_valid_blksize(bsize)) {
-			printk(KERN_ERR "Invalid block size %llu\n", bsize);
-			return -EINVAL;
-		}
-	}
 
 	if (bytes != config->bytesize || bsize != config->blksize)
-		nbd_set_size(nbd, bytes, bsize);
+		return nbd_set_size(nbd, bytes, bsize);
 	return 0;
 }
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
