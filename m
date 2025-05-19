Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A889C54795
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 19:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zHd55Romwn0cPwiYwFndbu6faM9Xo1hZyDXyd3z4ETo=; b=tg7vhLQwWP0rHIa86PfuJONHFg
	mdSwxoqqmgz3TMnN/jRsoNtne4SVPUZtFXxNPWaugQ9QpCUaRzizp7SKF25mckdYRYHs7mUxtuM6B
	dZjfVwTtGosAIgrkf5cc78grkuyPbZo22sO3qI7mIQWXi5AcbcBfDH7lBbba2NurNGSbwsrQBRsFf
	2vOw7JV27eXeEILU2dQpCzq4vMtpdLXTswY0PwqEoFlpPXXD4bTvbO9yx4ZzTKq6nYupV14lJYgKe
	nzrS3yv4BN0vNQVHOSyjPOZlwj4oWjJCLvtnxN2WrT7tOovBAFcgUBfJgXujFTrCeBSx80pypaR8b
	Vd4r94eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH6a2-0000000AHdL-1JPf;
	Mon, 19 May 2025 19:55:22 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH4eb-0000000A1ca-1kQv
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 17:51:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9DF4B5C5482;
	Mon, 19 May 2025 17:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27ABCC4CEE9;
	Mon, 19 May 2025 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747677116;
	bh=6UQF5G5Q/IqfsqFiqjSqhb91XPJLD0TluJRUmBXqaqQ=;
	h=From:To:Cc:Subject:Date:From;
	b=dyAmKu5xNvuarM5vll1Jey/CJZjtEoDjLh6iLorHPO/yseAOXLY+oF8lH6ci/8KJO
	 TMuLob6QZg33xzOkRASomXI8c6ahg7pErY5fzW/g4u1uwYVlquLsUIfIZ9n2S7QO7p
	 FwFSqEHmmpX/HpRPYS9GFmC7jgotcyv4sdCNswZXQTLGyEC5BNvSOdhke+38z0btl+
	 JP674PRmUux1BbbsX3YqIbd7z3xI77s5mpsrfLlyplI/DKOfbHAJ8p37Tc9+pvkAXJ
	 oa61PBvhk6Gr78GARy0TGIkjbuqCqeKgXHt+AByH0eLHZsJdqW91nvwZTZLhZbTdnB
	 UFyKvgTEeD8lA==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 00/10] net: faster and simpler CRC32C computation
Date: Mon, 19 May 2025 10:50:02 -0700
Message-ID: <20250519175012.36581-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_105157_510897_41233252 
X-CRM114-Status: GOOD (  11.59  )
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

Update networking code that computes the CRC32C of packets to just call
crc32c() without unnecessary abstraction layers.  The result is faster
and simpler code.

Patches 1-7 add skb_crc32c() and remove the overly-abstracted and
inefficient __skb_checksum().

Patches 8-10 replace skb_copy_and_hash_datagram_iter() with
skb_copy_and_crc32c_datagram_iter(), eliminating the unnecessary use of
the crypto layer.  This unblocks the conversion of nvme-tcp to call
crc32c() directly instead of using the crypto layer, which patch 9 does.

Please consider this series for net-next for 6.16.

Changed in v2:
  - Added some benchmarks to commit message of "net: add skb_crc32c()"
  - Added "Return:" to kerneldoc for skb_copy_and_crc32c_datagram_iter()
  - Added Reviewed-by's
  - Addressed review comments on nvme-tcp patch

Eric Biggers (10):
  net: introduce CONFIG_NET_CRC32C
  net: add skb_crc32c()
  net: use skb_crc32c() in skb_crc32c_csum_help()
  RDMA/siw: use skb_crc32c() instead of __skb_checksum()
  sctp: use skb_crc32c() instead of __skb_checksum()
  net: fold __skb_checksum() into skb_checksum()
  lib/crc32: remove unused support for CRC32C combination
  net: add skb_copy_and_crc32c_datagram_iter()
  nvme-tcp: use crc32c() and skb_copy_and_crc32c_datagram_iter()
  net: remove skb_copy_and_hash_datagram_iter()

 drivers/infiniband/sw/siw/Kconfig |   1 +
 drivers/infiniband/sw/siw/siw.h   |  22 +----
 drivers/nvme/host/Kconfig         |   4 +-
 drivers/nvme/host/tcp.c           | 124 +++++++++-------------------
 include/linux/crc32.h             |  23 ------
 include/linux/skbuff.h            |  16 +---
 include/net/checksum.h            |  12 ---
 include/net/sctp/checksum.h       |  29 +------
 lib/crc32.c                       |   6 --
 lib/tests/crc_kunit.c             |   6 --
 net/Kconfig                       |   4 +
 net/core/datagram.c               |  36 ++++----
 net/core/dev.c                    |  10 +--
 net/core/skbuff.c                 | 132 ++++++++++++++++++------------
 net/netfilter/Kconfig             |   4 +-
 net/netfilter/ipvs/Kconfig        |   2 +-
 net/openvswitch/Kconfig           |   2 +-
 net/sched/Kconfig                 |   2 +-
 net/sctp/Kconfig                  |   2 +-
 net/sctp/offload.c                |   1 -
 20 files changed, 161 insertions(+), 277 deletions(-)


base-commit: a8ae8a0e848e3506c95e45e7cb6e640502495f1a
-- 
2.49.0


