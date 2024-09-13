Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A8FFA3759
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 13:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UqBq3X2g8cgBbm8DL2dBq09ONW6vdYfWTbSC4AkmVtM=; b=zlvHUslqe2+85wEUKdkNx/PZgU
	IAWkmP2pYF1Cx+o9mYx60gRoaYGkBvAGyQ8yj7RXrZS340vRd5eZS9gzjW7Fe/3p+umxfKDMFCe9H
	Nc9seFmbuO1Q4vCY167bYdvJsqB0GBcnH5qfKarEMYvUKaZ1wtdCypLGOCkhoIdnqSbgnA8/H6X64
	FRWSlAKYcNLOkVkpypunj3Y3rW37vB+5qW628mokEPljTBJpe/WqW0/SG27Ss/rn6Wign2+rolAAz
	Qxv7nVfoF+nakW+nin8S+iGMOL5WKNkPD7Or8DzeNyhnSDbol8zx5lIefLFDiZRpy5JhxdaA0MPMR
	bmr31QBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6bk-0000000G4aP-2SJl;
	Fri, 13 Sep 2024 13:45:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6ba-0000000G4YE-11F9
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 13:44:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726235097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqBq3X2g8cgBbm8DL2dBq09ONW6vdYfWTbSC4AkmVtM=;
	b=JDkuXGuo/gU+kBg9qROGxHfptCpATsZRCXqAgRhvEQVRzzaqVl7nweajjGJ5nNbualKbFu
	E7ErsPBuQlqeGnzb1Qj2cMJ/UVeHrCcEg66j45gINyK7mMwxhDFBjUhRvKXvvGLltv058d
	6gHYVIrEgSMPn+MwqiCxeox2aaonJ4A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-c-DaReOePwO-183v8nzhvA-1; Fri,
 13 Sep 2024 09:44:54 -0400
X-MC-Unique: c-DaReOePwO-183v8nzhvA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FE7D1955BE5;
	Fri, 13 Sep 2024 13:44:53 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.65.135])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F3AD3001D11;
	Fri, 13 Sep 2024 13:44:50 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: Keith Busch <kbusch@kernel.org>,
	ens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	David Jeffery <djeffery@redhat.com>
Subject: [PATCH 3/4] nvme: pci: use admin queue timeout over NVME_ADMIN_TIMEOUT
Date: Fri, 13 Sep 2024 09:44:29 -0400
Message-ID: <20240913134430.5416-4-djeffery@redhat.com>
In-Reply-To: <20240913134430.5416-1-djeffery@redhat.com>
References: <20240913134430.5416-1-djeffery@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_064458_374764_B3351519 
X-CRM114-Status: GOOD (  12.45  )
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
when available to match the device's existing timeout setting.

Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c0533f3f64cb..823476f4e42f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2467,9 +2467,10 @@ static bool __nvme_delete_io_queues(struct nvme_dev *dev, u8 opcode)
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
2.46.0


