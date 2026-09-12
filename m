Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC645C88E59
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Sep 2026 17:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0DeWI7yWKMhOTA8L1o8/gSta/I0gOo2/cgp9qNzVlGE=; b=xmVJAvHB/BZV19ot6e+KRxzyh9
	hZfpvoPsW64OdYcsyneXe4U9C452dNWnEA/4KX0RJOQsUNTQQ/koSTduaEYCrv42UW2IdtCsEBeaG
	Ilt2Iq4USsVLC9Nlas7JOw8+d9Al5KNAdB/Zo4WjuNKRWhSkBkxVHUA2vgm1aKdJA1qv8wjRY+X/m
	t9lXid/4VURGPoCGe+ZGVnDS6Vp4GFKhqdtu0E9KyEa/3O8ZKsG/ETJwpL7z2YVBrVfO9egiOj6IN
	6pEWQGAoyTm5G//vqVq8sDRJz5TFJLFFaz9jzdWEfKLWm02M+GzHgmCacmyNMOr9KyIGtmjj9oMTi
	3028ITPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5RXO-000000012Sa-2VxL;
	Sat, 12 Sep 2026 17:29:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5RXN-000000012SA-15kH
	for linux-nvme@bombadil.infradead.org;
	Sat, 12 Sep 2026 17:29:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=0DeWI7yWKMhOTA8L1o8/gSta/I0gOo2/cgp9qNzVlGE=; b=j+jUWAecAteZG6WGbMEYkjKAql
	qWTXzSjCGk/BHnjwp6k+07i0zAoYX0x2+dj99Tbpz66xhBLVjWKUto85gUBOVYdaQiRyd4VPvdfNh
	M68WTGgeGQnHHvj8Dk/mvcr8zbdLZThUMg63Ul7vyxL6U9x4p9BYbPot5sjAl+Uhw/ywIZ2Pplt3s
	/EdCqv/bhI53/8ibCkTJ4IUHyBkwQ2WaXoWQx7EjxSoyL+ucWqQ9isThmiYNnNsdEEqbCauS4SSCg
	P7iuS4UruQNlE4eZSdzqZbWULwgo4p3Wh8yDf3zrQS5RZGR3pPRO7l/xGknFfaTDhulPy3YopRjEq
	b9Z+jOlw==;
Received: from smtp-22.smtpout.orange.fr ([80.12.242.22] helo=smtp.smtpout.orange.fr)
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x5RXJ-00000004WPG-2FMv
	for linux-nvme@lists.infradead.org;
	Sat, 12 Sep 2026 17:29:11 +0000
Received: from device-106.home ([10.64.95.107])
	by smtp.orange.fr with ESMTP
	id 5IA7x4bYF4WOc5IA7xIMj7; Sat, 12 Sep 2026 09:28:35 +0200
Received: from device-106.home ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id 5IA4xBPdCDGip5IA4xOT8z; Sat, 12 Sep 2026 09:28:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1789198115;
	bh=0DeWI7yWKMhOTA8L1o8/gSta/I0gOo2/cgp9qNzVlGE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Dcex9FWgzImdvlzB7ZppOwQ3EHL+OnskH8uEkAulWNMVQWxDx8uZ0iKaFXE17XrB+
	 2Ph9GPtw+Oso5DQDqq8p2kBZqrLHEM0MTAEjuuas+Ca1fdv8jitgXJzobNDVLA6aXh
	 rAppp5M22QF7boY3ilP6FZ7GqBbM5KLQ7i96IicRCGN7C8C/RSDo+cnqO6FH0VrC2F
	 otBqa2L8oQWYR+P57k2038cCDAhOuiw0IpOTDwtvqxyEjwjLKNxM5xzgJKChgRLCSa
	 O9pwXjW09nt10BT7N4SsT856vFoZWGjtBhtfo7QjtmDweBxtKPFwzw76JEtP1Jbz3J
	 Ctfl0jThtjKWA==
X-ME-Helo: device-106.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 12 Sep 2026 09:28:35 +0200
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-keyring: Constify struct nvme_tls_psk_priority_list
Date: Sat, 12 Sep 2026 09:28:25 +0200
Message-ID: <303d4eff4cd1095ed248e64a7d4c799a49027394.1789198083.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260912_182909_747240_899756D1 
X-CRM114-Status: GOOD (  12.21  )
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

'struct nvme_tls_psk_priority_list' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increases overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   7097	   4296	     64	  11457	   2cc1	drivers/nvme/common/keyring.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   7193	   4200	     64	  11457	   2cc1	drivers/nvme/common/keyring.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/nvme/common/keyring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 32d16c53133b..43624d7713de 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -194,7 +194,7 @@ EXPORT_SYMBOL_GPL(nvme_tls_psk_refresh);
  * PSKs, PSKs with hash (psk_ver 1) should be preferred to PSKs without hash
  * (psk_ver 0), and SHA-384 should be preferred to SHA-256.
  */
-static struct nvme_tls_psk_priority_list {
+static const struct nvme_tls_psk_priority_list {
 	bool generated;
 	u8 psk_ver;
 	enum nvme_tcp_tls_cipher cipher;
-- 
2.55.0


