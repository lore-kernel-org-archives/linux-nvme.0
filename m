Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32651C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 05:11:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB6321D79
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 05:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB6321D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sP621EdieohlYIDjsYqbTOHxW01FeUL+KzNpwTV9DEk=; b=sFdlttFbG6qk5J8dAWfT6WZEV
	cGD8f8+7uG1BSFYL1zfWBZLWAW9OYXbowMKoypLAolrSYsHvAhKJ7n1eiog1ZEd0IKt+UNR0H3oLi
	1kIj7A6L5BhvJamrwxYdHHqUEpUzZ1EFHqIIHgurzIw+N4UXnnEjgZIDehsk6O+O4mGd1x0EdkcLi
	EmViy98nCrkroVTxIqpWza979+vD5ClRbZ9937Ooo7qoFvYqzKSqW88a88JNcjqn3Bn3XSzBCUzIb
	2RwGvF5GZvV56ulQc+af6eDlY1yVusJ3XrGuboBX2r+6ZYl+lHyyaPhcn36OEWL1J5c6hMFBCeuGj
	z/nBfY75A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwI97-0003HH-72; Mon, 04 Jan 2021 05:11:09 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwI8z-0003EA-VG
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 05:11:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1609737738; x=1641273738;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qwXyOBMpSjhNvMX3TuA4Swa6BZth8f79ppVgwTS1V1A=;
 b=qOT/28fC22lCBvCBASz1A98m5ITFSHIKwUf0v8/JTeD1QCJDhc1zYfRv
 DqGcUPJlC7VeRgFi467oP+1SQoqfFRPMOO3ffKZOjXaqCGe+/r+7i2eJd
 IMXU0BcKEZY3Kxqs8L7weXjgYFMw1CbzmyIxvSn7k2zX/+Py8n9BOepwf
 g+oCIHZfc+/j+M/N5sCYZxij2xVGOwDJNDtquYwdSq4GAqhv81MpCACnG
 4DpqbrDEuIqB11/XSChnEBzVPMB/N/Z83K6wYfhUl7G8WCG5aqlZP/m96
 Bj1vH9IAeQdpBaEcvyJrKi3fF12nw1c0rJlhVLXPtqTrBZ+S5JjqHXfKx g==;
IronPort-SDR: 7QvGZzf8kFToNFE/nwQwanQRt3iEyhdE8AKSjmcS7CFW/sMFgAfln5nxPvAAXiIbsGUlGBAlaK
 LiAZZMGWtelHq902ygDLlFqGqgZzFq/k/Y/MSc+UbROtCe6TYIkTOqcn48OpJ15uDlOO8+68MI
 AFNG+Gl3Tx+E8GkZTrZWf+bTfozOWc6kGvBoMj/4mCL4GfbUOg0BP+f52Ko3cW3wwguS30/BBA
 4+6mdM3xtYaxYaEV9dUA4ouHcbz0ILx5EALIzfU7d4AQ97Hsf1dGK1UtHkaPG3Bf7Rn2glSW7A
 rr8=
X-IronPort-AV: E=Sophos;i="5.78,473,1599494400"; d="scan'208";a="260321548"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jan 2021 13:22:17 +0800
IronPort-SDR: BnEUpVF3HN6PQn27J0UW1iYPAwoPsIVeYx3APnWAtqSVzcJf/Q8xEjCeouj4R0nMr9TmKdnugY
 50eV0H/ZSKZs/Me0DHJpUwEpCYsGO6hzsW3ZW/5PHNgy2QocRBxC6hk53jHqZT/LqUYXl/TstZ
 uDiXXBCn2YXDa/x1E62KnKCN8NkkXBVPWm50Bm5LYgatmlm0yr92OOZ0PFz1kfynMhoTKp6kjp
 PGLg8U8FvxxDUDvCWLE7YGZGa2Omypzf6SR5oL5N18ayYbbjr8apugrxHK/6At9AizVfkXhPDF
 PkvvMTXQ5hUnuVcfq+RJdXGk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2021 20:54:10 -0800
