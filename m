Return-Path: <SRS0=OivJ=GG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E24FC433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Jan 2021 18:13:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29303207C9
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Jan 2021 18:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29303207C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SSwoYiX0HPNKmnmE22OJZBTkJ1znpXvuFjl97+UfwoU=; b=piePUfY/gNE2rEA6B7p+N0RWTA
	QwBKIpBmtrq3DQ3zWMTKrn5kretRkM84mZcq3dvdew7BicCyHKQ7Wba4GY815GhTdZ4T15iRD7Eqe
	dOyqrhRDAxNyKOw2wcXom1vdOL5ueA3EfpFHg26Yngt+cuHuVEuEMT6UNP7YJsYN7SqNa1kukbQj2
	HF+BytBbe0j8cxzunmcucRrljmMF9yjuN83RmZSghvpYLsb+Zby6wgKUmFGfTQZGSht6PKsgWcdjp
	mBbtu4TJX36cBBoIp3ZWedxAQCi3St6UJA99q1yQQFcMNfh033i+GwfM6OxmCmQ906U7E4PdWgO5G
	H6jUtUig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kw7sa-0003Cn-Jv; Sun, 03 Jan 2021 18:13:24 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kw7sW-0003BL-5p
 for linux-nvme@lists.infradead.org; Sun, 03 Jan 2021 18:13:21 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 103ID6Ns021439
 for <linux-nvme@lists.infradead.org>; Sun, 3 Jan 2021 13:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=p1JDwNjo4kW+Onlqx41wby/8vL/xJp1erYMmcX8soa4=;
 b=Mp0/IMXiqgZVXcpwSVyLpl/oXUp8xmq1DsM32+CKD5gI2wDU7n3dQcFZ5jGiDqn4dAu3
 m4yhrBP6hRp7dQDPHzpyxVyJWCf/dGgASizwzme8p359i/NPDqck5cfKUajChNz5158W
 HTFEjGoWn2oeenpdSH+MCWTmuFJCZH4/JiJL8J8Ttr8SpbAvg/ndv/iDq8btI/i2r1A9
 ZzcE1+lETjIG0I8jgBQXN8nVP8iJkynjNHhSKTR0OS7dy0JcOZnSxqBmmgBk8A0DkUiM
 SEjZpXHY6lTByfmvd6bsXx24dnsCq0qM/pvg7uAIctB9R6qOccWdchR3z4jgXzq2GZBb ag== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 35tpctj97j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Sun, 03 Jan 2021 13:13:15 -0500
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 103I67K0041393
 for <linux-nvme@lists.infradead.org>; Sun, 3 Jan 2021 13:13:15 -0500
Received: from esaploutdur04.us.dell.com ([128.221.233.10])
 by mx0b-00154901.pphosted.com with ESMTP id 35u720ckrt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Sun, 03 Jan 2021 13:13:15 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.226.146
Received: from unknown (HELO vd-leonidr.xiolab.lab.emc.com) ([10.55.226.146])
 by esaploutdur04.us.dell.com with ESMTP; 03 Jan 2021 12:13:13 -0600
From: leonid.ravich@dell.com
To: james.smart@broadcom.com
Subject: [PATCH v2] nvmet-fc: associations list protected by rcu,
 instead of spinlock_irq where possible.
Date: Sun,  3 Jan 2021 20:12:53 +0200
Message-Id: <1609697575-103348-1-git-send-email-leonid.ravich@dell.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <20201224110542.22219-1-leonid.ravich@dell.com>
References: <20201224110542.22219-1-leonid.ravich@dell.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-03_11:2020-12-31,
 2021-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101030117
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101030118
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210103_131320_492928_3BE193E6 
X-CRM114-Status: GOOD (  20.68  )
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

searching assoc_list protected by rcu_read_lock if list not changed inline.
and according to the rcu list rules.

queue array embedded into nvmet_fc_tgt_assoc protected by rcu_read_lock
according to rcu dereference/assign rules.

