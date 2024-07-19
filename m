Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9348DC3DA5D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 08:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oLQyJLpqfAdFkJXnxgEIBqmjb0XINeSVQ+CxRDn9XtM=; b=z1eDORjXpQAsSWejcaejjk76Rj
	MqR0gVRx6ilJO8wIrBg4wFc4ncxmlvPkGR14A/RDNLyc1MVnwAKUHb3uXmFeo9PvYQ5cT/W4mjR1h
	3udJ0OvOukc2bBUZmuoHEYFrjhrPqtWfSEIvYifAggK9LSvq0IcHPhIhvNUct8OJKlxVElApQhJwm
	QRdARlFtJLbmZKswWiFT4b5MaSG/yYrb2qeuq6Qk8rKWI8/dxlf3FgpDp0R+PZuviVObWldo9mDxT
	y7Z1nA052BWk97WrlsLC8OzguRG5Q5rVCVH1ToEVqztU5zEItCoHmr5wfIMINY1qPVSQFUSTA+PPO
	3QuOtAqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUj9C-000000026Gr-0uqq;
	Fri, 19 Jul 2024 08:39:26 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUj97-000000026Cs-26q9
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 08:39:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5484761C55;
	Fri, 19 Jul 2024 08:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38AAC4AF0A;
	Fri, 19 Jul 2024 08:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721378361;
	bh=FmPlUIHoCmFMgHseJZrvVh9i0TiwVeYiFuAHc9ZSRBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDN+Pg+F8e2rKdG6m/ZDzwHEgQ8m9fvh2t96v8d3/51ahEBlMkSA6B3iKHt/N1MW6
	 Q6GHG+G7miZ8wBd9OZORpSFp5eE8TqvegKNuoBoTA3tc6WH4+IsgtO0Ho1XPPJNC0C
	 uUYjoDf/yqVBpcOWdDebmPKATeaAtaRcPsV0BNEamQru6DY4I2gdRzdbrgezgh/CNA
	 dyFMDsmBpjSoXvtIVwnAxkHRFsnWGupniD98C0roc4anBp5Dq1yH3XT8WLSziRtMHL
	 18LSem1s3/YTdsbl0h1OWuspXojLOnqmCBgWBBkP8z3wSDC7sHGkkUCS8tQOsN88+v
	 mF8ojpxCcM7nA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/9] nvme: add a newline to the 'tls_key' sysfs attribute
Date: Fri, 19 Jul 2024 10:38:56 +0200
Message-Id: <20240719083901.35399-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240719083901.35399-1-hare@kernel.org>
References: <20240719083901.35399-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_013921_612586_125E02CB 
X-CRM114-Status: GOOD (  12.10  )
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

Print a newline for easier userspace handling.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 72675b59a7a7..c391ad6c5a88 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -672,7 +672,7 @@ static ssize_t tls_key_show(struct device *dev,
 
 	if (!ctrl->tls_pskid)
 		return 0;
-	return sysfs_emit(buf, "%08x", ctrl->tls_pskid);
+	return sysfs_emit(buf, "%08x\n", ctrl->tls_pskid);
 }
 static DEVICE_ATTR_RO(tls_key);
 #endif
-- 
2.35.3


