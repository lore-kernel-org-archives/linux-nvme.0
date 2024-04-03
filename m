Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A8BCD128A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 14:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vJTsgSbL8VG7p/U9Cu8CkcGzJM3BnNaX4BMsrcA1Er8=; b=4b2dvl2EEKLqliJGTG1BruAcGy
	nhFTfOspvYK4y0LCCWPJoTg7CY8WKZYaZ2eLivAx8sygLyRsiu6ISCmCTyXyxaOw9dQ5ppeNDLhzo
	t39utxJusDl5nP9VQ//b5EqH2N7BYnM4RCytpPmnMy6Vjd7I0l9Wo8TaOWgI3jY740GQQ12jY9rkn
	IVkWJN6zFyPvBGyk5cNwmvfBy62/voccX0L8dIR2v24wphufnbxZMK7B7brrtRshSfKVVHKTMzlgr
	A8c5Cqkz8xNygKoL0Wj71PmnTGN5Z+378FZo6ODfF/QMKfU5w3u7ZR70E4AdxrY1RHfeMjzh5NARB
	m0aanAaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs1Rf-0000000GQdi-27wq;
	Wed, 03 Apr 2024 14:18:31 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs1RL-0000000GQMH-30Gn
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 14:18:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id EF42DCE2AFD;
	Wed,  3 Apr 2024 14:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443F0C433C7;
	Wed,  3 Apr 2024 14:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712153886;
	bh=5WLxOnkBJjo+0/yjmhaPs0wdHBWPf/7+izSo8rpQdYc=;
	h=From:To:Cc:Subject:Date:From;
	b=NuWtTg5KxYV2VyFxLPwASt9nk5SyyAAczmPsX6EqVXaE+uy0yZTf+Qg14SSrtFhH/
	 1d64qMKMjSK6F6ho+1suRE9a6BymHSKdGfGlPSwlfjp0aTEW1/9Bke0R3hT06E+ADy
	 5RyCeU8DMjya/pZ1QOkZXgyZvUXLR6+29DC854Ek5hDLigHSKd3ulX5Z/Kccpip8Ey
	 SU33r1KwSqFZB4lTwdPKTkF9+zBoq4t3wx4aNRC23KNx5W8ZbFyRnqT/wSdxAwi6qW
	 re/WQP81gDnWrsC3vUSqpkH5bJL/wFzsiSAYf6TI5n1Abd9qN5qP4WOQA7QQBmiNis
	 BfRRRHp4HlgMw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv2 0/2] block,nvme: latency-based I/O scheduler
Date: Wed,  3 Apr 2024 16:17:54 +0200
Message-Id: <20240403141756.88233-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_071812_561714_03A0AD0D 
X-CRM114-Status: GOOD (  11.91  )
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

there had been several attempts to implement a latency-based I/O
scheduler for native nvme multipath, all of which had its issues.

So time to start afresh, this time using the QoS framework
already present in the block layer.
It consists of two parts:
- a new 'blk-nlatency' QoS module, which is just a simple per-node
  latency tracker
- a 'latency' nvme I/O policy

Using the 'tiobench' fio script with 512 byte blocksize I'm getting
the following latencies (in usecs) as a baseline:
- seq write: avg 186 stddev 331
- rand write: avg 4598 stddev 7903
- seq read: avg 149 stddev 65
- rand read: avg 150 stddev 68

Enabling the 'latency' iopolicy:
- seq write: avg 178 stddev 113
- rand write: avg 3427 stddev 6703
- seq read: avg 140 stddev 59
- rand read: avg 141 stddev 58

Setting the 'decay' parameter to 10:
- seq write: avg 182 stddev 65
- rand write: avg 2619 stddev 5894
- seq read: avg 142 stddev 57
- rand read: avg 140 stddev 57  

That's on a 32G FC testbed running against a brd target,
fio running with 48 threads. So promises are met: latency
goes down, and we're even able to control the standard
deviation via the 'decay' parameter.

As usual, comments and reviews are welcome.

Changes to the original version:
- split the rqos debugfs entries
- Modify commit message to indicate latency
- rename to blk-nlatency

Hannes Reinecke (2):
  block: track per-node I/O latency
  nvme: add 'latency' iopolicy

 block/Kconfig                 |   6 +
 block/Makefile                |   1 +
 block/blk-mq-debugfs.c        |   2 +
 block/blk-nlatency.c          | 388 ++++++++++++++++++++++++++++++++++
 block/blk-rq-qos.h            |   6 +
 drivers/nvme/host/multipath.c |  57 ++++-
 drivers/nvme/host/nvme.h      |   1 +
 include/linux/blk-mq.h        |  11 +
 8 files changed, 465 insertions(+), 7 deletions(-)
 create mode 100644 block/blk-nlatency.c

-- 
2.35.3


