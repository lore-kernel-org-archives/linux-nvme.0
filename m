Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCB3606A337
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Vk3M1HZy;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XIdjPt5L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=+jpP9hHBLdvkPKqqx3Eoy4sT1PswK17YP171LAP+8rw=; b=Vk3M1HZyh9ovJCCbx0uthjCY29
	GyYqfGD2+z9dO9evRXqqXnrsN+0hI8gv9uTgA+ctvNack3nO/dzMCPuljZdrMVwZDgzdWmlPvWqGP
	7hZ6gww3LEOn9uKrFeiq4C9mWbkn4th+OVJz7dwJljv+TABcVvPAEUXAQ8pwdenHtlNMWiz4/58uD
	2ECpYFtpwHOSARD00YM92TyDnzdlPbfQ+sh+Ur+iI7vKD5h50vyLKUJjwykvau9AfG8YhsFhfAaeb
	ByvsCep2VOzqH5NPNWX/AetWd7bL+MSM7puJv3OLFAptladZb+IAsCWhaw6eG07Mshcx1m9lnjNId
	FX+MFqFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQhXa-00000003Ac7-2BuA;
	Tue, 10 Nov 2026 08:49:18 +0000
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQhXY-00000003Abd-1u9B
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 08:49:17 +0000
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-36a315ed211so2049967eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2026 00:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794300556; x=1794905356; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+jpP9hHBLdvkPKqqx3Eoy4sT1PswK17YP171LAP+8rw=;
        b=XIdjPt5Lo5ZTp2Q5SpsAbsHs1JQ6K6A5yzYF4057AETD34y8QzeMcyX8Rb6XGmbtHv
         RDWAbLk/u7LjAFnjh8/sQuVaIkwBkgXouhlaUma48lxkfzLhekSKP/jFayXF5ofO8iKO
         TOxwXi02dB/2j/serTiQItKw1RNGKIjskL/rnQ3MPpdRp5NLMim/IhmwD8tOPBUDkt7E
         ncmla4EzApFB8Qwh/ofqwt7wuVsEgbV7U6x92cG/CO5wL2DaTBxXhlE0eG3SEzJ/Yske
         ytip5/6vhAOorHqZz1h/VRoHOJpRYB0yJm/4kxuLEW03CGa0v74+IJLVd09uE7ecz5pX
         YOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794300556; x=1794905356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+jpP9hHBLdvkPKqqx3Eoy4sT1PswK17YP171LAP+8rw=;
        b=bjEKR5+2forgJV+TKrQx5TyKw08eFhSh8U+XvtiSZG7GegBQMOGBJ76krtx3nTNN/A
         SxCZhFsWRPcVNvklbjoKd1FMx3HXJcu50g+H+Qw59RNcuGS6lj4hmN7tgtDVO6QWBH5k
         /PcAL4fPmngUOjVqGudGfocdKapLP/SbW1opM4DutD69MvWUN5+nR5GoMI0ACmplzWQk
         MPHaDt4yXH6eZS4SED0fHbnQALQd/qlmTi1Fj0zL85OFXBG6zton5WIiFBllMWyKGa+4
         A4pGvM3+pHi9QSeLaIsMeOywX3dxVJ2WoivR1IpSrMBVpfIVBxSoKpzX3PxDtsHoEG4g
         IQ5Q==
X-Forwarded-Encrypted: i=1; AL+hErEymVKApTkoMR/sP35nmejjrfejxJu7Zr7+VxxUkiGnpUZONJ4lyeYzl9bjTlPigIrh3PYzpLTC/1Mz@lists.infradead.org
X-Gm-Message-State: APuU4Z9I/PU2rYLUFc9W/Hd5ypM+yiThASy4CpxHyfa71/JonKiDAOhv
	N5int90dH9aZoNWj9r4uv84kFf5akLjl3M7h+Vv9vVzmE5K777y2wqD1
