Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE49C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 14:36:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB4923432
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 14:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB4923432
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YLdAQ72eE/FwrdWNDKCLDe40jaGUVkbGPGddrSi1iaM=; b=fhxzVuavqFpQI0MnGdp1zJB0c8
	w7A5PjE1Sa8LFmUESWSPMD7s5VcvDgRNLfhRVrWHkDKoVKWVVVUaClCEAzkFP/jdILkLX3aIz0zyg
	81xXZIN3aiuFFLQEbS8pNfgMFtsTJ87xkskuBuVIrhbzUoyzNajI4FCRm5coTiWjYuRUShPLbq04Q
	HWqEpdxIJfese6uP9w0pn38fU6nRoKcFcXtSsg8GJdJ9c7YbVQkn7qUNC5nqJeM5J+1R2kks4V+d+
	n5rl3Cx+KYOK+GHjI73x5IvugdOhni3Fy+RB3CBKJWvw9TiUXBhLSxlGLwGa1c2k3Q/lOgwfDaDSU
	G/Y2B4WA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzhGP-0001Cb-1P; Wed, 13 Jan 2021 14:36:45 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzhGH-00018q-4R
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 14:36:42 +0000
Received: by mail-pf1-x42c.google.com with SMTP id m6so1325989pfm.6
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 06:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=I57NXoiscpqsUn9PYD1kaTLRHzV/nPSTBgPwuH5846g=;
 b=ssm2X/seJlKfpeccx8INaOtxkVPrh/Z+GREpCKSO0GcsjvRpdXIcFvypkk7wqjRLjY
 DljQf4QZZu3LrvxNE3ePrOWNdE6NCKUDFOzH1UOPrFV9G8Gc+g7t4NoXxORxVQFOeTSa
 H0KfyqtQxvDpJN1p7zKenBkJ2YjtqSLVrEy1hBK/1TnmTQUM5AYeEur8tr5QP9in5k6y
 ufT5+XyAmD1M4xCTCyeoTPD0yCeDwSxVR+lGW65mMTWVeboHxsUf//TaSSN/r9CYLM8V
 W+/QcKrp4js7G04CQyvEiBVN2U6rqa6a+qU3j7BkOrBpAa+gvLsDoHdM0bWimsRq6NqT
 dxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=I57NXoiscpqsUn9PYD1kaTLRHzV/nPSTBgPwuH5846g=;
 b=D3eKxN6Pt47cPme74AC4U0+594zcIPmpkAogb0Qsvvrt71f+Gt7fcw8asuju7irxWu
 LzzVVRPukORiEQN+FMBJV4SBwKjIB+5gsytSgN2DMZ+sZKZN9WeJLYH3mLs4Tv2LqWEp
 76zpOTED700m0frJb9hYrVKVnjl4GNNv3t6txdI5eP6ruvJK1lGtzGuEFQ09SIjF6elr
 UpIPQFIQwmTUZ2P4TOxAfecv/fjNvSgJQuP7aD09EtuCk0O6Ufj4k3TFWBomC/Tbw2fA
 wCOJKj2LQYJNFgtFsGfZR5+4++4ToKfdCPfquJ8u4eu79rTk71MzhJ5kgZ4lsy63Sztq
 oeZA==
X-Gm-Message-State: AOAM5306/akj9p5C4KFpkIEBGXIxxc8ereGunBUC/qDB1zeXVdjCQTSN
 yCi3XNz/yFxh5SkjtetTBc+4rQj6FgXElg==
X-Google-Smtp-Source: ABdhPJw/AyO/noI5XHjHVkSxqw2MeR8N0D+3qjIFxqvFWvyRtcCu0TkwXZtKIjkGqQ3X86TSL3/oZg==
X-Received: by 2002:a62:6845:0:b029:1ae:2731:8a89 with SMTP id
 d66-20020a6268450000b02901ae27318a89mr2665805pfc.73.1610548594261; 
 Wed, 13 Jan 2021 06:36:34 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id u68sm2777358pfu.195.2021.01.13.06.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 06:36:33 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: refactor ns->ctrl by request
Date: Wed, 13 Jan 2021 23:36:27 +0900
Message-Id: <20210113143627.787-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_093637_242942_E2488A97 
X-CRM114-Status: GOOD (  12.73  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Just for current code in nvme_cleanup_cmd(), we don't have to get
namespace instance, but we need controller instance.

Controller instance can be retrieved by namespace instance, but it can
be directly accessed by nvme_request instance from request.

	ctrl = nvme_req(req)->ctrl;

We don't have to go around namespace instance from request instance
through gendisk.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fff49e544fdf..c8da271a77d7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -841,11 +841,11 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 void nvme_cleanup_cmd(struct request *req)
 {
 	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		struct nvme_ns *ns = req->rq_disk->private_data;
+		struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
 		struct page *page = req->special_vec.bv_page;
 
-		if (page == ns->ctrl->discard_page)
-			clear_bit_unlock(0, &ns->ctrl->discard_page_busy);
+		if (page == ctrl->discard_page)
+			clear_bit_unlock(0, &ctrl->discard_page_busy);
 		else
 			kfree(page_address(page) + req->special_vec.bv_offset);
 	}
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
