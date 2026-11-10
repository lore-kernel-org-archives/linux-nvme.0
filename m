Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC6E606A31C
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tZ8W52QP;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=heD6Kwqe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=eb4IbN5BS1fARhwXlM0e58qZU7d7q3WTMx1lm2ye1vM=; b=tZ8W52QPuQocgbauxDyRe2WT7B
	WXk9xLeV/nybg3MY3VKe1l2UjcWpOxvZYx61yi3OZPUZffXFWo0u3gUIzI9sC4Hs6BO2Q/SUglh8J
	f9ZY/Ngq7uwdzBNEJhoIaSd3f7kAku2rjPex8Ldwjr4ftK4XjnfHBTxiw7CR0nkR2zLR4awmWMS3d
	K0bfGxefKC21zThqh5OKr1JYttQ8ib67xaGlCuWQkxGCehu3M6PBXsWz1mWfE/EpDpSdhf1lem+qD
	jXhVtzDc8VDOJg5+hsCQa40ZHjrAaKb5ha6ZOoZvjUpgIScQPiSXtfZaEAr51RqP0GK3xVl4t/jHe
	/laUENfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQk8a-00000003eX3-2zmf;
	Tue, 10 Nov 2026 11:35:40 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQk8Z-00000003eVE-091D
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 11:35:40 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3506000eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2026 03:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794310538; x=1794915338; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eb4IbN5BS1fARhwXlM0e58qZU7d7q3WTMx1lm2ye1vM=;
        b=heD6KwqeEE9/fh4c04qigOlbVIFauTDsaHiS0NXoOg24Zrs3OTJOR43hk5DnjmUh6M
         GocCyr7e5JJ4mGE2XfWt2/iNqrxwJI+UIacEkgSWyFKed69mcfBdpn2IZr0DNBZxS2nk
         /gZljhRVQA22sHp0s6QwvWvXb0okmIr0v/s6/2uCBeQP5Y9dCrx4d8UNnWLOR6Cq12bY
         KizotZ2PIJaofSyePD4iRzTT9U0HRQfIH2WAY10luAFUaCUkR/x/kfDtS8Rc6G4I/phE
         cBTWQTugVbpb/qo6YJ/q8l7X6aakwGhbgzquWYu19Jz/xij6mCWE7g2pPIBZt3GicVzG
         1Gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794310538; x=1794915338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eb4IbN5BS1fARhwXlM0e58qZU7d7q3WTMx1lm2ye1vM=;
        b=iT9DqaOUh+LL2VZxr1ziVktonyaQ4iuFTcGkoGwOktFM4no9lBWJXrQ8h3qQOHrCU0
         fsg/EEDS7FBbCFCdvpW4wE8ZdnoCQWkf2ZMcBOaiBOF144YXstQ4SYx9jU2CNc3dsXgJ
         PRHQuu4xZisR+FgQlze1hySZLj8GgBfpGh62MIbd/wUVot/1EgaZbmTyWY/QTIeu8Lsw
         /5QPx7o6d+24jK6HcocXUVyZsjDowxpIHqwDV7X6iZ2NQw09iQU/IB00Qq0V5/kdtScX
         ZxFa197G+Gr1YHSmAZkMNxkVhVaZxz3NuRAUjyH3SmwBnU4D6Eh0nf92p45S2zMpDb6T
         9SAw==
X-Forwarded-Encrypted: i=1; AL+hErEMOm3U9dFZiMz2wWG7uoe2ZnLXXDTMLZVVl4halake1xv+ONNFa5Muii+SWIV8tJ/5QrDc5lA9pL+6@lists.infradead.org
X-Gm-Message-State: APuU4Z96I249c7tCAL2CYYdK0s0ElhMkZxl9nttmyg52uFSBS0nbeUlv
	+5axsDQITEkJRvphQ1HmyomztQVYqij9SKRR2g4C1ioSsB1cwIRc/uKUGlSNjLuB
X-Gm-Gg: AYBFou1eK/YnIJsbUDyKtIf8t/dEsV1dW1gonoyw5eTeDZAXFlmwAYFKRoQeq3RKcjo
	md3rsb8JTTDzGIpue10HxEHm4BhUAOcbsBocHxqjF6lMjIVcMC7THK1u7oSYeJ4TblYTgpP8SFw
	gdBmUgsvfWS8HYlrVTpqfbk/xsnTWeu5yqHikkUFsfxB5yM5SJI1gLANyQdQ5SiQNOHk+sDaj72
	R/7qADjdaYjLuW5YycnDVjVAdtZ0FAmxN1eHCvojRd6QwFpfZYOEmvcO/Z0kDP320abQpdOVDbK
	J4V1Wd91GPrALcBZQSQJiB80xtFiwGkvqklO5gLicBoJYOQMQmfVsSiOjZC7KOM6mPo8VRIJc6g
	fVNFK6vxZiDMDoVg23ZE+Nbjww9HRXuCUb/eoZmky26CrqdCK2OUTO9QzGD6vVbwOEleBo2qtSf
	j83r0nr0iBG96AB7BvyoWRTjTT1/JChDWugHL0u1AUbEvXs8SLMi/iogkPV16SgwwzR6IpMjZeN
	zuEf999yXpt8TWyJdezucuOAGfGD/PbRywV8vaWSreuZ2OhmjAr6TpwFfa4NYT0bR32+JxqiS0K
	L7MCijs03IMWgx/Wzg/lCh93kwNBoqzGsl98M6gTGBEvwjuNtAB8o/V61I669M89f4oEFdyqkk0
	=
