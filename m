Return-Path: <SRS0=1Q2H=NB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC814C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 12:51:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98A060F35
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 12:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A98A060F35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r354cwjPiuka9PwgxSfmAKEh6PRDWSFD/uZf6KtEsek=; b=MwGJ94MKpRQPlq
	x8v6JaDjbZwCaGaVXyfVkR5MEWIOtvKBFxVG4oE8+kvglI4q3Op/G8VUXaJKM3Ryo4VFCsq3FUBvS
	FLG8CMi1pdwBkVp4saHS/6UY6kAg5pvopn4jUEDVgUVeUMn/CCAtA1xPvHo57RoLKTukfmIx/dxH2
	NvhgcCO8NVazvMvIS0lTITlBthbjPi/gERY+7DBoGN/+8NgaWplI2HkhmSpomP1xdOJbRTd2oz7Qb
	uP0nBbT8lbgnBjrBS3nD3k5HpC2V35Zkqb+u4tFV0SO3V0NcFywiOEbOWlAwTAmxqSXlGxoiMSEtu
	MgZ8jCq1cbtwk+MaDA6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDRDo-003nYf-4q; Tue, 10 Aug 2021 12:51:08 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDR5v-003l6c-Oh
 for linux-nvme@lists.infradead.org; Tue, 10 Aug 2021 12:43:08 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 3BCFE200B3;
 Tue, 10 Aug 2021 12:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628599372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MUoNB1RE7VhyoT1+GvVF1n3f2kAKysSACL4JZIm62EA=;
 b=EX2vEI9iPdolviNRyMxdRU3CU11O4eOfGgO6VJpppShc8sUqjxev9d8M8aYZqSw13WphTh
 EoeWw5f+xYhnlDlZw3hGORRaLLLTc54ZtVzdxDiembtjbjJnVe7cZfHlfaKpB/iGuF19Ds
 USY31qdDkSHXqLG7pQCqGdzXbMJT5xQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628599372;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MUoNB1RE7VhyoT1+GvVF1n3f2kAKysSACL4JZIm62EA=;
 b=WFcQNkEFlZB//F5QFZeBEPxbYqgMdFIqhGS24JWxwebjGtKxSY9wgEMcjgmh5jYRMiu64y
 +/IoSmOIaqtRnfAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 20CD7A3B96;
 Tue, 10 Aug 2021 12:42:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 8D902518C55A; Tue, 10 Aug 2021 14:42:50 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 13/13] nvme: add non-standard ECDH and curve25517 algorithms
Date: Tue, 10 Aug 2021 14:42:30 +0200
Message-Id: <20210810124230.12161-14-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210810124230.12161-1-hare@suse.de>
References: <20210810124230.12161-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210810_054300_065569_B8FB1A9A 
X-CRM114-Status: GOOD (  17.91  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

TLS 1.3 specifies ECDH and curve25517 in addition to the FFDHE
groups, and these are already implemented in the kernel.
So add support for these non-standard groups for NVMe in-band
authentication to validate the augmented challenge implementation.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c | 34 +++++++++++++++++++++++++++++++++-
 include/linux/nvme.h     |  2 ++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index e73b5be4a4b0..6de2910eec80 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -9,6 +9,8 @@
 #include <crypto/hash.h>
 #include <crypto/dh.h>
 #include <crypto/ffdhe.h>
+#include <crypto/ecdh.h>
+#include <crypto/curve25519.h>
 #include "nvme.h"
 #include "fabrics.h"
 #include "auth.h"
@@ -69,6 +71,13 @@ static struct nvme_auth_dhgroup_map {
 	{ .id = NVME_AUTH_DHCHAP_DHGROUP_8192,
 	  .name = "ffdhe8192", .kpp = "dh",
 	  .privkey_size = 1024, .pubkey_size = 1024 },
+	{ .id = NVME_AUTH_DHCHAP_DHGROUP_ECDH,
+	  .name = "ecdh", .kpp = "ecdh-nist-p256",
+	  .privkey_size = 32, .pubkey_size = 64 },
+	{ .id = NVME_AUTH_DHCHAP_DHGROUP_25519,
+	  .name = "curve25519", .kpp = "curve25519",
+	  .privkey_size = CURVE25519_KEY_SIZE,
+	  .pubkey_size = CURVE25519_KEY_SIZE },
 };
 
 const char *nvme_auth_dhgroup_name(int dhgroup_id)
@@ -424,6 +433,27 @@ int nvme_auth_gen_privkey(struct crypto_kpp *dh_tfm, int dh_gid)
 			kfree_sensitive(dh_secret);
 			goto out;
 		}
