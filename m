Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916FEC47DDB
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jan 2024 09:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m9lNAatKR1uJ0FWoXVGaFk+j52kcK+4DyLm1/iPa/jk=; b=1sjxgDAUmqlhySUJGePwU9dUDd
	ZTyEvL86IiCvcnR9nRl5cmoxeEJfLlLLFqYJDsbfWvF8kK5kphrdkCfo9ztCpb83HT/eYuv060gUF
	6kxVAh5RVQIQERoiqb8kNYP82BbabpMFCDzinLlLxw6NemN/rHgd9z5bOn1/t2beh6eBlFXU723e4
	iu07k13RQaYbZYbVrqDBbuuG+hVTSglE24okMNSs5eAYjwdeElJHIT5PKqBcBFnn514M3VYuCR3JX
	3a7d62V+jt3x1n88u/K1cMioQcQqBLHwg4wyRJAFzfVgRWcATKG3ZKldvWBb+0Ft0EhbT4Wgf8PfS
	vGpel1ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf2h-00000007GDm-2cXC;
	Sat, 27 Jan 2024 09:32:03 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf2R-00000007Fz4-2M28
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jan 2024 09:31:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E0F3660C15;
	Sat, 27 Jan 2024 09:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734C1C43394;
	Sat, 27 Jan 2024 09:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706347876;
	bh=pjiiv8KMmTakeYhu0r5KqfsHRedGlj15qANEtP6EvyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GA1lz51JwQpnfMXYH1/Su7PJYQFxXQzYcWjjdqsyR40gCfYiSGt2JfidGlJU42cnT
	 3/pMyDzSQWlhHe7xpkKVKs8jfNIFhZVaDkYcHN++mjn38Zviw0m2HNHjAzFbTJwpxu
	 EkHNkNUAPBUILfXUVmjqNostDAmUApBIO8FNd1hSGlswDAwRbnV4zD28XT1wYsE5Vc
	 vsO5o5lxOnSJT9jNZE4PqYmEb8sJze+Sqp0QSkytrjLUr6iapqpVhTbrzxBdJcejSd
	 AYeJfwnUX2YnVhc5o3Dq6gT4VvF+sEfCFRdAX4KuUVXCaydLYSNZmX/1KzZ2Y/X6Qp
	 etjM57GiXucVQ==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/13] nvme-fabrics: authentication errors are not retryable
Date: Sat, 27 Jan 2024 10:30:53 +0100
Message-Id: <20240127093058.15699-9-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240127093058.15699-1-hare@kernel.org>
References: <20240127093058.15699-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_013147_864699_569A5C87 
X-CRM114-Status: GOOD (  10.57  )
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

From: Hannes Reinecke <hare@suse.de>

Whenever authentication failed the error is non-retryable as the
authentication solely depends on the passed parameters, which do
not change during retry.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fabrics.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index a7da088331dc..c6feb6e1e05f 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -465,7 +465,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
 				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
 		/* Authentication required */
@@ -473,7 +473,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid 0: authentication setup failed\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
 		ret = nvme_auth_wait(ctrl, 0);
@@ -537,7 +537,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
 				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
 		/* Authentication required */
@@ -545,7 +545,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid %d: authentication setup failed\n", qid);
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 		} else {
 			ret = nvme_auth_wait(ctrl, qid);
 			if (ret)
-- 
2.35.3


