Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF53C5321D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 14:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=D3rBxFKcTir72MMBmPsMr1mg6s2sT/TAucrklFe8r0k=; b=c86zIBI4/EutZEImjIk9//8eHd
	ZrTQi88VwryoQIUqHsGu9dUWIYEde94D45ROUvG6FO7NNFkA59oaHE8b6bp5TAQB6I21Vf4PBlOTW
	g4rziHh0qXdUrvykotCB3R+TL5gPsLhbotKPUMajL2Rzh3AFmoBKYgOOINJLxwv0zPcxk/VrD9CA2
	V2NXCqjCqi4kiVjwa7sDVQNTZKU90XLrIFXuZ29pL3hm1nSIMsJ6bznsSR+PN0/MwBMKDyKALcqCh
	P9w4ZSELiXJHVPgoKKGqcYMwrWOfVxTOAYGhqGnfbX5z+ooX1dFwx5Gmu2l3y2RlIM2wnIe+Y7fP3
	gJK9bWeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siacV-00000007dMK-0POB;
	Mon, 26 Aug 2024 14:22:59 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siacS-00000007dKD-0k4x
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 14:22:57 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so38772915e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 26 Aug 2024 07:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724682173; x=1725286973; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D3rBxFKcTir72MMBmPsMr1mg6s2sT/TAucrklFe8r0k=;
        b=PsRkiW3lRdXd/c9RSo939xFaJKCLMm3Z65nNV/IpajdKLcBGq5rcoBGpA5rVmYBy5P
         FzjhYJ2NvIsNaDRXFclYKDon6GK38VphUZviRNCasXcyhJBEBgFC4EXDHeRioR9ahdb5
         OKtE6lNUdErLbsoMr6axYS/zABmzL+55A2faLWS9isGW2530XK7i3MLeB6iwn5fSyzVq
         J77F2UycIIRaykJ6pr7NFM61HkA1YPmk7Lylpue1iRnlZPODktjfYwBWgT4jg0mStFD0
         1ULSxKPMe9CSz93ZfHLNgkHsJhKCSjM6F6aIoo/uxxqyv55+lVxywd9PBdW6Ux7+FCAw
         ezJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724682173; x=1725286973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3rBxFKcTir72MMBmPsMr1mg6s2sT/TAucrklFe8r0k=;
        b=UzQd+6EQQakqJkesmL/8DQQkUwxAi+3egYQQS1KSBGdG9XWgj48cvdWid1NB9AtvnP
         AJ2VNNjG0G63jGmqCEYqdb6I3WKl6I9Kcl+4hxxOor7UAFexDKKEEyaRSKlOpex6ILS+
         VMnj1eKse3vFskcTY2MV6GHQ2rs8L6rN003NSClOxoWx9EYfknJ+CwibjpM3HPuzZS8L
         ybhfwMkoZE+kZ4bRrsRcN3o76Ts8Bmr61bJzt7Go3PI6ept41MBY0gOr+hvdbRXvCJVd
         Kjc+a9vBzIjXCdqQcmZJnMYxhiCuvHo4qvfYgqT6r+vNLi/eqTWxaEPF2SgFJq5eaCwS
         uvwA==
X-Forwarded-Encrypted: i=1; AJvYcCXandGpNQVGGvi9GaXtDLz9FYyXAWanMl3AqqoaPDMNCK7GUdQ7I0jPwLEveTJdNqE4JebCWISQS8mw@lists.infradead.org
X-Gm-Message-State: AOJu0Yxu4NHK9Ro2tXrwfvajr4xR8tjiI1bCiJeOcfejNepElJK13gCS
	TDNzY7nDmDBu8Eq5ox/151m1OkCVHGUzRf/AD6B9yIdBYyTsQCRZV+Wj4SQHmuQ=
X-Google-Smtp-Source: AGHT+IFTt5foejd01x2kS49Yq6B2V85sCMj9zl+uIb7PdjpHDMf4GDRRVXBGqI0VV+mDFAMaS+9mww==
X-Received: by 2002:a5d:456a:0:b0:371:8f26:67f1 with SMTP id ffacd0b85a97d-3731186848fmr7559044f8f.33.1724682172217;
        Mon, 26 Aug 2024 07:22:52 -0700 (PDT)
Received: from localhost (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5c04a3eac85sm5682783a12.48.2024.08.26.07.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 07:22:51 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Niklas Cassel <cassel@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2] nvme: core: shorten duration of multipath namespace rescan
Date: Mon, 26 Aug 2024 16:22:41 +0200
Message-ID: <20240826142241.53601-1-mwilck@suse.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_072256_242051_55102A88 
X-CRM114-Status: GOOD (  21.47  )
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

For multipath devices, nvme_update_ns_info() needs to freeze both
the queue of the path and the queue of the multipath device. For
both operations, it waits for one RCU grace period to pass, ~25ms
on my test system. By calling blk_freeze_queue_start() for the
multipath queue early, we avoid waiting twice; tests using ftrace
have shown that the second blk_mq_freeze_queue_wait() call finishes
in just a few microseconds. The path queue is unfrozen before
calling blk_mq_freeze_queue_wait() on the multipath queue, so that
possibly outstanding IO in the multipath queue can be flushed.

I tested this using the "controller rescan under I/O load" test
I submitted recently [1].

[1] https://lore.kernel.org/linux-nvme/20240822193814.106111-3-mwilck@suse.com/T/#u

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
v2: (all changes suggested by Sagi Grimberg)
 - patch subject changed from "nvme: core: freeze multipath queue early in
   nvme_update_ns_info()" to "nvme: core: shorten duration of multipath
   namespace rescan"
 - inserted comment explaining why blk_freeze_queue_start() is called early
 - wait for queue to be frozen even if ret != 0
 - make code structure more obvious vs. freeze_start / freeze_wait / unfreeze

Hannes and Daniel had already added Reviewed-by: tags to the v1 patch, but
I didn't add them above, because the patch looks quite different now.

---
 drivers/nvme/host/core.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0dc8bcc664f2..1ea052450846 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2217,6 +2217,16 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	bool unsupported = false;
 	int ret;
 
+	/*
+	 * The controller queue is going to be frozen in
+	 * nvme_update_ns_info_{generic,block}(). Every freeze implies waiting
+	 * for an RCU grace period to pass. For multipath devices, we
+	 * need to freeze the multipath queue, too. Start freezing the
+	 * multipath queue now, lest we need to wait for two grace periods.
+	 */
+	if (nvme_ns_head_multipath(ns->head))
+		blk_freeze_queue_start(ns->head->disk->queue);
+
 	switch (info->ids.csi) {
 	case NVME_CSI_ZNS:
 		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
@@ -2250,11 +2260,13 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		ret = 0;
 	}
 
-	if (!ret && nvme_ns_head_multipath(ns->head)) {
+	if (!nvme_ns_head_multipath(ns->head))
+		return ret;
+
+	blk_mq_freeze_queue_wait(ns->head->disk->queue);
+	if (!ret) {
 		struct queue_limits *ns_lim = &ns->disk->queue->limits;
 		struct queue_limits lim;
-
-		blk_mq_freeze_queue(ns->head->disk->queue);
 		/*
 		 * queue_limits mixes values that are the hardware limitations
 		 * for bio splitting with what is the device configuration.
@@ -2286,9 +2298,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
 		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
 		nvme_mpath_revalidate_paths(ns);
-
-		blk_mq_unfreeze_queue(ns->head->disk->queue);
 	}
+	blk_mq_unfreeze_queue(ns->head->disk->queue);
 
 	return ret;
 }
-- 
2.46.0


