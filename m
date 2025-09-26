Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5A5CAC5B5
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Sep 2025 00:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K7J0OiLYHZMJ0bnG+eMF/IOU5QQ2sTcSBMPLXazN35c=; b=saWLZ/3L7snNsE2p59oBHFZvs3
	AeX+DIrV3eJB7HKUsvAg7bUiP5WaCxn6ftiZ4KK+9UDqh5PlY9mMRiaQhgw6RwzfRt+VP3Y41i00L
	jqNM/a0HGGCC0plRFLA4TeNPjGPKQ44+pc2GwFfogAWk7hmxeJbCu4EVZtKoaPitAeg5lkoUIDJGp
	9mmWlBR1IkjYdmR+8LT5bwFM9EaPaHsfp9Hy/GaVHLFKITu1MiG6Nd3qwQEMN/QmEODUbegoqyv63
	C2liL2rpX/xEyiip5XiBU9jRWBcRCRFZfwmDyo6p6uQu+ez8FVm9bYKwiLYCZQFd2QQm5noIh92OF
	eO6gT22Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1vv0-0000000EAki-0dV3;
	Fri, 26 Sep 2025 00:02:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1vux-0000000EAhe-29CA
	for linux-nvme@lists.infradead.org;
	Fri, 26 Sep 2025 00:02:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758844950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7J0OiLYHZMJ0bnG+eMF/IOU5QQ2sTcSBMPLXazN35c=;
	b=b+JKc/IWCjf2wE8HqoN2iEeKlvyx+FKX5luHT2Hc8LSc/q+UFGu/l+rYfLyTs+4OWZHiv/
	V52wWaGgyFAeWwlEL068GmzZjnsUS7XhR0V7P29GtjvGleAN9ZLHK4Anl1TlGQ+3VLB8DC
	VlAD2e/92t09thyKbQZHGkhJnVxQcPw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-fZ4J0yAeOjWuFzhaAOv6Sw-1; Thu,
 25 Sep 2025 20:02:27 -0400
X-MC-Unique: fZ4J0yAeOjWuFzhaAOv6Sw-1
X-Mimecast-MFC-AGG-ID: fZ4J0yAeOjWuFzhaAOv6Sw_1758844945
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2395C1956096;
	Fri, 26 Sep 2025 00:02:25 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen7.rmtusnh.csb (unknown [10.22.81.200])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E628180035E;
	Fri, 26 Sep 2025 00:02:22 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: hare@suse.de,
	kbusch@kernel.org,
	martin.petersen@oracle.com,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: bgurney@redhat.com,
	axboe@kernel.dk,
	emilne@redhat.com,
	gustavoars@kernel.org,
	hch@lst.de,
	james.smart@broadcom.com,
	jmeneghi@redhat.com,
	kees@kernel.org,
	linux-hardening@vger.kernel.org,
	njavali@marvell.com,
	sagi@grimberg.me
Subject: [PATCH v10 05/11] nvme-multipath: queue-depth support for marginal paths
Date: Thu, 25 Sep 2025 20:01:54 -0400
Message-ID: <20250926000200.837025-6-jmeneghi@redhat.com>
In-Reply-To: <20250926000200.837025-1-jmeneghi@redhat.com>
References: <20250926000200.837025-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_170231_620003_FE7E7CE9 
X-CRM114-Status: UNSURE (   9.85  )
X-CRM114-Notice: Please train this message.
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
2.51.0


