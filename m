Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DFAC021A4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2025 17:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EhaY44LabIRZbp1gFKZbV5ZkU6S68tdKwnnQCkN/Ysg=; b=Tu4nkWV+TlQfSAwj/9j4bVfrNg
	sPvSw9ZMJC3Z2X2ds+YkPScLtr9vqY3bA56qx4lmwb7xGTKKy12f1NMEanY2Cn+ydsIP2RT7lWLGw
	ntRV8z+9F/ir890TWDVF7WlOE/VFj607CRVEWXzEn42ynFnzECRWa3UlmHH7AMmLAvhb1wP/USH2B
	0w3EJ7F+QxI9mOXG2/TF6m6MingXiINWwWY5yRjTFM7OXLUD1FeopcQ+spWHYGeGTn6AAFGDHnfzX
	apr78mfbkKa+B3rnQO2vWwSWW60YD7wxOHMckA9M24cFReyqCE7YAfN4jTMzB+3ZxOhXsJN7pDSj+
	k7n8NLtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiGKH-00000008H57-0Raa;
	Wed, 12 Feb 2025 17:15:05 +0000
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiGAg-00000008DK4-2Nec
	for linux-nvme@lists.infradead.org;
	Wed, 12 Feb 2025 17:05:12 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1739379905; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XzIdDMmlQvd+7eqBZ48Ft6NFDObvfGC3Be/pMeDmAHLPoCZJGXVUw97X39UEEAiRrblYMg9eWQxWtGxx8O+AOY7du8of9Rb7iiopL+no7EDmhp/ei/Iwodm+YTmrTV6TYBr/KeYfR9PvUHuI9Rf9HEr+EX4+uC+9W6LQrxfUG1s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739379905; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EhaY44LabIRZbp1gFKZbV5ZkU6S68tdKwnnQCkN/Ysg=; 
	b=Q6hdsqLSw2EQ8IoXJFpXGiIyLVC6ufy+1fbbE0nOhSS9xbF7jam4O4R/MEDsdQFi4qs5MuOVtefWGgWbtg65f2E+CfCbxSffeN6MLw6NKh3bI+beQJrfn0nLzjn0CzEZkIYsWs74w34oZI4jGGWc53o6ppxEMNQ36bUkw6iKBk4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739379905;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EhaY44LabIRZbp1gFKZbV5ZkU6S68tdKwnnQCkN/Ysg=;
	b=qHWlJLzgnc9QMfKFDayNYxao2HW5JMbJuKDS1DFJa3ffaak9qasaCWlhv0RcSBXQ
	3oETqjpXidQyELvC8sc4Kv6ckCR5CtA+OpUkiGob0VzTWXaSF++VcCoqtlrnIRXlz+6
	m0nLTPfPTBKEB/XAd+xXfF51zWFMEpclkGlnwGCBF+Htit8Wl6j2AOut7qWo1HyTVVW
	no1hkY7wzQcKlDHBsY515YGGoL551gwJwxOsJt3z3EKjdktHTGLoUElNfbYKL2Bo92m
	gQ651RY/FaucuTgXU7Jy2ofel++q52NOhkhUr1W5Wp+ZuObrYuohrl9EWTtudbKhVkh
	Vbv3G5QxAg==
Received: by mx.zohomail.com with SMTPS id 1739379903389217.33151028331645;
	Wed, 12 Feb 2025 09:05:03 -0800 (PST)
From: Icenowy Zheng <uwu@icenowy.me>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 0/2] Misc fixes on registering PCI NVMe CMB
Date: Thu, 13 Feb 2025 01:04:42 +0800
Message-ID: <20250212170444.16138-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_090510_686622_EBB1A961 
X-CRM114-Status: UNSURE (   9.97  )
X-CRM114-Notice: Please train this message.
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

Here is a small patchset that is developed during my investigation of
a WARNING in my boot kernel log (AMD EPYC 7K62 CPU + Intel DC D4502
SSD), which is because of the SSD's too-small CMB block (512KB only).

The first patch is a fix of the PCI DMA registration error handling
codepath, which is just a observation-based patch (because my disk is
only NVMe 1.2 compliant, and the register cleaned up here is only added
in NVMe 1.4).

The second patch really fixes the warning by testing the CMB block
against the memory hotplugging alignment requirement (which the CMB
block of my SSD surely cannot satisfy -- the alignment requirement is
usually 2M with SPAREMEM_VMEMMAP enabled and even larger in other cases).

Refer to commit 6acd7d5ef264 ("libnvdimm/namespace: Enforce
memremap_compat_align()") for a similar approach for NVDIMM subsystem.

Icenowy Zheng (2):
  nvme-pci: clean up CMBMSC when registering CMB fails
  nvme-pci: skip CMB blocks incompatible with PCI P2P DMA

 drivers/nvme/host/pci.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

-- 
2.48.1


