Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB50C63699
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:06:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40FC622450
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G3DL9eUv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tNKy0A5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FC622450
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8pgZnvKeYFi7Mnzrv8kuZA9RpgiNR4hLehB8I5/1Gf0=; b=G3DL9eUvA/fsmOEm9SVGznWBo
	58POXx+xytGChxFy5um04H/a6hvUL8mG7CSaDcN+V/zh+4Hfp1cd2yuadetV2/Ln4zr7XziEigCEg
	Bj4z2nmXShb/w1ilCo8hIzV3cjIm77BXEAglz9zKQZiP2QnMgVLNiJBLzp6+fkMdO+1i0eFeR71Bv
	cXiriazWGw6Cv2HyhoYwnvpJDQVbBTVmvd/Q00JytIGV8i8awo9N2SrnnPHuPZ3WcJbCrADmrpoqn
	ASATcCEFuXRnyS5UPkHuOljvRVnJW2afLwOSxVcUl73ZPRmeRbmhVW0KC3WyZ880x46Hw5rAGVHca
	FFFAdjzyw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keg4y-0000VC-OP; Mon, 16 Nov 2020 15:06:04 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyD-0003gu-7g
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:59:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=j9YzX4Imfj42oekp8Tth+LQoKAxJAOk+J48Ms5WWyRs=; b=tNKy0A5I0JGyRwszKo8CS5i8OD
 +8V953YfFx3Xman6sQ8F42cjnDZ+fEMnGq+5JSKyBoWRq84B0ROGouApW++jZ44y6feigXqLuqKsR
 cxqh2lFOkiVIegiphp90kij1qmc1NDslqQZNsGbC21VOg69MDd/n08QOAs5NDSIePC2uZIeQod82Z
 T6wB+Z9xXg1/0NZKtWCv5t7lkIbvOb2buar5vD5Qry8bhovOugY2M7SSd4S16Dl+mklfVYWbkqbny
 8IY3ZaEc9JVI0kFlBfL2Zv+6ubgx5Kd03xor/wsERRQOPm0Gj4ArtdUOT7w0cJYRw8cIK/bIaVXYw
 0ktG/eKQ==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyB-0003xB-Ni; Mon, 16 Nov 2020 14:59:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 38/78] block: rework requesting modules for unclaimed devices
Date: Mon, 16 Nov 2020 15:57:29 +0100
Message-Id: <20201116145809.410558-39-hch@lst.de>
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

Instead of reusing the ranges in bdev_map, add a new helper that is
called if no ranges was found.  This is a first step to unpeel and
eventually remove the complex ranges structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/genhd.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 2a20372756625e..8391e7d83a6920 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1028,6 +1028,13 @@ static ssize_t disk_badblocks_store(struct device *dev,
 	return badblocks_store(disk->bb, page, len, 0);
 }
 
+static void request_gendisk_module(dev_t devt)
+{
+	if (request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt)) > 0)
+		/* Make old-style 2.4 aliases work */
+		request_module("block-major-%d", MAJOR(devt));
+}
+
 static struct gendisk *lookup_gendisk(dev_t dev, int *partno)
 {
 	struct kobject *kobj;
@@ -1052,6 +1059,14 @@ static struct gendisk *lookup_gendisk(dev_t dev, int *partno)
 		probe = p->probe;
 		best = p->range - 1;
 		*partno = dev - p->dev;
+
+		if (!probe) {
+			mutex_unlock(&bdev_map_lock);
+			module_put(owner);
+			request_gendisk_module(dev);
+			goto retry;
+		}
+
 		if (p->lock && p->lock(dev, data) < 0) {
 			module_put(owner);
 			continue;
@@ -1290,15 +1305,6 @@ static const struct seq_operations partitions_op = {
 };
 #endif
 
-
-static struct kobject *base_probe(dev_t devt, int *partno, void *data)
-{
-	if (request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt)) > 0)
-		/* Make old-style 2.4 aliases work */
-		request_module("block-major-%d", MAJOR(devt));
-	return NULL;
-}
-
 static void bdev_map_init(void)
 {
 	struct bdev_map *base;
@@ -1310,7 +1316,6 @@ static void bdev_map_init(void)
 
 	base->dev = 1;
 	base->range = ~0 ;
-	base->probe = base_probe;
 	for (i = 0; i < 255; i++)
 		bdev_map[i] = base;
 }
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
