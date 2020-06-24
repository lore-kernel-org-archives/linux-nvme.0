Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CFEC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 00:20:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A2B2078E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 00:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uw1ovwg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A2B2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=h6qR3J+tokRavtExYHW6i92+LlUiNNVQRHW4CCpt1gU=; b=Uw1ovwg6L6fFFXJseup4or0ZJ
	EzhBHAI5dH7imXp/tyyv/a5wMFxv2oWjiwA7WNKuRmgHc2f4mo+35f8Kh/+fOh5vRqct8lbglWB8a
	DA3BNJD76GOmJ+H6CtrIVW7rdMWoTJrR21ymOKMUTfDe95SJf6OxvMAJCmOPZDtMLfJ24FNhlynZV
	KTHtk6BoCQnTDQ9nJ8use/TlZ9L5czyPX2IQj/PmJaQu7SKSDfEukZd0n4xxdPAyriN5TjRZIgeli
	FaYADW4Ud39i6Iry7hnhuXNxUzqwdv7nzQq8Z9QFfVgQFO4vqeB1/AWqpJhxUw1Q0l5i1XVoPIGEO
	3q/vEvpMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnt8w-0001of-RC; Wed, 24 Jun 2020 00:19:58 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnt82-0001cL-Ev
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 00:19:04 +0000
Received: by mail-pf1-f196.google.com with SMTP id a127so224628pfa.12
 for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2020 17:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DUbZIXRaVLoAuUfmnWTcHd9prDgY4LWLz4OLRGO9a7k=;
 b=pdr8kORszqpsEVTN31O0GGQREFyb9W4yt349pgxaa2zz1V+bath6EetY32+aO8Mk2z
 bDK3irdRAuMFmUZ9Zn+/hyUDfJyB2tJ4eHV4W/1IKkT1vREgv3Q1qzniLFHdC7LxNmPM
 Ji4b9S4hwwzlz0ce5HIR1/pPljvOfTR7NfPLfZROxU4IZ9jj/r3sbwgGBumYiD5eyS9W
 PjRmbKLqm2+exikhpKXjAU4KPRb7Z3At+ubkMcUnqn4Ojxwahjq9ZHt9IfaXJg6TiUtN
 5QYiyzwsTTi9zxkmcnqx/8jNmIhJ7nAZVjXR7boYa38q7nyZh3qpXBrSZOfg6JonrHOa
 RDnA==
X-Gm-Message-State: AOAM532RDNuMz9HtkM4eHj9Pnhb1CrhdmHBz2GoKyDtCoiTZxWPtOHyI
 ACJfQzgzRru0Jm6+6QOGDiqA3UQl
X-Google-Smtp-Source: ABdhPJxGOCRjWETYEOgikVJvhgY7Bzvi3m/bYyc1USqqRIgAl4KnmN/bOD6UarqXNjqrMCKd8gq9Yw==
X-Received: by 2002:a63:7741:: with SMTP id s62mr19072958pgc.332.1592957939367; 
 Tue, 23 Jun 2020 17:18:59 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:9915:87a9:9728:63e])
 by smtp.gmail.com with ESMTPSA id d2sm14571840pgp.56.2020.06.23.17.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 17:18:58 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 for-5.8-rc 3/6] nvme: don't protect ns mutation with
 ns->head->lock
Date: Tue, 23 Jun 2020 17:18:50 -0700
Message-Id: <20200624001853.5408-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624001853.5408-1-sagi@grimberg.me>
References: <20200624001853.5408-1-sagi@grimberg.me>
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

Fixes: 0d0b660f214d ("nvme: add ANA support")
Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/multipath.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a646f9eb2e73..c8fc42e37138 100644
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
@@ -427,8 +426,9 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		srcu_read_unlock(&head->srcu, srcu_idx);
 	}
 
-	synchronize_srcu(&ns->head->srcu);
-	kblockd_schedule_work(&ns->head->requeue_work);
+	synchronize_srcu(&head->srcu);
+	kblockd_schedule_work(&head->requeue_work);
+	mutex_unlock(&head->lock);
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
@@ -670,10 +668,8 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
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
