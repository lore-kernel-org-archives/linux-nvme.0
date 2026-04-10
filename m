Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7B1E9904A
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2026 07:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lWcwI7XVbwMpMMWFJCRGBr2iI+0OyEEwAssf/4kI+3E=; b=m6Pz9ALJ8LbRFpvef9/8pAw/tN
	aBDAK3caOoyMBaYrgOa53Emobw0w7rQjlDjgj2OlzGedKyNnn185x46p9e8jQUGz6yrnfEhBmcs+K
	04FDecWbKAN3I4CLuYFk9x3Y4YIINk94ieQJ6+J2NgOBkHwjvCLFVQwIeZkiGsQsHwyY244/Z2fl6
	rvZdfVDb23QBTB+Qaypm0k08PzQfzgp7iyupszaDI45GF9l1fUVFLW70zaxry1nVrS7BU77XtPZJ6
	4RU2UQLbkT7X9M4AvjPnKSPM1vQgIdPrslmLmaUbAQ958WnEMo0Rm2zShHGJa0lm7PMMsop4b4N1/
	sTOrcpvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6TM-0000000BlMG-43Pu;
	Fri, 10 Apr 2026 07:40:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6TJ-0000000BlId-0Rc0
	for linux-nvme@lists.infradead.org;
	Fri, 10 Apr 2026 07:40:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775806808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWcwI7XVbwMpMMWFJCRGBr2iI+0OyEEwAssf/4kI+3E=;
	b=NGMXy4g1/DK7U7RlnCC+H4mkN44d/qFUoCOK19t9hsKfAXurVXqOVUjdycT+DDe4VVxHCn
	ddOYZQavaUDsg0XYpOJcbsofgZ2HBbk0VYxHHsdkFR6iK75NYYBVvKDQ4vBhXtG5cy7/nS
	DM2FcZlOkBMTEBZJIFAAVHYLlv4Os0M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-z-1rl8oAPeGRG-hlO7cQ0A-1; Fri,
 10 Apr 2026 03:40:04 -0400
X-MC-Unique: z-1rl8oAPeGRG-hlO7cQ0A-1
X-Mimecast-MFC-AGG-ID: z-1rl8oAPeGRG-hlO7cQ0A_1775806802
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4ACF0180034A;
	Fri, 10 Apr 2026 07:40:02 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.170])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC2441800B7F;
	Fri, 10 Apr 2026 07:39:58 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mheyne@amazon.de,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@arkamax.eu,
	mkhalfella@purestorage.com,
	chaitanyak@nvidia.com,
	hare@kernel.org,
	hch@lst.de
Subject: [PATCH V3 8/8] nvme-core: warn on allocating admin tag set with existing queue
Date: Fri, 10 Apr 2026 09:39:24 +0200
Message-ID: <20260410073924.61078-9-mlombard@redhat.com>
In-Reply-To: <20260410073924.61078-1-mlombard@redhat.com>
References: <20260410073924.61078-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Oyz5ygiPTSOyo57c2ULwAprDaksZn5VJ-Smjld7a8_I_1775806802
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_004009_243368_A1367EFF 
X-CRM114-Status: GOOD (  12.17  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently, nvme_alloc_admin_tag_set() silently drops and releases
the existing admin_q if it called on a controller that already
had one (e.g., during a controller reset).

However, transport drivers should not be reallocating the admin tag
set and queue during a reset. Dropping the old queue and allocating
a new one destroys user-configured timeouts and may race against
nvme_admin_timeout_store()

Since all transport drivers are now expected to preserve the admin queue
across resets, calling nvme_alloc_admin_tag_set() when ctrl->admin_q
is already populated is a bug.

Remove the silent cleanup and replace it with a WARN_ON_ONCE() to
explicitly catch any transport drivers that violate this lifecycle rule

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3aa7b29d2a2..ae084373a79b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4884,12 +4884,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	if (ret)
 		return ret;
 
-	/*
-	 * If a previous admin queue exists (e.g., from before a reset),
-	 * put it now before allocating a new one to avoid orphaning it.
-	 */
-	if (ctrl->admin_q)
-		blk_put_queue(ctrl->admin_q);
+	WARN_ON_ONCE(ctrl->admin_q);
 
 	ctrl->admin_q = blk_mq_alloc_queue(set, &lim, NULL);
 	if (IS_ERR(ctrl->admin_q)) {
-- 
2.53.0


