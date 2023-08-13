Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8AEC001B0
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 14:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zCCJuLWxlzwZK4lPpl9OOBdDL3u1368YHPb0g0HV9fw=; b=Jgkx/gu1+VMtO3jELemsyxWLYP
	3L3r4QY8g9kQEoaVkc9NTje2ltZYq0QrlQj/0lhwHzYfajtIChRzzIdnLY6Mj9mKTPVyrzPWRiiC8
	pZVdiBBdRmrsW0BA0RaHc69+VGaCF31eLs/OsGcl5aNZmRZvGXDA5Ee44Ezje/KCQKKjimpJi1CNX
	fCg+IdufwBOGDFuDNa4mzo6jAkcSAQuJcLs6pJPep2vGjkydCrhFtZhDX/v2DmxNwmyOa+WpwY4O/
	hiSBmWSNWPXh7S2DJGCcbrYlu81HIYd0S95OL8oTwJFDHCRoug8vz3XUFkeVhQvNcelpJCL39XkeN
	aNaAUYJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVCL7-00FFsN-0D;
	Sun, 13 Aug 2023 14:45:09 +0000
Received: from mail-ed1-f54.google.com ([209.85.208.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVCL4-00FFqz-0q
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 14:45:07 +0000
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-52349d93c8aso1043146a12.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 07:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937904; x=1692542704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCCJuLWxlzwZK4lPpl9OOBdDL3u1368YHPb0g0HV9fw=;
        b=Bue6diU2nYIsSV+s22HjJbTSkPCSxNlqVgHY2JUuymQqJCL8KpWa35ULjcUQem6VPE
         7gcIVRG+ql2kSv7L4rQUjYgVcCWG87WoC2x9MGUa8UL9JqxHsd436QiRWdvSj+PZmP04
         2ASo3y6oClQ91a1eZxBBY2bPEk4tT8Bsnyc1PQDcHLnPfShrkdmovwKZpzhhgIxOCbx+
         gBS9H/PG1q3t22skFaxvsg1FXB5w+OzJ3sbUtFeKlqgdjDTvjX3OIyd6aSZVbMbKPEnN
         YEJlredJaM14WugyKEiU33TZ1wICT1s4SswEbSvxc/Ov3kaElhLTc+S4QuYRTb+AQNtT
         iQww==
X-Gm-Message-State: AOJu0YwU3HtlcYLdt8/wJM16VuVitUoHwQgk/ASpZl8yAncH4320wcZB
	TkqOOtEC5oZwOZda2UeX4ZKv462e9cY=
X-Google-Smtp-Source: AGHT+IFIRCwoxlLELSV6+nD2yzu51uet4FKj4HXaxSd/Tq89d9NcP9kV/g2lKC51F+pjVVWNPlqp3w==
X-Received: by 2002:a17:906:21c:b0:99c:c178:cef9 with SMTP id 28-20020a170906021c00b0099cc178cef9mr5573065ejd.2.1691937904256;
        Sun, 13 Aug 2023 07:45:04 -0700 (PDT)
Received: from localhost.localdomain (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906110b00b00977cad140a8sm4618761eja.218.2023.08.13.07.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:45:03 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: <stable@vger.kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 6.1.y 2/2] nvme-rdma: fix potential unbalanced freeze & unfreeze
Date: Sun, 13 Aug 2023 17:45:00 +0300
Message-ID: <20230813144500.15339-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813144500.15339-1-sagi@grimberg.me>
References: <20230813144500.15339-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_074506_299988_2B0AA047 
X-CRM114-Status: GOOD (  12.96  )
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

From: Ming Lei <ming.lei@redhat.com>

Move start_freeze into nvme_rdma_configure_io_queues(), and there is
at least two benefits:

1) fix unbalanced freeze and unfreeze, since re-connection work may
fail or be broken by removal

2) IO during error recovery can be failfast quickly because nvme fabrics
unquiesces queues after teardown.

One side-effect is that !mpath request may timeout during connecting
because of queue topo change, but that looks not one big deal:

1) same problem exists with current code base

2) compared with !mpath, mpath use case is dominant

Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 80383213b882..c478480f54aa 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -923,6 +923,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		goto out_cleanup_tagset;
 
 	if (!new) {
+		nvme_start_freeze(&ctrl->ctrl);
 		nvme_start_queues(&ctrl->ctrl);
 		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -931,6 +932,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			 * to be safe.
 			 */
 			ret = -ENODEV;
+			nvme_unfreeze(&ctrl->ctrl);
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
@@ -980,7 +982,6 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
 	if (ctrl->ctrl.queue_count > 1) {
-		nvme_start_freeze(&ctrl->ctrl);
 		nvme_stop_queues(&ctrl->ctrl);
 		nvme_sync_io_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
-- 
2.41.0


