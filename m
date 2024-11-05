Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1F1D2C115
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 14:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5vIy8/a9aiXFl3rcfyGsmdu83APhG1KQgWV74xlkHbk=; b=S1eQvXdjve3GYXOfDapc/aDMGw
	CpV9e6IQ3S2IuiNUYGS2kyeralq5zNO6MNCwQETho7X8WUHdGKlRDVPfvPNs+IhKlM74cwDF/bRKi
	JZMKgGV5ufz5NmtSLOQCWZboAgXKVMkOHC/YeC48VjX9Edu3SV8dk8jQnMxQPk7QXh0FrxM2JWoFQ
	gJLBAWPY720VWCOCMcu+BXqVqTPvz2y4Q4oxqqJRBGQOx2BKZX4Z4zMQaPKNC9W1MqYyn2Bbws3DE
	iLaWP9C8sWYLFymTv43LGQcTcC5nj3UYbAbXVESTIGgJfpTSDzKSO9qB8cnWOjyy0wUwf87Tz4BOS
	gZcj/MNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Klu-0000000HJlY-1Fan;
	Tue, 05 Nov 2024 14:43:06 +0000
Received: from mail-lj1-f171.google.com ([209.85.208.171])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Kls-0000000HJkY-0bEJ
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 14:43:05 +0000
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb443746b8so48963111fa.0
        for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 06:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730817781; x=1731422581;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vIy8/a9aiXFl3rcfyGsmdu83APhG1KQgWV74xlkHbk=;
        b=rHUzQGN1oDXQiPeQpek1p3d7kCGn9k4lI9JsV3ueTASIH3RxDg/huGKbwVbae+6o1+
         aWUPxtAJ6QOWXnuGWcYprmABmyAqIT00Y9cjR+OWR39GhwityhN7fmcAb1W0FX8OHdE+
         iFtX+mLdxKwNSB4n07/5g7xQHObMjMR1Hy4gdjQ1tmedfidDjZ6yPrspjGd4LEwj2OfR
         KwyQkmvN5Ssawrn+Q+P16IZoyiihxiq1dIis7PF3fYZeCDmdzJRHJLVX0bDfyyAnt1qW
         hXqB0DDCBHNcoVWp3tKmvbo+3a9aD7KNTtlZksWmDhGfUCGL3rlIiz7adu1WuXi3768E
         Eeqw==
X-Gm-Message-State: AOJu0Yw9v+yFQ7//7QTFesHcYgMem4OniT4u2OxHzTHtPFEz2ixIBAfx
	Lg7Zk5mN2dRKj3/NkD0VtU4zHcRvr+0Es6PcpAYRu2kjtq9shmNoiuxEzg==
X-Google-Smtp-Source: AGHT+IGJVfakpm67z/6merecDWZjEioE1MjlTp0I1x/17PR+xbhIKd4ub9edUmeg1BY49irbKjFprA==
X-Received: by 2002:a05:651c:154a:b0:2fb:7e65:cb27 with SMTP id 38308e7fff4ca-2fcbdf68bf5mr206616391fa.6.1730817780751;
        Tue, 05 Nov 2024 06:43:00 -0800 (PST)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6ac399bsm1366680a12.52.2024.11.05.06.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 06:43:00 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 05 Nov 2024 06:42:46 -0800
Subject: [PATCH] nvme/multipath: Fix RCU list traversal to use SRCU
 primitive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-nvme_multipath_rcu-v1-1-2d7450c1cd84@debian.org>
X-B4-Tracking: v=1; b=H4sIAOUuKmcC/x3MUQqEIBQF0K087neCOv6MW4kIs+f0oCy0YiDc+
 8CcBZwHlYtwhacHhW+psmd4Mh0hLiF/WMkMT7DaOmO0U/neeNyu9ZQjnMtY4qXe8xT0K0U3aYu
 OcBRO8v2n/dDaD8TjljtkAAAA
