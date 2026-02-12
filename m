Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9EEEB4917
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 12:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9k24dZPh7kLNujzAzXZVv9JcPfYQkpM8QJY2JVLohc4=; b=FV7CKecsdNJGEwoxsB0OfH7qKY
	PQQmUSArQ/1jTZ10rb8kYuduaesN5Rc5ELniaHlYyajEuKTGVcZN+Zv6J2bg6xyJvUnb4yt4Mrr0R
	RWMAVhctVySXp8gRDI7KqqpSJ8nzt32WZdytmtZa1RtexbaUzvqtWLKY6DAquMfXDRipvROTqdqMW
	DkkJihoz2d6I+8RaM+YAmbEy0bFEpsKU9IZYoZfaRkKZX5RJrNAFnH5dWEqpWInqkvk4lNlIAYrHp
	05ChTGRySgtCqLVHsQnFaEPUxJVJDRF/HwbkFE6Nk/z5hYJSMW67sNwX0MPI8U6GtxbUNSfg8+G3h
	PsU1oMtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqVWJ-000000023VK-2Tjj;
	Thu, 12 Feb 2026 12:10:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqVWG-000000023UR-35Tb
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 12:10:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770898202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9k24dZPh7kLNujzAzXZVv9JcPfYQkpM8QJY2JVLohc4=;
	b=IFqN1FrHXIprLuSwtx2aRdkFjG6JfLSegw8pKKGMs2JQS1HRiwjWBxloxvt6FrqdkidPhl
	NrzG+s0jRVDI23TWmT2521o3dBpyINydlX2DH2OgQFnlWRHu/b7TJ8S1mEzkvnVZMgsJd6
	lVNhhh9+O/FlhomJHJBGHrQIZy0h7uE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-llu9CW6HMa6e0ig2QhxdOA-1; Thu,
 12 Feb 2026 07:09:57 -0500
X-MC-Unique: llu9CW6HMa6e0ig2QhxdOA-1
X-Mimecast-MFC-AGG-ID: llu9CW6HMa6e0ig2QhxdOA_1770898196
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 986DB195411B;
	Thu, 12 Feb 2026 12:09:55 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D749B1956095;
	Thu, 12 Feb 2026 12:09:52 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mheyne@amazon.de,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@bsdbackstore.eu
Subject: [PATCH RFC 0/5] nvme: Refactor and expose per-controller timeout configuration
Date: Thu, 12 Feb 2026 13:09:46 +0100
Message-ID: <20260212120951.79738-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Kbzg--qIGA_3QPi9wsJf4-tlKLuT156rY_dBiwUZD2w_1770898196
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_041004_849708_8DB07481 
X-CRM114-Status: GOOD (  12.48  )
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


David Jeffery (1):
  nvme: pci: use admin queue timeout over NVME_ADMIN_TIMEOUT

Heyne, Maximilian (1):
  nvme: Let the blocklayer set timeouts for requests

Maurizio Lombardi (3):
  nvme: add sysfs attribute to change admin timeout per nvme controller
  nvme: add sysfs attribute to change IO timeout per nvme controller
  nvme: use per controller timeout waits over depending on global
    default

 drivers/nvme/host/apple.c |  4 +--
 drivers/nvme/host/core.c  | 11 ++++---
 drivers/nvme/host/nvme.h  |  3 +-
 drivers/nvme/host/pci.c   |  5 +--
 drivers/nvme/host/rdma.c  |  2 +-
 drivers/nvme/host/sysfs.c | 69 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/tcp.c   |  2 +-
 7 files changed, 84 insertions(+), 12 deletions(-)

-- 
2.53.0


