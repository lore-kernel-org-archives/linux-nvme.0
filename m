Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BF1C282EC
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Mar 2025 10:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DtKuJQ06qfII3rTqmqh1wamz/AJqIFW3YQSyMwSTH+s=; b=vhw6abkXvt8TmH06e3NgJk/aNB
	bKL6x/zliHW8z/N+UVacVpZ9PuDqb7vJ85mCk8LIoBF8xNnQyD9cYjbUs4+NXZGlyjldVjm74mGKc
	mHAbMSc/vAvPlMRnQ1fr/Y4Cn1EDaisi1sXJ9FTf6krLgMjotPzR3pMZWk6FYTtZD83422P+IFPmT
	IxN0DGXXok76Pj7vnw0yDGRlaDXTOzIM735jcw3TBQu7df0xhonrc2F6GpwihIvwrSD1qfJMdNJiK
	Wfn10v+hIYRPyk9WEg4Plqn0X8zM+5vbNlJxGnRjw6Z0oYkxhME79DMFsYgs91N/sorMpGgJukRTW
	PFK/7oyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tt1tP-0000000DlYI-2LzA;
	Fri, 14 Mar 2025 10:03:51 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tt1ol-0000000Dkjc-2f3R
	for linux-nvme@lists.infradead.org;
	Fri, 14 Mar 2025 09:59:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1751EA4424C;
	Fri, 14 Mar 2025 09:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512D1C4CEE3;
	Fri, 14 Mar 2025 09:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741946342;
	bh=yea/BXMxYHePRngsHLeT3CbZYvxN+tCHbKAXMRReTsY=;
	h=From:To:Cc:Subject:Date:From;
	b=IUgkGVboqHzShk3fMhTq/lcMZN9gUC8lq6SB7MVa20fgzfUgy1ARf3ypj915HnDJg
	 HWgbAxxpqrKNiBe+qDAF5WTJcVpEG6WUbY+l3g0MbDF1lRItbP+ZhACzF1wNthy9QT
	 gVmrIFrNpvezikCrCNCDqq7d7Be1qWwT+OwoME7/TCldSnltqD76LdhXwFvmYdVMeI
	 w3sTTfV1tGHz++M61R+2YpUNlKhpofAqqxozGF44tv2n1H+qUg2mRhQ4vf+6oYVUDk
	 GfquJS7EPfOnQ0UGHOoCrfniWb8mergb6zGrJP6xuTJonp8/v98o2NlbJk2CUX98+H
	 jvjX0W4ciAj8Q==
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: pci-epf: Always configure BAR0 as 64-bit
Date: Fri, 14 Mar 2025 10:58:58 +0100
Message-ID: <20250314095858.1604764-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1988; i=cassel@kernel.org; h=from:subject; bh=yea/BXMxYHePRngsHLeT3CbZYvxN+tCHbKAXMRReTsY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIv/31UZpGdbbI5uODSe7u0cJYTq+e5a9ju2ZC/gTPc/ LZR0euajlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEykpYnhN+tGgQvx7kn3dNUb 1il8DPxQo8BfMHNVXuo32TfSgjtdZjMybKy04bmXvo7/8knD5n8x4u5rrR+m2VxNWjOjyP1sUFI XHwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250314_025903_736543_B9F66DA3 
X-CRM114-Status: GOOD (  13.81  )
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

NVMe PCIe Transport Specification 1.1, section 2.1.10, claims that the
BAR0 type is Implementation Specific.

However, in NVMe 1.1, the type is required to be 64-bit.

Thus, to make our PCI EPF work on as many host systems as possible,
always configure the BAR0 type to be 64-bit.

In the rare case that the underlying PCI EPC does not support configuring
BAR0 as 64-bit, the call to pci_epc_set_bar() will fail, and we will
return a failure back to the user.

This should not be a problem, as most PCI EPCs support configuring a BAR
as 64-bit (and those EPCs with .only_64bit set to true in epc_features
only support configuring the BAR as 64-bit).

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Hello Damien,

please test on your platforms as well.

I think this is the way to go, as most real NVMe drives in the wild have
BAR0 as a 64-bit BAR.

 drivers/nvme/target/pci-epf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 0136df45ca275..a24f6549c0d15 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2096,8 +2096,15 @@ static int nvmet_pci_epf_configure_bar(struct nvmet_pci_epf *nvme_epf)
 		return -ENODEV;
 	}
 
-	if (epc_features->bar[BAR_0].only_64bit)
-		epf->bar[BAR_0].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+	/*
+	 * While NVMe PCIe Transport Specification 1.1, section 2.1.10, claims
+	 * that the BAR0 type is Implementation Specific, in NVMe 1.1, the type
+	 * is required to be 64-bit. Thus, for interoperability, always set the
+	 * type to 64-bit. In the rare case that the PCI EPC does not support
+	 * configuring BAR0 as 64-bit, the call to pci_epc_set_bar() will fail,
+	 * and we will return failure back to the user.
+	 */
+	epf->bar[BAR_0].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
 
 	/*
 	 * Calculate the size of the register bar: NVMe registers first with
-- 
2.48.1


