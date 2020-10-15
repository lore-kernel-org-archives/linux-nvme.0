Return-Path: <SRS0=wM/2=DW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFF7C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 18:36:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE672073A
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 18:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qfhQ0WJO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOA6f56P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE672073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7sRkxUKFkmC9iBbm2BPyaVyscBBJNPHu+BNg+QGQYMI=; b=qfhQ0WJOOwbjAbbiLGd5JpHJym
	sBG3MZ7d5uJP8MkFZj89IAehvacVkAm+gbNbH7D+cjLE7msh6A2JUeAkplhbs6oooy1A5FJO8H6X7
	p/zaQA6T/vW81DzI0/AbdnEGQdzBLMeGgEMlM/4p7VlXTzfvWR4O3MtEbfou9rGIMTDruGHrHw4MR
	lMajggsK+TdvMOF9Tc52AenL1aFxGaNvGjNId6We+sZrwZy+MgI7wAriK2B7rjC0rAXm9Ede0416u
	AOg6gF5ukqwiexXxtNiTm7I1qWbxSxzHIctBwACR/azfN+FDuAPdj4o1zya6dkYSt+Lehu+YlQ86c
	cHIF4VEw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kT87E-0007NA-Qd; Thu, 15 Oct 2020 18:36:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kT87B-0007MN-Ny
 for linux-nvme@lists.infradead.org; Thu, 15 Oct 2020 18:36:38 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 296B820878;
 Thu, 15 Oct 2020 18:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602786996;
 bh=0rAf1SYHP8QvCWGkrac76PIejHE89LP0dOH3AijOSng=;
 h=From:To:Cc:Subject:Date:From;
 b=GOA6f56P0SROiIksyJGmBqXZmn/r4yn3vQLHA+kOUjzq7EgM61kd4/VcfGVixcQfI
 dCFAAeeDxwBuJ0qzcikOgoDiM7T31BpZwdcflVuZObAS3mBhObuaXp5EczlXMvL+wi
 5Bek6K9ee+xMCxGazN1FFcx6VYRlmftUfoJ/vO6E=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Subject: [PATCHv2] nvme: use queuedata for nvme_req_qid
Date: Thu, 15 Oct 2020 11:36:29 -0700
Message-Id: <20201015183629.1424705-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201015_143637_865775_F2140C9B 
X-CRM114-Status: GOOD (  14.42  )
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
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The request's rq_disk isn't set for passthrough IO commands, so tracing
uses qid 0 for these which incorrectly decodes as an admin command. Use
the request_queue's queuedata instead since that value is always set for
the IO queues, and never set for the admin queue.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2

  Don't bother setting the rq_disk request parameter; use the existing
  queuedata criteria instead

 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e7c88b40f5bb..cc111136a981 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -176,7 +176,7 @@ static inline struct nvme_request *nvme_req(struct request *req)
 
 static inline u16 nvme_req_qid(struct request *req)
 {
-	if (!req->rq_disk)
+	if (!req->q->queuedata)
 		return 0;
 	return blk_mq_unique_tag_to_hwq(blk_mq_unique_tag(req)) + 1;
 }
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
