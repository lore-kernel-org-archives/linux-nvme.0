Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3E1C54EDA
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 16:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wi0UdrTiJ+AtrL2e/Sl369BIO7fIF+C3tLfBYBklOHE=; b=U9heu5KFUshP5WqKMAn07PhsNP
	BuWJEBPh5COY2lL9L292W/TpCWvdTk/DLh266haVuaNnB9ugSQ78WykfOiebvROaSizQb4mLDTl0s
	LasYdLW6DCQaPRUdEi3LCoBbLxhw+tyedxAYUuHCKYNyVU3NYl6YHm8BVmHQWPJl9erWn0yNq53Zg
	f33q3Zsxwp19T2FLqQ5jsBobTnuxf/4YVODLNjFK85Q1+b9P8UYWHOhDz3urphSuM/KfYr4hcrsxJ
	0/q94tVz6uHttHsemWJjBOGLxIAobRKqMU07IYLYuhdo3RE6Nx2cKJYwGgLRe850gDoKTCoSfgjHJ
	PDFhxfhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI8w3-00000001c3w-3uN1;
	Thu, 22 May 2025 16:38:23 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHqKY-0000000Go0j-1erG
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 20:46:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6B795A4F312;
	Wed, 21 May 2025 20:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D172C4CEE4;
	Wed, 21 May 2025 20:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747860385;
	bh=euBwZn0uIF7MJHWwzG0lTQpTqXVn0Aafo4uJEYuZTeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qp1CATHn/VUgcgqz5540CDqe9HC/FGZfq6354MEUoXOkWB6NJGVtkzDjng4qAGzon
	 cTDJf+C1DALZnWz2U20HvefxhjUDTvQYvdP8bkugAY1ahAjWCv//R80yvOvE8NvCF5
	 Jq2CRf8oyLEP8n3yfk/n4D+qj0e2lQlvC5ml62mfo7Kp5p67SAcL4GTXlyMfBD67ST
	 6Q7gesCMIf0+EMCtrugQXzxS3BNWhlh4R2vTH+oW/ac3S+rC9sJoZKYEO9AS9HBVBB
	 W9edJ2gxt98KwUs1IrG5W+z6kaqSOFcwg5iaFTwGePxjLy3/+iKA8iXjem+yziG5xy
	 JOBnlh/Y+vwyg==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hayes Wang <hayeswang@realtek.com>,
	Douglas Anderson <dianders@chromium.org>,
	Grant Grundler <grundler@chromium.org>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
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
	Simon Horman <horms@kernel.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Lei Yang <leiyang@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
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
	linux-wpan@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v2 5/8] net: usb: r8152: Convert to use struct sockaddr_storage internally
Date: Wed, 21 May 2025 13:46:13 -0700
Message-Id: <20250521204619.2301870-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521204310.it.500-kees@kernel.org>
References: <20250521204310.it.500-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5749; i=kees@kernel.org; h=from:subject; bh=euBwZn0uIF7MJHWwzG0lTQpTqXVn0Aafo4uJEYuZTeg=; b=owGbwMvMwCVmps19z/KJym7G02pJDBl61tNTbid3VDsEvv/Je3byvSnbZApvNVxZwDuV+/TbL 6/nPO3521HKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjCR91GMDI8f3zrrs/khq3SY 7h+rlhYrxidKIqwq3lmy3XkqJad3ODL8U5Zee+WEQPsPn2mhNe2ijo02p6oKuXV3fjQ6dcz47u8 AJgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_134626_565869_1A4708A0 
X-CRM114-Status: GOOD (  18.77  )
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

To support coming API type changes, switch to sockaddr_storage usage
internally.

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Hayes Wang <hayeswang@realtek.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Grant Grundler <grundler@chromium.org>
Cc: <linux-usb@vger.kernel.org>
Cc: <netdev@vger.kernel.org>
---
 drivers/net/usb/r8152.c | 52 +++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 67f5d30ffcba..b18dee1b1bb3 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1665,14 +1665,14 @@ static int
 rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 		  u32 advertising);
 
