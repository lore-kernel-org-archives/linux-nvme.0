Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D9DFA3758
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 13:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=roUJtJtso2mLh8G9fdhTqEr/oU1GAa6f/R7BiTPSOt0=; b=DMbwbPWc4TlxcFq6GC4/Gj3XE7
	WDqJp8TQbZAZJqALuOAogGisg0y2jqz+vYmXg7hlsbDDAiHbgWtaZ/3KkTTiJMp87V2vg87z+V20Q
	S4ck64j9QRKSPFVzdkpkAEGpfXwSW2S/7Zbr21dZ5OmlfoI49jxrHNhB+EwMFWsQI+Hy3rZS8PikH
	o84a0cAsm7Obdk4Qhe6Uf3PLEE2qzyttj3DwGkuTJ478U3SmM8/WdgWHx02Htj9CH65pkWulZ9SEC
	naq4NS9qHRl/7sWQ4iB0iYiqRsLet4IMQFEEM3arWI6V0mbKHteQLASh8GSog6I3VMoIf6DdkkWgW
	Gp68c4uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6bi-0000000G4Zo-1uCZ;
	Fri, 13 Sep 2024 13:45:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp6bK-0000000G4Th-2Eiv
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 13:44:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726235081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=roUJtJtso2mLh8G9fdhTqEr/oU1GAa6f/R7BiTPSOt0=;
	b=KcgDdzx+H7KeJ4xhKtiMJbKxCILK4yuE4VcX8wGQbt9p1JxGkaM/RlVSfs43uIMYtfyA0+
	RKqgz2z21vkgs/naNEce5mloliRklLI1MVppbwcLklRWRIp3XMmSbVqulhqnFYEybj6jiH
	qyEez4ELwybTLnS/biDANBMuFPqvbgo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-N9tcSbauMwGXZbFnevPrLw-1; Fri,
 13 Sep 2024 09:44:38 -0400
X-MC-Unique: N9tcSbauMwGXZbFnevPrLw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DD621955BD2;
	Fri, 13 Sep 2024 13:44:36 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.65.135])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 19DEB30001AB;
	Fri, 13 Sep 2024 13:44:33 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: Keith Busch <kbusch@kernel.org>,
	ens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	David Jeffery <djeffery@redhat.com>
Subject: [PATCH 0/4] cleaning up nvme timeout over-dependence on global values
Date: Fri, 13 Sep 2024 09:44:26 -0400
Message-ID: <20240913134430.5416-1-djeffery@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_064442_670025_14C87A4B 
X-CRM114-Status: GOOD (  11.23  )
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

With nvme timeout handling, the global configuration options behind
NVME_IO_TIMEOUT and NVME_ADMIN_TIMEOUT are broadly used in nvme timeout
behavior.

This can become quite a problem with systems using mixed nvme transports.
The timeoue values needed with local PCI devices may be very different from
what is needed over tcp or other fabric transports. The intention of this
patch series is to limit the NVME_IO_TIMEOUT and NVME_ADMIN_TIMEOUT values
to providing only an initial timeout value which can then be overridden and
configured separately per device. Thus, each device can have a timeout
value configured to match its characteristics.

David Jeffery (4):
  nvme: use queue's configured timeout not global config value for
    passthru
  nvme: add sysfs attribute to change admin timeout per nvme dev
  nvme: pci: use admin queue timeout over NVME_ADMIN_TIMEOUT
  nvme: use per device timeout waits over depending on global default
    value

 drivers/nvme/host/apple.c |  2 +-
 drivers/nvme/host/core.c  | 12 +++++++++---
 drivers/nvme/host/nvme.h  |  2 +-
 drivers/nvme/host/pci.c   |  5 +++--
 drivers/nvme/host/rdma.c  |  2 +-
 drivers/nvme/host/sysfs.c | 31 +++++++++++++++++++++++++++++++
 drivers/nvme/host/tcp.c   |  2 +-
 7 files changed, 47 insertions(+), 9 deletions(-)

-- 
2.46.0