+	} else if (dh_gid == NVME_AUTH_DHCHAP_DHGROUP_ECDH) {
+		struct ecdh p = {0};
+
+		pkey_len = crypto_ecdh_key_len(&p);
+		pkey = kmalloc(pkey_len, GFP_KERNEL);
+		if (!pkey)
+			return -ENOMEM;
+
+		get_random_bytes(pkey, pkey_len);
+		ret = crypto_ecdh_encode_key(pkey, pkey_len, &p);
+		if (ret) {
+			pr_debug("failed to encode private key, error %d\n",
+				 ret);
+			goto out;
+		}
+	} else if (dh_gid == NVME_AUTH_DHCHAP_DHGROUP_25519) {
+		pkey_len = CURVE25519_KEY_SIZE;
+		pkey = kmalloc(pkey_len, GFP_KERNEL);
+		if (!pkey)
+			return -ENOMEM;
+		get_random_bytes(pkey, pkey_len);
 	} else {
 		pr_warn("invalid dh group %d\n", dh_gid);
 		return -EINVAL;
@@ -597,7 +627,7 @@ static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
 	data->napd = 1;
 	data->auth_protocol[0].dhchap.authid = NVME_AUTH_DHCHAP_AUTH_ID;
 	data->auth_protocol[0].dhchap.halen = 3;
-	data->auth_protocol[0].dhchap.dhlen = 6;
+	data->auth_protocol[0].dhchap.dhlen = 8;
 	data->auth_protocol[0].dhchap.idlist[0] = NVME_AUTH_DHCHAP_SHA256;
 	data->auth_protocol[0].dhchap.idlist[1] = NVME_AUTH_DHCHAP_SHA384;
 	data->auth_protocol[0].dhchap.idlist[2] = NVME_AUTH_DHCHAP_SHA512;
@@ -607,6 +637,8 @@ static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
 	data->auth_protocol[0].dhchap.idlist[6] = NVME_AUTH_DHCHAP_DHGROUP_4096;
 	data->auth_protocol[0].dhchap.idlist[7] = NVME_AUTH_DHCHAP_DHGROUP_6144;
 	data->auth_protocol[0].dhchap.idlist[8] = NVME_AUTH_DHCHAP_DHGROUP_8192;
+	data->auth_protocol[0].dhchap.idlist[9] = NVME_AUTH_DHCHAP_DHGROUP_ECDH;
+	data->auth_protocol[0].dhchap.idlist[10] = NVME_AUTH_DHCHAP_DHGROUP_25519;
 
 	return size;
 }
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index e2142e3246eb..e1145bbfc92f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1477,6 +1477,8 @@ enum {
 	NVME_AUTH_DHCHAP_DHGROUP_4096	= 0x03,
 	NVME_AUTH_DHCHAP_DHGROUP_6144	= 0x04,
 	NVME_AUTH_DHCHAP_DHGROUP_8192	= 0x05,
+	NVME_AUTH_DHCHAP_DHGROUP_ECDH   = 0x0e,
+	NVME_AUTH_DHCHAP_DHGROUP_25519  = 0x0f,
 };
 
 union nvmf_auth_protocol {
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
