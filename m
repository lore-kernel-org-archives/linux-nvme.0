Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D4FC7EE2C
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 18:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z4ssDNTbdjnvyf9H6decjqPCDvRA78WfZlTwv5K5yLM=; b=Vv4+RFN3xIY0sJ6OVw/2TqnCZn
	3oNzrGV6JrdYh8yqDYyQxZ8vTiD7rJDKECCKmJ2iYZeozgWTGTEtypabD8+oiPOdC4ITOz23V8l22
	LwFyBfqb4060MVLSTZRp2MUvHKu+UUO5YTPUtKipad2jvGkzy0ipMEfNAzPEC1M0byzBn4cdpg2uo
	7IPvCZz+VtnZjNXaVSgm2ENEJVZxn2xuvsvL3BqeT5AOOiNic5nRGj/ctWuO9LgRrwoDYma0K/U3N
	4jZtWjh3rXhFZDLB2/jZDb6CCCCa4fORixACq8HLH58Sco1MKX9WoHFyMtTdfqJFYPbCjLWK9uH8O
	GvYKWG7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FtM-00HS2n-0d;
	Thu, 25 May 2023 18:40:52 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FtF-00HS02-2P
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:40:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5704A6111E;
	Thu, 25 May 2023 18:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13140C433A7;
	Thu, 25 May 2023 18:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685040044;
	bh=olsUV6eDcmHnx/fL5hia89UDW05rIxgTusM4aF0wg/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MfqbUVb4Lz+9U97rNROl7OjNyO3dbuy4pBwUa7TOBy1pcKd7o8VXqthCf5h1deFDT
	 uzLrUnFFGke3cb1PAfEdFgBY9NnGmMA2qP8xgMX7y1zkl69y6JDzkhoUOeE29QvdZ0
	 /EuoKC9YhIvTEpqB1vflDjjztKuofsPzc3Qso/Zg+5GdHycc+P0ctrP6QudWcSkguM
	 JlP1rEjeglDLMsurRmYccd/JjPVZ3DW3aBZ7AYSvRhJ/HDBU3l3VJxG6KBW+zu48UD
	 fS2ZmO197emCRwS7dhgFqpXYIdzBYQ76zMNe4IdqYr0NipT2VLDEoXemxALtoi5qhe
	 mDTv6SFZr8Dvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 37/43] nvme-multipath: don't call blk_mark_disk_dead in nvme_mpath_remove_disk
Date: Thu, 25 May 2023 14:38:48 -0400
Message-Id: <20230525183854.1855431-37-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183854.1855431-1-sashal@kernel.org>
References: <20230525183854.1855431-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_114045_826774_94E370A1 
X-CRM114-Status: GOOD (  12.05  )
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 1743e5f6000901a11f4e1cd741bfa9136f3ec9b1 ]

nvme_mpath_remove_disk is called after del_gendisk, at which point a
blk_mark_disk_dead call doesn't make any sense.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 8d97b942de01f..73eddb67f0d24 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -821,7 +821,6 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
-	blk_mark_disk_dead(head->disk);
 	/* make sure all pending bios are cleaned up */
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
-- 
2.39.2


