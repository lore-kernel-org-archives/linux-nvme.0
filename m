Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A28C3600C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 10:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ch5Vz5NpYZ3Tfh9gOPod0y0qTN3o8eVB4CPJpEfTyEk=; b=gXaFy3QzPzZ8dDYNYJD4m16FxU
	ZD+l/OCVqi8oiZb7zD4PUckvnrJ+VHS/BOmr6japgAdhdjDpXzcHSHCxq82jRIOkk4ZfQTvXbvSr3
	pHg6lJtIN18Mg1o8OBq+2IHoJWWjI5pkKlRsyOa+91Uluzk466YZjyi/YEvoyBez7jn5ZWmv6Yhi8
	FG4rrYAvw+vaOmugJcydt9yNXfAOZkSIQrqtKLBNtcs9gGMwDfOmTvEZd3Eqg0cy+BZSL8Oj1B5OG
	nP9U52lh3RlIsrbjYhWbw7O4DPl9s+2D8TK5k0DpbdFZDZwAFsbtuEyR45NCWg32g9TQzzgl/611O
	ZwGV1pQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tweys-00000002oMV-3dZR;
	Mon, 24 Mar 2025 10:24:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twexm-00000002o6Y-2dHr
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 10:23:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742811800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ch5Vz5NpYZ3Tfh9gOPod0y0qTN3o8eVB4CPJpEfTyEk=;
	b=EeFpvobstn5Vmx6/KQdWY0dye+zT237zPTOLkMCxmvBqyMrzp0zACpjJOjwJSXVUy31S5z
	ur4DW17xW2ZJX5o6x/RUSxiVeYKPFOkteM2Sxd4hpc6giKSR3rI2I2iZGMpsgg1LSG4tOZ
	74Gq6503u8y2ZZmLGQyoJN2sofvbdB0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-khUWgiDbPRSI-WU66jIIkA-1; Mon,
 24 Mar 2025 06:23:16 -0400
X-MC-Unique: khUWgiDbPRSI-WU66jIIkA-1
X-Mimecast-MFC-AGG-ID: khUWgiDbPRSI-WU66jIIkA_1742811795
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5B361956070;
	Mon, 24 Mar 2025 10:23:15 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70F02180A803;
	Mon, 24 Mar 2025 10:23:12 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	jmeneghi@redhat.com,
	hare@suse.de,
	cleech@redhat.com
Subject: [PATCH RFC v3 00/11] Support for cancel command (TP4097a)
Date: Mon, 24 Mar 2025 11:22:59 +0100
Message-ID: <20250324102310.658007-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DHy8lPyE6UfSw-LmD5s8UIUEBUIDprI12QCCsTdeHsw_1742811795
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_032322_741755_70538DB0 
X-CRM114-Status: GOOD (  21.25  )
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

This patchset adds support for the cancel commands

The nvme host driver could take advantage of Cancel (defined by TP 4097a)
to abort a command that timed out instead of resetting the controller.

The abort command's implementation is mandated by the specs but
the target isn't necessarily required to perform any meaningful action
(as it happens, for example, with the Linux nvmet implementation, where the
abort command does nothing at all).
On the other hand, the Cancel command is optional, therefore if the target
claims to support it, it's reasonable to expect its implementation to
perform a useful action.

This patchset modifies the tcp and rdma host drivers' timeout
handlers to check if the target supports the Cancel command; if it does,
it will use it to try to abort the command that timed out.
If multiple commands time out at the same time, the driver will use a
Cancel command with the 'multiple commands' flag to attempt to
abort all stuck commands as a last attempt to avoid a controller reset.

If Cancel isn't supported, if the allocation of the command fails,
or if any failure is encountered, the driver will fall back
to the standard controller reset mechanism.

Example of dmesg output:

