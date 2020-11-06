Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D4BC5DF9D
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:04:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E22208C7
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jM4NX8dV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n8I2bAP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E22208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ImT3M9DZfvvVjmDW+F3+rjV/yYsi7nvYtfavd3gK4ac=; b=jM4NX8dVixLdUkqO8iPbrhGHT
	XQEfG+LufT7OWE3yVBG4sZOzuatEOohIwuqqJ5DA1u+9WiOEiM80Iu2qlyg+930608KH6UmHPCkY5
	I06V4PaAicGD62k+bNE8pa/KJs9NEvJlx0BajyyfrsQqzRdN2yXPMLEM1UAA6O9vHwpP/ZoJYND80
	dYFZ6pxMgfKBjdFPQVBrSMcyGyOSr7jfisel6kZyOmQTF/NU3FaRsBs8gJ0IlHdcEh0KAaDQ26uC+
	nyLxSRKZfYEr5u9Fl6oXroiu0ny4aPe1xYn3OhRP+Bo2pWSOrKOn7YFPSsVUV5HGpBA646IfC607S
	OS3/MXnGA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb727-0001FW-4R; Fri, 06 Nov 2020 19:04:23 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb71t-00017V-Cm
 for linux-nvme@merlin.infradead.org; Fri, 06 Nov 2020 19:04:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=bvDrEMxNDsV0qnNGdlqXQ69LsBhINsh0TucESS2zUH4=; b=n8I2bAP/s2+x6HOHdjRdHDWR3/
 GA/Cs3M+JrFbYS8rdgv0qo6a4A0jrAZBnmY+K1D74/+PV24lfi4IfolPr81Es5J+oT3bNkKw+zeyt
 gzGbvCJ/WLzovUznZrsUBw/c3J9CCUvz+ACD1ZDZABtLuHpP1MIu1EsTtA6gHC13E5VQHVC3M2IPO
 euQ15DdO/iHu2S2Q/EN08UcT6UkTgp+yjc+bc84KvHOaWCsbvd4kqKO3zm38ITtQtkMvvsIlZcQLN
 c065U6oC9P/8yGDRb0naXdAcrUAL3dBvZQFdpezRIgymyXONVwpK8wkcN1XKXY+qgz/GD1N42jXxh
 uh/ciLlg==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb71r-0000wc-G0; Fri, 06 Nov 2020 19:04:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/24] nbd: validate the block size in nbd_set_size
Date: Fri,  6 Nov 2020 20:03:22 +0100
Message-Id: <20201106190337.1973127-11-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106190337.1973127-1-hch@lst.de>
References: <20201106190337.1973127-1-hch@lst.de>
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
---
 drivers/block/nbd.c | 47 +++++++++++++++------------------------------
 1 file changed, 15 insertions(+), 32 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index eb8a5da48ad75a..327060e01ad58e 100644
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
@@ -1808,18 +1798,11 @@ static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
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
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
