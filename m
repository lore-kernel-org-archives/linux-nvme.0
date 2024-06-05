Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F77EC25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 12:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AjHCSCrrFj6jkDDN2Ay1P8HQ19//2OXcelFooXLB7Sg=; b=r35KtM1+6lFwbYHr5Znk3fRKeE
	NxbH9WfavmITDGM5+XC6dUzmL78O+XNvxnA6YAWo1yBetMsZvp4l0dsqVTNzU5DFkys9M+ZtydcBu
	9mZPNqNDTqCJKQfNhApGFBToZjpoLoBI5jFGY8sJS3YczcZK3X5sBGdM3DKby5JjaW38KbI9oDz23
	8ZPhMFRWUr/IbhNOG7QXpLvywIOcOFfNM6Z+8GT8/NEnPX2szEuUB5q8+AtGaEfkPnfe+ZN92+8D5
	/sqIeV4JvORM6LBhnk27Px9NlgEVNE+W52U0WhOTx29dOWA/aYrj0o32h37TQOcxUsYLuaUqz2IKX
	Sz6CvVHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpP7-00000005s9s-09P7;
	Wed, 05 Jun 2024 12:06:09 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpOv-00000005s2G-3PsB
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 12:06:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D11D761852;
	Wed,  5 Jun 2024 12:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A416BC3277B;
	Wed,  5 Jun 2024 12:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589156;
	bh=nVJRpRaHgI+nkFlBEpSJxAeDE8zbvLSqEEqAymsMMJ0=;
	h=From:To:Cc:Subject:Date:From;
	b=JszvcpbW45EYPcXuA8boXylLE9f5o38xvpBQPtqyqAXLLRjaUazyLEj2uQWPTv6Bu
	 R4ZRruuTlz0THdOjDb2HWp68ho5mReMFXEv7Ec3XVFcfDYwS0aYxxi7SbDatGz4LKl
	 wDyRKwEbg6kOWJU1dDr5clTPn76mk4dn8ssXppzyao3IYgHWa2ckb8Q54xs7rjj+oi
	 nk0izIh9dEQrxn7orgHpiKX1C9YnsrwL3uGVOrM3o7+xqZsHDuWYesWdf8XYzq6ESU
	 FXbfAn3xw3oFFa7VARXwC6L4I0zjFmdmLvDC15Moo1uS0iIDJ2+TUoTVnyas5MBJJS
	 3nY77hckZOW3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 1/8] nvme-multipath: find NUMA path only for online numa-node
Date: Wed,  5 Jun 2024 08:05:44 -0400
Message-ID: <20240605120554.2968012-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_050558_409094_D6A812B0 
X-CRM114-Status: GOOD (  17.00  )
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

[ Upstream commit d3a043733f25d743f3aa617c7f82dbcb5ee2211a ]

In current native multipath design when a shared namespace is created,
we loop through each possible numa-node, calculate the NUMA distance of
that node from each nvme controller and then cache the optimal IO path
for future reference while sending IO. The issue with this design is that
we may refer to the NUMA distance table for an offline node which may not
be populated at the time and so we may inadvertently end up finding and
caching a non-optimal path for IO. Then latter when the corresponding
numa-node becomes online and hence the NUMA distance table entry for that
node is created, ideally we should re-calculate the multipath node distance
for the newly added node however that doesn't happen unless we rescan/reset
the controller. So essentially, we may keep using non-optimal IO path for a
node which is made online after namespace is created.
This patch helps fix this issue ensuring that when a shared namespace is
created, we calculate the multipath node distance for each online numa-node
instead of each possible numa-node. Then latter when a node becomes online
and we receive any IO on that newly added node, we would calculate the
multipath node distance for newly added node but this time NUMA distance
table would have been already populated for newly added node. Hence we
would be able to correctly calculate the multipath node distance and choose
the optimal path for the IO.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 379d6818a0635..a4e8e7f331235 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -419,7 +419,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		int node, srcu_idx;
 
 		srcu_idx = srcu_read_lock(&head->srcu);
-		for_each_node(node)
+		for_each_online_node(node)
 			__nvme_find_path(head, node);
 		srcu_read_unlock(&head->srcu, srcu_idx);
 	}
-- 
2.43.0


