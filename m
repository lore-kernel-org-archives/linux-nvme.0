Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B4C60774E6
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=h3XBbP3X;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cils9x2o
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=YLlZuK32JaWyLywcZsk5CvR69cakJjXk6LbjdCED9YE=; b=h3XBbP3XFOp4Isi6Vs93Y78RQD
	ZeK8ikTczjJWpBU5bK7ZZoVyNzf+qIYBJlDDoNs32jZYCJ0iMdiCULdg3OLo+fDsdFeUPkaa0BKSf
	Jlxm4VnMXIODBYIy+f1HvK+sZsbqZMp9JAYQPf5evugZhFrtl+NNvY8RZ8RcoEt/YedrGOF/fCmI0
	2krqmHe1jp1vFWKT5z7TEwN7cYiR5YnKb1NMEHg9mwLuniyYC5HztPJuaSwvuzG4Wd9KjFpDmMXYc
	g+d1SHe/AHivrHsIuNrHSOyz/MqDcbl3rfSmnbTNhXeQhYlCAxrfpVNOeciHcIs/mWT27V4ULdxMH
	D/INlbhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQiCQ-00000003HCq-3h1a;
	Tue, 10 Nov 2026 09:31:30 +0000
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQiCO-00000003HAt-0gU6
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:31:29 +0000
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-3704d30b84fso2239883eec.1
        for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2026 01:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794303087; x=1794907887; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YLlZuK32JaWyLywcZsk5CvR69cakJjXk6LbjdCED9YE=;
        b=cils9x2oRVETsb2owP67YbjF4RFsFuM7K+nLxwGUqtD0vBSU/f2Th+tWXUMhWXfDHU
         K4bL2qWTcuVCJbIm7B+oWGyhQHejVN5ZkL7NNHKtSJp/l4iXbhKuQ3AcaSWihaFPp7pt
         6WwilkNnUz7jb+PchMLAKrMeAWVkwKHVS6LNk55WklbPPnSbKjencrYwSgk031eXcQiP
         MBY/0RjiomHK4sONQuZn9LbEJ5Rswi5WIaGbvcnGO5lkojfPyBhKWKnMskWXCUEiaF9V
         tAsZOnG6M9q5Z67c1abBrZen+Npr+YTB7PxZeViAYBQ0KPmFRu0ENBucoyv9SZ/MsOOs
         iYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794303087; x=1794907887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YLlZuK32JaWyLywcZsk5CvR69cakJjXk6LbjdCED9YE=;
        b=g9Yb53RQWQgaPaIRGk+n6CdCnZm/ea/jltj9mvjadZnBpKjXOa8O58QVrMRnKr8E6h
         /RxY6j5W8MTWjOGZx8s1g5UIeTKm/X/mmKgipr+T2Xb7j/z0PAfGp4HseMUkQKIJ93Ku
         tjJuEQbVefRk2wAbxDcH5Nk9iSlNMZXs3nT59lwu8o9h1K0fgltPNcLP8/qF6tn1hj9o
         iOZYfbsuwGFr63LuH62czjpRD09pJ6opZRD4l3rrsEt9y17zMZRpDJwJA5VFBRohByYv
         yRXzgx5yEkxPFbNw+nalEnbSiMBP/DPsP9OezghwPKM0VOmXHdshYlY3Tf1vbqz/xvVL
         99YA==
X-Forwarded-Encrypted: i=1; AL+hErFUut/K9zUZ9BYPVNvx+iyedheIavCeDYbruYQwpHHD/9Vf9+FCZ13ya2HMQJiC64dJZW3SwmjuDQ+T@lists.infradead.org
X-Gm-Message-State: APuU4Z/W6z1DtWo57ABhq2Nd1hkY/mAuSAvOYGNrf5oA0ASpby4F+gWo
	PID45wRxUfns59AT4dXIEgEfDa7mTz7cLaUj6qKVxRV5tv19Uo90cIPej+gZWjZ5
X-Gm-Gg: AYBFou2mOhk0xZV1DpnmdQMvWvQql60By2TzArsylY5E6HoDwiSk4hAdqzZPe7YoeFp
	kjXsE399tNWilUmeYUa2zH8+4DI4meTasrGEvyP2DZe2Fys+iJLAotYsXq/nQnf3nZn9RaMmdbe
	ZV5Ny/UJJ+OObEnoXdgC699MXY06oKOU8Bc1sqeKTO3YgYyE2LGw++HeY/ATR9gThvw/UdT8F4L
	ALbS14JQU2s0qjZb6dFwRUfUUKjTyTsVnvLsnugxrpNE/lKmkE5iecW/AQ3NAvWKz1sO10/x1yx
	c3T+vr6ibsL55oBOcfTSFZy+jnkpGpd1DKlmPn2+QPwBd2HN5+kAVIan7huQVHNKwWMUsrVqqQk
	johgNO6doMWJdTjRGMQwKcG4MeIEA8A0xNZBZWhBi50HlWLXa1jGGEGSbY3cTxq6Uhtj7XgKAgC
	k6bTo4nPqamKIBWMTo+rNGtvjhstdjM2T9BpwDhlDx5p1Z02ehW+CXQEnsTFWGB9l404YkiDxe6
	jmR29CUKgLdQwltnNTcoy5Mi3+RbpZ0jXCJG1B9q05gGYK0N3KNWuWU/RFC8QFwTynNel4epX2w
	zBIIHVDhigqwlBuGIlBy/4amH4VGiPlQgG3GjqJQfP4MbYPJAHMV
X-Received: by 2002:a05:7301:488e:b0:371:7ecc:b82a with SMTP id 5a478bee46e88-3751f659215mr2769649eec.21.1794303087065;
        Tue, 10 Nov 2026 01:31:27 -0800 (PST)
Received: from localhost.localdomain ([103.179.231.100])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060dc0csm6610193eec.14.2026.11.10.01.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:31:26 -0800 (PST)
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
Subject: [PATCH v2] nvmet: clean up DH group state on initialization failure
Date: Tue, 10 Nov 2026 09:30:47 +0000
Message-ID: <20261110093047.4290-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_013128_225509_3B620BBC 
X-CRM114-Status: GOOD (  12.49  )
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
v2:
 - Consolidate error handling in "nvmet_setup_dhgroup()" using 
   a shared cleanup label to avoid duplicated teardown code.
 - Add Fixes trailer.

 drivers/nvme/target/auth.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index ccba84b1344e..20f8c84e8ced 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -105,9 +105,7 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
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
@@ -115,18 +113,26 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
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


