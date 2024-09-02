Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48761CA0ED3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 11:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ME7UYn/7XQCSZlQd4iqv+MYwFM38mmnNTLxgCKd7Cfk=; b=uGuWoZtKf8nTcHTvXwLPHL8l3y
	m3BXejlMiOqzl+bNJszVjXInkcNJ4qVGytcoVZ33w398sM+yEkLUzh01pVczr5wiaSQGA5m55qDGt
	AXkkUGKYEzCqVUMBw/1NSPpnGSjCpGA7GVhRBWO/2yU16JeehYEKzvi5g9yDR9FF1tf1d1BsJpRwn
	/bhp3yvlvoNmRApKIJR1mSmmd+Z8q4uYSl8WaIWBHEDHIyhbykY9Uf4Jt21lGCHAl7hc7pFKJ1HFZ
	sXj6x/eATPwQE60cPkGIXb+tBTNd8gvy7JHvioNmZEhnSwzcddBK/U51wN1BVzQwsvME/EX/Uqwpa
	O1J7/oVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl52N-0000000E57S-3L5D;
	Mon, 02 Sep 2024 11:15:59 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl52J-0000000E54o-3rNq
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 11:15:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BB6D65C4B0B;
	Mon,  2 Sep 2024 11:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DEAC4CEC6;
	Mon,  2 Sep 2024 11:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725275754;
	bh=zNtKtrM314CAiptOnQPF+QW3taJ/oZP/TwjsE2evHg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oIDOvndn63gCqttkW4AJGRR5UGuP0r/Sd18ZxU2S1xJOy0a6ZHt9sJRGI2kR9SiyX
	 zosYLz1nzDJIrgGoy6DbnxDrL+8kIItbRNuv86hQ6nhjt+lYMg0+QpisES8Wm588s7
	 0dDBP1ikwnsWg29MS6EBtihHH1OR99eHLA0yitF+bSCd/hs1QpKDa9y5ZsxiMfCFGT
	 6uNgkYed//y3kAPiL+4FQS60ZVxzBIspstCHUa/PmRe97boHGtwjxaq6tPjq9wWxUL
	 WDr8oJrUJKvTypF5CZ76s0JX++zJw6HnB9UFzc1kCR04mu+SvKbvowhX+AbOOTtKqz
	 EFAaEuWjo5GuQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/4] nvme-multipath: fixup typo when clearing DISK_LIVE
Date: Mon,  2 Sep 2024 13:15:45 +0200
Message-Id: <20240902111548.41430-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240902111548.41430-1-hare@kernel.org>
References: <20240902111548.41430-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_041556_124590_19B4DC4E 
X-CRM114-Status: GOOD (  11.20  )
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

NVME_NSHEAD_DISK_LIVE is a flag for 'struct nvme_ns_head', not
'struct nvme_ns'.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 91d9eb3c22ef..c9d23b1b8efc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -646,7 +646,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		rc = device_add_disk(&head->subsys->dev, head->disk,
 				     nvme_ns_attr_groups);
 		if (rc) {
-			clear_bit(NVME_NSHEAD_DISK_LIVE, &ns->flags);
+			clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags);
 			return;
 		}
 		nvme_add_ns_head_cdev(head);
-- 
2.35.3


