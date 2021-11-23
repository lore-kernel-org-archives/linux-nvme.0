Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AFEC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 12:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yQPKCbzaAg6zMuSNpgHZa4Q0dK8gulF3LOq3pSB3gCg=; b=lAuRiWMi+a3rPHxcOlQUzRjMfl
	o9S/eLZKk1iEvbt0CwvX1T2OelB019oeVzaKNaWGqnVAnOYxq7nyXDetNuYLYFyz6TBZKrYklOYAc
	Y0Rgrp6bx9BJMvOdy2qraqDg+os8hTEUinxJ7kynkG0D3y2enG1RkrYtJ5xGSTwJklGUAFovcKuLP
	ttQkqJxo5Y2faLMSkfjYk/YzvqPOOz+makum779njcOPozCsDJt9jMyOwpIRB3a3DMK5cuehV6Sm/
	PzoEyF7Z8yAyiGUN/cOa4SPiieC/yFm4GNMR0AjUdWGsS7HYoOupgL2MQzEr+V6anZpL/D8ir53Ky
	QEnXM+xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpV57-0029DJ-P5; Tue, 23 Nov 2021 12:39:29 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpV3w-0028s2-6z
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 12:38:19 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 3249A1FD5C;
 Tue, 23 Nov 2021 12:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637671094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQPKCbzaAg6zMuSNpgHZa4Q0dK8gulF3LOq3pSB3gCg=;
 b=upDsnRfsZgy1XD4yfcG3M+rIHCptnSzOrlWGGHTsN5C5dvPzDSaNkD6YNgQFwpyEpcfgbn
 2vZCiPQwp/1w0BpLwycj4dFEkr4gRPX+sQBsRIrlJchyFqYo7eB8kaWuo/mEDRls4gMsZe
 fJKKObFRp2j+o6JkQitqZ1PQGVHH50s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637671094;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQPKCbzaAg6zMuSNpgHZa4Q0dK8gulF3LOq3pSB3gCg=;
 b=BSoZdIUom1vRwm+9svoetWJU33DxJNwlrydibxx+aUkW4mYVIzYcvtg/Prtn/tERUDT5V6
 AeusPrQUJrSh6WBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id CBA97A3B85;
 Tue, 23 Nov 2021 12:38:12 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 946C251918BC; Tue, 23 Nov 2021 13:38:12 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.org>, linux-crypto@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 01/12] crypto: add crypto_has_shash()
Date: Tue, 23 Nov 2021 13:37:50 +0100
Message-Id: <20211123123801.73197-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211123123801.73197-1-hare@suse.de>
References: <20211123123801.73197-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_043816_582612_616970BF 
X-CRM114-Status: GOOD (  11.12  )
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

Add helper function to determine if a given synchronous hash is supported.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 crypto/shash.c        | 6 ++++++
 include/crypto/hash.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/crypto/shash.c b/crypto/shash.c
index 0a0a50cb694f..4c88e63b3350 100644
--- a/crypto/shash.c
+++ b/crypto/shash.c
@@ -521,6 +521,12 @@ struct crypto_shash *crypto_alloc_shash(const char *alg_name, u32 type,
 }
 EXPORT_SYMBOL_GPL(crypto_alloc_shash);
 
+int crypto_has_shash(const char *alg_name, u32 type, u32 mask)
+{
+	return crypto_type_has_alg(alg_name, &crypto_shash_type, type, mask);
+}
+EXPORT_SYMBOL_GPL(crypto_has_shash);
+
 static int shash_prepare_alg(struct shash_alg *alg)
 {
 	struct crypto_alg *base = &alg->base;
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index f140e4643949..f5841992dc9b 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -718,6 +718,8 @@ static inline void ahash_request_set_crypt(struct ahash_request *req,
 struct crypto_shash *crypto_alloc_shash(const char *alg_name, u32 type,
 					u32 mask);
 
+int crypto_has_shash(const char *alg_name, u32 type, u32 mask);
+
 static inline struct crypto_tfm *crypto_shash_tfm(struct crypto_shash *tfm)
 {
 	return &tfm->base;
-- 
2.29.2


