Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27169C54E92
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 04:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q4D8QP0Drk2RxXppqi3MWOoCmgsAR+aiSSnoHXYxWxE=; b=qElTEEY/9uAMapcN7pAoSTuP4c
	RzO0wL7seOp/FURL/05JcP52UddB6CLLYFb7ypbIIJ8F8VIHjVNh2Z/qUbQqZAJbAY9pZayLrfvVw
	6vU3GFIkk55iA0lL7XqVrxKEk9MdIIw0bMmqvlGWyqY6jDR3DC9q6lPwpRuiQgncNuOieAQMA4AMX
	3gxfePmJQHB2jdAdhSO4oiYL7xM/KYw2CCHxy+wD5aEvBL+tuu8MNa0WEd2UmdGCIuNkXT4l5y0rj
	HHsgfhv8xIq9ytPR4KGkLZfaRWtVKxa6j5W82/IoizojAOnlBA8Yig4dkjtBFHqZuA5b/pyawSwnR
	TZcXhBmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHbQs-0000000EmSE-2A6x;
	Wed, 21 May 2025 04:51:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHVUR-0000000EGzR-1wCc
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 22:31:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BF12C4AEE7;
	Tue, 20 May 2025 22:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BDFC4AF0C;
	Tue, 20 May 2025 22:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747780274;
	bh=G/KW2fG4F98OctuROMgZgIIvFCaLrHVnDk1WTYvgspw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f187OrFCg57oP0keL/hhM+Str6skqYz5KDi3ixuy4dW6InjJA8mmWQIlXSQwLQ6pB
	 yu//5NY1YoeUx2lAW15/4R9wVmBv8p7VaNipK9g8pxMsfWkg85pxXf3TQFP/10oK/r
	 BAsL57NAaPfN2JFfEWJV2ks4VFHiVIFMCTRKK1tx2sMMpa36JgSgRUQoMSPkTRwXF4
	 PPepSZwyKYp3lw02cEfA+Q04Z89y1WnubbHp/MwY1gfXDenV9S1p+totqqC03C2/rR
	 W/JQGom8aSowEx+F8QHM9zx3JEOHmx7bNAvAEOJXQXRg4xfKGkuXseY/eEVZuv2tr/
	 KKnIxOBXL6Fcg==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
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
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Lei Yang <leiyang@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
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
Subject: [PATCH 3/7] net/ncsi: Use struct sockaddr_storage for pending_mac
Date: Tue, 20 May 2025 15:31:02 -0700
Message-Id: <20250520223108.2672023-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520222452.work.063-kees@kernel.org>
References: <20250520222452.work.063-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4361; i=kees@kernel.org; h=from:subject; bh=G/KW2fG4F98OctuROMgZgIIvFCaLrHVnDk1WTYvgspw=; b=owGbwMvMwCVmps19z/KJym7G02pJDBm6TCunCmxWFNePehP86dB70827uoPWdOgUrArcFFzwa 3ksv9jJjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIlcPMjwVzQp/92/7mUeWUz6 crLSi1crXmCVWSB2NPJaUDunXPnyRob/ZWuqXyrWdfZONDS471Garv39t+b7vVEcbcL/o4JbpUo ZAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_153115_548825_8566605E 
X-CRM114-Status: GOOD (  19.42  )
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

