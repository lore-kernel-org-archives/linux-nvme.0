Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CE4C04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 06:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IylTrP9rJ6ALJKFkZ0L8wB/2A4YQIPlpnzp6BP2BGk0=; b=KImSgEsAJXk3DoGO1SnY3E58Lx
	DPO92FfalD2w+GI/JhPBBx6ZyGraJ6DeB0lIR0OOdNzX4JTF5IYgA4h9M0iKMJySymM/+TKOicXRA
	Lc/SsRQWh75dVd5w6ricLWainXgK0XYxZIf76jpsOPMd/1uqStFthpbGqUSrepKNoibHUsazY/Dh3
	1AyLtvrCxoRcNIUk9bB8iHrnK9RG1/UD/KF4cfZxOJPwQbP5AqYtAwCDWPQ8d0+DodWwIb9SUsTxK
	1wCabHgeeSAf00ZqsDnVGUHFc1eos+XHVyHiEYx1ZKP2wE8tW11/fRbn9wG+gO0WDtGbDKVKjKxJY
	wL2m2Blw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQj1-00EH7R-GJ; Wed, 28 Sep 2022 06:39:19 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQiz-00EH6C-Jp
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 06:39:18 +0000
Received: by mail-wr1-f46.google.com with SMTP id n10so18135784wrw.12
        for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 23:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=IylTrP9rJ6ALJKFkZ0L8wB/2A4YQIPlpnzp6BP2BGk0=;
        b=a/6znpZUwAtBs1dca7XCn2z1PNaMbAujTQRKeW500ZDorV2ZlLyyrWkCBIP4l2VWvP
         EFKBWea6HmNicabzRK9Lez5wXXs702N/7v2LKorI76CDEVzkudGNsB6G6on9wxRCEHSq
         O+iab4JGiMuaVRG3JfEmURgf5kanHrV7S5y1GmyeOedv9gFKNlaRNGU5DSDo6kXaO9U8
         tVCsjtrco4TWsPIrpgKrWohyteRNhICiW+xLbxm7jzkX5Pf1d+Wf96mZ14LwGgamDlgK
         SXqEapf3jxoe4915dBqzBXVVaB5vudWeK8DQDCGLj9Q6NUNEZ09EPrYw87j6FFs2ETK7
         k/HA==
X-Gm-Message-State: ACrzQf2lEqM0f9ZCmVz3uUAhfcC1CtpSGlt4GjwplcqhV2ST/tkPdghA
	W+rZv9aPda8yI8ui4DHk3iQIwgN/kzs=
X-Google-Smtp-Source: AMsMyM63j8kiIqSEMhHskUBwCatNe5+lx+n0qpWjIL6ZTs7McDs09bXCWEqHeVPbLamxL+yB9S5cHQ==
X-Received: by 2002:a05:6000:1007:b0:22a:38fc:aeb2 with SMTP id a7-20020a056000100700b0022a38fcaeb2mr20227642wrx.297.1664347153857;
        Tue, 27 Sep 2022 23:39:13 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x5-20020a5d6b45000000b002238ea5750csm3950381wrw.72.2022.09.27.23.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 23:39:13 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] nvmet: fix workqueue MEM_RECLAIM flushing dependency
Date: Wed, 28 Sep 2022 09:39:10 +0300
Message-Id: <20220928063910.46862-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_233917_667248_85A16442 
X-CRM114-Status: GOOD (  13.93  )
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

The keep alive timer needs to stay on nvmet_wq, and not
modified to reschedule on the system_wq.

This fixes a warning:
------------[ cut here ]------------
workqueue: WQ_MEM_RECLAIM
nvmet-wq:nvmet_rdma_release_queue_work [nvmet_rdma] is flushing
!WQ_MEM_RECLAIM events:nvmet_keep_alive_timer [nvmet]
WARNING: CPU: 3 PID: 1086 at kernel/workqueue.c:2628
check_flush_dependency+0x16c/0x1e0

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Fixes: 8832cf922151 ("nvmet: use a private workqueue instead of the
system workqueue")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7f4083cf953a..428317fe6da0 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1175,7 +1175,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	 * reset the keep alive timer when the controller is enabled.
 	 */
 	if (ctrl->kato)
-		mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
+		mod_delayed_work(nvmet_wq, &ctrl->ka_work, ctrl->kato * HZ);
 }
 
 static void nvmet_clear_ctrl(struct nvmet_ctrl *ctrl)
-- 
2.34.1


