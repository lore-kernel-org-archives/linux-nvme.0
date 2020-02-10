Return-Path: <SRS0=obgt=36=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACD1C352A5
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2020 18:38:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A20C20656
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2020 18:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Me6t/o5P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lightbitslabs-com.20150623.gappssmtp.com header.i=@lightbitslabs-com.20150623.gappssmtp.com header.b="CV5KJodG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A20C20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightbitslabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=QcdZmZp13NEba++BV4UtouuqsPnyR8p1VFbCi1yi/4M=; b=Me6
	t/o5PlXjLoFOPULO3lfyEpmTvo4xKd1AHYegFsS5v4bIjFRbe+szjMQM5x1gxfAr+wefjarye7Jl4
	X+BjSyljphBcyKoZeYZV6vaHAWwj6ItW8VEp4korhX99TBa8sJg2vWC8Mkrwwnfyrw2Hv7BugGEK+
	30IS6wIL33GceMnqjUeG1Gbq8QH6Eyq2Tp/XDQFFzqMLEcGAURr1gwRuvms246O21GNH1LPX7Bs/T
	bXlSXQthViMuAsmM1YqIXR9UhDT7jtxKK+2XY7LXKzWQhitsmGYN2lk2YzflQWlS0mnkfnGz/5rO8
	9ZRZTo1ESJ4DjGRAKzzNT2i2yr902vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1Dwa-0000CR-Jq; Mon, 10 Feb 2020 18:38:04 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1DwX-0000B1-8s
 for linux-nvme@lists.infradead.org; Mon, 10 Feb 2020 18:38:03 +0000
Received: by mail-ot1-x342.google.com with SMTP id j20so7388926otq.3
 for <linux-nvme@lists.infradead.org>; Mon, 10 Feb 2020 10:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightbitslabs-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=b7a1RKgCX7uN2D3HDme+oeSzxg4iOeuYGaH9JVM69Uo=;
 b=CV5KJodG5F+6qbelANSja2G/av6yO5hBKnt3qtwwGmWWOHS4GohYwSFApkLh/83vv6
 YZ1fYQs/LB4u0YKjAwgcltL9SNbwYe0rYzr/fMw9fjyE0i0Pe+ZrqUzev0EJAVn0wDDO
 7n75d+EozJIVphVyW3pnfCdJuTxmYt89rGfjqvOdkAsel8tUG+CY6UUSXtpaY7TeTsOn
 o1i7tjhUPBKqjmiFmtOEx1qL/mKo3dq2Bpa/WIolFfS33GKVzDp9KdtFJi9Efi6I8hYl
 rqy1NLpRnyPGXjNgdxNVpsMPmbEZjT4HA9LRt7bMk1hulRoNqMqXWCw2bPg1qjCiZ2w5
 EU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=b7a1RKgCX7uN2D3HDme+oeSzxg4iOeuYGaH9JVM69Uo=;
 b=c9yHUNPC6xp0sJG6Q2FWq2ZdvU9peItw2ZCFNq6iuzq0sE8rfd8jo0okvV1ICj02iL
 7UNlUNn4edrbHeXPPqtsQ5qgxiPjCDtgYuVqhD7zMpgiQ2fVhVq+8m4zc0mNGlMnls8r
 l8QLRusoblOIJRh0ssFyiZPmnO+YjVvfTlp9V+I/OCnUyl+YKD3koUFhHytalexqniBB
 YD3JfNI50h+Nm5L1fKrn/fn8UdNm9eiPDWhLtIaGVEk2hLHBjVLoZUYjtgOdJNOEy4ZJ
 S9B3ad+HBy4CPtDJDznB3xWnjKtk8hPx7r5d/sUb45o34yBbd+48BceDqot1r9WBrA8r
 cUvQ==
X-Gm-Message-State: APjAAAUijrmMN4aPjdCXD4NQOM5zCVW4ris5LOCkCIrjL8rjJUaMzSJT
 PtkAwlzgDQ396QbcIrDbvYV+yn0pqmc=
X-Google-Smtp-Source: APXvYqwhyuOIa1P5ZSrTcTRGWywK9pMWoW2Y1LB+S+utD93UW2Qo5W29cViWCdPkHVkYjJ/N1nEc6g==
X-Received: by 2002:a9d:4c8e:: with SMTP id m14mr1963963otf.245.1581359877336; 
 Mon, 10 Feb 2020 10:37:57 -0800 (PST)
Received: from anton-latitude.attlocal.net
 ([2600:1700:65a0:78e0:bd79:a87f:18e2:64cc])
 by smtp.googlemail.com with ESMTPSA id j13sm301865oij.56.2020.02.10.10.37.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Feb 2020 10:37:56 -0800 (PST)
From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, keith.busch@intel.com,
 sagi@grimberg.me, hare@suse.de
Subject: [PATCH] nvme/tcp: fix bug on double requeue when send fails
Date: Mon, 10 Feb 2020 10:37:18 -0800
Message-Id: <20200210183719.32410-1-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.14.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200210_103801_743122_F8478495 
X-CRM114-Status: GOOD (  12.22  )
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
Cc: Anton Eidelman <anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When nvme_tcp_io_work() fails to send to socket due to
connection close/reset, error_recovery work is triggered
from nvme_tcp_state_change() socket callback.
This cancels all the active requests in the tagset,
which requeues them.

The failed request, however, was ended and thus requeued
individually as well unless send returned -EPIPE.
Another return code to be treated the same way is -ECONNRESET.

Double requeue caused BUG_ON(blk_queued_rq(rq))
in blk_mq_requeue_request() from either the individual requeue
of the failed request or the bulk requeue from
blk_mq_tagset_busy_iter(, nvme_cancel_request, );

Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/tcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6d43b23a0fc8..f8fa5c5b79f1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1054,7 +1054,12 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		} else if (unlikely(result < 0)) {
 			dev_err(queue->ctrl->ctrl.device,
 				"failed to send request %d\n", result);
-			if (result != -EPIPE)
+
+			/*
+			 * Fail the request unless peer closed the connection,
+			 * in which case error recovery flow will complete all.
+			 */
+			if ((result != -EPIPE) && (result != -ECONNRESET))
 				nvme_tcp_fail_request(queue->request);
 			nvme_tcp_done_send_req(queue);
 			return;
-- 
2.14.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
