Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74814606A31E
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MWObqJSa;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IDsSRTeW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=ZYP5yrgTb/w5dlTNs4dFxXJq9l0xNxdDp3WQtepGxwg=; b=MWObqJSaULBfyYxGC9DSXG+Hks
	jG/ZZ4Jqs3IxYUiRIui6VrsUxH0rXjEZw/krf6g8B95+Lu5Epxu+/1PSISE/VbKeoKwxAA0ey05uv
	08kIP+fAZHQSNbYtr5XXOZ1rOovRrEYb6DESTqpj1IiI7SFTnR8t3TDUPs4QlZwbcIUnmDe0JJPCn
	v1xJo9rcfheGz3sW+MCFI7q07q/A8MSNo04hQ+Q55fGRQOgNXSiCKcb5KmNMoCFMkF53IKDZsXrlH
	dVjMglHTfgVNq4ls8VdbfZEgjLQ/aRD5t2WU6vsrBsZc7Mwn7jwOTJcSH4Wv9Mo3vrynAYyejRd85
	8B4nRe1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJrWI-0000000E3Ao-138x;
	Thu, 22 Oct 2026 12:03:42 +0000
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJrWF-0000000E3A7-3cq6
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 12:03:41 +0000
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-35ef6b49813so2320314eec.0
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 05:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792670618; x=1793275418; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZYP5yrgTb/w5dlTNs4dFxXJq9l0xNxdDp3WQtepGxwg=;
        b=IDsSRTeWcU6Zq++Bd4mTruVacBcilesHZotc+ErTZ8WMK6g66Muf1uGVQ5QcZoIgpu
         68cdg9sM+GzKoE760jy1Ks4nd8VE9BsD5BXB3GSKtR37moHZhDs8q3ft6Tnzjhf7mYvI
         vVYw5rYZqBtPdg4CuF4CjCuWh91w4as0IBU/rURl/E/bSA+M8L4ibdASj42r1cAQCTlu
         hv1KGWfKdZQcU4xMV48LeTymORahHAT2kDCBJwqRX78GszAgUd0WIUp+W8j/x4Nkz+02
         obFVfGVm/e5JMvwTNvR84AqA5fR2Grb5N0uG8XqmZygs3q2Alg14hvx01oGHgHyBmFYE
         +5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792670618; x=1793275418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZYP5yrgTb/w5dlTNs4dFxXJq9l0xNxdDp3WQtepGxwg=;
        b=WkoF10pj6OHGD74ZV376mLXjqPSTKT+axcNT3S2ZZag1uk5WfhOczWUgkRk24Pieug
         roG7WUZS/StZiSF3n/nbRpillPVk60gzG01kUkY2XRuQfkY5Qwq18ZwK3UlGfqekAmWz
         zzPZ61LYG7rgOYSk6KVZZuusUeJ72zYI6oo43A6xkhgw2890ntLi3g3QWDI5XYeF79gq
         v8jevzRcD88459VjKxQfCHnh4X7aWigrvdSa8CHBmHuwpgGpX7RQ0SKyVJ632/yEvdCE
         Bl/31upBMkxV6dx2QZZs7yHG1KBSG3d3aUJuYCEgGPzuw5/KI8hqFKsJjPrRLSwIdzU1
         wRwQ==
X-Gm-Message-State: AFq9FYLArFYmPBAc0atUZUtVuHI3Pfb+PvP9f6QBEhCQZORJlY/RtrNv
	1jiZ1cq1w6vhs4XO4WtV7855GQenNZhMF4ETbHPsMi9n4Y7iGucrP2JTxMM1MPn/
X-Gm-Gg: AYBFou3U1VQ0oD4d4Mzv5tdwoqqKjuINjAzfxSROExiMghmS38odtE7fM2FiNnjke/q
	JwqdhRZNJL0b4e+eEzEZSUpb4Hx4sBKty80RUuzWFmrzaFL8lkyzHM5QeVhMlAAEEqQPmgKdtqR
	fwvYDgS+0nIUS4g97PWwPo1XN4O/HXfL3CIIoOje9VylDnpa7XAHuQtBqEo0HZamg/rtjv0mUFO
	LZeyV4svvCqGGjqAj7g0OZP54aJe7Zj/waGlx82y6BpLJ8H59oI2CaacOacCd8ii+LgMCdCJaxI
	9M8egzJp4kRp2/EJqHtd2QxohQsG9iPx2rbLmKsRZd6HcSD5aWKk8kQM4FvJhulFfuTBK934ydo
	SscTMGhqLOFT0M+a3FfWE/vJ2FbTqt5z7qEfFcJlZ0bcSqJ7CtNpFTQCpCRD3Mkchxj35a6U8Nl
	Ra4lPgLqZqMUyyBT7VWLhrItDC7EHPU1pCAdlQ/P6eYbGlvElbjlYJ1j7+T/9/vvLEQBfC39nqW
	KC8bAp+6L7ScAA4RhOzk4Nm6ENYclrNGAdnuGUyhB9iR0zKd/J6zwxcDDCMvv2uopDPLEaxeROh
	Figb
X-Received: by 2002:a05:693c:42c3:b0:360:1637:404 with SMTP id 5a478bee46e88-3674f1164a4mr6500665eec.33.1792670618221;
        Thu, 22 Oct 2026 05:03:38 -0700 (PDT)
Received: from gooner.hq.netapp.com ([136.226.242.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198e2d6sm14324971eec.22.2026.10.22.05.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:03:37 -0700 (PDT)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH] nvme-multipath: avoid size_t underflow in ANA log bounds checks
Date: Thu, 22 Oct 2026 17:33:23 +0530
Message-ID: <20261022120323.6684-1-marting@netapp.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_050339_907585_E244CDF7 
X-CRM114-Status: GOOD (  11.90  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ANA log bounds checks subtract the required size from ana_log_size
in unsigned arithmetic, which can wrap when a rogue or buggy target
reports an oversized nnsids. Compare as "ana_log_size - offset < required"
instead, so the subtraction can't underflow and bypass the check.

Signed-off-by: Martin George <marting@netapp.com>
---
 drivers/nvme/host/multipath.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 87b934b46b85..701015022199 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -878,7 +878,7 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 		u32 nr_nsids;
 		size_t nsid_buf_size;
 
-		if (WARN_ON_ONCE(offset > ctrl->ana_log_size - sizeof(*desc)))
+		if (WARN_ON_ONCE(ctrl->ana_log_size - offset < sizeof(*desc)))
 			return -EINVAL;
 
 		nr_nsids = le32_to_cpu(desc->nnsids);
@@ -894,7 +894,7 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 			return -EINVAL;
 
 		offset += sizeof(*desc);
-		if (WARN_ON_ONCE(offset > ctrl->ana_log_size - nsid_buf_size))
+		if (WARN_ON_ONCE(ctrl->ana_log_size - offset < nsid_buf_size))
 			return -EINVAL;
 
 		error = cb(ctrl, desc, data);
-- 
2.43.0


