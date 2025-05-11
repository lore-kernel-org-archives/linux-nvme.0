Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC49C3ABC9
	for <linux-nvme@archiver.kernel.org>; Sun, 11 May 2025 00:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X2fmX4A1PHYXU2aOKfkvVRjXgyMr5BSWn/YGvucVzVg=; b=3aI3WB13/3oiVcrf/ps0KdJlre
	jhFxZuAeK+1E8lSoF0LGM/kP0t91Dk4d5FnFm3FeQHB5qwN8p3z3n98cVQ9v/uO6My09mthkugEcU
	RZ+sDl4KCSLNbWkCK7Y/7igleD7xE28VYa3xF5LBxXLAzOUpeqkKIlY3RgIq+iAqj8R6CbfVth1w2
	eqyfJrUxsh+puvKcGfxtfQhVOaiqIKn5pl2o/pYLf8O8ykOot0dnf9uUQLq4GBmaZ2RtyAJ37GHC7
	d8CAmvBv9APuRvEUgvMpo2JA2h6jmOjGsxsoV4HPdABUKouci27/wNvdA7tLYvJONEtR5ytkNHLVI
	Z6gQA5CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDul7-00000006XYL-2So6;
	Sun, 11 May 2025 00:41:37 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDul0-00000006XWx-2nE1
	for linux-nvme@lists.infradead.org;
	Sun, 11 May 2025 00:41:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A78E49C49;
	Sun, 11 May 2025 00:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D96CC4CEE2;
	Sun, 11 May 2025 00:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746924088;
	bh=R+XXV9FURsEpJSl2vU49YG7wQYEwkpgw74F8OUSZ5Rc=;
	h=From:To:Cc:Subject:Date:From;
	b=U16hB7T3BCEhsAUSzD3ipzJhXUtEcrXBncxv9PaEqtmHewVTs5iW1aBbYA9hjvar4
	 5RdxggNXStq0Vy3lU4cUKTuLCqkbd7Xq5k+omQ2v2+uh/IyIPPF5z8z0qgBV5xqtY4
	 514ldV2XSNfrXTrPnrzfQZVfocQgPKT13FyArAH7E8NDFhPNroi6xzNBCAs6LbiwMb
	 tNszmxetLcwCMbve/SiGW3+UnS4cd5gBz/ASP2nqtZY5/qlgxACNTZ1s88oLUkB8Jl
	 9pJr3Tikjz4t5d02cMH0oVD74WHjouCZEK8fW5zjjMUWGDrJTMuJNfGpsiKKQd6pj1
	 u/ItEGlsiQIrQ==
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
Subject: [PATCH net-next 00/10] net: faster and simpler CRC32C computation
Date: Sat, 10 May 2025 17:41:00 -0700
Message-ID: <20250511004110.145171-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250510_174130_725973_76CB4122 
X-CRM114-Status: UNSURE (   9.54  )
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

Update networking code that computes the CRC32C of packets to just call
crc32c() without unnecessary abstraction layers.  The result is faster
and simpler code.

Patches 1-7 add skb_crc32c() and remove the overly-abstracted and
inefficient __skb_checksum().

Patches 8-10 replace skb_copy_and_hash_datagram_iter() with
skb_copy_and_crc32c_datagram_iter(), eliminating the unnecessary use of
the crypto layer.  This unblocks the conversion of nvme-tcp to call
crc32c() directly instead of using the crypto layer, which patch 9 does.

I'm proposing that this series be taken through net-next for 6.16, but
patch 9 could use an ack from the NVME maintainers.

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
 drivers/nvme/host/tcp.c           | 118 +++++++++-----------------
 include/linux/crc32.h             |  23 ------
 include/linux/skbuff.h            |  16 +---
 include/net/checksum.h            |  12 ---
 include/net/sctp/checksum.h       |  29 +------
 lib/crc32.c                       |   6 --
 lib/tests/crc_kunit.c             |   6 --
 net/Kconfig                       |   4 +
 net/core/datagram.c               |  34 ++++----
 net/core/dev.c                    |  10 +--
 net/core/skbuff.c                 | 132 ++++++++++++++++++------------
 net/netfilter/Kconfig             |   4 +-
 net/netfilter/ipvs/Kconfig        |   2 +-
 net/openvswitch/Kconfig           |   2 +-
 net/sched/Kconfig                 |   2 +-
 net/sctp/Kconfig                  |   2 +-
 net/sctp/offload.c                |   1 -
 20 files changed, 156 insertions(+), 274 deletions(-)


base-commit: 0b28182c73a3d013bcabbb890dc1070a8388f55a
-- 
2.49.0


