Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8718FCE7AA4
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Sep 2023 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ny4IdEKx0Olp/QtAzOUUyk/jIreXKp6NCOv1TYEmYD4=; b=xgdgjsfb2HBH+00VTWCn3SiYd3
	T0ccuotNMC+NvhD3wdu2wL6vw2SOVtFK88oH6VUAA3RyZNhaJL7qvDk3O5J0mxgcMDuI1wT/VKtOv
	eQtQxfBIUQ0xowOKKs3yylvE4yzpvScaQDMcm8DIXjGfSOOdnJPhF261MBZic0gD2bqKV6gmXvvAb
	eUWG/eiW5QUsAJW35tYR79ODPJxsi3j4DkyMQPnM8YMW/Pea2+Ioas+PDQGi13NVq6TmHXt24ZdLk
	DW8hXC0ASZaiSCPm1/MmjN4Prnk2+Vz7p8HNmU8hqTz5/HNuckI+leQiU0qTxRHUh1rT8mqW/bN9b
	ix99JEKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkoWA-00EfSS-0W;
	Mon, 25 Sep 2023 16:33:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qkoW6-00EfR1-1w
	for linux-nvme@lists.infradead.org;
	Mon, 25 Sep 2023 16:33:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695659580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ny4IdEKx0Olp/QtAzOUUyk/jIreXKp6NCOv1TYEmYD4=;
	b=OSkfVM9b3YKW2EXFijYR+nFXlf1CllPz6/UoQqAXOdnWRiKdOjUzKZuuZhcqDrbbwLjmyZ
	sKqGOznzg7YzzU/kBrXtvIzyTu0ZQH82hyGQ47lpPAf5CZ6HzkUjro3VhF3Gem/6j2uTC9
	trfGvCx0TxWQEBqKQXktbARpL4zPh1o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-aJzsjDDzNxe6kL22VnkbGA-1; Mon, 25 Sep 2023 12:31:25 -0400
X-MC-Unique: aJzsjDDzNxe6kL22VnkbGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86BCE3816C90;
	Mon, 25 Sep 2023 16:31:24 +0000 (UTC)
Received: from emilne.bos.redhat.com (unknown [10.18.25.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 61D66C15BB8;
	Mon, 25 Sep 2023 16:31:24 +0000 (UTC)
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: tsong@purestorage.com,
	jmeneghi@redhat.com,
	mlombard@redhat.com
Subject: [PATCH 2/3] nvme-multipath: Implement new iopolicy "queue-depth"
Date: Mon, 25 Sep 2023 12:31:22 -0400
Message-Id: <20230925163123.16042-3-emilne@redhat.com>
In-Reply-To: <20230925163123.16042-1-emilne@redhat.com>
References: <20230925163123.16042-1-emilne@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_093302_705661_29175687 
X-CRM114-Status: GOOD (  17.40  )
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

The existing iopolicies are inefficient in some cases, such as
the presence of a path with high latency. The round-robin
policy would use that path equally with faster paths, which
results in sub-optimal performance.

The queue-depth policy instead sends I/O requests down the path
with the least amount of requests in its request queue. Paths
with lower latency will clear requests more quickly and have less
requests in their queues compared to "bad" paths. The aim is to
use those paths the most to bring down overall latency.

[edm: patch developed by Thomas Song @ Pure Storage, fixed whitespace
      and compilation warnings, updated MODULE_PARM description
      and changed to use new blk_mq_queue_nr_active() instead of adding
      additional atomic counters.]

Co-developed-by: Thomas Song <tsong@purestorage.com>
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/nvme/host/multipath.c | 48 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0a88d7bdc5e3..deea7fd4aa95 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -17,6 +17,7 @@ MODULE_PARM_DESC(multipath,
 static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
+	[NVME_IOPOLICY_QD]      = "queue-depth",
 };
 
 static int iopolicy = NVME_IOPOLICY_NUMA;
@@ -29,6 +30,8 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
 		iopolicy = NVME_IOPOLICY_NUMA;
 	else if (!strncmp(val, "round-robin", 11))
 		iopolicy = NVME_IOPOLICY_RR;
+	else if (!strncmp(val, "queue-depth", 11))
+		iopolicy = NVME_IOPOLICY_QD;
 	else
 		return -EINVAL;
 
@@ -43,7 +46,7 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
 module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
 	&iopolicy, 0644);
 MODULE_PARM_DESC(iopolicy,
-	"Default multipath I/O policy; 'numa' (default) or 'round-robin'");
+	"Default multipath I/O policy; 'numa' (default) , 'round-robin' or 'queue-depth'");
 
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
 {
@@ -329,6 +332,41 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 	return found;
 }
 
+static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head,
+		int node)
+{
+	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
+	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
+	unsigned int depth;
+
+	list_for_each_entry_rcu(ns, &head->list, siblings) {
+		if (nvme_path_is_disabled(ns))
+			continue;
+
+		depth = blk_mq_queue_nr_active(ns->queue);
+
+		switch (ns->ana_state) {
+		case NVME_ANA_OPTIMIZED:
+			if (depth < min_depth_opt) {
+				min_depth_opt = depth;
+				best_opt = ns;
+			}
+			break;
+
+		case NVME_ANA_NONOPTIMIZED:
+			if (depth < min_depth_nonopt) {
+				min_depth_nonopt = depth;
+				best_nonopt = ns;
+			}
+			break;
+		default:
+			break;
+		}
+	}
+
+	return best_opt ? best_opt : best_nonopt;
+}
+
 static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 {
 	return ns->ctrl->state == NVME_CTRL_LIVE &&
@@ -344,8 +382,14 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	if (unlikely(!ns))
 		return __nvme_find_path(head, node);
 
-	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
+	switch(READ_ONCE(head->subsys->iopolicy)) {
+	case NVME_IOPOLICY_RR:
 		return nvme_round_robin_path(head, node, ns);
+
+	case NVME_IOPOLICY_QD:
+		return nvme_queue_depth_path(head, node);
+	}
+
 	if (unlikely(!nvme_path_is_optimized(ns)))
 		return __nvme_find_path(head, node);
 	return ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470af..938fbed007ce 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -389,6 +389,7 @@ struct nvme_ctrl {
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
+	NVME_IOPOLICY_QD,
 };
 
 struct nvme_subsystem {
-- 
2.20.1


