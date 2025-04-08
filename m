Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C00C369A8
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 15:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HOJkx142J+CPmI4E7qvd3VIwHILjmmhTtVDvmCkfyXM=; b=xoib+h1rSeGoRMjFR+8BOqzY4d
	bEInmepclj9z9Jo7phAeir4eG7r8jQF4DHq2iXuI/NJbosJYaNzDJplncUJLckHsBS4cc2ebRBkfT
	bW7UuxZ/JV4Y1+xNNi/phMVKFu+gzc/v5HZYt55ybXJujmLybq+xh3jsQhco42YIk0eeL88F9PHMo
	rklW78c/WGHrBTLJ//9sePLrRc7pLLRm6lsba3p2JlcszJLIs47KUUNOmiUnunkNFc64LOA+iLrlC
	rxgCOctKWFNY8phXfddsiuqYPvTWGBolpOw7REhfb7E+eM8vjr4XF6ScS6RHSLBDQ/JdiXW0KMenh
	w5nwoMjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Atl-00000004cUA-0WeQ;
	Tue, 08 Apr 2025 15:30:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2AtG-00000004cIw-2twn
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 15:29:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2376E614FE;
	Tue,  8 Apr 2025 15:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FD8C4CEE9;
	Tue,  8 Apr 2025 15:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744126169;
	bh=xJGc+4ZfEtXd0Q1inHLwc+Miuup2DabedmlojQWG/4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cnHKkn1/i/vfN8L94bedD3cqiEus3Owc9Akn0InGkpSFwh2a9E3we/bAH7PrvgUsZ
	 XVTvZI3sb0JV0s5tpbZL887wljckaMCvo539mnaqvda+488C9q2D05HIMIAZ5jgqxE
	 Py/q3GagC9o8wsUAuCoz0HV2qPZYgMAo3Muc+v8Fo9y0wchluxSfYN7S5domQblPAz
	 VKvQ1j4sbpyvH2uc3BeyS7qkaliv742LkEbIn3gIymcDPWO6ZguAFerfnjsfIeQB9f
	 Sklg3s3e+jBW5tNPvY+dFoZGR4+uvVFUAkm0UYt9/PubKLNam2ilWamZq8qphJIUl2
	 12bd3B2d8RHQQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 08 Apr 2025 17:29:08 +0200
Subject: [PATCH 6/8] nvmet-fc: update tgtport ref per assoc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-nvmet-fcloop-part-one-v1-6-382ec97ab7eb@kernel.org>
References: <20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org>
In-Reply-To: <20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
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

We need to take for each unique association a reference.
nvmet_fc_alloc_hostport for each newly created association.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 6d64dadcb356b78b522d0deaa433cc745bfcd8f6..42613280c06e82a0236520d93470ec6fdede37ea 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1127,6 +1127,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		goto out_ida;
 
 	assoc->tgtport = tgtport;
+	nvmet_fc_tgtport_get(tgtport);
 	assoc->a_id = idx;
 	INIT_LIST_HEAD(&assoc->a_list);
 	kref_init(&assoc->ref);
@@ -1228,6 +1229,8 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 	dev_info(tgtport->dev,
 		"{%d:%d} Association deleted\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
+
+	nvmet_fc_tgtport_put(tgtport);
 }
 
 static struct nvmet_fc_tgt_assoc *

-- 
2.49.0


