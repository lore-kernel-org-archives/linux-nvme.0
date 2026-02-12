Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F089EEB4914
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 12:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jfLGEF23493PitfPgnERF2wV6qssIMuQy46WO9oJH2Y=; b=vnKtwHVEZvieEsXYTfk5mmFPEf
	r/EsWnoflctqQ+MTQvBs6QoQPH/zzsBbgFO0ci45RUm6vLHBNqikjSjOLqOUSysITb6Ra9c8wB1C+
	HqV9vwKBcfPAynP60E6/zKALOFVmMd++dJ/ly3uQl+qk9P14nxbQKXFcc36x8IFxRxYsQURsi7Arz
	lwCRPMWXTikmMn0w51AzLWfHOSuTFsVCCSqWBF8HQakLzk2O1w3IXMQ7SIE6SQLv1MIE6pApk7dqW
	vGOsi0QR8wCGXbb7gI1T1o6aGGchG5k/dR9YbPsn4mw3mN9qaVMKOpDiPz3RwEiK9iMVpDBar0zn8
	GyaelvPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqVWN-000000023X4-1aPV;
	Thu, 12 Feb 2026 12:10:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqVWK-000000023VU-2SaW
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 12:10:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770898207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfLGEF23493PitfPgnERF2wV6qssIMuQy46WO9oJH2Y=;
	b=GxbqxpXjOnt+DrehKB6NVU8+DC7ggokermFjNAP7HzcXGh46WKq0wrZIsiJwEyjUbQKOWc
	QMLEfw2tO2R49WWVD/MU6KnWDUvtUzBPNvuzkU1qNaqW7T+OAKTSCYD58rKtoIJk4oVoH/
	qTMCmUYHbFU8cTFpRD90ipqGmOwlzDU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-8i-7C27RMi295Z2O7oFNqA-1; Thu,
 12 Feb 2026 07:10:06 -0500
X-MC-Unique: 8i-7C27RMi295Z2O7oFNqA-1
X-Mimecast-MFC-AGG-ID: 8i-7C27RMi295Z2O7oFNqA_1770898205
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 061011954117;
	Thu, 12 Feb 2026 12:10:04 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 548AB1956095;
	Thu, 12 Feb 2026 12:10:01 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mheyne@amazon.de,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@bsdbackstore.eu
Subject: [PATCH RFC 3/5] nvme: pci: use admin queue timeout over NVME_ADMIN_TIMEOUT
Date: Thu, 12 Feb 2026 13:09:49 +0100
Message-ID: <20260212120951.79738-4-mlombard@redhat.com>
In-Reply-To: <20260212120951.79738-1-mlombard@redhat.com>
References: <20260212120951.79738-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _2P2rKT0aYZyQGcpgATeBy3At97d48FLw5aoG5FiIlw_1770898205
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_041008_698056_360725BE 
X-CRM114-Status: GOOD (  11.11  )
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

From: David Jeffery <djeffery@redhat.com>

While tearing down its queues, nvme-pci uses NVME_ADMIN_TIMEOUT as its
timeout target. Instead, use the configured admin queue's timeout value
when available to match the device's existing timeout setting.

Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 58f3097888a7..853cd57e4480 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2911,9 +2911,10 @@ static bool __nvme_delete_io_queues(struct nvme_dev *dev, u8 opcode)
 {
 	int nr_queues = dev->online_queues - 1, sent = 0;
 	unsigned long timeout;
+	struct request_queue *q = dev->ctrl.admin_q;
 
  retry:
-	timeout = NVME_ADMIN_TIMEOUT;
+	timeout = q ? q->rq_timeout : NVME_ADMIN_TIMEOUT;
 	while (nr_queues > 0) {
 		if (nvme_delete_queue(&dev->queues[nr_queues], opcode))
 			break;
-- 
2.53.0


