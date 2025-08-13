Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054DDCA0EE4
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 21:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r8TVetdancKlSFrfJSB6yQxe4MFxTONVgMPDkztUaCk=; b=ucIqqN2f7veQ71tvn9hSErzkJb
	Mt6tXIbl9bsnfRih6QrhmnMS9EFqw+5wiRL60MVN9lXd1mzscfxq7oj70algFaXfcup1JIPrjzSzs
	uiFFxVMeC3B2yxWz/ATCLs9Hp5pV1NlXemidNR+x/TemLD6d+Yzn/2gQxxQ+tUtJ1iJlW0Bdf9pTC
	2BZtpzzmgRwXZw35m/QnGU0P8YZD2t11TDbPf/d1cFf/lNAUn/HevOeed6Mh0BFgEbQVzyWef4UBN
	NADCcE/lBhHfYeskqTzasKfiS42roU9QJcSO66zSEIomyP51m5bhmBsRa59PbpuTI367ljpr/c9eL
	41iiDSuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umIpe-0000000Ezdd-2bgn;
	Wed, 13 Aug 2025 21:16:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umHmN-0000000EuiE-0fg2
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 20:09:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755115738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8TVetdancKlSFrfJSB6yQxe4MFxTONVgMPDkztUaCk=;
	b=CFYnVjqt3yuMMXSfqlFl/rMOSUqoR21gHN7/O5LzHDWYq+QVUnfhag79rtXcGCfwypQXg/
	wyIPWyXY08qeZ8+RjiYh+YBTGpe3vwXM7nYWt9L239YesSM1JhmqKuYR+HkzB9Gtq2N1Fu
	Uta7WCBPkkWcILjvhRkql1RnKX3ZnIE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-N8_2nS2bNFqZBOD4IFl2Sg-1; Wed,
 13 Aug 2025 16:08:57 -0400
X-MC-Unique: N8_2nS2bNFqZBOD4IFl2Sg-1
X-Mimecast-MFC-AGG-ID: N8_2nS2bNFqZBOD4IFl2Sg_1755115735
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 324A219560B4;
	Wed, 13 Aug 2025 20:08:55 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.44.32.39])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22331180044F;
	Wed, 13 Aug 2025 20:08:48 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: james.smart@broadcom.com,
	njavali@marvell.com,
	linux-scsi@vger.kernel.org,
	hare@suse.de,
	linux-hardening@vger.kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	bgurney@redhat.com,
	jmeneghi@redhat.com,
	emilne@redhat.com
Subject: [PATCH v9 8/9] nvme-multipath: queue-depth support for marginal paths
Date: Wed, 13 Aug 2025 16:07:43 -0400
Message-ID: <20250813200744.17975-9-bgurney@redhat.com>
In-Reply-To: <20250813200744.17975-1-bgurney@redhat.com>
References: <20250813200744.17975-1-bgurney@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_130859_265851_08B9DBF0 
X-CRM114-Status: GOOD (  11.28  )
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
fall back to __nvme_find_path which selects the best marginal path.

Tested-by: Bryan Gurney <bgurney@redhat.com>
Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/multipath.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c042a9a11ce3..38e40dd88e52 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -420,6 +420,9 @@ static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
 		if (nvme_path_is_disabled(ns))
 			continue;
 
+		if (nvme_ctrl_is_marginal(ns->ctrl))
+			continue;
+
 		depth = atomic_read(&ns->ctrl->nr_active);
 
 		switch (ns->ana_state) {
@@ -443,7 +446,9 @@ static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
 			return best_opt;
 	}
 
-	return best_opt ? best_opt : best_nonopt;
+	best_opt = (best_opt) ? best_opt : best_nonopt;
+
+	return best_opt ? best_opt : __nvme_find_path(head, numa_node_id());
 }
 
 static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
-- 
2.50.1


