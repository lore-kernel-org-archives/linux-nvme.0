Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D10D6EBF1
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 09:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rY85NKSZyEQqwVJ2ilRB+cw7Ifzr+W7VkE3MccCS3KY=; b=it86t/pNbCNKHkTOz451Cj27Xd
	e9ojW4tOMCTPLzdIqD7RdNkWevMH1aR/czvXlOBX5r276mBS0OguY7wXzdDWkR3r4PNRDf1Fa9lha
	cGXTNI3FHAQp6V7TE1sW/sTUkmNoij8D63/lRzRN7U1POIQdJEHUanagkLHFprveDheXQGL8no8f/
	mZo8M/bFG7meY2mjjMKoj03yvi9zKBB3uASEoWbul8ly1zzhjVOopq0kgWfki3hg/mWCwPUunWW/0
	Qp5aKAlGVkUx0k7zPGnbGZstvOuFnjTUTLXHpzaZ0atDp6nhEwQuQWKKhhSsv05FNn7QFcITz7oST
	jGClXr7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGxIm-0000000HKhQ-0tE4;
	Fri, 29 Nov 2024 09:28:40 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGxIj-0000000HKeb-1DpJ
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 09:28:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E1F12A43DE3;
	Fri, 29 Nov 2024 09:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B3EC4CECF;
	Fri, 29 Nov 2024 09:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732872516;
	bh=zipAIlJ40bkL0Mod12OfQfmtAm7/0GgYfeae3gXItQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qx3G+Cv8fSe5QyR0gx7bjPbEP//SQQBAU9RNjl4LM0VuT25DVgdP0Keh27Bz63mxy
	 LccmaL88EB6Pn29OfsIheagaIHTU74NA1tn8nKEozPAiI2SdgnUbj2XZYdX/BBLOoE
	 CjLoAu/FsHnbnJpgsDASmGeM4rP4grBw4e6DuLEuWEqOY6iM1eBiC42g7HYOimbXQ4
	 QsvJX4R84PmMm/A+BeGzjp9e637sRQb5RK5gUhItH4eJDkgL55YmgYkotl3enoUQOU
	 TFI3+8dMsSRHCPUgaJk4TnUWhIohUj8tmppfkQVE/vdm2KFMqTDrmxxgs842eCVY+c
	 WILDpKTNuUsKA==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 29 Nov 2024 10:28:25 +0100
Subject: [PATCH v3 3/3] nvme: handle connectivity loss in
 nvme_set_queue_count
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-nvme-fc-handle-com-lost-v3-3-d8967b3cae54@kernel.org>
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
In-Reply-To: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_012837_407344_BBAED386 
X-CRM114-Status: GOOD (  15.94  )
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

When the set feature attempts fails with any NVME status code set in
nvme_set_queue_count, the function still report success. Though the
numbers of queues set to 0. This is done to support controllers in
degraded state (the admin queue is still up and running but no IO
queues).

Though there is an exception. When nvme_set_features reports an host
path error, nvme_set_queue_count should propagate this error as the
connectivity is lost, which means also the admin queue is not working
anymore.

Fixes: 9a0be7abb62f ("nvme: refactor set_queue_count")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2a07c2c540b26c8cbe886711abaf6f0afbe6c4df..aa2a7c7d4d0ae7bd1f7fb704e55c0a8d724b9d56 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1677,7 +1677,12 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 
 	status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES, q_count, NULL, 0,
 			&result);
-	if (status < 0)
+	/*
+	 * It's either a kernel error or the host observed a connection
+	 * lost. In either case it's not possible communicate with the
+	 * controller and thus enter the error code path.
+	 */
+	if (status < 0 || status == NVME_SC_HOST_PATH_ERROR)
 		return status;
 
 	/*

-- 
2.47.0


