Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA043CD6E4A
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 10:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mLduu1BN8oVDlsMVXW9d1+2kTVCOlPEKY23vvFbWsFs=; b=DSeDIS9y3MGkohSpXwIipGm2O8
	VyzKOuA/MvZgHNcElFO1f05Pk26AOZu7hibPcJ/taGc2bIaSLqayUQfWpJw/xSNmgtBQimIw0tfMX
	Jd55JmZ/zQprqP0MIlWWAXocCpRh2usXUsZMoSF4O3RR/1Cg7fgm9mNxhyRsXI8LLCOQswCH91MBz
	0milnBuU9Bv8bEJc5YGG5EJtN8cCXUs4+C1Jz/YTAIYapPIQORzHF2NQ38oYb6TzhIfalYt2anKW6
	3BO1DCAJyClJG3n/gtT2mMF93NqZUMTwLG5TDdIu47vl1zVMPUjFWBtcSiC/GOTo9QXX3CDtfGrd9
	yeNsTtdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV5Du-0000000GZKI-1hKm;
	Thu, 04 Jun 2026 10:22:50 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV5Du-0000000GZK8-0dJR
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 10:22:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 67E5860219;
	Thu,  4 Jun 2026 10:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03D61F00893;
	Thu,  4 Jun 2026 10:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780568569;
	bh=mLduu1BN8oVDlsMVXW9d1+2kTVCOlPEKY23vvFbWsFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QIsGHYA0WcZE3oERGImpnuJVLx6AJq73KcO/q7CliE8Dn98sagksNM4BE5LaEAEjO
	 EZwBYc3p4tra7JCHhXHwNr0vf6sthuDgV9MwbMhggawYqGrnkUuhF9DN9OvjwRDIUQ
	 47d7dqDxFHPmX/GNRqJ5deQsn/+A8LVnQs6XqX23RWV8Zp141Hs5O4W3nN7dSiGwIl
	 iMHqEVmOBQrzZOfIKq6Smay+Ku+gZWs8cwnf1aiHB6dVjahlXbOqUtBQbGZFEkZW2I
	 AZibZ+pj/iNXwNAyVIkRm5NOkVIN/6gkyDTWwD/bdWjqO+JqhUeR75C27eFmlw+0D6
	 nzgoHmFtU4+dg==
Date: Thu, 4 Jun 2026 11:22:43 +0100
From: Keith Busch <kbusch@kernel.org>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] nvmet-rdma: reject inline data with a nonzero offset
Message-ID: <aiFR81yE9_BIsNbM@kbusch-mbp>
References: <LM21QIR-1-qJb7PViyJKCnGBnUzizeiNJVWQ3wb7ZwGezodjgKg3f-iobqOyequ-sT1jFCKJImfqNO_BKU3KO80xFITnaI5GTV_GxLUNDDc=@proton.me>
 <ahm6Ksr3rfGdnOsN@kbusch-mbp>
 <20260604084624.120032-1-hexlabsecurity@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604084624.120032-1-hexlabsecurity@proton.me>
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

On Thu, Jun 04, 2026 at 08:46:33AM +0000, Bryam Vargas wrote:
> It does stop the u64 overflow, but while testing it I found it is still
> incomplete when a port is configured with inline_data_size > PAGE_SIZE
> (it is settable up to max(SZ_16K, PAGE_SIZE)): an offset in
> (PAGE_SIZE, inline_data_size] passes that bound and then "PAGE_SIZE - off"
> in nvmet_rdma_use_inline_sg() underflows, leaving scatterlist::length at
> ~4 GiB pointing past the first inline page.

Then the use_inline_sg() should find the appropriate index and offset
accordingly.

---
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1234567..abcdefg 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -821,22 +821,29 @@ static void nvmet_rdma_use_inline_sg(struct nvmet_rdma_rsp *rsp, u32 len,
 		u64 off)
 {
-	int sg_count = num_pages(len);
+	u64 page_off = off % PAGE_SIZE;
+	u64 page_idx = off / PAGE_SIZE;
+	int sg_count = num_pages(page_off + len);
 	struct scatterlist *sg;
 	int i;
 
-	sg = rsp->cmd->inline_sg;
+	sg = &rsp->cmd->inline_sg[page_idx];
 	for (i = 0; i < sg_count; i++, sg++) {
 		if (i < sg_count - 1)
 			sg_unmark_end(sg);
 		else
 			sg_mark_end(sg);
-		sg->offset = off;
-		sg->length = min_t(int, len, PAGE_SIZE - off);
+		sg->offset = page_off;
+		sg->length = min_t(u64, len, PAGE_SIZE - page_off);
 		len -= sg->length;
-		if (!i)
-			off = 0;
+		page_off = 0;
 	}
 
-	rsp->req.sg = rsp->cmd->inline_sg;
+	rsp->req.sg = &rsp->cmd->inline_sg[page_idx];
 	rsp->req.sg_cnt = sg_count;
 }
 
@@ -857,7 +864,8 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
 			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
 
-	if (off + len > rsp->queue->dev->inline_data_size) {
+	if (off > rsp->queue->dev->inline_data_size ||
+	    len > rsp->queue->dev->inline_data_size - off) {
 		pr_err("invalid inline data offset!\n");
 		return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_DNR;
 	}
--

