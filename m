Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D394C369CB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 13:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8RIENUipbPnPcNezkAE3vmNOAiaclo1CE6Lp7trw+TY=; b=Md1tMuEKTZF43krjCzrMCyo1Lj
	AhE6nkyfDSZbfbWD/DjoZkVDZFf8p3Q8qS2JQbs9FOUc3M5uZOzfK7MJ/m/3aeve1LMlnuNNbcCkw
	sVlRdbC2vxLD0j0YjPOdKxCLYYZ52gsmPKsEsm5yoPaRAOo54RKLCUGmmzfIKB5r6zQvwOjnXkGy6
	glGuPDxybLrV2boQg7YN6bXsS61cZu379FbqeO4v5XxTcsts1aPXBsQo1aN5UkAWnCAzWprL0ovK3
	GYPPUZrgMOO7TDdLG3fX0wqJlQUx5WuoDGu79/HlFrOd1O2xaG6WUODlZMZLG29Xm3DsvLaamV4+a
	SQnANMRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7aXG-0000000AhZb-2YA7;
	Wed, 23 Apr 2025 13:53:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7a3C-0000000Aakd-1F1H
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 13:22:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6EF624A68B;
	Wed, 23 Apr 2025 13:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751D5C4CEEB;
	Wed, 23 Apr 2025 13:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745414525;
	bh=EWB/sYzoB8CsG9hgCZR+RFlRMAyDx5p/cXloDsy+UNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CNmoq/3KVehOvmZ18VWVuTRv1tXJahNs8dsSUKRF/BOdxPT9wWUVmZWhpkld1QLde
	 0B/qwpZEbYbxjoFGcHm61oWS4XU4AwsChS6nfDMDiKiuhwZlwZdbYnRrFiJOkzgiiy
	 D3wKVV9+jR/IAJQMZhw9r8GtoabmqWgjtaFh9lM/86C+u5GrEMsLLT246t8CzXAovu
	 G3rcNghzfALArZDKFESy+PU80wAlZ9pMoaNNG8lUob2PPjHfPeAhC3RzSDf1TelfiL
	 2J+bgtjdFjhx4NAaJrGIZ6xrRIN50Xl2436mQicHvnJ+NN+4kdRqzHVi8z7uymd0ZP
	 yqMI1Znr9ozBQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 23 Apr 2025 15:21:48 +0200
Subject: [PATCH v5 05/14] nvmet-fcloop: update refs on tfcp_req
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-nvmet-fcloop-v5-5-3d7f968728a5@kernel.org>
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
In-Reply-To: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_062206_359051_EB81BCD0 
X-CRM114-Status: GOOD (  11.69  )
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


