Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D70C61DD6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 20:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aOzuicW09ymDk9cexEa+3/Sews5a9NJ263znpzR+848=; b=pCNqeBDdTOSgmL0x+SNbz007jf
	81N8PPsGsVjbUph17NDLlLNlhRzYL15aFplSEVhIegoqXi66p+0rsTNmrSbQOl3Oo4HeQAxVlcGsU
	mICOyuGBFd8CcRZdBNecC/G/VvZkPH+wB6uZ+/+uzCWTKVOhkTqzx0euyz+8/xLBNAZDHy6WjeoBx
	XalnrJ+WoW/5bv94mZEF5fU7vkI9x9X+ycBztn7g6XDvkU9Hq8jKzlTFLw24ECt6q/lmvGtVkskEn
	3kaqlYB2xxErOjKzS2sKmBwa/SzPPZJTJi3HeMqyxpPmPu4z63YQ/Y/ZeuxaRPWvS3F5CMz1Fg1yP
	38G6pDrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1rE0-0000000FoUl-3Ht6;
	Wed, 02 Sep 2026 20:06:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1rDy-0000000FoTg-0Qol
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 20:06:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788379581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOzuicW09ymDk9cexEa+3/Sews5a9NJ263znpzR+848=;
	b=GDDLXmOIUgREjZvl7UuM9rx183sUpTv3chsxxbYrmEhj5RfLT6NsVm1d/dFhDw9GakPCAp
	81opXCjKuVZunXKVD37WgT0xwfT5q9mRI+/dX3khB+sbTYDM6uKJungHKtYTNHlDP12dW9
	Af7fIZ/2xD1uvpuLY+e+vBdX/zIQ7ok=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-72-yttTKMveSGAZMlApg2A-1; Wed,
 02 Sep 2026 16:06:17 -0400
X-MC-Unique: 72-yttTKMveSGAZMlApg2A-1
X-Mimecast-MFC-AGG-ID: 72-yttTKMveSGAZMlApg2A_1788379568
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E64BF1955D99;
	Wed,  2 Sep 2026 20:06:07 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.17.16.153])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A8FE51955F02;
	Wed,  2 Sep 2026 20:06:04 +0000 (UTC)
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
Subject: [PATCH v2 4/7] nvme-multipath: round-robin support for marginal paths
Date: Wed,  2 Sep 2026 16:05:44 -0400
Message-ID: <20260902200547.184734-5-jtaubepe@redhat.com>
In-Reply-To: <20260902200547.184734-1-jtaubepe@redhat.com>
References: <20260902200547.184734-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: U_8QybkhkSpC-ELaCC9TL-9E08q1gYcD79m0ONruGCM_1788379568
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_130622_210261_B938C5A4 
X-CRM114-Status: GOOD (  18.97  )
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

Exclude marginal paths from round-robin io policy. In the case where all
paths are marginal and no optimized or non-optimized path is found, we
fall back and perform round-robin on the marginal paths.

Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
---
V10 -> V1:
 - New commit
V1 -> V2:
 - Rewrite
---
 drivers/nvme/host/multipath.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f28797deab68..738e3c742b74 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -392,22 +392,29 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
 	int node = numa_node_id();
 	struct nvme_ns *old = srcu_dereference(head->current_path[node],
 					       &head->srcu);
+	bool need_marginal;
 
 	if (unlikely(!old))
 		return __nvme_find_path(head, node);
 
 	if (list_is_singular(&head->list)) {
-		if (nvme_path_is_disabled(old))
-			return NULL;
-		return old;
+		if (nvme_path_is_usable(old))
+			return old;
+		return NULL;
 	}
 
+	need_marginal = nvme_all_paths_marginal(head);
+
 	for (ns = nvme_next_ns(head, old);
 	     ns && ns != old;
 	     ns = nvme_next_ns(head, ns)) {
 		if (nvme_path_is_disabled(ns))
 			continue;
 
+		/* Skip marginal paths unless we need to use them */
+		if (!need_marginal && nvme_ctrl_is_marginal(ns->ctrl))
+			continue;
+
 		if (ns->ana_state == NVME_ANA_OPTIMIZED) {
 			found = ns;
 			goto out;
@@ -419,12 +426,23 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
 	/*
 	 * The loop above skips the current path for round-robin semantics.
 	 * Fall back to the current path if either:
-	 *  - no other optimized path found and current is optimized,
+	 *  - no other optimized path found and current is,
+	 *      optimized and not marginal.
+	 *  - no other non-marginal path found and current is,
+	 *      optimized and marginal.
 	 *  - no other usable path found and current is usable.
 	 */
-	if (!nvme_path_is_disabled(old) &&
-	    (old->ana_state == NVME_ANA_OPTIMIZED ||
-	     (!found && old->ana_state == NVME_ANA_NONOPTIMIZED)))
+	/* no other usable path found and current is usable. */
+	if (nvme_path_is_usable(old) && !found)
+		return old;
+	/*
+	 *  - no other optimized path found and current is,
+	 *      optimized and not marginal.
+	 *  - no other non-marginal path found and current is,
+	 *      optimized and marginal.
+	 */
+	if (nvme_path_is_usable(old) && old->ana_state == NVME_ANA_OPTIMIZED &&
+	   (!nvme_ctrl_is_marginal(old->ctrl) || need_marginal))
 		return old;
 
 	if (!found)
-- 
2.55.0


