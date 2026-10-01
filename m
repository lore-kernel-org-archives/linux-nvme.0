Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753D1CA5FD2
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2026 09:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wWOahLGqSABk/Bl8Hm3IIeG0DfjrEOdUVN6u43pWVOk=; b=BJEe8MTgp94jAwivw/sBnjQrXY
	Ei012zUW7nh99VngsRvcVeS4HgVO2/0ckzpbUTzMQDJMKPPPDhFmfvbqYTcRdwnKluXJPPwUAQTaF
	CfgUA520bVhCEbZar5tqjbQK5mhtdMU7EgGkL40xw7f00UYfa3Ph5zA3/Dkq53J0a0lglNa6tsCy/
	uYdnuRCrKvEFBfQiT0IqWbeQtC+ZUb5Ckq5MekOQ+cspgUE/Jsnfh/N+Wb0EkYsPeWdpaA3eNTpV2
	QpNoMqRSpeWeCQNOmGb4cco6pKJkWT/eRnrJzgk3nATU6rcQ5U+v+eMipTIQ0AovdWRSL4dQPjaf0
	iaim/HbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCDPZ-00000008QDs-3Q7s;
	Thu, 01 Oct 2026 09:49:09 +0000
Received: from mail-wr2-x18.google.com ([2a00:1450:4864:30::18])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCDPS-00000008QC2-2LiK
	for linux-nvme@lists.infradead.org;
	Thu, 01 Oct 2026 09:49:04 +0000
Received: by mail-wr2-x18.google.com with SMTP id ffacd0b85a97d-48b024549a2so1232571f8f.3
        for <linux-nvme@lists.infradead.org>; Thu, 01 Oct 2026 02:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1790848140; x=1791452940; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wWOahLGqSABk/Bl8Hm3IIeG0DfjrEOdUVN6u43pWVOk=;
        b=OdCZj7GE9VBl0QKC2Avt0zpV0V3UpApncHVZEmMwmBgBMnHfqjqCIOYMjYOqS4DHgd
         nI/2jNDai2e1qXrAVb1QgRTFOsQxxgMJeMP72DhxEVEeLiFeFB/rMcsXg/O6UcsJ4qzQ
         +fwkl0B9Ux0XVuAqgoT0I6wbirZlecga8+8Ftkng8oa5NWk4UeukLo4Z4TM5tfEozPTN
         imA/3dgXtAFLyQVbdMYSfiQD4mK2fnYDYDHr//ut6vhmeNOHDYzkMWAnpUNS7+xUovJt
         ce70XEi7YqebLX/t1SzS0TW4BVpmiMK5Li+4aqEQcx4ge0gR3xo1UDwaooJgPxbO0W2r
         Wf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790848140; x=1791452940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wWOahLGqSABk/Bl8Hm3IIeG0DfjrEOdUVN6u43pWVOk=;
        b=HhbSxUD6zuaI5Xu/56ywen8Af+cUL0YHp5j2H2zkXOxctU0Y/Z157/NRwG8y9/tn0P
         zblnK5ZJkqB7V+f8dwYxf9Ct1H0qzLvALZ1DKIQn3kcN5zI7cdYRDRzvhrh83Z3viSjV
         YJYaY6l89y62GADY+WHqlB+FH1zyzjNqWjzmR9U/B6BtLTt9aBr2dgBeEH15h0AhpTzQ
         +iczdQ66+dRQGjykaqLw7TnKh5crErKgvFOCeNlmWcvOqzQKMQWJsQ/cZiZR7xbD7KG7
         rN7D2SPAG/TNrj3TqNBgEXPl6OqxWLId3/VLPGlGbuyS4GKtKCW35rCnm6cXLWUtBiPl
         yL5w==
X-Gm-Message-State: AFq9FYKjA35luFs3nHBVwNU5QHNHwfXelJTtIpOvQdFrh4BY4kxIFoQ9
	entRcCARxYwwWoDB2B1+JqJfBgbx07OHPh84Xl6yYOj2ApALpvprjR8/JD/lXJBSjIkmYvIFwQD
	XY23Sqjh0jQ==
X-Gm-Gg: AYBFou0i6oGYYzPxEd9ULFemPdo+G/B81QbT+lSbLWJQ+cMvWUy6ZHh0F+/lHBzrzqi
	ydIueDOjGF7XzZk/IZ4kYaqpuL71wFG7suc4vL/mg4CCwkgucY+6yBVlwleQ4dD/mvN3Xfh5HQw
	zwoupPRIrqffCm0pTjnJV4/RSSujSLkKI8bcEQXrFbqlI2R4dGxpFUK25O2KYsfa42SiymanIUZ
	xb0ZMhvFGQRErtWXNbBmpJUwCe76HjbbISjglZsPC9Qa1AiZtzao4p8NGs8vNR9G7QL+hpWSiBh
	GXwynyfKZL9eAmVtxHMEBKdSiGVkyUPEIuq7Jep4BwA3535bZh6s4+YCx+nWYpTPdDUhWjoLd7e
	qsW2iF1EPl2NS55wdRvzKx/yfZChI5PJ3azbw7pnqSQzh011yt4iKEhDNBm14jJNOYkumr6PUbC
	Z02DpQUpXa7cT+6RGRS96ZTnQXe8Y77M5ZbNoaHe2UP898Pru/WakQaqTDjmcGZl1g67mAVFWhN
	HsiWyVPo2IWf2uWn1kBezg6f74cvMTygiM=
X-Received: by 2002:a05:6000:4811:b0:488:8546:d0b2 with SMTP id ffacd0b85a97d-48b0253956cmr8652279f8f.51.1790848139833;
        Thu, 01 Oct 2026 02:48:59 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([83.71.242.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0db6de0dsm1938341f8f.43.2026.10.01.02.48.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Oct 2026 02:48:59 -0700 (PDT)
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
	Krishna Iyer <kiyer@crusoe.ai>
Subject: [PATCH v4 1/2] nvme-multipath: fix path state evaluation for failfast and ANA
Date: Thu,  1 Oct 2026 02:48:56 -0700
Message-ID: <20261001094857.74567-2-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261001094857.74567-1-kiyer@crusoe.ai>
References: <20261001094857.74567-1-kiyer@crusoe.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261001_024902_642365_B922BA5E 
X-CRM114-Status: GOOD (  18.25  )
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


