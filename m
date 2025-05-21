Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C70C54ED0
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 16:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3O0pdcT50X2JtFUldvuuHQcfp3v/Gsxzw8U7YWSBo5w=; b=JifHOaNV8LD/NyZMqzFUdV1lfE
	f8mjhphMz2Trks0PJV6ckYq8vlyvEmQFK1pRgJAbvfIon2cgGJVvaCVCG1lG4pgCvNO77Md3POOPo
	r5gX7icXhYpTog0tMjPoSSfWLaDqLWnoEfhk/MDsc8Du7WibpFtl5RBbUAR4RJlDMGyc60TrMFDNJ
	BmVYq0fw1bMj4fYiP3R+jhBuCEiv9l6Nu5P62dRn9QWDnHfH6EDDK1vLlOLH5OzoROyqC31BlK9Z4
	Rnj0vg+tm8+sqkdy+1yc72iU+kybigUWa19S2DoPdAq3EHiIJBwHmCaVVa3RLk3UynHj6N5lnjDsR
	p79+qbRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI8w3-00000001c3H-189S;
	Thu, 22 May 2025 16:38:23 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHqKY-0000000Go0x-1iZ7
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 20:46:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 70FE04A6DB;
	Wed, 21 May 2025 20:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322E2C4CEEA;
	Wed, 21 May 2025 20:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747860385;
	bh=l0FQvf1M3ScltpOkIqN+MDVq9vIgvD938vpt9yDUCJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vBKLuJ7sKUSpfyXuxBqq39G79W7Rz+UgR7DuXV2nFijDXVirka3E+lf3mI6fXB0Yo
	 mZOUQfG73t+Xuth33SjGVYKaekrLaoII2/T3K6AZjNEhr0CPUF8ElsWBpwwwveUigJ
	 ggl0EEtsqlQRlArrV8y7Eilmbkxj8H7zTcXtCzT9hboQyrqMZpNFXmf8Rn/4VDah9J
	 TPGWWMi38PnhlLxhpPZ3PHppOIRAeJ2aNCzY68IyOav836l3I6flsMl32tjnY/gMza
	 WxFzQG4WJNLON5DDl6tmYOC3c4khu2AQm7il4HADgQwwQxxOQsHUTU5BUtanTzVtfR
	 U34EqaLwCIOwg==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
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
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Lei Yang <leiyang@redhat.com>,
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
	linux-wpan@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v2 7/8] rtnetlink: do_setlink: Use struct sockaddr_storage
Date: Wed, 21 May 2025 13:46:15 -0700
Message-Id: <20250521204619.2301870-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521204310.it.500-kees@kernel.org>
References: <20250521204310.it.500-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2148; i=kees@kernel.org; h=from:subject; bh=l0FQvf1M3ScltpOkIqN+MDVq9vIgvD938vpt9yDUCJ4=; b=owGbwMvMwCVmps19z/KJym7G02pJDBl61tMbYmZ7vqv3y5thHs3r9nVXSVtZ7MEJ73YFLVVlf crw4fn/jlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImYKjAyfDV1aEz44sad4qiz 39HRp5zLnFf5iffcMym3Px+wdE/gY/ineFOBL/PIyU28LFO3x+ZnOm9YpcfdFuQ7kyW368Lt3AU cAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_134626_489618_35597F61 
X-CRM114-Status: GOOD (  14.38  )
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

Instead of a heap allocating a variably sized struct sockaddr and lying
about the type in the call to netif_set_mac_address(), use a stack
allocated struct sockaddr_storage. This lets us drop the cast and avoid
the allocation.

Putting "ss" on the stack means it will get a reused stack slot since
it is the same size (128B) as other existing single-scope stack variables,
like the vfinfo array (128B), so no additional stack space is used by
this function.

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>
---
 net/core/rtnetlink.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 9743f1c2ae3c..f9a35bdc58ad 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3080,17 +3080,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 	}
 
 	if (tb[IFLA_ADDRESS]) {
-		struct sockaddr *sa;
-		int len;
-
-		len = sizeof(sa_family_t) + max_t(size_t, dev->addr_len,
-						  sizeof(*sa));
-		sa = kmalloc(len, GFP_KERNEL);
-		if (!sa) {
-			err = -ENOMEM;
-			goto errout;
-		}
-		sa->sa_family = dev->type;
+		struct sockaddr_storage ss = { };
 
 		netdev_unlock_ops(dev);
 
@@ -3098,10 +3088,9 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 		down_write(&dev_addr_sem);
 		netdev_lock_ops(dev);
 
-		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
-		       dev->addr_len);
-		err = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
-		kfree(sa);
+		ss.ss_family = dev->type;
+		memcpy(ss.__data, nla_data(tb[IFLA_ADDRESS]), dev->addr_len);
+		err = netif_set_mac_address(dev, &ss, extack);
 		if (err) {
 			up_write(&dev_addr_sem);
 			goto errout;
-- 
2.34.1


