Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2408CA6007
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2026 14:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KrLj7myEvmL1NDZSoo6YVPO8m4//5te8foqX8lpo05U=; b=3J9EzQ3EZocIKJognCPcAdoWVP
	YfKMMy2MoE1276aTkmTYcSdETOm7ipGXosCTpAIn44WKD/FT7zd/wnDnGS+1NCAbkUyMWoEPaqDlP
	08Z4eN0w7gXXnXmal4TmGStN4ic88/aw0RbVCCsZFhb8cX6oF+nKYjHlV9GV4hB2KYrkoJWnUzqXy
	ccUjVNcTG2IrEDG78ywEBEqVdyie0T+GQmmw942uHmj2AUp5wW4sXxKff0w16MdOn0m6FamnKJoyr
	WnSjzb+PyHqz8/v4t5Hws0Xx4yW44fY4uVqvp7KPgbReTO/lNhLd3hbwgs9VTUmWoTsAEMycahNpC
	gJVwaXKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEosz-00000004WIO-21Sd;
	Thu, 08 Oct 2026 14:14:17 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEosw-00000004WGo-2yL7
	for linux-nvme@lists.infradead.org;
	Thu, 08 Oct 2026 14:14:15 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so44475735e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2026 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1791468853; x=1792073653; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KrLj7myEvmL1NDZSoo6YVPO8m4//5te8foqX8lpo05U=;
        b=QVHGWDpfd0lov5iqpGK0lvG660obysIfAqwB9lorugjtf4otW6+xbdfn/Pg40sgnUQ
         WHG6FpsKiB80xegZYETcOpmfU/H7nLfNwwGEqLd9l7Q9M1Po6H0SybdNjT9XrkOs+BkX
         JqzaBBte7B8Xo6+98eyPjcI3FG+sm2OjHeqpCTBxkvm1lDbcby5L6Oe501rbTbDed6SJ
         zVT60ZLwNNCgkeVprWmkoUSehaBbJAIbOhonkyDGiDssMMGPKRFp2H/1YmEQZrUiknHC
         EK1KSVb5Q5LGtgHJkVaSpz4ukn8yl3eUsb209Oie0ogbDvz7ZWTxB02rD/IAbmYalIlB
         NqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791468853; x=1792073653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KrLj7myEvmL1NDZSoo6YVPO8m4//5te8foqX8lpo05U=;
        b=zGTgoA/cxCWLUKAXCBYgqYSMhQtMRYUOsxlmnlRtFDiH/vBcpHm6iUlNZhDwpG21ql
         nSjoRqILMxgzmMdeblJIlBcPs2HO9vZZtUrUVPHOBEAwUpAEXshxRj1zKJdS91tkVMfI
         gq8KKkcTgMNz0EOthLqfsNxlGFyO+tI+7Bu4i1R/oxrY6uvxrFU3A6BxAmwW2/XpgaaT
         bH5Pv2LeLkOUyKkyC6B6BSt+EYk/05RLXrtFwknXyiMg6RM3gsbYg8k1oGetK/pH8BrF
         lD3b1jbntiKplglL8NdxkqmKbfT0/wxfsmiZBf54y8VJyCue9Twgh2aT8zB5E4CzCJs/
         4zNg==
X-Gm-Message-State: AFuF++nn55oCmSLLDxa6Up6h1bwpLqgJOZye7rkFHL7BmnfBMzg6RdQP
	xAup00vOxHUlfuFb635tpC2LATpbhWAtRL54Z7yRp2Bysw2uGcT3CxYmIrG2f5Q7TwI7fln9eXS
	q11DZjrtKlw==
X-Gm-Gg: AYBFou3Wv8zY3JKLYjGKxJBGxDpWD2Gj3WhLBBHgKCqB0r6YNLj1whb6eTD5wrrG13H
	siyblkyCS7dFNaEx51jJtZlWkCVsMjuGvlRsEnrBguKszQ98x3mU6o8Y2KuJGJv3bfS/DENPXQt
	+eNY590ldZwNK1RYhv3Mpy8DTDH95Wg9wzrcwIKHo6cpx0VfJShkWPFHATLfAU0v91XCAEjN6tE
	DaCuGxftXRfRBoeeVZt3MsdJYKFHBECtUmHwTTptldiuLK6LjhbN30FujsqqSvxB2tfiNCkhwOP
	hASUPhvNSYQcoNHS4HH+z5xPUypRaArVlLEPeJe2W176onxy7GfYRRw90J2vKouRR6QCyLWqeel
	eTtD6j/zeSuDRMakfuN/VtWZBycnaG3oQtIVLscknzjUwFhXNyL1oUQhfd1Il4XWXHIbstn4/zj
	2z1wUkUW0s/yl2QSzbrVCmVpvLP75ZJwUpaEql+pLJ1p+6m6I9jXtaGCK/6+UnBElkw6/ZHEsj9
	3JunZbW6LpTeffi8KBdQS1Oqln68mW8MFJB
