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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386E3C64E8A
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 12:48:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A85F720691
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 12:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tPrAsOmn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3CDcRh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85F720691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/FN4sqI4b1SnLORZl9nyeUI/6bMXiNlTH8mlNmFgjyA=; b=tPrAsOmna6bnjwTFfeoG0wXfrn
	I7JVsCznSAxJZiZP7s9R30/3QS+p33inX5BQ+q8tevex9lK0sMIEtgbRCdTvBExnlt2fnm32iD+ZZ
	FF8y+TUWakQRf5IAOS/3ogEREtgp5xXixYF/ttBVbO7Mk8DdUo29sQIv/JZt9CBotCUjTOTrj8jU0
	HCaV3iaskEF71RSbUPwzPB3WkAFAqPxEpjS2Iba0X/ulxSDOq9nLgcIktqX7sjLL0RejoNgi31Ifj
	FMXdbazdvWfOg1LqhJIXJwAspqs+qpwUhdOu23Q+POE+LkKsl2QkE3FYxkDhvX689wRbV4oC+DPVf
	7+fd1hYg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjibN-0001MN-LT; Mon, 30 Nov 2020 12:48:21 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjibK-0001L8-HZ
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 12:48:19 +0000
Received: by mail-pf1-x442.google.com with SMTP id x24so10325224pfn.6
 for <linux-nvme@lists.infradead.org>; Mon, 30 Nov 2020 04:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=D9yY8cqEbmiznhuEKu5Kfj9u9L3gq5yyEax5Fj5lYcw=;
 b=W3CDcRh2gxRP15+mLlmYbg9zO0l8ujZOPXMX2AtK7xElrliXA92Q+xY5kNBW/wiiwb
 YSTsES85synkV7/JumgaYKqdby3ZoKHtbDo7v1gqOsRSYdQi4SaEdEZVVnP5BEkz7/R+
 Diw1GPO5pyXLPEZO2oHiknW2HGYX7vQbRL+B/g+5AA2s1COYVm7pLn+RajtoVqV6wPSP
 wnFXQe5xyl/gmt0pJQ0T73+mq/7qkP0G9WQB4bbu1r1Q2zyaZFsFz7CcomJ6x0ScPXYI
 ChVZvOw7OLkSDmXJnLF3NZdpzqwKwqx7Z4FTVui3z5op1vao17yhUeSMKNRXhwbCsjgQ
 OSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=D9yY8cqEbmiznhuEKu5Kfj9u9L3gq5yyEax5Fj5lYcw=;
 b=iLUBSMXQcWkiCjoY0DUCycM661/ScC+1coj1mHkewvBnxaXAeaU0UpKpG8WNuy3Ewm
 W0B+dksgaP4KwSF1WzpN7SdZmx9cmO55aKHPWDAan6oKULqYI4mWNfDif5HNRd4DSRd7
 9jvMNLUBgk3wqu+TfRJUZ85TxwQ3L/CpS4sraa5MVtjSE7TjntIHkx/dO7NS9GhtHxiA
 8yAO6m79DjynO/AlTXNK0wH6w4f6UApHzMRI1Wjc7FqBdE4Z4Os0jFeTTN9ag9E+R0QH
 US+Q61GzZxJ11x6oPvJ7edIY3P4hbUb9b/ctH3KjD+sW4mml/3YXS3yU7+J2WjGZ7Ut/
 LaOQ==
X-Gm-Message-State: AOAM531REk+tLfRKsDY4p/lseaPo6Eevx/9F7UJe4pbY0P1HOo58zmKH
 gnHJKv6mY/yZ1bFqWvZfEoFRhu66Jok=
X-Google-Smtp-Source: ABdhPJzKkq9tlfG8xLQZ9mECmiD7uY+MbYYx02JfHq4BrpLY3zPzILbxI3Yvg4mbrMbO+CDT+ugM9A==
X-Received: by 2002:aa7:9198:0:b029:18b:3835:3796 with SMTP id
 x24-20020aa791980000b029018b38353796mr19183301pfa.9.1606740496302; 
 Mon, 30 Nov 2020 04:48:16 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id q19sm16625918pff.101.2020.11.30.04.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 04:48:15 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme: Print warning for list-ns command failure
Date: Mon, 30 Nov 2020 21:47:47 +0900
Message-Id: <20201130124747.14725-3-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130124747.14725-1-minwoo.im.dev@gmail.com>
References: <20201130124747.14725-1-minwoo.im.dev@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_074818_650457_54325C49 
X-CRM114-Status: GOOD (  18.18  )
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

During the scan_work, list-ns command is issued to figure out which
namespaces are in active state.  But if this command is failed, it will
try to scan namespaces sequentially.  In this situation, we don't see
any warnings and don't even know whether list-ns command has been failed
or not easiliy.

This patch prints out warning for the failure of the list-ns command.
Then we can find easily what's going on in the scan_work like:

[    1.108399] nvme nvme0: Identify NS List failed (status=0x400b)
[    1.109583] nvme0n1: detected capacity change from 0 to 1048576
[    1.112186] nvme nvme0: Identify Descriptors failed (nsid=2, status=0x4002)
[    1.113929] nvme nvme0: Identify Descriptors failed (nsid=3, status=0x4002)
[    1.116537] nvme nvme0: Identify Descriptors failed (nsid=4, status=0x4002)
...

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ded6376facbe..64905bc83e9d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4096,8 +4096,12 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 
 		ret = nvme_submit_sync_cmd(ctrl->admin_q, &cmd, ns_list,
 					    NVME_IDENTIFY_DATA_SIZE);
-		if (ret)
+		if (ret) {
+			dev_warn(ctrl->device,
+				"Identify NS List failed (status=0x%x)\n",
+				ret);
 			goto free;
+		}
 
 		for (i = 0; i < nr_entries; i++) {
 			u32 nsid = le32_to_cpu(ns_list[i]);
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
