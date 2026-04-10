Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC998E99049
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2026 07:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lC6zFHUghCMJChmo/c2WflwCoXvTelpZ8pGJh8/iGzQ=; b=w7XuD3Y7zNlYumfcIN8OZgyIaZ
	/boqGVjNCaXcLZtzV5VEubn0ij8FlCRrIErW5rUpbSv8ysIIpukj+n1/wOpz0a43p8jj7B93m9Ytn
	Zi/c06nNAX5XJRCxzsyG+7xgYP0Gq4epKFA5yclnk4RaH3eL1tsLvZntMtg2NBQVzzGTO7Rlr2JF1
	EbjT3Avpl6qhvvstnjobDrdDoWScw4bZ+zkK+QjVNwht9HdeokNBGECLoIhwwqOxcJwkWo6G6q/h1
	Mue81XgrhvNw+u7A6TtVOgWU5HU5QPlLfqGWGMot5ihvb7KzHllmZJWE5g/5m+BKwT8D1ivKFSIgk
	cYXMPdjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6Sw-0000000Bkzk-11Mv;
	Fri, 10 Apr 2026 07:39:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6Sr-0000000BkxH-0nZH
	for linux-nvme@lists.infradead.org;
	Fri, 10 Apr 2026 07:39:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775806778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lC6zFHUghCMJChmo/c2WflwCoXvTelpZ8pGJh8/iGzQ=;
	b=fKBP9oPWXxkFw0aG/i46e7YAKDQWWhsWrVLHmGf0wcC76GFEyrAEG+vT+xNQ17cg9lN0Od
	iJutRUdqerT3GRJ3YTBtnOxijAhAn1rUKn0rBm/qZAjsBNGMAynS7El28HXv5syYUYek9t
	iOe46p4abJlwu+WUvnFs4xvi4YUuke0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-Vdza8OhwNFGedNCE3lRcfg-1; Fri,
 10 Apr 2026 03:39:33 -0400
X-MC-Unique: Vdza8OhwNFGedNCE3lRcfg-1
X-Mimecast-MFC-AGG-ID: Vdza8OhwNFGedNCE3lRcfg_1775806771
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8010180057E;
	Fri, 10 Apr 2026 07:39:30 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.170])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7AD9818002A6;
	Fri, 10 Apr 2026 07:39:26 +0000 (UTC)
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
Subject: [PATCH V3 0/8] nvme: Refactor and expose per-controller timeout configuration
Date: Fri, 10 Apr 2026 09:39:16 +0200
Message-ID: <20260410073924.61078-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ALhuHJlU_kRyPVJjM9Nwdh0VqVZz32I31ThReAzgiCg_1775806771
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_003941_302250_7C13D182 
X-CRM114-Status: GOOD (  15.21  )
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

Heyne, Maximilian (1):
  nvme: Let the blocklayer set timeouts for requests

Maurizio Lombardi (7):
  nvme: add sysfs attribute to change admin timeout per nvme controller
  nvme: pci: use admin queue timeout over NVME_ADMIN_TIMEOUT
  nvme: add sysfs attribute to change IO timeout per nvme controller
  nvme: use per controller timeout waits over depending on global
    default
  nvme-core: align fabrics_q teardown with admin_q in nvme_free_ctrl
  nvmet-loop: do not alloc admin tag set during reset
  nvme-core: warn on allocating admin tag set with existing queue

 drivers/nvme/host/apple.c  |  2 +-
 drivers/nvme/host/core.c   | 23 +++++-----
 drivers/nvme/host/nvme.h   |  4 +-
 drivers/nvme/host/pci.c    |  4 +-
 drivers/nvme/host/rdma.c   |  2 +-
 drivers/nvme/host/sysfs.c  | 89 ++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/tcp.c    |  2 +-
 drivers/nvme/target/loop.c | 38 ++++++++--------
 8 files changed, 128 insertions(+), 36 deletions(-)

-- 
2.53.0