X-Received: by 2002:a05:7301:d184:b0:36d:a465:b38e with SMTP id 5a478bee46e88-3751c53689emr3136955eec.5.1794310537844;
        Tue, 10 Nov 2026 03:35:37 -0800 (PST)
Received: from localhost.localdomain ([103.179.231.100])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060dc0csm7675796eec.14.2026.11.10.03.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:35:37 -0800 (PST)
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
Subject: [PATCH v4] nvmet: clean up DH group state on initialization failure
Date: Tue, 10 Nov 2026 11:35:02 +0000
Message-ID: <20261110113502.3235-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_033539_079653_2130A423 
X-CRM114-Status: GOOD (  15.18  )
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
v4:
 - Consolidate DH group error handling and clear stale key state
   when switching DH groups.
v3:
 - Clear stale DH key state when crypto_alloc_kpp() fails during
   re-authentication.
 - Fix the error path when crypto_alloc_kpp() fails by returning
   the allocation error instead of incorrectly reporting success.
v2:
 - Consolidate error handling in "nvmet_setup_dhgroup()" using
   a shared cleanup label to avoid duplicated teardown code.
 - Add Fixes trailer.

 drivers/nvme/target/auth.c | 67 +++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index ccba84b1344e..681459b5db3b 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -76,8 +76,11 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 			return 0;
 		}
 		crypto_free_kpp(ctrl->dh_tfm);
+		kfree_sensitive(ctrl->dh_key);
 		ctrl->dh_tfm = NULL;
 		ctrl->dh_gid = 0;
+		ctrl->dh_key = NULL;
+		ctrl->dh_keysize = 0;
 	}
 
 	if (dhgroup_id == NVME_AUTH_DHGROUP_NULL)
@@ -95,38 +98,42 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 			 __func__, ctrl->cntlid, dhgroup_id,
 			 PTR_ERR(ctrl->dh_tfm));
 		ret = PTR_ERR(ctrl->dh_tfm);
-		ctrl->dh_tfm = NULL;
-		ctrl->dh_gid = 0;
-	} else {
-		ctrl->dh_gid = dhgroup_id;
-		pr_debug("%s: ctrl %d setup DH group %d\n",
-			 __func__, ctrl->cntlid, ctrl->dh_gid);
-		ret = nvme_auth_gen_privkey(ctrl->dh_tfm, ctrl->dh_gid);
-		if (ret < 0) {
-			pr_debug("%s: ctrl %d failed to generate private key, err %d\n",
-				 __func__, ctrl->cntlid, ret);
-			kfree_sensitive(ctrl->dh_key);
-			ctrl->dh_key = NULL;
-			return ret;
-		}
-		ctrl->dh_keysize = crypto_kpp_maxsize(ctrl->dh_tfm);
-		kfree_sensitive(ctrl->dh_key);
-		ctrl->dh_key = kzalloc(ctrl->dh_keysize, GFP_KERNEL);
-		if (!ctrl->dh_key) {
-			pr_warn("ctrl %d failed to allocate public key\n",
-				ctrl->cntlid);
-			return -ENOMEM;
-		}
-		ret = nvme_auth_gen_pubkey(ctrl->dh_tfm, ctrl->dh_key,
-					   ctrl->dh_keysize);
-		if (ret < 0) {
-			pr_warn("ctrl %d failed to generate public key\n",
-				ctrl->cntlid);
-			kfree(ctrl->dh_key);
-			ctrl->dh_key = NULL;
-		}
+		goto err;
+	}
+
+	ctrl->dh_gid = dhgroup_id;
+	pr_debug("%s: ctrl %d setup DH group %d\n",
+		 __func__, ctrl->cntlid, ctrl->dh_gid);
+	ret = nvme_auth_gen_privkey(ctrl->dh_tfm, ctrl->dh_gid);
+	if (ret < 0) {
+		pr_debug("%s: ctrl %d failed to generate private key, err %d\n",
+			 __func__, ctrl->cntlid, ret);
+		goto err;
+	}
+	ctrl->dh_keysize = crypto_kpp_maxsize(ctrl->dh_tfm);
+	ctrl->dh_key = kzalloc(ctrl->dh_keysize, GFP_KERNEL);
+	if (!ctrl->dh_key) {
+		pr_warn("ctrl %d failed to allocate public key\n",
+			ctrl->cntlid);
+		ret = -ENOMEM;
+		goto err;
+	}
+	ret = nvme_auth_gen_pubkey(ctrl->dh_tfm, ctrl->dh_key,
+				   ctrl->dh_keysize);
+	if (ret < 0) {
+		pr_warn("ctrl %d failed to generate public key\n",
+			ctrl->cntlid);
+		goto err;
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


