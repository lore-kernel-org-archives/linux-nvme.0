Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5163BCA1005
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 12:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zW+/exB5KV475cNu25rJPsJ4+iw9qnfVTVbZoTMleqE=; b=juFgRGUKtqkJEYOuC5BJVKDT96
	dqPyaf4yPpmeEv9/fQFG68IzDF6XDI6U5WC/CV2qkwr7V0QvPwVDnuQjCAiOF5Qg3cShZo7+INiQ0
	IovRjplM95Vu6I14ZhCOGXsVqfA7PKHps3Zm484ztkD9KR72lHS8s5X9KXR9XBUw4ERyQNQMkd2qT
	MLkROKr2Oj0vLflKGwIH9mE2RS7HiFVFB3FYwFH73Mja6vHpDj9VF4SDYmEm3FbbwvtqBdX+ildSX
	v9kwz3a00gPO5Evh5Wcltxxe2LG7PYeHkJKwqE5n3/arFKsNU4j/pyz6rdSukx+3z1v2zZcmuIzr9
	WBcHyBoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utQBL-0000000HJfm-368g;
	Tue, 02 Sep 2025 12:32:15 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utO9k-0000000GeE3-0LXQ
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 10:22:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CA2D644439;
	Tue,  2 Sep 2025 10:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60ADAC4CEF7;
	Tue,  2 Sep 2025 10:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756808547;
	bh=gts/rTiszRszSd+E8YgjDWY8uUXdozvHeqnApxB8p4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=li/lAITQwCvoPOw+bowFCpbpMsWY0CiLhLPc4GXDdDgSbItyBfFlWT06CnsVcrOUT
	 hOsO3X3V8ksejEvjlBTy6Mu5XWEosfQVW6f/d8bYuRprbuj7CFowzk9kA2Uh+WUCjC
	 zA8/2oKThxApz1iQbDKb4qyTY9BmA3xQp7YpRT2uJDOV2lbdUjWVWcT5Otc4sPVegV
	 dNBaf0LQcox7s4dGawma0FuXOjXKzk/Cb80Uc9VFRqNZOWppLE9oHN/VLJMQLVJ1u2
	 y/RGf9fPJxxm9yoaSSE9Sga3ao8Du3p3VD3i6u94L9NVz4pJwhfDNEdQtv8ZZ9ThPh
	 uFoRngpmL5Ztg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 02 Sep 2025 12:22:03 +0200
Subject: [PATCH v3 4/4] nvme-fc: use lock accessing port_state and rport
 state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-fix-nvmet-fc-v3-4-1ae1ecb798d8@kernel.org>
References: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
In-Reply-To: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Yi Zhang <yi.zhang@redhat.com>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_032228_145273_D7C47DD4 
X-CRM114-Status: GOOD (  13.96  )
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

nvme_fc_unregister_remote removes the remote port on a lport object at
any point in time when there is no active association. This races with
with the reconnect logic, because nvme_fc_create_association is not
taking a lock to check the port_state and atomically increase the
active count on the rport.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/all/u4ttvhnn7lark5w3sgrbuy2rxupcvosp4qmvj46nwzgeo5ausc@uyrkdls2muwx
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3e12d4683ac72f9ef9c6dff64d22d5d97e6f3d60..03987f497a5b55533ee169c9a7cb9b479d0f2d92 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3032,11 +3032,17 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 
 	++ctrl->ctrl.nr_reconnects;
 
-	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE)
+	spin_lock_irqsave(&ctrl->rport->lock, flags);
+	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE) {
+		spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 		return -ENODEV;
+	}
 
-	if (nvme_fc_ctlr_active_on_rport(ctrl))
+	if (nvme_fc_ctlr_active_on_rport(ctrl)) {
+		spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 		return -ENOTUNIQ;
+	}
+	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: create association : host wwpn 0x%016llx "

-- 
2.51.0