queue and assoc object freed after grace period by call_rcu.

tgtport lock taken for changing assoc_list.

Reviewed-by: Eldad Zinger <Eldad.Zinger@dell.com>
Reviewed-by: Elad Grupi <Elad.Grupi@dell.com>
Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
---
1) fixed sytle issus 
2) queues array protects by rcu as well

 drivers/nvme/target/fc.c | 81 +++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 43 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index cd4e73a..c14c60b 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -145,6 +145,7 @@ struct nvmet_fc_tgt_queue {
 	struct list_head		avail_defer_list;
 	struct workqueue_struct		*work_q;
 	struct kref			ref;
+	struct rcu_head			rcu;
 	struct nvmet_fc_fcp_iod		fod[];		/* array of fcp_iods */
 } __aligned(sizeof(unsigned long long));
 
@@ -167,6 +168,7 @@ struct nvmet_fc_tgt_assoc {
 	struct nvmet_fc_tgt_queue	*queues[NVMET_NR_QUEUES + 1];
 	struct kref			ref;
 	struct work_struct		del_work;
+	struct rcu_head			rcu;
 };
 
 
@@ -790,7 +792,6 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 			u16 qid, u16 sqsize)
 {
 	struct nvmet_fc_tgt_queue *queue;
-	unsigned long flags;
 	int ret;
 
 	if (qid > NVMET_NR_QUEUES)
@@ -829,9 +830,7 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 		goto out_fail_iodlist;
 
 	WARN_ON(assoc->queues[qid]);
-	spin_lock_irqsave(&assoc->tgtport->lock, flags);
-	assoc->queues[qid] = queue;
-	spin_unlock_irqrestore(&assoc->tgtport->lock, flags);
+	rcu_assign_pointer(assoc->queues[qid], queue);
 
 	return queue;
 
@@ -851,11 +850,8 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 {
 	struct nvmet_fc_tgt_queue *queue =
 		container_of(ref, struct nvmet_fc_tgt_queue, ref);
-	unsigned long flags;
 
-	spin_lock_irqsave(&queue->assoc->tgtport->lock, flags);
-	queue->assoc->queues[queue->qid] = NULL;
-	spin_unlock_irqrestore(&queue->assoc->tgtport->lock, flags);
+	rcu_assign_pointer(queue->assoc->queues[queue->qid], NULL);
 
 	nvmet_fc_destroy_fcp_iodlist(queue->assoc->tgtport, queue);
 
@@ -863,7 +859,7 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 
 	destroy_workqueue(queue->work_q);
 
-	kfree(queue);
+	kfree_rcu(queue, rcu);
 }
 
 static void
@@ -965,24 +961,23 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 	struct nvmet_fc_tgt_queue *queue;
 	u64 association_id = nvmet_fc_getassociationid(connection_id);
 	u16 qid = nvmet_fc_getqueueid(connection_id);
-	unsigned long flags;
 
 	if (qid > NVMET_NR_QUEUES)
 		return NULL;
 
-	spin_lock_irqsave(&tgtport->lock, flags);
-	list_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
 		if (association_id == assoc->association_id) {
-			queue = assoc->queues[qid];
+			queue = rcu_dereference(assoc->queues[qid]);
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
 
@@ -1137,7 +1132,7 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 		}
 		if (!needrandom) {
 			assoc->association_id = ran;
-			list_add_tail(&assoc->a_list, &tgtport->assoc_list);
+			list_add_tail_rcu(&assoc->a_list, &tgtport->assoc_list);
 		}
 		spin_unlock_irqrestore(&tgtport->lock, flags);
 	}
@@ -1167,7 +1162,7 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 
 	nvmet_fc_free_hostport(assoc->hostport);
 	spin_lock_irqsave(&tgtport->lock, flags);
