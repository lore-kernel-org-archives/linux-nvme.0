Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3173AC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 08:53:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000A8207DD
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 08:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tn19d7lI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000A8207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PwSNSJmou+yHKmcN8kcgN06i1PeS6nuHAtSX30/kz9E=; b=Tn19d7lIraRBIcAP4JM+Tdnm/
	Vc8gPSJTv3ozzN6SG0ZFKeo0H0dv1gK0Z4MkAdzSZD/oxmJqCi26KeNJMavbuFFjQHWuSokLiGmvO
	6/J3XdpluCx35VYEb7vXoopSYFtPesdo/6/txYgI25lETcy/GiWDYtY3Be3XlzmF+J+AYU9ubsNXx
	yy6OrhZad+tjmZb6h1hw+vZGnG24OsBizOidxmQbTXk9VJC7M/nwa189L0Uy/+pjxEWhte3vfWHQx
	P1u8tCgA23XPBNuIJoVyi6Oe+/2ahlKVRgKmVnt8IkOiGH29UQiJJyYPq4J2LAqOf0AZkISdo1O8w
	gOCxBN0IA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jo19x-00067U-BH; Wed, 24 Jun 2020 08:53:33 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo19r-00064I-VF
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 08:53:28 +0000
Received: by mail-pf1-f194.google.com with SMTP id b16so852763pfi.13
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 01:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jFfbankdZK0LwOXYcAxwV2Z07RwZ/ZXGFORydYXtnoQ=;
 b=TXUEXcELHmA9uyvhX2hgPBXoy6Nl8OKzP63BN1N5aMWVNIxOhQB3YlYfDOump8DCG1
 VLl5SzJFQ6CbTf8Qaa9AgPEbGKjmKe2aGnDHVX6GHBOcWwhxhaT7znZQPX6BLuqUs4AO
 gcMynFkaA/zw+vS8qERXP0L9XIg3QcJ2Bj3O/BClEIw4N8uV26UOVRVLdkaE3ojt4jkQ
 HRJUePfymCfPO/MW15h+To0d8HtmHmE0B43klBlJUU/TlEvmVsG5U+05K1/XuyoyUDX4
 hcoqw/4amDcAUrkaFCWYz8S3f754tyra54GJ8pKzQihWDv4pV7KWzOblHjjYnJhvyVgI
 nmaQ==
X-Gm-Message-State: AOAM531Rhcku3feF1+68W4R+oG9CjI8Ry/qiSBwpbDPFKwMOJc0jwORp
 yBYYs8eJqzYH24Lfuk/qZd71IV6Q
X-Google-Smtp-Source: ABdhPJzfPJht9dXD8zi4ms5QZ54wAowz3IQ+GfvjyslCsdypwv7vioTsQpdNAX6oI2aeKBIruxKfvw==
X-Received: by 2002:a62:884b:: with SMTP id l72mr29504629pfd.242.1592988806517; 
 Wed, 24 Jun 2020 01:53:26 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:9915:87a9:9728:63e])
 by smtp.gmail.com with ESMTPSA id m14sm4600814pjv.12.2020.06.24.01.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 01:53:24 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3 for-5.8-rc 3/5] nvme: don't protect ns mutation with
 ns->head->lock
Date: Wed, 24 Jun 2020 01:53:10 -0700
Message-Id: <20200624085312.35967-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624085312.35967-1-sagi@grimberg.me>
References: <20200624085312.35967-1-sagi@grimberg.me>
MIME-Version: 1.0
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
Cc: Anton Eidelman <anton@lightbitslabs.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Right now ns->head->lock is protecting namespace mutation
which is wrong and unneeded. Move it to only protect
against head mutations. While we're at it, remove unnecessary
ns->head reference as we already have head pointer.

The problem with this is that the head->lock spans
mpath disk node I/O that may block under some conditions (if
for example the controller is disconnecting or the path
became inaccessible), The locking scheme does not allow any
other path to enable itself, preventing blocked I/O to complete
and forward-progress from there.

This is a preparation patch for the fix in a subsequent patch
where the disk I/O will also be done outside the head->lock.

Fixes: 0d0b660f214d ("nvme: add ANA support")
Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/multipath.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0ef183c1153e..5c48a38aebf8 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -409,11 +409,10 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 {
 	struct nvme_ns_head *head = ns->head;
 
-	lockdep_assert_held(&ns->head->lock);
-
 	if (!head->disk)
 		return;
 
+	mutex_lock(&head->lock);
 	if (!(head->disk->flags & GENHD_FL_UP))
 		device_add_disk(&head->subsys->dev, head->disk,
 				nvme_ns_id_attr_groups);
@@ -426,9 +425,10 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 			__nvme_find_path(head, node);
 		srcu_read_unlock(&head->srcu, srcu_idx);
 	}
+	mutex_unlock(&head->lock);
 
-	synchronize_srcu(&ns->head->srcu);
-	kblockd_schedule_work(&ns->head->requeue_work);
+	synchronize_srcu(&head->srcu);
+	kblockd_schedule_work(&head->requeue_work);
 }
 
 static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
@@ -483,14 +483,12 @@ static inline bool nvme_state_is_live(enum nvme_ana_state state)
 static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 		struct nvme_ns *ns)
 {
-	mutex_lock(&ns->head->lock);
 	ns->ana_grpid = le32_to_cpu(desc->grpid);
 	ns->ana_state = desc->state;
 	clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
 
 	if (nvme_state_is_live(ns->ana_state))
 		nvme_mpath_set_live(ns);
-	mutex_unlock(&ns->head->lock);
 }
 
 static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
@@ -669,10 +667,8 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 			nvme_update_ns_ana_state(&desc, ns);
 		}
 	} else {
-		mutex_lock(&ns->head->lock);
 		ns->ana_state = NVME_ANA_OPTIMIZED; 
 		nvme_mpath_set_live(ns);
-		mutex_unlock(&ns->head->lock);
 	}
 
 	if (bdi_cap_stable_pages_required(ns->queue->backing_dev_info)) {
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
