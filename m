Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3649CEF177
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 13:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9WsNEK3SzrgBNgbl3Pp0UqAn16HQlFPdCzP2CrKTwxQ=; b=cVjVxDTtJEJI9P1HH1G57KrTbN
	PmNkIqm1Q+T0M9t4BbUTZ6XZSe5uGOndJ0bjIY/rYXxNPcdxGGJpIyoRxTShEQGf+SQHV4mIS917I
	zBE78buvdsvkjrWphjMv5zj5uihIsvNXU6meuOAhrU2xTP79D+ygmFWxyMQ59rS2ybRivIFiuqoqg
	mPZ/9n8cS4Uupj4l5U5JIQRv32V9K5tbgGYTYeW9JWXJdA6dvTJqthxRMPYkSKsx1m5Q/gYb3HQqS
	k+KfH/EH22s8gVLiRWDdaOrnxt0zEnd75s36zXVQfD8BGD3PQmkbTH2/atJvwPVxZ3bnQw/IU+7ug
	oFRoqQAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syAig-000000065Jv-0Zpk;
	Tue, 08 Oct 2024 13:57:46 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syAib-000000065IU-1f38
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 13:57:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C1A25A41D9E;
	Tue,  8 Oct 2024 13:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B92C4CECE;
	Tue,  8 Oct 2024 13:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728395860;
	bh=lrv1F10F9Lc+dt5ageIRPEr/KZWGfeWIU4QNpTYC3gQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UPVPMMaXCfK3MFItCuN55F1tRg0SXJ+wXndnV0MA7h/red/upwN/NyUnFxDNVnjcu
	 sksMd9ZloBi0lXrQEE6TV7f1Olp4HutOSeFj3VdkUSQXB3bmhUe/oFVVJb3Sy0M1ow
	 SRnzKDPdQYMsEKBy+qHjDb1uZTFN096jwuGV2lSD9gRlSBCd0ZNQvJui8Nt0GPGnDZ
	 D30gNo2IZmF1Sb1sPZaa1+xbwtE9wpPO2UyjPjMvT4L90fLMoXNduplJWvVkXzJHA/
	 vO2QbyoJBlzuh6ONRyhf+KzDQxqYHtmqYsORz8pc4RbnYiH/oEQ/qgNeaDb2F+urLU
	 lxLVSG1Fm1NhA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/2] nvme: propagate I/O errors during partition scan
Date: Tue,  8 Oct 2024 15:57:28 +0200
Message-Id: <20241008135729.68810-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241008135729.68810-1-hare@kernel.org>
References: <20241008135729.68810-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_065741_587652_F42BCC71 
X-CRM114-Status: GOOD (  21.93  )
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

Partition scan is triggered from device_add_disk(), and is needs to
terminate such the namespace scanning can continue.
This patch adds two new flags NVME_NSHEAD_DISK_SCAN to signal that
the 'head' device is currently in partition scan, and NVME_NS_SCAN_FAILED
to signal that I/O errors had been encountered on the namespace during
partition scan.
With these flags we can modify the failover mechanism to count any namespace
with NVME_NS_SCAN_FAILED as a disabled path, and to not queue commands when
all paths are disabled and NVME_NSHEAD_DISK_SCAN is set.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/core.c      | 26 ++++++++++++++++++++------
 drivers/nvme/host/multipath.c | 18 ++++++++++++++++++
 drivers/nvme/host/nvme.h      |  2 ++
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 651073280f6f..d8581ddd9a2e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4007,8 +4007,10 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 	 *
 	 * TODO: we should probably schedule a delayed retry here.
 	 */
-	if (ret > 0 && (ret & NVME_STATUS_DNR))
+	if (ret > 0 && (ret & NVME_STATUS_DNR)) {
+		set_bit(NVME_NS_SCAN_FAILED, &ns->flags);
 		nvme_ns_remove(ns);
+	}
 }
 
 static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
@@ -4017,8 +4019,14 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	struct nvme_ns *ns;
 	int ret;
 