To avoid future casting with coming API type changes, switch struct
ncsi_dev_priv::pending_mac to a full struct sockaddr_storage.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Cc: Paul Fertser <fercerpav@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: <netdev@vger.kernel.org>
---
 net/ncsi/internal.h    |  2 +-
 net/ncsi/ncsi-manage.c |  2 +-
 net/ncsi/ncsi-rsp.c    | 18 +++++++++---------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 2c260f33b55c..e76c6de0c784 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -322,7 +322,7 @@ struct ncsi_dev_priv {
 #define NCSI_DEV_RESHUFFLE	4
 #define NCSI_DEV_RESET		8            /* Reset state of NC          */
 	unsigned int        gma_flag;        /* OEM GMA flag               */
-	struct sockaddr     pending_mac;     /* MAC address received from GMA */
+	struct sockaddr_storage pending_mac; /* MAC address received from GMA */
 	spinlock_t          lock;            /* Protect the NCSI device    */
 	unsigned int        package_probe_id;/* Current ID during probe    */
 	unsigned int        package_num;     /* Number of packages         */
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index b36947063783..0202db2aea3e 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1058,7 +1058,7 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 		break;
 	case ncsi_dev_state_config_apply_mac:
 		rtnl_lock();
-		ret = dev_set_mac_address(dev, &ndp->pending_mac, NULL);
+		ret = dev_set_mac_address(dev, (struct sockaddr *)&ndp->pending_mac, NULL);
 		rtnl_unlock();
 		if (ret < 0)
 			netdev_warn(dev, "NCSI: 'Writing MAC address to device failed\n");
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 8668888c5a2f..472cc68ad86f 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -628,7 +628,7 @@ static int ncsi_rsp_handler_snfc(struct ncsi_request *nr)
 static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 {
 	struct ncsi_dev_priv *ndp = nr->ndp;
-	struct sockaddr *saddr = &ndp->pending_mac;
+	struct sockaddr_storage *saddr = &ndp->pending_mac;
 	struct net_device *ndev = ndp->ndev.dev;
 	struct ncsi_rsp_oem_pkt *rsp;
 	u32 mac_addr_off = 0;
@@ -644,11 +644,11 @@ static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 	else if (mfr_id == NCSI_OEM_MFR_INTEL_ID)
 		mac_addr_off = INTEL_MAC_ADDR_OFFSET;
 
-	saddr->sa_family = ndev->type;
-	memcpy(saddr->sa_data, &rsp->data[mac_addr_off], ETH_ALEN);
+	saddr->ss_family = ndev->type;
+	memcpy(saddr->__data, &rsp->data[mac_addr_off], ETH_ALEN);
 	if (mfr_id == NCSI_OEM_MFR_BCM_ID || mfr_id == NCSI_OEM_MFR_INTEL_ID)
-		eth_addr_inc((u8 *)saddr->sa_data);
-	if (!is_valid_ether_addr((const u8 *)saddr->sa_data))
+		eth_addr_inc(saddr->__data);
+	if (!is_valid_ether_addr(saddr->__data))
 		return -ENXIO;
 
 	/* Set the flag for GMA command which should only be called once */
@@ -1088,7 +1088,7 @@ static int ncsi_rsp_handler_netlink(struct ncsi_request *nr)
 static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
 {
 	struct ncsi_dev_priv *ndp = nr->ndp;
-	struct sockaddr *saddr = &ndp->pending_mac;
+	struct sockaddr_storage *saddr = &ndp->pending_mac;
 	struct net_device *ndev = ndp->ndev.dev;
 	struct ncsi_rsp_gmcma_pkt *rsp;
 	int i;
@@ -1105,15 +1105,15 @@ static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
 			    rsp->addresses[i][4], rsp->addresses[i][5]);
 	}
 
-	saddr->sa_family = ndev->type;
+	saddr->ss_family = ndev->type;
 	for (i = 0; i < rsp->address_count; i++) {
 		if (!is_valid_ether_addr(rsp->addresses[i])) {
 			netdev_warn(ndev, "NCSI: Unable to assign %pM to device\n",
 				    rsp->addresses[i]);
 			continue;
 		}
-		memcpy(saddr->sa_data, rsp->addresses[i], ETH_ALEN);
-		netdev_warn(ndev, "NCSI: Will set MAC address to %pM\n", saddr->sa_data);
+		memcpy(saddr->__data, rsp->addresses[i], ETH_ALEN);
+		netdev_warn(ndev, "NCSI: Will set MAC address to %pM\n", saddr->__data);
 		break;
 	}
 
-- 
2.34.1


