Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2981C25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 12:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kGhZJmGbQ0Cr5mNkeWpVOXiFbg8QgnZxBbvdD78egvw=; b=vxUyYHSnyuic16BuYbVH7HV+Fr
	VybqghlXOvRBnGGgktZPvijiX0+D3gTGCzXjUl5cgl98nhRYlhaH1U1I3lFVNsFUVu9/q5uukXBYT
	vvwHxtBTttfruJa0394F187f+aC0wqypdZAkUznVtDRmrjVKLRvgmIrHFGxFlqGhNDxEaCDh7ELcK
	2M1pNW0xwILl23wyOchJoOhk7Fn5yBkXLVBmZAy3To4L3Bbe/AoY0cEv6M9F9psujBAsP1rQRhtDB
	dO1lOeXxNxOadu3XOPSy0DhLabuhhAFUscm8mCXrsNROUIGWyrHw3pn0fT26CU7gAxY/RhWvZC2ec
	4KQqXbFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpLX-00000005q3h-4BIT;
	Wed, 05 Jun 2024 12:02:27 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpLV-00000005q3D-10u6
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 12:02:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9259ACE16FA;
	Wed,  5 Jun 2024 12:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B87C3277B;
	Wed,  5 Jun 2024 12:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588942;
	bh=nUrzGKAlcTVG27/8nvDQiyvFFzUX6+tQO0eRQHx673k=;
	h=From:To:Cc:Subject:Date:From;
	b=XUAqZR1Ia9cJ54WN9Z5NmlR9Ip0zPR9ZVwpLMT7f4/nKzExyCHNnHVI1HR6zx6EO/
	 4yhiTRhi9whL1EHg0kHIUbWGopqZrPo6+pCMWkGeO2rOAoGqdwjNwSdVmvwGLAROlp
	 jdSg3JdR31d7hTXetuBHYm+mKP3lIkPIfTWxCDSEZeKncluEaPc42H4U2uhmG+xCuK
	 eHcIYXb8X/HylwuxSZGhjqWDrruIDZD+BlSy2N1hwyw+U31ERVU5qCdkcfjZjw5nvn
	 Mvf081PONT1DGr8JJBF2zatmHoS3j1+e9JrRXqzDxXgzsZda73rThUelWJzx4BV9hE
	 nLe/C/wUxRg8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.9 01/23] nvme-multipath: find NUMA path only for online numa-node
Date: Wed,  5 Jun 2024 08:01:44 -0400
Message-ID: <20240605120220.2966127-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_050225_484347_FE5C4092 
X-CRM114-Status: GOOD (  16.90  )
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
index d16e976ae1a47..9c1e135b8df3b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -595,7 +595,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		int node, srcu_idx;
 
 		srcu_idx = srcu_read_lock(&head->srcu);
-		for_each_node(node)
+		for_each_online_node(node)
 			__nvme_find_path(head, node);
 		srcu_read_unlock(&head->srcu, srcu_idx);
 	}
-- 
2.43.0


