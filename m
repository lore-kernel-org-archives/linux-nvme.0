Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA0AC5DF70
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 06:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V9Szkgv2uln62JPBOa1EuVKyOTJ9UGVh4SfukLg25ME=; b=4YNVqeJw/Rl4jBxgGiPeFEghLu
	ah3LccUQ2ymycRQ/DbEbaCuJ3kXqOAoCCGwn9iWKs+Dms2zTIPUgiXBs3Fu3vaKgMkTJxGuMLWq4P
	PZQsM59Xovu2joaiKZmmAHqDKgHs6Yf4/VqIXc3J6rkqH5aZMfZXbz6Tcp+qSEMMWp+cjgOCaQve5
	wtTJKRQGGtyQ55saYvVxgS4zFwqfmAZjPggQMZQF8CC4Wa1lxN6llEYrLzG1KGy2/b8awJijH2ozv
	AuV4kFsmWL6Bba05yP35DO/ZM7qDApGu7Q1FUAAPskp5a1gA4T7502+i5rMWdmAxlpL+KpYcKwpo1
	s7ig+m4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwCv7-00000007NEY-1i6M;
	Tue, 18 Aug 2026 06:03:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwCv6-00000007NEQ-0jlp
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 06:03:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EB457600AB;
	Tue, 18 Aug 2026 06:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E591F000E9;
	Tue, 18 Aug 2026 06:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787033010;
	bh=V9Szkgv2uln62JPBOa1EuVKyOTJ9UGVh4SfukLg25ME=;
	h=From:To:Cc:Subject:Date;
	b=c65zJeqhLZzEwBgVwv4bwA7V93TKpjb35hfmmLWpuz84ipg0v1C1K4tqPdN4M7004
	 z78ca1fP+OslMgHGPWsb7bBM3dL4WOpi2fc+QKx7nnDCST1mcOFm6WwL8WWYUvCOLf
	 YLe3IvPB5EpPeUsqN5TuUwpIUu2nY3FdL9jq7fcG4DBslll3uLQf7XmnbpGJl93piw
	 w+HVvYUd/S28wR9R3mBEOtmLdCa3TQwnR371QBKi8LnFWHzh2nRduV3zKFWCMZ8Fui
	 reYd3xtHPuJHVYq7v4iKX5AnIzDxma9Ua9Q+QX+kzwgwEicXN6e8ZqqdLT9bvL+hhr
	 5R7XUYvxFw/VA==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH v4 0/4] nvme-tcp: add IPv6 traffic class support
Date: Tue, 18 Aug 2026 14:02:59 +0800
Message-ID: <cover.1786947923.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Geliang Tang <tanggeliang@kylinos.cn>

This series adds IPv6 traffic class (tclass) support to the NVMe/TCP
fabrics stack, mirroring the existing IPv4 TOS configuration.

The current code path only handles IPv4: nvme-fabrics exposes a 'tos'
option, the host (nvme-tcp) applies IP_TOS to each queue socket, and
the target (nvmet-tcp) reflects the value received on the wire. This
leaves no way to control or observe the IPv6 traffic class for NVMe/TCP
connections, which is a real gap for deployments running over IPv6 that
need a non-default tclass.

The series also refactors the socket option configuration on both host
and target sides to use the generic do_sock_setsockopt() helper. This
change eliminates the need for protocol-specific helpers and decouples
the configuration from the underlying transport protocol, laying the
groundwork for future protocol extensions such as MPTCP.

The series is split into two logical parts: the do_sock_setsockopt
refactoring (patches 1-2) and the IPv6 traffic class support (patches
3-4), following the natural host/target layering.

This was tested with the selftests mptcp_nvme.sh [1] to pass "--tos"
on the host side and validate that the value is reflected on the wire
by the target.

[1]
https://patchwork.kernel.org/project/linux-nvme/cover/cover.1779934709.git.tanggeliang@kylinos.cn/

v4:
 - check return values of do_sock_setsockopt, as suggested by Sashiko.
 - change "u8 tclass" to "int tclass" in nvmet_tcp_sock_set_tclass,
   as suggested by Sashiko.
 - change "u8 tos" to "int tos" in nvmet_tcp_sock_set_tos.

v3:
 - add two patches to unify socket option configuration using
   do_sock_setsockopt on both host and target sides.
 - use do_sock_setsockopt for IPV6_TCLASS rather than exporting and
   calling ip6_sock_set_tclass, as suggested by Jakub.
 - reuse the existing NVMF_OPT_TOS for IPv6 sockets instead of adding
   a new NVMF_OPT_TCLASS option, as suggested by Stanislav.
 - https://patchwork.kernel.org/project/linux-nvme/cover/cover.1786841319.git.tanggeliang@kylinos.cn/

v2:
 - Export and use the ip6_sock_set_tclass() helper in both target and host
   paths, aligning with the existing ip_sock_set_tos() usage.
 - Add CONFIG_IPV6 and AF_INET6 guards to avoid build failures when IPv6
   is disabled.
 - Use rcv_flowinfo from the target socket instead of np->tclass.
 - https://patchwork.kernel.org/project/linux-nvme/cover/cover.1786171863.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/linux-nvme/cover/cover.1785122120.git.tanggeliang@kylinos.cn/

Geliang Tang (4):
  nvmet-tcp: unify sockopt with do_sock_setsockopt
  nvme-tcp: unify sockopt with do_sock_setsockopt
  nvmet-tcp: support IPv6 traffic class
  nvme-tcp: support IPv6 traffic class

 drivers/nvme/host/tcp.c   | 111 ++++++++++++++++++++++++++++++++++----
 drivers/nvme/target/tcp.c | 102 +++++++++++++++++++++++++++++++----
 2 files changed, 193 insertions(+), 20 deletions(-)

-- 
2.53.0


