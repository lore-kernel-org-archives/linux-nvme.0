Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D49C54ED0
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 04:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nuyU/otZZ6F/kbQ0vjF7WHrbJic1jTjPt7X06a7y7Ws=; b=QpJfZW2OBrE5peow592lXcEd2a
	cOrxc2HKiwEaZ+8UJ2W6+6DLuct+zajcOZ3R5iv2FN8Bg73HtAmLqEWSMcBZcqfkTzILw6Bf0NweZ
	F2pJcxoQxKFjy70ijPwSULMF96QgQEYu8YUtJszRLZh2VfnFDRnEa4Uws4uol5dK+oTIiKeP5f6zL
	J1eLVDbGxN+JW0Jv5AiTgpLGH1gphPSSwSW22/Oqw/VuOyfKlIGLzsWWm8A8gSNYJCb0EC7hcO4Ak
	CDXExX26BKwzV4JFC5ZJx5U634x9dKZoWAjnAQle9Gvd9I2kmeS3up7616wsUosyVtKV8nStF2JM5
	JHZcNm/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHbQt-0000000EmTd-3bkb;
	Wed, 21 May 2025 04:51:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHVUS-0000000EGzo-008f
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 22:31:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CA1D74AEE9;
	Tue, 20 May 2025 22:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDE3C4CEEF;
	Tue, 20 May 2025 22:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747780274;
	bh=7+5aLCST6s7T/oujRRoROLyuAQnVT9g0E0a0chHKZpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ldaHrxJ+HWhXTPlP+sI/ZOa+dyUowLN+FvRZgsV/pojXZLN+5l0tMTfDgW+FvxXEi
	 l6kB4qqCzEH3QJojzSOdG0Soxb7diNMYVQQOQiXH/QZ4nG0KbFvhE62wcMzLmR5wxD
	 vYzJC23akqQAfWN3ae9OeyTLnv3bVi7P8nb8oOO0LP8BA+/UnJMz2QJIxAl+Rf5ezs
	 7/5N5COJCJr+5jsF5lwzw4tt9uCvfW/BgZqa5cozToSzp+Lk/4dFSB90zs1JQnJbXc
	 IxOg9p8m+B+dfNQb13ftdez29WQRPrpGVFpYOcgPikp73u22S2Sai2erFI4eeN0eEi
	 Vcrs0XReQcjHA==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-wpan@vger.kernel.org,
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
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
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
	linux-usb@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 4/7] ieee802154: Use struct sockaddr_storage with dev_set_mac_address()
Date: Tue, 20 May 2025 15:31:03 -0700
Message-Id: <20250520223108.2672023-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520222452.work.063-kees@kernel.org>
References: <20250520222452.work.063-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1660; i=kees@kernel.org; h=from:subject; bh=7+5aLCST6s7T/oujRRoROLyuAQnVT9g0E0a0chHKZpY=; b=owGbwMvMwCVmps19z/KJym7G02pJDBm6TCuvblF8lhP5XPy9sMWyEMOOBf5mZU1r2a84b9zO5 XOSa+eDjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIn0SzEydIpvmvaTp0OOf/HG wvDqKzx16Tpczr9fn9p0tPx64oXQBwz/U432vV52/+aEDRx7zU2ryn2Z8narzXt2blLAxWNdZx/ NYQEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_153116_082502_21C8E36D 
X-CRM114-Status: GOOD (  12.44  )
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

Switch to struct sockaddr_storage for calling dev_set_mac_address(). Add
a temporary cast to struct sockaddr, which will be removed in a
subsequent patch.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: <linux-wpan@vger.kernel.org>
Cc: <netdev@vger.kernel.org>
---
 net/ieee802154/nl-phy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
index 359249ab77bf..ee2b190e8e0d 100644
--- a/net/ieee802154/nl-phy.c
+++ b/net/ieee802154/nl-phy.c
@@ -224,17 +224,17 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
 	dev_hold(dev);
 
 	if (info->attrs[IEEE802154_ATTR_HW_ADDR]) {
-		struct sockaddr addr;
+		struct sockaddr_storage addr;
 
-		addr.sa_family = ARPHRD_IEEE802154;
-		nla_memcpy(&addr.sa_data, info->attrs[IEEE802154_ATTR_HW_ADDR],
+		addr.ss_family = ARPHRD_IEEE802154;
+		nla_memcpy(&addr.__data, info->attrs[IEEE802154_ATTR_HW_ADDR],
 			   IEEE802154_ADDR_LEN);
 
 		/* strangely enough, some callbacks (inetdev_event) from
 		 * dev_set_mac_address require RTNL_LOCK
 		 */
 		rtnl_lock();
-		rc = dev_set_mac_address(dev, &addr, NULL);
+		rc = dev_set_mac_address(dev, (struct sockaddr *)&addr, NULL);
 		rtnl_unlock();
 		if (rc)
 			goto dev_unregister;
-- 
2.34.1


