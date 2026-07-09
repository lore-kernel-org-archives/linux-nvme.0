Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A382C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 12:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K8rZsYfKqh8ovcXw7o3S/4TJwBou6C72ZHTzfJTtwDE=; b=H1w1ltyqBSboGWK4OOHhNM5PRj
	nwVRKSkfyjXyslmEE2bDHyYZxmUwIC6eJVNOjrBZZZQDttNinYON39tmnLRPxxAGRdmadY7uo2Cxa
	Aq8JbhNp2fbn3Q1ZzDUOgocGP/CkX2p1ozPQe6EJ4ui03h18A1M8BWbO2ApAVOjndMxOburuK7oZ9
	j1smmfdr+sNpRLL/KBwkoxOezGFfZnKUyR/uRaaYHADVQQ6fjkd2aZvRi6ONUt+IjXjTJeYr1L6+q
	VUfDmyevJXGSfClvlFbQW2BZ8QUGRh6onuaEaLc2bOMiuJhvnO83JOl61nRAFCjqd+ClvNNbYNWjm
	oVT222vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whntn-00000002PhB-0SZo;
	Thu, 09 Jul 2026 12:30:39 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whntl-00000002Ph2-3NmY
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 12:30:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DD82C601D9;
	Thu,  9 Jul 2026 12:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200051F000E9;
	Thu,  9 Jul 2026 12:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783600236;
	bh=K8rZsYfKqh8ovcXw7o3S/4TJwBou6C72ZHTzfJTtwDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1NWYhZ+oO8VtYC7OeI728VPfofHDsj3u2KheK2X+n/5CMebga0B//jvmwa1lKDmEl
	 xtuX228jXtrFm766jrg9kkKA/mPoWaSP1wxICLzhgdN0PkKxBRBCBTrU8QJc9KxvnE
	 IRxblEi5HCpJ9dvuo7Y7AFGKOB3w5tjNk5gVSxzY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] nvme: clamp FDP nruhsd to allocated RUH status descriptor count
Date: Thu,  9 Jul 2026 14:30:33 +0200
Message-ID: <2026070932-fried-frying-9c36@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026070931-stopping-cost-239a@gregkh>
References: <2026070931-stopping-cost-239a@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=PA8MEk/isiRvoD4Y1PDdctB4RwX1e1zanaIxVF2oOsc=; b=owGbwMvMwCRo6H6F97bub03G02pJDFn+UzL+TeU99PVX0XulTRUHYq/xxenMf1KQw7Hh0VVFR mfeKpvzHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjARmakMC67Vpl53sTKQ6dyo IZ7wYkn8ivLH1xgWdKT9jHhWdfxwu3DLlZk/Onz27fVjBwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
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

From: Hari Mishal <harimishal1@gmail.com>

nvme_query_fdp_info() allocates the RUH status buffer for at most S8_MAX
- 1 descriptors, and then copies ruhs->ruhsd[] into head->plids[] using
the controller reported ruhs->nruhsd directly as the loop bound.
However, that count wasn't taken into account for the actual buffer's
size, so there was a chance for a controller reporting a larger nruhsd
to cause the copy to overflow the buffer.  Clamp nr_plids to the same
bound used for the allocation.

Assisted-by: gkh_clanker_t1000
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6505da5c5ebe..62a7adfdab99 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2361,7 +2361,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		goto free;
 	}
 
-	head->nr_plids = le16_to_cpu(ruhs->nruhsd);
+	head->nr_plids = min(le16_to_cpu(ruhs->nruhsd), S8_MAX - 1);
 	if (!head->nr_plids)
 		goto free;
 
-- 
2.55.0


