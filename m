Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C10606A321
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=B6E4W6rr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uEIPELbo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=b59TztVWp3GhBgQqkWL6K94kfiqvh6QYhx7OQRm8o3k=; b=B6E4W6rr4JuKspefqxQUJbbga+
	DVLdtORdtU1qyzMdiASOiLDTexamsKhxg5bLm/X9NMicE+B/zJE5CngFWoOBreMqPllan6A0DVdrX
	ztymVjzNVsAjQ1XXY6yg6FT7pbYtbdCJFhvqY1TIXkEoNBGNBvXI1QFc7HTlsDJB6yUF2jqOuA6nO
	6t/Cr8GyC4Rocs2VmC7S5bhu0Agn/1KckJg4cv+ykxysri+TRljTzc3j2tHF8kuTqXRePYnqvhepq
	52bt/UAxhUb4y0RSZEEuNK3HvLg+E9FrCKngX8TZPr6TI+VHdIhXcEsyHAaUW+dbBXht+7wLmIgDc
	y1wJ8GIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQgk2-000000032DX-091H;
	Tue, 10 Nov 2026 07:58:06 +0000
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQgk0-000000032D0-0MVL
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 07:58:05 +0000
Received: by mail-dl1-x1234.google.com with SMTP id a92af1059eb24-1a2af4c8d00so346041c88.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2026 23:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794297483; x=1794902283; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b59TztVWp3GhBgQqkWL6K94kfiqvh6QYhx7OQRm8o3k=;
        b=uEIPELbooUPb0Q+gcC1wRS4JWKHWtYhU5zKkVoa2GP5JJjyAEZohY49HGQdToSzs23
         lSoP7C/A0/o8Ub+NTifP4lvjC4BsF4kzJvSGTOiuchoZawFXweeRJfzgvOpI/vdgM/MX
         O9Bq5yNpJ0enPLxBTvYLiUJ2hORW8aeUbRRjCVrVWtXGxbpfyuCJ3twn9L0Ts/lFn9fN
         Jx/GnZagVhlU9UVR72LbLFH8V2oeuov9qNuyXt3ZDZp5FrFoS0db0MajVHtRKN/heoFN
         BCSqZLcGgRNQ6m5fgyE/XG5g7iB0hmhOqk8kYSY/LLvY9t2gPTzSJDbaDN9AhDcazNTb
         McWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794297483; x=1794902283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b59TztVWp3GhBgQqkWL6K94kfiqvh6QYhx7OQRm8o3k=;
        b=Z/VXGin4nVJo4I8rnimVwbDyKG7Bvf3pq1BY8APVf0Fv+KHCCqKdhsHT7Q636B/HKH
         kRErau98mjFXXJHRkPusUCA460Vn2ETQDVVT45IaBJUuFUUZItsXvunE9QtEevmwWpUe
         u0rFkAdGVSfP0mgzC3Qo5Fn3538XaY6lGk8VlPkQjgNE+yCYqoW4LI+nWK3elKRBa2Sr
         ZlZk+gHK1VKRC9AIDOg/56tu4OdP9tgUiyTMEnaFcK9kt+kgrJv0vQoRGlQ2t0Ieupu0
         v9NMLGLCgtNRdlAh5WgK2afcIbxp5AuzcYVuEuI0vjHV5yn97hN3BWCXgi6xrXm6p6JL
         T1Ag==
X-Forwarded-Encrypted: i=1; AL+hErH02C86ZaMkQSax8XDByD3mWxaZFAMHN0evTEzJKxitwwXFXb+Hw+tMFk9C6PWJl2/EdvQUiYFA7Ru5@lists.infradead.org
X-Gm-Message-State: APuU4Z+JHZWjCuCItyfJWSYHyW1WsmfgVqx2sh5ddBFlqPcaZs7xjgcr
	GoR8d6ZwnCwYQG3RkhuWj1ocnnI1sMkjxHWuGmiEPUwjgP5iSQ7sICC/
X-Gm-Gg: AYBFou2B+5IgD+MDzN5Vn4fQUmpah82zjadgk9R6QVAVU5L2qeMLdjTIlhbTzgsmty7
	kaSYIgkAvMq+zHEAiO2/fkQUXeY3VGGcIYrWmAlrqqoYg/NnJSkv/Z1GYOLp/MlcgGcRLNgcqc5
	bXvz/yt7XgRIv4BUN9+qVqZ9nuATUOK8fakCCpNBne5cqyg09HJ4pZU+D8BRIcbc64HFMY69Qev
	P6gilZ0uj/xbOys2GkjalErU2sOiPRCL4B2dC6EmaHstpZzTm+QycT9GMSg7FdYNFeDtwSaCWTY
	o1Z6QjFILhKQj5FFjinJGKYMe/MYtG+TjKoRHg2vUJwtz7y6ECbkLkN82UfTMQZ8R1jOuUVsPFT
	seZXofiaWC99rsrMwSuToF/yKSRWat9ycqtIzFW4/J3WlOJTNpznxZGa8i0c7dgehK+mTcmky09
	uEwoZnNt+tK2s8nD6KdcUK6N1zvE07uFD3S1QB9XI12BgP3U+JAjdPbZ0AbL9h9fjmLhzGaGq8P
	nZXVDPwmuc8WgwuQaQ//4KLXkwCwyPZXTXjA6btq50uPSxhQzKrd9PB0Bgf2PtTjJ5swwv7silR
	Pko4AETLIrhVkz+0X450z9hXHHGxq03uQjVpDXMcCjMDdjdN1AUZ
X-Received: by 2002:a05:7022:3c08:b0:195:49ee:94c7 with SMTP id a92af1059eb24-1b3b6057602mr2424972c88.8.1794297482931;
        Mon, 09 Nov 2026 23:58:02 -0800 (PST)
Received: from localhost.localdomain ([103.179.231.66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b20c55sm4571441c88.8.2026.11.09.23.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:58:02 -0800 (PST)
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
Subject: [PATCH] nvmet: synchronize DH-CHAP secret removal
Date: Tue, 10 Nov 2026 07:57:33 +0000
Message-ID: <20261110075733.2578-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_235804_128088_82EE6E81 
X-CRM114-Status: GOOD (  10.03  )
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

The empty-secret path in nvmet_auth_set_key() modifies and frees
host authentication secrets without holding nvmet_config_sem.

nvmet_setup_auth() accesses these fields under the read lock,
allowing concurrent secret removal to cause a use-after-free.

Acquire nvmet_config_sem for writing while clearing the secrets
to synchronize with authentication setup.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/nvme/target/auth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index ccba84b1344e..8fe521690ccd 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -26,6 +26,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 	char *dhchap_secret;
 
 	if (!strlen(secret)) {
+		down_write(&nvmet_config_sem);
 		if (set_ctrl) {
 			kfree(host->dhchap_ctrl_secret);
 			host->dhchap_ctrl_secret = NULL;
@@ -35,6 +36,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 			host->dhchap_secret = NULL;
 			host->dhchap_key_hash = 0;
 		}
+		up_write(&nvmet_config_sem);
 		return 0;
 	}
 	if (sscanf(secret, "DHHC-1:%hhd:%*s", &key_hash) != 1)
-- 
2.55.0