X-Change-ID: 20241104-nvme_multipath_rcu-9dba03fc4b02
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4084; i=leitao@debian.org;
 h=from:subject:message-id; bh=110IyjSStVOb9YuhidGQIkWZlivIid1liiPs3nyU/x8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnKi7z2MZCI4evEWx0fsjg+t99XgLdznFE4RxRu
 6YgWk4v+MOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZyou8wAKCRA1o5Of/Hh3
 bf7AEACYitXkDX7P2OopVTZSjwNnDHp4Cdydu1OXuDBL1wNFZ5+isGb0wabJAcbChKGpktkj9EE
 xuCNBnQlP7xKuHfK5ixIjJk39ISq4HEbRpsMjtEyU+i6FCfOb8FQSSzOMNKd8jGqtW+k4QFrGZ3
 Ol6yfcXpjScHjhud9Tq9tOhVRqmmKDsJ4ZiNa5m/sLoROC1/l8+dnJIupvSOiPk1dVxH9u3Mj1m
 H9PWbx0HRlPY94emLbCDnd2U1xlh+ylee4lGRmCngl2Yc6KrRDofkrbeRYD895S/rUAdWRU7UvP
 egyz767RIeuO7/2teK6uiR9AXT84hd8ixhe/eglKaSCPb8M4FgCMJ7Y3U1cSsnDjK8RavTi8h02
 YcuIwViU/1d51N8WSvqb3M3ZaGP4TkFIb4DD4bqfVX0rAEKt8cOQakuV1WxxAQ5uTyySk7XWeO1
 l4QNCuabaPTWPy8z/fHKDQ40RPLop3mHKNeeLgTCCIeaTRhHN1yCZoK8Pd088NfRAAGMTEZT2xx
 yg5iMwz38jt/WPfO2tYC/Qxu0oiTpKhtbOCBGNxyoWVvW4emIDOoEslwTcUo3oObEcs90n9VHp6
 UHBNSudn5Cjc6QevLTorpTs86BABKQdJ+EYNK+nZyjsp1ThC1w/l92n4iwni4xM3R6C1iJUl+3z
 rhu+E9xf5Qekknw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_064304_223609_843116F7 
X-CRM114-Status: GOOD (  14.01  )
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

The code currently uses list_for_each_entry_rcu() while holding an SRCU
lock, triggering false positive warnings with CONFIG_PROVE_RCU=y
enabled:

	drivers/nvme/host/multipath.c:168 RCU-list traversed in non-reader section!!
	drivers/nvme/host/multipath.c:227 RCU-list traversed in non-reader section!!
	drivers/nvme/host/multipath.c:260 RCU-list traversed in non-reader section!!

While the list is properly protected by SRCU lock, the code uses the
wrong list traversal primitive. Replace list_for_each_entry_rcu() with
list_for_each_entry_srcu() to correctly indicate SRCU-based protection
and eliminate the false warning.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: be647e2c76b2 ("nvme: use srcu for iterating namespace list")
---
 drivers/nvme/host/multipath.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6a15873055b9513f827709ad780bc7e18f75e439..f25582e4d88bb04c0f866ada11735ce562f227d4 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -165,7 +165,8 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu)) {
 		if (!ns->head->disk)
 			continue;
 		kblockd_schedule_work(&ns->head->requeue_work);
@@ -209,7 +210,8 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu)) {
 		nvme_mpath_clear_current_path(ns);
 		kblockd_schedule_work(&ns->head->requeue_work);
 	}
@@ -224,7 +226,8 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	list_for_each_entry_rcu(ns, &head->list, siblings) {
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+				 srcu_read_lock_held(&head->srcu)) {
 		if (capacity != get_capacity(ns->disk))
 			clear_bit(NVME_NS_READY, &ns->flags);
 	}
@@ -257,7 +260,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 	int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
 	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
 
-	list_for_each_entry_rcu(ns, &head->list, siblings) {
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+				 srcu_read_lock_held(&head->srcu)) {
 		if (nvme_path_is_disabled(ns))
 			continue;
 
@@ -356,7 +360,8 @@ static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
 	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
 	unsigned int depth;
 
-	list_for_each_entry_rcu(ns, &head->list, siblings) {
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+				 srcu_read_lock_held(&head->srcu)) {
 		if (nvme_path_is_disabled(ns))
 			continue;
 
@@ -424,7 +429,8 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
 		return NULL;
 
-	list_for_each_entry_rcu(ns, &head->list, siblings) {
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+				 srcu_read_lock_held(&head->srcu)) {
 		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
 			continue;
 		switch (nvme_ctrl_state(ns->ctrl)) {
@@ -785,7 +791,8 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 		return 0;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu)) {
 		unsigned nsid;
 again:
 		nsid = le32_to_cpu(desc->nsids[n]);

---
base-commit: 822eca3e06d039ea9ebf46c6192af06661f50d58
change-id: 20241104-nvme_multipath_rcu-9dba03fc4b02

Best regards,
-- 
Breno Leitao <leitao@debian.org>


