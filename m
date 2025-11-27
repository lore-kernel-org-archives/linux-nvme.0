Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D16D111A8
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 15:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ou4g2gpbqdyWYYdF4trm4Wyw1sQfHw28pV0QqLzlfAc=; b=BzVSPU/i0e9ufPwQVkxCMd4j7G
	+AYDUyJwtc3uicxBpGWuE+nfjQG5jCfdLHR7tfrAqOmdb+FlQd54UF7yLD2D7zvTbAshx8HeU3pt5
	FsPrvafhqysjF5Xt6c9v58X7wd3Vp39APbmm2AdaoEret4/EPsjPxssNIbW6WhF9VariSp1VetH5H
	UnxfJuogRPIPeQDgAcBdDUFT2ZDaJ3+Rs7v+/GCqVY+j1BJBcCL3+vbCGye7AKFYghqc7uRR2zfHd
	R8ZQqBNcJ7KQgD3wgmW9OrHNyi9K9RKWdNFoQPitkfy3vBLmW4abWS/gqCH4LyyWbtfDZyAbM1GP1
	hwxrI8PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOeKM-0000000GsKH-07Ol;
	Thu, 27 Nov 2025 15:54:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOeKJ-0000000GsJa-3Cfx
	for linux-nvme@lists.infradead.org;
	Thu, 27 Nov 2025 15:54:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764258874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ou4g2gpbqdyWYYdF4trm4Wyw1sQfHw28pV0QqLzlfAc=;
	b=ZS0JoGxKNkF1W0oZ/9AiJL9Pd84MmZrEjSI2a7tjDBgYT6DnGK1AgzKvsoRYITVBEs7RzM
	pT905H2u78srulgtDwBz7P6XrAbGexD+DwOw1VZJ+QOBtWqbbMA7UThnAb4zG3aCaYWqWI
	1P8lPghZxQE4pgNSQGist/jYP/EUzbw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-oGuaWfK9POKJ1NkOxmYQxQ-1; Thu,
 27 Nov 2025 10:54:31 -0500
X-MC-Unique: oGuaWfK9POKJ1NkOxmYQxQ-1
X-Mimecast-MFC-AGG-ID: oGuaWfK9POKJ1NkOxmYQxQ_1764258869
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DB32195609D;
	Thu, 27 Nov 2025 15:54:28 +0000 (UTC)
Received: from localhost (unknown [10.2.16.53])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13FEF19560B0;
	Thu, 27 Nov 2025 15:54:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-block@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Christoph Hellwig <hch@lst.de>,
	Mike Christie <michael.christie@oracle.com>,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 0/4] block: add IOC_PR_READ_KEYS and IOC_PR_READ_RESERVATION ioctls
Date: Thu, 27 Nov 2025 10:54:20 -0500
Message-ID: <20251127155424.617569-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_075436_216276_BFB04EEB 
X-CRM114-Status: GOOD (  11.01  )
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

v2:
- Fix num_keys validation in patches 1-3 [Hannes]
- Declare local variables at beginning of scope [Hannes]

This series exposes struct pr_ops pr_read_keys() and pr_read_reservations() to
userspace as ioctls, making it possible to list registered reservation keys and
report the current reservation on a block device.

The new ioctls are needed by applications or cluster managers that rely on
inspecting the PR state. This is something that has been possible with SCSI-
and NVME-specific commands but not with the PR ioctls. I hope to move QEMU from
SG_IO to PR ioctls so that NVMe host block devices can be supported alongside
SCSI devices without protocol-specific commands.

These ioctls will also make troubleshooting possible with the blkpr(8)
util-linux tool, for which I have prepared a separate patch series.

Stefan Hajnoczi (4):
  scsi: sd: reject invalid pr_read_keys() num_keys values
  nvme: reject invalid pr_read_keys() num_keys values
  block: add IOC_PR_READ_KEYS ioctl
  block: add IOC_PR_READ_RESERVATION ioctl

 include/uapi/linux/pr.h | 14 +++++++
 block/ioctl.c           | 87 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/pr.c  |  4 ++
 drivers/scsi/sd.c       | 11 +++++-
 4 files changed, 115 insertions(+), 1 deletion(-)

-- 
2.52.0


