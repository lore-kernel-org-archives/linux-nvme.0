Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F317FC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 11:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KZobnTvHVRGj8VnmtvNun3RbnRa5h4o6yXoKaMfPo0Q=; b=lefGxHAYJK5TPgLOGaqPCk1Nte
	VrnHZ9hzK6n1J74AoMPjBPZPnyLNKJbsdyb0S+2k78lTqwBejOGqtEC2a5QnDkgsFcE8TrkfC8ouq
	SBKcfhgn6BEORHcqrNDWPrHKwPkvwWH3uwKxXFuo3V5aeWL7oO81wtnD8sRl6ATo33tzqjTW2C1/B
	OFWhsFPlU2MjnWrNFZAxA/Mnu3ogDuVo4Qya/xjtzChxAsBdpkzSH0I3wE+oaDXVSvuEmC3A8jtrM
	bDW7DpakwuuBYTuWwpTN6G+lQxXMMYmEFn+F5cP60BTOWLBpIyvwBmK+IMFgnkATlgWU2JCiPzD7S
	ofbZXJkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCJgh-006fvh-FJ; Fri, 15 Jul 2022 11:40:51 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCJge-006ftc-R5
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 11:40:50 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 8AC0E34D5A;
	Fri, 15 Jul 2022 11:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1657885245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KZobnTvHVRGj8VnmtvNun3RbnRa5h4o6yXoKaMfPo0Q=;
	b=EPSSg5cpOUEHcCF+bT8PzOzWnJG2UAlLVgt31Ew1rXa2+my/9cmp6DJva3weY0ZRt4bs/C
	RK6yati/ieRCkgh1IXIk+1MqjxJJeJd0UFIO5EoljI5lvihrdAZvSZ4Ylxs0vHne5brhuo
	uN9nZO9sKEQlt7XWOnVGW7TUP2jwKmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1657885245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KZobnTvHVRGj8VnmtvNun3RbnRa5h4o6yXoKaMfPo0Q=;
	b=x5zh2+UGTfkMx+/W6i9iR8vc8aozipszDpqWOKTJtpTl87sge1+Hbv79N11f5vE6u3ztKq
	ljplV7KA4n5zsWBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 7E7522C142;
	Fri, 15 Jul 2022 11:40:45 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 6DC635198905; Fri, 15 Jul 2022 13:40:45 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme-auth: Fixup kernel test robot warnings
Date: Fri, 15 Jul 2022 13:40:44 +0200
Message-Id: <20220715114044.104782-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_044049_061584_7FFB5CF5 
X-CRM114-Status: GOOD (  12.83  )
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

The linux kernel test robot complained that some checks in
nvme_auth_hmac_{len,name,id} and nvme_auth_dhgroup_{name,kpp,id}
always evaluate to 'true'. So simplify the conditions to get
rid of those warnings.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/common/auth.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 0c86ebce59d2..94cc7cafbb9d 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -55,9 +55,7 @@ static struct nvme_auth_dhgroup_map {
 
 const char *nvme_auth_dhgroup_name(u8 dhgroup_id)
 {
-	if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
-	    !dhgroup_map[dhgroup_id].name ||
-	    !strlen(dhgroup_map[dhgroup_id].name))
+	if (dhgroup_id > ARRAY_SIZE(dhgroup_map))
 		return NULL;
 	return dhgroup_map[dhgroup_id].name;
 }
@@ -65,9 +63,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_name);
 
 const char *nvme_auth_dhgroup_kpp(u8 dhgroup_id)
 {
-	if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
-	    !dhgroup_map[dhgroup_id].kpp ||
-	    !strlen(dhgroup_map[dhgroup_id].kpp))
+	if (dhgroup_id > ARRAY_SIZE(dhgroup_map))
 		return NULL;
 	return dhgroup_map[dhgroup_id].kpp;
 }
@@ -77,9 +73,10 @@ u8 nvme_auth_dhgroup_id(const char *dhgroup_name)
 {
 	int i;
 
+	if (!dhgroup_name || !strlen(dhgroup_name))
+		return NVME_AUTH_DHGROUP_INVALID;
 	for (i = 0; i < ARRAY_SIZE(dhgroup_map); i++) {
-		if (!dhgroup_map[i].name ||
-		    !strlen(dhgroup_map[i].name))
+		if (!strlen(dhgroup_map[i].name))
 			continue;
 		if (!strncmp(dhgroup_map[i].name, dhgroup_name,
 			     strlen(dhgroup_map[i].name)))
@@ -113,9 +110,7 @@ static struct nvme_dhchap_hash_map {
 
 const char *nvme_auth_hmac_name(u8 hmac_id)
 {
-	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
-	    !hash_map[hmac_id].hmac ||
-	    !strlen(hash_map[hmac_id].hmac))
+	if (hmac_id > ARRAY_SIZE(hash_map))
 		return NULL;
 	return hash_map[hmac_id].hmac;
 }
@@ -123,9 +118,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_name);
 
 const char *nvme_auth_digest_name(u8 hmac_id)
 {
-	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
-	    !hash_map[hmac_id].digest ||
-	    !strlen(hash_map[hmac_id].digest))
+	if (hmac_id > ARRAY_SIZE(hash_map))
 		return NULL;
 	return hash_map[hmac_id].digest;
 }
@@ -135,8 +128,11 @@ u8 nvme_auth_hmac_id(const char *hmac_name)
 {
 	int i;
 
+	if (!hmac_name || !strlen(hmac_name))
+		return NVME_AUTH_HASH_INVALID;
+
 	for (i = 0; i < ARRAY_SIZE(hash_map); i++) {
-		if (!hash_map[i].hmac || !strlen(hash_map[i].hmac))
+		if (!strlen(hash_map[i].hmac))
 			continue;
 		if (!strncmp(hash_map[i].hmac, hmac_name,
 			     strlen(hash_map[i].hmac)))
@@ -148,9 +144,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_id);
 
 size_t nvme_auth_hmac_hash_len(u8 hmac_id)
 {
-	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
-	    !hash_map[hmac_id].hmac ||
-	    !strlen(hash_map[hmac_id].hmac))
+	if (hmac_id > ARRAY_SIZE(hash_map))
 		return 0;
 	return hash_map[hmac_id].len;
 }
-- 
2.29.2


