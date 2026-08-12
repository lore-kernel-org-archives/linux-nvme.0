Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1967C5CFEB
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 18:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p5hCJTyk+JlNhkqSdY8pBWBu0X2FbGauT5SMAOg6BwM=; b=Y2f+5emtyjVLQNHGZ4hNg6dbIj
	+wlRiUvX6xrht1aLyHiu8eI88sytjJDsqkB5WUFVYppM3wWLdBnafoG5vK4c1ZO5xKYLpWuizKg7A
	7dXMhElyNWqRJxGzLKNIqEyD5S32sMgcK5iJo86cMfeTbDOHiyMDXXNFbQ4wYYJucl3NqRTtoyf6U
	U7z/laVu01iO3Mo44KEecyhwVzn/AMfIkXkBE+kvFq35UNV1pC7An1AmAPXeBOhkUfEucl0yZKIC3
	xtggHogUOG+/GIMzNOVXpmv+nLNw3UcEqIoCATW9tzRNeHiFA9lZ9VfnyffJiOU7AzdOGolmtHqtK
	3+v2Wzpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDSh-0000000Gl04-0o3F;
	Wed, 12 Aug 2026 18:13:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDSc-0000000Gkwk-3lW4
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 18:13:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786558434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5hCJTyk+JlNhkqSdY8pBWBu0X2FbGauT5SMAOg6BwM=;
	b=QzprF+whQeQO/8aSR6Pp9GeSsA75DK5WQofqxsyc9u5gN7m02r+8O0I2wlZ0q0E0CfsbeT
	HYShoYsDtjlW3bjZIQBRcdapvQic7lt1HhdEYeemGyuSWk3EjLik9PDlr6lwRGMXl51Te7
	eJ/zlb0fzlsmTntW7OBoIOkoUvEQyb0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-0Kh43q5oOv-BWeaItZ2FLg-1; Wed,
 12 Aug 2026 14:13:43 -0400
X-MC-Unique: 0Kh43q5oOv-BWeaItZ2FLg-1
X-Mimecast-MFC-AGG-ID: 0Kh43q5oOv-BWeaItZ2FLg_1786558420
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E602619560AA;
	Wed, 12 Aug 2026 18:13:39 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.88.181])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42C76180034C;
	Wed, 12 Aug 2026 18:13:34 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-scsi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 05/13] nvme-multipath: round-robin support for marginal paths
Date: Wed, 12 Aug 2026 14:12:52 -0400
Message-ID: <20260812181300.3712426-6-jtaubepe@redhat.com>
In-Reply-To: <20260812181300.3712426-1-jtaubepe@redhat.com>
References: <20260812181300.3712426-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 2IkntEnBEawjkl_9YnXmS08srjZtdtckdruJ2uYJU7w_1786558420
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_111355_036804_370353A7 
X-CRM114-Status: GOOD (  19.30  )
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
V10 -> V11:
 - New commit
---
 drivers/nvme/host/multipath.c | 47 +++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index dc34634842be..11f474704fdd 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -405,6 +405,7 @@ static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
 static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *ns, *found = NULL;
+	bool found_is_marginal = true;
 	int node = numa_node_id();
 	struct nvme_ns *old = srcu_dereference(head->current_path[node],
 					       &head->srcu);
@@ -425,22 +426,58 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
 			continue;
 
 		if (ns->ana_state == NVME_ANA_OPTIMIZED) {
+			if (found_is_marginal && nvme_ctrl_is_marginal(ns->ctrl)) {
+				/*
+				 * A marginal path has already found,
+				 * or this is the first path found.
+				 * This one is also marginal, but optimized,
+				 * so prefer it.
+				 */
+				found = ns;
+				found_is_marginal = 1;
+				continue;
+			}
+
+
+			/*
+			 * A non-marginal path has already found.
+			 * This one is marginal, so skip it.
+			 */
+			if (nvme_ctrl_is_marginal(ns->ctrl))
+				continue;
+
+			/* Found a non-marginal, optimized path use it. */
 			found = ns;
 			goto out;
 		}
-		if (ns->ana_state == NVME_ANA_NONOPTIMIZED)
+		if (ns->ana_state == NVME_ANA_NONOPTIMIZED) {
+			/*
+			 * A path has already found. This one is marginal,
+			 * so skip it.
+			 */
+			if (found && nvme_ctrl_is_marginal(ns->ctrl))
+				continue;
 			found = ns;
+			found_is_marginal = nvme_ctrl_is_marginal(ns->ctrl);
+		}
 	}
 
 	/*
 	 * The loop above skips the current path for round-robin semantics.
 	 * Fall back to the current path if either:
-	 *  - no other optimized path found and current is optimized,
+	 *  - no other non-marginal optimized path found and current is,
+	 *      optimized and not marginal.
 	 *  - no other usable path found and current is usable.
 	 */
-	if (!nvme_path_is_disabled(old) &&
-	    (old->ana_state == NVME_ANA_OPTIMIZED ||
-	     (!found && old->ana_state == NVME_ANA_NONOPTIMIZED)))
+	/* no other usable path found and current is usable. */
+	if (!nvme_path_is_disabled(old) && !found)
+		return old;
+	/*
+	 * no other non-marginal optimized path found and current is,
+	 *   optimized and not marginal.
+	 */
+	if (!nvme_path_is_disabled(old) && !nvme_ctrl_is_marginal(old->ctrl) &&
+	    (old->ana_state == NVME_ANA_OPTIMIZED || found_is_marginal))
 		return old;
 
 	if (!found)
-- 
2.54.0