IronPort-SDR: Qs2Ws6SathLHE/zvV7u2GucAlk4qXW96sXoMKJrgmZS24gY/DC4ozow6/yb6kCo9JZFqwygXTW
 KdKOOsDVqU9zXNR8CgBgCsXYNVc2QAy4jxsGuhjNSiFI4iFZdfL5Jf3smUXh3amue6j3DJ4XJv
 lY4vBBIbO2WCIOtqRReG7BX81N2M/12oTygW3ilkYCKkH8jKhHdr/1mFtL6MDNPgeb9VHTsNtu
 vtmptVJ87z7lc+b9s6/2iHY8ZWeHsv6TmuwduJTZYBrGbMbpy12QuhfuDpgYL8aGLFH4KwNKfd
 r3Q=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jan 2021 21:11:02 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V8 9/9] nvmet: call nvmet_bio_done() for zone append
Date: Sun,  3 Jan 2021 21:09:38 -0800
Message-Id: <20210104050938.25745-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210104050938.25745-1-chaitanya.kulkarni@wdc.com>
References: <20210104050938.25745-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210104_001102_279395_88D7DB12 
X-CRM114-Status: GOOD (  13.34  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function nvmet_bdev_execute_zone_append() does exactly same thing
for completion of the bio that is done in the nvmet_bio_done(),
completing the request & calling nvmet_bio_put()_to put non online bio.

Export the function nvmet_bio_done() and use that in the
nvmet_bdev_execute_zone_append() for the request completion and bio
processing. Set the bio->private after the call to submit_bio_wait() to
nvmet request. The call to nvmet_bio_done() also updates error log page
via call to blk_to_nvme_status() from nvmet_bio_done().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 drivers/nvme/target/nvmet.h       |  1 +
 drivers/nvme/target/zns.c         | 10 ++++------
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index c23a719513b0..72a22351da2a 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -167,7 +167,7 @@ static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 	return status;
 }
 
-static void nvmet_bio_done(struct bio *bio)
+void nvmet_bio_done(struct bio *bio)
 {
 	struct nvmet_req *req = bio->bi_private;
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f4f9d622df0d..ab84ab75b952 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -535,6 +535,7 @@ void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
 void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
 int nvmet_file_ns_revalidate(struct nvmet_ns *ns);
 void nvmet_ns_revalidate(struct nvmet_ns *ns);
+void nvmet_bio_done(struct bio *bio);
 
 static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
 {
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 149bc8ce7010..da4be0231428 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -283,7 +283,6 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	struct request_queue *q = req->ns->bdev->bd_disk->queue;
 	unsigned int op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
 	unsigned int max_sects = queue_max_zone_append_sectors(q);
-	u16 status = NVME_SC_SUCCESS;
 	unsigned int total_len = 0;
 	struct scatterlist *sg;
 	int ret = 0, sg_cnt;
@@ -306,7 +305,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 
 		ret = bio_add_hw_page(q, bio, p, l, o, max_sects, &same_page);
 		if (ret != sg->length) {
-			status = NVME_SC_INTERNAL;
+			bio->bi_status = BLK_STS_IOERR;
 			goto out_bio_put;
 		}
 		if (same_page)
@@ -316,15 +315,14 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	}
 
 	if (total_len != nvmet_rw_data_len(req)) {
-		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		bio->bi_status = BLK_STS_IOERR;
 		goto out_bio_put;
 	}
 
 	ret = submit_bio_wait(bio);
 	req->cqe->result.u64 = nvmet_sect_to_lba(req->ns,
 						 bio->bi_iter.bi_sector);
-
 out_bio_put:
-	nvmet_req_bio_put(req, bio);
-	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL : status);
+	bio->bi_private = req;
+	nvmet_bio_done(bio);
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
