Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9BEC2D0EE
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:53:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D67DC206CC
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AeDlZ8b/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tECeffKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67DC206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=AprS7Mipo0Q2QDuM6sqxvXPf+Y4oJ1DH7RnhAUVHFAs=; b=AeDlZ8b/TVc44+ZEPMUO98xZT2
	XxvGbV8sQMzn0hRjAn8o8pbTi5Q6KrDw4N5Bd9Bu/sbiEVb0yGi4PoT7PyZqL0A7jy3SWGhUSNY2E
	ik4J9ze3cAbqlPzSI/xBz5vZRrSh5x8iM7+GeXvUGhiimGtZGjW0nD3AG0MqmlLHEac2vkTMPT743
	ESljg9Kyy+jwxH/Is5cnALQ9bTyaPJQ15p6XZwjoCnEC2Jhygky3JX28SoVDPudJtqcCxhLjPPq8D
	55bbN9eqxXxzcDMMtzMRtA0ckm2gYwWVYjnsM80cPOQSXVeH/oq9bcGadSw1SDfqt5E4lf45BvTX0
	QcGJDsYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJK8z-0006bp-BP; Tue, 31 Mar 2020 16:53:41 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK65-0004kK-8u
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:50:45 +0000
Received: by mail-wm1-x342.google.com with SMTP id g62so3630416wme.1
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 09:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YXzUeNaUG8stK+cLPdXF2q9aGOjJnHdDb3LANWprF1M=;
 b=tECeffKnm1tuiiWkL4PVjkEkXKn9zf/HzIfuAMkhbnuAI7+0FoxeCniMFJqIUcoEcl
 X0mkB1YwxZHctjFVj3/bV8d4KSeH7aNeY+hSZ3r4wkNrs17OITNLGQjr7ycwdWKG2Iks
 QznTPBaaR/J2fwJpS+K/UYHc+G39yMK4rS7tOHPy/3EqznADuZNEeaX94S5ZfgVvm6TA
 4olE7iT1fTRekaGE4YLDORKKIlzYlC2o1xvhhBa2rOV4OUe91bEfh+14qujzJYy8XKtE
 iWtdbmtlGhnu/uJ2wJrtTSYLsLOtRkoQFHNI64WGl5HWwX7ImmW7qVIY2QrzK756IFWz
 0NVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YXzUeNaUG8stK+cLPdXF2q9aGOjJnHdDb3LANWprF1M=;
 b=FW2GVL+3WY9hS9mPr0MTMpIgysqLggxMAJT6AfSTLuehwSvk9VuLOeLfSZkeDflFj0
 BAYc/RJ6ESX8O7JOX2ohOFGk+tKOWYzzc7xiREpr+31LjNt8f3lCD5zH9OWt5sZ/koq5
 vBs0h9E4g6KOcF96cYMPoGlyz9zTbdUxnnZ0sn5IrWe63QPHiTu0P2VfJ2ePxLDvmeY7
 wlFDYNTZJHCqCTEq/6FjYHLlRSM0ljUASCTLzMVrYR9ojKKx69SGcF5cQdjjorGyL2rX
 ZVY1Fz0W5/WpzMjao+vfaa/4DHrxU/tR+wMCHSL9OW94ZFVjMuwOvIkXpbi0dAw99hmu
 HqHg==
X-Gm-Message-State: ANhLgQ27++zkTBM3W1jJtrPY5p5DqYvOXD7iMGjH2/HnrPMmFAEshEaK
 9hJuxDAGwBQB76oiiaHOZAfQnIdX
X-Google-Smtp-Source: ADFU+vvMTjK3t0M9dOGSKnx2Mb5hyHnd//b3fLTUbGh+pjd04QI8hlylKSArpEqYbqF3GIkBC9a2lw==
X-Received: by 2002:a05:600c:2611:: with SMTP id
 h17mr4499932wma.183.1585673439313; 
 Tue, 31 Mar 2020 09:50:39 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r14sm2711582wmg.0.2020.03.31.09.50.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:50:38 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 12/26] nvmet-fc: track hostport handle for associations
Date: Tue, 31 Mar 2020 09:49:57 -0700
Message-Id: <20200331165011.15819-13-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200331165011.15819-1-jsmart2021@gmail.com>
References: <20200331165011.15819-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_095041_473288_2B6ABB85 
X-CRM114-Status: GOOD (  21.48  )
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
Cc: James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In preparation for sending LS requests for an association that
terminates, save and track the hosthandle that is part of the
LS's that are received to create associations.

