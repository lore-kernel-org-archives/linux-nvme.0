Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4432C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Feb 2022 10:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kGtucXRlsUgdo6q5I/+fRZ6DtzeMa53DdgwCCfIIvdc=; b=HEgu7CSg7Gh6rmHfbEgP6ThU6R
	Ce8KoLh75+vog/B7sE5OePX7e/2CLq7webMCumZZT06FYI41Z3EW65yGbEEBWkbB7QsEfdJsTKgph
	TC9L39985eAdSLbOeiya3d4SI/DlpLBpceXDXm+icQbe2PkhGMJf7wa5zT3JRVNT0meQG6mWGrEs4
	VL0HaYMsDi90udbPgSs2hCrQvpUKDJjgTSps805FtUhSwjgbzDJ8kqTAsjEpNs0dq5DFLoC7isO+M
	F9Qn8kCdzLU79Mvj6/YI3Ky643QY7cUW9SduGyNV8CjqCFpBUvYobR3wU+bBNPJ74Tgobc30i/3+Y
	v3MW82YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nH0rL-009jZu-Dd; Mon, 07 Feb 2022 10:02:59 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nH0oZ-009iZL-Lj
 for linux-nvme@lists.infradead.org; Mon, 07 Feb 2022 10:00:09 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 399851F38F;
 Mon,  7 Feb 2022 10:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644228006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kGtucXRlsUgdo6q5I/+fRZ6DtzeMa53DdgwCCfIIvdc=;
 b=kQw3ZcuzAs7QgpYRHAQV5tcpimG06dMTSSSHzK3gqk4z5gX+fmzF+Uem0AW3gO8nr4rhA3
 qW/WE0bfyOKBjw0ZRS221mdFuNiwghvO33n+mkmDnB2YAGHQKoeOyLLI3GLSpi5dPOZidk
 s0qSAiHzznwAOMRTmWrSXUyiu0CqlTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644228006;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kGtucXRlsUgdo6q5I/+fRZ6DtzeMa53DdgwCCfIIvdc=;
 b=aGsfaeilpwtlOmM+TpLcJrkmC5j6PHy3CI81aMqx6SPyJazxj7jZThe4cxMjRMJ1I6QePl
 ATkuaIEur15T3iBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 0678AA3B85;
 Mon,  7 Feb 2022 10:00:06 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id E7AF75192F42; Mon,  7 Feb 2022 11:00:05 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme-multipath: add an 'ana_groups_only' module option
Date: Mon,  7 Feb 2022 11:00:05 +0100
Message-Id: <20220207100005.34404-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220207_020007_897968_E7E963C8 
X-CRM114-Status: GOOD (  17.53  )
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

On large installations the ANA log buffer can be exceedingly large;
we've come across a controller with 49 ANA Group Descriptors and
65536 namespaces, resulting in an ANA buffer with an order-7 allocation.
And this is just to validate that the namespace ID is _really_listed
in the log page.
So to avoid an overly large memory allocation we can leverage the
'RGO' bit when retrieving the ANA log page, and check whether the
ANA group ID from the namespace is found in the ANA descriptors.
That cuts down the memory allocation, and provides the same result.
But to be on the safe side I've added a module option 'ana_groups_only'
to switch between modes.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/multipath.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 7f2071f2460c..bffa56c4fc83 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -13,6 +13,11 @@ module_param(multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
 
+static bool ana_groups_only = false;
+module_param(ana_groups_only, bool, 0644);
+MODULE_PARM_DESC(ana_groups_only,
+		 "Retrieve ANA Log page with groups only (RGO bit set)");
+
 void nvme_mpath_unfreeze(struct nvme_subsystem *subsys)
 {
 	struct nvme_ns_head *h;
@@ -556,13 +561,14 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 	for (i = 0; i < le16_to_cpu(ctrl->ana_log_buf->ngrps); i++) {
 		struct nvme_ana_group_desc *desc = base + offset;
 		u32 nr_nsids;
-		size_t nsid_buf_size;
+		size_t nsid_buf_size = 0;
 
 		if (WARN_ON_ONCE(offset > ctrl->ana_log_size - sizeof(*desc)))
 			return -EINVAL;
 
 		nr_nsids = le32_to_cpu(desc->nnsids);
-		nsid_buf_size = flex_array_size(desc, nsids, nr_nsids);
+		if (nr_nsids)
+			nsid_buf_size = flex_array_size(desc, nsids, nr_nsids);
 
 		if (WARN_ON_ONCE(desc->grpid == 0))
 			return -EINVAL;
@@ -617,8 +623,17 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	if (desc->state == NVME_ANA_CHANGE)
 		(*nr_change_groups)++;
 
-	if (!nr_nsids)
+	if (!nr_nsids) {
+		if (!ana_groups_only)
+			return 0;
+		down_read(&ctrl->namespaces_rwsem);
+		list_for_each_entry(ns, &ctrl->namespaces, list) {
+			if (ns->ana_grpid == le32_to_cpu(desc->grpid))
+				nvme_update_ns_ana_state(desc, ns);
+		}
+		up_read(&ctrl->namespaces_rwsem);
 		return 0;
+	}
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
@@ -644,7 +659,8 @@ static int nvme_read_ana_log(struct nvme_ctrl *ctrl)
 	int error;
 
 	mutex_lock(&ctrl->ana_lock);
-	error = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_ANA, 0, NVME_CSI_NVM,
+	error = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_ANA,
+			ana_groups_only ? NVME_ANA_LOG_RGO : 0, NVME_CSI_NVM,
 			ctrl->ana_log_buf, ctrl->ana_log_size, 0);
 	if (error) {
 		dev_warn(ctrl->device, "Failed to get ANA log: %d\n", error);
@@ -855,8 +871,10 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	ctrl->anagrpmax = le32_to_cpu(id->anagrpmax);
 
 	ana_log_size = sizeof(struct nvme_ana_rsp_hdr) +
-		ctrl->nanagrpid * sizeof(struct nvme_ana_group_desc) +
-		ctrl->max_namespaces * sizeof(__le32);
+		ctrl->nanagrpid * sizeof(struct nvme_ana_group_desc);
+	if (!ana_groups_only)
+		ana_log_size += ctrl->max_namespaces * sizeof(__le32);
+
 	if (ana_log_size > max_transfer_size) {
 		dev_err(ctrl->device,
 			"ANA log page size (%zd) larger than MDTS (%zd).\n",
-- 
2.29.2


