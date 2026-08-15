Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64310C5AD5A
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2026 13:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2eb8yhaSP6esKUtShVLG/ljDKlqOdP+bfjrtAJ32aMY=; b=v+muU/EqJo2L1tBzspROx9yn+j
	/9jYJLucN2hll1IrUoDhLAVw9tcy7kAz624kDeKirdl7slL/t0Y9LuXmPYMzHxnH8Xrh90yW7bj/y
	RP8OqjBW4TeeXOCVJA4fmQ3af87hzh66uD6zyeACdLFXriVf22XuwVamxMTQw+sDp4/pr4wSG24HS
	D0ivfVd1MYzLL50Vph3PyqBa+Qk7pcZGozxcAH7ZZT5T2tQDUXNmgWjACNscdERtaomxlvnJ9Wa1f
	1BHn1yjRRQtByfyEqIRA0Vfu+QtRTQByG4rV/mVzSKlJXPjWX5gNEYejxGIWNVAEO3vQ/16US/g1D
	bOhhQr5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvEkQ-00000003rLx-4BdG;
	Sat, 15 Aug 2026 13:48:31 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvEkJ-00000003rLc-3Llt
	for linux-nvme@lists.infradead.org;
	Sat, 15 Aug 2026 13:48:24 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-383cb94f742so2287110a91.3
        for <linux-nvme@lists.infradead.org>; Sat, 15 Aug 2026 06:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786801702; x=1787406502; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2eb8yhaSP6esKUtShVLG/ljDKlqOdP+bfjrtAJ32aMY=;
        b=pnGO9aQsGNGDORdI6WNfkEUt2aHE16rO+UP05/UCcXfFfADu3KdlArkGNJwny+OxCQ
         cBBWcD2Cn1DbPJKBiaPcfEljtQrgr/klg6cds1W/MySDE/rMifG4JneN7xFKeKna6vRy
         i08u012b9ZV/qbgU0LFVL2l2UeO3IqBL+h08fqubAOxYH492wnTt3pc6jlC/kawIRR9t
         FH17707XxHAFg+vAvZqm0SRRnWeNGOpWt+cVAS/u3lP2IuQUE+L8HAyJU6/E/8YS8eKy
         0ED+fFgpF4lv1oyjoMRYvCb+WdLR3v5fwVAYV12wkohFkx2edp2kZrGP9Qde2JRZtTgS
         7Qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786801702; x=1787406502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2eb8yhaSP6esKUtShVLG/ljDKlqOdP+bfjrtAJ32aMY=;
        b=gEm7wePOkUXM850vN875z2FqfTq/8p2kDoKmq1xaGFBeSE+HPlrtwPM41HRH+1xQX1
         5kcccyEItHTs5ifu5YpEWoVLlFtbmupWtkvDMlT0HQ8kdUa1Q0tiX7Zg69UiVPrcXADD
         M2PiAmBLdE0rK1eUVel+c6jxs6pTP8p091t+xrTlYVQo7tVigzKWeaK1caEeuMwhI4Ou
         ndPt76fskaYrT4z2fyfY+qucBVoO1ZxWdrfY/AvI02ENx4x0HuG7BL1RvDvi8B/ixVfv
         hjYxFxH8WluA3yw/U9+wAuN8pJWriEbqzmHsxIkK8XWKGtT5OfyZPfPe1kgHVRZUw2Oc
         tj2A==
X-Gm-Message-State: AOJu0Yz8N8/1tvCrSEJk5F6Nv8TW+CqhQWA1EfzvxfkRX8IwcwZ8Z0ub
	msgwqofb26W+zfuyxn6QQeXo4PbmgbY7owIJ6pxJ/qDfG1gj/HgVBLu/
X-Gm-Gg: AR+sD10C/iw4/1uryaBb77kntV1SLX9/EVZQgiCWq737KhQubsbHt/w+36wIaBbhxXW
	e5uS9yy4pJrH6NqIm4AiJYl8b4QJ5Z4oA/PrJwCEtqeXP3yQh5dyFO/d4BoCi3qujK0wh9FCFU5
	vXQ6eg9RsUwjZ04yoRPnrRLyWMN6o9G3+htZsmottRYnfyuPVwRPk4mVBv6Bd9LLHfzwlPmyAPB
	nK7skYzI7iC6z23EHEaxwvgumqAGYRkeB6uMLUKh6Uo46vlXoCizXzFi27a1+1oeme1bE5Vd8hz
	U6by78/iFIt9Oukg5lam/8qtB/xreXZP4c4NwS4cTfjusrC+aQH52eRbOVGzCwkTcZfRGNIrbYU
	xJcGWoY2d1sLkf3u9SAbmAm393RleL/XZF5393S/sLUWFdZtE2dZV7/soLoV1kekZUZq0BFDoDO
	cHUYe/AzRIKPy7/h+mBSwja0M+NOKZbhG86lUbL+NN4vV8nfchXrQbqFTxVvW0BqM3TFZmUxHLL
	KizaruWtt6cfMXZhVBQfFH5
X-Received: by 2002:a17:90b:2d4c:b0:37f:f4ae:5f25 with SMTP id 98e67ed59e1d1-3933ed3fd54mr15227726a91.20.1786801702349;
        Sat, 15 Aug 2026 06:48:22 -0700 (PDT)
Received: from localhost.localdomain ([103.179.231.124])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141388b2554sm28629273c88.14.2026.08.15.06.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 06:48:21 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH] nvme-pci: return -EINVAL when failing to parse quirk parameter
Date: Sat, 15 Aug 2026 13:47:45 +0000
Message-ID: <20260815134745.7263-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260815_064823_845452_97DA8DA2 
X-CRM114-Status: GOOD (  12.00  )
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

In quirks_param_set(), if nvme_parse_quirk_entry() fails to parse an
entry from the user-provided quirks string, the function prints an
error message with pr_err() and jumps to out_free_qlist to free
resources.

However, the variable 'err' is not updated upon parse failure,
retaining the value '0' from the preceding call to
param_set_copystring(). As a result, quirks_param_set() frees the
allocated memory but returns 0 (success) to the kernel parameter
subsystem, silently masking the parsing failure and incorrectly
reporting success to the caller.

Fix this by explicitly setting 'err = -EINVAL;' before jumping to
out_free_qlist, ensuring that parse failures are correctly propagated
to the caller.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 69932d640b53..560560268c05 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -213,6 +213,7 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
 		if (nvme_parse_quirk_entry(field, &qlist[i])) {
 			pr_err("nvme: failed to parse quirk string %s\n",
 				value);
+			err = -EINVAL;
 			goto out_free_qlist;
 		}
 
-- 
2.54.0


