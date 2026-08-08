Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38EFC55174
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Aug 2026 06:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RQXi3ucLUQ3/i/PzsOd0/dubewVrVUJmLRg32xggvMA=; b=o0atvtaZOPMowLo4KA+zOwmAcw
	BbpWeEP1wpd4rganqHjauBz+xSs3M6kGwDZLu6ardENe83+rc2fePNbaDPRHuHB/BrikuX2fA8s29
	+ySActDbLcQVeN5nrWNCxqBJIwVL695iC0aLp+tsnMsBnevv8LKxQmtEjS40iSJ6c8D7Y6S8u3oua
	rQ3NFmW+BCllFeb+PKTeUPUrblI24KrszQq+nUtKk2gXHLCTW8B29S642CiUWojZZnZ1dVPOUdsvL
	SoINDMCNPoJMkKCnlKhQpsi0AfsRdnqRD6RYI3FznWfy464VmIVEr1pkgcOxeoedS756ZdbcE4112
	KfGRG45A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsayV-000000096xu-2ew3;
	Sat, 08 Aug 2026 06:56:07 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsayU-000000096xh-26P2
	for linux-nvme@lists.infradead.org;
	Sat, 08 Aug 2026 06:56:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B175761878;
	Sat,  8 Aug 2026 06:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568DE1F000E9;
	Sat,  8 Aug 2026 06:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786172162;
	bh=RQXi3ucLUQ3/i/PzsOd0/dubewVrVUJmLRg32xggvMA=;
	h=From:To:Cc:Subject:Date;
	b=gWVtOcXMgj5zP3MmaWsGpUlhDNNkHlGy+Qfc9LNAkA5MT6KidPEbGhbV9iF+TvWxp
	 Qjt2vMW7lLn2D2kAd39EOvTIFd/jvbkKWT4BukhIPnfbIXedE8bHkzlF1TdhWGqw6d
	 s/MhILIpSNRdd6UkPehqjoLT2wAfcj55scV8Ijuhi/oCOcUkLR3xOzIZFfr52njlp5
	 Jb9eUX7ps9Vk4nZlSQrGenCOv+0HMgug0I+lpzMAfiRFqn60XAhUJbMYWCYWtXW9Q8
	 jKzBuLXh9YLKIHYPfVcyC3bhbAgdXe1Yx/gu7Pc84PLTwselFYVp0JamxEmPyj9xLJ
	 lOqD5cEANOOsA==
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
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH v2 0/3] nvme-tcp: add IPv6 traffic class support
Date: Sat,  8 Aug 2026 14:54:58 +0800
Message-ID: <cover.1786171863.git.tanggeliang@kylinos.cn>
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
connections, which is a real gap for deployments running over IPv6 or
MPTCP subflows that need a non-default tclass.

The series is split into three patches following the natural
fabrics/host/target layering:

1. nvme-fabrics: add IPv6 traffic class option
   Parse the new 'tclass' option in nvmf_parse_options(), validate
   that it is in the 0-255 range, and store it in
   struct nvmf_ctrl_options. Use -1 to mean "transport default",
   matching the existing tos handling.

2. nvme-tcp: support IPv6 traffic class
   Advertise NVMF_OPT_TCLASS in the nvme_tcp transport and, when a
   tclass was provided, set IPV6_TCLASS on each queue socket. The
   existing IP_TOS path is left untouched so IPv4 behaviour is
   unchanged.

3. nvmet-tcp: support IPv6 traffic class
   On the target side, differentiate the socket family: for AF_INET
   keep the existing TOS handling, and for AF_INET6 read the traffic
   class from the incoming socket and apply it via IPV6_TCLASS.

Follow-up changes outside of this series expose the same option
through libnvme and the nvme-cli, so the new tclass can be selected
from the user-facing command line; those patches will be sent in a
separate series.

This was tested with the selftests mptcp_nvme.sh [1], extended in
"nvme: add tclass support" to pass "--tclass" on the host side and
validate that the value is reflected on the wire by the target.

v2:
 - Export and use the ip6_sock_set_tclass() helper in both target and host
   paths, aligning with the existing ip_sock_set_tos() usage.
 - Add CONFIG_IPV6 and AF_INET6 guards to avoid build failures when IPv6
   is disabled.
 - Use rcv_flowinfo from the target socket instead of np->tclass.

v1:
 - https://patchwork.kernel.org/project/linux-nvme/cover/cover.1785122120.git.tanggeliang@kylinos.cn/

[1]
https://patchwork.kernel.org/project/linux-nvme/cover/cover.1779934709.git.tanggeliang@kylinos.cn/

Geliang Tang (3):
  ipv6: extract and export ip6_sock_set_tclass helpers
  nvme-tcp: support IPv6 traffic class
  nvmet-tcp: support IPv6 traffic class

 drivers/nvme/host/fabrics.c | 18 ++++++++++++++++++
 drivers/nvme/host/fabrics.h |  3 +++
 drivers/nvme/host/tcp.c     |  8 +++++++-
 drivers/nvme/target/tcp.c   |  8 ++++++++
 include/net/ipv6.h          |  3 +++
 net/ipv6/ipv6_sockglue.c    | 31 +++++++++++++++++++++++--------
 6 files changed, 62 insertions(+), 9 deletions(-)

-- 
2.53.0


