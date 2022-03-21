Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ABAC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Mar 2022 22:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IhWYlsEf5ZK2fnqW4BbtC5xM4+IzYSGk/l+nHupUiCc=; b=ClXw/6x3zyyjMbnA9E4e2TwiYu
	z8jlRp6dGQ2UGcDRIuNLKdsyhhTscqnesx1CeoFooNqlAmGp9tY0T4EHjzPCM84bc3Loe34E4QFs2
	Y0SwtvL1pjXNDQzpiTLvmdi/yv15uFjRvb3KKjhg0V7FOK1mRPXuYSKmPF+t+Z+0dk7GF3r9iXaEI
	OqszOw6ehsT8bz9QvBicmvWzv3s0iqkh5Y4IUxdK0z/yYNJQt3gYrSXGMyp9tbCBHDNKykgargG6G
	WxH7JdgmgqvV9xE5/CVOWIwh5bS8d37K2G8hq+v8d3na+b5wMAa+4gtzIEqv29XRkC5ig8YGE9d5H
	UBSLN+7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWQlD-009HnA-GA; Mon, 21 Mar 2022 22:44:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWQkr-009HhP-9C
 for linux-nvme@lists.infradead.org; Mon, 21 Mar 2022 22:44:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647902640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IhWYlsEf5ZK2fnqW4BbtC5xM4+IzYSGk/l+nHupUiCc=;
 b=S10knkiboUdbgXRpT38oNuBc6T0sUeBO468Ep4RFYx0zrpcDnCmcNnF5CC5ctzF+I9RbCB
 QMGfBEoZLx1Z9s7rWOJhnQL5VrSmVpYYvgodGqyKeO4yUAe/bPGSkViW4Q10l9tyo9ngJB
 CYSYX0CL4DKTEw+mjkg85eiXjaEYs/U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-i18ODjRIOnOmKZ77O3AKYw-1; Mon, 21 Mar 2022 18:43:55 -0400
X-MC-Unique: i18ODjRIOnOmKZ77O3AKYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B820C3C14CC3;
 Mon, 21 Mar 2022 22:43:54 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.2.17.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB717141DEE9;
 Mon, 21 Mar 2022 22:43:53 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: lengchao@huawei.com, dwagner@suse.de, hare@suse.de, mlombard@redhat.com,
 jmeneghi@redhat.com
Subject: [RFC PATCH] nvme: fix RCU hole that allowed for endless looping in
 multipath round robin
Date: Mon, 21 Mar 2022 15:43:04 -0700
Message-Id: <20220321224304.955072-4-cleech@redhat.com>
In-Reply-To: <20220321224304.955072-1-cleech@redhat.com>
References: <20220321224304.955072-1-cleech@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cleech@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220321_154401_440138_CDE4743C 
X-CRM114-Status: GOOD (  13.47  )
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

Make nvme_ns_remove match the assumptions elsewhere.

1) !NVME_NS_READY needs to be srcu synchronized to make sure nothing is
   running in __nvme_find_path or nvme_round_robin_path that will
   re-assign this ns to current_path.

2) Any matching current_path entries need to be cleared before removing
   from the siblings list, to prevent calling nvme_round_robin_path with
   an "old" ns that's off list.

3) Finally the list_del_rcu can happen, and then synchronize again
   before releasing any reference counts.
---
 drivers/nvme/host/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fd4720d37cc0..20778dc9224c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3917,6 +3917,15 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	set_capacity(ns->disk, 0);
 	nvme_fault_inject_fini(&ns->fault_inject);
 
+	/* ensure that !NVME_NS_READY is seen
+	 * to prevent this ns going back in current_path
+	 */
+	synchronize_srcu(&ns->head->srcu);
+
+	/* wait for concurrent submissions */
+	if (nvme_mpath_clear_current_path(ns))
+		synchronize_srcu(&ns->head->srcu);
+
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
 	if (list_empty(&ns->head->list)) {
@@ -3928,10 +3937,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	/* guarantee not available in head->list */
 	synchronize_rcu();
 
-	/* wait for concurrent submissions */
-	if (nvme_mpath_clear_current_path(ns))
-		synchronize_srcu(&ns->head->srcu);
-
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
 	del_gendisk(ns->disk);
-- 
2.35.1


