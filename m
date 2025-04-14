Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B9FC369BA
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4ZzcpxXF0e/AAlcmxD26p9q35osIleH0yEitMKhryTM=; b=NAln31uHiPRTiYmeneWupY2ov1
	nJ2kcHWnzxg0CfGbAUAuPlbLNea2vKmil0BRrYSHq172PTnNmwb3mJz/ZVN2RZ/laP1imIIt5gK/7
	OFv54269IgFRPGwxG0cnPoMwHdSASwwb1A/loxCODBlyzIuZFRwqEIfcKwvuVZze4T6a++NJgqMxr
	sYNWh1DmeLLS92Z25oB6sgF9WhpyaQbANekYyOYa1+Ap6c2otO+jEutWcXGvu0cfKyIhAj4H9oLP9
	9q+rgeLEhyFxfZ3wol/Yx+7ZuJLCrvRf4KnbdFDqARrDqwBdmmX3luFYTsQxXKZP2ZmqX+2ZGG7Dg
	WifY8A3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4L1m-00000002RXB-0D5D;
	Mon, 14 Apr 2025 14:43:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Juz-00000002AaG-13Zp
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:32:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C399143961;
	Mon, 14 Apr 2025 13:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76382C4CEE2;
	Mon, 14 Apr 2025 13:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637528;
	bh=Ekfkic5IQNMOXLfzLqVWehnFSXZpJb9m496EdyUz3xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L889CAftYF1ZchKK95i36DX2SYQ5xQg5mE/4D8bjOm3Nhu3Ckd4gOTOq2xHstbp85
	 7fH90K3YscAlfxJuXRTihMz4+DEaYViRO7E2pkjQGuFAfbo+olyFhuhWwpOAXSnoMe
	 TxMWfaVyCGX3Pr2tM+5EVO/A9f+yHYwBIK88XaFVfBCbambvnZg7H6dsDKM0xywcE4
	 ZPs01772wUYGm16YYmVY/6wzEK0Dt2tOX5RjBzlGMO4e+XZMT32KKv72KEDyvhzekL
	 ZDiS2W18xJGh+3VwjFHg1mZaXR0xjLLXhU5RoQbXyoX/ODiEhj/PgcS2fB/qQYDR7i
	 cVVftKM+mVkwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 04/11] nvme: requeue namespace scan on missed AENs
Date: Mon, 14 Apr 2025 09:31:51 -0400
Message-Id: <20250414133158.681045-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133158.681045-1-sashal@kernel.org>
References: <20250414133158.681045-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.236
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_063209_313379_DD546C30 
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
index 5f16fc9111a9f..b3ca27b78f030 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4265,6 +4265,10 @@ static void nvme_scan_work(struct work_struct *work)
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


