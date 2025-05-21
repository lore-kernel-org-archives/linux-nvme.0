Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215A4C54E65
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 16:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hIlZlIFASI51YJEYVeJxY2kFBYpfzd7gEazKFSguSpw=; b=mlKPnA94KIF7TuPG8ADvcTLSti
	ZgKVLynJCRQ873Fne0Kj3AhJFFyVzrErDh/Ej9UH4/zZDvUDt4ovnukbLNZxLPfsJNObHUps7c9sL
	byZK9Ps6QpqdHVWMc9nIemqa0vM2sEv5Zi6rgOEp+io0ksbxqWOfkjCOHdyzA+rv7s9MNQRfkd+4e
	4mbok9hlUB3VVfewQ3g3RikyEhlwLWcdt8gMRQ2UJpHs7MYwRrIyhnP7Iv0jhMbeTEqTkGXSBaKyy
	yphCFW2fD9D7kD4PlNP1o/QZ6jP6gj1mgFKkLGuPmdZZh8pU0ZBsVRZyp79GNRwjuwYynWy4qAVKs
	FFfNv/BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI8w2-00000001c2j-2MPP;
	Thu, 22 May 2025 16:38:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHqKZ-0000000Go1f-0zXI
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 20:46:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4FFA8629F1;
	Wed, 21 May 2025 20:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D0AC4CEEF;
	Wed, 21 May 2025 20:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747860386;
	bh=uukxrEpJUYAyupSlleSqs7Dnu8Ku05Cf2zA1scbEPws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fBTJp1Aipta+gv7edcYonzjM2tkxkmReYflq95ozqHQ9fIyJA+9hvQzZjaDrCQH5u
	 sS5yaj7Zooxfty8T4FI0zqqis2BxQ7LM27ImicICpU/DpXNiG0WYYSrY5Ox397CNtz
	 /Lm8W108V3ClijzV05IuwLsbhHpETeNClTl8DTx1TKrlJwOHVzuBMScBbOx4ClkcsI
	 bRxzp6y0wO7zEpWcOO0jNf+d5ZWmJJijJRge3pZmMY/s8kIxsnLvin7EuM/LPBae73
	 iVcjt+q3Iskqn5RgQAjomzRDkTU68eu0gQ3Ra65DX17glfUBipzsgjklF59lJ1yiZT
	 YVbezXOD4QP+Q==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxim Georgiev <glipus@gmail.com>,
	netdev@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Mike Christie <michael.christie@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Mingzhe Zou <mingzhe.zou@easystack.cn>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
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
	linux-wpan@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v2 8/8] net: core: Convert dev_set_mac_address_user() to use struct sockaddr_storage
Date: Wed, 21 May 2025 13:46:16 -0700
Message-Id: <20250521204619.2301870-8-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521204310.it.500-kees@kernel.org>
References: <20250521204310.it.500-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5481; i=kees@kernel.org; h=from:subject; bh=uukxrEpJUYAyupSlleSqs7Dnu8Ku05Cf2zA1scbEPws=; b=owGbwMvMwCVmps19z/KJym7G02pJDBl61jM2yvHveiO5bCO79hbl2xaaia+7dH6tKefuW3NeW oH30HebjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIl4ujP8TzXgvz1rLdPhJvMc ifokhpB3NWdP3Wlj/MzwS6tqucLENwz/i9PmCR2I//nx7YRNT9ftYvna3xWiMoGnfp7/pl3btjw OZQIA
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

Convert callers of dev_set_mac_address_user() to use struct
sockaddr_storage. Add sanity checks on dev->addr_len usage.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>
Cc: Maxim Georgiev <glipus@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <netdev@vger.kernel.org>
---
 include/linux/netdevice.h |  2 +-
 drivers/net/tap.c         | 14 +++++++++-----
 drivers/net/tun.c         |  8 +++++++-
 net/core/dev_api.c        |  5 +++--
 net/core/dev_ioctl.c      |  6 ++++--
 5 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b4242b997373..adb14db25798 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4216,7 +4216,7 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			  struct netlink_ext_ack *extack);
 int dev_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			struct netlink_ext_ack *extack);
