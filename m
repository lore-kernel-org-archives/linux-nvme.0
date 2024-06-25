Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89BAC2BBCA
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jun 2024 12:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XTitNVRGPj2/sy+vCINs/a5dERClA89sJfbo+NdMWMQ=; b=kI4OkmQj+Ut6S50Uxb8Wra5Y4G
	dpTGFHvDmQxpl6RhYYJBCtorBamisRZ3zhpCCmF4VEgGpnZhemEnFt+cI5EZjL5dNSkEsK/hj/zL0
	cAVkIREFSqzX7vQHMYKFf5TS/78ZClPpyoPjHvVub7BDDMvVl5NWOSq89e1ab9EcCdtb49bqNm4/A
	m8V+cg/8YHKLJbmRggyEGw8Cty1YpuWFkvQaj4+Zdiwrnme0XK4rL83AfMp8UpqKZI0qKWugKQTbn
	7hR19ZdKXR0Wb8GygH0MiYw6sTH44Pt4vggWadVVyqLNgv7SQ3lQRRWd2Qaw0Mto5BdBtfH9cbSxb
	sG3Qwo/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM5Fh-00000002kbT-3si6;
	Tue, 25 Jun 2024 12:26:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM5Fe-00000002kZ0-3Xy4
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jun 2024 12:26:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719318381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTitNVRGPj2/sy+vCINs/a5dERClA89sJfbo+NdMWMQ=;
	b=T1RKMGn17qb3/VHlUiKcijdavLFgM306pequa5DwaTbpFI6eoGTHGtpEtq/qHbzMbYXIAn
	+08eFmw/0Q8DLv5/8M9OLj+duu81XYqzjnLfLnQb4IjcQs5kakKSkJilqTdQVhUeSRcCOR
	Z7hXnPqspSMMfMVHphL53ZZ7/MvNH2c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-62ruxzYmOgaHLh82rnGNzw-1; Tue,
 25 Jun 2024 08:26:16 -0400
X-MC-Unique: 62ruxzYmOgaHLh82rnGNzw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA8F4195609D;
	Tue, 25 Jun 2024 12:26:14 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.34.111])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 54A8F1956057;
	Tue, 25 Jun 2024 12:26:12 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com,
	chaitanyak@nvidia.com,
	hare@kernel.org
Subject: [PATCH v8 1/2] nvme-multipath: prepare for "queue-depth" iopolicy
Date: Tue, 25 Jun 2024 08:26:04 -0400
Message-ID: <20240625122605.857462-2-jmeneghi@redhat.com>
In-Reply-To: <20240625122605.857462-1-jmeneghi@redhat.com>
References: <20240625122605.857462-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240625_052622_999688_F6717C04 
X-CRM114-Status: GOOD (  13.20  )
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

This patch prepares for the introduction of a new iopolicy by breaking up
the nvme_find_path() code path into sub-routines.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/multipath.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 8a4d0e377114..0ade378e514b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -291,10 +291,14 @@ static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
 	return list_first_or_null_rcu(&head->list, struct nvme_ns, siblings);
 }
 
-static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
-		int node, struct nvme_ns *old)
+static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *ns, *found = NULL;
+	int node = numa_node_id();
+	struct nvme_ns *old = srcu_dereference(head->current_path[node], &head->srcu);
+
+	if (unlikely(!old))
+		return __nvme_find_path(head, node);
 
 	if (list_is_singular(&head->list)) {
 		if (nvme_path_is_disabled(old))
@@ -340,7 +344,7 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 		ns->ana_state == NVME_ANA_OPTIMIZED;
 }
 
-inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
 {
 	int node = numa_node_id();
 	struct nvme_ns *ns;
@@ -348,14 +352,19 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	ns = srcu_dereference(head->current_path[node], &head->srcu);
 	if (unlikely(!ns))
 		return __nvme_find_path(head, node);
-
-	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
-		return nvme_round_robin_path(head, node, ns);
 	if (unlikely(!nvme_path_is_optimized(ns)))
 		return __nvme_find_path(head, node);
 	return ns;
 }
 
+inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+{
+	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
+		return nvme_round_robin_path(head);
+	else
+		return nvme_numa_path(head);
+}
+
 static bool nvme_available_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *ns;
-- 
2.45.2