-	if (nvme_identify_ns_descs(ctrl, &info))
+	ns = nvme_find_get_ns(ctrl, nsid);
+	if (nvme_identify_ns_descs(ctrl, &info)) {
+		if (ns) {
+			set_bit(NVME_NS_SCAN_FAILED, &ns->flags);
+			nvme_put_ns(ns);
+		}
 		return;
+	}
 
 	if (info.ids.csi != NVME_CSI_NVM && !nvme_multi_css(ctrl)) {
 		dev_warn(ctrl->device,
@@ -4037,17 +4045,23 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	else
 		ret = nvme_ns_info_from_identify(ctrl, &info);
 
-	if (info.is_removed)
-		nvme_ns_remove_by_nsid(ctrl, nsid);
+	if (info.is_removed && ns) {
+		nvme_ns_remove(ns);
+		nvme_put_ns(ns);
+	}
 
 	/*
 	 * Ignore the namespace if it is not ready. We will get an AEN once it
 	 * becomes ready and restart the scan.
 	 */
-	if (ret || !info.is_ready)
+	if (ret || !info.is_ready) {
+		if (ret > 0 && ns) {
+			set_bit(NVME_NS_SCAN_FAILED, &ns->flags);
+			nvme_put_ns(ns);
+		}
 		return;
+	}
 
-	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
 		nvme_validate_ns(ns, &info);
 		nvme_put_ns(ns);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f72c5a6a2d8e..68eb1df98419 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -92,6 +92,13 @@ void nvme_failover_req(struct request *req)
 
 	nvme_mpath_clear_current_path(ns);
 
+	/*
+	 * Mark the namespace with NS_SCAN_FAILED to ensure
+	 * I/O can be aborted during partition scan.
+	 */
+	if (test_bit(NVME_NSHEAD_DISK_SCAN, &ns->head->flags))
+		set_bit(NVME_NS_SCAN_FAILED, &ns->flags);
+
 	/*
 	 * If we got back an ANA error, we know the controller is alive but not
 	 * ready to serve this namespace.  Kick of a re-read of the ANA
@@ -227,6 +234,7 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
 		if (capacity != get_capacity(ns->disk))
 			clear_bit(NVME_NS_READY, &ns->flags);
+		clear_bit(NVME_NS_SCAN_FAILED, &ns->flags);
 	}
 	srcu_read_unlock(&head->srcu, srcu_idx);
 
@@ -239,6 +247,12 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
 {
 	enum nvme_ctrl_state state = nvme_ctrl_state(ns->ctrl);
 
+	if (test_bit(NVME_NSHEAD_DISK_SCAN, &ns->head->flags)) {
+		if (state == NVME_CTRL_DELETING ||
+		    test_bit(NVME_NS_SCAN_FAILED, &ns->flags))
+			return true;
+	}
+
 	/*
 	 * We don't treat NVME_CTRL_DELETING as a disabled path as I/O should
 	 * still be able to complete assuming that the controller is connected.
@@ -423,6 +437,8 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 
 	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
 		return NULL;
+	if (test_bit(NVME_NSHEAD_DISK_SCAN, &head->flags))
+		return NULL;
 
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
 		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
@@ -646,8 +662,10 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	 * head.
 	 */
 	if (!test_and_set_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
+		set_bit(NVME_NSHEAD_DISK_SCAN, &head->flags);
 		rc = device_add_disk(&head->subsys->dev, head->disk,
 				     nvme_ns_attr_groups);
+		clear_bit(NVME_NSHEAD_DISK_SCAN, &head->flags);
 		if (rc) {
 			clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags);
 			return;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 50515ad0f9d6..6089528d5eb8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -493,6 +493,7 @@ struct nvme_ns_head {
 	struct mutex		lock;
 	unsigned long		flags;
 #define NVME_NSHEAD_DISK_LIVE	0
+#define NVME_NSHEAD_DISK_SCAN	1
 	struct nvme_ns __rcu	*current_path[];
 #endif
 };
@@ -527,6 +528,7 @@ struct nvme_ns {
 #define NVME_NS_ANA_PENDING	2
 #define NVME_NS_FORCE_RO	3
 #define NVME_NS_READY		4
+#define NVME_NS_SCAN_FAILED	5
 
 	struct cdev		cdev;
 	struct device		cdev_device;
-- 
2.35.3


