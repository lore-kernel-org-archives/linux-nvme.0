Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9CDC3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 12:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8RIENUipbPnPcNezkAE3vmNOAiaclo1CE6Lp7trw+TY=; b=21TXyD3DMC7Aw5n0FcA9Dm785+
	oy9mWDuB7hDKRkpV6A5KnK2CUnndVVJN+ig0Jia3BElUYEwiI84fA+hPrQ/JHykPfmcG2k0HYXkrB
	F0vo9SJPfRdB99kE9V3U3Q0pFgAvvnqaPUitL1wX34dMcbg17B5L1+yFnTnjz+OicIconvJlG6NVZ
	4VAuBWoQCdAeGDFpu5ndPSvyWWtVZWZ78/gdwXZkjQXTOL2jFY6eik13f9OlU1JShEqYFIM3UFsQ2
	qwBZTEXILgSkE/1xSCLbp64Vxk4uxK6Ss9X6eZ74moGsmlSbN0r5KHD2cnuD0P0s37KeVpvhlPw+q
	r9iMpxNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdnz-0000000FMtv-2n8Q;
	Wed, 07 May 2025 12:23:19 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdnx-0000000FMsH-2bPq
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 12:23:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0B045629D5;
	Wed,  7 May 2025 12:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F838C4CEEE;
	Wed,  7 May 2025 12:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746620596;
	bh=EWB/sYzoB8CsG9hgCZR+RFlRMAyDx5p/cXloDsy+UNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E4pf1TPGVmBdUIky47hVFkGl8bu7ltq4xtdCI8G/lqa9Ha1+WbUT4u28zHHZtm9Er
	 7f82C0jD5WlOu6VNr+NGvd3RWKTr+yjMRrwlsFgbfkyvRovPtsg7O/sc4hjFdX6r4D
	 C7+W+TeLZ13/0OEN06QAWDPw/cN4Ml/J08Xs9bvJg9mk7/A77t51GuFPodV13Xq6id
	 f2uUSjnJTMYlqo+fWm7DqZK+kLOnPq1R7jeNzD7GVmXKAl0JH9+RgPEbEUC81061RZ
	 1zBgl5xC8308xy/bWvvVQGLbuYeU+tn9UxVWeiY8zCdn68gGDhARGxrrk+ADRPVib3
	 Yu5iPvJHAJAxQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 07 May 2025 14:23:01 +0200
Subject: [PATCH v6 05/14] nvmet-fcloop: update refs on tfcp_req
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-nvmet-fcloop-v6-5-ca02e16fb018@kernel.org>
References: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
In-Reply-To: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
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

Track the lifetime of the in-flight tfcp_req to ensure
the object is not freed too early.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 1a8ae33c1699be3b7a2a7170dff77e324c127ebb..b54467b285181d6909c6592eb166cf4fe6fbe54c 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -566,7 +566,8 @@ fcloop_call_host_done(struct nvmefc_fcp_req *fcpreq,
 	}
 
 	/* release original io reference on tgt struct */
-	fcloop_tfcp_req_put(tfcp_req);
+	if (tfcp_req)
+		fcloop_tfcp_req_put(tfcp_req);
 }
 
 static bool drop_fabric_opcode;
@@ -671,6 +672,7 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		break;
 	default:
 		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
+		fcloop_tfcp_req_put(tfcp_req);
 		WARN_ON(1);
 		return;
 	}
@@ -958,8 +960,10 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 
 	spin_lock(&inireq->inilock);
 	tfcp_req = inireq->tfcp_req;
-	if (tfcp_req)
-		fcloop_tfcp_req_get(tfcp_req);
+	if (tfcp_req) {
+		if (!fcloop_tfcp_req_get(tfcp_req))
+			tfcp_req = NULL;
+	}
 	spin_unlock(&inireq->inilock);
 
 	if (!tfcp_req)

-- 
2.49.0


