Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C17BC04FFE
	for <linux-nvme@archiver.kernel.org>; Tue, 14 May 2024 17:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=k2gBSujYu31mPPvnyQiVHOQf9CToyTM3g/ONiXjGE8E=; b=SqGwxZ/q4ic6HritP93oj4tbI+
	2/UqV7sGzcj0/qskTYSYyu1Nehds9mbdwHmU+Vy55RNFj+H7rCnu5QrVNs6LWuYrEm0OM2/mHAXkO
	LYzjScpnGo9dKV/Va4L3FDIyU9QWFjT3cqMbIyxUmOQ7ILaq86oyo5WlmNGy7kgRBNSQe52S1OvQt
	lgA20aeYqFIwaQT+pFvN7UpYzeSr9Y2Vw/v0cMHFnxBbkY3y23v8JW0DuODlS4D8a6Lic6DoLNcNd
	EuTED5NYTWMMEeI+jApC0ltGXmr/8cRxs/keoGOd2gMElk53swrXQAMNIF3YthtPDwSBzsCPMRKxy
	CDYh5IPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6w7V-0000000GgA3-13K0;
	Tue, 14 May 2024 17:39:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6w7S-0000000Gg7s-03dB
	for linux-nvme@lists.infradead.org;
	Tue, 14 May 2024 17:39:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6C67E61227;
	Tue, 14 May 2024 17:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91018C2BD10;
	Tue, 14 May 2024 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715708356;
	bh=/peSAZG0cb3BX+DST69d3XDZ+Ks8vx/0fVqM+mOIwq8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZaranJIsD3CjnPayI//xhe97b/b2Wuro5rws+anPjSrkaC8btmIs/aL0HXe+tHE2Z
	 ga0kl4ua0ml4wksoeydFJARI/R94Dh5TEJ8kecxqW1oCjmiWRT8w6wq2um59f6JDGe
	 tyxpDWZN1MIv6hI6uqMIwyzrqMXnDOZtMWWN8OzwWM+H2uhMOdV9mK3Wg1g/9AD80n
	 atlUEQnN1JUdN9JAslIK3k9VKXwoWwE4YDMn9a6kSgDOTtaBwjsiKOJcGe+ztbrFOy
	 8V6jIrwM1mctqPOTC3kCgVy1TcxPh2ku2MWZZusVJaJ2wjd81nSlrrDYJumFvPPB1k
	 Pm7bPN5OI4Yqg==
From: Hannes Reinecke <hare@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv2 0/6] enable bs > ps for block devices
Date: Tue, 14 May 2024 19:38:54 +0200
Message-Id: <20240514173900.62207-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240514_103918_123543_3FA2449B 
X-CRM114-Status: UNSURE (   9.75  )
X-CRM114-Notice: Please train this message.
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

based on the patch series from Pankaj '[PATCH v5 00/11] enable bs > ps in XFS'
it's now quite simple to enable support for block devices with block sizes
larger than page size even without having to disable CONFIG_BUFFER_HEAD.
The patchset really is just two rather trivial patches to fs/mpage,
and two patches to remove hardcoded restrictions on the block size.

As usual, comments and reviews are welcome.

Changes to the original submission:
- Include reviews from Matthew
- Include reviews from Luis
- Fixup crash in bio_split()

Hannes Reinecke (5):
  fs/mpage: avoid negative shift for large blocksize
  fs/mpage: use blocks_per_folio instead of blocks_per_page
  blk-merge: split bio by max_segment_size, not PAGE_SIZE
  block/bdev: enable large folio support for large logical block sizes
  block/bdev: lift restrictions on supported blocksize

Pankaj Raghav (1):
  nvme: enable logical block size > PAGE_SIZE

 block/bdev.c             | 11 ++++++---
 block/blk-merge.c        |  3 ++-
 drivers/nvme/host/core.c |  8 +++----
 fs/mpage.c               | 49 +++++++++++++++++++---------------------
 4 files changed, 37 insertions(+), 34 deletions(-)

-- 
2.35.3


