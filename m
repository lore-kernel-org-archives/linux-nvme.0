Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE91C55AB9
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 12:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ITD8nQi5AEPIoEG91hA6U363Jc5ugeo3raC88VmKMT4=; b=G+EJtnpYSpQixWNrp1mm7feh0b
	wy9o6Z7cgLcIt36RKrJ/7AizdfxQ85XpEGSWuf9bSAru897i0KG0VV/TI0ZfT4Oj/uMIghdMnNMEx
	70hOQriMElKqFQFxkCot1m1RH1+REv2pR0izZOEUdMtwt3HcKU8XnyYXSCgQUel9rE02zi9zc7zwc
	ElQ7qoMZVylEApnvmAoM5zwy4sgPkfPfveydQhTOBcaUqY0QFavP684BmoL6vT7IjZBJvaxXtLPAz
	zIJHWXmWdnuEhpuY6m+yyOa9I1NwGfyvZ+w13iiplJKTuII2M7hFww6qdFPtQ9b2t7rppA8DGdS6p
	Fv2wRrKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtPyn-0000000EVET-0jIm;
	Fri, 20 Feb 2026 12:51:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtPyk-0000000EVCj-2zDq
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 12:51:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771591889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITD8nQi5AEPIoEG91hA6U363Jc5ugeo3raC88VmKMT4=;
	b=KiDzqSqJseduEP+ayNUJtsAARDVvLkZRWbyvErde4YsH5mdCz8N4ukHtJcLrbe7JpFPz3e
	xJlRGdsxQdELz+b4wwWYJGtQlNIyvuZw4ZiMT3PTEXOWD7fXSlQx79ODcjkBfbBZAW8gX+
	veKspBWHgV8ysNkZdI7uOD3lt5FjMt8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-nQyVJIIEOGq9X-uDXjV9eA-1; Fri,
 20 Feb 2026 07:51:26 -0500
X-MC-Unique: nQyVJIIEOGq9X-uDXjV9eA-1
X-Mimecast-MFC-AGG-ID: nQyVJIIEOGq9X-uDXjV9eA_1771591885
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 443DA180049D;
	Fri, 20 Feb 2026 12:51:25 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.45.224.125])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 85D261800352;
	Fri, 20 Feb 2026 12:51:21 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mheyne@amazon.de,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@arkamax.eu,
	mkhalfella@purestorage.com
Subject: [PATCH V2 3/5] nvme: pci: use admin queue timeout over NVME_ADMIN_TIMEOUT
Date: Fri, 20 Feb 2026 13:51:06 +0100
Message-ID: <20260220125108.483250-4-mlombard@redhat.com>
In-Reply-To: <20260220125108.483250-1-mlombard@redhat.com>
References: <20260220125108.483250-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aAK04N1GAIk4zeYgyGOvyq-Zp-9FWC7_LE354Tu2YKo_1771591885
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_045130_819194_E420D8FA 
X-CRM114-Status: GOOD (  10.93  )
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

While tearing down its queues, nvme-pci uses NVME_ADMIN_TIMEOUT as its
timeout target. Instead, use the configured admin queue's timeout value
to match the device's existing timeout setting.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 80df992d1ae8..2bceedadded2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2925,10 +2925,11 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 static bool __nvme_delete_io_queues(struct nvme_dev *dev, u8 opcode)
 {
 	int nr_queues = dev->online_queues - 1, sent = 0;
+	struct request_queue *q = dev->ctrl.admin_q;
 	unsigned long timeout;
 
  retry:
-	timeout = NVME_ADMIN_TIMEOUT;
+	timeout = q->rq_timeout;
 	while (nr_queues > 0) {
 		if (nvme_delete_queue(&dev->queues[nr_queues], opcode))
 			break;
-- 
2.53.0


