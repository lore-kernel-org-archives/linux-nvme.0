Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89C9CD13CF
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 11:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EbG3/uDuvktVoi6GV7RU57cyrggN/hLVsPLLl6oe8Fg=; b=3GnAHlV16af2r3aZ34fV5DZsJa
	81rZAxTq5bBwJl1mRMuvcXsshRDvAm9acgXzUQ8/2QDCOvQ9cbs/rV80dnuZQ2XAOFIpZGr+9R1Xz
	IzLlJQKCbsF6AkCVOtxeAk0rCBwkyvW7HKwdUMtdFjS3MH0t9xc0TgqBD0YEJ0MetdesxULWTjGbY
	uhKfWHEaqOSGtPzh4KENxHvZqBDBvDETu97Olt2foYKMrV4JzsvgekjzXqtoZf3iZQeau9qI0YldG
	/A31sdQdXNW4IGRCGpn74401ZvPR720iNmQtBX3eY+F2oQK7vXjf6pBJZSgKaQpZ6+lfdumZyAEp3
	s+9FDe4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl52M-0000000E56S-12GP;
	Mon, 02 Sep 2024 11:15:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl52I-0000000E53i-2Yxs
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 11:15:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1347A5C57D9;
	Mon,  2 Sep 2024 11:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F43C4CEC2;
	Mon,  2 Sep 2024 11:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725275753;
	bh=TZh4IeOGtz0bQ3n6eik4tkyWzFZtb7Hb+Vl97/C6sMI=;
	h=From:To:Cc:Subject:Date:From;
	b=J7RIa7r2958IKQctyltfZXrPfqPbQxMsQWV95Llnsps4PJxYHc4AI94y4UVZCShJW
	 a64bHgBsBDl3vWsezzoX582B18xBH78U9TGTQsU4fg5gFZ1/9V15qfit3GC2Ee4r5b
	 WQysNApYVfUo8dc+UmxW7ZP9aKFFEA8NVw+mr7NSZt8FH6tuMQht9muhF/MOoMQd7k
	 LX6OGVVLeD2wCF8dgvSUmIVE/YuSUCluP9RME1ghGj89SdWPb3hHrDBqrf5opH/OOF
	 oT7ET7+Z4SWHZTwKqJiHUHxB5EIOF/6313x84EB67I1vZJLfNF+F4V1yfuQG/9gQvR
	 qqAQmOhiaRtow==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 0/4] nvme: NSHEAD_DISK_LIVE fixes
Date: Mon,  2 Sep 2024 13:15:44 +0200
Message-Id: <20240902111548.41430-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_041554_734709_D5D0A2B6 
X-CRM114-Status: GOOD (  12.02  )
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

Hi all,

I'm have a testcase which does a repeated map/unmap of namespaces and
changing the UUID for each namespace after unmapping.
This leads to an unrecoverable system where the scanning processes
are stuck in 'device_add_disk()' waiting for I/O which will never come
as the I/O is doing ping-pong between the namespace (which cannot
do I/O as the path is inaccessible) and the ns_head (which is not
live and hence can't do I/O, either).
With this patchset (and the queue freeze patchset from hch) the problem
is resolved and the testcase runs without issues.
I see to get the testcase added to blktests.

As usual, comments and reviews are welcome.

Hannes Reinecke (4):
  nvme-multipath: fixup typo when clearing DISK_LIVE
  nvme-multipath: clear 'NVME_NSHEAD_DISK_LIVE' bit on shutdown
  nvme-multipath: check for NVME_NSHEAD_DISK_LIVE when selecting paths
  nvme: remove existing namespace on ID mismatch

 drivers/nvme/host/core.c      |  4 +++-
 drivers/nvme/host/multipath.c | 10 ++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.35.3


