Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96355C04FFE
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 10:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uB6BU2uC0GC4LYFFeR04qt2WDJKUHkXz3YazJUanwj0=; b=03c+1xUkvotVIqtsvMyQ48z5Z6
	/a6xo3WoxZzcRgqstygFUZllAXUcnrgLQ01mZWEGkFw+dqMXofkDIRDgzaNmtxz5oaDO657IBSrFM
	vvyAlLNFP23rFPcfSuS+HM3weEBxYk8Zyo3qGRzVawQ4KbrSDfWB80sHyWvPX7eMYjnuxigpNU8iy
	ANboCdpLM2blSXIaB5Za8ZlV19zHZHT9rUO/vENLpwRsb5pk6Fy5vljRbhiRYIjQPW0XXT0Vmhffw
	FWIuBMMLtTBYOH4whX2Tpm+PE7F01dIIYGdbVMiRWT19iiQ+kyjY/IVKGsWEKWRAtwzDxlGYHyTBp
	7fnaviWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4eVO-0000000Ezne-3FQx;
	Wed, 08 May 2024 10:26:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4eVN-0000000EzmE-03B7
	for linux-nvme@bombadil.infradead.org;
	Wed, 08 May 2024 10:26:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=uB6BU2uC0GC4LYFFeR04qt2WDJKUHkXz3YazJUanwj0=; b=QuljAG3YQ7A8yNL4rcugMB7jVj
	1pY/8umYhj8hLTe6hXgmT3D2l1ePCa8Be5PB0H425P/ala0NTaSYQegFWEsdD5cEggmG5dltNCNab
	nPiIXoPHkj0TUgDpd4tXk1EHdRljPbKjC1zaVDKe5guFX+0TLRghGBj36RYdr9JhlH3eMxj2MecE+
	6aCZFHKKIylKMLRjDbjpfQz0AlEfe3SJPadugPSAnP0Tu+3LMyzuSaIy9xsce6k8YLiPb7EcRSjl/
	5UbMSweLqkBJ81ai8RGOoG6P3dTPQjjz/gvTsrsihi2qms3Z4hYI5COYi+NkD4GUPmVAR1EZAsj/Z
	Gny7r0qw==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4eTO-00000002SL2-0pKp
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 10:25:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9DF7D61B65;
	Wed,  8 May 2024 10:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FF8C4AF17;
	Wed,  8 May 2024 10:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715163825;
	bh=dMTER6NNyOAwLrb1/o/gBEwUrWLvoTVjyf+DwaHWcnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k7GQA1mzZjefCgU+rQZEZMWBUV8M0G9z565V5xL7nWyAY83IfwFC6s203ngpqCElJ
	 5IRx2M7O+w4vqjOHqPyqVW48LpAtjS1zfX0gkt/ICn9LxoYv2qK5jdusMC7IZa4jI4
	 lx+BYpFb16Upak9W+wIRvZg7piIUy3pnDWRFX6pOyWAFRqKdm8z8097te+b/4g7gbD
	 nDgooM+GsMIHR0rkkceQmYOTxsW2Gg9MursWB91iZ7Jq63uXfWu0BzHN1mRWJf37Un
	 blA4QvLseWR2PYDf7HeVzdxOWXF7iF+0z83KgoFG4M4LxOijvG69PeyvGadaqBZv4D
	 r8N59aTkJSsjg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 13/19] nvme-fabrics: reset connection for secure concatenation
Date: Wed,  8 May 2024 12:22:59 +0200
Message-Id: <20240508102305.108949-14-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240508102305.108949-1-hare@kernel.org>
References: <20240508102305.108949-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_112457_101438_C588DF00 
X-CRM114-Status: GOOD (  16.74  )
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

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/core.c    | 8 +++++++-
 drivers/nvme/host/fabrics.c | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 09d089e42152..f2463d3c7c0f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4541,6 +4541,8 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
 
 void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 {
+	bool start_scan = ctrl->queue_count > 1;
+
 	nvme_enable_aen(ctrl);
 
 	/*
@@ -4553,7 +4555,11 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	    nvme_discovery_ctrl(ctrl))
 		nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
 
-	if (ctrl->queue_count > 1) {
+	/* Suppress namespace scanning during setting up secure concatenation */
+	if (ctrl->opts && ctrl->opts->concat && !ctrl->tls_pskid)
+		start_scan = false;
+
+	if (start_scan) {
 		nvme_queue_scan(ctrl);
 		nvme_unquiesce_io_queues(ctrl);
 		nvme_mpath_update(ctrl);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index f916c9cac9db..2256b611e3f2 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1335,6 +1335,12 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
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


