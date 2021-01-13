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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFBEC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 14:36:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D5323432
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 14:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D5323432
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gPTrUYJrKl7i9oi1yqb4/BCvAeyAbBk59sWpqjtRoUo=; b=ZGeaFQ9Hd1q2izualzfIb1xjf0
	wuagRIGzJWEnjrnMCo4gAGbVqCGp9XaTq0qF7kU3L7OafjmChlNKPhFw2vXZQ+B9laVgJqH4sVjw+
	A7E/icsmfWF12WqA/eNSxSBojgyjwXteQgYO35Oj7sS4T4sVY+rUKhoRfSfvoXnBCv1FX1SQIW0Zs
	gwFDCWpKCt5TrKVJ4TQjBJhQA4rtTiQ79xrKG8TaFRQWR8NsUTUj1yHGePJiVaL0nBwtbL59+6vsY
	/AiiMm2MD7OhZom46gWj9SAf+F+tXCNO0oU2JDOo8ibWvBvnlpIFzJz1sMfjXi8+88MnU8A3Onoo3
	ZkdH4NnQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzhFc-0000oC-Lu; Wed, 13 Jan 2021 14:35:56 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzhFW-0000kq-GU
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 14:35:54 +0000
Received: by mail-pl1-x636.google.com with SMTP id q4so1167402plr.7
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 06:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9s8mDrj9Qo2c5wOTAo1lHo80hmVfcACcbXc+pNkTdF0=;
 b=qdG67/t9AwNpk8Wbn6KuGPkJzIm2pZBkUVvIWzC9lLKH72gfjEAMEosI37ZK6ZD/uq
 hy4UcssqvxkmqO3j7nlgaE7jyVvvJ2CNp4DlRK4NDZuPCQN1Rr7prhbejRImmBCjOt6H
 Oa9j2wH1Oo1EgnzkhkVtktLTS9lddnmktrMysqxBU4D02LAV4H4SAnE/bBKEvezgw4qu
 Ps+7R0h2DSclGsxHtPRwxsxp3fIT7DHH8/beErKqD2mGaRpTkp/C6j48G0Ma/VDkVDae
 K1163MXdNJjvQFHloCaq17X+9Vagi+/RU3YiO1MmUb7bSZiu4cVDk3pCDyTMx/TnagSb
 VANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9s8mDrj9Qo2c5wOTAo1lHo80hmVfcACcbXc+pNkTdF0=;
 b=PsszlDCL1loZ/l+8BWPWikLk4Mbw9T4kd4lOV8Qb10jruY2DW5EBvMQCuNM1sHSggb
 ttlkl8gheApURpe4KJ++lZQB/P7WQtQNkv4sSyFWAvmxHVnzq+dxwZc60/LSIhhJl9E4
 8maMzZioYNS/7TJnx1RNAIRAkmgHHCguIDDi3HMUkTxpbcvuAPE0RJKEyCHtz5aINv0m
 unHFXHksK0jScfEuyz9mYyVNJuFt9LK+YF4fyOK1wI/j01HXZvkrmmZFGiA/8WRqGHnj
 3K2AGSNVX4tygeWhhL72StDp0PV1YUrVV9J2CZU70ww2VRvgxWljhYQ4YypEoT/2TL+c
 ue0Q==
X-Gm-Message-State: AOAM533cHQUCr2vslZxTnDutzsLZFD8SJ5a8HcuGuziFQiXMnvxrHhFI
 wjlHsnL5xzeMl7+uvefHoRbA/eY/oXaQuQ==
X-Google-Smtp-Source: ABdhPJxMdXgp0nAlHrZC8GXojqg1huaDjoZkuJuOutSS+XTdpdAdBDsnQyJRW7VFuf5zlyumkinUNw==
X-Received: by 2002:a17:902:eb0d:b029:dd:f952:db29 with SMTP id
 l13-20020a170902eb0db02900ddf952db29mr2539549plb.18.1610548548050; 
 Wed, 13 Jan 2021 06:35:48 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id i13sm2914431pgd.32.2021.01.13.06.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 06:35:47 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/2] nvme: check all retry delay times in Identify
 Controller
Date: Wed, 13 Jan 2021 23:35:37 +0900
Message-Id: <20210113143538.554-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210113143538.554-1-minwoo.im.dev@gmail.com>
References: <20210113143538.554-1-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_093550_625319_7DF43245 
X-CRM114-Status: GOOD (  16.55  )
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
structrure instead of checking the first one: CRDT[0] for cases that:

	- CRDT[0] == 0, but CRDT[1 or 2] != 0

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fff49e544fdf..a8cee380b3c0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2499,7 +2499,7 @@ static int nvme_configure_acre(struct nvme_ctrl *ctrl)
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
