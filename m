Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0F560A6F77
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WXXtl7R0;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q0hE97HC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=UjCTRKy+7U4JN1Jcu/EJZJuoaK4wFbRJ3ehthWXUHa4=; b=WXXtl7R0z9k2rcGoH3ZaR0ZW+c
	3LRHAzqGjF8Ywoo9ip+Y5LL0qt5pBgfakR2IDk/HW63P875wDWbS6iqfKwllWJFc4mg70gqgTosYf
	ChfdbUSiWxCqh04DFfONxYJ82eW1w2b1VQJCrN23ZEobojUbhEg4ispsWGElEJqzblzQXHaIjlfTc
	ZrX3WEYRmXB/uz4heUZ/K52Jlrzlvq6TqkDAOnFClMo9htNsBijyvLuWv6NwJDNMnATT013u/TcJB
	oLBd7t7a5CJtQrDlABa6kLu75jAybc9zSSe0Yy8W5ARgbYs6WIdR7TLn4HKnOWdrDR7ELlong3Zlu
	pdLVIvEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQifb-00000003Nfq-0kQb;
	Tue, 10 Nov 2026 10:01:39 +0000
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQifY-00000003NfD-1WpU
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 10:01:37 +0000
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-372bdb942dbso2454050eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2026 02:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794304895; x=1794909695; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UjCTRKy+7U4JN1Jcu/EJZJuoaK4wFbRJ3ehthWXUHa4=;
        b=Q0hE97HC9yc7AdnpslaJy7Ifx1MhDI5RH9ogM+u4d30qXBAbn4bMbxF7GJ4YmEwfdb
         EpUPiOWextlR8y8KMD6AnSLJNha1Sc6hLBtURClJJIhC6yTy+2IAHYc6sypSI15knmVc
         UaLXOh1emR/biHTIrdBVlC/VYHUKJiCBfCmusN/jPS1tD7OOqj4DNAAkhME6ttEq2hIm
         IsDLM3rqLUxWQ6PJVubaV7DiQEfzlybFpV7TMFZlaa9L/IvXZd57ARrBnQ7AWLQmtFOc
         goFV5ttEvnO6irrCRsrCfAhu+8bPf3pVVDPwP1u0v8OnLNJascEMriMSFzS9QYjHFTYg
         Qu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794304895; x=1794909695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UjCTRKy+7U4JN1Jcu/EJZJuoaK4wFbRJ3ehthWXUHa4=;
        b=k7a/Nw8UKvVC0+LZvVxKucaRNgCjxBnuQd6NeByVSvbOsyHqly0W/aK7na+/Sk4NtN
         PYHnycU2MeL53D/EDN/pdwJ3pHXdl7lIC37wKpBof0WLAq9DES5Ep8sfOjJ5gCzyeLcd
         UJlsa80mw3eUCmQMzrGMMrNupVVG+8ibz6eWHHhIhb82Hv02YHC+GO4YU277C0/smFfR
         ddvBzKTdC8njt9789i3Tfrz/Uc0rW+81+5FOa5CiFnvIqFspMuW0QNY8+qu4fhi1KoIr
         uuwhm8bVCtrYLAcE25R2MWD5xxFiE1ftsXkV+BpntrzlvBjSAu7zymeve60oXNCN5r5n
         DceQ==
X-Forwarded-Encrypted: i=1; AL+hErEDgH6rgUoZeyMkm+57ybYhacmlO4Ai6GRLXJ7qKP3H3o6aC5vn2H6tEVQbi93nqqO8gzK1YJMt1i8L@lists.infradead.org
X-Gm-Message-State: APuU4Z9ab2ILo8fTOTVtfdPEfYecCNZble6DODxwGfFpwatC8rbWsfSa
	NG8KfILh7cd3I2J7aLnWH3rmbxA9ZgHKB13qVbppFOLegxmSdiwY3+AQ
