Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F56CD3436
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2026 13:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2+OxyQMqQfbtfK53xIjesZ/ycJC8Pw8uhuNGwjElzSc=; b=ZLgvfesE/T2qBtpaj4s28PLAj3
	kg1du+K6mBaULPg65rjOzL/k9DQWUJQiI0tJx8ecR9U8idC7FlTkLiNz+M5YnLbsynLfSZhUz/mJw
	bxN6G0w6zXD4QNgycHysBBcQi0s77CqKfSsOw9KW8I3vAVyOSKWE8Qc92AMShJv/aIZaRBl2j7Fu8
	s8V4oFsIh6B45jmU2XpuzYBf11d74YDCqAgGNJUN5mAn+YCdwzqWYMRbRs1UykFoxV7iGfYyPErP/
	mVNWzQs+g/3rUG5QTP8RHwHRYt0eA6HKVlFIKgerGUCg0ouxycb14p1wN4nELX5ABFjMCFjvviF9c
	VyD/ZBlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLLLF-00000006Yfa-1Rpb;
	Fri, 08 May 2026 13:34:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLLLC-00000006Ycj-1nIG
	for linux-nvme@lists.infradead.org;
	Fri, 08 May 2026 13:34:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778247245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+OxyQMqQfbtfK53xIjesZ/ycJC8Pw8uhuNGwjElzSc=;
	b=Zo+n268pmlmS3+u/lgWoxIEHTHsUYpKKyuzNJf1ZQZquApYmYX94zypnpcvI3b24T3LMTj
	kxR7vhCc+FfIa0j9DxW9FXN6DYSXZm7T+gdydbx3DF2Bv6QNB84gkw0jgvOceXflqMRfY6
	xlYB82VXci1Y/fnXYTdm4HCyjhHebY4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-jzJFkYu6NRezjJUaUw8A1g-1; Fri,
 08 May 2026 09:34:02 -0400
X-MC-Unique: jzJFkYu6NRezjJUaUw8A1g-1
X-Mimecast-MFC-AGG-ID: jzJFkYu6NRezjJUaUw8A1g_1778247237
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49B44180060F;
	Fri,  8 May 2026 13:33:57 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.105])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0142D195394A;
	Fri,  8 May 2026 13:33:53 +0000 (UTC)
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
Subject: [PATCH V4 4/9] nvme: pci: use admin queue timeout over NVME_ADMIN_TIMEOUT
Date: Fri,  8 May 2026 15:33:30 +0200
Message-ID: <20260508133335.98612-5-mlombard@redhat.com>
In-Reply-To: <20260508133335.98612-1-mlombard@redhat.com>
References: <20260508133335.98612-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5cRvG2R8w6HLO-7KJpBrufIek7w_8-AUWwXvHnjYv3o_1778247237
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_063406_532559_A50DDA9F 
X-CRM114-Status: GOOD (  10.68  )
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

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9fd04cd7c5cb..dd1bc3807a2d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3094,7 +3094,7 @@ static bool __nvme_delete_io_queues(struct nvme_dev *dev, u8 opcode)
 	unsigned long timeout;
 
  retry:
-	timeout = NVME_ADMIN_TIMEOUT;
+	timeout = dev->ctrl.admin_timeout;
 	while (nr_queues > 0) {
 		if (nvme_delete_queue(&dev->queues[nr_queues], opcode))
 			break;
-- 
2.54.0


