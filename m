Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E99C19F4F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 23:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3YZ4qfNGh3AdAjcZclXPVurgt4rVN0eN8g2Qf5OQLoA=; b=REI8J4yyokHNv6VrMwRDpqD52K
	NfwTPZz7q3RxY/IhNRf5UaZtLzieHKAuWmmzZ4okLiftY0MICiOPmchDIu3p4HlH2KHRQi4wmpI8H
	7nx5LNM5mdK68gx7N4Lo3k/BYqwsoP1aYVcEVgzWP9T395D2znINjfI3j1JZf/KsJf9bR4CMTD1h0
	aYBIQEdK8Fxkje3gmEnma2UBmzzWDMFTMij/go6wrLtfAU/c6sDkBJAywoonBy0dzArSy57M4XwFw
	xeasrr6kJECvswKG8LX25ypJSIk3pkA9YSDQul9BU0p80xFpHmZ9hUU462kQ+arHQnFdTdcTAjpt0
	yn50YmdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Twb-0000000DA8i-2pm6;
	Tue, 07 May 2024 23:09:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4TwX-0000000DA6k-31CG
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 23:09:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 14A2661A1E;
	Tue,  7 May 2024 23:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D779CC2BBFC;
	Tue,  7 May 2024 23:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123392;
	bh=eReVYF2BCrlIPA5oKYsRheyDizBUKVOYu2q3Y2uoyew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cqo8ySPwk3C0pG13Dmd+CcADEH/cn+FxaMYKxGqDRKs6SuZmm7Il0g70uW5wsfTFE
	 WSyYIc0bDCdYx8h5seI7L3MP20FaKBwHsTaHwLBrGKWMqRu26GA8QkvAZ+Sj7pTSs2
	 UClHaOCl+pRDCuWEmOgl/SHCwQJPyqYFLRqEV13WizCtk/ZyDv57V62tsmOIyN8GMY
	 rQSDiQ/I2+UmcJwPh3jX9QWQu8ZWdm0atYIcePiv85/QqbmyoYmatjFhgxdLyiS/qs
	 gqY56CnRzrtu1g9yo5kfZCn/Fv8xvkwy+z2JoWufQr/glGuMzJvlMhN9ftIwiwGJoZ
	 lW/8O6cGd67Jw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 45/52] nvme: find numa distance only if controller has valid numa id
Date: Tue,  7 May 2024 19:07:11 -0400
Message-ID: <20240507230800.392128-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_160953_837779_C19F4C4C 
X-CRM114-Status: GOOD (  12.34  )
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

From: Nilay Shroff <nilay@linux.ibm.com>

[ Upstream commit 863fe60ed27f2c85172654a63c5b827e72c8b2e6 ]

On system where native nvme multipath is configured and iopolicy
is set to numa but the nvme controller numa node id is undefined
or -1 (NUMA_NO_NODE) then avoid calculating node distance for
finding optimal io path. In such case we may access numa distance
table with invalid index and that may potentially refer to incorrect
memory. So this patch ensures that if the nvme controller numa node
id is -1 then instead of calculating node distance for finding optimal
io path, we set the numa node distance of such controller to default 10
(LOCAL_DISTANCE).

Link: https://lore.kernel.org/all/20240413090614.678353-1-nilay@linux.ibm.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 74de1e64aeead..75386d3e0f981 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -247,7 +247,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 		if (nvme_path_is_disabled(ns))
 			continue;
 
-		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
+		if (ns->ctrl->numa_node != NUMA_NO_NODE &&
+		    READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
 			distance = node_distance(node, ns->ctrl->numa_node);
 		else
 			distance = LOCAL_DISTANCE;
-- 
2.43.0


