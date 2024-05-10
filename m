Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212EAC25B5F
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 16:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6kDYWX0th0RD1o9d0n3rqHmvv+XtVaaePGzPaB7aOhg=; b=xPIRTpQU1sF3PehX6Tj5Fyx1ev
	npYx6Wt5mo3GqQttMN/cQSxOlAhyfcSGXq4tRxAn/x3JhwvXGP0VB43URSzAZlKjx0lfr2rbEjuzI
	eR/bA7ASUZfYqUL860h10n/aXvvIPxmG3fdTBBd/ZJIZSIDed6v9VsJfWdW1ow3Fxy9DRUKPBTzUg
	2Qi7yGPbpjKpmy2ValcUpS6fsECB1TRVW44vgc8M+CCsD/uDrJ2i3iQwwWMwZ+x6+PFcPg20DqX6k
	0Q1EJTryQQfrCCiY3+oA/rqMxGSUamsbw5Iyshqx6fLovxJhZqBkbWF0LPOEFguImQbMZlVGm/e5Y
	6P8NAisg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5T8s-00000005s2s-3SKr;
	Fri, 10 May 2024 16:30:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5T8o-00000005s0c-1M9e
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 16:30:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715358633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6kDYWX0th0RD1o9d0n3rqHmvv+XtVaaePGzPaB7aOhg=;
	b=RyA59EwgLUI6vWhah9bYRnwt221YCmaOjZaNj4fsxajf5wSpQyllyLocvi73lZ8ubcu5/A
	imZ6KleANH32D4FT9zl1OcNx2XEXYkqv25pQDpMJPhNPAK/7trGZXEfmRvn2WlCqnsSmDs
	mcJ7CO/posOXNQHVo2D2CbVJcxVhPd0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-hFIRY4eSPlCC2r1ke1cg6w-1; Fri, 10 May 2024 12:30:29 -0400
X-MC-Unique: hFIRY4eSPlCC2r1ke1cg6w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56AA880027F;
	Fri, 10 May 2024 16:30:29 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.42.28.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 36F2C207CDF0;
	Fri, 10 May 2024 16:30:27 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@meta.com
Cc: hare@kernel.org,
	sagi@grimberg.me,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH 0/5] Support for Cancel commands for host (TCP and RDMA)
Date: Fri, 10 May 2024 18:30:21 +0200
Message-Id: <20240510163026.786898-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_093038_468654_F387460E 
X-CRM114-Status: GOOD (  13.85  )
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

The nvme host driver could take advantage of Cancel (defined by TP 4097a)
to abort a command that timed out instead of resetting the controller.

The abort command's implementation is mandated by the specs but
the target isn't really required to perform any meaningful work
(as it happens, for example, with the Linux nvmet implementation, where the
abort command does nothing at all).
On the other hand, the Cancel command is optional, therefore if the target
claims to support it, it's reasonable to expect its implementation to
perform something useful.

This patchset modifies the tcp and rdma host drivers' timeout
handlers to check if the target supports the Cancel command; if yes,
it will use it to try to abort the command that timed out.
If Cancel isn't supported or if the abort operation fails,
the host will perform a controller reset.

Tests were carried out both against a modified nvmet driver
(see PATCH 5) and against real hardware devices.

example of output in dmesg:
nvme nvme4: I/O tag 73 (4049) type 4 opcode 0x1 (Write) QID 8 timeout
nvme nvme4: Cancel status: 0x0 imm abrts = 0 def abrts = 1


John Meneghini (1):
  nvme: add definitions for cancel command

Maurizio Lombardi (4):
  nvme-core: add a function to submit a cancel command
  nvme-tcp: use the cancel command to perform an abort if target
    supports it
  nvme-rdma: use the cancel command to perform an abort if target
    supports it
  nvmet: target support for cancel commands

 drivers/nvme/host/constants.c       |  1 +
 drivers/nvme/host/core.c            | 55 ++++++++++++++++++++
 drivers/nvme/host/nvme.h            |  2 +
 drivers/nvme/host/rdma.c            | 28 ++++++++--
 drivers/nvme/host/tcp.c             | 19 +++++++
 drivers/nvme/target/Makefile        |  2 +-
 drivers/nvme/target/admin-cmd.c     | 36 +++++++++++++
 drivers/nvme/target/core.c          | 45 ++++++++++++++++
 drivers/nvme/target/io-cmd-cancel.c | 81 +++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-file.c   | 19 +++++++
 drivers/nvme/target/nvmet.h         | 10 ++++
 include/linux/nvme.h                | 19 +++++++
 12 files changed, 312 insertions(+), 5 deletions(-)
 create mode 100644 drivers/nvme/target/io-cmd-cancel.c

-- 
2.39.3


