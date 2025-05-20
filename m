Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF309C3ABC9
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 04:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MHGwZBIJbaXk1n3egZ2PY5lsa/gvX4QbMPVC625QL00=; b=0VjMqXvwne8Q8Xu/ZICEsho4Dn
	U3j2Zr21qu7633IdeiV0vLkWC1GQVh40YZ4bb3fyPVxS+GoZLM1nBSYgGt7tB4kKvwchSr93DfSO+
	TBtWo6ICweGdYKv8CM4+DXLhLvJf1cGqsGYWPpIZznVWMTs6pgrqhHeIgFIUfoo5rUukYsTDwSZG6
	zz9jnlep6tANRB2+1H2GOj3yHCQerHPzauiAqY0ZCDkS36j1XWgRpJ7PtSA4zM11iYq5Q0wB6JzuA
	ZRZnORBpFrOCOjFtwB/yo/XvFDFUWGasmSAK5Rzqr7Qp8aLhlat0YjzhzvSFgkUfsN8vCdwM9eL90
	VO4ZaLaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHbQq-0000000EmQp-2LfV;
	Wed, 21 May 2025 04:51:56 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHVUP-0000000EGz4-20D8
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 22:31:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1C1E8629F2;
	Tue, 20 May 2025 22:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18DAC4AF0C;
	Tue, 20 May 2025 22:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747780271;
	bh=V5uf6YlgPTr2U418QetNaAAYXDxQz7VW/iPHa55aWbE=;
	h=From:To:Cc:Subject:Date:From;
	b=c8JF6yMZ2CfkNKv+fj/emGvRG+4AyBoiThhjNe5giOiqWyOZw3S7kTIX/1n0SD9Jj
	 suGB+ONLcSBgGXRUppLShhfbiSMiz01dT9hURbyiqqUgl9uZIL9h5Qb1w5mz9fq2g3
	 +3KDq2sAocKLZIJ+6qf0tJKmZvhm5Ld//TaXafA9rqLXQ0D01Gikn2kmFDNEFisM35
	 hYRp9zZ9CfpjFon3LCztZHDMjSgmV62M8vHILqeu31B7msusbLOVZEM7R0MiAGCaAv
	 doSIfmG9RO12LRHELfyIyHykmNE5dHzqAAGdqhZvqPBN5eiLTNrMtO52XzsHkdfs9B
	 5R1K5BHNnA5CA==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Mingzhe Zou <mingzhe.zou@easystack.cn>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Simon Horman <horms@kernel.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Lei Yang <leiyang@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Hayes Wang <hayeswang@realtek.com>,
	Douglas Anderson <dianders@chromium.org>,
	Grant Grundler <grundler@chromium.org>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Eric Biggers <ebiggers@google.com>,
	Milan Broz <gmazyland@gmail.com>,
	Philipp Hahn <phahn-oss@avm.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wpan@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/7] net: Convert dev_set_mac_address() to struct sockaddr_storage
Date: Tue, 20 May 2025 15:30:59 -0700
Message-Id: <20250520222452.work.063-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2018; i=kees@kernel.org; h=from:subject:message-id; bh=V5uf6YlgPTr2U418QetNaAAYXDxQz7VW/iPHa55aWbE=; b=owGbwMvMwCVmps19z/KJym7G02pJDBm6TCseuGUb11+RCOzXO7lCOWzlOiOBrx4L36js6ygWL q07/N2go5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCKzBRgZ/tQsZlVS1pRfEbvj 8Caz4t6e8B9HuKfWHNo4c+GV9lVGrxj+WV4zLXjF52Tya+X2me5K9ydwBjwu97i7/jWv+FeeaQG 6zAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 May 2025 21:51:54 -0700
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

Hi,

As part of the effort to allow the compiler to reason about object sizes,
we need to deal with the problematic variably sized struct sockaddr,
which has no internal runtime size tracking. In much of the network
stack the use of struct sockaddr_storage has been adopted. Continue the
transition toward this for more of the internal APIs. Specifically:

- inet_addr_is_any()
- netif_set_mac_address()
- dev_set_mac_address()

Only 3 callers of dev_set_mac_address() needed adjustment; all others
were already using struct sockaddr_storage internally.

-Kees

Kees Cook (7):
  net: core: Convert inet_addr_is_any() to sockaddr_storage
  net: core: Switch netif_set_mac_address() to struct sockaddr_storage
  net/ncsi: Use struct sockaddr_storage for pending_mac
  ieee802154: Use struct sockaddr_storage with dev_set_mac_address()
  net: usb: r8152: Convert to use struct sockaddr_storage internally
  net: core: Convert dev_set_mac_address() to struct sockaddr_storage
  rtnetlink: do_setlink: Use struct sockaddr_storage

 include/linux/inet.h                |  2 +-
 include/linux/netdevice.h           |  4 +--
 net/ncsi/internal.h                 |  2 +-
 drivers/net/bonding/bond_alb.c      |  8 ++---
 drivers/net/bonding/bond_main.c     | 10 +++---
 drivers/net/hyperv/netvsc_drv.c     |  6 ++--
 drivers/net/macvlan.c               | 10 +++---
 drivers/net/team/team_core.c        |  2 +-
 drivers/net/usb/r8152.c             | 52 +++++++++++++++--------------
 drivers/nvme/target/rdma.c          |  2 +-
 drivers/nvme/target/tcp.c           |  2 +-
 drivers/target/iscsi/iscsi_target.c |  2 +-
 net/core/dev.c                      | 11 +++---
 net/core/dev_api.c                  |  6 ++--
 net/core/rtnetlink.c                | 19 +++--------
 net/core/utils.c                    |  8 ++---
 net/ieee802154/nl-phy.c             |  6 ++--
 net/ncsi/ncsi-rsp.c                 | 18 +++++-----
 18 files changed, 79 insertions(+), 91 deletions(-)

-- 
2.34.1


