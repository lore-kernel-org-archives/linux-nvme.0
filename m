Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7CECD4F25
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2026 08:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SUlBJkZorrVlyBEnUFyiBLceuWljHKXaSYIB4Y7Y2NY=; b=bRU5mHj+9/ke1GrXgojvPOdIDo
	iT1HK0gbOLgkXtVYfEHXrk0dM2lEjjx617hlqr9AYwiijlq09o2211vw/DAqpKudj0tuS67FuWcn3
	vIOBFr+DT43Y+Sb8LPQB9fowwOJBKpnjUGkE8SIigVdZrlDJIXcw5iaEh7yIZjUUc6XPgKc73eUVu
	Kyuk1fr9H95gxGoJkzGkk07ZuyCt+WRAdKOunYBse5e3IMLkNjDJuLEQfCY/biyvuDKGYD8bzXVLY
	pd1ssG3t3AhhP3ianLY9ssR8+lgOm+aKL+BU3e3VP0l1WTvPeY1tePRkrtNqf2QR+sEibw3DTp8L6
	2HZSTPxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNRVI-00000004wuI-3jew;
	Thu, 14 May 2026 08:33:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNRVF-00000004wsy-2dw2
	for linux-nvme@lists.infradead.org;
	Thu, 14 May 2026 08:33:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778747587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SUlBJkZorrVlyBEnUFyiBLceuWljHKXaSYIB4Y7Y2NY=;
	b=ecR1SDxyLKUj3BhSP6fx1Q+eaozjyKeonrZ/9i8+Sg5WWls04c5ytlZTmbllaYNeEF6Fee
	MmYG+D6kWuuAGS/bLOYcG0cRtvbFhZzrzOMLvSIK0X5ARd+UZcFQ98B6rfSIKXMG8wJfMY
	fJ9+HHLUHe/r5C4SAI1WWFAc9Fng8Cw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-b61hKrQIO9Kn9MGEeUhpQg-1; Thu,
 14 May 2026 04:33:03 -0400
X-MC-Unique: b61hKrQIO9Kn9MGEeUhpQg-1
X-Mimecast-MFC-AGG-ID: b61hKrQIO9Kn9MGEeUhpQg_1778747581
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 290C419560AA;
	Thu, 14 May 2026 08:33:01 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.48.89])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2500C1955F22;
	Thu, 14 May 2026 08:32:56 +0000 (UTC)
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
Subject: [PATCH V5 0/7] nvme: Refactor and expose per-controller timeout configuration
Date: Thu, 14 May 2026 10:32:48 +0200
Message-ID: <20260514083255.41109-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KyH9IW-FNh_Iit6Ri5u1q9uG2vjK1-5iv5MA7TB7RNs_1778747581
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_013309_744374_09B45921 
X-CRM114-Status: GOOD (  19.76  )
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

V5: - A few cosmethical changes (80-char lines etc.)
    - Move the ex patch 6 ("nvme: use per controller timeout waits")
      earlier in the serie, change it to just dropping the timeout parameter.
    - ex patch 4 ("nvme: pci: use admin queue timeout")
      eliminated, its nvme-pci changes are now part of patch 3
    - ex patch 3 ("nvme: fix race condition between connected uevent")
      has been already merged in linux-nvme tree.
    - patch 7: change it to use "if (ctrl->fabrics_q)" instead of 
      "if (ctrl->ops->flags & NVME_F_FABRICS)" where it makes sense.
    - In the commit messages of patch 3 and patch 4, I clarify that changing the timeouts
      of fabrics_q and connect_q queues is intended.

V4: - Refactor the nvmet-loop patch as suggested by Daniel Wagner
    - Add a patch to fix a potential race condition between
      connected uevent and STARTED_ONCE controller's flag.

V3: - Rebase on top of nvme 7.1 branch
    - add an admin_timeout variable to nvme_ctrl structure
    - Wait until the controller has reached the LIVE state
      for the first time before allowing the user to modify
      the timeouts, this prevents the dereferencing of the admin_q,
      fabrics_q and connect_q queues before their initialization.
    - move blk_put_queue(fabrics_q) to nvme_free_ctrl() to align it to
      admin_q teardown
    - modify nvmet-loop to avoid deleting and re-creating the admin_q queue
      when the controller enters the resetting state.
    - add a warning if nvme_alloc_admin_tag_set() is called twice against
      the same controller

V2: - Drop the RFC tag
    - apply the timeout settings to fabrics_q and connect_q too
    - Code style fixes
    - remove unnecessary check for null admin_q in __nvme_delete_io_queues()
    - Use DEVICE_ATTR() macro


Maurizio Lombardi (6):
  nvme: remove redundant timeout argument from nvme_wait_freeze_timeout
  nvme: add sysfs attribute to change admin timeout per nvme controller
  nvme: add sysfs attribute to change IO timeout per controller
  nvme-core: align fabrics_q teardown with admin_q in nvme_free_ctrl
  nvmet-loop: do not alloc admin tag set during reset
  nvme-core: warn on allocating admin tag set with existing queue

Maximilian Heyne (1):
  nvme: Let the blocklayer set timeouts for requests

 drivers/nvme/host/apple.c  |  2 +-
 drivers/nvme/host/core.c   | 21 ++++-----
 drivers/nvme/host/nvme.h   |  4 +-
 drivers/nvme/host/pci.c    |  4 +-
 drivers/nvme/host/rdma.c   |  2 +-
 drivers/nvme/host/sysfs.c  | 88 ++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/tcp.c    |  2 +-
 drivers/nvme/target/loop.c | 31 +++++++-------
 8 files changed, 121 insertions(+), 33 deletions(-)

-- 
2.54.0


