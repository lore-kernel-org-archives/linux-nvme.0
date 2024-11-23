Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3B3E6ADFD
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Nov 2024 13:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jd9a/be5zPzPzHX2bMJ+1WldLBEiKm1H974p4wdOY3Y=; b=JMgY+6jfWobCtOETuDD/VM1p4G
	D4jAvj9aD0ZxU1RHrw4lpR1CfrwO0N7kb2hLxix9QaE0EECtcP3vFXfmlOJ50xhtHT4377AEHJ17L
	ROgPqhUnN2oYwi/Dcp6QkQq7RDgqtt3Rhg8zuR8I6Fl+9fm34HqiV68+NOytaRU0QTFB2VO50Kmd7
	WMvLqz/11Ad63+b/iHMCOyYjoCn/Q2Y4R/T3z5cj6u8C4S5v9fYNZFSgqXaMF0ZXry9tFBg4U0S9z
	VX3LyafOfQG8bnW7jFhzy9ZQIdBHgBEisFXV+fF47ZKV2ZZTy5hDZnlMoppWsF9BHwaM+etcVkmEa
	jER8mS+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEpmG-00000004Lw4-2s2p;
	Sat, 23 Nov 2024 13:02:20 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEpmD-00000004Ltr-3btU
	for linux-nvme@lists.infradead.org;
	Sat, 23 Nov 2024 13:02:18 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so2207888a12.2
        for <linux-nvme@lists.infradead.org>; Sat, 23 Nov 2024 05:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732366937; x=1732971737; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jd9a/be5zPzPzHX2bMJ+1WldLBEiKm1H974p4wdOY3Y=;
        b=K+mHeD4EP2925GO9mmqCGQ4x9tdQxh2vnjZ5xTOpH7CS90plMIdEMWgOfssAem/6bO
         PcHyp6DZ21N19HapP+8UbyyArKTjUKiH7rG5+sE2CiiZ3rlh6WXq0ZyLo816SySerdHs
         +t6FKEnTH+la79cH9Lgcig0UhpVbSc7YYQyIsXS29IfkyMzLHT63a0cND8p5KiyJ0dOu
         2v7ohW2JpewROZy2kq7WVZyKlKRdghNkfYXDJCJeDlJssd1z8C8iNq8jIUGjRJO+hTjw
         LA09cwN2vbPmrurKXVZ/curfDdpUwX40Y+UN/eUks1J8leK/8QLAImZxPQvhiC1yWXfo
         PbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732366937; x=1732971737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jd9a/be5zPzPzHX2bMJ+1WldLBEiKm1H974p4wdOY3Y=;
        b=jr9T+TgI3FVXuFESiQkxCG4LDvUCAO53UJnHvR0zgYgdGqmYgDjSnH3GxWPCbABchv
         7ZZQRk5+hFIlZqhWC0znYD84XpagPbdWQxsu0hM2+JzmuXm1p2+wjolYQUTVq2Ey8Hf4
         mlO2ljBmSWukTgowz4zuEyCacjRwxhZbIBx6VLVLZ0I5nLfKChH8py3+jP5dJZ3F9qbr
         mMcV7+Hm8VYdDiAE6u6AfAwhBUTmsxsTFdUf8hHCv/F8UC3LJXnXxQvWKG8zqch5MHcs
         zoXusUSWY9XR5L3/2NMbwjf928vQN6LBg+hq5yg4lKy2WsxnOZpsmDmQHsRxzPzfYqpD
         9fiA==
X-Gm-Message-State: AOJu0Yz0BOgiEAfnK6hG7dXYcFE2bTskkGtFy/YnTzoCm/fB1vgfOdad
	Wqman3ekfYRR1G27m88XLyRJItbai/9z2ekLGRN8R4jGlgNEbUDV
X-Gm-Gg: ASbGncuJ+I2Sh6AbhebjdexknM09JcsJHs1U6mo3Ql2waZZSQQz7X9Bu2ma9LvvW+pg
	m1wXvAfg/veZ6dvLuD0fwzzcDrNdfQ98T/J/agYiMjh76vGX60DuZWaFJywFXnKwKl/VmQgLuVw
	W2mDQZ8gdyIv5/kl5InLLd2TAh3A0ZckVcudbMv8IurmMVxdFMZzEKYs3Y/wnOoWqHJRtYl1Z1U
	P1WrDwWP8yyfzbDyuf9huxbwQpML+G+3Od60BqxVBY09i+lFSR5Ea8hrUCYCA==
X-Google-Smtp-Source: AGHT+IEZYYlYvDwl/+fsjo2KFtg8yQ5hbXqNTsiSgl63OWsqCTdHbVAL3ymVk7gyL9arAvb6Nw6tnw==
X-Received: by 2002:a17:90b:1b4d:b0:2ea:aa69:1067 with SMTP id 98e67ed59e1d1-2eb0e024c02mr7965691a91.3.1732366937238;
        Sat, 23 Nov 2024 05:02:17 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cff8fe8sm3295226a91.14.2024.11.23.05.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 05:02:16 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] nvme-tcp: remove nvme_tcp_destroy_io_queues()
Date: Sat, 23 Nov 2024 21:37:40 +0800
Message-Id: <5afd7d60a07afc6f299aba8c31fe87e00484da5b.1732368538.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1732368538.git.chunguang.xu@shopee.com>
References: <cover.1732368538.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241123_050217_900917_96026CF8 
X-CRM114-Status: GOOD (  11.60  )
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

From: "Chunguang.xu" <chunguang.xu@shopee.com>

Now maybe we can remove nvme_tcp_destroy_io_queues() to simplify
the code and avoid unnecessary call of nvme_tcp_stop_io_queues().

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 45cbaa7523e6..57f0f0290cc8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2024,14 +2024,6 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 	return __nvme_tcp_alloc_io_queues(ctrl);
 }
 
-static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
-{
-	nvme_tcp_stop_io_queues(ctrl);
-	if (remove)
-		nvme_remove_io_tag_set(ctrl);
-	nvme_tcp_free_io_queues(ctrl);
-}
-
 static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 {
 	int ret, nr_queues;
@@ -2170,15 +2162,17 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 		bool remove)
 {
-	if (ctrl->queue_count <= 1)
-		return;
-	nvme_quiesce_io_queues(ctrl);
-	nvme_sync_io_queues(ctrl);
-	nvme_tcp_stop_io_queues(ctrl);
-	nvme_cancel_tagset(ctrl);
-	if (remove)
-		nvme_unquiesce_io_queues(ctrl);
-	nvme_tcp_destroy_io_queues(ctrl, remove);
+	if (ctrl->queue_count > 1) {
+		nvme_quiesce_io_queues(ctrl);
+		nvme_sync_io_queues(ctrl);
+		nvme_tcp_stop_io_queues(ctrl);
+		nvme_cancel_tagset(ctrl);
+		if (remove) {
+			nvme_unquiesce_io_queues(ctrl);
+			nvme_remove_io_tag_set(ctrl);
+		}
+		nvme_tcp_free_io_queues(ctrl);
+	}
 }
 
 static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl,
@@ -2267,7 +2261,9 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		nvme_sync_io_queues(ctrl);
 		nvme_tcp_stop_io_queues(ctrl);
 		nvme_cancel_tagset(ctrl);
-		nvme_tcp_destroy_io_queues(ctrl, new);
+		if (new)
+			nvme_remove_io_tag_set(ctrl);
+		nvme_tcp_free_io_queues(ctrl);
 	}
 destroy_admin:
 	nvme_stop_keep_alive(ctrl);
-- 
2.25.1


