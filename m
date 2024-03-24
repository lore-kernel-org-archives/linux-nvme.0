Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDA0C6FD1F
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Mar 2024 17:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IBHFNX2j0rhZu+5MTohXAOg1qnw46e/14/t1gQ0cfbc=; b=vZ+1a/hM9o4pWTgrScbXAxdnyK
	cpUXQbh4QUJ/X2cTDyqIVxAF0QgPHNKTtQX3Kp8DV3FaTrSZsDIzqVBhDinBeCyolSYTU5VuZz9e7
	ig0XYemIIjQ1PVf9OdNzjGhGGOj6sWWuaDwmpkFNnA0Gf5QgcwUpo1iC6RUyyG6O2Y1SfJuM09stO
	5u+ea58Z2TTq3haco64KBCo1YI8IPH69A5Wzlaf2lYRESZICEWRYp4ZJ6AEU3Yzv6fUSVjhvFnRHN
	7p50vmotVFarGiQ2uAyy2q/GH8R6wATSAsg5h+Ho6C9rw1LrEPHBasw548wF5TbIwdr06jpR4hG2E
	G68RX7xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roRJz-0000000D2DD-36rr;
	Sun, 24 Mar 2024 17:07:47 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roRJv-0000000D295-1DdJ
	for linux-nvme@lists.infradead.org;
	Sun, 24 Mar 2024 17:07:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2FDE5CE0B42;
	Sun, 24 Mar 2024 17:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9554EC43390;
	Sun, 24 Mar 2024 17:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711300060;
	bh=K1c7/bIX7waGm3DxSRRRej1jh5k3h52Mpft+aw2Oay0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GQD6sgKRsyFAut2JPBCyqKQzTHivBIUi4B9QpQ7biJf11bdv6+6GHyfS0dXiHMtkU
	 gvuZZgCee3Osvg5Z5L0bXyvXsgmzVndc8KIFlvKaonpBJ5EUDtwVgvkcUxaw64GU6T
	 EJkoLZPfiMfO6AfyjPQ4vGwYXbg9bt5Q1m+1G1ZNzAzdPNRVemja9Ir8mYwKvneuMi
	 OMTZX7/KvQ7YhWnnAO7gJ1GPL4XDyTRF9OCzMvcYCxtEQA3J44XPu4Iu6sb68i9A5z
	 0ibSvz5y5b0Rvj/o9FpBKcygwe6Qnc306d4+5uMvhOdEb9BZaR4WH4fXjuk3iyqmE0
	 it/diKB4Oxkpw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 3/3] nvme: clear caller pointer on identify failure
Date: Sun, 24 Mar 2024 13:07:33 -0400
Message-ID: <20240324170735.546735-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170735.546735-1-sashal@kernel.org>
References: <20240324170735.546735-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.272
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240324_100743_566222_B94A2684 
X-CRM114-Status: GOOD (  12.52  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 7e80eb792bd7377a20f204943ac31c77d859be89 ]

The memory allocated for the identification is freed on failure. Set
it to NULL so the caller doesn't have a pointer to that freed address.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9144ed14b0741..0676637e1eab6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1080,8 +1080,10 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 
 	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
 			sizeof(struct nvme_id_ctrl));
-	if (error)
+	if (error) {
 		kfree(*id);
+		*id = NULL;
+	}
 	return error;
 }
 
@@ -1193,6 +1195,7 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl,
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
 		kfree(*id);
+		*id = NULL;
 	}
 
 	return error;
-- 
2.43.0


