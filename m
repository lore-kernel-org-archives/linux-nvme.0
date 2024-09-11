Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B96EE49A0
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 12:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j8lgyS5dMPeO2qFkYi30AkvOg4jJMB6frjU0fmtL/DI=; b=YwvQqmaubh9XZvD0t1cNnJJPdx
	7Cxy07C3k+y62Mkk9ZbZK75DlIpclBmH4dantRN34mZpQiGP+ZVkhLSKkGLGUH3MLVU3am6dc5PkR
	rJZEj7XD+leOvKPNKoEq2hWbOPUwV6szavHoik3rhiYjYX4muBl/b0iQtdrotV0Iqdxlkbdu5Rs6f
	rt9QorlP0gLsFaZJWL1FQ1QSrU98QfAiKE08gfAFKRiou9oan5G0yisEU16itO7/ZrWJF5V2pt8u/
	bJepuqoCvxk0tbYYsS9MnQzGFMp56MkYbM/juZTLwPFisZgjnJN2UQfuTsExDBz8TdnajHDhkLB6f
	yBtwED4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soMkL-00000009YLe-1aNY;
	Wed, 11 Sep 2024 12:46:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soMjh-00000009YCa-1pcB
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 12:46:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AA16B5C06CE;
	Wed, 11 Sep 2024 12:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2409C4CECE;
	Wed, 11 Sep 2024 12:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726058775;
	bh=+gdjB79noZuxpKg7Fo8CxJSoz0h+b+eS39KuQFoFvps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G9tt2nlkQEsYlbHcKDx6QWMpqqvaATaQZ4ErhV4facBsibdCCFN73GDnt2+OECNT4
	 oJ8ygfJ6zK7AQ3c2XIxOI+felozfw3Gv/5wWr/ZZzyw4MHvnpY2GfU5/SXdyHs36JS
	 nof4GbVDJcXDXfDs7VWO523dacVQHZWXsMLCe0Se+YPcuGXZu4OS2ijWoyFCl0oNGb
	 3lKPqDl02oAC/QRKhBTAbrvTsYXlZC8APr8f22tNMnZ/KZBWXR+Sm/zjRBK7loP37E
	 aQda+o6GwIXqggVtyjzVLYHl1n6nlP4cAaUh0aI/c3Q0eD8KFlApgezSBv5ZGiGtDv
	 Vn6si1j3dIiJQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/3] nvme-multipath: fixup typo when clearing DISK_LIVE
Date: Wed, 11 Sep 2024 14:46:08 +0200
Message-Id: <20240911124610.81615-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240911124610.81615-1-hare@kernel.org>
References: <20240911124610.81615-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_054617_615460_5DA2AED0 
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


