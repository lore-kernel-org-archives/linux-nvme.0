Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE47606A31C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3cFmD4gj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=pD86UpHOxhyLqzS6be0EhkIEJCw12KAcYQlv+BBMplU=; b=3cFmD4gjkOwpVlXYpaAkXbItnE
	RxgfI2b0GrkBin2x8uxA4Og2x9QDm7xOK6xAiu1f/ct0Pd7lM/ZEy0M9HNZkH/pwEb2a9TO+AuIX+
	rolFjwMFTjsA8LFomlySxrP6PE/2Sh6by2P2I8Rt0ayElgm05O+DIp/OaES3z2ESfYtS4D9pMdH7o
	LHG7Jdu5+ZCaUMGdD07C+1luIH1ZjI0LlY4HYApDSvNIA+5ikIvmBEjYjeFy9LuEWUS/CO1Jjq5AY
	cjGKjQ55pDy43UP8nNj6uCHDFkOsO6t1edv0WMlN52UG952I03Gr/ef4sDTVGKtioYXSZciHnYzNw
	2ArEDaGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRnoJ-0000000CFRg-2Gm7;
	Fri, 13 Nov 2026 09:43:07 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRnoE-0000000CFP8-2g4x
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 09:43:05 +0000
X-UUID: 902a8ca4df4611f19a56ed5b684f684d-20261113
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED
	SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:cdb45710-6009-44f6-b47a-6eedb2131482,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:cdb45710-6009-44f6-b47a-6eedb2131482,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:44419d180148dd700d819c0f740def09,BulkI
	D:261113174241C9BMUJOO,BulkQuantity:0,SF:10|66|78|102|127|153|850|865|898,
	TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 902a8ca4df4611f19a56ed5b684f684d-20261113
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(114.244.3.119)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 62882414; Fri, 13 Nov 2026 17:42:38 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH] nvmet-auth: lock DH-HMAC-CHAP key clearing
Date: Fri, 13 Nov 2026 17:42:14 +0800
Message-Id: <20261113094214.1918982-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_014302_996583_6F109737 
X-CRM114-Status: GOOD (  10.68  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clearing a key without nvmet_config_sem can race with configfs reads
or authentication and cause a use-after-free.

Use the same locked path to set and clear keys.

Fixes: bb2df18958b4 ("nvmet-auth: allow to clear DH-HMAC-CHAP keys")
Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 drivers/nvme/target/auth.c | 43 ++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index ccba84b1344e..3cbe90a432ef 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -22,39 +22,32 @@
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl)
 {
-	unsigned char key_hash;
-	char *dhchap_secret;
-
-	if (!strlen(secret)) {
-		if (set_ctrl) {
-			kfree(host->dhchap_ctrl_secret);
-			host->dhchap_ctrl_secret = NULL;
-			host->dhchap_ctrl_key_hash = 0;
-		} else {
-			kfree(host->dhchap_secret);
-			host->dhchap_secret = NULL;
-			host->dhchap_key_hash = 0;
+	unsigned char key_hash = 0;
+	char *dhchap_secret = NULL;
+
+	if (*secret) {
+		if (sscanf(secret, "DHHC-1:%hhd:%*s", &key_hash) != 1)
+			return -EINVAL;
+		if (key_hash > 3) {
+			pr_warn("Invalid DH-HMAC-CHAP hash id %d\n",
+				key_hash);
+			return -EINVAL;
 		}
-		return 0;
-	}
-	if (sscanf(secret, "DHHC-1:%hhd:%*s", &key_hash) != 1)
-		return -EINVAL;
-	if (key_hash > 3) {
-		pr_warn("Invalid DH-HMAC-CHAP hash id %d\n",
-			 key_hash);
-		return -EINVAL;
+
+		dhchap_secret = kstrdup(secret, GFP_KERNEL);
+		if (!dhchap_secret)
+			return -ENOMEM;
+		dhchap_secret = strim(dhchap_secret);
 	}
-	dhchap_secret = kstrdup(secret, GFP_KERNEL);
-	if (!dhchap_secret)
-		return -ENOMEM;
+
 	down_write(&nvmet_config_sem);
 	if (set_ctrl) {
 		kfree(host->dhchap_ctrl_secret);
-		host->dhchap_ctrl_secret = strim(dhchap_secret);
+		host->dhchap_ctrl_secret = dhchap_secret;
 		host->dhchap_ctrl_key_hash = key_hash;
 	} else {
 		kfree(host->dhchap_secret);
-		host->dhchap_secret = strim(dhchap_secret);
+		host->dhchap_secret = dhchap_secret;
 		host->dhchap_key_hash = key_hash;
 	}
 	up_write(&nvmet_config_sem);
-- 
2.25.1


