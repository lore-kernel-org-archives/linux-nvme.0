Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47080C3ABBE
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 23:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ovyunJMzY2BM/vnqYqDfx0z8WEcxzxmQSFfHAJD53dQ=; b=hl2TBt4YEpEXmgfBRbSsvC4x5E
	QSENUVZlhNombO1mesUvlWRMu/ArfqMPuhZsbADamYHNGWuuAB34NbzbV0n8mJOqnnC5rxNXsWcf5
	gDOC59OP6U34q6Tg1f9l0e5s94d47j0PCbHRs3LMwxM4H9mKLdSLM/KTd8a0jUBX+0vXo0CnwTyb4
	yHTehXAm/n8q25xSCJO7BD5bsLzWIWOPDrERZfI0rQyos50FQS459cDu6iQsqDtAeVQAUrDJd0iWe
	sobYwhFC1Rq5U9MEYHocBez0IyDxauy38tvyPAUOgmB7YPKXZ//wd9TkxvEGv182684GrPx65l/NO
	WfrGI6cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCRpB-0000000DfnV-3bAk;
	Tue, 06 May 2025 23:35:45 +0000
Received: from mail-il1-x164.google.com ([2607:f8b0:4864:20::164])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCMUo-0000000CuZP-42pL
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 17:54:24 +0000
Received: by mail-il1-x164.google.com with SMTP id e9e14a558f8ab-3d821d6f629so1563265ab.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 May 2025 10:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746554062; x=1747158862; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ovyunJMzY2BM/vnqYqDfx0z8WEcxzxmQSFfHAJD53dQ=;
        b=J6GvLDJOxZ/g0w/uct459gwvp9K2M+T2QrLo9PpyzV/6FgZlrJ5KUw53FnHO54Ctlt
         8fcocOtl+u/EMgUissLpor+2RmoSKpz/LQT1FR1fQHVGggmTARzd2c3AXTirlsYPzT2E
         Pf4y85KlYomKn/MMf/r70lmYxPvjL0ZRGF1BOx4BrrT5PzrLwDm/JVQLTM/+Oje1UnoC
         C/INi/jntzowd2l46C5u9971p/eHZLfQ0Jz1DEQvcI6a3jcWCGVqb7HBV3GeVoL+TgGp
         YEcANiVs4zYkXYQo9QpBfW6P+/v9xLblyGu/Q7gzJR3G1WGLamR+zl83pEwZWsMuDne6
         CO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746554062; x=1747158862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovyunJMzY2BM/vnqYqDfx0z8WEcxzxmQSFfHAJD53dQ=;
        b=GYXkZE3pouk54hVyDu5Cu0ECsgj1bjgx/TjuUbRK4iWbDCEkg7cRlMfRyUnb4Is8VP
         FgKjEmFUJnLuDMZdR7r4HCaPFAwnEKfdMDIwOe/z8zcev5VukbLsTYbvTMjy8r4E4k3G
         pc2qkVHT0lkMKI8mtYIK6RnjmVoN+WYty1lsWG3m5Qn94wvLoUGjtPGdn2RixvQ/h9y7
         bhg2Mdj2llsFjatqfb+eGC4za9NhkeabSCJtynKONafJn9atgl5QrNIMC7I6P2yFP32n
         W5a+Pb8M+y4HLHPItCmAdg6PARqsUCWEd9F2QjpWyt0CfhoOuUZ8mnHRo9hj4hdX7CoM
         vhEA==
X-Forwarded-Encrypted: i=1; AJvYcCU/WXwtWEHKRDaj1pzOfsneWp6IiwaGjMxw7ihJQ5CQW0SlgiCrrXOt0WHf6W80U/2b02vjsCWQk8IJ@lists.infradead.org
X-Gm-Message-State: AOJu0Yyk6+OVGMdWSf5L4cSnBtV16d+B480Uiuk08NxVmK+kjTHXTZCa
	c5QRfGQH23ShONcrn62nk2UXVqzHwhrBbdYgdOmAfZFkCgMw+m9AflOfXqSQRPRHcM5uL+yerGn
	hno0B4KxntTlGxZsNeQOlyiSuK36MTn9kpvkRaMZIFEwKa1HJ
X-Gm-Gg: ASbGncvzlOPHthX0aSxo1JEMLMXWB7nFtHCSVjL1WF1gljfHZ6TpAt/krR9iuQZodmT
	ZOdnU/MdeDUPtbwtLX/XwxyczGjWOZM0ap4C/0/01Pdxll+IAgWyFU7Zvvq/DJo5VqGZglBP4XO
	IyFb1jrdDjLRTwH1YmsghdZOA964cI2ILzowPoCDN8h3LNHp2UwutvKdWLItTXUTLXLecTQenMB
	ybyoLDB942jqYU3x6hqd0X7KiBN7Y41niGSmQoZI1DN+p+VdWcIVIW3KkcKzdWEKzKNNe6xsSlJ
	pRPgj+GN+x4g+n9UtAHjYQ+tWq+WAQ==
X-Google-Smtp-Source: AGHT+IGG5+67z8CZz9trHjpJ22gnk/1CqPuiaRkSCUUxhooa3Yd+geotR/Vte9dYVNo7S+ByK3+DgGrMmhi2
X-Received: by 2002:a05:6e02:1b0e:b0:3d9:2961:fa01 with SMTP id e9e14a558f8ab-3da723e7850mr3279115ab.3.1746554061783;
        Tue, 06 May 2025 10:54:21 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d975e34c17sm22713665ab.2.2025.05.06.10.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 10:54:21 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6E8953401CE;
	Tue,  6 May 2025 11:54:21 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 67ED5E41E7B; Tue,  6 May 2025 11:54:21 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Kanchan Joshi <joshi.k@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: fix write_stream_granularity initialization
Date: Tue,  6 May 2025 11:54:12 -0600
Message-ID: <20250506175413.1936110-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_105423_046375_1253F6A5 
X-CRM114-Status: GOOD (  14.15  )
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

write_stream_granularity is set to max(info->runs, U32_MAX), which means
that any RUNS value less than 2 ** 32 becomes U32_MAX, and any larger
value is silently truncated to an unsigned int.

Use min() instead to provide the correct semantics, capping RUNS values
at U32_MAX.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 30b5f20bb2dd ("nvme: register fdp parameters with the block layer")
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 52331a14bce1..a9fb8cd54420 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2390,11 +2390,11 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (!nvme_init_integrity(ns->head, &lim, info))
 		capacity = 0;
 
 	lim.max_write_streams = ns->head->nr_plids;
 	if (lim.max_write_streams)
-		lim.write_stream_granularity = max(info->runs, U32_MAX);
+		lim.write_stream_granularity = min(info->runs, U32_MAX);
 	else
 		lim.write_stream_granularity = 0;
 
 	ret = queue_limits_commit_update(ns->disk->queue, &lim);
 	if (ret) {
-- 
2.45.2


