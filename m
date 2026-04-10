Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14283E9904A
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2026 07:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xuIeTSS1PHB+dylZ5NHCLiVxoQxlUtz0B0jRXwB+GWM=; b=wpJucIaTUauFvpqOMP/SLwRCX8
	zqoiV9dg1RKRwt8Ri8SfQxRYNJWLcC2V+vbKg7KLbDRymCTvEcA/eGusiAOThb3+N6I/npwfow3Kq
	4UpeusyiDRR9or/deuy+RJE9sRu0VjLT1Vt5YmTt4T4ywlwzMpa03/GF2teTB5LEeshe9ILWovsdd
	35S3Zbh8LTeojSBBj5mFtZ/zL+O7KCBiQ0DL37b8GKSl5IwBZO6VmyrlPdeJJ9baACZdkcLU8gJcv
	tdVxQpICx9yNzzk0j9rCxi3uoSiBR8FMSrydXwBOjV6QCAgQ0mtCB3QhAvrQHOttEhs9A6aaFNlm3
	U3NPefwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6Su-0000000Bkyk-2fas;
	Fri, 10 Apr 2026 07:39:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6Sr-0000000Bkxm-3yf4
	for linux-nvme@lists.infradead.org;
	Fri, 10 Apr 2026 07:39:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775806781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xuIeTSS1PHB+dylZ5NHCLiVxoQxlUtz0B0jRXwB+GWM=;
	b=SFJ6dM4ChGzLh2KI7j1Rwhq4C2kVPz7nbmIsYtbhulGVkBnh+Lu+sXvluB6kjsbS1Ql3ff
	PNtwmezCVR4d9m7ycJxY0s8rYRO4Hnx9a4o//dDqYjtTUNdPP48mtZxwbrmONA0oJ+Ld7S
	M2HwOLA6lEi6SEkP2XEXu1Hq0ltBqdc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-_kPjWWjOOKWmgT2IEB6asA-1; Fri,
 10 Apr 2026 03:39:37 -0400
X-MC-Unique: _kPjWWjOOKWmgT2IEB6asA-1
X-Mimecast-MFC-AGG-ID: _kPjWWjOOKWmgT2IEB6asA_1775806775
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2840E180034F;
	Fri, 10 Apr 2026 07:39:35 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.170])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5CDCF18002A6;
	Fri, 10 Apr 2026 07:39:31 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mheyne@amazon.de,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@arkamax.eu,
	mkhalfella@purestorage.com,
	chaitanyak@nvidia.com,
	hare@kernel.org,
	hch@lst.de
Subject: [PATCH V3 1/8] nvme: Let the blocklayer set timeouts for requests
Date: Fri, 10 Apr 2026 09:39:17 +0200
Message-ID: <20260410073924.61078-2-mlombard@redhat.com>
In-Reply-To: <20260410073924.61078-1-mlombard@redhat.com>
References: <20260410073924.61078-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oifKHpWB6umEIR0Ax59Eejp6bXydB1VlzbrZ9t4whtE_1775806775
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_003942_060831_8C0132A3 
X-CRM114-Status: GOOD (  14.88  )
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

From: "Heyne, Maximilian" <mheyne@amazon.de>

When initializing an nvme request which is about to be send to the block
layer, we do not need to initialize its timeout. If it's left
uninitialized at 0 the block layer will use the request queue's timeout
in blk_add_timer (via nvme_start_request which is called from
nvme_*_queue_rq). These timeouts are setup to either NVME_IO_TIMEOUT or
NVME_ADMIN_TIMEOUT when the request queues were created.

Because the io_timeout of the IO queues can be modified via sysfs, the
following situation can occur:

1) NVME_IO_TIMEOUT = 30 (default module parameter)
2) nvme1n1 is probed. IO queues default timeout is 30 s
3) manually change the IO timeout to 90 s
   echo 90000 > /sys/class/nvme/nvme1/nvme1n1/queue/io_timeout
4) Any call of __submit_sync_cmd on nvme1n1 to an IO queue will issue
   commands with the 30 s timeout instead of the wanted 90 s which might
   be more suitable for this device.

Commit 470e900c8036 ("nvme: refactor nvme_alloc_request") silently
changed the behavior for ioctl's already because it unconditionally
overrides the request's timeout that was set in nvme_init_request. If it
was unset by the user of the ioctl if will be overridden with 0 meaning
the block layer will pick the request queue's IO timeout.

Following up on that, this patch further improves the consistency of IO
timeout usage. However, there are still uses of NVME_IO_TIMEOUT which
could be inconsistent with what is set in the device's request_queue by
the user.

Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 drivers/nvme/host/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b42d8768d297..111f9a226952 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -724,10 +724,8 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
 		struct nvme_ns *ns = req->q->disk->private_data;
 
 		logging_enabled = ns->head->passthru_err_log_enabled;
-		req->timeout = NVME_IO_TIMEOUT;
 	} else { /* no queuedata implies admin queue */
 		logging_enabled = nr->ctrl->passthru_err_log_enabled;
-		req->timeout = NVME_ADMIN_TIMEOUT;
 	}
 
 	if (!logging_enabled)
-- 
2.53.0


