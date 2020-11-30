Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B44FC64E8A
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 12:48:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911E1207BC
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 12:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cD86ALWv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTb96c53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911E1207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DXXE3gFZP3+6UfX4uJrGsTIHSKoOPKLtTRNui/QxikQ=; b=cD86ALWv//b9Frb5XN76CqpYqt
	o8rVg1OZUqoOlSkCj1bO++MWncWgE1K/C6QFfNIH3YfXPL8h85QSgDq3xFNFbQeJOMnJj/qXzV4r8
	UKnDMubSp45EtRm0fwIj3gKSUqmLxqiit91Bgw3g6byBzLRYp6mkM+aCHrx5po1jzWoBkc3fk/P7I
	VVC0y5lZasJLEHoQ60W3lQbfS7yomawhH+t7MKcwZ5aU04dt0eC/v88nr22lPSzQl80xLsNFghm3H
	DtiYEPHG5ncC6axV3E9C4ocG4x7gtrwmhX3AivgP/jWat/qoIkCXPX++wuCVTAah6GQWmij/XvgFH
	jjELIIPQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjibK-0001LF-9S; Mon, 30 Nov 2020 12:48:18 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjibH-0001Kc-HJ
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 12:48:16 +0000
Received: by mail-pl1-x641.google.com with SMTP id v21so6397298plo.12
 for <linux-nvme@lists.infradead.org>; Mon, 30 Nov 2020 04:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1gUObWOQlkbxEaF6E1ArmzmaXMqYV0mhp/4tArrYM3A=;
 b=YTb96c53VLPNtsJ7D6GjCES79g1X9MBO3nj5j8s4SoDOZ/fUFRb7qZ/f3qslZzoQls
 kZsvvQ3lpt59rhk4aa/EeFquaFVUKWbso4FCzL1m3gxLhjwdzW50waOPc/aHtfvaUa+5
 HOCSSJPJHqAWztC6bagBmjDFb2403/aD3JxA2J7hRXwviTZW9jArGsbaTWCyQeAhKlW9
 MsH4ha+ElKcUQ+MrPkYqidirBpurtORlkOQCfVvwQFLgtZyQp3RtmS2budv8m41vUhDO
 inNH4RS7NxR4a3I2iREDeBdyh35uwUprnjJ0BvN8N6erZQGIOhArzYHxHfYOJjXM5n8+
 cXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1gUObWOQlkbxEaF6E1ArmzmaXMqYV0mhp/4tArrYM3A=;
 b=Jft/8NxvrN1SvqX3K7P2iyiRHiZcBUBwXxzrnUFlz4wNJ1JlYohoEGaUmNv41/F+Sc
 fWvd8PyAbrl66bbV5Ua5fjLdhoMpuA2J5H6qDwKcrsoHeDspBZQc49z5FSeNu9evxlku
 OaBCbJL4NJEAEIqxKq7LQW8ewKB3vVogWMbby30eEnl9SlXES3LVeGREFsolZvJBuMQh
 eRaRudc3q2a4n7OvL+n51/z6KjyFLKxWjOBv5AHdxxIBwunBfJBtBBqjQFvJd8w55t86
 qUe8oVyMthFb/zw5JGZ7KxzI3X5I58NHkVAlOa9L5cfk9oYbam+LYznweFtLds5CO6Om
 lLGw==
X-Gm-Message-State: AOAM533nv05khVBHk3gj4OWPr/CxPj71Yc2pC36Gd5bNPAiE1bgXWXdm
 ujYh1PAYzdSQgHMXpyJ6dOxZ7rfvVVE=
X-Google-Smtp-Source: ABdhPJyNmHFRMK9uygHsztVkMbFivANGsvUsvOUTnKLKQRgPOdRcPbYJQChMsD8bzQNoRyyE3Ntmww==
X-Received: by 2002:a17:90b:782:: with SMTP id
 l2mr15185951pjz.91.1606740493298; 
 Mon, 30 Nov 2020 04:48:13 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id q19sm16625918pff.101.2020.11.30.04.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 04:48:12 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme: elaborate ns-descs failure warning in detail
Date: Mon, 30 Nov 2020 21:47:46 +0900
Message-Id: <20201130124747.14725-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130124747.14725-1-minwoo.im.dev@gmail.com>
References: <20201130124747.14725-1-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_074815_641489_ACA8ECE6 
X-CRM114-Status: GOOD (  15.09  )
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

Add nsid to figure out which namespace id has been failed during
ns-descs commands.  If we don't print it out, some of duplicated
warnings which don't have much meaningful statement can be seen
like:

[    1.321031] nvme nvme0: Identify Descriptors failed (16386)
[    1.321948] nvme nvme0: Identify Descriptors failed (16386)
[    1.322872] nvme nvme0: Identify Descriptors failed (16386)
[    1.323775] nvme nvme0: Identify Descriptors failed (16386)
[    1.324687] nvme nvme0: Identify Descriptors failed (16386)
...

Also, this patch prints status value in hexadecimal format rather
than decimal for better readability.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f42ed266bd7f..ded6376facbe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1357,7 +1357,8 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 				      NVME_IDENTIFY_DATA_SIZE);
 	if (status) {
 		dev_warn(ctrl->device,
-			"Identify Descriptors failed (%d)\n", status);
+			"Identify Descriptors failed (nsid=%u, status=0x%x)\n",
+			nsid, status);
 		goto free_data;
 	}
 
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
