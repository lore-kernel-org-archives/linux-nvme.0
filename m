Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B22C5B56A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 18:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vcu9PbtDT1pNYoR33movkVcPOA1p/h5oinwfvgSmomU=; b=3xSsY/xbgj1amj3of9rsqgZWt0
	n95p+828Mw60TH9r31MhmN+1Er041J2zfYOcfv33SNHRpM52579LQEJH8Y55+SM8pEpOwpPwypWkm
	GVercMSsZuTQ7ZL97LRyRkzljBG9hyPuybnA7YipQcYHiUPwv9cY2lubeLz2ewmb24YRSofAPb+FD
	VwWZYXHQss2xnftOpp+0u8SShCE3FDysDHuL2eIOXad8pKwZgJG4/RQpGfR7tOil8qPDRv1tapIAm
	uOdKKF+EM6uNmoLJLw3lPX3DdChnaIEa4s6ryFMb98UWl/Z283gwDLLDtVXn4LMglkuS0JhBo7fis
	R0NZ/VEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDSe-0000000Gkyb-13eo;
	Wed, 12 Aug 2026 18:13:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuDSb-0000000GkvX-2OR8
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 18:13:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786558432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vcu9PbtDT1pNYoR33movkVcPOA1p/h5oinwfvgSmomU=;
	b=hY8pqk/1jd6CQhoL7f+oi0IbVT6QJCaxrSEA6KZyHyB+NFOOFLMgtdXkXgPU36rsfmFugO
	jkIf0S29uZUBhjlqnIiubtGKKeTbdrNRwgSlUSznkeNSnJv5vWOrQ3eJLCz5AQfn+LamaA
	vtRabRr5GBRpdLf74XIdZkz8BrrAVUg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258--3g3ShMDN3KjRurcw1SDwA-1; Wed,
 12 Aug 2026 14:13:46 -0400
X-MC-Unique: -3g3ShMDN3KjRurcw1SDwA-1
X-Mimecast-MFC-AGG-ID: -3g3ShMDN3KjRurcw1SDwA_1786558414
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0849C195604B;
	Wed, 12 Aug 2026 18:13:34 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.88.181])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 41C3E180034F;
	Wed, 12 Aug 2026 18:13:28 +0000 (UTC)
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
Subject: [PATCH 04/13] nvme-multipath: queue-depth support for marginal paths
Date: Wed, 12 Aug 2026 14:12:51 -0400
Message-ID: <20260812181300.3712426-5-jtaubepe@redhat.com>
In-Reply-To: <20260812181300.3712426-1-jtaubepe@redhat.com>
References: <20260812181300.3712426-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: cCrN0aT7Qa3FOEA844TMZq5pjhC2gfLbL9pfUHzpnRM_1786558414
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_111353_697526_F26AAF5E 
X-CRM114-Status: GOOD (  16.55  )
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

From: John Meneghini <jmeneghi@redhat.com>

Exclude marginal paths from queue-depth io policy. In the case where all
paths are marginal and no optimized or non-optimized path is found, we
fall back and select the best marginal path.

Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
V10 -> V11:
 - New commit
---
 drivers/nvme/host/multipath.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 02936c580a37..dc34634842be 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -453,7 +453,9 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
 static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
-	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
+	int min_depth_opt = INT_MAX, min_depth_nonopt = INT_MAX;
+	bool opt_is_marginal = true, nonopt_is_marginal = true, marginal;
+
 	unsigned int depth;
 
 	list_for_each_entry_srcu(ns, &head->list, siblings,
@@ -462,28 +464,40 @@ static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
 			continue;
 
 		depth = atomic_read(&ns->ctrl->nr_active);
+		marginal = nvme_ctrl_is_marginal(ns->ctrl);
 
 		switch (ns->ana_state) {
 		case NVME_ANA_OPTIMIZED:
-			if (depth < min_depth_opt) {
+			if (is_best_distance(opt_is_marginal, marginal,
+					     min_depth_opt, depth)) {
 				min_depth_opt = depth;
 				best_opt = ns;
+				opt_is_marginal = marginal;
 			}
 			break;
 		case NVME_ANA_NONOPTIMIZED:
-			if (depth < min_depth_nonopt) {
+			if (is_best_distance(nonopt_is_marginal, marginal,
+					     min_depth_nonopt, depth)) {
 				min_depth_nonopt = depth;
 				best_nonopt = ns;
+				nonopt_is_marginal = marginal;
 			}
 			break;
 		default:
 			break;
 		}
 
-		if (min_depth_opt == 0)
+		if (min_depth_opt == 0 && !opt_is_marginal)
 			return best_opt;
 	}
 
+	/*
+	 * Prefer non-marginal non-optimized path
+	 * over a marginal optimized path.
+	 */
+	if (opt_is_marginal && !nonopt_is_marginal && best_nonopt)
+		return best_nonopt;
+
 	return best_opt ? best_opt : best_nonopt;
 }
 
-- 
2.54.0