nvme nvme0: I/O tag 3 (3003) type 4 opcode 0x1 (I/O Cmd) QID 5 timeout
nvme nvme0: I/O tag 4 (2004) type 4 opcode 0x1 (I/O Cmd) QID 5 timeout
nvme nvme0: I/O tag 5 (4005) type 4 opcode 0x1 (I/O Cmd) QID 5 timeout
nvme nvme0: Cancel status: 0x0 imm abrts = 1 def abrts = 0
nvme nvme0: I/O tag 6 (5006) type 4 opcode 0x1 (I/O Cmd) QID 5 timeout
nvme nvme0: Cancel status: 0x0 imm abrts = 63 def abrts = 0
nvme nvme0: I/O tag 3 (9003) type 4 opcode 0x1 (I/O Cmd) QID 6 timeout
nvme nvme0: I/O tag 4 (a004) type 4 opcode 0x1 (I/O Cmd) QID 6 timeout
nvme nvme0: I/O tag 5 (a005) type 4 opcode 0x1 (I/O Cmd) QID 6 timeout
nvme nvme0: Cancel status: 0x0 imm abrts = 1 def abrts = 0
nvme nvme0: I/O tag 73 (7049) type 4 opcode 0x1 (I/O Cmd) QID 6 timeout
nvme nvme0: Cancel status: 0x0 imm abrts = 5 def abrts = 0


This also adds a target side Cancel implementation written by Chris Leech,
intended for testing. It adds a new Kconfig option
CONFIG_NVME_TARGET_DELAY_REQUESTS which depends on debugfs.
When this config option is enabled, a delay attribute is added under
the kernel/debug/nvmet/test-nqn/ctrl1/ directory.
When a controller is created, it will read as "0 0"
$ cat delay    
0 0    

The first number is a count of how many requests will be delayed.
The second is a delay time in ms.

V3: In the host driver, instead of counting outstanding Cancel
    commands using atomic_inc()/atomic_dec(), use two flags
    in the queue structure. (Suggested by Sagi Grimberg).
    Added a target side implementation.

V2: Reserve 2 commands per queue for cancel commands (the number is fixed
but in future it can be made configurable with trivial changes to the code).


Chris Leech (5):
  nvmet: put all nvmet_req.execute calls behind a function name
  nvmet: add delay debugfs file to nvmet_ctrl
  nvmet: delay requests
  nvmet: command tracking
  nvmet: cancel implementation

Maurizio Lombardi (6):
  nvme: add definitions for cancel command
  nvme-core: reserve tags for cancel commands
  nvme-core: add a function to submit a cancel command
  nvme-tcp: use the cancel command to perform an abort if target
    supports it
  nvme-rdma: use the cancel command to perform an abort if target
    supports it
  nvmet: emulate basic support for cancel commands

 drivers/nvme/host/constants.c       |  1 +
 drivers/nvme/host/core.c            | 83 ++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h            |  4 ++
 drivers/nvme/host/rdma.c            | 50 +++++++++++++++--
 drivers/nvme/host/tcp.c             | 62 +++++++++++++++++++--
 drivers/nvme/target/Kconfig         |  9 ++++
 drivers/nvme/target/Makefile        |  1 +
 drivers/nvme/target/admin-cmd.c     |  3 ++
 drivers/nvme/target/core.c          | 67 ++++++++++++++++++++++-
 drivers/nvme/target/debugfs.c       | 40 ++++++++++++++
 drivers/nvme/target/fc.c            |  4 +-
 drivers/nvme/target/io-cmd-cancel.c | 77 ++++++++++++++++++++++++++
 drivers/nvme/target/loop.c          |  2 +-
 drivers/nvme/target/nvmet.h         | 19 +++++++
 drivers/nvme/target/rdma.c          |  4 +-
 drivers/nvme/target/tcp.c           |  4 +-
 include/linux/nvme.h                | 22 ++++++++
 17 files changed, 434 insertions(+), 18 deletions(-)
 create mode 100644 drivers/nvme/target/io-cmd-cancel.c

-- 
2.43.5