Support consists of:
- Create a hostport structure that will be 1:1 mapped to a
  host port handle. The hostport structure is specific to
  a targetport.
- Whenever an association is created, create a host port for
  the hosthandle the Create Association LS was received from.
  There will be only 1 hostport structure created, with all
  associations that have the same hosthandle sharing the
  hostport structure.
- When the association is terminated, the hostport reference
  will be removed. After the last association for the host
  port is removed, the hostport will be deleted.
- Add support for the new nvmet_fc_invalidate_host() interface.
  In the past, the LLDD didn't notify loss of connectivity to
  host ports - the LLD would simply reject new requests and wait
  for the kato timeout to kill the association. Now, when host
  port connectivity is lost, the LLDD can notify the transport.
  The transport will initiate the termination of all associations
  for that host port. When the last association has been terminated
  and the hosthandle will no longer be referenced, the new
  host_release callback will be made to the lldd.
- For compatibility with prior behavior which didn't report the
  hosthandle:  the LLDD must set hosthandle to NULL. In these
  cases, not LS request will be made, and no host_release callbacks
  will be made either.

Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/fc.c | 177 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 170 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 01488fc35d46..3ccf27c328b2 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -33,6 +33,7 @@ struct nvmet_fc_ls_iod {
 
 	struct nvmet_fc_tgtport		*tgtport;
 	struct nvmet_fc_tgt_assoc	*assoc;
+	void				*hosthandle;
 
 	union nvmefc_ls_requests	*rqstbuf;
 	union nvmefc_ls_responses	*rspbuf;
@@ -81,7 +82,6 @@ struct nvmet_fc_fcp_iod {
 };
 
 struct nvmet_fc_tgtport {
-
 	struct nvmet_fc_target_port	fc_target_port;
 
 	struct list_head		tgt_list; /* nvmet_fc_target_list */
@@ -93,6 +93,7 @@ struct nvmet_fc_tgtport {
 	struct list_head		ls_list;
 	struct list_head		ls_busylist;
 	struct list_head		assoc_list;
+	struct list_head		host_list;
 	struct ida			assoc_cnt;
 	struct nvmet_fc_port_entry	*pe;
 	struct kref			ref;
@@ -134,14 +135,24 @@ struct nvmet_fc_tgt_queue {
 	struct nvmet_fc_fcp_iod		fod[];		/* array of fcp_iods */
 } __aligned(sizeof(unsigned long long));
 
+struct nvmet_fc_hostport {
+	struct nvmet_fc_tgtport		*tgtport;
+	void				*hosthandle;
+	struct list_head		host_list;
+	struct kref			ref;
+	u8				invalid;
+};
+
 struct nvmet_fc_tgt_assoc {
 	u64				association_id;
 	u32				a_id;
 	struct nvmet_fc_tgtport		*tgtport;
+	struct nvmet_fc_hostport	*hostport;
 	struct list_head		a_list;
 	struct nvmet_fc_tgt_queue	*queues[NVMET_NR_QUEUES + 1];
 	struct kref			ref;
 	struct work_struct		del_work;
+	atomic_t			del_work_active;
 };
 
 
@@ -773,6 +784,102 @@ nvmet_fc_find_target_queue(struct nvmet_fc_tgtport *tgtport,
 	return NULL;
 }
 
+static void
+nvmet_fc_hostport_free(struct kref *ref)
+{
+	struct nvmet_fc_hostport *hostport =
+		container_of(ref, struct nvmet_fc_hostport, ref);
+	struct nvmet_fc_tgtport *tgtport = hostport->tgtport;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tgtport->lock, flags);
+	list_del(&hostport->host_list);
+	spin_unlock_irqrestore(&tgtport->lock, flags);
+	if (tgtport->ops->host_release && hostport->invalid)
+		tgtport->ops->host_release(hostport->hosthandle);
+	kfree(hostport);
+	nvmet_fc_tgtport_put(tgtport);
+}
+
+static void
+nvmet_fc_hostport_put(struct nvmet_fc_hostport *hostport)
+{
+	kref_put(&hostport->ref, nvmet_fc_hostport_free);
+}
+
+static int
+nvmet_fc_hostport_get(struct nvmet_fc_hostport *hostport)
+{
+	return kref_get_unless_zero(&hostport->ref);
+}
+
+static void
+nvmet_fc_free_hostport(struct nvmet_fc_hostport *hostport)
+{
+	/* if LLDD not implemented, leave as NULL */
+	if (!hostport->hosthandle)
+		return;
+
+	nvmet_fc_hostport_put(hostport);
+}
+
+static struct nvmet_fc_hostport *
+nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
+{
+	struct nvmet_fc_hostport *newhost, *host, *match = NULL;
+	unsigned long flags;
+
+	/* if LLDD not implemented, leave as NULL */
+	if (!hosthandle)
+		return NULL;
+
+	/* take reference for what will be the newly allocated hostport */
+	if (!nvmet_fc_tgtport_get(tgtport))
+		return ERR_PTR(-EINVAL);
+
+	newhost = kzalloc(sizeof(*newhost), GFP_KERNEL);
+	if (!newhost) {
+		spin_lock_irqsave(&tgtport->lock, flags);
+		list_for_each_entry(host, &tgtport->host_list, host_list) {
+			if (host->hosthandle == hosthandle && !host->invalid) {
+				if (nvmet_fc_hostport_get(host)) {
+					match = host;
+					break;
+				}
+			}
+		}
+		spin_unlock_irqrestore(&tgtport->lock, flags);
+		/* no allocation - release reference */
+		nvmet_fc_tgtport_put(tgtport);
+		return (match) ? match : ERR_PTR(-ENOMEM);
+	}
+
+	newhost->tgtport = tgtport;
+	newhost->hosthandle = hosthandle;
+	INIT_LIST_HEAD(&newhost->host_list);
+	kref_init(&newhost->ref);
+
+	spin_lock_irqsave(&tgtport->lock, flags);
+	list_for_each_entry(host, &tgtport->host_list, host_list) {
+		if (host->hosthandle == hosthandle && !host->invalid) {
+			if (nvmet_fc_hostport_get(host)) {
+				match = host;
+				break;
+			}
+		}
+	}
+	if (match) {
+		kfree(newhost);
+		newhost = NULL;
+		/* releasing allocation - release reference */
+		nvmet_fc_tgtport_put(tgtport);
+	} else
+		list_add_tail(&newhost->host_list, &tgtport->host_list);
+	spin_unlock_irqrestore(&tgtport->lock, flags);
+
+	return (match) ? match : newhost;
+}
+
 static void
 nvmet_fc_delete_assoc(struct work_struct *work)
 {
@@ -780,11 +887,12 @@ nvmet_fc_delete_assoc(struct work_struct *work)
 		container_of(work, struct nvmet_fc_tgt_assoc, del_work);
 
 	nvmet_fc_delete_target_assoc(assoc);
+	atomic_set(&assoc->del_work_active, 0);
 	nvmet_fc_tgt_a_put(assoc);
 }
 
 static struct nvmet_fc_tgt_assoc *
-nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport)
+nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 {
 	struct nvmet_fc_tgt_assoc *assoc, *tmpassoc;
 	unsigned long flags;
@@ -801,13 +909,18 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport)
 		goto out_free_assoc;
 
 	if (!nvmet_fc_tgtport_get(tgtport))
-		goto out_ida_put;
+		goto out_ida;
+
+	assoc->hostport = nvmet_fc_alloc_hostport(tgtport, hosthandle);
+	if (IS_ERR(assoc->hostport))
+		goto out_put;
 
 	assoc->tgtport = tgtport;
 	assoc->a_id = idx;
 	INIT_LIST_HEAD(&assoc->a_list);
 	kref_init(&assoc->ref);
 	INIT_WORK(&assoc->del_work, nvmet_fc_delete_assoc);
+	atomic_set(&assoc->del_work_active, 0);
 
 	while (needrandom) {
 		get_random_bytes(&ran, sizeof(ran) - BYTES_FOR_QID);
@@ -829,7 +942,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport)
 
 	return assoc;
 
-out_ida_put:
+out_put:
+	nvmet_fc_tgtport_put(tgtport);
+out_ida:
 	ida_simple_remove(&tgtport->assoc_cnt, idx);
 out_free_assoc:
 	kfree(assoc);
@@ -844,6 +959,7 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 	unsigned long flags;
 
+	nvmet_fc_free_hostport(assoc->hostport);
 	spin_lock_irqsave(&tgtport->lock, flags);
 	list_del(&assoc->a_list);
 	spin_unlock_irqrestore(&tgtport->lock, flags);
@@ -1057,6 +1173,7 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 	INIT_LIST_HEAD(&newrec->ls_list);
 	INIT_LIST_HEAD(&newrec->ls_busylist);
 	INIT_LIST_HEAD(&newrec->assoc_list);
+	INIT_LIST_HEAD(&newrec->host_list);
 	kref_init(&newrec->ref);
 	ida_init(&newrec->assoc_cnt);
 	newrec->max_sg_cnt = template->max_sgl_segments;
@@ -1133,14 +1250,21 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
 {
 	struct nvmet_fc_tgt_assoc *assoc, *next;
 	unsigned long flags;
+	int ret;
 
 	spin_lock_irqsave(&tgtport->lock, flags);
 	list_for_each_entry_safe(assoc, next,
 				&tgtport->assoc_list, a_list) {
 		if (!nvmet_fc_tgt_a_get(assoc))
 			continue;
-		if (!schedule_work(&assoc->del_work))
+		ret = atomic_cmpxchg(&assoc->del_work_active, 0, 1);
+		if (ret == 0) {
+			if (!schedule_work(&assoc->del_work))
+				nvmet_fc_tgt_a_put(assoc);
+		} else {
+			/* already deleting - release local reference */
 			nvmet_fc_tgt_a_put(assoc);
+		}
 	}
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 }
@@ -1178,6 +1302,36 @@ void
 nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
 			void *hosthandle)
 {
+	struct nvmet_fc_tgtport *tgtport = targetport_to_tgtport(target_port);
+	struct nvmet_fc_tgt_assoc *assoc, *next;
+	unsigned long flags;
+	bool noassoc = true;
+	int ret;
+
+	spin_lock_irqsave(&tgtport->lock, flags);
+	list_for_each_entry_safe(assoc, next,
+				&tgtport->assoc_list, a_list) {
+		if (!assoc->hostport ||
+		    assoc->hostport->hosthandle != hosthandle)
+			continue;
+		if (!nvmet_fc_tgt_a_get(assoc))
+			continue;
+		assoc->hostport->invalid = 1;
+		noassoc = false;
+		ret = atomic_cmpxchg(&assoc->del_work_active, 0, 1);
+		if (ret == 0) {
+			if (!schedule_work(&assoc->del_work))
+				nvmet_fc_tgt_a_put(assoc);
+		} else {
+			/* already deleting - release local reference */
+			nvmet_fc_tgt_a_put(assoc);
+		}
+	}
+	spin_unlock_irqrestore(&tgtport->lock, flags);
+
+	/* if there's nothing to wait for - call the callback */
+	if (noassoc && tgtport->ops->host_release)
+		tgtport->ops->host_release(hosthandle);
 }
 EXPORT_SYMBOL_GPL(nvmet_fc_invalidate_host);
 
