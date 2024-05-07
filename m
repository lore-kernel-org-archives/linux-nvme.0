Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A83BC19F4F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 23:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OrlufrY1vVa82xXygQLUIRx2/RKh5iuZSCOfSc3BLJc=; b=v14VUY9XuTnoWk9rVCGeFEinSu
	lpMqxJdVsdJ7ho542r6arvi0u+FBMYNWq5KxHuzPwSruyMfYNoNBHjYJ0bBf/sRJqgTyBXSPZZivd
	wSPcyxrqp9h7zKl7k/eDiCxTfRJu9TTc/tZTwG6MSMAt5Ij4UuPP22MKdbT87ZFymL/gDLc2o8rXs
	1YdfHI6dJuhX7pxaag46/2x/ChI/z2wpAB5Xna5UCJbTr3yIHsODPQYS0DZ/Nu/7bhsc0w+BICoOv
	bFcfCKPpWvI+ed+i4nIUF/j0618uzs+MfvzLPPRiWOfqBYUh04pRxnGw9ut1Z18LzZTQ0rOn0vIdx
	gmegVPQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4U1A-0000000DD7c-14ad;
	Tue, 07 May 2024 23:14:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4U0t-0000000DCx6-3CpC
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 23:14:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9115261A14;
	Tue,  7 May 2024 23:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6040BC3277B;
	Tue,  7 May 2024 23:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123662;
	bh=jEyNlku0t6GHW7QmWeecYZadcby2sfahyDeKzw51+lU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+sdp+IbqjB8HpGTgUp2RXQZBE1GBJQl5cR0c2uYOGWM2rUoMzTVJe75S58h4sDJo
	 gIWIA1UMU6atNPS8nSjxKooPgAvJUlXZecFM28xkBE4NFXN9rC1z1b4lj9OyCRWeOq
	 cvBNdQ1vb+SWKr5p8uvgY1icjmvLkJFz4Ykj2YVr4+oeeq5Vt1gh8DxspunL1AQNQR
	 q2MkfcnZAfrpSBHULqdfAt0pV9Tb5tnYXEDPLk3Rb+GV3UlYcKl/JvlBwsry4qUgwJ
	 ElNHWVERsSvnZMVZ3h4stu3SdObqRYsywVSHJoKSMcH74zHTi9KE3rihZJY3iFIahN
	 fMcQUtENWyUYA==
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
Subject: [PATCH AUTOSEL 5.10 9/9] nvme: find numa distance only if controller has valid numa id
Date: Tue,  7 May 2024 19:14:04 -0400
Message-ID: <20240507231406.395123-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231406.395123-1-sashal@kernel.org>
References: <20240507231406.395123-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.216
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_161424_077246_FC530569 
X-CRM114-Status: GOOD (  12.25  )
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
index 379d6818a0635..9f59f93b70e26 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -168,7 +168,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
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


