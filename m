Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CED7C52D7B
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Aug 2024 11:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=700IUMNB5HMD7q7B4i0myalU684MNd29QkEe2tZhnTM=; b=ohPqL/BjP/ZyLbhhSmZa1DCQCk
	s3S678QMEHQwYcXAxyQs5MIyfU4gQXLPNdiJH0ArVsZqIZfuOvQloI/TvTrPSS4SNtQ76bCSiemKV
	N0HSurwGxfrt2vPMNbHwUl39gCsyGhln7bpPl5UUOdHHXSfnPHXED0e7A+8UvrzW0TmZsAD6xWpiR
	A72Rt0hG55GcD9uLLmIiTxuWLUcxzWVAwBHI2sEvPq9Wvs8B6bBXsyThEz6U6meqzZ+B942l06kH+
	avljcvG+ZTzC/+YDh1U3RZNujM3Q2Qbpo36+lcIfpGptIu2uG++8aSBiylHM/qaa/si4Nksi8FabI
	54fCAXJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdpVF-00000003TSm-3CcG;
	Tue, 13 Aug 2024 11:15:49 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdpVD-00000003TPm-0bYD
	for linux-nvme@lists.infradead.org;
	Tue, 13 Aug 2024 11:15:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4B44CCE12B1;
	Tue, 13 Aug 2024 11:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45818C4AF09;
	Tue, 13 Aug 2024 11:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723547744;
	bh=/86MfWmQRKcJfmjDt9iktLWAZBTQWC9ifCVsFdqniNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V3EOhzrFloUbjnGESoDCOqiwVXV9cNhUmg32h1L/jbEli58GrbC6SoVSWBfZKD5aS
	 uTrKywT9oXEu0RO3oWGHeTWfahE2xFEKSPLeVj/z/Hqi1/YMB7jB+KKnOpDkYFKU+e
	 bI0MnaJmqICmrTGJsu1m1WoTtSCwMCZ/BVfa6xMlWq3qMiinLfhv/vQxn7G2OQNJ2l
	 tWgLQIqboy0ZV+49LE9fwv7bqErpRCpePDbdAetZVcJfxHnewFbcARdx3qtrSKfJYf
	 Z1a94LN07qIbTx+uBQB1jamtgX9RFJQjhmi/vt3YsgGDTsspt4jyHebed9yhZJKOew
	 J6DVO54GBVeqg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 7/9] nvme-fabrics: reset admin connection for secure concatenation
Date: Tue, 13 Aug 2024 13:15:10 +0200
Message-Id: <20240813111512.135634-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240813111512.135634-1-hare@kernel.org>
References: <20240813111512.135634-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_041547_391975_BB9E98CD 
X-CRM114-Status: GOOD (  11.74  )
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


