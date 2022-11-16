Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53F9C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 13:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j0+ghIjsyLB4cWDZIBvfX141sP/NjLMWtu0A9msmbwE=; b=VpI5+ruw0GeFgw3LqHp3WhHywz
	/m3GUTmMbN4xN06D1Fdd4lJ+yM2dcwwyYub4Zq32gtARYQR3FU7ibhWw+V3qBMqUxmbe2ZXpk0Oye
	DDC6ZDG+dK0qwLMLy7K10tThqX6C44TMEqkIoapCojNVoUYbengVcNs4tJB7Wkga3neeJELlH6akB
	P1QXjib9DsSiY6YLe6+Daic+MSGKGC+GXe/TQjaZANT0cmAo0gNRV7xSxKfeXeR7kl+XVvCwMUEGK
	0z6jKNFxHD2t/VoCsfgI98eFgmW5woij1eURWFM2444YnibhUg0eaW7TIds6vO2wmaLy5QoGPTJqP
	GrB11oXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovI2g-003drP-Fz; Wed, 16 Nov 2022 13:01:26 +0000
Received: from [2001:4bb8:191:2606:427:bb47:a3d:e0b8] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovI2a-003dnp-5t; Wed, 16 Nov 2022 13:01:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] nvme: reject passthrough of queue creation / deletion commands
Date: Wed, 16 Nov 2022 14:01:04 +0100
Message-Id: <20221116130104.2186334-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221116130104.2186334-1-hch@lst.de>
References: <20221116130104.2186334-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Creating and deleting queues interferes directly with the low-level
operation of the driver.  Don't allow user space processes to do that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 171c983191501..271f85ee04e9b 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -34,6 +34,14 @@ static int nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 				return -EINVAL;
 			}
 			break;
+		case nvme_admin_create_cq:
+		case nvme_admin_create_sq:
+		case nvme_admin_delete_cq:
+		case nvme_admin_delete_sq:
+			dev_warn_ratelimited(ns->ctrl->device,
+				"rejecting queue create/delete command (0x%x) by %s\n",
+				c->common.opcode, current->comm);
+			return -EINVAL;
 		}
 	}
 
-- 
2.30.2


