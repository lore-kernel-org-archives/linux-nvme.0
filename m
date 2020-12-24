Return-Path: <SRS0=K5Lp=F4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FF5C433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Dec 2020 11:06:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7E32222D
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Dec 2020 11:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7E32222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dlbyuF/RnHhudboDUc1LXKtJwxz1H3KpHtc+PVnxAJc=; b=RvnN8S9pvzK2Cj7zFMnWmqnHJ/
	FK3c/pWChd4MTEKhrHE2w7hio3OzMssxXKQjdG3jOKHcmffx0kxkZXx5o5D+Og16SSQYo4RRz66L+
	c2hN8u2lFLWQ1E8lhPuipqrZUQGk1ZIgnaoOOvFfLL9Hvold7V/9TI1KwcYt0CI5qkHCVQDJVKpDx
	ijZokE4NN8UG0xka/WsWIEV1eADf464rDg/rYqZEHYmsJmRmMJ4poq5ZUFDR1PBIW/S58x9G/s5oU
	D5l9KgpbcyNryRxwigvapnwERoS4/XqQOj4pyDvg74Dk3o5VAAmE3cWvYwGE5YwidxEhJXrJ1sP+5
	O864fejw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ksORp-0001tV-DD; Thu, 24 Dec 2020 11:06:21 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ksORl-0001sm-CT
 for linux-nvme@lists.infradead.org; Thu, 24 Dec 2020 11:06:19 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0BOB3E8P016443
 for <linux-nvme@lists.infradead.org>; Thu, 24 Dec 2020 06:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=v0/HAblaSot77F3n7el3TvOALx5ZhAeoYJj1o93ojNQ=;
 b=sHwPO6IYFydJPSf/6v85biv/4VXOHoYRidEctNAAI5RQxPAunySYWYy0qXBOiccSdnzu
 LcMZAWpXJPPSFdl2sgfgrpvAlmojKOoffoeQtCrZvwiJRWa2xOOhTcLrkqpoWCw5tBTW
 NY5LeAIbNNXk8I7V9RBvQtEYrbKm85eqgAWhwFwvD1ict5eksYgqibTJZXKwloMFC+Jo
 EvojYntsi6g3ILShusEjOL8uyPKvN7y/yqnvmh+m4hQk4GSdVYLrXJ9z59u9MWcLrEDS
 tEO0dw4N2DmCub/Wgsqy2KXn/NwzunR9FKrs41Bz7Mua+NGWB6bg8FhJyN+6H/B+g2Yo Nw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 35k0e127un-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Thu, 24 Dec 2020 06:06:16 -0500
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0BOB2ekA111888
 for <linux-nvme@lists.infradead.org>; Thu, 24 Dec 2020 06:06:16 -0500
Received: from esaploutdur05.us.dell.com ([128.221.233.10])
 by mx0a-00154901.pphosted.com with ESMTP id 35m99gsrj2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Thu, 24 Dec 2020 06:06:16 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.160.55
Received: from unknown (HELO arwen6.xiolab.lab.emc.com) ([10.55.160.55])
 by esaploutdur05.us.dell.com with ESMTP; 24 Dec 2020 05:06:13 -0600
