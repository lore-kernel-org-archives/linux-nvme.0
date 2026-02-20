Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500B1C55AB9
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 12:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QG36cuj8x1xlEey9KHNTKXvexo5fPhYAPvqQE/wbZRQ=; b=n2OgZQXG9fQLHgkgSeq1ML7pml
	I/GkrxNZxqmvP4F4nxPYP0hY2zn5TJoXAn+81yOxDzyurq/zGMA+zDfF1pa2CTuEwBQtxa0q+zYP7
	B58tZ/e59GuwjHV3FRSu5LpHCpkTIQnM6P+I7YRusOe3+vzxw30pty/5Cim0jarJXrynzcTRLXGFj
	iuSVzaP5HKDXzCHvJ1ynVLtphhs0SosVcr6grLkA0B+Cbh4nzmQsO54XnS8v/5PNl4NAwYgA8sslg
	wVZxcGe+eyeH6b/YaKbKKEqBPvrMl6porvS24kKZaXROUAAdUnrUqeLzwDMDBBgRdVvSJoI6eoQSL
	OQZqwMFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtPye-0000000EV8u-1evQ;
	Fri, 20 Feb 2026 12:51:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtPyb-0000000EV7S-3fdU
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 12:51:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771591879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QG36cuj8x1xlEey9KHNTKXvexo5fPhYAPvqQE/wbZRQ=;
	b=Uhtn3In+AjRouiMseknhmdCe12Kz4+ssm8+0OyVEQkY3yEAmQmt5Yn7EgM9ryOTzldnrye
	EP/C3HZV7Nf+lRal13dSYAgenRdv0sjs7+3kl9A65MwQQ8q7F7RLWlvs3gZtv4eRcMNWk6
	1u3OE6nZTThHR+7j2OxChob1uZcEwoY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395--9cMdYNVPhObuYlTKM-w4A-1; Fri,
 20 Feb 2026 07:51:15 -0500
X-MC-Unique: -9cMdYNVPhObuYlTKM-w4A-1
X-Mimecast-MFC-AGG-ID: -9cMdYNVPhObuYlTKM-w4A_1771591874
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 048961956059;
	Fri, 20 Feb 2026 12:51:14 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.45.224.125])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 511791800361;
	Fri, 20 Feb 2026 12:51:10 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mheyne@amazon.de,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@arkamax.eu,
	mkhalfella@purestorage.com
Subject: [PATCH V2 0/5] nvme: Refactor and expose per-controller timeout configuration
Date: Fri, 20 Feb 2026 13:51:03 +0100
Message-ID: <20260220125108.483250-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rRajPJq3-lZxI5xB_vv-3rMThmMgB5i4SCGnZ4GL3Vg_1771591874
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_045121_992066_E9C3EF7A 
X-CRM114-Status: GOOD (  11.91  )
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

This patchset tries to address some limitations in how the NVMe driver handles
command timeouts.
Currently, the driver relies heavily on global module parameters
(NVME_IO_TIMEOUT and NVME_ADMIN_TIMEOUT), making it difficult for users to
tune timeouts for specific controllers that may have very different
characteristics. Also, in some cases, manual changes to sysfs timeout values
are ignored by the driver logic.

For example this patchset removes the unconditional timeout assignment in
nvme_init_request. This allows the block layer to correctly apply the request
queue's timeout settings, ensuring that user-initiated changes via sysfs
are actually respected for all requests.

It introduces new sysfs attributes (admin_timeout and io_timeout) to the NVMe
controller. This allows users to configure distinct timeout requirements for
different controllers rather than relying on global module parameters.

Some examples:

Changes to the controller's io_timeout gets propagated to all
the associated namespaces' queues:

# find /sys -name 'io_timeout' 
/sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n1/queue/io_timeout
/sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n2/queue/io_timeout
/sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n3/queue/io_timeout
/sys/devices/virtual/nvme-fabrics/ctl/nvme0/io_timeout

# echo 27000 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/io_timeout
# cat /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n1/queue/io_timeout
27000
# cat /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n2/queue/io_timeout
27000
# cat /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n3/queue/io_timeout
27000

When adding a namespace target-side, the io_timeout is inherited from
the controller's preferred timeout:

* target side *
# nvmetcli
/> cd subsystems/test-nqn/namespaces/4 
/subsystems/t.../namespaces/4> enable
The Namespace has been enabled.

************

* Host-side *
nvme nvme0: rescanning namespaces.
# find /sys -name 'io_timeout' 
/sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n1/queue/io_timeout
/sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n2/queue/io_timeout
/sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n3/queue/io_timeout
/sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n4/queue/io_timeout <-- new namespace
/sys/devices/virtual/nvme-fabrics/ctl/nvme0/io_timeout

# cat /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n4/queue/io_timeout
27000
***********

io_timeout and admin_timeout module parameters are used as default
values for new controllers:

# nvme connect -t tcp -a 10.37.153.138 -s 8000 -n test-nqn2
connecting to device: nvme1

# cat /sys/devices/virtual/nvme-fabrics/ctl/nvme1/nvme1c1n1/queue/io_timeout
30000
# cat /sys/devices/virtual/nvme-fabrics/ctl/nvme1/admin_timeout
60000


V2: Drop the RFC tag
    apply the timeout settings to fabrics_q and connect_q too
    Code style fixes
    remove unnecessary check for null admin_q in __nvme_delete_io_queues()
    Use DEVICE_ATTR() macro

Heyne, Maximilian (1):
  nvme: Let the blocklayer set timeouts for requests

Maurizio Lombardi (4):
  nvme: add sysfs attribute to change admin timeout per nvme controller
  nvme: pci: use admin queue timeout over NVME_ADMIN_TIMEOUT
  nvme: add sysfs attribute to change IO timeout per nvme controller
  nvme: use per controller timeout waits over depending on global
    default


 drivers/nvme/host/apple.c |  2 +-
 drivers/nvme/host/core.c  |  9 ++---
 drivers/nvme/host/nvme.h  |  3 +-
 drivers/nvme/host/pci.c   |  5 +--
 drivers/nvme/host/rdma.c  |  2 +-
 drivers/nvme/host/sysfs.c | 74 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/tcp.c   |  2 +-
 7 files changed, 87 insertions(+), 10 deletions(-)

-- 
2.53.0


