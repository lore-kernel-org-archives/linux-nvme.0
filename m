Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AB1FD3770
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0ie7X8G/aioYQL267xphe9M0Dn97fy0rBJ1VdwmGLSc=; b=1hY8tfALojYJ3MoPhNR+J6DA4h
	mYpfDhjryS1t07fddVVg0PbSeVxtVEJDd26fsiIYfTJNyUSVA2NGJNpGtv812cR3Cz+QaSlnWIp0i
	1AWzHXhg+dbOu3y0PMKUBMwnOnY4oWReRZkjD+4cyqMBr/bF246FlF3YI7z6CbtWOTuAqXKOmReVn
	ulQn/jBVEUnJzaN0MD8DIuXlB4BczEWBSgYTYZvoA54YBZwBhSC6yQ+awIPndHSXQ+PfIR/tgn4xB
	AP7GJIi62xDtyz37zAQNk1c+QNBnaOyyUbO+ysPqsL2nN3fqDnKqx5mDsRphOQS2kQL00D6fQKHHl
	Y9+7Puuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvHUr-00000004SnX-2eoc;
	Wed, 25 Feb 2026 16:12:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvHUp-00000004SmC-0KXY
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 16:12:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772035936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0ie7X8G/aioYQL267xphe9M0Dn97fy0rBJ1VdwmGLSc=;
	b=TwQTtJ1G/TWFKJ+wfm9H7slyU27PJFZ50BduwJ9w7gML1BPoieXHiSsac1PXYIzOLb87aK
	iOqZ4iGBaF5p8OsMGDqnjKUyumQWf7yqP7u5MTFrVlzI0AQjSTytEFBt8wsBcBzv7TbzRD
	AIMo0gqK9AP+YpaRfh0TqicRc5aDIm0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-kOUKdMH1NimkPFuuXtRElQ-1; Wed,
 25 Feb 2026 11:12:12 -0500
X-MC-Unique: kOUKdMH1NimkPFuuXtRElQ-1
X-Mimecast-MFC-AGG-ID: kOUKdMH1NimkPFuuXtRElQ_1772035931
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9A7A19560B2;
	Wed, 25 Feb 2026 16:12:10 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.217])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 886AD180066B;
	Wed, 25 Feb 2026 16:12:05 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	hare@suse.de,
	chaitanyak@nvidia.com,
	bvanassche@acm.org,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	James.Bottomley@HansenPartnership.com,
	mlombard@arkamax.eu,
	jmeneghi@redhat.com,
	emilne@redhat.com,
	bgurney@redhat.com
Subject: [PATCH V3 0/3] Ensure ordered namespace registration during async scan
Date: Wed, 25 Feb 2026 17:12:00 +0100
Message-ID: <20260225161203.76168-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: cxGeiSTpJ0F5LnZRY4OiZsC_vDXrrJanQdC8uyRpMqM_1772035931
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_081219_189180_9CDAF80A 
X-CRM114-Status: GOOD (  11.24  )
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

The NVMe fully asynchronous namespace scanning introduced in
commit 4e893ca81170 ("nvme-core: scan namespaces asynchronously")
significantly improved discovery times. However, it also introduced
non-deterministic ordering for namespace registration.

While kernel device names (/dev/nvmeXnY) are not guaranteed to be stable
across reboots, this unpredictable ordering has caused considerable user
confusion and has been perceived as a regression, leading to multiple bug
reports.

This series introduces a solution to enforce strict sequential
registration based on NSID order, entirely preserving the performance
benefits of the asynchronous scan approach.

Instead of adding an NVMe-specific hack, this series abstracts the
serialization mechanism currently open-coded in the SCSI subsystem
(drivers/scsi/scsi_scan.c) into a generic library helper called the
completion chain (compl_chain).

By enforcing a strict First-In, First-Out (FIFO) completion order for
asynchronous tasks, we can ensure that namespaces are allocated and
registered sequentially without blocking the underlying parallel discovery
processes.

PATCH 3 Refactors the existing SCSI asynchronous scanning implementation
to use the new compl_chain helper, stripping out the custom, open-coded task
list and reducing code duplication.

Original code:

$ nvme list
Node                  Generic               Namespace
--------------------- --------------------- ----------
/dev/nvme0n1          /dev/ng0n1            0x2
/dev/nvme0n2          /dev/ng0n2            0x1
/dev/nvme0n3          /dev/ng0n3            0x5
/dev/nvme0n4          /dev/ng0n4            0x3
/dev/nvme0n5          /dev/ng0n5            0x4
[...]
/dev/nvme0n10         /dev/ng0n10           0xa
/dev/nvme0n11         /dev/ng0n11           0x8
/dev/nvme0n12         /dev/ng0n12           0x12
/dev/nvme0n13         /dev/ng0n13           0x17
/dev/nvme0n14         /dev/ng0n14           0xc
/dev/nvme0n15         /dev/ng0n15           0x11
/dev/nvme0n16         /dev/ng0n16           0x14
/dev/nvme0n17         /dev/ng0n17           0x13
/dev/nvme0n18         /dev/ng0n18           0xe
/dev/nvme0n19         /dev/ng0n19           0xf


With this patch:

$ nvme list
Node                  Generic               Namespace
--------------------- --------------------- ----------
/dev/nvme0n1          /dev/ng0n1            0x1
/dev/nvme0n2          /dev/ng0n2            0x2
/dev/nvme0n3          /dev/ng0n3            0x3
/dev/nvme0n4          /dev/ng0n4            0x4
/dev/nvme0n5          /dev/ng0n5            0x5
/dev/nvme0n6          /dev/ng0n6            0x6
[...]
/dev/nvme0n10         /dev/ng0n10           0xa
/dev/nvme0n11         /dev/ng0n11           0xb
/dev/nvme0n12         /dev/ng0n12           0xc
/dev/nvme0n13         /dev/ng0n13           0xd
/dev/nvme0n14         /dev/ng0n14           0xe
/dev/nvme0n15         /dev/ng0n15           0xf
/dev/nvme0n16         /dev/ng0n16           0x10
/dev/nvme0n17         /dev/ng0n17           0x11
/dev/nvme0n18         /dev/ng0n18           0x12
/dev/nvme0n19         /dev/ng0n19           0x13

V3: fixed some comments
    PATCH 3: declare scanning_hosts as static
    remove "extern" keyword from scsi_complete_async_scans()
    prototype declaration

V2: create the compl_chain helper that both SCSI and NVMe can share

Maurizio Lombardi (3):
  lib: Introduce completion chain helper
  nvme-core: register namespaces in order during async scan
  scsi: Convert async scanning to use the completion chain helper

 drivers/nvme/host/core.c    |  94 +++++++++++++++++-----------
 drivers/nvme/host/nvme.h    |   2 +
 drivers/scsi/scsi_priv.h    |   2 +-
 drivers/scsi/scsi_scan.c    |  68 +++------------------
 include/linux/compl_chain.h |  35 +++++++++++
 lib/Makefile                |   2 +-
 lib/compl_chain.c           | 118 ++++++++++++++++++++++++++++++++++++
 7 files changed, 225 insertions(+), 96 deletions(-)
 create mode 100644 include/linux/compl_chain.h
 create mode 100644 lib/compl_chain.c

-- 
2.53.0


