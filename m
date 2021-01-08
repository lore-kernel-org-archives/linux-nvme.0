Return-Path: <SRS0=mUlG=GL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0231C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 14:47:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E7A235FF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 14:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E7A235FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wc2+oTaXVhom8qNSe9WMLabOEtYa2NI2ouMelA9Ores=; b=VJQOpyKJkt2Ky498MKueNM0UpR
	DSMFIsLVbFA8z4vmNdE5cOzU2y6PaFCKEKk8siSB0xWZxXLaX9a/+3cZDGhvv5rNiz/1n64mbikV6
	mLVADtoLYd04qiLdrvul5ORZ3fwjNRQCgoGL24os2JbxUMSnH/LnTodhFc7zwcEdjFJR/xuSnuSnD
	8HCWXOgrHsLfakUnkQqWGc0bo31m5m/O7xyI2+G1azaaI06G7wuTESU0/BPexmFuKgMKervkjl6HG
	/rW7a0dbl26ccaIfEaiARlCQrhlbYeBCkXHT4+/9e8jL8SaaFsizYO2M/rIADIygcbtqPNxlMZ3/T
	4fH4MipA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxt2u-0003KU-EM; Fri, 08 Jan 2021 14:47:20 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxt2q-0003Ff-VC
 for linux-nvme@lists.infradead.org; Fri, 08 Jan 2021 14:47:18 +0000
Received: by mail-pj1-x1034.google.com with SMTP id n3so5677450pjm.1
 for <linux-nvme@lists.infradead.org>; Fri, 08 Jan 2021 06:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=t94jF8Zwj9l+GtRe7t4utc2KgSA2lSlDQFu2xMPLjqI=;
 b=OqnkLoFp/9V4mimHurZwgXsPzZC3oMGCM9CIX66+mhMUCt3AZXb5uPWZetCyPU23hT
 Avgg+QBVgbkuFovVcc9z07qTdKd9ajojRpPrF4QTUjKJceMK6srIE17jqYGqCpqCPBGL
 NTOQ+N7PfmO6KmMV8LkfA+vaoBsB6U6zosqNniN79JXAUVs+XpURTvmvbkH33TSoZOnS
 fQ4eVBRoIbUPEIgm67cVmaMXXuq1XWdO+G5B/E5azq0s2+OiG7JzixndmsSHapEy6vfN
 wYT08oYXjmuIkVEK7aGO1ASUBj4JiITCEU0ghI2FPLn8ic/1xtO91yVg0YeD7JyhVR8u
 yrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=t94jF8Zwj9l+GtRe7t4utc2KgSA2lSlDQFu2xMPLjqI=;
 b=ah7/pUfA1U5PkEDhGg49psHf4wJrjiDcWkpWgn7aAF3MBo1pOCKUMjuMGyqqkcUoiZ
 xGNXe4guZofoHFE8TmbFh2vcfdMhLFm2t5u9vq1lkPj2ckKya05lFtcKEkST916ERwf7
 18rjWu7klIBqgbTiZaw3fiJSj+7achqwXtC8dreSWMvd1FuWibXzNKPB9xulg1HOXCrK
 0jLuheWomzSWeNxpQ8tuA2vSQMQC3hyHHv8t9avXZled5lNvhUpZxG37rXqCln8kLOyk
 lJl8yk+Ps++wW++D6PBHM4bGmW7ZdDKHE8oHJNVyPIM8Tt+LF7htOWivfNiphR+kGULg
 OUZQ==
X-Gm-Message-State: AOAM53166TgATQAXVvfAEng/6PKyapeT58H3D0EB62IXuodL0MabGmUR
 LnrYr5VnGXXhkRlIUNFeI6jU118AYypZKw==
X-Google-Smtp-Source: ABdhPJxNWRoCl0Q1MR3mK9jZsaEdbmwk12eS04E3XQf/O3wUmmnjD/ST1Fl3dKBtUyI8Hur6VeB+hg==
X-Received: by 2002:a17:90b:14c7:: with SMTP id
 jz7mr4080741pjb.40.1610117234428; 
 Fri, 08 Jan 2021 06:47:14 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id w11sm9875391pge.28.2021.01.08.06.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 06:47:14 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] nvme: check all retry delay times in Identify Controller
Date: Fri,  8 Jan 2021 23:46:58 +0900
Message-Id: <20210108144659.7126-3-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
References: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210108_094717_034434_F89DCAE9 
X-CRM114-Status: GOOD (  16.09  )
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

If none of Command Retry Delay Time(CRDT)s are set, then we can simply
skip to configure Advanced Command Retry Enable(ACRE).

CRDT selection will be made in Completion Queue Entry that controller
has responsibility to decide.

This patch checks all CRDT[0, 1, and 2] in Identify Controller data
structrure instead of checking the first one: CRDT[0].

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d0c99a9400ea..6e428fdc25a8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2501,7 +2501,7 @@ static int nvme_configure_acre(struct nvme_ctrl *ctrl)
 	int ret;
 
 	/* Don't bother enabling the feature if retry delay is not reported */
-	if (!ctrl->crdt[0])
+	if (!ctrl->crdt[0] && !ctrl->crdt[1] && !ctrl->crdt[2])
 		return 0;
 
 	host = kzalloc(sizeof(*host), GFP_KERNEL);
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