-static int __rtl8152_set_mac_address(struct net_device *netdev, void *p,
+static int __rtl8152_set_mac_address(struct net_device *netdev,
+				     struct sockaddr_storage *addr,
 				     bool in_resume)
 {
 	struct r8152 *tp = netdev_priv(netdev);
-	struct sockaddr *addr = p;
 	int ret = -EADDRNOTAVAIL;
 
-	if (!is_valid_ether_addr(addr->sa_data))
+	if (!is_valid_ether_addr(addr->__data))
 		goto out1;
 
 	if (!in_resume) {
@@ -1683,10 +1683,10 @@ static int __rtl8152_set_mac_address(struct net_device *netdev, void *p,
 
 	mutex_lock(&tp->control);
 
-	eth_hw_addr_set(netdev, addr->sa_data);
+	eth_hw_addr_set(netdev, addr->__data);
 
 	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_CONFIG);
-	pla_ocp_write(tp, PLA_IDR, BYTE_EN_SIX_BYTES, 8, addr->sa_data);
+	pla_ocp_write(tp, PLA_IDR, BYTE_EN_SIX_BYTES, 8, addr->__data);
 	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_NORAML);
 
 	mutex_unlock(&tp->control);
@@ -1706,7 +1706,8 @@ static int rtl8152_set_mac_address(struct net_device *netdev, void *p)
  * host system provided MAC address.
  * Examples of this are Dell TB15 and Dell WD15 docks
  */
-static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
+static int vendor_mac_passthru_addr_read(struct r8152 *tp,
+					 struct sockaddr_storage *ss)
 {
 	acpi_status status;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -1774,47 +1775,48 @@ static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
 		ret = -EINVAL;
 		goto amacout;
 	}
-	memcpy(sa->sa_data, buf, 6);
+	memcpy(ss->__data, buf, 6);
 	tp->netdev->addr_assign_type = NET_ADDR_STOLEN;
 	netif_info(tp, probe, tp->netdev,
-		   "Using pass-thru MAC addr %pM\n", sa->sa_data);
+		   "Using pass-thru MAC addr %pM\n", ss->__data);
 
 amacout:
 	kfree(obj);
 	return ret;
 }
 
-static int determine_ethernet_addr(struct r8152 *tp, struct sockaddr *sa)
+static int determine_ethernet_addr(struct r8152 *tp,
+				   struct sockaddr_storage *ss)
 {
 	struct net_device *dev = tp->netdev;
 	int ret;
 
-	sa->sa_family = dev->type;
+	ss->ss_family = dev->type;
 
-	ret = eth_platform_get_mac_address(&tp->udev->dev, sa->sa_data);
+	ret = eth_platform_get_mac_address(&tp->udev->dev, ss->__data);
 	if (ret < 0) {
 		if (tp->version == RTL_VER_01) {
-			ret = pla_ocp_read(tp, PLA_IDR, 8, sa->sa_data);
+			ret = pla_ocp_read(tp, PLA_IDR, 8, ss->__data);
 		} else {
 			/* if device doesn't support MAC pass through this will
 			 * be expected to be non-zero
 			 */
-			ret = vendor_mac_passthru_addr_read(tp, sa);
+			ret = vendor_mac_passthru_addr_read(tp, ss);
 			if (ret < 0)
 				ret = pla_ocp_read(tp, PLA_BACKUP, 8,
-						   sa->sa_data);
+						   ss->__data);
 		}
 	}
 
 	if (ret < 0) {
 		netif_err(tp, probe, dev, "Get ether addr fail\n");
-	} else if (!is_valid_ether_addr(sa->sa_data)) {
+	} else if (!is_valid_ether_addr(ss->__data)) {
 		netif_err(tp, probe, dev, "Invalid ether addr %pM\n",
-			  sa->sa_data);
+			  ss->__data);
 		eth_hw_addr_random(dev);
-		ether_addr_copy(sa->sa_data, dev->dev_addr);
+		ether_addr_copy(ss->__data, dev->dev_addr);
 		netif_info(tp, probe, dev, "Random ether addr %pM\n",
-			   sa->sa_data);
+			   ss->__data);
 		return 0;
 	}
 
@@ -1824,17 +1826,17 @@ static int determine_ethernet_addr(struct r8152 *tp, struct sockaddr *sa)
 static int set_ethernet_addr(struct r8152 *tp, bool in_resume)
 {
 	struct net_device *dev = tp->netdev;
-	struct sockaddr sa;
+	struct sockaddr_storage ss;
 	int ret;
 
-	ret = determine_ethernet_addr(tp, &sa);
+	ret = determine_ethernet_addr(tp, &ss);
 	if (ret < 0)
 		return ret;
 
 	if (tp->version == RTL_VER_01)
-		eth_hw_addr_set(dev, sa.sa_data);
+		eth_hw_addr_set(dev, ss.__data);
 	else
-		ret = __rtl8152_set_mac_address(dev, &sa, in_resume);
+		ret = __rtl8152_set_mac_address(dev, &ss, in_resume);
 
 	return ret;
 }
@@ -8421,7 +8423,7 @@ static int rtl8152_post_reset(struct usb_interface *intf)
 {
 	struct r8152 *tp = usb_get_intfdata(intf);
 	struct net_device *netdev;
-	struct sockaddr sa;
+	struct sockaddr_storage ss;
 
 	if (!tp || !test_bit(PROBED_WITH_NO_ERRORS, &tp->flags))
 		goto exit;
@@ -8429,8 +8431,8 @@ static int rtl8152_post_reset(struct usb_interface *intf)
 	rtl_set_accessible(tp);
 
 	/* reset the MAC address in case of policy change */
-	if (determine_ethernet_addr(tp, &sa) >= 0)
-		dev_set_mac_address (tp->netdev, &sa, NULL);
+	if (determine_ethernet_addr(tp, &ss) >= 0)
+		dev_set_mac_address(tp->netdev, (struct sockaddr *)&ss, NULL);
 
 	netdev = tp->netdev;
 	if (!netif_running(netdev))
-- 
2.34.1


