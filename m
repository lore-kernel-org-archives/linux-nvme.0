Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14660C54E71
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 15:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dmBTr1Jnoq9kJRDjNdwybBTD1IAKRDz4jto2TS1ys1Q=; b=fct4Bt4cNUTq3VjbWQc5S9TKzk
	hEC1Y2t2AwUrCBLddmS/nXYe60iDKgzIItdebuInrdFezoi27xA5vrf2e0DSh3ixTh+EZJPJELlsI
	I3DgbnVAKXS9NA9jWnGAi2C75q8P7LqK51bSqwybWWrCfBeJAAeyxJxKslbZ4sbejB/GIGuVggsrl
	MjXT6ftg06a6Il2p9FEdPB2qMLf+905VY+BX0Vrzm4F9bLhJpjjuqIaFQSwI5wCTimhBdbf2E/giL
	zd6vb2t9Nfxqna+hUuw/Q1FBnVmLeLbuBDhkzcZk9DkCuTgE2Ks2Q8ivkhsG80RaIB4Q0qmdpIzu8
	kuFfEmKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEXD-00000008uiW-0WIE;
	Mon, 18 Mar 2024 15:04:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWm-00000008uPs-2CDs
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 15:03:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0056560C54;
	Mon, 18 Mar 2024 15:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1138CC433C7;
	Mon, 18 Mar 2024 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774231;
	bh=Dbn+A7Khli91HFWzt8m8ueWoyccZQowReC59K7fgdJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cMRjIoqjBJWRaHRfW5hM+Ja0fAU63Ev4IgIU4pcLbx+k6YhbEFfVabXweH50T9DbO
	 Jwen9NmwTic6Az3m8DatwfYHiXh2CWqOFKeI7I4ltVccoz3hfRMswZQJ4ZsQRmGenG
	 mUOAO8HJosRn3A/MfCU7vpClAuJJqnopJzRYvB+aHGJDRNKvmdMe7bYvVWAv5dhEV7
	 XiRuGdSfWI2Ur9rDh/0ghW6pPnzkp+sYYRuPS7XZP7COEzhw+FJkhtPx/6WwcGz+ru
	 aEbO9jDNl8elpBZMM3bo8AU0rq2AwYEqVqZXPhzgm7ka5TGuuNnhys0tCskQe+2o1V
	 E1VpPKzAfGN8w==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 12/17] nvme-fabrics: reset connection for secure concatenation
Date: Mon, 18 Mar 2024 16:03:11 +0100
Message-Id: <20240318150316.138501-13-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240318150316.138501-1-hare@kernel.org>
References: <20240318150316.138501-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_080353_234232_D0BE3A8F 
X-CRM114-Status: GOOD (  16.24  )
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
The current implementation does not allow to easily skip
connection attempts on the I/O queues, so we connect I/O
queues, but disable namespace scanning on these queues.
With that no I/O can be issued on these queues, so we
can tear them down quickly without having to wait for
quiescing etc.
Once that is done we can reset the controller directly
after the ->create_ctrl() callback.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c    | 8 +++++++-
 drivers/nvme/host/fabrics.c | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9b601655f423..57b664d12863 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4513,6 +4513,8 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
 
 void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 {
+	bool start_scan = ctrl->queue_count > 1;
+
 	nvme_enable_aen(ctrl);
 
 	/*
@@ -4525,7 +4527,11 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	    nvme_discovery_ctrl(ctrl))
 		nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
 
-	if (ctrl->queue_count > 1) {
+	/* Suppress namespace scanning during setting up secure concatenation */
+	if (ctrl->opts->concat && !ctrl->tls_key)
+		start_scan = false;
+
+	if (start_scan) {
 		nvme_queue_scan(ctrl);
 		nvme_unquiesce_io_queues(ctrl);
 		nvme_mpath_update(ctrl);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ae091e0e4ecf..06418e01ab69 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1331,6 +1331,12 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
 		goto out_module_put;
 	}
 
+	/* Reset controller to start TLS */
+	if (opts->concat) {
+		pr_debug("resetting for secure concatenation\n");
+		nvme_reset_ctrl(ctrl);
+	}
+
 	module_put(ops->module);
 	return ctrl;
 
-- 
2.35.3