X-Gm-Gg: AYBFou0j4An4LLLAsV1hkVpxuOCQtSH3OGIFCuCyxotZGWin3nwr4rlkVCZ5qxQvTJH
	2arlJiAN+7q2PstdSBeC0opsiBOG67Kp6BxOqSkXaIWUQ/Mstw8ktcRyPesR7DwNXsiJNBphfj8
	aJGAdxIk7YaqUxi1xEKq2mWIFGx8gzF9C88/FaT6oqlP9pCEJ9TsS7XTQDzzelidzNSyGNKZh3x
	JCR+8BieKR8q35ZQzOeMnb4wR/3ZnOqAcjEfjM5tWB8olGpFwAjEQqnjlJ7tpA8X9mvZ+yi5ASs
	qHDHojzQ9duUgKWf5ptt3bMLzDz9vaCgbh0WzBMLcsi4xEH7Nm79EgCXk0hnLbZITP6ldXQAT2C
	TT7/NECI9LIN+YVauySwMXM70H2fybUPETPuWJ0Worc7sWxy8zPhtGUslxqQXfZqPBtQ5JbsCE7
	HDt7apC1EBf2O6TNoeyrDHhrc3rpWF+ZzsA6N+L1GkovgptrD/q3p6wEvLt30kWVxPOOI/7bKFV
	m7BqgmNjpJeoOiZSaPFI1DG5x3DY9cCxp7tGD5qj7yT1aTWe1D2ZtxSJQli3npOrT97nnFCq3dW
	O2UK3VFDdhHW1tiN7eRK6zjsr6eHsg6Zkew0A4mnOHH/HGv8aprVww==
X-Received: by 2002:a05:7301:420c:b0:375:35b4:1dc8 with SMTP id 5a478bee46e88-37535b423cemr2135969eec.32.1794304895316;
        Tue, 10 Nov 2026 02:01:35 -0800 (PST)
Received: from localhost.localdomain ([103.179.231.100])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306e3sm6237197eec.7.2026.11.10.02.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:01:34 -0800 (PST)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: hare@kernel.org,
	hare@suse.de,
	hch@lst.de,
	kbusch@kernel.org,
	kch@nvidia.com,
	sagi@grimberg.me
Cc: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v3] nvmet: clean up DH group state on initialization failure
Date: Tue, 10 Nov 2026 10:00:58 +0000
Message-ID: <20261110100058.4652-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_020136_427147_5DA3305D 
X-CRM114-Status: GOOD (  13.68  )
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvmet_setup_dhgroup() leaves the DH transform and group ID
initialized when private-key generation, public-key allocation,
or public-key generation fails.

A subsequent invocation with the same DH group incorrectly
returns success because the existing transform and group ID
are treated as proof of successful initialization.

Release the transform and reset the group state on initialization
failures so that subsequent attempts can properly retry setup.

Fixes: 7a277c37d352 ("nvmet-auth: Diffie-Hellman key exchange support")
Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
v3:
 - Clear stale DH key state when crypto_alloc_kpp() fails during
   re-authentication.
 - Fix the error path when crypto_alloc_kpp() fails by returning
   the allocation error instead of incorrectly reporting success.
v2:
 - Consolidate error handling in "nvmet_setup_dhgroup()" using
   a shared cleanup label to avoid duplicated teardown code.
 - Add Fixes trailer.

 drivers/nvme/target/auth.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index ccba84b1344e..33f2584973ec 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -97,6 +97,10 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 		ret = PTR_ERR(ctrl->dh_tfm);
 		ctrl->dh_tfm = NULL;
 		ctrl->dh_gid = 0;
+		kfree_sensitive(ctrl->dh_key);
+		ctrl->dh_key = NULL;
+		ctrl->dh_keysize = 0;
+		return ret;
 	} else {
 		ctrl->dh_gid = dhgroup_id;
 		pr_debug("%s: ctrl %d setup DH group %d\n",
@@ -105,9 +109,7 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 		if (ret < 0) {
 			pr_debug("%s: ctrl %d failed to generate private key, err %d\n",
 				 __func__, ctrl->cntlid, ret);
-			kfree_sensitive(ctrl->dh_key);
-			ctrl->dh_key = NULL;
-			return ret;
+			goto err;
 		}
 		ctrl->dh_keysize = crypto_kpp_maxsize(ctrl->dh_tfm);
 		kfree_sensitive(ctrl->dh_key);
@@ -115,18 +117,26 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 		if (!ctrl->dh_key) {
 			pr_warn("ctrl %d failed to allocate public key\n",
 				ctrl->cntlid);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto err;
 		}
 		ret = nvme_auth_gen_pubkey(ctrl->dh_tfm, ctrl->dh_key,
 					   ctrl->dh_keysize);
 		if (ret < 0) {
 			pr_warn("ctrl %d failed to generate public key\n",
 				ctrl->cntlid);
-			kfree(ctrl->dh_key);
-			ctrl->dh_key = NULL;
+			goto err;
 		}
 	}
 
+	return 0;
+err:
+	kfree_sensitive(ctrl->dh_key);
+	ctrl->dh_key = NULL;
+	crypto_free_kpp(ctrl->dh_tfm);
+	ctrl->dh_tfm = NULL;
+	ctrl->dh_gid = 0;
+	ctrl->dh_keysize = 0;
 	return ret;
 }
 
-- 
2.55.0


