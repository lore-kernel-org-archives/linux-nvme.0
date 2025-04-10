Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7E7C369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 11:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8RIENUipbPnPcNezkAE3vmNOAiaclo1CE6Lp7trw+TY=; b=JvTy7IUGpUheT5tvKAXa6lGh1+
	uu2VKUdJcyFhwj6BQYOhvlJMjmsf3grJqMY+tO1KctD0+cxao9/tVxPRgTMZ8HM/Wqb/LolLUnJtZ
	RQRtq40emL1rIpsmaC6AyTBe6oPQwn2EO91lAHaDgWibVj7iaJr3sKjPts0JHpLShgo0NhtSGhdby
	nJHbYP3wE7M0WwxzYs1jhNwfP/CRkScDGA8G5s2VuJiwdBF3+E7l0Xnkx/EbFLSk/utmjl89n4n3g
	HJ4pkxqKKMK7TXDHpCOniP+JEkZalhxlSoRJ5Exqhmi1zr+MY5cV0AbUBUbaNsdG6vhiNG0aTdtrh
	C5+O+Kzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2qN2-0000000AM3J-1loN;
	Thu, 10 Apr 2025 11:47:00 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2qHc-0000000AKr8-1PAv
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 11:41:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CE1E15C1043;
	Thu, 10 Apr 2025 11:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37028C4CEDD;
	Thu, 10 Apr 2025 11:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744285283;
	bh=EWB/sYzoB8CsG9hgCZR+RFlRMAyDx5p/cXloDsy+UNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JPUZt9RSeiO/4YQ+MT8jIdFJcRgt7qA0dP1SZOktGtqhvXqAISDEIbq6F9H+FNjYK
	 BPER5HUO1SHEV23d3JJJXIcejJuZMYL+AEi7+XNrdc3vpATcgOBSgdB0AAB7pvBpg5
	 qEFm3brS/PLSabgWffWrZD4H9nmdupYyXGbOfl+q/8/So3wJgptnWdGl4h9b1DCBv5
	 kMMF8Z6inz4Z9PSJ6Pb4JLV816MmwYD07c0v4IUiwimX+FPlIPQodC21sH4hhgtW3X
	 KkVbGAH3zDiQOjqk4bDAVSzQkBmRCbqJYKW/MmDcl79nUPGhZP9ctmbPCadd+ungjH
	 7gV5MvrXbtA2Q==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 10 Apr 2025 13:41:08 +0200
Subject: [PATCH v4 05/14] nvmet-fcloop: update refs on tfcp_req
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-nvmet-fcloop-v4-5-7e5c42b7b2cb@kernel.org>
References: <20250410-nvmet-fcloop-v4-0-7e5c42b7b2cb@kernel.org>
In-Reply-To: <20250410-nvmet-fcloop-v4-0-7e5c42b7b2cb@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_044124_423916_B346F97A 
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


