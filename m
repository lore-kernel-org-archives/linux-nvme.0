Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0FDC369A2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4UiPdCaTvOGGKxmR2PHXTgQNGTGWL5eM1vmIN2lpOQA=; b=l3KrYywuFsdUq4O8dk93WMP23l
	6NBBmpdmd8mhz6e0emnXL86MsCOCR22OgZDE71nfuITwyAP7zLKNmTZuWDcObaXGMJqjD0N7ye3UN
	GWaPTZJFLLuqYom73p7+D5+UnD3A8qYOCIGujmkWuAv9PIFgbffCcVP2FkWfSMAhp+Y54hqnKE8XL
	37Uxz5m0Td/sBkyV8X8pMgh3VHh2BQlarltAjQxWipfClKbeEFUj2qIQhbQDm08s2nvYLSk2mwIFn
	6qXe12GcSypUe2cQ58U9m491L2Q+cX6vZ8di9rmsArHZByAJwGnkgWyUcNga3baMoZ1lOwKGt7mhN
	eRUu+uxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JuZ-00000002AAF-3I9b;
	Mon, 14 Apr 2025 13:31:43 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JuY-00000002A8E-2M96
	for linux-nvme@bombadil.infradead.org;
	Mon, 14 Apr 2025 13:31:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=4UiPdCaTvOGGKxmR2PHXTgQNGTGWL5eM1vmIN2lpOQA=; b=MPpF+MRfHSeMNBL2KfoiRIPKKy
	0avXKmEIo0m5U0KD4nvCls0esi4FRY/HbHBOTDO0aN8wauptWWjYvwlzF4JOe5oDIkJzNAHSeQHOH
	DcjkRCFSOTs2Wfdpmx2HQzm/lG55UP3kQKlYyaCdqxjer40hnlDKuF2OkravdR0V/5iq8oyq6vdSL
	KmUY2PUHjjZycEoZfPP4QBM+RAPDX87RhUHx+eg8uVNWzBGJVNXddP5Dr9MBIFKXu3+Ck/fNvTlkN
	79YIvXqOEhbF6sPlRfBWEQawMrg6uh/w5qea/CkAXRXe4c17h+FbZu8jiiRxF2y8qJeJIyQRD6TBD
	aa1xYAOw==;
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4JuU-00000009hFL-3yXE
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:31:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A76F043451;
	Mon, 14 Apr 2025 13:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB9BC4CEE9;
	Mon, 14 Apr 2025 13:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637497;
	bh=7gCAC9EMWruDkCcRIMujAGo1+Bb7GwAj1G4HbW1H0uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uj1cIdUNpHl8TffQlRRq6A+NXz1M3+OPb+G6wpIpnEwhof0nFDwquYdmkWienbwDU
	 ClKqQwP/EL6fi7IGZkyxMO9sKl7kofeJnxHNoLYBpD+/4KK0CPBq1gvXzfbaG2cQzL
	 t6PptYic1mLfoxZf3ClaoZf1pCdCiSVtWKm5nM87lsGiGz25c69aJLfGFI9eNV0HmD
	 +EEg9cKP1RwQPWy0EtMYxx9/sjqAFvvIASXIcozkt6/ys+7bfU3QKMhOsynK+rvIa1
	 ctHQUwn0uw+wsp/IlaboxiPkhqgK0pcm+eD0LQ1+NX/JPHwMs9hUSN3wcmZOLhCY7L
	 uQZntmtJgioIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 05/15] nvme: requeue namespace scan on missed AENs
Date: Mon, 14 Apr 2025 09:31:15 -0400
Message-Id: <20250414133126.680846-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133126.680846-1-sashal@kernel.org>
References: <20250414133126.680846-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.180
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_143139_264017_FC91D28D 
X-CRM114-Status: GOOD (  12.05  )
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
index 6748532c776b8..85d965fe8838c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4221,6 +4221,10 @@ static void nvme_scan_work(struct work_struct *work)
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


