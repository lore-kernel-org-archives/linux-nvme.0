Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A242ACA5FC2
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DfV0ZdyXjwMFuzBG40t+uh9OXVIWsQkLcTmp8LtXSIY=; b=dmSi9AE8QcCyLUlF2YWUaSSutU
	A7f5zVL1DVN9LYwQhNwZt6rTqY4QB9MQIHvvwc9RaGoyJ6H9IwfFfeoRnSDtD2IrKstYmgEuYpAEj
	JunngoNsAqbVIifsWXPVXkZAMTK638ziD1IBJEuE98oPE3SSXCXu/O2y6pzugtS8O4zVWtgZ1W/t8
	+SMix5sorT4OhosVC21hfJKQmskZz4BffSqkgEuZOIPptDvPciKxvrS8bUqIyrKy2kGPzIUF+jJsK
	Cu3/K0j3MqPBAPuZpI8SRrjpOp7KwEJXK7xD+JVWbbG5rhhcrrHZ9RvcPvYh4llWwvlLjabYrHaOe
	jTkZoxVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT7e-00000002jQr-1aJM;
	Tue, 29 Sep 2026 08:23:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBS67-00000002a0D-0St8
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 07:17:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 85996404C9;
	Tue, 29 Sep 2026 07:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040681F000FF;
	Tue, 29 Sep 2026 07:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790666274;
	bh=DfV0ZdyXjwMFuzBG40t+uh9OXVIWsQkLcTmp8LtXSIY=;
	h=From:To:Cc:Subject:Date;
	b=HC9gNeCZQT3WnFBnHiYLaloBAkhdlb69XWMbxRy8PiaJGIPTPD6zTlnf3Ryvc5YtD
	 ndc1eqGx+qsW/X5N60SwWKjXKN/SDPDG9hXhKxLq33KqrAu55Pg74vSUxLQoxmHM/A
	 H+J9biykKCRQU4nYH8TyqyD8WmPWQUy9/BuIvyefKsCo/b4tbec7l5y2zh5U6NU3vi
	 Vl6GVqTVBJUVa4EkAj/o8NBWA2q3BUWLxqFONpztoLahQLNxKZAn5q64UDAdmqIZ1O
	 iFjMVQtBoLp1twfVreBa2slbPq0CUbtZDgBGVZGoTwPMB9daryMl2npyQVIszOZHCz
	 l0d+sbbfh4V4w==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	edumazet@google.com,
	netdev@vger.kernel.org,
	Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	gfs2@lists.linux.dev,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	mptcp@lists.linux.dev,
	Wen Gu <guwen@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Allison Henderson <achender@kernel.org>,
	rds-devel@oss.oracle.com,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH v3 net-next 0/9] tcp: avoid struct socket cache line miss in tcp_check_space()
Date: Tue, 29 Sep 2026 07:17:34 +0000
Message-ID: <20260929071743.23624-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 01:23:30 -0700
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

tcp_check_space() is called on every incoming ACK and every transmitted
packet, and tests SOCK_NOSPACE in sk->sk_socket->flags.  Because struct
socket lives in its own cache line and the TCP fast paths do not touch
it for anything else, that test pulls in an extra cache line that is
cold when the working set of active sockets is large.

This series mirrors SOCK_NOSPACE into a new u8 field, tp->tcp_nospace,
placed right after tp->chrono_type in the tcp_sock_write_tx cache line
group (fitting in an existing 3-byte hole before chrono_start, so no
other field moves and sizeof(struct tcp_sock) is unchanged).  Both the
transmit and ACK fast paths already touch that cache line, making the
fast-path test in tcp_check_space() free of extra cache misses while
keeping __tcp_check_space() authoritative on SOCK_NOSPACE.

To maintain the invariant (SOCK_NOSPACE set => tp->tcp_nospace set) from
a single choke point:

 - Patch 1 fixes a long-standing bug in dlm where SOCKWQ_ASYNC_NOSPACE
   was tested and cleared on con->sock->flags instead of SOCK_NOSPACE.
 - Patch 2 introduces sk_set_nospace() and sk_clear_nospace() and
   converts the core networking setters and clearers.
 - Patches 3-8 convert the remaining in-kernel callers (sunrpc, rds,
   dlm, drbd, nvme-tcp, libceph) so that no open-coded set_bit() or
   clear_bit() of SOCK_NOSPACE remains in the tree.
 - Patch 9 adds tp->tcp_nospace, wires it into sk_set_nospace() and
   sk_clear_nospace(), and switches tcp_check_space() to test it.

v3:
 - Rebase and CC subsystem maintainers (Jakub)
 - Link to v2: https://lore.kernel.org/netdev/20260924134729.2047213-1-edumazet@google.com/

v2:
 - Order set_bit(SOCK_NOSPACE) before tp->tcp_nospace = 1 in
   sk_set_nospace() and tp->tcp_nospace = 0 before
   clear_bit(SOCK_NOSPACE) in sk_clear_nospace() so a concurrent
   lockless tcp_poll() cannot leave SOCK_NOSPACE set with
   tp->tcp_nospace cleared (Sashiko)
 - Move tp->tcp_nospace to the 3-byte hole after tp->chrono_type so no
   field in struct tcp_sock shifts after the AccECN bitfield additions
   (Sashiko)
 - Clarify comment and Patch 2 changelog wording (Sashiko)
 - Link to v1: https://lore.kernel.org/netdev/20260922122721.3568295-1-edumazet@google.com/

Eric Dumazet (9):
  dlm: fix send buffer backpressure handling
  net: add sk_set_nospace() and sk_clear_nospace()
  sunrpc: use sk_set_nospace() and sk_clear_nospace()
  rds: use sk_set_nospace()
  dlm: use sk_set_nospace() and sk_clear_nospace()
  drbd: use sk_set_nospace()
  nvme-tcp: use sk_clear_nospace()
  libceph: use sk_clear_nospace()
  tcp: add tp->tcp_nospace

 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 drivers/block/drbd/drbd_worker.c              |  3 +-
 drivers/nvme/host/tcp.c                       |  2 +-
 drivers/nvme/target/tcp.c                     |  2 +-
 fs/dlm/lowcomms.c                             | 10 ++--
 include/linux/tcp.h                           |  3 ++
 include/net/sock.h                            |  2 +
 include/net/tcp.h                             | 30 +++++++++++-
 net/ceph/messenger.c                          |  2 +-
 net/core/sock.c                               | 46 ++++++++++++++++++-
 net/core/stream.c                             |  6 +--
 net/ipv4/tcp.c                                |  5 +-
 net/ipv4/tcp_bpf.c                            |  2 +-
 net/ipv4/tcp_input.c                          |  8 +++-
 net/kcm/kcmsock.c                             |  4 +-
 net/mptcp/protocol.c                          |  4 +-
 net/mptcp/subflow.c                           |  5 ++
 net/rds/tcp_send.c                            |  5 +-
 net/smc/af_smc.c                              |  2 +-
 net/smc/smc_tx.c                              |  6 +--
 net/sunrpc/svcsock.c                          |  4 +-
 net/sunrpc/xprtsock.c                         |  4 +-
 net/tls/tls_sw.c                              |  2 +-
 23 files changed, 121 insertions(+), 37 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog


