Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CC1606A319
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 06:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ieo7d7J0;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=g5Oh+J/f;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U8fWHJYT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LTcIwHCkV7H2yPlaX3buDu6FTvh743aqgH51nE4exbo=; b=Ieo7d7J0x3mvq/wClVT6y7UZFk
	kxgKt1BOb4PgbNL3nBJZAmRq4+3dlh4vTip31IRDUYS9Cr1ep1zB6tBok+NZISNhrRzpjIB0WG5ts
	FSQLMBFcnhCB/1NgdiToUFxYc4IbwrtbSCCKERXvDquPmZ4Bzvzg3egk0BfXgU4PWNhdFhq+mIET1
	+0cEjXlF2YmufmxpyJmaSIiYIaHFRE1bWNq9citshPAJS95AKAgg7lscd62CFRx5H4Mt2hgIN0sZO
	k64ZBO7bvHTHnOUt/OD5T7+v8VeH3B7gwEbLnXV3wVwLZYwAALsqdYxWoaiVVBcgAk7as1+tLnmba
	HxgUfkMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJmIy-0000000DTE9-3Ikj;
	Thu, 22 Oct 2026 06:29:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJmIx-0000000DTDq-29ib
	for linux-nvme@bombadil.infradead.org;
	Thu, 22 Oct 2026 06:29:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=LTcIwHCkV7H2yPlaX3buDu6FTvh743aqgH51nE4exbo=; b=g5Oh+J/fZjleeNc3grPECqhlLv
	wlis8AVJKuycuP8RGg2dK9nDbX3F2IaPhtkI0Hl9DTHlQ7nOtw4sVuCbfiq0+jZZTkKvLGn/3zsh1
	8Squ9ZEn2pkFV/+v9VxKIcNfH+ENF0VQ7ObWhXvNRA0k7F458P+KR4+3MYUjLjt+ywy8HeJKiv3Fi
	1+vKRAGEXrq8smcP/Af85faSplM0k7zKM5uC61Rxd+gi7NJbmWIjBlgGaB44qi2EM0c8CaMrq612A
	I+kKSjOvTtST6bGSrs/9nz0WwhEA7+qLWWZf78tyaK41YwdvKRBb/coeZF2xLM3UJdJ5UlSIbdadt
	TLZl05Sw==;
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xJmIs-00000006Vtz-3bpW
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 06:29:32 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso1011115e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 23:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792650568; x=1793255368; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LTcIwHCkV7H2yPlaX3buDu6FTvh743aqgH51nE4exbo=;
        b=U8fWHJYToBNiS+neJal8nYXaH4ubaXoq4S1qqhpYqHCAcCcHhfA+mtVqcFPN9ZNqV5
         OeJLb9ksu+vMu5Z2CVW68/ZSr4xVVhGFv1X6TXT2iIC549ocx1Gk9y/hpDAya/QQrrrS
         mmTIhfV4RA8Z2IR+C/xF0i/Msa4Uk4JwnpmBcUJOUOCrU0QDdR2TXw7FFjw6mu62Btj1
         fmsz/HMd+99HC1LCGUJd11AeUsTy8KqbjYUtxq7UgOqq3qOVff7ByFt2FYrFOnnAG122
         6sg2F6+heWc6m9L714iv10EcNdHnVxdXQ8F4ADrb/LBGTGMSam+48tSH1mpjhg2L3GOT
         HAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792650568; x=1793255368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LTcIwHCkV7H2yPlaX3buDu6FTvh743aqgH51nE4exbo=;
        b=1dHQfcivS0Pm72GfEoWukOuujAY5gVV2w+jQ0FydGUieUg0q8aDApYzshZM3yTEKYd
         OiTXAdg6105jzHM1FQW1rrJHzgEVESENMwtsojYbPqNuRCD8+hYD8MeM0Oayt1gQ0ZFX
         K3TPo9Mz/XR7WHh5nEbaPf7mK150i412Qkzk/Ip/1roL9tzDFi/vTHKm40btpLgWYeIU
         RhWIXts4nCY9Ih2LLTrvoVTyfLxlP8kZ5IEi1zGkvuX2nhvjs3Lur69kzGr7uAKP6eve
         WtVaXrkdLSKHtE3F4PZbwqfiUBCYGi/L3odGAFqpf8W7rSya2uN4TD4n49l/AqLJYVJ2
         H53g==