-	list_del(&assoc->a_list);
+	list_del_rcu(&assoc->a_list);
 	oldls = assoc->rcv_disconn;
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 	/* if pending Rcv Disconnect Association LS, send rsp now */
@@ -1177,7 +1172,7 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 	dev_info(tgtport->dev,
 		"{%d:%d} Association freed\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
-	kfree(assoc);
+	kfree_rcu(assoc, rcu);
 	nvmet_fc_tgtport_put(tgtport);
 }
 
@@ -1198,7 +1193,6 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 {
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 	struct nvmet_fc_tgt_queue *queue;
-	unsigned long flags;
 	int i, terminating;
 
 	terminating = atomic_xchg(&assoc->terminating, 1);
@@ -1207,19 +1201,23 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 	if (terminating)
 		return;
 
-	spin_lock_irqsave(&tgtport->lock, flags);
+
 	for (i = NVMET_NR_QUEUES; i >= 0; i--) {
-		queue = assoc->queues[i];
-		if (queue) {
-			if (!nvmet_fc_tgt_q_get(queue))
-				continue;
-			spin_unlock_irqrestore(&tgtport->lock, flags);
-			nvmet_fc_delete_target_queue(queue);
-			nvmet_fc_tgt_q_put(queue);
-			spin_lock_irqsave(&tgtport->lock, flags);
+		rcu_read_lock();
+		queue = rcu_dereference(assoc->queues[i]);
+		if (!queue) {
+			rcu_read_unlock();
+			continue;
+		}
+
+		if (!nvmet_fc_tgt_q_get(queue)) {
+			rcu_read_unlock();
+			continue;
 		}
+		rcu_read_unlock();
+		nvmet_fc_delete_target_queue(queue);
+		nvmet_fc_tgt_q_put(queue);
 	}
-	spin_unlock_irqrestore(&tgtport->lock, flags);
 
 	dev_info(tgtport->dev,
 		"{%d:%d} Association deleted\n",
@@ -1234,10 +1232,9 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 {
 	struct nvmet_fc_tgt_assoc *assoc;
 	struct nvmet_fc_tgt_assoc *ret = NULL;
-	unsigned long flags;
 
-	spin_lock_irqsave(&tgtport->lock, flags);
-	list_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
 		if (association_id == assoc->association_id) {
 			ret = assoc;
 			if (!nvmet_fc_tgt_a_get(assoc))
@@ -1245,7 +1242,7 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 			break;
 		}
 	}
-	spin_unlock_irqrestore(&tgtport->lock, flags);
+	rcu_read_unlock();
 
 	return ret;
 }
@@ -1473,19 +1470,17 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 static void
 __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
 {
-	struct nvmet_fc_tgt_assoc *assoc, *next;
-	unsigned long flags;
+	struct nvmet_fc_tgt_assoc *assoc;
 
-	spin_lock_irqsave(&tgtport->lock, flags);
-	list_for_each_entry_safe(assoc, next,
-				&tgtport->assoc_list, a_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
 		if (!nvmet_fc_tgt_a_get(assoc))
 			continue;
 		if (!schedule_work(&assoc->del_work))
 			/* already deleting - release local reference */
 			nvmet_fc_tgt_a_put(assoc);
 	}
-	spin_unlock_irqrestore(&tgtport->lock, flags);
+	rcu_read_unlock();
 }
 
 /**
@@ -1568,16 +1563,16 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 			continue;
 		spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 
-		spin_lock_irqsave(&tgtport->lock, flags);
-		list_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
-			queue = assoc->queues[0];
+		rcu_read_lock();
+		list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
+			queue = rcu_dereference(assoc->queues[0]);
 			if (queue && queue->nvme_sq.ctrl == ctrl) {
 				if (nvmet_fc_tgt_a_get(assoc))
 					found_ctrl = true;
 				break;
 			}
 		}
-		spin_unlock_irqrestore(&tgtport->lock, flags);
+		rcu_read_unlock();
 
 		nvmet_fc_tgtport_put(tgtport);
 
-- 
1.9.3


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
