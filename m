Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C233C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2mi/4J6CZtO3ex4hBVSjeQPAftfJhIqVY/QQKL8MXX8=; b=XptvzWWd2t6hhAs+1DpzdahSFM
	voR810ZpZF1DfS6geBkh3LbezD70Cu8LPXDepOVEvjsJcTWl0XSlCpwAnz663oQWzHS0aRztTg0fh
	Ih9p65rW3ctdTjolddrjFMHfej1clibv1VpEZkcC4pcBbs9gnleB4sbzlp0AY96CT1cNY5aTYjBJh
	w+U1Oa/blQz0mqLcNjHux3fqAwuyCWV4rllJmBnGjXXTgn7DAXOnne+yF319z77ASpPM5B6EhO/l7
	nlFXvf1L9HJzsmilaG47G7FM/enHwzeiiY00IjdqwYfIe0v4zCobZbvwZfjgIWk5UKESfZLZCpVoX
	v2cfrmbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovI2c-003dol-Dk; Wed, 16 Nov 2022 13:01:22 +0000
Received: from [2001:4bb8:191:2606:427:bb47:a3d:e0b8] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovI2X-003dmU-B3; Wed, 16 Nov 2022 13:01:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] nvme: don't allow userspace to set the Host Behavior Support feature
Date: Wed, 16 Nov 2022 14:01:03 +0100
Message-Id: <20221116130104.2186334-4-hch@lst.de>
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

This feature is used to tell the controller what features are supported
by the driver.  We thus can't let userspace processes update it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/ioctl.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index badbc55d29350..171c983191501 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -23,6 +23,20 @@ static int nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 		return -EINVAL;
 	}
 
+	if (!ns) {
+		switch (c->common.opcode) {
+		case nvme_admin_set_features:
+			switch (c->features.opcode) {
+			case NVME_FEAT_HOST_BEHAVIOR:
+				dev_warn_ratelimited(ns->ctrl->device,
+					"rejecting Host Behavior support update by %s\n",
+					current->comm);
+				return -EINVAL;
+			}
+			break;
+		}
+	}
+
 	/*
 	 * Allow privileged processes to pass through any other command.
 	 */
-- 
2.30.2


