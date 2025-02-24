Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D74BC021A6
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 10:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Krn4gjvkBmqA/FwymkhlEO2A4LIP8vepXPsLolf9PO8=; b=Vdq5MBlj5vMyGU05ruNuyqwSFP
	MIUSiRWxmhrjg+FuR8cpR39wnR1TrsRHzKE+EpAvW+MwcoaBM2yaBGNXaTHfiMX5Orr4x7xAH+faz
	RcllIqePBKq6C3RU5xyvbaIDMxKsESqYs9bo85uuPEFgaLmbnjSsjedy76n5nQ7HJSg5UsA7leK6b
	FxI0ZcYGfCJGtCdW5arwlquPpgHzCTLeKa6rmL+wCy9+lcMdAi7UhAIm673TyljvSQeU984qEEHFd
	OKxkqIptX1+rUldTMXixjvNvbfqn4wjs2majLRZ/d+i6JNaIhmZ4GtiqQxqjop/D3p/Uzad/lCnCW
	wTYdyK6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmVFr-0000000D1FL-2SfG;
	Mon, 24 Feb 2025 10:00:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmV9r-0000000CzgA-0cpV
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 09:53:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 10BE75C5D8E;
	Mon, 24 Feb 2025 09:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349C1C4CED6;
	Mon, 24 Feb 2025 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740390829;
	bh=g6VMlunQlRDJng03dDx4fAmN66ot/J1KNDpnUBk3Uyk=;
	h=Date:From:To:Cc:Subject:From;
	b=u0usiYCPpGjJz7W/r+tTDedwSQMO7Lzj2OGrQ7vpI1I6Ni/J58p4fjs01N0vVrCAy
	 CupqoMmeyJpmyBT33Swem7HP4O4OA6qZfthw2HnsZgFr0H9T56aiYr5z8HSIvhJ3wo
	 ILS61Ps7NSn2v37GJTsxM5FAS2tS1WmZhYCJYPxRjxaqBATn6A3KKZsis22HoJbvBC
	 y5bUAgcJHr9xYjQfadxhzbrj9AfhEsQrt1QeJxY+PA7PsZYrl0y2GkNEOsO7eMJumX
	 eTDcPsCHnH8iIhJ75t4YE7EeEjvUZNPoyVSCrYXZ1Xo9lYedRKjQFhXI8schHBm7m7
	 B5W68rNG+/KDA==
Date: Mon, 24 Feb 2025 20:23:38 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>, Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-bcache@vger.kernel.org
Subject: [PATCH 0/8][next] Avoid a couple hundred
 -Wflex-array-member-not-at-end warnings
Message-ID: <cover.1739957534.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_015351_240685_9ADE76B6 
X-CRM114-Status: UNSURE (   9.02  )
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

This patch series aims to fix a couple hundred -Wflex-array-member-not-at-end
warnings by creating a new tagged struct `struct bio_hdr` within flexible
structure `struct bio`.

This new tagged struct will be used to fix problematic declarations
of middle-flex-arrays in composite structs, like these[1][2][3], for
instance.

[1] https://git.kernel.org/linus/a7e8997ae18c42d3
[2] https://git.kernel.org/linus/c1ddb29709e675ea
[3] https://git.kernel.org/linus/57be3d3562ca4aa6

Gustavo A. R. Silva (8):
  block: blk_types.h: Use struct_group_tagged() in flex struct bio
  md/raid5-ppl: Avoid -Wflex-array-member-not-at-end warning
  xfs: Avoid -Wflex-array-member-not-at-end warnings
  erofs: Avoid -Wflex-array-member-not-at-end warnings
  btrfs: Avoid -Wflex-array-member-not-at-end warnings
  nvme: target: Avoid -Wflex-array-member-not-at-end warnings
  md/raid5: Avoid -Wflex-array-member-not-at-end warnings
  bcache: Avoid -Wflex-array-member-not-at-end warnings

 drivers/md/bcache/bcache.h     |  4 +-
 drivers/md/bcache/journal.c    | 10 ++--
 drivers/md/bcache/journal.h    |  4 +-
 drivers/md/bcache/super.c      |  8 ++--
 drivers/md/raid5-ppl.c         |  8 ++--
 drivers/md/raid5.c             | 10 ++--
 drivers/md/raid5.h             |  2 +-
 drivers/nvme/target/nvmet.h    |  4 +-
 drivers/nvme/target/passthru.c |  2 +-
 drivers/nvme/target/zns.c      |  2 +-
 fs/btrfs/disk-io.c             |  4 +-
 fs/btrfs/volumes.h             |  2 +-
 fs/erofs/fileio.c              | 25 ++++++----
 fs/erofs/fscache.c             | 13 +++---
 fs/xfs/xfs_log.c               | 15 +++---
 fs/xfs/xfs_log_priv.h          |  2 +-
 include/linux/blk_types.h      | 84 ++++++++++++++++++----------------
 17 files changed, 107 insertions(+), 92 deletions(-)

-- 
2.43.0


