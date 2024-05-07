Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFF6C25B4F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 23:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nC8DSj4Cp3iNi+xUuS+nKG6RidfbmnWqoQplnTqD4pM=; b=sC+4tGSqrYF6I2FZ2u3KlPL7s2
	/Ere+KwlBi6Q7JOezWB7DhjNao3ITOf87zTdlbyooq/dP1MPH9+bnCEIbE/ki1nhwSRvDtoIQy3a/
	wlio8Jp6/HB84KzBjIYIGKeRRZtr8C/TLi6qyFOyjBRi4YzpAIxIFLGoM9/dzGMWTjgkSWzPZxLly
	1dgNFIyQAqLLzhMYjjs7sE57t/YIASgtir+czHlBeowIpOj4d3y0OFEoltT7VnJXAgYXfzicJzuL8
	syvVpWMcLCTQfQEAaITIuhtDrLle0Wu7pVceollaPK8KUrmDOcbOpz/Rhq5iCx3XsmkNRsIwa0SaC
	zWbAo6fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Typ-0000000DBXR-2bNO;
	Tue, 07 May 2024 23:12:15 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Tyf-0000000DBPz-0mnc
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 23:12:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7870BCE174A;
	Tue,  7 May 2024 23:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB164C4AF67;
	Tue,  7 May 2024 23:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123522;
	bh=BW3sS1jeUTOlQ8ybavzsM9YtTj8gFtolCcVVBcb4G0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sCgL8TLt9qi2S4jyu7/OFC26vDQH4FJivgTaMqRQQ8UisrgI8lqD/bRXifuSXIO27
	 3UgYtT+w3KkWE3S1TNbaLTx9Ope5px33iGcdy6UB0d5AJkPtL557RG1uwmbDrq3iSl
	 yNBb1u5rU+pvopne/OHxs60swidLzmdE2GkIIzoTdSbTeQGz7Ykv415sAQp93rkHuG
	 rDW6nxa4V/LhBi8ZX0Fu4S0MkogumRc4r45Le0jRwtCgVIBzts9zE5qpeo4YCqrxsZ
	 aLNI2UYIkqaQRAYprRhl0RlG7deLUP2sqVxzd13keXMTKvH/h4eNPwEhHsL5AnpMkL
	 OZRWoDNwf/Quw==
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
Subject: [PATCH AUTOSEL 6.6 37/43] nvme: find numa distance only if controller has valid numa id
Date: Tue,  7 May 2024 19:09:58 -0400
Message-ID: <20240507231033.393285-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_161205_552797_13C3E1B0 
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
index 0a88d7bdc5e37..b39553b8378b5 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -246,7 +246,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
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


