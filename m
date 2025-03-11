Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B69C28B2E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 10:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZOtqI4fFWiqp4mRJOPhdfRtEEslq7r23ITDbQBBjyv4=; b=01qIZUwt/bEebuEEtsn/89PWw7
	9b7PPy25t21P9psRprxWIfJrPvqC3N1oI7wuRTpKp2fT1yRc1htk1R30kGOeHV3kUTsK5BPyvGYri
	+itjTdyxjQajv4a7kREE3ILJWddnUG7gIJYfw2W+qHeVjpHBX50jSH7DfW/Ip2jr8xeGGYvIu/LL4
	19mLV8LaIc3Mn1IqlmzS7gv/I4505M/WOG8MarjX0exl2fnSSeFo57kOZbt17iZnbyj6cq+W7RCWh
	rs95TQXAKzFLxMSe2ZfL0q7XNEgEV46kfwtta16C6zRW4QzSUJFa/BRso6AyVomuEQbAWwfnrUdZd
	mYGn6lBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trwag-00000005GEh-32Dt;
	Tue, 11 Mar 2025 10:12:02 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trwad-00000005GAo-4A8m
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 10:12:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2C9E5A46A51;
	Tue, 11 Mar 2025 10:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC07C4CEE9;
	Tue, 11 Mar 2025 10:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687919;
	bh=wI6rm3kgmO+4Czqw6r4G9A3rll5Hy0paO6uSe/x9Deo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B8d/uXixxiXUse3CbEAsQptoblBgmPDG7/LJYRPSNh9/NK80MWN0enP3PW3o5RuUj
	 m8FNX5TRXyN77/sQgjpW2v9oprwGTy1GfmHjFDQi0zRKeCrgJ5MDJy6+wOnfBcAFye
	 haHF7FIW/ZhfpQ6CUxHtBlLb5GMC2rXzO6ysmOlaBl7nXxUZgssAMTR+wmKD8nT8Rz
	 O2N6/05T701y/ETgTHvB2VVO4ZqUS4mVNZII+1mex5FGA4+GQX7x3R3pcMIJNmo3p6
	 S9NbGtLEqYYLoAPFTaqRChVvX186znv1+Ur9ROo+nXaKT8dv+G6e50rdUMgoKgpLC6
	 0uJay7Pif72Bg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:33 +0100
Subject: [PATCH v2 07/15] nvmet-fcloop: update refs on tfcp_req
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-7-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_031200_099471_DDDEB3E2 
X-CRM114-Status: GOOD (  11.51  )
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

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 2ad213c9041ee19893b2f7e8d8c82119ba412a46..4ba75f7f51e0bd95ab806b6e82452e75593ff0cf 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -567,7 +567,8 @@ fcloop_call_host_done(struct nvmefc_fcp_req *fcpreq,
 	}
 
 	/* release original io reference on tgt struct */
-	fcloop_tfcp_req_put(tfcp_req);
+	if (tfcp_req)
+		fcloop_tfcp_req_put(tfcp_req);
 }
 
 static bool drop_fabric_opcode;
@@ -672,6 +673,7 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		break;
 	default:
 		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
+		fcloop_tfcp_req_put(tfcp_req);
 		WARN_ON(1);
 		return;
 	}
@@ -930,6 +932,8 @@ fcloop_fcp_req_release(struct nvmet_fc_target_port *tgtport,
 {
 	struct fcloop_fcpreq *tfcp_req = tgt_fcp_req_to_fcpreq(tgt_fcpreq);
 
+	if (!fcloop_tfcp_req_get(tfcp_req))
+		return;
 	queue_work(nvmet_wq, &tfcp_req->tio_done_work);
 }
 
@@ -959,8 +963,10 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 
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
2.48.1


