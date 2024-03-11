Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FBEC54791
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Mar 2024 02:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Z4ztNqq1FwMuKzBeQUi/UacN3w/fjsndHTJlWkBGBT0=; b=MeClqvz0zR7x8ABIRk64A1+2kJ
	bok6K8l0VNy/KtHwGKZhFqSpi4wZ8GX+A+NS0SPz7a523nxj0Z8H+E0/uEJlyzDFr1HJtF0WMqVfl
	cxJW+QxadwiwKxXIrvzokYF4J9WXxwuAwHC+hpzC7wpy+F2fswTrZT7jv7XUj4c7CXEIyuoVG4/JC
	GL0MsNWbby5L/vF8uwJDY4kejk0HhZoXilZYCMAqRLG5ici/H59MvK4janwuUyZ+CnLBSiHYcfBnl
	URqUW3om8HVYtvreKO9x+V2qTh13FLd05ntS7QEEgT+ui+76gjcvenphAMyHoSfB1XtD/kt7PiHzS
	WT1RNtVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjV6g-0000000HSmc-1bYt;
	Mon, 11 Mar 2024 02:09:38 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjV6a-0000000HSkw-2gin
	for linux-nvme@lists.infradead.org;
	Mon, 11 Mar 2024 02:09:34 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso3326774a12.0
        for <linux-nvme@lists.infradead.org>; Sun, 10 Mar 2024 19:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710122969; x=1710727769; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4ztNqq1FwMuKzBeQUi/UacN3w/fjsndHTJlWkBGBT0=;
        b=OyWNAaR2zqM3HGpmSnOLTQpy+ngFyjov+msWvl/a7BZ++7nsurlfGq37ID53/LYS53
         E8lnxUxpkH10jw1Ala+0gdxmv5b87czD0YZmGjZs2vmf8HWN/6gnco5Dc22ymZX6RQJP
         qU/w4mPksLFoKjcgSyb43Bz11Od8HfsUVm8MFu65d+ye5ge/9YzNhRQ+K+cV/Gy8PAuk
         /sswe7IDEPmn43S+KuUs+dWnVUDraSwixI/sftyPtdwfZpUh/SWXMSXSeinKQ/jfGqY1
         mUkX+U7NLmraJ+ri3Ng2EjcFogYu1fVWc7emFshpdtet3T+KF23EjxPosla72ZhwxvVk
         6McA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710122969; x=1710727769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4ztNqq1FwMuKzBeQUi/UacN3w/fjsndHTJlWkBGBT0=;
        b=wy5ER7BMnfgBTy6ufDx1ED/1T9RTn74Uw63p5UC8V+MbDHN8tcgTH/EPPRuSHZ/q7r
         wBdBfD757i26oVzPdmXbF6tLwr+mB3yEM46dV4NESLqGMS9mZ/nNjm7mJfhQJr/ctbBo
         6U7JqkQASK9rMS69XChpSuU86/sptO5fZoPYLBLCe5Xu00QUude+JqoA6kvv+tRhZjM3
         Xi2kSqCVO2LP4wnHzw9jebTCJjdb803EB47xv/5QkZXP25OSLq/luINpO+lw/6dUtuEg
         u5QlKX+rzHzcIazCoonKbAxXjztA0NnzIjAgutnuYCxAKRtYl5oDCI+0A5CN3TDS+AET
         JuQA==
X-Forwarded-Encrypted: i=1; AJvYcCXKmaF0TVZbKvd7tFDzWUUryTLaOnCCgYmX5aRegOWYqpbtfbh2S4wlbx1sItmxsNhg+Tn3sPixzUiHKAJM9xL5m7ASr4QrhlhNKZ3y+Lc=
X-Gm-Message-State: AOJu0YzKyGeb7fqu540OiwjamfwBHdPl5QoeZCMUaIRvOAbp0WNEfdr5
	KLtqKoWpaj4POEGB48av11TUxdCj/j3CwtIPBh6ueP5SL4+7I/RT
X-Google-Smtp-Source: AGHT+IHqBF6JL0jv4YkL9dvpzWH5MTZk1eBoCcUG7fuhmwb1A35fre/o9bnKED1G3FfFT131dmX8eQ==
X-Received: by 2002:a05:6a20:258f:b0:1a0:f5b9:bd88 with SMTP id k15-20020a056a20258f00b001a0f5b9bd88mr7832457pzd.55.1710122968903;
        Sun, 10 Mar 2024 19:09:28 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id ky14-20020a170902f98e00b001dd61bc14f2sm3387888plb.8.2024.03.10.19.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 19:09:28 -0700 (PDT)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] nvme: fix reconnection fail due to reserved tag allocation
Date: Mon, 11 Mar 2024 10:09:27 +0800
Message-Id: <20240311020927.85482-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240310_190932_718083_7476BE34 
X-CRM114-Status: GOOD (  16.90  )
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

From: Chunguang Xu <chunguang.xu@shopee.com>

We found a issue on production environment while using NVMe over RDMA,
admin_q reconnect failed forever while remote target and network is ok.
After dig into it, we found it may caused by a ABBA deadlock due to tag
allocation. In my case, the tag was hold by a keep alive request
waiting inside admin_q, as we quiesced admin_q while reset ctrl, so the
request maked as idle and will not process before reset success. As
fabric_q shares tagset with admin_q, while reconnect remote target, we
need a tag for connect command, but the only one reserved tag was held
by keep alive command which waiting inside admin_q. As a result, we
failed to reconnect admin_q forever. In order to fix this issue, I
think we should keep two reserved tags for admin queue.

Fixes: ed01fee283a0 ("nvme-fabrics: only reserve a single tag")
Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v4: move init value and the comments to the real users
v3: rearrange commit log, no code change
v2: keep two reserved tags for admin_q instead of drop keep alive request

drivers/nvme/host/core.c    | 6 ++++--
 drivers/nvme/host/fabrics.h | 7 -------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0a96362912ce..fe3627c5bdc9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4359,7 +4359,8 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	set->ops = ops;
 	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 	if (ctrl->ops->flags & NVME_F_FABRICS)
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		/* Reserved for fabric connect and keep alive */
+		set->reserved_tags = 2;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_NO_SCHED;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
@@ -4428,7 +4429,8 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	if (ctrl->quirks & NVME_QUIRK_SHARED_TAGS)
 		set->reserved_tags = NVME_AQ_DEPTH;
 	else if (ctrl->ops->flags & NVME_F_FABRICS)
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		/* Reserved for fabric connect */
+		set->reserved_tags = 1;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 06cc54851b1b..37c974c38dcb 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -18,13 +18,6 @@
 /* default is -1: the fail fast mechanism is disabled  */
 #define NVMF_DEF_FAIL_FAST_TMO		-1
 
-/*
- * Reserved one command for internal usage.  This command is used for sending
- * the connect command, as well as for the keep alive command on the admin
- * queue once live.
- */
-#define NVMF_RESERVED_TAGS	1
-
 /*
  * Define a host as seen by the target.  We allocate one at boot, but also
  * allow the override it when creating controllers.  This is both to provide
-- 
2.25.1


