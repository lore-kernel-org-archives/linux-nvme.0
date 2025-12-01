Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1051FD116F6
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 21:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yrYQN3GFchT9vktyOBuE240rtI/tNrya4XeIT60BS5g=; b=HyY3lMoBMW6dBCJuKCXwrxJTI9
	MecQ0B4P/H0NUEhy/bpgIpLc1yCxIiRXkLq9Pjb5WoimO398vyzGd3meLwhLAKIU9V079ArRUiDkl
	Ntbss6tqUOrprWmGURtlVRPiJCfsjXWk6uDyKcNYTTn8biKl44JktnFQsxOq72ko+tj1V+uq0m8xQ
	NY0XISq6QrlOUGPvAno7Pf5XTpxwn5oRZl35sGt/tkzQuN3j7A2ojosClXvL3Lbqx3pkuuaBKvxba
	VTQpMmlzixSNE+3LzSs6yrIj/d3p2W+pSXcVwBSnMP31Sd7AfAbso1BFrDs/uFAO1ykiYqpZ4kDsp
	4P4QILOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQBgW-00000004Y3U-0CWC;
	Mon, 01 Dec 2025 21:43:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQBgM-00000004Y1I-18N3
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 21:43:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764625420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yrYQN3GFchT9vktyOBuE240rtI/tNrya4XeIT60BS5g=;
	b=Mj0wkjSfWYt3muGtgZFjRt9ZO8pRXLQEPMDbFfj3vijwXZUujRUSlul0aGBd93LuDNOjmi
	PI9AMTB/69RjCBIvEL6CKzgT0UkS9fjpfWnuALjzkvV0PUKeffs+Jo2y9/hGu9qYFoIG6C
	uQ3Ml2aXZp1DKfsTkP6asZo4/bGeYHY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-aBrDrz7yNLyJJu19yzJ8HQ-1; Mon,
 01 Dec 2025 16:43:34 -0500
X-MC-Unique: aBrDrz7yNLyJJu19yzJ8HQ-1
X-Mimecast-MFC-AGG-ID: aBrDrz7yNLyJJu19yzJ8HQ_1764625413
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 101991800452;
	Mon,  1 Dec 2025 21:43:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.172])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE40F19560A7;
	Mon,  1 Dec 2025 21:43:30 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Mike Christie <michael.christie@oracle.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-nvme@lists.infradead.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 0/4] block: add IOC_PR_READ_KEYS and IOC_PR_READ_RESERVATION ioctls
Date: Mon,  1 Dec 2025 16:43:25 -0500
Message-ID: <20251201214329.933945-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_134342_398544_9966ECEB 
X-CRM114-Status: GOOD (  12.16  )
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

v3:
- Use checked_mul_overflow(), struct_size(), etc to avoid duplicating size calculations [Christoph]
- Don't use __free() from cleanup.h [Christoph, Krzysztof]
- Drop one-time use num_copy_keys local variable [Christoph]
- Rename inout local variable to read_keys [Christoph]

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
 block/ioctl.c           | 84 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/pr.c  |  6 ++-
 drivers/scsi/sd.c       | 12 +++++-
 4 files changed, 114 insertions(+), 2 deletions(-)

-- 
2.52.0


