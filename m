Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FD3C28B28
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uxkfe7pOPeRutU0JUxUeOrsc5lSMzwMpWs2aOVCL1V0=; b=sbk25uIHlb+LmuzK2FMrSJbdq9
	Zcc2y68naTjnTKy3cgvhmWAIeGHoeIhf5dfBhUgf1X7qrKJn/KkB9cosYlz87ogN7QiXVbfLh9zsG
	3mi3NHpobc3QJoMGElPNnKTb46Bk3BWcnGhReE0IEkXSUghXBmpyKWuGepzY2S8I/blWHSW/02M9R
	ZDY8CCfqoEHD+RDeX2zfKhrlOx07BZJvZqBhOVfZdwf44WROBCb3QIeToRkk+JRKG1lgmAVPM5Z7w
	BPSsb3h560RzCh7gI9/qnpg/ljQpUjMRNY9sEGYicfUPnlFGXR3pyfgML79CM1U0FW6Q41vjqyp2s
	xMH3i69g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUN0-00000005Xy5-171B;
	Tue, 18 Mar 2025 10:40:26 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUMx-00000005Xtk-1ClX
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 10:40:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D58EE5C58BC;
	Tue, 18 Mar 2025 10:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE54C4CEDD;
	Tue, 18 Mar 2025 10:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294422;
	bh=JTLpMEKu43lVUED42qFb7QDyfoLGefK5QDiEX4OAcCM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sXy78qeV0HjURROd9BFGrAxVsdc51t3zCXW3oUfrGCkHr1gOQtkHlR0FSrmb1NsVq
	 FPYCZin06m9CFFnFxkPlsqS1058O5HK57MvXBOOsfucwMOA9nFXFKVf7qRLpSFv5Ow
	 SIQbSUDk+Hi8NHZ1REyQ12Gg+anZLTs+aRbTJxOnzVeiPWjslC+Ij0VNKduEjhSREb
	 ZIiIexYEM7GVrcge2yXMB4wRdYur64V8wY7KGlDoxI/y9s4y/fL5Y1NKUbszALQWsP
	 dxjkeAjD5WrnRq9BojwO/iRX4RwU63vbHerm3T74+OIsGtTeRwuUeojlMyph2KBVA1
	 Bli7m3bKjzcsQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:02 +0100
Subject: [PATCH v3 08/18] nvmet-fcloop: add missing
 fcloop_callback_host_done
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-8-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_034023_402025_CD0A8054 
X-CRM114-Status: GOOD (  11.82  )
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

Add the missing fcloop_call_host_done calls so that the caller
frees resources when something goes wrong.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index cadf081e3653c641b0afcb0968fc74299ab941d1..de23f0bc5599b6f8dd5c3713dd38c952e6fdda28 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -966,9 +966,11 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 	}
 	spin_unlock(&inireq->inilock);
 
-	if (!tfcp_req)
+	if (!tfcp_req) {
 		/* abort has already been called */
+		fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
 		return;
+	}
 
 	/* break initiator/target relationship for io */
 	spin_lock_irqsave(&tfcp_req->reqlock, flags);
@@ -982,6 +984,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 		break;
 	default:
 		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
+		fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
 		WARN_ON(1);
 		return;
 	}

-- 
2.48.1


