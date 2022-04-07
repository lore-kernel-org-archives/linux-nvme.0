Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753B6C433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 01:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sbwcMT3mU6SE6qbgdwEHPilcLOrINBYrYdqfEeBkBaA=; b=GparG4jppM6mwnhd1fQqLxmVLV
	oV1cNai5w4FSqfBtsLiXK3dhp8+7Ten4b+/Y9/fYp8oMZGoNNqzWzcG8fCCZsldgxbB9tBO6erMAM
	S1hmsv6c2hxWKbVAi6osVvJFrsg+ya/NO1iw1+MekznbAtPFSXCCJCRTJ/ckQXQ3T1+Y+7WwLpY/4
	XsP3REBJMYFE2V15gWKmYg+Yh3v3lTIkeke5LGUs3FdcyU0r/cNFMzPI88WakfI4jCc5k7IJ3c5Qh
	K03WduECpdBDJSlvzTYPy/n+w+H1/096gqbBTDzmFgWQA6fs5Ggd8c4qfuZjVUtn67CoNV4GQ3fsC
	dyGG0tRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncGhZ-008V7W-VW; Thu, 07 Apr 2022 01:12:46 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncGgv-008UfS-Uv
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 01:12:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 9022CB8268D;
 Thu,  7 Apr 2022 01:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2339DC385A7;
 Thu,  7 Apr 2022 01:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649293923;
 bh=yKyYHVZeUbRYReCQgBvc2qrRWwD3Cz7cLVDukRxXuOo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=p8Ie+3mOr6WemlUZ39zHw8kPtDKBFnhiCRVcd7yB6r0uFomhOMWAkOkhUL50l6jMd
 bkcfOMu24jW7GbhMyV0FK/mEJZ23TyBL2GcKb80Ly+kC1/27JUsUWlGy+F1elZSnqH
 OQ2M2xkRZVfgekw8/xq48OV2JI9TuNVmJb/aacEJ38w/7W9/YxNNDuA4btBY60wGWb
 rpmXruKLo3QvkrocjEZvOWPVnDZYPOqn03KBIZNiiFV0F9hR/CxTbxypGcHq3aUt06
 a7Z7DdEm14pn9HR0b0xQrB+nHRYNY9INQ81ev7XtaYf9qfn4Kqgp8eI6vGHQQbtGE4
 TF8dbmbHjPKzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Monish Kumar R <monish.kumar.r@intel.com>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, kbusch@kernel.org, axboe@fb.com,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.16 11/30] nvme-pci: add quirks for Samsung X5 SSDs
Date: Wed,  6 Apr 2022 21:11:21 -0400
Message-Id: <20220407011140.113856-11-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407011140.113856-1-sashal@kernel.org>
References: <20220407011140.113856-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_181206_180872_CD23C569 
X-CRM114-Status: GOOD (  13.89  )
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

From: Monish Kumar R <monish.kumar.r@intel.com>

[ Upstream commit bc360b0b1611566e1bd47384daf49af6a1c51837 ]

Add quirks to not fail the initialization and to have quick resume
latency after cold/warm reboot.

Signed-off-by: Monish Kumar R <monish.kumar.r@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 953ea3d5d4bf..84f6c116338a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3398,7 +3398,10 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_128_BYTES_SQES |
 				NVME_QUIRK_SHARED_TAGS |
 				NVME_QUIRK_SKIP_CID_GEN },
-
+	{ PCI_DEVICE(0x144d, 0xa808),   /* Samsung X5 */
+		.driver_data =  NVME_QUIRK_DELAY_BEFORE_CHK_RDY|
+				NVME_QUIRK_NO_DEEPEST_PS |
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ 0, }
 };
-- 
2.35.1


