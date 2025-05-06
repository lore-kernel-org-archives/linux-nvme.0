Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED9AC3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 02:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jiE29MBG2KEnpFsMiinXGKq0To9lV06TDg9RCtNvoYY=; b=SC7TYbtpF3r5MHrGLJGMCS96xD
	8CO+yVColXmWoGok5M0P+Za88LaUZLy4Ia2/Y7yUbnX0dOoY1zd7/JuLBudOK6MHXIDkzDmHWveig
	/i9ucEhz7kg01XUkyVMR3Kep553dJtrxaZbWGvVuOYG70UhusO7igtN/SBW2PXxlB4PQJlbtVnR32
	H2Xdfas6lvgbdc7vnVQMIAHyy7Iec8qTepyKsEVtC2XlvbpQRov/uXnDkgdx5egCsDQAj3Le+WBKV
	1i71WO/aj8GaBGo2oSUsCEI7Msc+2nzCYA82LmQMXoEhPU/gFMefkBTCEnkaYm/BFj4njCRuBsjff
	rRBNjqUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCUcK-0000000DxXz-2dwV;
	Wed, 07 May 2025 02:34:40 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCPyN-0000000DRNS-2SAg
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 21:37:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CF5ADA4C3BB;
	Tue,  6 May 2025 21:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D68C4CEEE;
	Tue,  6 May 2025 21:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746567426;
	bh=xcjlLSgn1Tt/P9DMlCgwzZshykWA3CEBFvuoEeQscz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5RxwrddDrS3vrU6vVChYh4xdeIAb/HLFFzau9osfjDKM6esIeC0nnB0oxW0GEVoM
	 mkArZPhEMz1MsDqZYp6cz44q2hogOXHDMRk7UtNqyblZT7L5GuemzFfMF16+w3cqbc
	 gEBZoQAOPUjkSpLPffvYkqCh0DIh+soad9N0L1MHyhqqgs9JxfMtaH7k9xxGes9aow
	 DZNGFlBEjikzabor1xdVkEwLYnGbYkZzR609fky+/UuPOf4pkj5iIJsX1JtGRDmRUr
	 ktsayt2zVVPI6tZykWVY7PmOKr/2W0L+83PQm/O12kjQDuaG2Sy7zzcxOUZzBxgS/k
	 JYxlRhf8ul3pQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Wentao Guan <guanwentao@uniontech.com>,
	WangYuli <wangyuli@uniontech.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/12] nvme-pci: add quirks for device 126f:1001
Date: Tue,  6 May 2025 17:36:42 -0400
Message-Id: <20250506213647.2983356-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506213647.2983356-1-sashal@kernel.org>
References: <20250506213647.2983356-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_143707_687182_0BBEB04F 
X-CRM114-Status: GOOD (  11.68  )
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

From: Wentao Guan <guanwentao@uniontech.com>

[ Upstream commit 5b960f92ac3e5b4d7f60a506a6b6735eead1da01 ]

This commit adds NVME_QUIRK_NO_DEEPEST_PS and NVME_QUIRK_BOGUS_NID for
device [126f:1001].

It is similar to commit e89086c43f05 ("drivers/nvme: Add quirks for
device 126f:2262")

Diff is according the dmesg, use NVME_QUIRK_IGNORE_DEV_SUBNQN.

dmesg | grep -i nvme0:
  nvme nvme0: pci function 0000:01:00.0
  nvme nvme0: missing or invalid SUBNQN field.
  nvme nvme0: 12/0/0 default/read/poll queues

Link:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e89086c43f0500bc7c4ce225495b73b8ce234c1f
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a763df0200ab4..8eee28282b1e9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3427,6 +3427,9 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1217, 0x8760), /* O2 Micro 64GB Steam Deck */
 		.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },
+	{ PCI_DEVICE(0x126f, 0x1001),	/* Silicon Motion generic */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_BOGUS_NID, },
-- 
2.39.5