From: leonid.ravich@dell.com
To: james.smart@broadcom.com
Subject: [PATCH] nvmet-fc: associations list replaced with hlist rcu,
Date: Thu, 24 Dec 2020 13:05:41 +0200
Message-Id: <20201224110542.22219-2-leonid.ravich@dell.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20201224110542.22219-1-leonid.ravich@dell.com>
References: <20201224110542.22219-1-leonid.ravich@dell.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2020-12-24_06:2020-12-24,
 2020-12-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=950 spamscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012240069
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012240069
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201224_060617_564938_EC18549A 
X-CRM114-Status: GOOD (  19.02  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Leonid Ravich <Leonid.Ravich@dell.com>,
 Christoph Hellwig <hch@lst.de>, lravich@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Leonid Ravich <Leonid.Ravich@emc.com>

to remove locking from nvmet_fc_find_target_queue
which called per IO.

Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
---
 drivers/nvme/target/fc.c | 54 ++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index cd4e73aa9807..3928a17d073c 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -105,7 +105,7 @@ struct nvmet_fc_tgtport {
 	struct list_head		ls_rcv_list;
 	struct list_head		ls_req_list;
 	struct list_head		ls_busylist;
-	struct list_head		assoc_list;
+	struct hlist_head		assoc_list;
 	struct list_head		host_list;
 	struct ida			assoc_cnt;
 	struct nvmet_fc_port_entry	*pe;
@@ -163,10 +163,11 @@ struct nvmet_fc_tgt_assoc {
 	struct nvmet_fc_tgtport		*tgtport;
 	struct nvmet_fc_hostport	*hostport;
 	struct nvmet_fc_ls_iod		*rcv_disconn;
-	struct list_head		a_list;
+	struct hlist_node		a_list;
 	struct nvmet_fc_tgt_queue	*queues[NVMET_NR_QUEUES + 1];
 	struct kref			ref;
 	struct work_struct		del_work;
+	struct rcu_head		rcu_head;
 };
 
 
@@ -965,24 +966,23 @@ nvmet_fc_find_target_queue(struct nvmet_fc_tgtport *tgtport,
 	struct nvmet_fc_tgt_queue *queue;
 	u64 association_id = nvmet_fc_getassociationid(connection_id);
 	u16 qid = nvmet_fc_getqueueid(connection_id);
-	unsigned long flags;
 
 	if (qid > NVMET_NR_QUEUES)
 		return NULL;
 
-	spin_lock_irqsave(&tgtport->lock, flags);
-	list_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
 		if (association_id == assoc->association_id) {
 			queue = assoc->queues[qid];
 			if (queue &&
 			    (!atomic_read(&queue->connected) ||
 			     !nvmet_fc_tgt_q_get(queue)))
 				queue = NULL;
-			spin_unlock_irqrestore(&tgtport->lock, flags);
+			rcu_read_unlock();
 			return queue;
 		}
 	}
-	spin_unlock_irqrestore(&tgtport->lock, flags);
+	rcu_read_unlock();
 	return NULL;
 }
 
@@ -1118,7 +1118,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 
 	assoc->tgtport = tgtport;
 	assoc->a_id = idx;
-	INIT_LIST_HEAD(&assoc->a_list);
+	INIT_HLIST_NODE(&assoc->a_list);
 	kref_init(&assoc->ref);
 	INIT_WORK(&assoc->del_work, nvmet_fc_delete_assoc);
 	atomic_set(&assoc->terminating, 0);
@@ -1129,7 +1129,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 
 		spin_lock_irqsave(&tgtport->lock, flags);
 		needrandom = false;
-		list_for_each_entry(tmpassoc, &tgtport->assoc_list, a_list) {
+		hlist_for_each_entry(tmpassoc, &tgtport->assoc_list, a_list) {
 			if (ran == tmpassoc->association_id) {
 				needrandom = true;
 				break;
@@ -1137,7 +1137,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		}
 		if (!needrandom) {
 			assoc->association_id = ran;
-			list_add_tail(&assoc->a_list, &tgtport->assoc_list);
+			hlist_add_tail_rcu(&assoc->a_list, &tgtport->assoc_list);
 		}
 		spin_unlock_irqrestore(&tgtport->lock, flags);
 	}
@@ -1153,6 +1153,17 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	return NULL;
 }
 
+void nvmet_assoc_free_queue_rcu(struct rcu_head *rcu_head) {
+	struct nvmet_fc_tgt_assoc *assoc =
+		container_of(rcu_head, struct nvmet_fc_tgt_assoc, rcu_head);
+	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
+
+	kfree(assoc);
+	dev_info(tgtport->dev,
+		"{%d:%d} Association freed\n",
+		tgtport->fc_target_port.port_num, assoc->a_id);
+}
+
 static void
 nvmet_fc_target_assoc_free(struct kref *ref)
 {
@@ -1167,17 +1178,14 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 
 	nvmet_fc_free_hostport(assoc->hostport);
 	spin_lock_irqsave(&tgtport->lock, flags);
-	list_del(&assoc->a_list);
+	hlist_del_rcu(&assoc->a_list);
 	oldls = assoc->rcv_disconn;
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 	/* if pending Rcv Disconnect Association LS, send rsp now */
 	if (oldls)
 		nvmet_fc_xmt_ls_rsp(tgtport, oldls);
 	ida_simple_remove(&tgtport->assoc_cnt, assoc->a_id);
-	dev_info(tgtport->dev,
-		"{%d:%d} Association freed\n",
-		tgtport->fc_target_port.port_num, assoc->a_id);
-	kfree(assoc);
+	call_rcu(&assoc->rcu_head, nvmet_assoc_free_queue_rcu);
 	nvmet_fc_tgtport_put(tgtport);
 }
 
@@ -1237,7 +1245,7 @@ nvmet_fc_find_target_assoc(struct nvmet_fc_tgtport *tgtport,
 	unsigned long flags;
 
 	spin_lock_irqsave(&tgtport->lock, flags);
-	list_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
+	hlist_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
 		if (association_id == assoc->association_id) {
 			ret = assoc;
 			if (!nvmet_fc_tgt_a_get(assoc))
@@ -1397,7 +1405,7 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 	INIT_LIST_HEAD(&newrec->ls_rcv_list);
 	INIT_LIST_HEAD(&newrec->ls_req_list);
 	INIT_LIST_HEAD(&newrec->ls_busylist);
-	INIT_LIST_HEAD(&newrec->assoc_list);
+	INIT_HLIST_HEAD(&newrec->assoc_list);
 	INIT_LIST_HEAD(&newrec->host_list);
 	kref_init(&newrec->ref);
 	ida_init(&newrec->assoc_cnt);
@@ -1473,11 +1481,12 @@ nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport)
 static void
 __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
 {
-	struct nvmet_fc_tgt_assoc *assoc, *next;
+	struct nvmet_fc_tgt_assoc *assoc;
+	struct hlist_node *next;
 	unsigned long flags;
 
 	spin_lock_irqsave(&tgtport->lock, flags);
-	list_for_each_entry_safe(assoc, next,
+	hlist_for_each_entry_safe(assoc, next,
 				&tgtport->assoc_list, a_list) {
 		if (!nvmet_fc_tgt_a_get(assoc))
 			continue;
@@ -1522,12 +1531,13 @@ nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
 			void *hosthandle)
 {
 	struct nvmet_fc_tgtport *tgtport = targetport_to_tgtport(target_port);
-	struct nvmet_fc_tgt_assoc *assoc, *next;
+	struct nvmet_fc_tgt_assoc *assoc;
+	struct hlist_node *next;
 	unsigned long flags;
 	bool noassoc = true;
 
 	spin_lock_irqsave(&tgtport->lock, flags);
-	list_for_each_entry_safe(assoc, next,
+	hlist_for_each_entry_safe(assoc, next,
 				&tgtport->assoc_list, a_list) {
 		if (!assoc->hostport ||
 		    assoc->hostport->hosthandle != hosthandle)
@@ -1569,7 +1579,7 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 		spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 
 		spin_lock_irqsave(&tgtport->lock, flags);
-		list_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
+		hlist_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
 			queue = assoc->queues[0];
 			if (queue && queue->nvme_sq.ctrl == ctrl) {
 				if (nvmet_fc_tgt_a_get(assoc))
-- 
2.16.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
