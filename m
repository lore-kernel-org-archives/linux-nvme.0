Return-Path: <SRS0=kk+z=3Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C858DC35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:42:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D1B20674
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nbzoJ7uo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBAczEGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D1B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=vyh42KSA12RudGrEnSn2hFIV50+PKYbjTwCI8Myor3k=; b=nbzoJ7uoU4agMHNAPs6o+MosxF
	9FVzhWCjKkQuP9Gm+WQ5bubbxQJmPbHQCLuG4KTUtedQ3IW5oIxk1wxMC3XYKhdJBSifzsJ99OoCG
	b6z8hMqkaG829s5QG68PJQXUraJWQ3q65TWAi3PA1JO8hx5g+B1LZsDKx3L3BQuafhhjGcZS8OlEG
	nxiOOFPiyowiol2fBXD65Yo5skooT4cIrTn7R2XooM7TA0woSv0WgoWeuihSjRHxcMd+dlPuErBTU
	IS2WmWUWga8Pv0TecvJf59wLvRFLr6Uxsb9bOLfcNxdcQv/pxco/EBuB4BhD04qkdPTInTSHaAjXC
	0G0+eGdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPd0-0007z7-QN; Wed, 05 Feb 2020 18:42:22 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPZD-0003kr-6z
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:38:31 +0000
Received: by mail-wm1-x342.google.com with SMTP id a9so4066787wmj.3
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pBivVV6gjUvC4W2YEsJWApTYZrx906zK4XhlwwQlCqk=;
 b=SBAczEGooHzOjyFKvqukfwuyNyVAs7IRtIw9H4E5gS5yS/u0O/KLGrzelRdHRO39AZ
 Cb+hJ1Alr9NW7gGAieNC4b5OckdYJAY3HkuyzqJup+a7hfhDHhVz+d7oDZH5GHulCO4O
 +phKbJyDY10aen0TYWCAPjjB+0goQuEa9xsk6DVbBNiBY9VTimSN+iPClgIJHCvgKu58
 h96rtNbMuuUhLni1Z/5GzeXxm8Hla6gxaLJ1C7XmbQiAWohqF5XpXUoIPHxKCyO/tvez
 Y94YkFhtELpkUQdRXPh4S++xt2oqsavo+7rhZ5PkkehrgUiw5H9TOUK2lZwggfZixe+D
 sorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pBivVV6gjUvC4W2YEsJWApTYZrx906zK4XhlwwQlCqk=;
 b=Izsl3yiRfLJSuUq9/CF0trNnUHPkqf0S2rvgDgOtLfMgcBZn1nORvqcIzVC8UOpIdQ
 cksqr/NuGTdcRlk1WULOtXKyB/eVKzDK6uJz4sdyOZn/cZvtGj0UESLdEQyIrboqrMVO
 g9mDlRdKnc+NF3D1Vm9ZG+PQY11de5C1uo7llNyf3H/SZT2tGS3p8tUt52FpDMG9FuiH
 qrGQiejTcBDnq9qxXhxXEK7llzv54+M2AdUYAjM+WfHFaiM3Dg2P5o5Q86ae3nZGzSjf
 FUFAqE9ikziAJd4tu3VhKVJTvZKakDQW7Yb6G6My+hD24wsdxfkJctKfZbPOmawxuAka
 R00A==
X-Gm-Message-State: APjAAAUPluvnnQ8m6enDzUr/lrB9dOdUUUXBxHzEsnyLHlqt3ZybJitn
 TKyE2ecAALHHVUeF9rYEHSMmoHi3
X-Google-Smtp-Source: APXvYqziqUaavrYU8DLQiHixJzPAb7ub3ZXsa7e2lh6R94R7Rmg8SrkFv7N3RXxXALio+jR+2gh0Cg==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr6929291wmf.75.1580927905329; 
 Wed, 05 Feb 2020 10:38:25 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:24 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 15/29] nvmet-fc: track hostport handle for associations
Date: Wed,  5 Feb 2020 10:37:39 -0800
Message-Id: <20200205183753.25959-16-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103827_473534_AEAF38D1 
X-CRM114-Status: GOOD (  21.17  )
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
Cc: James Smart <jsmart2021@gmail.com>, martin.petersen@oracle.com
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
---
 drivers/nvme/target/fc.c | 177 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 170 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 35b5cc0d2240..2c5b702a8561 100644
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
 
 
@@ -774,17 +785,114 @@ nvmet_fc_find_target_queue(struct nvmet_fc_tgtport *tgtport,
 }
 
 static void
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
+static void
 nvmet_fc_delete_assoc(struct work_struct *work)
 {
 	struct nvmet_fc_tgt_assoc *assoc =
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
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