X-Gm-Gg: AYBFou22KiFpr9edvc5hY3qCHLu2gcnp6iZttVWMBrtKDYhZkL/jjuIjKANudyk1aCN
	bQLkJtlRg2WhfZFHuEG63yay+lLYFEzcNiid8zvqGiTFIboCMvZru2BCWU+Fobf8lCqbQ8JR4sQ
	OnnUc8sxdkaAO3cKLA/4VFZTxxAUwksnrUxlIckiXvWay8dx/M+sAcNRtYnQUzmYxDVqSxU7OYa
	Zw0WZihPjVlrF8VayX76M8ZeFwWNLaxxnfNgeIUmmZro39FoYbvfsVcCAZdwwq4YdSiWmTxCUal
	hfq7qs5lqGFjGUtow9wlg7xarZaXGyvM9PZzhECy1HHHY3wDVEvWzUdb3krU1eluFl7qJ56ZdVp
	4jv/RDEY+OK51tmYmZq2Bqu5yl/pWSDCMmxF5UaHmhTe6UgzPngpXbgNK+znFGBfqRxfhFAaiYu
	S2GfON7YOEzghTEkcUuy+rH82oqzIDLkpquVkudERgWjqjFG8qPCsAJIg7ZDxAC4iw6ELxTxJ/p
	Njqcbk5J4QYb8EFY2DFoIAp/4/xdOaSaQS4IgOstq9YY2OWFW8HsGdlpSYP4ivWEWM7j3W07Wxh
	0NlQp9Cu5NQKSf5Y2evb0S2jeSMQm1NFuq9UxOeIiq2rBNuBo9C3
X-Received: by 2002:a05:7300:e9d6:10b0:36a:647b:2d7a with SMTP id 5a478bee46e88-37503f67618mr3036430eec.0.1794300550852;
        Tue, 10 Nov 2026 00:49:10 -0800 (PST)
Received: from localhost.localdomain ([103.179.231.100])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e76e2sm5897214eec.24.2026.11.10.00.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 00:49:09 -0800 (PST)
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
Subject: [PATCH] nvmet: clean up DH group state on initialization failure
Date: Tue, 10 Nov 2026 08:48:32 +0000
Message-ID: <20261110084832.3508-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_004916_494880_D38B8556 
X-CRM114-Status: GOOD (  11.47  )
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

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/nvme/target/auth.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index ccba84b1344e..7733d50de708 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -105,6 +105,10 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 		if (ret < 0) {
 			pr_debug("%s: ctrl %d failed to generate private key, err %d\n",
 				 __func__, ctrl->cntlid, ret);
+			crypto_free_kpp(ctrl->dh_tfm);
+			ctrl->dh_tfm = NULL;
+			ctrl->dh_gid = 0;
+			ctrl->dh_keysize = 0;
 			kfree_sensitive(ctrl->dh_key);
 			ctrl->dh_key = NULL;
 			return ret;
@@ -115,6 +119,10 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 		if (!ctrl->dh_key) {
 			pr_warn("ctrl %d failed to allocate public key\n",
 				ctrl->cntlid);
+			crypto_free_kpp(ctrl->dh_tfm);
+			ctrl->dh_tfm = NULL;
+			ctrl->dh_gid = 0;
+			ctrl->dh_keysize = 0;
 			return -ENOMEM;
 		}
 		ret = nvme_auth_gen_pubkey(ctrl->dh_tfm, ctrl->dh_key,
@@ -122,8 +130,12 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 		if (ret < 0) {
 			pr_warn("ctrl %d failed to generate public key\n",
 				ctrl->cntlid);
-			kfree(ctrl->dh_key);
+			kfree_sensitive(ctrl->dh_key);
 			ctrl->dh_key = NULL;
+			crypto_free_kpp(ctrl->dh_tfm);
+			ctrl->dh_tfm = NULL;
+			ctrl->dh_gid = 0;
+			ctrl->dh_keysize = 0;
 		}
 	}
 
-- 
2.55.0