X-Forwarded-Encrypted: i=1; AKwUvBzkSUjFhvbkIbpoY9F9661UmVOC+OmH1p70qyv1MJyMSDfh4u+eQpk9S1e9A4MDKCuCQinj5BiqG3lt@lists.infradead.org
X-Gm-Message-State: AFq9FYKroBPxW1ymLZ5Nblyaojq147Y974+9Wn3ZR2zTsuyN2KbOy7n1
	FZc3pL7XomzdWO4W8dXGQzK+drsKADFmLR7Tfcw+oWv/fwP4jaFzyanX
X-Gm-Gg: AYBFou0T5sTVhjuA5hlvAU/4B7n6zHWwQ3j7IlOPgmEkaJ5aoLcfJluAlz2g4qnFy90
	cH3zI3p160DLzlZwFfGq3+T84MCxPpUfdjXslLsTj3zKah0JvdUaaKmgBL/VBkEWeJVtBPYG39x
	Z/pHooD2DBoM8z4RhOPwNosPzxz5O/YNDzAlahmIbwHBKtCDk8o3gcBKuLyKKIIX0CoHQxgWLcT
	wcoshf8zlfSHvJWPxrRRVB9Y8/QFBfvKLMkQHczna/hqe12wVaYWo1//LXElPpljZL9PMarZImE
	qgEnBlmrMqSOe1ee/U8SXbk60cuvcBNkbZImdG3nU+itSnzHrv8kUfzkScfjtX+YfTu1W61n3uB
	Jw41B0KSbUlSRZmNcavW55awYIRrCX8fRd+LXhe7PxSggk1BrWoakGqYii4rfOceIMtMiv6EQ7V
	B8ntqA82TQb0x0BWQvXEtKAx4Bu7qH5EsAoDwZcKfGoZoi9BTsgVmHAaAW3ncvreX1uwHvmujqm
	Z7IPWfPhhQGFCxwGfCrJmKieTR1BS/dhaRebhDo4YC6EFYgZHowZ1PiGdck0YNHq319k9D9
X-Received: by 2002:a05:600d:864d:10b0:49f:e941:d6e with SMTP id 5b1f17b1804b1-4a1fdd399dbmr60022755e9.21.1792650567635;
        Wed, 21 Oct 2026 23:29:27 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4778:c500:2fac:694b:933a:abb0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc0b42bdsm96216345e9.0.2026.10.21.23.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 23:29:27 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] nvmet: prevent double-free after metadata SGL allocation failure
Date: Thu, 22 Oct 2026 09:29:23 +0300
Message-ID: <20261022062923.3761399-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_072931_221360_967F3314 
X-CRM114-Status: GOOD (  11.91  )
X-Spam-Score: 2.0 (++)
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If metadata SGL allocation fails, nvmet_req_alloc_sgls() frees
req->sg without clearing it. The RDMA error completion path later
frees the same scatterlist again.

Use nvmet_req_free_sgls() instead so that the scatterlist pointers
and counts are cleared before response cleanup.

Fixes: c6e3f13398123 ("nvmet: add metadata support for block devices")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 07a74c2e1f58..8032924e657f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1359,7 +1359,7 @@ int nvmet_req_alloc_sgls(struct nvmet_req *req)
 
 	return 0;
 out_free:
-	sgl_free(req->sg);
+	nvmet_req_free_sgls(req);
 out:
 	return -ENOMEM;
 }

base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
-- 
2.43.0


