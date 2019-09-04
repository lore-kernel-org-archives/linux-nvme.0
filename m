Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA33C3A5A7
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 13:14:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F35512168B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 13:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VDcLSCYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35512168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8xiFSalQC6PXR4LZ9KWkLMxnjuwY0irAkZPEYRmCVK0=; b=VDcLSCYiYu8b7b
	sjPVQvHA2QX2VuOEZOz3tZhnZm8OA6kJKKhtvsPCkxqspSF7RfWEWQnw/6NtTqYFRqx8Z9V4trkqD
	ip/yGLctzRR2lzSyjfxMOagx5dmzk/ssZzyTKFEyzExuYBnN7J7CHl77XtsBgpvqzhHnJgznSnKin
	llSOPSSwd3ZRRpJQdYI3T0ys/fzLzH32ioBANQMf/e9xKb9VJK+7KPlRbwiZsjQaXCp5HnG/7bhcg
	UKo+qGvxg0zHyqq5aU9V3B/lX6LJjJfnhlUlIIXmdJXvqBSrWpo3O4wCS43Cxwb9SHQOpwoLjCh7H
	gvRWEXX9zolGkwjHDp4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5V7Y-0007Zz-6d; Wed, 04 Sep 2019 13:14:48 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i5V7X-0007Zq-1Q; Wed, 04 Sep 2019 13:14:47 +0000
Date: Wed, 4 Sep 2019 06:14:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: amit.engel@dell.com
Subject: Re: [PATCH] nvmet: fix a wrong error status returned in error log page
Message-ID: <20190904131447.GA9892@infradead.org>
References: <20190831185006.119748-1-amit.engel@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190831185006.119748-1-amit.engel@dell.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sorry for dropping the ball earlier..

> +	num_of_sgl_slots = do_div(req->data_len, sizeof(struct nvme_error_slot));

I don't think this does what you think it does.  do_div has a reall
odd calling convention where it returns the result of the division
in the first argument (despite that not beeing passd by reference,
thanks to being implemented as a macro), and returns the remainder
in the actual return value.

But I think the fix might actually be as simple as:


diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 4dc12ea52f23..543fb2a0c005 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -37,7 +37,6 @@ static void nvmet_execute_get_log_page_noop(struct nvmet_req *req)
 static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
-	u16 status = NVME_SC_SUCCESS;
 	unsigned long flags;
 	off_t offset = 0;
 	u64 slot;
@@ -47,9 +46,8 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
 	slot = ctrl->err_counter % NVMET_ERROR_LOG_SLOTS;
 
 	for (i = 0; i < NVMET_ERROR_LOG_SLOTS; i++) {
-		status = nvmet_copy_to_sgl(req, offset, &ctrl->slots[slot],
-				sizeof(struct nvme_error_slot));
-		if (status)
+		if (nvmet_copy_to_sgl(req, offset, &ctrl->slots[slot],
+				sizeof(struct nvme_error_slot)))
 			break;
 
 		if (slot == 0)
@@ -59,7 +57,7 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
 		offset += sizeof(struct nvme_error_slot);
 	}
 	spin_unlock_irqrestore(&ctrl->error_lock, flags);
-	nvmet_req_complete(req, status);
+	nvmet_req_complete(req, 0);
 }
 
 static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
