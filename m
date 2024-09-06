Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A294ECE7AE2
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j8lgyS5dMPeO2qFkYi30AkvOg4jJMB6frjU0fmtL/DI=; b=ul5s4sRY3hK7N0SaA8yfBsmCqR
	nAntgdqvnJEpMXKmSfhJg54WXpwNpjoXCwvzRv2Xsj9YaQvakrN3bSgEkeyg7JzJquSkIAgm9YF7f
	GQMdqU9EiQVorTov3/dM5iAhbi3UqYDndOFFzz91ETm4DJax0uU/ibyVVVbsQ7i7YUXchAyHlNCLr
	GxCAQ/UqoJPhp+j3Jr1b/L3xDuiOirVOq/nPdFrp563oYTmbDkeHB+mL3VPe4fnXJ/jUgcA+TnKw8
	j2CykgboyUkHRaGtpqvxqSTNNHYZhtBmu5AIGO22ehzYS+Y2VCFSI16VL2TOb4u9suT6aFsopgpCo
	wca31RFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smTPC-0000000B5DG-0lNL;
	Fri, 06 Sep 2024 07:29:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smTEv-0000000B3TW-1wax
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 07:18:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6E8EC5C2723;
	Fri,  6 Sep 2024 07:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDEBC4CEC4;
	Fri,  6 Sep 2024 07:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725607120;
	bh=+gdjB79noZuxpKg7Fo8CxJSoz0h+b+eS39KuQFoFvps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQ0FIl8vNYjlgWZsl92Mu4aZX7YDaBMyiQvrNMpQ76IAamENIAwdYgmTimFUqj5jC
	 x1U4vUcXIdxkr8OH/3H+hPA1q4lyT/7vFaxIl4MF7OFTTlVeuwaZ737Ioqxi6FMWMw
	 xyX6+s/7Y+7mCN/oXqluY14bN+vl2Ixep6Q8fvIuT969F1sYlK4pRcq1geiql/J9gB
	 dIIfdpAwms2oyOMaIE/VGctP7Rx4iT+lHuvh57LoQU0r2nRt91E1CNhwz6+d6bVWGZ
	 Py4aZ+ZAti2b9plqYQt/qN0HRd/s0NmM+Wx31rXICSPyNpfx8ca4gI7ubugx6Q9/f4
	 NAw7XRv4pN6mQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/4] nvme-multipath: fixup typo when clearing DISK_LIVE
Date: Fri,  6 Sep 2024 09:18:25 +0200
Message-Id: <20240906071828.125614-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240906071828.125614-1-hare@kernel.org>
References: <20240906071828.125614-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_001841_556423_F98846C0 
X-CRM114-Status: GOOD (  10.72  )
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

NVME_NSHEAD_DISK_LIVE is a flag for 'struct nvme_ns_head', not
'struct nvme_ns'.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 91d9eb3c22ef..c9d23b1b8efc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -646,7 +646,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		rc = device_add_disk(&head->subsys->dev, head->disk,
 				     nvme_ns_attr_groups);
 		if (rc) {
-			clear_bit(NVME_NSHEAD_DISK_LIVE, &ns->flags);
+			clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags);
 			return;
 		}
 		nvme_add_ns_head_cdev(head);
-- 
2.35.3


