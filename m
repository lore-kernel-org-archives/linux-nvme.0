Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D877BC87FD2
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Aug 2025 05:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QoW10+RcxtJxMxrx5pWJddPJprR6x75GK3Y5SnJ1n5s=; b=CLr0WDos9Czs1VeZNywYRhg2DY
	wkWIzpdDNdcXdVXsPqdnoLvtqad75WmeMstaXfHEzsZCLUk7XGj9t+s+Cl5M0KIBx/pw7V6Dd20pC
	Op67oaJxFa9p09qHtySUARLZvx1/kY6wvNjIpgGd+Vg2VdEorW+BJsEZw8JbsuXfa1K20J16GuT25
	ws2xLqh8X9laF/6qb8n6H34dyWGJbz01IkwAuxgBNA+Ex+enMwKkwDxnV2wDTOO+a1l/mllZpG8hm
	2aT+7cxoKp4aMnBjc/UX+MpkPv870G53GqqlIIrK11GiN1h+MvqDEK9QBtvZnBZrr9pj19BmzCmPF
	4b6LJi6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujtIB-0000000HJeZ-0ooh;
	Thu, 07 Aug 2025 05:35:55 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujtI7-0000000HJe8-2PoF
	for linux-nvme@lists.infradead.org;
	Thu, 07 Aug 2025 05:35:53 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-76bd2b11f80so649160b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 06 Aug 2025 22:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1754544951; x=1755149751; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QoW10+RcxtJxMxrx5pWJddPJprR6x75GK3Y5SnJ1n5s=;
        b=Pp8XBAT+gIrI3TOcITk1qryCKWDnuJOqsFydHTAfmV/WgYA/W0wXeMHiYAfMpYK69O
         wF0T4Ty9Eho5N4oVE2N3VMT8K0z5yqqDuTdhwRtBQ0ZkTK2MXJkU+5pSgiKpph5uNNxy
         LtOmw9He1nqz0GfbxdjTXPuLQjFOSetxKuvnN7jMTCf4qsjkroP+4DWn0NsiBy1F6OFB
         gpcOjpAwfQSL2zV/SfXZk3w3ZyzczwnPkC4ri17S+C0PGoVc330Yr55XyZ78J/efHy0S
         FNqTvN+F2fZymxCD/rH0MDEcwxz/95VycKor89bxzQ2tgeOWolITNpQRyAZ0ODOYgaQU
         xUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754544951; x=1755149751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QoW10+RcxtJxMxrx5pWJddPJprR6x75GK3Y5SnJ1n5s=;
        b=Hl1IiPY/UdH6hq1mDbIkiIGmJQhPZ5xMR5a4pEn+13pKOaNzTB2bsbAhdXAB7Ps9yR
         t+5D7iVweMngydNR5seuhyh8MS7NSmhsXyd95NGPwn+bD1f0Q6TLyWmUT9tMZgmcOmI+
         LI+gZkeIlAX6SXT+4s9MoegXdesebJVcPi5uTAqx1SUO42WuRLLa+dggW3wnH6rQti/y
         c/j/rVp2egPkAPavZZN6O8v6Fj7Ar2rRrZiLBc11mMN2hKZTEEz+A9xc3Kng09wNFbS1
         M1NrSY2f5IImXZafnMr1OKWxLKSmfXM1UR+bjABbYpwusNU7lG1fZbrJLX3ko+DLgOeL
         r9RA==
X-Forwarded-Encrypted: i=1; AJvYcCVrblUNiqme7NeLKbQN4VGSg9cW5p5/pyGMcNPAroHEQBd+4/mZUZIGcrloi1gmPV3qN3axDglAlrK6@lists.infradead.org
X-Gm-Message-State: AOJu0YyIai9hjUXKc5PhGl4cGpkf+xUA/flxXyuT7IbzmveinpCmVGrW
	Y+d46vzZsQXhDwngcxgA0mi1GFY9la1U5fE+ol6zlTtxvJQVKMLYL2Lh/7hsNxOlwUA=
X-Gm-Gg: ASbGnctDj4YLEjWFICQoWzHTeb0lhC/kWu+WarKi3oMPnZIIanWC1jdxuDhJKa75Sh/
	Sd6RM9IFNO+VZmGW0JGBWJ3g1w3fuGwvXKzPdvlkjONbJA9ON20tG5WqXRndSWff6dy/XF1rN5c
	BLmQgO59+/GC5FiYXblzokbmCYtXpmGzzmKXjGyEmoINYR3QxKmv12fNL02CP8cR128LXgSKcOY
	MzL3R4RNurmEsugGO7nSCI7EbgD3B6eDwZizFQLXsoL3dt3KL95AUCCHqpE+Tcin9Pvb8CY2pKb
	u5Q9JPcGI+gi+FxjZuNKvRLbuxrTa39bAhEoRRtdBAD1vKpgn55imAP3PiZrZnGrz4MwFmuBqDy
	+FJWb4C16sNywQVslhDMqmMXNT9VOqEdsgFeOMfI=
X-Google-Smtp-Source: AGHT+IGeyHcVUYRXGoHcwS/JcJOXNo7fQU6bAK888L0yq4XpFiifdOi5CrgPuZlMwnAPe9aSf/fYLg==
X-Received: by 2002:a05:6a20:559a:b0:23d:9fd5:9231 with SMTP id adf61e73a8af0-240315b3ba3mr8005141637.46.1754544950644;
        Wed, 06 Aug 2025 22:35:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8202:6fb0::eb28])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-76bf772116asm10978824b3a.97.2025.08.06.22.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 22:35:50 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-block <linux-block@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: exit debugfs after discovery subsystem exits
Date: Wed,  6 Aug 2025 22:35:07 -0700
Message-ID: <20250807053507.2794335-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.49.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_223551_639772_ACB7E153 
X-CRM114-Status: GOOD (  12.83  )
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

Commit 528589947c180 ("nvmet: initialize discovery subsys after debugfs
is initialized") changed nvmet_init() to initialize nvme discovery after
"nvmet" debugfs directory is initialized. The change broke nvmet_exit()
because discovery subsystem now depends on debugfs. Debugfs should be
destroyed after discovery subsystem. Fix nvmet_exit() to do that.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs96AfFQpyDKF_MdfJsnOEo=2V7dQgqjFv+k3t7H-=yGhA@mail.gmail.com/
Fixes: 528589947c180 ("nvmet: initialize discovery subsys after debugfs is initialized")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 83f3d2f8ef2d0..0dd7bd99afa32 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1992,8 +1992,8 @@ static int __init nvmet_init(void)
 static void __exit nvmet_exit(void)
 {
 	nvmet_exit_configfs();
-	nvmet_exit_debugfs();
 	nvmet_exit_discovery();
+	nvmet_exit_debugfs();
 	ida_destroy(&cntlid_ida);
 	destroy_workqueue(nvmet_wq);
 	destroy_workqueue(buffered_io_wq);
-- 
2.49.1


