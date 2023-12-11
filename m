Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73946C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Dec 2023 13:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O+LzMZIVnyf7j7/+aK78J5MQ1ua7yeC/oUKsM77fkZ0=; b=2d86DHvbQR+XmoHo1C7QBPkO6k
	L7GS3YpNUM84FWOHKUo6xsqDJ5obMyzZuUOnsVsJpdGW6wRFx3U3X9INXucNiZzYxAhyWUD1respQ
	EBY8ojcRu7HdnVPBjyFwZfL6icwPljwA+jP8KwHbnRf3gKvwk+UwLowO3kX5imfFoKFln3C7nf/Hj
	x8LmmPQQ94ad9sTRhkTlC7glocWQW0VO+LNvGaGPiu7dIoxhZ3HOGL1iouecN2SWngPsZvJyJquzx
	fknxaF915LcrbotHiHNB8ltK9DqlSW5vIlJ+jiF27AwjIz/2VJYvqYmfnIGfxWwpXnDbm7WlaQwPu
	JG9i0yxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCgj6-0051gK-0E;
	Mon, 11 Dec 2023 13:53:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCgip-0051W8-37
	for linux-nvme@lists.infradead.org;
	Mon, 11 Dec 2023 13:53:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F2ECF612AB;
	Mon, 11 Dec 2023 13:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0E4C43391;
	Mon, 11 Dec 2023 13:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302800;
	bh=5PfvYngP914UoFoqeziwA++GC230K70pLi1A6QnVh1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sT2ytsi//ttMwWtngR8z/TjFe9xYS1XrkT+GTWghX7po/f/uRDIw4lwT2vKohIe1E
	 U8UL5WaKRpGJynj0ekfaYKVvhTl1Dc7e42emHaRD4VVKz+TniKNfhdRTB+/grGLbjf
	 /G/PA4ad8au57FDk/TcMFYgrdnHxoiV9MuBTWJaIYfGnJe841PMS3/GccgZpBk4isw
	 sb9x3o32zLkPjDUVUkcVDtSiZGD1ZT4pBMf9EBP+0ZQ4WlmKNuKJgycm5vlt0+zK+H
	 ahdc29nwoxgqPghlALQIfFSBdVaLbY0oR8ngCDkHzUmLzL3R/lP3Vx08SVpXnJlq8T
	 zN2ccyJvDhJJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nitesh Shetty <nj.shetty@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 33/47] nvme: prevent potential spectre v1 gadget
Date: Mon, 11 Dec 2023 08:50:34 -0500
Message-ID: <20231211135147.380223-33-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
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

From: Nitesh Shetty <nj.shetty@samsung.com>

[ Upstream commit 20dc66f2d76b4a410df14e4675e373b718babc34 ]

This patch fixes the smatch warning, "nvmet_ns_ana_grpid_store() warn:
potential spectre issue 'nvmet_ana_group_enabled' [w] (local cap)"
Prevent the contents of kernel memory from being leaked to  user space
via speculative execution by using array_index_nospec.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/configfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 907143870da52..01b2a3d1a5e6c 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -17,6 +17,7 @@
 #endif
 #include <crypto/hash.h>
 #include <crypto/kpp.h>
+#include <linux/nospec.h>
 
 #include "nvmet.h"
 
@@ -509,6 +510,7 @@ static ssize_t nvmet_ns_ana_grpid_store(struct config_item *item,
 
 	down_write(&nvmet_ana_sem);
 	oldgrpid = ns->anagrpid;
+	newgrpid = array_index_nospec(newgrpid, NVMET_MAX_ANAGRPS);
 	nvmet_ana_group_enabled[newgrpid]++;
 	ns->anagrpid = newgrpid;
 	nvmet_ana_group_enabled[oldgrpid]--;
@@ -1700,6 +1702,7 @@ static struct config_group *nvmet_ana_groups_make_group(
 	grp->grpid = grpid;
 
 	down_write(&nvmet_ana_sem);
+	grpid = array_index_nospec(grpid, NVMET_MAX_ANAGRPS);
 	nvmet_ana_group_enabled[grpid]++;
 	up_write(&nvmet_ana_sem);
 
-- 
2.42.0


