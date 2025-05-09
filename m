Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37CDC3ABCC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 17:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+JMc8eTKJVWCzq0oS/b4mNyPfKW/t3wh/H4OZoL/d7o=; b=w4DW9At1uyH/0PqP5lcPMC3OUb
	17BjCZVj1oLpXxfRo70hhZ772LMpyHYHBpnb1pysKhIJcgD17ztQ5vbiYkfFf/zCyyrf80MJMeN5F
	p9K4xQH7nzWfDbgHRlImeafWhP1+lphvUD8SqBc9219riIdWx3Ab3ngDNaN5a+22rtDPushUKIyAj
	8JTdvhgZmYkt21mevLVVZY8qgsZNSvOkAOWnYvqpa21CO7VOk4y4xdWqGTu8voAB2XEA4LQpT9Hg/
	Xng2R5nnVmAOsMRevd/18NwOb5CxtrwuTzqG5P5Quy3hM5kQnBIraPHjX67JOD1ldHoDyypSpttO+
	UsYkEwuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDRNO-00000004Q6d-0hYx;
	Fri, 09 May 2025 17:19:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDPTK-000000043Tz-3XuI
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 15:17:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746803826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+JMc8eTKJVWCzq0oS/b4mNyPfKW/t3wh/H4OZoL/d7o=;
	b=LdiI13iLOiLeiTJwRVUERrQkog7cfBlkLtSPQV+zzOfipieDfUdTJyauTF9w02dqmrErtg
	H64isVYuSKcabjpaBCaKSvS6FTBOaz33ZO0P6t+Q4M4/0V4m6Ms3GpqB9IfDBJj151OaSQ
	C+De1vhj4otKU29N5d/4iHI8tCo2vfY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-lggyA3xAOZGnKD4ll0LhUg-1; Fri,
 09 May 2025 11:17:05 -0400
X-MC-Unique: lggyA3xAOZGnKD4ll0LhUg-1
X-Mimecast-MFC-AGG-ID: lggyA3xAOZGnKD4ll0LhUg_1746803824
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FC4A1956063;
	Fri,  9 May 2025 15:17:04 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.22.64.239])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 393311956095;
	Fri,  9 May 2025 15:17:02 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: bgurney@redhat.com,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: jmeneghi@redhat.com,
	mlombard@bsdbackstore.eu
Subject: [PATCH 2/2] nvme: print warning on non-unique namespace identifier
Date: Fri,  9 May 2025 11:16:59 -0400
Message-ID: <20250509151659.20532-1-bgurney@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OnXNFfYSnvyG7_LPa24u314sTgMz66DHcgCcUSLbasQ_1746803824
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_081710_951077_91B99245 
X-CRM114-Status: GOOD (  10.51  )
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

If a duplicate ID is detected, print a warning about a suspected
firmware bug, that a non-unique identifier was found.

Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Bryan Gurney <bgurney@redhat.com>
---
 drivers/nvme/host/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 49ca29c64ca9..5670c25d1144 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3579,8 +3579,11 @@ static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
 
 	if (has_uuid) {
 		list_for_each_entry(h, &subsys->nsheads, entry)
-			if (uuid_equal(&ids->uuid, &h->ids.uuid))
+			if (uuid_equal(&ids->uuid, &h->ids.uuid)) {
+				dev_warn(&subsys->dev,
+					 "firmware bug: non-unique uuid found\n");
 				return -EINVAL;
+			}
 		return 0;
 	}
 
@@ -3588,8 +3591,11 @@ static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
 		list_for_each_entry(h, &subsys->nsheads, entry)
 			if (memcmp(&ids->nguid,
 				   &h->ids.nguid,
-				   sizeof(ids->nguid)) == 0)
+				   sizeof(ids->nguid)) == 0) {
+				dev_warn(&subsys->dev,
+					 "firmware bug: non-unique nguid found\n");
 				return -EINVAL;
+			}
 		return 0;
 	}
 
@@ -3597,8 +3603,11 @@ static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
 		list_for_each_entry(h, &subsys->nsheads, entry)
 			if (memcmp(&ids->eui64,
 				   &h->ids.eui64,
-				   sizeof(ids->eui64)) == 0)
+				   sizeof(ids->eui64)) == 0) {
+				dev_warn(&subsys->dev,
+					 "firmware bug: non-unique eui64 found\n");
 				return -EINVAL;
+			}
 		return 0;
 	}
 
-- 
2.49.0


