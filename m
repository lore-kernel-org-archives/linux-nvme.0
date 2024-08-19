Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC32C3DA4A
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Aug 2024 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bGfwzRFxBJhrA8E1xWjgSc8u816j+YTDeUk54l3sZpU=; b=1R5o1lYlcpok8S+Nn6HEsb6RVv
	MwHrXQuP8hKqx18LsLyhGec/p2toAfcl8FR4YffL0qWGl3R+Kmk0RtJZCDk/SjzEqI7S3joJKbu7y
	fVQNsnXxJYI3z2XMO/H57UhNrEEspwzCxgglNrBhg44qDS4qcyVNT7GkxHNi73oEJjLRX06dzHHKA
	bs4oJt0LJ+vcPPxU8uiYR+XU0Ww31F2KpSGEejgpNwbzuddYO6TKo2bYqowfo78Y2ey2Pdb9jxzRG
	0QxpBtTUb07DWBwNcP7GOWnBKaNR1I67FYt6kpY5iijU/HpRQipFBRhKKcVy1Q7w4/DdExL3ixFce
	eCIhcDOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg1UC-00000001R5P-1A9Z;
	Mon, 19 Aug 2024 12:27:48 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg1U9-00000001R2u-3OVC
	for linux-nvme@lists.infradead.org;
	Mon, 19 Aug 2024 12:27:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1FD9CCE0B63;
	Mon, 19 Aug 2024 12:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A2BC4AF0E;
	Mon, 19 Aug 2024 12:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724070462;
	bh=hFxrPEgQPtN02L8YCmaCN+9tumsCAthP36+3TsMwNjc=;
	h=From:To:Cc:Subject:Date:From;
	b=PxSQ16LD6C/JEtZgD/qM2ayJrCIhtzPFYN10fPLIzchxOyrN9Hhz7GXS2m5qEktcZ
	 CA/qlzURRGbwKVmSX2JIxgFoIQ1Nu/ZYKlpqIwLeIxccU5lEtOLSYfQhvsSmarMZg7
	 ucEbaGJqncDSfXLdkW89SRA3YLr8WcIOgFdU8tGLxWhk68JgYUvs/Vw5oD9q113VK6
	 RoZQbLd0GFI1Rx1UC/Yr40CXsNGR7dZAdrO/0+EIBg3stxheKg1Q01yi2N6c2qceiO
	 77xvB7LhyJVy4f3L3NlLIbKTXpPKETF/xqV0s9c0kqMUxTrCLHKdJ23e181qY22ZzO
	 riNuCPilIwyNA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvme-multipath: fix typo clearing NVME_NSHEAD_DISK_LIVE
Date: Mon, 19 Aug 2024 14:27:36 +0200
Message-Id: <20240819122736.57863-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_052746_042114_CF9CA2E9 
X-CRM114-Status: GOOD (  10.85  )
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

NVME_NSHEAD_DISK_LIVE is a flag for 'struct nvme_nshead', not
'struct nvme_ns'.

Fixes: 11384580e332 ("nvme-multipath: add error handling support for add_disk()")

Signed-off-by: Hannes Reinecke <hare@kernel.org>
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


