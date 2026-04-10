Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78626E9904A
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2026 07:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HjsgWsxKoK2eaKxnrqn65IGzej9yJt6Jvl1EjVR4/XU=; b=ZT0PR7ISgiTEiG5cvx5v5CyPs4
	7ja2gzEH5yjTz7w3oAKnZie9d0OtxHJb5D2gtTwVgn6PThRhabUH3yFDitwNb/e7074X45RO0q1co
	f50TC8nkuYcE2ba4A3EOIMhRK1+Oi9HlvA7oHSb3qPRQYrXGwC4rqCsUdc+BME9KaYk1lU71VI+li
	zRS9CQDnuegWpGZ3zd3BbMRUFdmvYOPN5D2MJqd4PJiBJIYIVqQS5CyUw/E2pvKNUBc5K1cX0qjgr
	gYPyY2mOK2dK+9SOSgsHcv+Ix53YcXnRwkZfO9AtIRZqufvjSi7vayC/56uSgby+zyjfFXgIx0SGJ
	A62dFn3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6T0-0000000Bl2j-3cLi;
	Fri, 10 Apr 2026 07:39:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6Sz-0000000Bl1T-0dCN
	for linux-nvme@lists.infradead.org;
	Fri, 10 Apr 2026 07:39:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775806788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjsgWsxKoK2eaKxnrqn65IGzej9yJt6Jvl1EjVR4/XU=;
	b=U5J7ZXRKirwnbC1/Or7A3fWHNRgEYbkHpcDAgs9M1OHA/izy6Ofrd6iuaRMnnzt6GDjR96
	8mlrjhA5qtR6p4Pop8t8r+FzjCurD3iO13GZGr2UL5TRNFcApWidBZDb/R1sMJ1bbY818v
	seO5/UCT1btLWcMlP1EW0/YhaQ7nW7k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-v3Hv_xMuP4-hzar4nRp9dg-1; Fri,
 10 Apr 2026 03:39:44 -0400
X-MC-Unique: v3Hv_xMuP4-hzar4nRp9dg-1
X-Mimecast-MFC-AGG-ID: v3Hv_xMuP4-hzar4nRp9dg_1775806783
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1A511800365;
	Fri, 10 Apr 2026 07:39:42 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.170])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79E771800B7F;
	Fri, 10 Apr 2026 07:39:39 +0000 (UTC)
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
Subject: [PATCH V3 3/8] nvme: pci: use admin queue timeout over NVME_ADMIN_TIMEOUT
Date: Fri, 10 Apr 2026 09:39:19 +0200
Message-ID: <20260410073924.61078-4-mlombard@redhat.com>
In-Reply-To: <20260410073924.61078-1-mlombard@redhat.com>
References: <20260410073924.61078-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JY4bHtewpAgeHW9xMLMfx5CYkK1jL5GQtG9iHhvXyvA_1775806783
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_003949_255892_CCAE4C25 
X-CRM114-Status: GOOD (  10.57  )
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
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9aa19255b041..379c75c6d35a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3091,7 +3091,7 @@ static bool __nvme_delete_io_queues(struct nvme_dev *dev, u8 opcode)
 	unsigned long timeout;
 
  retry:
-	timeout = NVME_ADMIN_TIMEOUT;
+	timeout = dev->ctrl.admin_timeout;
 	while (nr_queues > 0) {
 		if (nvme_delete_queue(&dev->queues[nr_queues], opcode))
 			break;
-- 
2.53.0