-int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
+int dev_set_mac_address_user(struct net_device *dev, struct sockaddr_storage *ss,
 			     struct netlink_ext_ack *extack);
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
 int dev_get_port_parent_id(struct net_device *dev,
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index d4ece538f1b2..bdf0788d8e66 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -923,7 +923,7 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 	unsigned int __user *up = argp;
 	unsigned short u;
 	int __user *sp = argp;
-	struct sockaddr sa;
+	struct sockaddr_storage ss;
 	int s;
 	int ret;
 
@@ -1000,16 +1000,17 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 			return -ENOLINK;
 		}
 		ret = 0;
-		dev_get_mac_address(&sa, dev_net(tap->dev), tap->dev->name);
+		dev_get_mac_address((struct sockaddr *)&ss, dev_net(tap->dev),
+				    tap->dev->name);
 		if (copy_to_user(&ifr->ifr_name, tap->dev->name, IFNAMSIZ) ||
-		    copy_to_user(&ifr->ifr_hwaddr, &sa, sizeof(sa)))
+		    copy_to_user(&ifr->ifr_hwaddr, &ss, sizeof(ifr->ifr_hwaddr)))
 			ret = -EFAULT;
 		tap_put_tap_dev(tap);
 		rtnl_unlock();
 		return ret;
 
 	case SIOCSIFHWADDR:
-		if (copy_from_user(&sa, &ifr->ifr_hwaddr, sizeof(sa)))
+		if (copy_from_user(&ss, &ifr->ifr_hwaddr, sizeof(ifr->ifr_hwaddr)))
 			return -EFAULT;
 		rtnl_lock();
 		tap = tap_get_tap_dev(q);
@@ -1017,7 +1018,10 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 			rtnl_unlock();
 			return -ENOLINK;
 		}
-		ret = dev_set_mac_address_user(tap->dev, &sa, NULL);
+		if (tap->dev->addr_len > sizeof(ifr->ifr_hwaddr))
+			ret = -EINVAL;
+		else
+			ret = dev_set_mac_address_user(tap->dev, &ss, NULL);
 		tap_put_tap_dev(tap);
 		rtnl_unlock();
 		return ret;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 7babd1e9a378..1207196cbbed 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3193,7 +3193,13 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 
 	case SIOCSIFHWADDR:
 		/* Set hw address */
-		ret = dev_set_mac_address_user(tun->dev, &ifr.ifr_hwaddr, NULL);
+		if (tun->dev->addr_len > sizeof(ifr.ifr_hwaddr)) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = dev_set_mac_address_user(tun->dev,
+					       (struct sockaddr_storage *)&ifr.ifr_hwaddr,
+					       NULL);
 		break;
 
 	case TUNGETSNDBUF:
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index 6011a5ef649d..1bf0153195f2 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -84,14 +84,15 @@ void dev_set_group(struct net_device *dev, int new_group)
 	netdev_unlock_ops(dev);
 }
 
-int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
+int dev_set_mac_address_user(struct net_device *dev,
+			     struct sockaddr_storage *ss,
 			     struct netlink_ext_ack *extack)
 {
 	int ret;
 
 	down_write(&dev_addr_sem);
 	netdev_lock_ops(dev);
-	ret = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
+	ret = netif_set_mac_address(dev, ss, extack);
 	netdev_unlock_ops(dev);
 	up_write(&dev_addr_sem);
 
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index fff13a8b48f1..616479e71466 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -572,9 +572,11 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 		return dev_set_mtu(dev, ifr->ifr_mtu);
 
 	case SIOCSIFHWADDR:
-		if (dev->addr_len > sizeof(struct sockaddr))
+		if (dev->addr_len > sizeof(ifr->ifr_hwaddr))
 			return -EINVAL;
-		return dev_set_mac_address_user(dev, &ifr->ifr_hwaddr, NULL);
+		return dev_set_mac_address_user(dev,
+						(struct sockaddr_storage *)&ifr->ifr_hwaddr,
+						NULL);
 
 	case SIOCSIFHWBROADCAST:
 		if (ifr->ifr_hwaddr.sa_family != dev->type)
-- 
2.34.1