X-Received: by 2002:a05:600c:8b6e:b0:4a1:78da:d271 with SMTP id 5b1f17b1804b1-4a18064be59mr101916045e9.30.1791468851533;
        Thu, 08 Oct 2026 07:14:11 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([80.95.100.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a185d914fdsm113358935e9.7.2026.10.08.07.14.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 07:14:11 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nilay@linux.ibm.com,
	hare@suse.de,
	saravanand@crusoe.ai,
	sjpark@crusoe.ai,
	Krishna Iyer <kiyer@crusoe.ai>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH v5 1/2] nvme-multipath: fix path state evaluation for failfast and ANA
Date: Thu,  8 Oct 2026 07:14:06 -0700
Message-ID: <20261008141407.22992-2-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008141407.22992-1-kiyer@crusoe.ai>
References: <20261008141407.22992-1-kiyer@crusoe.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_071414_772302_2ACF5CAC 
X-CRM114-Status: GOOD (  17.48  )
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

nvme_available_path() has two problems that keep I/O queued when it
should be failed:

1. When fast_io_fail_tmo expires, NVME_CTRL_FAILFAST_EXPIRED is set and
   the path is skipped, but the function still falls through to
   nvme_mpath_queue_if_no_path(). If delayed_removal_secs is configured
   the I/O is requeued indefinitely, defeating fast_io_fail_tmo. Only
   fall through to queue_if_no_path when there really are no paths;
   if a path exists but its failfast timer has expired, fail instead.

2. A LIVE controller counts as a usable path regardless of the namespace
   ANA state. A path whose ANA state is inaccessible or persistent-loss
   cannot serve I/O, so it should not count as available. ANA change is
   transient and bounded by ANATT, so keep queueing while it resolves.

Also kick the requeue work from nvme_update_ns_ana_state() when a path
does not transition to live, so parked I/O is re-evaluated when an ANA
transition leaves the namespace inaccessible.

Move nvme_state_is_live() above nvme_available_path() so it can be used
there.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 11871f5f18c2..0d6c05f0808b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -509,9 +509,15 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	}
 }
 
+static inline bool nvme_state_is_live(enum nvme_ana_state state)
+{
+	return state == NVME_ANA_OPTIMIZED || state == NVME_ANA_NONOPTIMIZED;
+}
+
 static bool nvme_available_path(struct nvme_ns_head *head)
 	__must_hold_shared(&head->srcu)
 {
+	bool failfast = false;
 	struct nvme_ns *ns;
 
 	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
@@ -519,10 +525,16 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 
 	list_for_each_entry_srcu(ns, &head->list, siblings,
 				 srcu_read_lock_held(&head->srcu)) {
-		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
+		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags)) {
+			failfast = true;
 			continue;
+		}
 		switch (nvme_ctrl_state(ns->ctrl)) {
 		case NVME_CTRL_LIVE:
+			if (!nvme_state_is_live(ns->ana_state) &&
+			    ns->ana_state != NVME_ANA_CHANGE)
+				continue;
+			return true;
 		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
 			return true;
@@ -531,6 +543,9 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 		}
 	}
 
+	if (failfast)
+		return false;
+
 	/*
 	 * If "head->delayed_removal_secs" is configured (i.e., non-zero), do
 	 * not immediately fail I/O. Instead, requeue the I/O for the configured
@@ -887,11 +902,6 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 	return 0;
 }
 
-static inline bool nvme_state_is_live(enum nvme_ana_state state)
-{
-	return state == NVME_ANA_OPTIMIZED || state == NVME_ANA_NONOPTIMIZED;
-}
-
 static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 		struct nvme_ns *ns)
 {
@@ -926,8 +936,10 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 		 * is not live but still create the sysfs link to this path from
 		 * head node if head node of the path has already come alive.
 		 */
-		if (test_bit(NVME_NSHEAD_DISK_LIVE, &ns->head->flags))
+		if (test_bit(NVME_NSHEAD_DISK_LIVE, &ns->head->flags)) {
 			nvme_mpath_add_sysfs_link(ns->head);
+			kblockd_schedule_work(&ns->head->requeue_work);
+		}
 	}
 }
 
-- 
2.54.0


