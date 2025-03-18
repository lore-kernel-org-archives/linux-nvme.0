Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C670C35FFF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VolDAcEy6e9GEB7vT3Qbd+LK5QwisuIULC2URVp0Sjc=; b=RYSuUP9+GiRoZnPS0Bvip4gdP9
	D4jY9zFqCZXj9qozrCeJAz2b6AdHxxNx/EP8YS5lEHomcgCEolh5/2PVbseAmgaNb7sE/+cTKRFRa
	YZI7clDIiHc61/pGs5/Z0BcOFJhlpTZ2ROBiusz61EB4WyZjiOQ4s6WELQv44tNc3lfz5GQxpRx+v
	pVC2YfVNB7gb4V5RId6d9qiBA5Vpya39Za6neQ+NICa5Xc8uiSdwY7JToCqbmCgbbXl57wBGgVw8K
	c6R4N+kGnf64HehPUtLg7dAS09+C4c/JWwoOWf5V1yDnOZB8RtYZlIdM4AFyH285W8qIomSHV5R7J
	YKLB+yGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUMw-00000005Xt3-2HN7;
	Tue, 18 Mar 2025 10:40:22 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUMu-00000005Xq3-47xH
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 10:40:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6491E5C58B8;
	Tue, 18 Mar 2025 10:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C135EC4AF0B;
	Tue, 18 Mar 2025 10:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294420;
	bh=/K31wKt7+pzmqy2zsNE8F9f+nDwRIU59/QexgN001CE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z4SjNouKzlzKLJIkXtOclDH4imOlVXyBVWWNpGMpJwA5Un4vtHvPsKZcWEBrshH0q
	 k7ILdTYwnudBf+fecOAmA87d7W4DmIwJs+gQg5Clo2jsQzwObCJkDeWgJwGnpmaC9u
	 Q2ozgKmR2eMrtA+a/LYYikN2yD+B5CjrEV8iY+orCc0Q4K6Jtz0nkQkCHlywG3eKwA
	 Iawcf7QYXkDNcZg2bapOHgoys+4OnZa6xJ3OLlpeiBLeHJ98B1+k2/Fht1iTlqk46X
	 GqCqWkohAjLNl8RQA9rsoGE3meOf4dF4W+4dBXweIRi9Y/BsxqxAUdjGW7NgNaAO5g
	 qPF8t3VTevcYQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:01 +0100
Subject: [PATCH v3 07/18] nvmet-fcloop: update refs on tfcp_req
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-7-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_034021_111022_67099AF2 
X-CRM114-Status: GOOD (  11.44  )
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
 drivers/nvme/target/fcloop.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index cddaa424bb3ff62156cef14c787fdcb33c15d76e..cadf081e3653c641b0afcb0968fc74299ab941d1 100644
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
2.48.1


