Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FDDC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 14:32:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA21D23DC3
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 14:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JndlQUVK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GVQmRWlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA21D23DC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Hj3QPvXY6dFGsOuyQU1z6IoF//f30dnIAQD9uvkBmPs=; b=JndlQUVK66K9BM2Z+P+wSNqvQz
	1OfGh8Nm+LHstM2FD/6yqjRYLq/oNQLlOSHzN7sgVh8XvSETfLXklRITO82lmB5qHAZL6iFJTKc0E
	X3POu3Y7/8bRrGt1saibrX8C9ZKE1NTfR0gvLKJ5b8RhyHdLBHPMEctT+wxpOnNVvklhWc9dYQGQt
	iLwFDvC0XAD9YM5HRRQS07YaOFdWdNlUfj8o+0cIPVcInpDeCTjAcoB3J2lWZdQRWahNI+s0xEpFP
	9Uj867QlhE3GdzbUyHpdgNiJ+PkuhNy0FCeIgfJ96J0QOiDfHEBZ9zVMPMSUEiuCXm1ayuQObJOlX
	DdyVbfzQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpupd-000444-L3; Mon, 29 Jun 2020 14:32:25 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpupb-00043v-6W
 for linux-nvme@merlin.infradead.org; Mon, 29 Jun 2020 14:32:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=oEhyFzKTobxNdsT8qVm+tfi5iTPKHSszr9mRFz99B5k=; b=GVQmRWlEJ5SWgbftdzqfswnukV
 RMsgaNGIPfxUNMwVC5uik2cj1rOacgIpasqWIG/PfrULWSehwYS89VKOPh+96SKcUi8MxothrPpq1
 gqaut2Fv4O+zcOwpAT/3bvdiSELGjOuOkI+hOFPxbprbGssKjwKekqmx0W4g0oSjqwYMEKdKKb73/
 900lCxwKqpoRVtpBHKrSsguOnWdZVTOMB4RqBwjjQ5gny2TQuZUVzyE+cfQDji2RkHqqqlGXj6uGJ
 VYQw1i1Ey1YPii3zFozYXHQhneH2PjUUkP50Jl7R7ZH2n3pbwHPZZYZQtas+qpvl/l/0QJ0ChSa0E
 rjjP8ZzQ==;
Received: from [2001:4bb8:184:76e3:6bff:e1fc:8865:1ab0] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpupY-00014g-0z; Mon, 29 Jun 2020 14:32:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: sagi@grimberg.me,
	kbusch@kernel.org
Subject: [PATCH] nvme: fix a crash in nvme_mpath_add_disk
Date: Mon, 29 Jun 2020 16:32:19 +0200
Message-Id: <20200629143219.2693520-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
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
Cc: Avinash M N <Avinash.M.N@wdc.com>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For private namespaces ns->head_disk is NULL, so add a NULL check
before updating the BDI capabilities.

Fixes: b2ce4d90690b ("nvme-multipath: set bdi capabilities once")
Reported-by: Avinash M N <Avinash.M.N@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/multipath.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 18d084ed497ef3..e3eaff10444f00 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -672,10 +672,10 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 	}
 
 	if (bdi_cap_stable_pages_required(ns->queue->backing_dev_info)) {
-		struct backing_dev_info *info =
-					ns->head->disk->queue->backing_dev_info;
+		struct gendisk *disk = ns->head->disk;
 
-		info->capabilities |= BDI_CAP_STABLE_WRITES;
+		if (disk)
+			disk->queue->backing_dev_info |= BDI_CAP_STABLE_WRITES;
 	}
 }
 
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
