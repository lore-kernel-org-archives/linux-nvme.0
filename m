Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42933C369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MkCRChhBamrkRdmp+0D7uM2HbSwlsnt88vQHFefViCk=; b=ZYv2tptGrfYyF/e7zc3iqGKw3m
	PQpvgpwuFappoHnn+nxCQr0ngWXufUopjQCe+m4N1DQgulgif3I0zJNfJFdyeJfHIvVlcI4dNWQBr
	l1amfpkoPdUfhoiRWZhcn+sDHXnjuoV9dzX7GEcyustx3O8owprCLP/JJFeaIodsxO7sQfPipi6bh
	JAzt1qE7vKPMi5wWSeqTXEPLMLV8FyEkzUTcl2Axc0zCW33Sb9A5En2N2IplgZs7RXUWzHLLbJ2w9
	BXD5wsmgjto4jzt2s/oKfixU+5TqiCrH2+hvYYU33j9FeErLjDHHyOqQ6Z3uKwYtkL35hyJ7KFsqL
	2iErwPXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4L1j-00000002RUL-2YyH;
	Mon, 14 Apr 2025 14:43:11 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Jtt-000000029PV-0VYC
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:31:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0532EA40E75;
	Mon, 14 Apr 2025 13:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E856FC4CEEB;
	Mon, 14 Apr 2025 13:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637460;
	bh=JiNGGLDvkpSf69DH9x7QcroMSUkNyxMbco3HquxO5Qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbfKHNCjBHDfi5sbg8qo0Zo9hX2HyUXHvE+O/RyzEFniCC60WN0IE/ONfZq3Bhdq5
	 9P9p9CINyqwoh76PbxOydDhy6da2CzYGc8mnPii6p6OTxHbDAqhrHLseA18bfvrUAm
	 +K9IypQReCwZtW6hHjR4v6uR375xaZtnceJ360XmOyR4Xgns+uwyLmPNVl+azXNrsx
	 SIYpyc9kfhHn0sfrcv3/YV4SFcoPD4TrK7/dO/ZKDCE+Jk04k9ppGqn0pBP55dVEdp
	 dMfxCpKYhTSZEmN6JD7lYAnd+mS3dbk6J/jolK/4QpRcHQYW0F8Bw9D4OAAE8jNmNq
	 Fk6tSRjWN4fSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 05/17] nvme: requeue namespace scan on missed AENs
Date: Mon, 14 Apr 2025 09:30:36 -0400
Message-Id: <20250414133048.680608-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133048.680608-1-sashal@kernel.org>
References: <20250414133048.680608-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.134
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_063101_235777_AB27B0D0 
X-CRM114-Status: GOOD (  12.10  )
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

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 9546ad1a9bda7362492114f5866b95b0ac4a100e ]

Scanning for namespaces can take some time, so if the target is
reconfigured while the scan is running we may miss a Attached Namespace
Attribute Changed AEN.

Check if the NVME_AER_NOTICE_NS_CHANGED bit is set once the scan has
finished, and requeue scanning to pick up any missed change.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6a636fe6506b4..ec73ec1cf0ff5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4704,6 +4704,10 @@ static void nvme_scan_work(struct work_struct *work)
 	if (nvme_scan_ns_list(ctrl) != 0)
 		nvme_scan_ns_sequential(ctrl);
 	mutex_unlock(&ctrl->scan_lock);
+
+	/* Requeue if we have missed AENs */
+	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
+		nvme_queue_scan(ctrl);
 }
 
 /*
-- 
2.39.5


