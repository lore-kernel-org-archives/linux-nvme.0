Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC997C25B4F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 23:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1L54T9LZ5wRdLvNusQHE/gbiBvXsuGzoJAzKtkd6zbg=; b=d8u6re2ZaP6pGN/ejuyexyFk7q
	Aa+adQVdfbN3+JgTQu9XZzHHrMqMnZ1m/j/z4EztrflcxfomvTWe3kykokUWRe4gxdBDNn9jcEXr+
	bEQADn7SuwR/W6uwMPwjJHO6AHVed/ClgxBYc+UTh1Xv6LkPpfgAYbGatd/hWkbLHWpzStwTzQqh7
	1mEY7RYxOwWJCmhbIE9XreoTD4R870pEyEOPU2cAX4IEQO/6eAYbCcgTF9hUDSJfO2J1170nKJEdl
	lBj4W0soVnZal5uOyBGWHUPRCqdWy5Gg65v5vbWoRR6L+5NHOzS1z+nk/WPE2KD+haufoR57J4Hi3
	eJvr73EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4U01-0000000DCNW-39AE;
	Tue, 07 May 2024 23:13:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Tzy-0000000DCLY-3qZO
	for linux-nvme@bombadil.infradead.org;
	Tue, 07 May 2024 23:13:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1L54T9LZ5wRdLvNusQHE/gbiBvXsuGzoJAzKtkd6zbg=; b=LoyfycKLJYVgsLkcxZPkIHt2Pk
	HIsZeK7kgXEStDtjULKVWNyk+QBEtlw85DrUCbUucgiRuyt+JDZU1mXraooM8HZVp+086N5Njs2Sb
	H9POgHWUaBc8C3vPC4VAlqxiIpp7CskmEBY9UpxfQzMa29c8JD+NZIc32aj7O0wHAuo61U5tpHplo
	mlRTd74dk1VRM5b9kLRPd58I0YGUJ/5O41NeB6lEq/IRvV2PqQxOcHXkdtTGveP8AICngCM9iFXEM
	ymj3HEbReSDp5XXLRNuPaRZfgSdHb0LAEVsKOVE3p58K8zVb7Ic0u2BnjYJwfhJsHPa41IWJLWXXO
	HXwVIBWA==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Tzr-00000002HEx-2gjA
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 23:13:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1AE6361A21;
	Tue,  7 May 2024 23:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1BEC3277B;
	Tue,  7 May 2024 23:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123596;
	bh=EKN08DW9s7MzrLgAqdyreXAk1J29WVSlpid6Z3QJLFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aeqz4a1AC2PlBWWpEFEPn6C6yH6g5cQFAPkVWP6olQB84fa0O1Dl57AUNRX7xc1XR
	 zkUTI89BpwyHRzKHYD0FBvGmGMKoGrfJHz1C7+ePfe3z5ObuV43ctXeX+zDqVUEYH+
	 tctnmr2ialhB1wDL7KflApXOu3zeNjFlTlAt4IhCYbuATmIqwPtI0s4jrZvg1EsxyI
	 AFwsLcbsAYJ0SOABH/8w4/JbzQ4aFT3ZqsLnrPbjhmGO1iF/VyDXCWbHyT6PfXGdV+
	 pM6JlE4bVJEwmMzdpp/vI7UmZWyWSLCOp1vQWcYmk8dlU7oCPjx/RWIbFwyjk+iN7D
	 pumfViqVZ9KrA==
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
Subject: [PATCH AUTOSEL 6.1 20/25] nvme: find numa distance only if controller has valid numa id
Date: Tue,  7 May 2024 19:12:07 -0400
Message-ID: <20240507231231.394219-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231231.394219-1-sashal@kernel.org>
References: <20240507231231.394219-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_001321_636038_70A63A20 
X-CRM114-Status: GOOD (  12.20  )
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
index f96d330d39641..6cf0ce7aff678 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -213,7 +213,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
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


