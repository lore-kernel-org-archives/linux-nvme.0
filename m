Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C62C2D0CD
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 04:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hq6/7s9L5QBpR1SNqSOIRQtqpZ6rzmq5+gZTFg34iJU=; b=ZdZeL4DECZ1VEzu42jfEJ5DJ/F
	dJ3A79UF3IFS0pdUF5zslNpvNPR1VwB5257j6ss1RIAVG1PFQ6a/phsSi4XY0LfjLq3Qd0E33ydbp
	joQcXlQCD2JB4ELSB9baJiyqScM1alHDm9pBkVChd9/6cpDaDkU40DLX0eb4husMoNsVHnowb5/67
	YQ/CwTzULq9yvq7r5/DY4qf8kaOIkmFNW/fV1X1zIrMB47xEnG/+cXmItuxrR+1OqpESumICtBI44
	W7ZBbEBV6nXYNT3+dcZP7VDnLbKSOPnz/Yh1q6OnSuzPHsXSOALTayg/iAZkVfpmtlcNhzE6mbEnu
	vtS0fGXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHbQu-0000000EmUC-2U7I;
	Wed, 21 May 2025 04:52:00 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHVUS-0000000EH0I-1RfA
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 22:31:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EE9344AEE5;
	Tue, 20 May 2025 22:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D095C4CEED;
	Tue, 20 May 2025 22:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747780274;
	bh=igIPzWO4UtdlqVXqgaOEG8EKTrUUS9nBOd3frgkk2rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bsxpPlJ30B2iPit5zxKLslFZoOWGdQyDGeqAyQ/8P30IGpTUrYAxr42VZtu8kZUbE
	 rUtRN/GmQBGaFvzdzDyZHshdYSJ6Rzkfa7dvxQFwq+RRFKlV5ht1lxUb6chN5A8IrI
	 /Gudl7bGdcNWQaHYApSbJVwe7EsTLHtiK6VnxB3OiJR1EO2jI426TJ0nbDsB2LU17n
	 YwhxHS8fRR1lcMihZAngxorPiWNA+TNvtKq7cwZg7Y5E5EdCqxEa5WeCFidaEVoyTy
	 9z45u3z4mYW5DTDiv6hR3Gz+eJBItlcRnDq7eyC/FLEdhjcEqvzA1+rps8rkXAWyQR
	 fSCmw93wwVCjw==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
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
	linux-hyperv@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 5/7] net: usb: r8152: Convert to use struct sockaddr_storage internally
Date: Tue, 20 May 2025 15:31:04 -0700
Message-Id: <20250520223108.2672023-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520222452.work.063-kees@kernel.org>
References: <20250520222452.work.063-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5694; i=kees@kernel.org; h=from:subject; bh=igIPzWO4UtdlqVXqgaOEG8EKTrUUS9nBOd3frgkk2rw=; b=owGbwMvMwCVmps19z/KJym7G02pJDBm6TCvrcy63S9y8Erpym7rgmW8P2lLcVmgumKje5tVVe P7yEZVNHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABOpuc3IcDp6R0Jtx14WFefS rXVdmut2deade3BX7OIJnXiRDilNe4Z/KnedHzN4RPn1JBT6yLfPU75/ic1R6GXT++fdMXuY9hR yAAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_153116_425590_40797914 
X-CRM114-Status: GOOD (  18.86  )
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

To support coming API type changes, switch to sockaddr_storage usage
internally.

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


