Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4884BC54FCE
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 18:24:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E892051A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 18:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kQWkU5LY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhaSns2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E892051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=5eXywYeva0aqxXU5Lg3CQmLI1BPBNEXCDRgIVnsmI9s=; b=kQW
	kU5LY5YbyKz/CklHuUrGXbZJRIFbRH4KcVGQyUStd5WR3YhguYAMDHiR4JQdG/KEzmPIVbmwpBKZU
	3zQHniV70Rp2LZeUNsgBfTVyebW4i/+BC+wsaPKLhOcLtTN/QV4tI5J1VdvQBfpWXXupvmk9xNEkd
	P7f1A/3FqqArqHlBrG9nxlYCsKPAm+lLp90UFLoxdkWkY/4pQkFpFmi2SBjw/ZPaZ3ehnioAxNk2v
	1k1oXTq9kKYvMG6Bf8njAiR4Uej8W0rGHOMiGMDzVEiZyF9HBn14nM3WoN7ym0Mctf+sG9MzKOii5
	L5qyxezipYHcnowcp52bpBa5A16c2bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGRjx-0006Ez-V0; Mon, 23 Mar 2020 18:23:57 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGRjt-0006Dy-9B
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 18:23:54 +0000
Received: by mail-pf1-x442.google.com with SMTP id h72so5684199pfe.4
 for <linux-nvme@lists.infradead.org>; Mon, 23 Mar 2020 11:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=nTfUmVUYCh35GIwC+cQp9S24IuXHaD8ADVR/tUaCHh4=;
 b=NhaSns2d49Hz2dbuq93wJRDzZmkkvJz/LDe2GbTFdwsHL1P4WnjKRRHCk2Q1YpXMP/
 5N/STNii3bPbZ8DknCUZuRBMPW9cHFzpkqovJwllYbDDe0yO8/a06sdVN3NnAzTi46cO
 mVkj9vMt2/9Bf+sG0n0SGtEi0YvYui2PTPFIAnijKpzuBpUkQKZl+pvOxSxHB/8LJNQj
 T6993Y6EZqBKI0cIP0Y41uIV5pW70L8vnHg3CLu1/qjJucPhaexNsZ03eYdfiH6XXkla
 JuLI52CthoQTABMS8YT8sQwkH5sfdMirJITeAD4gf63nIBdq+9I16gySXiE6nUar7UEj
 uGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=nTfUmVUYCh35GIwC+cQp9S24IuXHaD8ADVR/tUaCHh4=;
 b=W0JdpvjoHFwjuDZHt76HFvvB7w0SLfJFJ1tpSBmIqx1LAXsZbcWnzQVEYQAbAqCMpc
 KEzTM3r2DURiVzOaEK5F2cguEn2WAiz+BuSZafXOR1SHdKMiIdZi6eIounJ+EMzsADON
 fBYk1/L1pJkVg0Aszexckqunu1qqWWsjJ/bgfdeIHR8/NVjHABVd42YGt4UusKIjSpe+
 MRdmdjN8jRcK3JqL6um8sJmpLRmDIkFDs3B6CtffTyXmZcpkmQkZmNo2Cu7KqUQ+hRkx
 ABU69XND+YtQukro3odAJ6YxnfXsdb4iEcF/dWZJgbXf1LjnxT1cCZ9IfK+gD7OxsEGU
 1vkw==
X-Gm-Message-State: ANhLgQ3SYfjKe1+C1uC5XxMI9sXqjsEJ5KXY4JONrWXAYx20Kt8rSTBd
 Nnjz2q4/4uyOQr3caUwN74w=
X-Google-Smtp-Source: ADFU+vuR5UNMG7iJXu/V2a0mCllyPnYkO1GVX6uXEfkedqlfzEaPy0kbekxuKhsZyc6YMJYgZJqOwg==
X-Received: by 2002:a62:7c15:: with SMTP id x21mr26528164pfc.132.1584987831280; 
 Mon, 23 Mar 2020 11:23:51 -0700 (PDT)
Received: from localhost.localdomain (M106072039032.v4.enabler.ne.jp.
 [106.72.39.32])
 by smtp.googlemail.com with ESMTPSA id bt19sm266854pjb.3.2020.03.23.11.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 11:23:50 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-block@vger.kernel.org
Subject: [PATCH] block, nvme: Increase max segments parameter setting value
Date: Tue, 24 Mar 2020 03:23:24 +0900
Message-Id: <20200323182324.3243-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_112353_320768_E02CC5AD 
X-CRM114-Status: GOOD (  10.86  )
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
Cc: Tokunori Ikegami <ikegami.t@gmail.com>, linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently data length can be specified as UINT_MAX but failed.
This is caused by the max segments parameter limit set as USHRT_MAX.
To resolve this issue change to increase the value limit range.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
---
 block/blk-settings.c     | 2 +-
 drivers/nvme/host/core.c | 2 +-
 include/linux/blkdev.h   | 7 ++++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index c8eda2e7b91e..ed40bda573c2 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -266,7 +266,7 @@ EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
  *    Enables a low level driver to set an upper limit on the number of
  *    hw data segments in a request.
  **/
-void blk_queue_max_segments(struct request_queue *q, unsigned short max_segments)
+void blk_queue_max_segments(struct request_queue *q, unsigned int max_segments)
 {
 	if (!max_segments) {
 		max_segments = 1;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a4d8c90ee7cc..2b48aab0969e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2193,7 +2193,7 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 
 		max_segments = min_not_zero(max_segments, ctrl->max_segments);
 		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
-		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
+		blk_queue_max_segments(q, min_t(u32, max_segments, UINT_MAX));
 	}
 	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
 	    is_power_of_2(ctrl->max_hw_sectors))
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f629d40c645c..4f4224e20c28 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -338,8 +338,8 @@ struct queue_limits {
 	unsigned int		max_write_zeroes_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
+	unsigned int		max_segments;
 
-	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
 
@@ -1067,7 +1067,8 @@ extern void blk_queue_make_request(struct request_queue *, make_request_fn *);
 extern void blk_queue_bounce_limit(struct request_queue *, u64);
 extern void blk_queue_max_hw_sectors(struct request_queue *, unsigned int);
 extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
-extern void blk_queue_max_segments(struct request_queue *, unsigned short);
+extern void blk_queue_max_segments(struct request_queue *q,
+				   unsigned int max_segments);
 extern void blk_queue_max_discard_segments(struct request_queue *,
 		unsigned short);
 extern void blk_queue_max_segment_size(struct request_queue *, unsigned int);
@@ -1276,7 +1277,7 @@ static inline unsigned int queue_max_hw_sectors(const struct request_queue *q)
 	return q->limits.max_hw_sectors;
 }
 
-static inline unsigned short queue_max_segments(const struct request_queue *q)
+static inline unsigned int queue_max_segments(const struct request_queue *q)
 {
 	return q->limits.max_segments;
 }
-- 
2.17.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
