Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160A3C17440
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 20:55:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4DF821925
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 20:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d9yD4n4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4DF821925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hasenleithner.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uj4RqmA6m31alIIEdqDeNM3YxunWxF1LaRhVgGGPIFU=; b=d9yD4n4HnmYsqe
	avRh9GGhNLvnemHYUt0znXPna6W+CJ4ruPiU+5KRq+TSVNRw56XKlq/5qurmAKkLR+xMQu4grE6Kb
	odfYGsAnJr+UXeNQdyoPBvo2ZS9uXZlTiODM6ZUWSqVuczBOzRQxkL1u+i4TpFY3xcLNRnFKbl5RV
	8EtTrNpYhgNkU2VYtskoRNQ8dj+Bi75oYt4XMCrUkF36egXE5ipNCli16/RNE0GPhoLNOIHm9aZ1L
	MqXNocVg7YiJCtwnsGANYtHBB9vIR1O8vqxMxs5BS9Hh8MnRcrgNGaBuXarvmUFrKwrqq0/JMXW6G
	vt+r54AT5wAN95RIqcQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUdBt-0006LD-Qu; Tue, 12 Nov 2019 20:55:09 +0000
Received: from hodge.hasenleithner.at ([88.99.36.100])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUdBp-0006KL-Vh
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 20:55:07 +0000
Received: from [IPv6:2001:470:584d::10] (unknown [IPv6:2001:470:584d::10])
 by hodge.hasenleithner.at (Postfix) with ESMTPSA id DDC8C7600D1;
 Tue, 12 Nov 2019 21:55:01 +0100 (CET)
From: Eduard Hasenleithner <eduard@hasenleithner.at>
To: linux-nvme@lists.infradead.org
Subject: [PATCHv4] Workaround for discard on non-conformant nvme devices
Message-ID: <0f86cf43-f9c5-2b03-e9f2-e769abdfd35b@hasenleithner.at>
Date: Tue, 12 Nov 2019 21:55:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_125506_172536_9C55AF24 
X-CRM114-Status: GOOD (  12.89  )
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

As documented in https://bugzilla.kernel.org/show_bug.cgi?id=202665 there are lots of Linux nvme users which get IO-MMU related errors when performing discard on nvme. So far analysis suggests that the errors are caused by non-conformant nvme devices which are reading beyond the end of the buffer containing the segments to be discarded.

Until now two different variants of this behavior have been observed: SM22XX controllers round up the read size to a multiple of 512 bytes. Phison (E12) are found to unconditionally read the maximum amount of discard segment data allowed by the spec (256 segments or 4kB). In case the start address of the buffer is not aligned (512B or 4kB) and the actual data fits in the remainder of the buffer page it may cause the controller to read a page which is not mapped on IO-MMU.

The patch changes the nvme_setup_discard function to unconditionally allocate memory for a segment array of maximum size (256 segments). This prevents the nvme from reading beyond the end of the IO-MMU mapped buffer.

Signed-off-by: Eduard Hasenleithner <eduard@hasenleithner.at>

--- linux-5.3.7/drivers/nvme/host/core.c.orig	2019-11-12 20:42:16.394800789 +0100
+++ linux-5.3.7/drivers/nvme/host/core.c	2019-11-12 21:23:07.635266361 +0100
@@ -555,15 +555,22 @@ static inline void nvme_setup_flush(stru
 	cmnd->common.nsid = cpu_to_le32(ns->head->ns_id);
 }
 
+#define DSM_SEGMENTS_MAX 256
+
 static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmnd)
 {
 	unsigned short segments = blk_rq_nr_discard_segments(req), n = 0;
 	struct nvme_dsm_range *range;
 	struct bio *bio;
+	/* Some devices do not consider the DSM 'Number of Ranges'
+	 * field when determining how much data to DMA. Always allocate
+	 * memory for maximum number of segments to prevent device
+	 * reading beyond end of buffer. */
+	static const size_t alloc_size = sizeof *range * DSM_SEGMENTS_MAX;
 
-	range = kmalloc_array(segments, sizeof(*range),
-				GFP_ATOMIC | __GFP_NOWARN);
+	WARN_ON(segments > DSM_SEGMENTS_MAX);
+	range = kzalloc(alloc_size, GFP_ATOMIC | __GFP_NOWARN);
 	if (!range) {
 		/*
 		 * If we fail allocation our range, fallback to the controller
@@ -603,7 +610,7 @@ static blk_status_t nvme_setup_discard(s
 
 	req->special_vec.bv_page = virt_to_page(range);
 	req->special_vec.bv_offset = offset_in_page(range);
-	req->special_vec.bv_len = sizeof(*range) * segments;
+	req->special_vec.bv_len = alloc_size;
 	req->rq_flags |= RQF_SPECIAL_PAYLOAD;
 
 	return BLK_STS_OK;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
