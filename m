Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC697C54E92
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 04:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cra7rVXVtNR1td7LotglmxPpFVCzfq8B+4JXH2GhlQg=; b=T1UOOqjY70gVbqKffSUi6JizEJ
	bUHlrKpf9oEg43fPoH7LMGeYxOtq+NiizhekYeH1b1eQqaCmq3wFhkyesYG0x9qsCae8Petr6b6Qb
	YyRhkhvui6WBKZbJY/oFam9Q+xTuJ1IUZv17jqD0ZzisUUzfgJO4fzl6E60XwTzG8Omf7Sf2PpV/Q
	/0L08nWYGz6kTXAV/+khglHvoEbsndkh4slD+QWH+op1hnu2UJc2+13+dlsjoU6Rjqw7WY8gSGK3J
	XdRrTylv9gqJo9NdlUhszJGuoFazxxijGuztSpYZIyixF+RbsNHE/N8ixsy87XmJ8ghHR2uLZjQ28
	MxhTyMKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHbQr-0000000EmQx-0jdF;
	Wed, 21 May 2025 04:51:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHVUP-0000000EGzC-3gCd
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 22:31:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 169BD629D5;
	Tue, 20 May 2025 22:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3B8C4AF09;
	Tue, 20 May 2025 22:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747780271;
	bh=EN+GclfyW5kAxeN8WNPlyC9ZwL/jol7JwmGHWkiT4Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dC6GEMrR2q1oaK8xsVSF2NUNGwrnfGyhc1tnZMsVWuPq9D2hKdWuafB+2noLdvhl/
	 gAvocEEUtyWQ5tFvpFZuyWJiaT4vyMB9WYIOnt1Ld3RqB0Ex2SeuJzcbVFo+pK4hSa
	 LU32yQ4sIY1qEQyEiz1VwIrdK3x5rUFxioBMWZBWgzfsjDFNYJRgGWn7v7kM56mLl+
	 8ydpia6nDB2EE/tpcyoB5zZEOjtCAR1ZCM/JRgZl6NZuprwOJkfgKeIuBOKDHl6sWh
	 WQLiHQU5/NLSPgkFEdfkKOMi3rv1EiU6KDV27k/EcXyqf5fSHi9WwbM16a8wwDvgWI
	 YoqAHtGvo6alw==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Lei Yang <leiyang@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Christie <michael.christie@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Mingzhe Zou <mingzhe.zou@easystack.cn>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
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
	linux-wpan@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/7] net: core: Switch netif_set_mac_address() to struct sockaddr_storage
Date: Tue, 20 May 2025 15:31:01 -0700
Message-Id: <20250520223108.2672023-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520222452.work.063-kees@kernel.org>
References: <20250520222452.work.063-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4301; i=kees@kernel.org; h=from:subject; bh=EN+GclfyW5kAxeN8WNPlyC9ZwL/jol7JwmGHWkiT4Ho=; b=owGbwMvMwCVmps19z/KJym7G02pJDBm6TCvevNzDfb14x7WnP3O6zjSt2sKgMWtn9Nnn8WWX1 1qqSLLpdZSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzkvDPDP9WOiROtppmKdDp8 +eX+/EOifeGbHY/nPtme9yj0pNmF6ZcZ/sfnXBWUOvjGsqyw8YH74+ZJH6yW2prO/cM0oSlgS8Y TZ0YA
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

In order to avoid passing around struct sockaddr that has a size the
compiler cannot reason about (nor track at runtime), convert
netif_set_mac_address() to take struct sockaddr_storage. This is just a
cast conversion, so there is are no binary changes. Following patches
will make actual allocation changes.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Lei Yang <leiyang@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>
---
 include/linux/netdevice.h |  2 +-
 net/core/dev.c            | 10 +++++-----
 net/core/dev_api.c        |  4 ++--
 net/core/rtnetlink.c      |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ea9d335de130..47200a394a02 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4212,7 +4212,7 @@ int netif_set_mtu(struct net_device *dev, int new_mtu);
 int dev_set_mtu(struct net_device *, int);
 int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
 			      struct netlink_ext_ack *extack);
-int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
+int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			  struct netlink_ext_ack *extack);
 int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 			struct netlink_ext_ack *extack);
diff --git a/net/core/dev.c b/net/core/dev.c
index fccf2167b235..f8c8aad7df2e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9655,7 +9655,7 @@ int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
 }
 EXPORT_SYMBOL(dev_pre_changeaddr_notify);
 
-int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
+int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			  struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
@@ -9663,15 +9663,15 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 
 	if (!ops->ndo_set_mac_address)
 		return -EOPNOTSUPP;
-	if (sa->sa_family != dev->type)
+	if (ss->ss_family != dev->type)
 		return -EINVAL;
 	if (!netif_device_present(dev))
 		return -ENODEV;
-	err = dev_pre_changeaddr_notify(dev, sa->sa_data, extack);
+	err = dev_pre_changeaddr_notify(dev, ss->__data, extack);
 	if (err)
 		return err;
-	if (memcmp(dev->dev_addr, sa->sa_data, dev->addr_len)) {
-		err = ops->ndo_set_mac_address(dev, sa);
+	if (memcmp(dev->dev_addr, ss->__data, dev->addr_len)) {
+		err = ops->ndo_set_mac_address(dev, ss);
 		if (err)
 			return err;
 	}
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index f9a160ab596f..b5f293e637d9 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -91,7 +91,7 @@ int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
 
 	down_write(&dev_addr_sem);
 	netdev_lock_ops(dev);
-	ret = netif_set_mac_address(dev, sa, extack);
+	ret = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
 	netdev_unlock_ops(dev);
 	up_write(&dev_addr_sem);
 
@@ -332,7 +332,7 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 	int ret;
 
 	netdev_lock_ops(dev);
-	ret = netif_set_mac_address(dev, sa, extack);
+	ret = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
 	netdev_unlock_ops(dev);
 
 	return ret;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 8a914b37ef6e..9743f1c2ae3c 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3100,7 +3100,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 
 		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
 		       dev->addr_len);
-		err = netif_set_mac_address(dev, sa, extack);
+		err = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
 		kfree(sa);
 		if (err) {
 			up_write(&dev_addr_sem);
-- 
2.34.1


