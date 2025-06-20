Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A45C7115B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Jun 2025 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+k/PzmZFNCcHfs5nMoe3Ogufiyy+ih/BV0Jnn4FDitc=; b=GcAwJrlq399utkZLXtYWiSyzzz
	dE6PEIwsalMmt2O69eyo8aaHwgIhbOwVLc5cPHYoj8H3KZ+D16SjM/ERv00DYsEGmHpTKU9C9RaCa
	dSZDGNSK//b4F1Tn6dthioaB07vfwKd431qI41KZTkcC2d5vWr2/Ki0PYPsvfVa8nHTTXjDzjo1Qw
	JL5hXwQiR1QOsz9BbyizjHWdymh+vsobx6ibkvoIB/+EtIulCvWbyABEghXNI5GrefJZ6P9a/PHdI
	2LdCEPDxKYQBCWPwSqOAQICrovAtcZ1+l/OgKTwiHLFzyggVy8pbpKxJ+9QMB+h2RMsGHUxwUamnw
	oH6SM6Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSfys-0000000GJ2T-1eTy;
	Fri, 20 Jun 2025 17:56:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSfyp-0000000GJ27-0Wxq
	for linux-nvme@lists.infradead.org;
	Fri, 20 Jun 2025 17:56:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750442205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+k/PzmZFNCcHfs5nMoe3Ogufiyy+ih/BV0Jnn4FDitc=;
	b=BdXlfutiMKmmiAq0IAUZz+VDq6zCEixu4pTgwTTeNRc2p2YsWJCnC6hJgT5pemx7KG8/7J
	T/9tr9RIJP9y0lpmhnjINQG0qT9ir+wWSHVgwASWRORE+eyRYEuXdjcdcA88tmnazgpjOY
	d/+oa9qmkpT2nq+L6aq9aRvFzQIROmg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-GSvEBTZqO92u5GaU2WpHpQ-1; Fri,
 20 Jun 2025 13:56:42 -0400
X-MC-Unique: GSvEBTZqO92u5GaU2WpHpQ-1
X-Mimecast-MFC-AGG-ID: GSvEBTZqO92u5GaU2WpHpQ_1750442200
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AE5B180135B;
	Fri, 20 Jun 2025 17:56:40 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.22.80.187])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7B6B1956094;
	Fri, 20 Jun 2025 17:56:36 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	njavali@marvell.com,
	linux-scsi@vger.kernel.org,
	hare@suse.de,
	bgurney@redhat.com,
	jmeneghi@redhat.com
Subject: [PATCH v6 2/6] nvme-fc: marginal path handling
Date: Fri, 20 Jun 2025 13:56:32 -0400
Message-ID: <20250620175632.34660-1-bgurney@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250620_105647_234632_79D4604B 
X-CRM114-Status: GOOD (  16.72  )
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

From: Hannes Reinecke <hare@kernel.org>

FPIN LI (link integrity) messages are received when the attached
fabric detects hardware errors. In response to these messages I/O
should be directed away from the affected ports, and only used
if the 'optimized' paths are unavailable.
To handle this a new controller flag 'NVME_CTRL_MARGINAL' is added
which will cause the multipath scheduler to skip these paths when
checking for 'optimized' paths. They are, however, still eligible
for non-optimized path selected. The flag is cleared upon reset as then the
faulty hardware might be replaced.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Tested-by: Bryan Gurney <bgurney@redhat.com>
---
 drivers/nvme/host/core.c      |  1 +
 drivers/nvme/host/fc.c        |  4 ++++
 drivers/nvme/host/multipath.c | 17 +++++++++++------
 drivers/nvme/host/nvme.h      |  6 ++++++
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3da5ac71a9b0..ac03ef7baab9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5040,6 +5040,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	WRITE_ONCE(ctrl->state, NVME_CTRL_NEW);
 	ctrl->passthru_err_log_enabled = false;
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
+	clear_bit(NVME_CTRL_MARGINAL, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->namespaces_lock);
 
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 014b387f1e8b..7e81c815bb83 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -786,6 +786,10 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 		"Reconnect", ctrl->cnum);
 
 	set_bit(ASSOC_FAILED, &ctrl->flags);
+
+	/* clear 'marginal' flag as controller will be reset */
+	clear_bit(NVME_CTRL_MARGINAL, &ctrl->flags);
+
 	nvme_reset_ctrl(&ctrl->ctrl);
 }
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 1062467595f3..003954985675 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -324,11 +324,14 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 
 		switch (ns->ana_state) {
 		case NVME_ANA_OPTIMIZED:
-			if (distance < found_distance) {
-				found_distance = distance;
-				found = ns;
+			if (!nvme_ctrl_is_marginal(ns->ctrl)) {
+				if (distance < found_distance) {
+					found_distance = distance;
+					found = ns;
+				}
+				break;
 			}
-			break;
+			fallthrough;
 		case NVME_ANA_NONOPTIMIZED:
 			if (distance < fallback_distance) {
 				fallback_distance = distance;
@@ -381,7 +384,8 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
 
 		if (ns->ana_state == NVME_ANA_OPTIMIZED) {
 			found = ns;
-			goto out;
+			if (!nvme_ctrl_is_marginal(ns->ctrl))
+				goto out;
 		}
 		if (ns->ana_state == NVME_ANA_NONOPTIMIZED)
 			found = ns;
@@ -445,7 +449,8 @@ static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
 static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 {
 	return nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE &&
-		ns->ana_state == NVME_ANA_OPTIMIZED;
+		ns->ana_state == NVME_ANA_OPTIMIZED &&
+		!nvme_ctrl_is_marginal(ns->ctrl);
 }
 
 static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7df2ea21851f..71a5c5f87db6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -275,6 +275,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_SKIP_ID_CNS_CS	= 4,
 	NVME_CTRL_DIRTY_CAPABILITY	= 5,
 	NVME_CTRL_FROZEN		= 6,
+	NVME_CTRL_MARGINAL		= 7,
 };
 
 struct nvme_ctrl {
@@ -417,6 +418,11 @@ static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
 	return READ_ONCE(ctrl->state);
 }
 
+static inline bool nvme_ctrl_is_marginal(struct nvme_ctrl *ctrl)
+{
+	return test_bit(NVME_CTRL_MARGINAL, &ctrl->flags);
+}
+
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
-- 
2.49.0


