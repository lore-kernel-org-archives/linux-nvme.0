Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B329C3DA70
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=700IUMNB5HMD7q7B4i0myalU684MNd29QkEe2tZhnTM=; b=2Dozg/vK/4pVCBmb1954pK0Dvt
	fEWc0bxWb3fs8DT2dNfDSArl+eAmenBMPM1MYO1atiqbgjpuVs03Cv5pCEqDCal//drLjyvufCZZp
	U5c/4WT8NpKfmtB08WaHtBLS5gG+Kik6aWVTH7C0u0JV8NDfcGWXns4CmD+r6MEbDhgiB5lpZVgzl
	AHL2BRFlYwOwcDgpLQgHwlXftyeRbCrnrAOB8GpM35gHjjGNRRareWRaVGM7F7zuGCpnUi1lytl1j
	n5ztq8s1pxBUzrmtNQGHR7+kKAiwyc7g2+Jej8odsjUhGpASMalZEQClFJkILaGj7gNNZdNHFAlaa
	vo349CFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVtvk-00000009lPw-0CmA;
	Mon, 22 Jul 2024 14:22:24 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVtve-00000009lJz-0cW6
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 14:22:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4A102CE0B5F;
	Mon, 22 Jul 2024 14:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFA9C4AF0E;
	Mon, 22 Jul 2024 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721658135;
	bh=/86MfWmQRKcJfmjDt9iktLWAZBTQWC9ifCVsFdqniNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gRHLR1QExmwBjOTLBGYUit0X5xthmsotdXGxxUhnjw1+5QGw+BckdxxDyTpvWxj7D
	 EOHrnFySSW9tWx9W4CGPRPEEqgphj5ULc5GS4W9XZyzAgb+pOv8ZBrCQEVVz+7/EP6
	 S6xPgawwtUjbUy5/WczRRP73sJt0iFhNXYDAMr9gAmucHJaFdfln2ej+TmAatgKrjh
	 Ow+ytD/WqTZuQDdwevQGIKM5VIvH3MWIIsU4zDDn/d8fXci0kJ1cz82BzKNUWD1MwA
	 6zbQpamC/dH68a8qZu9IbmLg9v740eCXytFDMds19MbwTENZaUgBrS+sKShFO5py6S
	 qaXNPv9x+grrQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 7/9] nvme-fabrics: reset admin connection for secure concatenation
Date: Mon, 22 Jul 2024 16:21:20 +0200
Message-Id: <20240722142122.128258-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722142122.128258-1-hare@kernel.org>
References: <20240722142122.128258-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_072218_412151_98AD62DE 
X-CRM114-Status: GOOD (  11.98  )
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

When secure concatenation is requested the connection needs to be
reset to enable TLS encryption on the new cnnection.
That implies that the original connection used for the DH-CHAP
negotiation really shouldn't be used, and we should reset as soon
as the DH-CHAP negotiation has succeeded on the admin queue.

Based on an idea from Sagi.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b229c4402482..76c8e01d8f08 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2251,6 +2251,15 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	if (ret)
 		return ret;
 
+	if (new && ctrl->opts && ctrl->opts->concat && !ctrl->tls_pskid) {
+		dev_dbg(ctrl->device, "restart admin queue for secure concatenation\n");
+		nvme_stop_keep_alive(ctrl);
+		nvme_tcp_teardown_admin_queue(ctrl, false);
+		ret = nvme_tcp_configure_admin_queue(ctrl, false);
+		if (ret)
+			return ret;
+	}
+
 	if (ctrl->icdoff) {
 		ret = -EOPNOTSUPP;
 		dev_err(ctrl->device, "icdoff is not supported!\n");
-- 
2.35.3


