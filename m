Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AA7CD5BA4
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 12:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x8epAYec+NTIeOshMc3P6x0VziapTuVJ8PwEr+v0L30=; b=S/ZjHlXB8twGPnIoUeTJ/8VocM
	QRtw0DDh0XEVS1+z+0jDT6DhhIojzo0zjv8dZtXGxbWmaUCcmlKF+BY9NCcvXtAIq/GVq6K+0T4w/
	0rVnLdx1yoB+NBWWajtD2p0DAk4+FAtybexe1rUWFvihHCVLED9tHlEn1i1kjmiCTx5r3UMw+D1SZ
	uA4+1pqxsgZSljkZeI2v574SOggOJf5qvanVgCOEL4VMoSf23g6EvjVHKGmw14nw5FlmuScjQ7sut
	nJ/1LMtfLgW3lHrWq4dv5KG59y3h2KVo17RWMMmxuLLVLUzLR1nSMI3EdxH/2TF6jpbMxscsleUYl
	PQre1Zew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ2XH-00000007jT2-0ZqI;
	Thu, 21 May 2026 12:29:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ2XD-00000007jRU-3n9j
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 12:29:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779366593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x8epAYec+NTIeOshMc3P6x0VziapTuVJ8PwEr+v0L30=;
	b=BEAZxISctxfr3T3CvlU79/zVlZaMgS158/hVbIOmURLNqOuQmfBqLOBm9D6tEm4uoSISaZ
	1Gx360cRi41se7FtFLrbm4sOTbjy9SxR5aGlQ47ZsD8RCE6ECZPhAkZBRexdMMNWEsYYMZ
	Z2EQaW1IgzdiSdAc9qp20fsM7lsdnj0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-DEaIumwpNp6LRj_K1FIB-A-1; Thu,
 21 May 2026 08:29:48 -0400
X-MC-Unique: DEaIumwpNp6LRj_K1FIB-A-1
X-Mimecast-MFC-AGG-ID: DEaIumwpNp6LRj_K1FIB-A_1779366587
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D151195608B;
	Thu, 21 May 2026 12:29:46 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.48.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8728519560AB;
	Thu, 21 May 2026 12:29:42 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: dwagner@suse.de,
	mkhalfella@purestorage.com,
	hare@kernel.org,
	hch@lst.de,
	mlombard@arkamax.eu,
	linux-nvme@lists.infradead.org,
	error27@gmail.com
Subject: [PATCH] nvme-core: fix unsigned comparison warning in nvme_wait_freeze_timeout
Date: Thu, 21 May 2026 14:29:40 +0200
Message-ID: <20260521122941.418049-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5ZWc8D2mYV1T8SkeNnSKhDJsnZcJkxwVZDfpLwUMdtk_1779366587
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_052956_014112_27FB5AD0 
X-CRM114-Status: GOOD (  10.97  )
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

The timeout variable in nvme_wait_freeze_timeout() is an unsigned type.
Checking if it is <= 0 triggers a compiler warning because an unsigned
variable can never be negative.

Fix this warning by changing the condition to !timeout.

blk_mq_freeze_queue_wait_timeout() is a wrapper for
wait_event_timeout() and the latter returns 0 or a positive value.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202605211257.STzj2Ujv-lkp@intel.com/
Fixes: 23b6d2cbf75f ("nvme: remove redundant timeout argument from nvme_wait_freeze_timeout")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 72c50d5e938d..26a65404279f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5254,7 +5254,7 @@ int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl)
 	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
 				 srcu_read_lock_held(&ctrl->srcu)) {
 		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
-		if (timeout <= 0)
+		if (!timeout)
 			break;
 	}
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
-- 
2.54.0


