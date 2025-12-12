Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B73D59D8F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 19:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qkIrV0+1XK3G25k3vcZgoQ5O2NefayvpABFzazqYeUQ=; b=Ov7ZwpXIb9dtLbAFUo3aBOzSDF
	Twtcb59+t6WGvmpRuXbLunYkpQfSt/9p1EDnH6GhdfBu9+M5hDgaPID7Qg/dP3SKJvIizPeB0IhDQ
	zAVO+TOZ6pbxTq9ndpMuBmM+KqQsxy++15CNIloBPELfnN8wf6QdtFAG+3bSiJFq0yzV4xCpu/6De
	lK5FmZ1Iu+QOXy9qRjKZWDVFEG2ciZv9l+el1JzYhCDmuonRRcm12zFkTfmaRE1sO6LRHCbXMWHzE
	9gC3j5FkV59p8JCA8dnhDGlt9ZNNLa7uubhr9FxpmFFKb5XabhpadxhMOKJ9b9CKLfGp2iNpmUlzJ
	f8SMXSjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU8rx-00000000zZk-1qEC;
	Fri, 12 Dec 2025 19:32:01 +0000
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU8rs-00000000zZB-0APG
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 19:32:01 +0000
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-8b220ddc189so202268685a.0
        for <linux-nvme@lists.infradead.org>; Fri, 12 Dec 2025 11:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765567914; x=1766172714; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkIrV0+1XK3G25k3vcZgoQ5O2NefayvpABFzazqYeUQ=;
        b=H4MzUZyNYxs6Yz/x4D+uojYvMHWUbhfDYq4YBRBUhE7FePivda2FLnIgeA8dAMyhxK
         +kdxFgAPCE7QGmgSmdHffRwSlbnDI/MjVlaEEr6Jrhb4SYFbYyElGwp1Cr4zyPZvAYZ4
         5QBmlsBGTvCOKXxwqw79+XKw9X7SEDFkrer+85uqD+1kF3fZP2sqBhTKmwPW46+tNTTZ
         CglpSBib1ET651YKMn/+OApy1JCGUdNGTeSwJ6yndEg+xgYKsobA7wjqqfqf+CtjOIFl
         X4N4HHQ+Hf3JqphdLYPLhcwlSj7Yt6Lu1Urllt8pqeI+tgjnaFQWOBc484NKUaKyrdmW
         qskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765567914; x=1766172714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qkIrV0+1XK3G25k3vcZgoQ5O2NefayvpABFzazqYeUQ=;
        b=Bpa+AftR1egj1h+PGqBf6tM+AyGckSb1a6GbilCYXkNuAZ6BKwMNXA5jgOSZwiynyt
         OUt/FoT9VlRD0SPtiqNMKWRpmrSXypmfRZ3O12z62mdNLGbfzrCoUduxUDjCJziKfFqq
         78pmJsbzNlgzV0y0jQP6AVT0l5ZQCsBYe3PlVUbNTHAC6dB2fI2FJFRSkBPJZcP1jSl9
         7tD6DHJqlFtQSIyI22KRanUs6D2mcNzorx/CXhuyt11zn/skvrNGxIeCB20WLR5XLwOC
         tcs4WY0lftcTHWn44HXs5J5M07M/tRtnHsxWdr5o0sBNdHXKhzYsF5Gu5W3JNxcTQTrr
         5LpQ==
X-Gm-Message-State: AOJu0YzFbfRuOKT8mm+t7nBddZYyV1WWzcd410N+oWGHsav/KKRHR0qS
	L9Qwt85ErAdWx+uvTAlnIx7uLDuEhJXUu4izYI27Dkd30Kq87HKIq1xr3zLKTgNc
X-Gm-Gg: AY/fxX7/mSgTcZ+jNgASxRqzv1zh6jtQngDBXLa16JVvvOetGOwwP0yveUZYQkkuhJr
	1OkfivNwjG1Ej93CWlo4xxAmG2HN7AloixIlYCsmUtNDyFNqSp9H1KRhKK+WxgCCRR8nCsSPP8Z
	xZcaWKnBXrvX3/BMEEUTpiR8y54KI5quZ4B9OmwBEWIN1nByJyxc3RcavdxkM7SYKjHUFE5ZLl9
	3dBbxrH0tHEf08QeHr6h4skJUiUUtMRWHLYhwWv1sA8INP2dz+U5LukCGQqtQjhp/JsYeElNgMB
	u9Q2Wjs0P9yFAFzqp829GHj896GJWaVO4YUIiEBm3dkGMOSb296bld1ZYARIjlZdZdGPTUZlu/1
	aadkWLqgvYadSOE4I9ZooRUaGGWfmi76JgTfxPVOGflM2+yYZcGlyMXAbhR4BnFv+HAIurS/J5P
	I7sg9rmWOXP5J3km7O85tYHwxtBDDZfFUxo2YHfZ3YSvArqCYf0CdjoCjMkdI=
X-Google-Smtp-Source: AGHT+IEfZku+LKRGQlk2ElfAccQXj2X+kb+V1QadvH/DFtFYdOispfu2CJNeIaesViHbn7nZtrkmBA==
X-Received: by 2002:a05:620a:1723:b0:8b2:f9ac:a893 with SMTP id af79cd13be357-8bb3a387723mr420295385a.66.1765567913890;
        Fri, 12 Dec 2025 11:31:53 -0800 (PST)
Received: from rc-szhan197-01.ad.syr.edu (its-crushnat.syr.edu. [128.230.103.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88881825253sm17424536d6.17.2025.12.12.11.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 11:31:53 -0800 (PST)
From: Shivam <kumar.shivam43666@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: sagi@grimberg.me,
	kch@nvidia.com,
	hch@lst.de,
	kbusch@kernel.org,
	gregkh@linuxfoundation.org,
	Shivam <skumar47@syr.edu>
Subject: [PATCH] NVMe/TCP: Fixed the out of order H2C PDU Crash
Date: Fri, 12 Dec 2025 14:31:24 -0500
Message-Id: <20251212193124.1022096-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <BL3PR01MB684908447A2F3F7D2AFC57DAC8A3A@BL3PR01MB6849.prod.exchangelabs.com>
References: <BL3PR01MB684908447A2F3F7D2AFC57DAC8A3A@BL3PR01MB6849.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_113156_099907_2C073F58 
X-CRM114-Status: UNSURE (   9.43  )
X-CRM114-Notice: Please train this message.
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

From: Shivam <skumar47@syr.edu>

Signed-off-by: Shivam Kumar <skumar47@syr.edu>
---
 drivers/nvme/target/tcp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 15416ff0eac4..cbd9286eabf4 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -982,6 +982,18 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		pr_err("H2CData PDU len %u is invalid\n", cmd->pdu_len);
 		goto err_proto;
 	}
+	/*
+	* Ensure command data structures are initialized. we must check both
+	* cmd->req.sg and cmd->iov because they can have different NULL state:
+	*- Unintialized commands: both NULL
+	*- READ commands: cmd->req.sg allocated, cmd->iov NULL
+	*- WRITE commands: both allocated
+	*/
+	if (unlikely(!cmd->req.sg || !cmd->iov)) {
+		pr_err("queue %d: H2CData PDU received for invalid command state (ttag %u)\n",
+			queue->idx, data->ttag);
+		goto err_proto;
+	}
 	cmd->pdu_recv = 0;
 	nvmet_tcp_build_pdu_iovec(cmd);
 	queue->cmd = cmd;
-- 
2.34.1


