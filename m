Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2ADC54ED0
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tQEr2s36QFevSxuBtGh2fcvVOt0LRh93PEmpChQDzfA=; b=TAiwGQk9nLspqtv3A7zHf4nbYm
	BxRnO0UP05GXaUV4LHHUdThYCLb3FUetbr6/b7M65VwivCHtOQ8x/GM86Mm36EmKaIqlsQKpCUtbM
	vb9ws2gBqB2E1z4awdwIOvPFhm53lRaY+CTdjQIp3ChSmbgeyAUJQ+rlNo6fQjE7GrB3BKtZKY/Vv
	SXo60H1ZZtO23QVDq7fKbWRdIoiEO1tMsWfAyViCA+MQHBafUqyX6dc1IGDOhzn4st/Zej0VbwD2u
	D2QBJFtSgvF90MR1suWedL0HJ5JvfsIkOB8Q6Gcut6358Tl3xfIGCIsNFkwEMjuNbSb7Li3GkHIhj
	H5po/IpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI8vz-00000001c01-3QdG;
	Thu, 22 May 2025 16:38:19 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHqKW-0000000Go0R-2qtq
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 20:46:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 77C25629E8;
	Wed, 21 May 2025 20:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B86C4CEF2;
	Wed, 21 May 2025 20:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747860383;
	bh=TB5RrtCE3tLkkWSSZvlSdGdEuB83W94mJusyAgZ8cTE=;
	h=From:To:Cc:Subject:Date:From;
	b=azKxmU9yy7Izy99ARGU0CwcQd4sF4KPMD1aOQ//cIUDTuPCHSVJo6VQexSwPahcCY
	 RaB+/ec6twf4muJqtblNNKS/GpDDD2XG3WtK/YVf5pHdY030dyLCSc8h4ij0bAqyxG
	 XhMzcNbqL8jIseK0RS+FeGkfPecDLFgtEPxMgAOfvEscrYZNh+S4Apfj3U9piEHogG
	 y9AGdGlc3O0MHidOMqYgAwp7Okoo3zWYOYIkWqEJ9lP3XE3rJP/2gpLAJ+KJG3hZi0
	 kPJez90sL/EYEcH5kWO6CvWwcrgZuWC6+OgAByhtJvtb+9BzJ98rYQ164KEaiHbnwN
	 Wk4GR0fftc4bQ==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
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
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
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
	Jason Wang <jasowang@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxim Georgiev <glipus@gmail.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Philipp Hahn <phahn-oss@avm.de>,
	Eric Biggers <ebiggers@google.com>,
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
Subject: [PATCH net-next v2 0/8] net: Convert dev_set_mac_address() to struct sockaddr_storage
Date: Wed, 21 May 2025 13:46:08 -0700
Message-Id: <20250521204310.it.500-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2500; i=kees@kernel.org; h=from:subject:message-id; bh=TB5RrtCE3tLkkWSSZvlSdGdEuB83W94mJusyAgZ8cTE=; b=owGbwMvMwCVmps19z/KJym7G02pJDBl61lMn8Rlk/WQ5tG/fnM3cc3mE/hqzZ3+yr2D0L1GRf iekt16jo5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCIe3Az//f2rG3P6DZ5UOD7/ tuvKqRbdCQfV0q4oJrdt32d7xpNJhZFhldYdQ86QnhUK32dnBp/7eZFtyvJNKkZbN6/8239RZs9 5TgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 May 2025 09:38:03 -0700
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

 v2:
  - add conversion of dev_set_mac_address_user() (kuniyu)
  - fix missed sockaddr/sockaddr_storage conversion (kuba)
 v1: https://lore.kernel.org/all/20250520222452.work.063-kees@kernel.org/

Hi,

As part of the effort to allow the compiler to reason about object sizes,
we need to deal with the problematic variably sized struct sockaddr,
which has no internal runtime size tracking. In much of the network
stack the use of struct sockaddr_storage has been adopted. Continue the
transition toward this for more of the internal APIs. Specifically:

- inet_addr_is_any()
- netif_set_mac_address()
- dev_set_mac_address()
- dev_set_mac_address_user()

Only a few callers of dev_set_mac_address() needed adjustment; all others
were already using struct sockaddr_storage internally.

-Kees

Kees Cook (8):
  net: core: Convert inet_addr_is_any() to sockaddr_storage
  net: core: Switch netif_set_mac_address() to struct sockaddr_storage
  net/ncsi: Use struct sockaddr_storage for pending_mac
  ieee802154: Use struct sockaddr_storage with dev_set_mac_address()
  net: usb: r8152: Convert to use struct sockaddr_storage internally
  net: core: Convert dev_set_mac_address() to struct sockaddr_storage
  rtnetlink: do_setlink: Use struct sockaddr_storage
  net: core: Convert dev_set_mac_address_user() to use struct
    sockaddr_storage

 include/linux/inet.h                |  2 +-
 include/linux/netdevice.h           |  6 ++--
 net/ncsi/internal.h                 |  2 +-
 drivers/net/bonding/bond_alb.c      |  8 ++---
 drivers/net/bonding/bond_main.c     | 15 ++++-----
 drivers/net/hyperv/netvsc_drv.c     |  6 ++--
 drivers/net/macvlan.c               | 18 +++++-----
 drivers/net/tap.c                   | 14 +++++---
 drivers/net/team/team_core.c        |  2 +-
 drivers/net/tun.c                   |  8 ++++-
 drivers/net/usb/r8152.c             | 52 +++++++++++++++--------------
 drivers/nvme/target/rdma.c          |  2 +-
 drivers/nvme/target/tcp.c           |  2 +-
 drivers/target/iscsi/iscsi_target.c |  2 +-
 net/core/dev.c                      | 11 +++---
 net/core/dev_api.c                  | 11 +++---
 net/core/dev_ioctl.c                |  6 ++--
 net/core/rtnetlink.c                | 19 +++--------
 net/core/utils.c                    |  8 ++---
 net/ieee802154/nl-phy.c             |  6 ++--
 net/ncsi/ncsi-rsp.c                 | 18 +++++-----
 21 files changed, 109 insertions(+), 109 deletions(-)

-- 
2.34.1


