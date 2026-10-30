Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E6A606A323
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kzYtW7Q1;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HeQMgV87
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=aCpkNDkDJOBSn8oO8i7bGdEOJKusWxmvDqSYvuM0OR0=; b=kzYtW7Q1LuzF4jWUxXP44xxW+J
	r19utG0c4AVFOafl5krua8UBBK0TiiYIIBjhPwFfyhHlCs4gmCPDuBQnWRnWQUicFtP7PUA+59cOJ
	ah+UKE7yB+egaQ/zIeypWHueBDLzm0CJNGgjzY3eQR47WWf/13rLdMBOfDun/Y5UCTCfFfH7MfaYV
	Pwu+31Dvp9VC9T17avJW8gknKHLXdGeF4q8qioE2AhFc0v850NiNdLTELIvl9WPAtMiERFcLRzqRQ
	yuMQxpG7xMcByIkwV465L5SHwemBH6eip75q/WWCZN2OjMskEG/jvAR6aTVD/Vy4LbnMiIPPK4VUV
	EYNL40PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMlKP-0000000Bclm-1y7W;
	Fri, 30 Oct 2026 12:03:25 +0000
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMlKL-0000000Bcl8-2nm1
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 12:03:23 +0000
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-1a2af4c8d00so1181156c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 30 Oct 2026 05:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361800; x=1793966600; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aCpkNDkDJOBSn8oO8i7bGdEOJKusWxmvDqSYvuM0OR0=;
        b=HeQMgV87XH42HJ+Z8R116ItQgUX0yOvQeur2PYw4FUcfbHq5zDamIu6st+93884s8U
         N+zE117BtI+t/sb4JEIqCadSo+GG0SY6oSvhkvHyCrRegkmQctD4/s+og6HANcQ0Db9E
         jCEGBknyGuGmNZn0TQphanf1dUwlUJKWLoj8Hk60qA8gH65QqOHUdtvw/63ahZhoA9W3
         HZaA1/2S236EDv3jdeYOjSHgiJ35hD1IdxYPjNu4tjoCJ3T9Jmdvul6iTTjP1w+mvEu1
         /9T6d7kWzPLQ+i4nGqms6J6AU0cQL3sCW/s6CxoNImT29iyDDrGQ3y9d6kgP0cn3/a1B
         dIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361800; x=1793966600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aCpkNDkDJOBSn8oO8i7bGdEOJKusWxmvDqSYvuM0OR0=;
        b=yurDlWPFijXEJ7Ybrw1yKIHP6ZsyN4sAdAHc0afLXtoiVBV5WJtKQPUw9fFYJYf+8M
         QY2O4oYhM6ZYpF1Xo327kgsrKc89MGl07JP3zKWcup9CkBiyP0+n68AChaY0UWJgZxhg
         3cTyi5HwN3rQtFTfOAfVXFOodBqWJuTCGlYjo2/zIWpOiG8JdsJQadNragjwYBReL6Tv
         RL8xc7hfTLX31Q5c/uEret2AOvv1EDbWDnBoFsOA4Xqvz6pE1qtvbtngdvNGXwkOdIPM
         Qq7qZWV8e/35vqjrOEoPKA4bqZ12i+uxiNdvBTALitgpPdF/onKmm6Hau82PdK1KyJeW
         00Jg==
X-Gm-Message-State: AFq9FYIPAn9gd2wzPQjg9a8u9W/dORE7y1DPn2Gc3+ozKOoTwTXSs23v
	g+zj4YOnWZTapD3ccxU/EvlTriSTCZXiJ2n3g2VDLN2loEgoSWrhh4KSRiwzVgw=
X-Gm-Gg: AYBFou164kPacqbfT59GGbxp/KEEGwxfaMTD+PImw7QMoW8ouVJ2sdoFhIpZyCX5S6C
	FEvoPDCYgmSCNdpHrPICFsQu0AYEp9QjbemzWcX7D6PSyHolSPYRsgStod5MgHDGLKynaaqswi0
	sBB0MFGc3LZE8B0SKtsvzanhsXQDmDuH5kkVYsoWx8b6UXYeKj1IQ6SiDlSttHAJ4pP4Tj1ubp1
	QLqpP+oQLQQ9EcDhUy+jFqqA3Gdel+QBdytYgsTVtR/OfW6ofHGZH8S15xZHJtV8N8yRa2LL08b
	+vlqgQit8jmw308MdH6F2Dkl2lUfGjZzoVkFyhDhMCXEDXsKZCHqvXDMgu8U77ct97b3FkNLuPM
	jyBk6J6X8mC+hovVpFie7/QEO/HacHPSYjjl9XR2epKH06gz0t/8nBXe4aeUYT5csavRpAtoW6G
	eR+7xjbl9VkG68q6aAODbHEzMUAlUhPj5DcD98r8WI47H9xeeEl4/V6X7TYqyl3AMN1ErLfF75K
	nezG/DV8Wnw1jHc/sWRzoMTfaG9nowau47rZUHnEGzke+QyplZeMOf/x7b0woLa7GfZ8nArhTjv
	QFWAPCwABJgF/MXRTf38DpcpJntJ0i/vFgoVn7/b9DrJPDrgcPh7FztG/MrrpmA8t0LvfuGWygA
	+c/sGai+trGYCWLSQ
X-Received: by 2002:a05:7022:5f08:b0:1ad:4a47:a072 with SMTP id a92af1059eb24-1ad4a56e51emr1632573c88.42.1793361799521;
        Fri, 30 Oct 2026 05:03:19 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:75fd:f9a4:4062:7980:1324])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac13ef1932sm6617577c88.2.2026.10.30.05.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:03:18 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: axboe@kernel.dk,
	hch@lst.de,
	asml.silence@gmail.com,
	kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	anuj20.g@samsung.com
Subject: [PATCH] nvme: return -EOPNOTSUPP for unsupported dma-buf I/O
Date: Fri, 30 Oct 2026 17:33:00 +0530
Message-ID: <20261030120300.4161174-1-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_050321_708226_751C114A 
X-CRM114-Status: GOOD (  10.75  )
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

From: Anuj Gupta <anuj20.g@samsung.com>

dma_buf_io_ctx_create() uses -EOPNOTSUPP when a file cannot create a
dma-buf I/O context. NVMe currently returns -EINVAL when the namespace's
transport does not implement ->init_dma_buf_io_ctx, making fabrics
namespaces report an invalid argument for an unsupported operation.

Return -EOPNOTSUPP instead.

Fixes: ce5e386c1108 ("nvme-pci: implement dma-buf backed requests")
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a7a4d09644c1..54d4888cdcd1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2720,7 +2720,7 @@ static int nvme_init_dma_buf_io_ctx(struct block_device *bdev,
 	struct nvme_ctrl *ctrl = ns->ctrl;
 
 	if (!ctrl->ops->init_dma_buf_io_ctx)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	return ctrl->ops->init_dma_buf_io_ctx(ctrl, ctx);
 }
 

base-commit: 70866cfa169d5ee149364267289e71d50f9a7ae9
-- 
2.43.0