@@ -1192,6 +1346,7 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 	struct nvmet_fc_tgt_queue *queue;
 	unsigned long flags;
 	bool found_ctrl = false;
+	int ret;
 
 	/* this is a bit ugly, but don't want to make locks layered */
 	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
@@ -1215,8 +1370,14 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 		nvmet_fc_tgtport_put(tgtport);
 
 		if (found_ctrl) {
-			if (!schedule_work(&assoc->del_work))
+			ret = atomic_cmpxchg(&assoc->del_work_active, 0, 1);
+			if (ret == 0) {
+				if (!schedule_work(&assoc->del_work))
+					nvmet_fc_tgt_a_put(assoc);
+			} else {
+				/* already deleting - release local reference */
 				nvmet_fc_tgt_a_put(assoc);
+			}
 			return;
 		}
 
@@ -1293,7 +1454,8 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 
 	else {
 		/* new association w/ admin queue */
-		iod->assoc = nvmet_fc_alloc_target_assoc(tgtport);
+		iod->assoc = nvmet_fc_alloc_target_assoc(
+						tgtport, iod->hosthandle);
 		if (!iod->assoc)
 			ret = VERR_ASSOC_ALLOC_FAIL;
 		else {
@@ -1628,6 +1790,7 @@ nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *target_port,
 	iod->fcpreq = NULL;
 	memcpy(iod->rqstbuf, lsreqbuf, lsreqbuf_len);
 	iod->rqstdatalen = lsreqbuf_len;
+	iod->hosthandle = hosthandle;
 
 	schedule_work(&iod->work);
 
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
