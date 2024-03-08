Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2D3C54798
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 01:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=T0VmI7cjh01bWA9ccp2UxVbT9UK8V+NJKMSbB8EgOiM=; b=VKXSViiHoVlIQwDn1gYvBQ+1vr
	bJJSRY/K6cX/OIt/dVw/8Eth9FIJnQjUf9vi/QMs8WDktcLiql3WK5YJV547sdB/5ak4XP6gleYHn
	oj9OVmFAGiA1x1Iv5E80+uEklNVJjjP42xGhWFVrr5fDAEDjnBEUgvku/TlBdATCgL2lcYWr23SIs
	jIB7S61T7+4DhSkWgl8dns8UnGwNyOvyJJMUr07K76yQXSftvMdp8s1OMUkRCV3OmOAZZJcfz4lEW
	KT7XZwbI2j9uJh7HQPh+04wFNxtmi9sk4z4LFW4UEMvXSYKpJPH2pLzUQ/71ExmV2LlKBpj/XgpQs
	R69MxuLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riPRa-00000007FO3-188B;
	Fri, 08 Mar 2024 01:54:42 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riPRU-00000007FNG-2Ruc
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 01:54:38 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1dd611d5645so6739695ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 17:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709862876; x=1710467676; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T0VmI7cjh01bWA9ccp2UxVbT9UK8V+NJKMSbB8EgOiM=;
        b=mxa3BfoGS74BIU9tuG9wXP6zf+sHyW1y5R2erfPneMEzKG96kzwO+uBtAAYomI2q7P
         19IUDEAnmVj59kKhi5f0nz6ml63oAhqZy5eHpxITsXG3i9H7TBPMxlMYqYlgexGm4GE/
         wRO4e1JIyHBq5ONPm8KhKOGHfhvD5dp7McDEMHowXtVkDs12lE22zUWR9ZV5vUhVx8Zg
         siju95vlYCaowSzHsfiV6+i52Ba46c1i3eeVi4cQ1TCxOf8wBGCyCDHMzJHwnZKNHXfS
         WMa24xZv2ZiXLB9ls3JJf/d9dMK+XL6Ipo9+Y0cIkz81sNcyPxahy6+5HSedyFzpUAuf
         l3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709862876; x=1710467676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0VmI7cjh01bWA9ccp2UxVbT9UK8V+NJKMSbB8EgOiM=;
        b=lJGbVOArU3+epbadnTdxweW+Jl4mr6y5AwrQG6d9iCk2vDYT2o39DfwyWqhY26p8rx
         eYAWb5LYqaVzVmoOk9XES9QY4W6j7P3YUA9iy29Gw8QbjbX2xIT5YiodQcvpnEXm9oEe
         9lZUBhX1Rb4JGnOGEos7ZetLllPsVu3pifnmgNN1Ob+RXsel9jfRJNslvuzj2ONzVQjU
         UDF9Qb1U6X3nMo5wss9Um9X6wbo4g2sRW9YD4AXllo24exYBHdHPiyvJYpXc0udmw0TV
         TWaETt7vqU2RhL23Ely4c/jDupbpp+2+B8FsaTJc4FO4QBH30NMl1dn0bZMHmHjLxz3s
         YE3A==
X-Gm-Message-State: AOJu0Yw3x2ys2xI3RdpuBM3vhCvzrJBqvotJupkmXMPYXGpK+waLZHVW
	FWerxvDiBpZTyyKhtkg+oMYIvmXszW7HCSChLKAUZi7YGcr2JIAlGQbnkUYUUG+2Vw==
X-Google-Smtp-Source: AGHT+IG8Ki4U/HJqYPtsOy4+8fzlsGDeLJ+EjEnwZUwHoLxUKzC6D0RgqFcow4Z6uSVDQALjxcmYmQ==
X-Received: by 2002:a17:903:187:b0:1dd:6997:c96f with SMTP id z7-20020a170903018700b001dd6997c96fmr465916plg.18.1709862875858;
        Thu, 07 Mar 2024 17:54:35 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id lb12-20020a170902fa4c00b001dd675cb6fbsm317845plb.298.2024.03.07.17.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 17:54:35 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] nvme: fix reconnection fail due to reserved tag allocation
Date: Fri,  8 Mar 2024 09:54:35 +0800
Message-Id: <20240308015435.100968-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_175436_666314_EB335273 
X-CRM114-Status: GOOD (  16.41  )
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
---
v3: rearrange commit log, no code change
v2: keep two reserved tags for admin_q instead of drop keep alive request

 drivers/nvme/host/core.c    |  4 ++--
 drivers/nvme/host/fabrics.h | 10 ++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0a96362912ce..3d394a075d20 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4359,7 +4359,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	set->ops = ops;
 	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 	if (ctrl->ops->flags & NVME_F_FABRICS)
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		set->reserved_tags = NVMF_ADMIN_RESERVED_TAGS;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_NO_SCHED;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
@@ -4428,7 +4428,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	if (ctrl->quirks & NVME_QUIRK_SHARED_TAGS)
 		set->reserved_tags = NVME_AQ_DEPTH;
 	else if (ctrl->ops->flags & NVME_F_FABRICS)
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		set->reserved_tags = NVMF_IO_RESERVED_TAGS;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 06cc54851b1b..a4def76a182d 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -18,12 +18,10 @@
 /* default is -1: the fail fast mechanism is disabled  */
 #define NVMF_DEF_FAIL_FAST_TMO		-1
 
-/*
- * Reserved one command for internal usage.  This command is used for sending
- * the connect command, as well as for the keep alive command on the admin
- * queue once live.
- */
-#define NVMF_RESERVED_TAGS	1
+/* Reserved for connect */
+#define NVMF_IO_RESERVED_TAGS		1
+/* Reserved for connect and keep alive */
+#define NVMF_ADMIN_RESERVED_TAGS	2
 
 /*
  * Define a host as seen by the target.  We allocate one at boot, but also
-- 
2.25.1


