Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D69FC388F2
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:05:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A359B20882
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U8tizFfT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WIWq3qlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A359B20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Je7N9qQuG2Zj8u1b1oKVr08nfYOB2E5a1/8PcAHPOCE=; b=U8tizFfT6txcliHn3ao6na3Tc
	151d/L9wkniApDbdAkTV+TDPeucDPB6GX80h2MAIcW7S110odWVthGBfrKd8KLyiwjbtZq65K+qsI
	ybKIelQ7jtHQTA4PyR1sMo3dth2N7g+LVZNXg8gN/W4K/RpZFvb4Pj4BoJDiYwM5uBvauaMqfr1wy
	oAxSq/vWAmF7RZymBdbs1BvBCzJ3+QlcEXKMaIMJsThB67xiMkeKCaaW7kSsiQ9YuRGclgom2oap3
	dNJFm1LP0laN/If9AmwUuGZAchCokmC/cY06podvE9S9nnSVFBN3921QcziWKYVINXRSyOW7+PzuF
	jNLsCAj9Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb72v-0001j3-RX; Fri, 06 Nov 2020 19:05:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb724-0001EL-NF
 for linux-nvme@merlin.infradead.org; Fri, 06 Nov 2020 19:04:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=OzEVYDGpPhPKcdxmD06WYkOjTwHpY2TedHF0J0O+Oxs=; b=WIWq3qlg4S9I52R1ieKxa7C68n
 aUtvz/Z5VWPIixe1Jk0+iP74DUjRxGTZtczOqr2YZFiLvq0V49tmWt4Egw7piY18IH36MvoZkWHEt
 PEXXyAXapJgmVg+k6zZhVhBvhA8/MglHljbELD7NxRkbX9T5ONdSolc7glsQX2pPULh2BFtNXUSiB
 4S64nBsgEx2IPT2N8Aw5PojQzrUXaOJj9ljSBpygPZ+MvCfesSwKgolBafJYrmDDnT/lsCdBXfr9z
 7zQAfWzCCAKljC20Om2UuMm+cHGAPA54TVvos/MTzS9krZj+Wyhx49Kte2L0nUTmkA+/Fs96B8zhQ
 mbeUumNQ==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb720-0000zf-QY; Fri, 06 Nov 2020 19:04:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/24] nvme: use set_capacity_and_notify in
 nvme_set_queue_dying
Date: Fri,  6 Nov 2020 20:03:27 +0100
Message-Id: <20201106190337.1973127-16-hch@lst.de>
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

Use the block layer helper to update both the disk and block device
sizes.  Contrary to the name no notification is sent in this case,
as a size 0 is special cased.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index aa6e27c2eec945..223c681d774a6f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -93,16 +93,6 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 
-static void nvme_update_bdev_size(struct gendisk *disk)
-{
-	struct block_device *bdev = bdget_disk(disk, 0);
-
-	if (bdev) {
-		bd_set_nr_sectors(bdev, get_capacity(disk));
-		bdput(bdev);
-	}
-}
-
 /*
  * Prepare a queue for teardown.
  *
@@ -119,8 +109,7 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 	blk_set_queue_dying(ns->queue);
 	blk_mq_unquiesce_queue(ns->queue);
 
-	set_capacity(ns->disk, 0);
-	nvme_update_bdev_size(ns->disk);
+	set_capacity_and_notify(ns->disk, 0);
 }
 
 static void nvme_queue_scan(struct nvme_ctrl *ctrl)
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
