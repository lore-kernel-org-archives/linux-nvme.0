Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39179FE520D
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 11:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=biJxR4k8rsxSyY8blZs5dP7xQ+oubsMpmF2rk0rTkb8=; b=IYoZLXS37wBKHzEKVkvUcuylKZ
	e/evCTHyHk082DJ6JCtdk6lHN0c/mxSZErr6OHfh7X8IVJPyZZznVxPZzvTatIKPCU4QL9L9u/DBP
	YI4b49JaZO4R0PMpziTBUtP1bNKqYFxOSlNqcB8CGbHU3sefShxV4fgos5G+3OwxsKzLebZgQXTLy
	utEwcpczLO5iXYLPsCLRLWQYTEOop8r2s5DXsUsOH5Sk2GlOZ681E4fA8FcJA89EYnhba2zYILiCd
	5FazmZ0AuEPzmA0Qdy/92tdwc6Je6l9q95Nhs7Bkzj2wDRu9WJB53yepJvvnRrrZ13OV7KxtQMhYM
	d6Z0KOfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGEra-0000000D8LR-0VCR;
	Fri, 24 Apr 2026 11:38:26 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGErW-0000000D8Jp-3gpZ
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 11:38:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C5CDE441A9;
	Fri, 24 Apr 2026 11:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA2B1C2BCB8;
	Fri, 24 Apr 2026 11:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777030701;
	bh=DyeHMsiA53Hg5qFneyAbch7hM4sTqy1Q2kOzjNNoSVs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AcULKuxXO0kW4nxweg42tbqzWYh8+yhBTx9zf3EslgfCYZ0LZ43Xpju/ysY7K1tT1
	 H+5WKyfz8yzwNChuIZ8yuDY+AYMQ6BzA/8rJPGfYIogmrfF2dIfRrd8CAtnj0HWokT
	 ZwrGf1Ih2oC5DzHxWPa29gxhtoJapLRUzZcJq51slqq/UWfm6R1i4RlKRJ8F9ZJLps
	 YrxJZ2rkn+vXh2abRiamYltZhxNS5car04inYiXtKyYQzTR8RLndkLVfFiXAvcKm1j
	 5P4zOzbnYuEl7uEUh4FusR2CHI9hZA/v9dGp2mnm5a8aKiW3VC44567iQLWSUvSZzM
	 B+X0UrTRlXB2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C314FE5209;
	Fri, 24 Apr 2026 11:38:21 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 24 Apr 2026 13:37:52 +0200
Subject: [PATCH RFC 2/5] nvme: Add CDQ data structures to host driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-jag-cdq-lkml-v1-2-d773343a717c@kernel.org>
References: <20260424-jag-cdq-lkml-v1-0-d773343a717c@kernel.org>
In-Reply-To: <20260424-jag-cdq-lkml-v1-0-d773343a717c@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=DyeHMsiA53Hg5qFneyAbch7hM4sTqy1Q2kOzjNNoSVs=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGnrVikL1ufBNaxO3jg3y3Fffg+8zf+zzw/B0
 P4HbfBBQDTamokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJp61YpAAoJELqXzVK3
 lkFPV4kL/0d5y27c0jUzAL+8oyMRSaia0vmNA+oFoLsBT8frQWdmpj2QI0FNzwgs5iW2L+PxQoy
 uLAlgCpABgAtn+4ya4fqJV3c/sZW14Fgvg6rKfU2NevWJftYVqiRiIfm61a4zwwCr+qhby2WhFN
 0GHodx3+LUgRCa/NVVGB5SoE1sYevG/IO8T9zpw10aUJ2x6CuO+b9Q/JScvqUAxq7gCx6y6YJ6x
 hoiLk5oXsP7USr164PHKFhntwcIPlYCFcI+7QiU8MIMu+z3JGxxaNbavNPJbAkulfKhCBaa4L7S
 FSZ0V1ikIBLK3gy0LwfYz7EI6nzDdP8gTQ0e0NZ9ZsCGc7R73xiUwZyz0Y32JYoPuOSPJqUSZvp
 lSBtM3Svfhk7r6IoL5/+KiV8IBctEvH63Jg6f/+8wEdCJXx81IA4GRpyYif4z80eyjgV/fNMuma
 +Amx+WANJbExznXr5EPSB6NzOFV7EmQv3hu9jy6nShqDzvtMe5Zf7/LE9uPIgZKOTj1lOip9a27
 m0=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_043822_978944_F370F29B 
X-CRM114-Status: GOOD (  10.51  )
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

Add host-side Controller Data Queue (CDQ) data structures and function
declarations to drivers/nvme/host/nvme.h:
- Add cdqs xarray to nvme_ctrl for managing CDQ instances
- Add cdq_nvme_queue structure containing:
  - DMA mapping state
  - PRP list management
  - eventfd context for tail pointer event notifications

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/nvme/host/nvme.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9971045dbc05e9bb9d7fa32ad540fd107d8c8b83..30d5052c7728c0d5c5e8772ff531bc672e96940f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -466,6 +466,7 @@ struct nvme_ctrl {
 	enum nvme_dctype dctype;
 
 	u16			awupf; /* 0's based value. */
+	struct xarray cdqs; /* Controller Data Queue */
 };
 
 static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
@@ -619,6 +620,20 @@ static inline unsigned long nvme_get_virt_boundary(struct nvme_ctrl *ctrl,
 	return NVME_CTRL_PAGE_SIZE - 1;
 }
 
+#define MAX_NR_CDQ_PRPS		20
+struct cdq_nvme_queue {
+	struct nvme_ctrl *ctrl;
+	__u32	size_nbyte;
+	u16 cdq_id;
+	struct eventfd_ctx *tpt_efd_ctx;
+	struct sg_table sgt;
+	struct page **pages;
+	unsigned long nr_pages;
+	void *prp_lists[MAX_NR_CDQ_PRPS];
+	dma_addr_t prp_lists_dma[MAX_NR_CDQ_PRPS];
+	u32 nr_prp_lists; /*number of PRP lists*/
+};
+
 struct nvme_ctrl_ops {
 	const char *name;
 	struct module *module;

-- 
2.50.1



