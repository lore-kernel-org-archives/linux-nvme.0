Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631D8606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 03:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=14cDFtbV;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mjm1V/l8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=vIlFLNw+m47ftNTJxN6Q3ULvJUFPP52XPh/0+wF0w7c=; b=14cDFtbVBlcjA2UIqrCm28jUXt
	sB0Lufiyrnay6bfyAAb30m5A1t0DVEsa9oX9rPEcnTYlFU0FuTymB4Inkuiuo7Dj3tyy4PtY9ooEc
	hg+ga72q58XRMyQM11bJKKcORnn1erkxEx3LRkiEmgM+5zuy0I47HipbNYw2QG0mOENi5nO42wsLs
	lEzteSeXcTYhuvMAtS+ZHNu02qOM8B3noABr+VHijppnLjt6ZiBmrgpM5e9hXJ5otvps39CAdh7dl
	Te0Ei6rHfyRSsF1oy8soeOU0p82VEcWcv9oAg65omkZSy3KhJvHRGDNLkZz7zSsVx2V5yNGGSJW86
	66RZ2ypg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMGc2-00000008Exb-2LUr;
	Thu, 29 Oct 2026 03:15:34 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMGby-00000008ExB-39jH
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 03:15:32 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so15534255e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 28 Oct 2026 20:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793243728; x=1793848528; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vIlFLNw+m47ftNTJxN6Q3ULvJUFPP52XPh/0+wF0w7c=;
        b=Mjm1V/l8eg5sFecNnarhNZYKxRDyRG5ADJeWT759AWbcLbZu9MtJqRCqcgFDgh95/W
         5GRX13BArf8vlBhJeioUhdb84bqnLEJEOHtgGSWDArpJI8mLbKjMCgooei+7S5WFGycb
         i1bC1sZ+y4N8x6qkSP4ExPotkJwE2rezO4ku0GiL3u1h0BubDagXIfeT0KOQ+Ifj++Jy
         PYKYSXZDdfmNuUUlyi2bhGOycOoEGsz7I3MenuNkX/cutkhXSpRCdT56xY7OPmAW1yJY
         oYh+GIb0ReSi7ihNMeHGy1Nw/gvfcCyc6Wqo9BkhuCtlQubBbotdTWVzNqY/TDgUMGGY
         daIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793243728; x=1793848528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vIlFLNw+m47ftNTJxN6Q3ULvJUFPP52XPh/0+wF0w7c=;
        b=lAnrDpIdWLwmEwoROhEMOMlGRnfL1t5qIA2mRMndfTlAhI7BQyiAF7qIe1TEb5eLhj
         rmOHYRWoRJyXwciGeHmLfuqxLmMv4rAi3RemD1mav5eDzd51sYMo5MKGSXeOycZBdoVq
         0Bi5OhwPh/ijEGhBuGKvIlNmnyHLmP6oBAGv7o52dLWFA/EvmQzZBXFCDHyxmAVS6vNv
         GDw1XqmskPYIKMNr04Yfu1iJ0uvB7jCf3lHPBGD4+8fOCJfTICfWy1x62hGASXvekEtd
         3v05U4QJ+CaTmTOaAgBpkxoVctZRAVZf42hIFH0K3aNs+YY12KhH8SZOjmcP93z5Lgbi
         VUWg==
X-Forwarded-Encrypted: i=1; AKwUvBxLlo9wYB8bbpHpFyWRtfLX3nQJN/S311sBie2Dm3NDRlhsZKpgbJNqCee3F0zeDJV+SDlkWMnXFpMD@lists.infradead.org
X-Gm-Message-State: AFq9FYIn+i8mpB4U5VG9lr0zyHrrq05FbhHbxGveFKuZQyojzZ/XCL1S
	VSOv6RPH0JbMjFVX7rSw7S04k4tY4zqdKDV2B/vpeughA785SRaHihV1
X-Gm-Gg: AYBFou2zBSa7ew4JSQ/6APxliuPcnS526Mb+1M+HmxfJi7OBYAQB/aT2uOM+YOd9amN
	G8dkcxGpApscTqyZaDx169JJNUPzFKOA4L4zvXxa8GqPoDKgNrtnBitOApC7iZhNUgkZZCm7FJj
	qtDxaKdPmnMyrCpuHPEJaEuydNuKLhiXcR4pIBia9jLOvGWofpY7gY41kv6MvqzMxPgZkJU5Dm8
	ULnTtu7mA8WjC6VVKI24sM6ffjVBnBxXmL3PCRJkbAOaar5M8AVfMb0PbdpZTZpJ0FqAhQzkzm9
	D076O+6AzIKskutNBRCSm/QRzTQe/+pH1lnFfGCoOIU0at7SKaIEPyBlp6ppwvD2Uotfo1p36xh
	zWUqDqJP8XBCG5DX4xBwQDXD1hFr4PwUbO7gkjY5CGUAIrkeECwuAW9rLZB50jq7PuKyG3P4OG1
	X9+GaLmrqHzDdykqHLzKUnhQRxk2ZCehQStYHUXBA4SgAuTFuln3J+EzqIM2BuvbHjvLdMSfoGZ
	UJHakl0/StUwWhU+iy/RTPTjSlsarwTZ2MrV55iL6Ct2hn0eqpKMj0NeUAZ36sN8b3033NuqFi0
	PQxIQUG4Oe0InOvludmFyjAWuFnXKpTlOjuET+f+rR57ZGEa0XpLzCmr6rBJxJrFltugncGF7Lb
	Vyb8Bo6+r6lJW96DdGHCblE4M3053c92gzMwTnt1J4CuvrKlcEweKDxR2ToCPWE6RTWRe/CiXN1
	D2izaLMTxFU0vjGg==
X-Received: by 2002:a05:600c:8715:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a967ab1ce3mr94468935e9.33.1793243727833;
        Wed, 28 Oct 2026 20:15:27 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-226-156.77.7.pool.telefonica.de. [77.7.226.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm35478505e9.5.2026.10.28.20.15.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 20:15:27 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 5.10.y] nvme-tcp: fix error codes in nvme_tcp_setup_ctrl()
Date: Thu, 29 Oct 2026 04:13:52 +0100
Message-Id: <20261029031352.56096-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_201530_811634_A57CDBC7 
X-CRM114-Status: GOOD (  12.12  )
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

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 522af60cb2f8e3658bda1902fb7f200dcf888a5c upstream.

These error paths currently return success but they should return
-EOPNOTSUPP.

Fixes: 73ffcefcfca0 ("nvme-tcp: check sgl supported by target")
Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
[ Karl Mehltretter: Omit the SGL-check hunk because 5.10.y lacks
  73ffcefcfca0 ("nvme-tcp: check sgl supported by target"). ]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
The fix is already in 5.15 and newer.

Tested on the 5.10.273 review queue (6aa0165f18f12) in arm64 QEMU,
using a loopback NVMe/TCP target stub reporting icdoff = 1. Without the
fix, the connection write succeeds and deleting the remaining controller
oopses. With the fix, the write fails with -EOPNOTSUPP and no controller
remains in sysfs.

 drivers/nvme/host/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9e1c45d7cc999..6c52e7fc2bf46 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2116,6 +2116,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		return ret;
 
 	if (ctrl->icdoff) {
+		ret = -EOPNOTSUPP;
 		dev_err(ctrl->device, "icdoff is not supported!\n");
 		goto destroy_admin;
 	}
-- 
2.50.1

