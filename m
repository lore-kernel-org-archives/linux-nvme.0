Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8112C624DA
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 20:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B4SOQVx6UDmhZ26lSu1cCcYqEQXYt2vou3jNd344Y+M=; b=Szvmz8ZuEzmgnB9HMEtZX0LhEH
	4HK/rKowsjWbQ4QvGfbetkP+NIs0kKCr4fjIY+UbR08TEn8QvqYnFSZvx+471+XCYPNWjYujnQEHB
	cRVTHueFuKSt84yv2AnT2UrY16JbIArwOnTkcHKNANYqkhOTXp7FUmB9kN3AS7YdO4WQID4M7Y7IG
	VYfmKSPj8gaP2KdswqQiQpm4km5FHTpx49Zw1ysV1BrtS3O9dy7jLHEvenZEEThFuigg2xrBPrkER
	Jpyl67x2/tIo18GM8CJQiWOBYviM3tv/6iLBxkSm1iGUVu37KxmXbwptmgoP6+718CIdSjJqV1Qul
	pe7q5P0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1rDs-0000000FoR5-21A7;
	Wed, 02 Sep 2026 20:06:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1rDq-0000000FoQ0-2A3t
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 20:06:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788379573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B4SOQVx6UDmhZ26lSu1cCcYqEQXYt2vou3jNd344Y+M=;
	b=VeA+7WkM8AfRcRn0mmtbiatRG+adlidrwZRlIR8W+XvPr8VHRDrwJnyqJzMG+hfusU7IC7
	Lx82CM8btT4dMPh60chHlGhUxheuR1dIgMaCBJw0VQFovfokKTfKAX5+2sDeDHDVBbZnjR
	pEn8HtacZ1RqMpvgba/T/3uq/Q6WEZA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-wFa_C8tYM3y7FXo3Jv1X2Q-1; Wed,
 02 Sep 2026 16:06:11 -0400
X-MC-Unique: wFa_C8tYM3y7FXo3Jv1X2Q-1
X-Mimecast-MFC-AGG-ID: wFa_C8tYM3y7FXo3Jv1X2Q_1788379565
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74E081808898;
	Wed,  2 Sep 2026 20:06:04 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.17.16.153])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2AF5D1955F03;
	Wed,  2 Sep 2026 20:06:01 +0000 (UTC)
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
Subject: [PATCH v2 3/7] nvme-multipath: queue-depth support for marginal paths
Date: Wed,  2 Sep 2026 16:05:43 -0400
Message-ID: <20260902200547.184734-4-jtaubepe@redhat.com>
In-Reply-To: <20260902200547.184734-1-jtaubepe@redhat.com>
References: <20260902200547.184734-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: loOoUlXVwF-KQbsBP1CKDi1_rJJgAAAf-nHGypvpI3E_1788379565
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_130614_630590_67CDE413 
X-CRM114-Status: GOOD (  15.03  )
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
V10 -> V1:
 - New commit
V1 -> V2:
 - Rewrite
---
 drivers/nvme/host/multipath.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index dbf09cdda815..f28797deab68 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -439,12 +439,17 @@ static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
 	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
 	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
 	unsigned int depth;
+	bool need_marginal = nvme_all_paths_marginal(head);
 
 	list_for_each_entry_srcu(ns, &head->list, siblings,
 				 srcu_read_lock_held(&head->srcu)) {
 		if (nvme_path_is_disabled(ns))
 			continue;
 
+		/* Skip marginal paths unless we need to use them */
+		if (!need_marginal && nvme_ctrl_is_marginal(ns->ctrl))
+			continue;
+
 		depth = atomic_read(&ns->ctrl->nr_active);
 
 		switch (ns->ana_state) {
-- 
2.55.0


