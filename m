Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477DFC61DD6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 20:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7S+46ev46/4yG1E8XUsVniDJoHCi+hDFBp54jOlRy1g=; b=l+5h4GpaysbAr0CJME7oPkZIEM
	t/F4GE5QXykUbmswP/GLIkYeTXNiYuqKn/RyLNSkmG0wsbDiJuVABbDad6GBT1YoAknMdOl6oTM9d
	Hs4xm47IxojQMudbO+1aVmWNwU0E4BPgun8h9+Hg9GOnIyJwXQmABn1Uz0vDCN01V8/QwrT1MRgU8
	/lsW70umTi2D+BVyLumpj8RVuBN8sGuzMavyQLPtYfbbnqGKTaq+jyQ69tAPM1UxNiXjaNyJK5SJY
	ImDMYd7A0GfdD38ouhn3P/r2y/cZXYiBHvD8/zUpeanMzSfkk2N0SNkHIQky9IrCSIOnsjo2+6P3I
	iAvmsz0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1rDr-0000000FoQP-1Yen;
	Wed, 02 Sep 2026 20:06:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1rDp-0000000FoPc-01J7
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 20:06:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788379572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7S+46ev46/4yG1E8XUsVniDJoHCi+hDFBp54jOlRy1g=;
	b=PRIHeHm4JD+sN6bR98peH19YhiL6S18KkdQDAj8N6Y9UkHxKRKlH4NdptuOVuJTwRYGD0C
	C1PTUpQeoFauoQw5aDTH9RMYddsSQGJPPpyzGlFkfODB6WYrGH5u1d145XjI23UKAsSn9D
	pST/6G6Yh7nTzl59jwb24spX5rvNF7s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-206uQ71GPvKtm7JkxKrxQQ-1; Wed,
 02 Sep 2026 16:06:05 -0400
X-MC-Unique: 206uQ71GPvKtm7JkxKrxQQ-1
X-Mimecast-MFC-AGG-ID: 206uQ71GPvKtm7JkxKrxQQ_1788379561
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECF571955D99;
	Wed,  2 Sep 2026 20:06:00 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.17.16.153])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2590A1955F02;
	Wed,  2 Sep 2026 20:05:57 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: linux-scsi@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Hannes Reinecke <hare@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>,
	Chris Leech <cleech@redhat.com>,
	"Ewan D . Milne" <emilne@redhat.com>,
	shinichiro.kawasaki@wdc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH v2 2/7] nvme-multipath: numa support for marginal paths
Date: Wed,  2 Sep 2026 16:05:42 -0400
Message-ID: <20260902200547.184734-3-jtaubepe@redhat.com>
In-Reply-To: <20260902200547.184734-1-jtaubepe@redhat.com>
References: <20260902200547.184734-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: jXuP4KgSAHj1jXiPRiMhZH9hfcK1oBi5ll4FxJmm1r8_1788379561
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_130613_120276_318CF8AA 
X-CRM114-Status: GOOD (  20.80  )
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

FPIN LI (link integrity) messages are received when the attached
fabric detects hardware errors. In response to these messages I/O
should be directed away from the affected ports, and only used
if no other non-marginal paths are available.
To handle this a new controller flag 'NVME_CTRL_MARGINAL' is added
which will cause the multipath scheduler to skip these paths when
checking for 'optimized' paths.

Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
---
This is a distinct change from the previous commit
which treated marginal paths as non-optimized but still usable.
This changes the priority of marginal paths to be lower than
non-optimized paths.
V10 -> V1:
 - New commit
V1 -> V2:
 - Rewrite
---
 drivers/nvme/host/multipath.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9b9a657fa330..dbf09cdda815 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -305,16 +305,45 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
 	return false;
 }
 
+static bool nvme_path_is_usable(struct nvme_ns *ns)
+{
+	/* Only NVME_ANA_OPTIMIZED and NVME_ANA_NONOPTIMIZED are usable */
+	return !nvme_path_is_disabled(ns) &&
+		(ns->ana_state == NVME_ANA_OPTIMIZED ||
+		 ns->ana_state == NVME_ANA_NONOPTIMIZED);
+}
+
+static bool nvme_all_paths_marginal(struct nvme_ns_head *head)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+				 srcu_read_lock_held(&head->srcu)) {
+		/* skip paths which can not be used */
+		if (!nvme_path_is_usable(ns))
+			continue;
+		if (!nvme_ctrl_is_marginal(ns->ctrl))
+			return false;
+	}
+
+	return true;
+}
+
 static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 {
 	int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
 	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
+	bool need_marginal = nvme_all_paths_marginal(head);
 
 	list_for_each_entry_srcu(ns, &head->list, siblings,
 				 srcu_read_lock_held(&head->srcu)) {
 		if (nvme_path_is_disabled(ns))
 			continue;
 
+		/* Skip marginal paths unless we need to use them */
+		if (!need_marginal && nvme_ctrl_is_marginal(ns->ctrl))
+			continue;
+
 		if (ns->ctrl->numa_node != NUMA_NO_NODE &&
 		    READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
 			distance = node_distance(node, ns->ctrl->numa_node);
@@ -339,6 +368,7 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 		}
 	}
 
+	/* No optimized path found, use the fallback */
 	if (!found)
 		found = fallback;
 	if (found)
@@ -444,7 +474,8 @@ static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
 static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 {
 	return nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE &&
-		ns->ana_state == NVME_ANA_OPTIMIZED;
+		ns->ana_state == NVME_ANA_OPTIMIZED &&
+		!nvme_ctrl_is_marginal(ns->ctrl);
 }
 
 static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
-- 
2.55.0


