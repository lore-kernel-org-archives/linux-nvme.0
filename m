Return-Path: <SRS0=PT9J=YU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8080ECA9EAF
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Oct 2019 15:04:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E9B20873
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Oct 2019 15:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iUe/X93u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E9B20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CMrC/js+XrssRsajiDpkCMV7pUooBOQccT9HzKhQqMQ=; b=iUe/X93uBsdWln
	B77DMpGCTSCTAc91PAk/Dz1jxyeXGvX1vbCCvTZcDDXX/HwghweWgs9GEGaKlR0igxekEbYhp7GjO
	lA4gWVs6cpkihxaJlE3whINeYVesLPUiCutPIgIjIseeiGwRf1lPORQrMa9pTpaz1q7iVRfNLEpDW
	3V/seS5mL0ImBqiBRSSs0yILCYYXWw+XrXBZlXLxB6rbQQl0g142NRDeehjS8+q/Y9sj6v+nrbPki
	+vahSok419tjdRpzvBp6+UGmIRHYsZCs3i20NzW/ZPe1l0XFGDKskflivSoZmzk4kJHFe84vkD6aZ
	VUgNPHtY4Y7LyY0REY6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iOk50-000744-6R; Sun, 27 Oct 2019 15:03:42 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iOk4v-00073e-MK
 for linux-nvme@lists.infradead.org; Sun, 27 Oct 2019 15:03:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4714D68B05; Sun, 27 Oct 2019 16:03:31 +0100 (CET)
Date: Sun, 27 Oct 2019 16:03:30 +0100
From: "hch@lst.de" <hch@lst.de>
To: Mark Ruijter <MRuijter@onestopsystems.com>
Subject: Re: [PATCH] nvmet: introduce use_vfs ns-attr
Message-ID: <20191027150330.GA5843@lst.de>
References: <20191023201715.4236-1-chaitanya.kulkarni@wdc.com>
 <20191024020003.GA2148@redsun51.ssa.fujisawa.hgst.com>
 <FA6B6A9F-649B-4B58-99D0-2D09076E2482@onestopsystems.com>
 <20191025040540.GA19941@redsun51.ssa.fujisawa.hgst.com>
 <20191025042658.GB19941@redsun51.ssa.fujisawa.hgst.com>
 <109617B2-CC73-4CDE-B97A-FDDB12CD22BD@onestopsystems.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <109617B2-CC73-4CDE-B97A-FDDB12CD22BD@onestopsystems.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191027_080338_030717_293299E9 
X-CRM114-Status: GOOD (  21.09  )
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
Cc: Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Oct 25, 2019 at 08:44:00AM +0000, Mark Ruijter wrote:
> 
> Hi Keith,
> 
> I am indeed not using buffered io.
> Using the VFS increases my 4k random write performance from 200K to 650K when using raid1. 
> So the difference is huge and becomes more significant when the underlying drives or raid0 can handle more iops.

Can you try the patch below to use block layer plugging in nvmet?  That
should be the only major difference in how we do I/O.

> 1. Currently a controller id collision can occur when using a clustered HA setup. See this message:
> >>> [1122789.054677] nvme nvme1: Duplicate cntlid 4 with nvme0, rejecting.
> 
> The controller ID is currently hard wired.
> 
>        ret = ida_simple_get(&cntlid_ida,
>                              NVME_CNTLID_MIN, NVME_CNTLID_MAX,
>                              GFP_KERNEL);
> 
> So two nodes exporting the exact same volume using the same port configuration can easily come up with the same controller id.
> I would like to propose to make it configurable, but with the current logic setting a default.
> SCST for example allows manual target id selection for this reason.

We can allow some control there using a new configfs file.  But what
would be even better is an actually integrated cluster manager, which
we'd need to support features such as persistent reservations.

> 2. The Model of the drives has been hard wired to Linux. As I see it this should be configurable with 'Linux' as default value.
> I'll provide code that makes that work.

Yes, please send a patch.

> 3. A NVMEoF connected disk on the initiator seems to queue forever when the target dies.
> It would be nice if we had the ability to select either 'queue foreever' or 'failfast'.

Making this configurable has been a long time todo list item.  At some
point in the past Hannes (added to Cc) signed up for it, but it seems
to have dropped off his priority list.

---
From 87ab0d6f9e092cde04775452131f90e8b4c46a66 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Sun, 27 Oct 2019 15:59:08 +0100
Subject: nvmet: use block layer plugging in nvmet_bdev_execute_rw

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 04a9cd2a2604..ed1a8d0ab30e 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -147,6 +147,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	int sg_cnt = req->sg_cnt;
 	struct bio *bio;
 	struct scatterlist *sg;
+	struct blk_plug plug;
 	sector_t sector;
 	int op, op_flags = 0, i;
 
@@ -185,6 +186,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	bio->bi_end_io = nvmet_bio_done;
 	bio_set_op_attrs(bio, op, op_flags);
 
+	blk_start_plug(&plug);
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
 				!= sg->length) {
@@ -202,6 +204,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		sector += sg->length >> 9;
 		sg_cnt--;
 	}
+	blk_finish_plug(&plug);
 
 	submit_bio(bio);
 }
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
