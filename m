Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FEAEE645E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 08:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1YpJpCH8bc+cAKdVOtjme/mDv1Zs9iVH2fA0rJOkqbM=; b=B2zCqQSkSGMc3s9rwEqlJbNYX2
	HAV7pKlj1xOtv69M6/0VLSvQp66pn8a3xgKUc7DjbvYB8LsPkg7/Ji2kZQ3k5mDbRUXYcngcSISU3
	IJjWyNacI3Y3ZKHdpuOdcaTTVmIaUsV1y8SXCWVxLcDUAVa3oFI3roEONc9WMkGQJx3gQG4COESbr
	jpx7s+bINSgkkvs6yrOIX5e2POlOUD+Z8BYQZ0ZzMpQ0j10tbgR7SaTw5ElUVG3NgM66He3K+WVD0
	FJl7c/DADXPd81z3zpk2Xxqluk22v2l+cQlQoHf4XrNBv7YLua6PiBOMPceKc+jJgdBmHppixAm2T
	4QwjWHXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sof1N-0000000CKt1-36el;
	Thu, 12 Sep 2024 08:17:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sof0V-0000000CKk7-3OWM
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 08:16:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726129011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1YpJpCH8bc+cAKdVOtjme/mDv1Zs9iVH2fA0rJOkqbM=;
	b=dEYN5qiJuC2fY29TVej55uZKYHkgZykr8Xz9+Gpl0f+LSIsqgkIfAISWSC7Gw8fKv72zBs
	xhpQUdFTZZy/o2jUAIdnoGAY9rcYPL98c66IazsYVZaPIR6JcqbPhE+A1trxApDMOk7vmL
	oBZ1YSMtsSl9aool0TV9ffNk+g7zT9Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-qq1jqkX4MjO4cDl0bU_9-w-1; Thu,
 12 Sep 2024 04:15:16 -0400
X-MC-Unique: qq1jqkX4MjO4cDl0bU_9-w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 945731953943;
	Thu, 12 Sep 2024 08:15:14 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.45.224.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8F9119560AA;
	Thu, 12 Sep 2024 08:15:11 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@meta.com
Cc: hare@kernel.org,
	sagi@grimberg.me,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH RFC V2 0/7] Support for Cancel commands for host (TCP and RDMA)
Date: Thu, 12 Sep 2024 10:15:03 +0200
Message-ID: <20240912081510.171857-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_011651_943499_5210D146 
X-CRM114-Status: GOOD (  17.82  )
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
the target isn't necessarily required to perform any meaningful action
(as it happens, for example, with the Linux nvmet implementation, where the
abort command does nothing at all).
On the other hand, the Cancel command is optional, therefore if the target
claims to support it, it's reasonable to expect its implementation to
perform something useful.

This patchset modifies the tcp and rdma host drivers' timeout
handlers to check if the target supports the Cancel command; if so,
it will use it to try to abort the command that timed out.
If the number of reserved commands runs low, use the "multiple
commands" action to abort all the commands on the specificied queue
as a last resort to avoid a controller reset.

If Cancel isn't supported, if the allocation of the command fails, or
if the pool of reserved commands is completely exhausted,
the host will fall back to the normal controller reset.

example of output in dmesg where a command gets canceled and
the target performed 1 immediate abort:
nvme nvme7: I/O tag 105 (1069) type 4 opcode 0x1 (I/O Cmd) QID 13 timeout
nvme nvme7: Cancel status: 0x0 imm abrts = 1 def abrts = 0

Patch 7 is a modified nvmet drivers with a module parameter that enables
an extremely basic emulation of cancel command (it does nothing, it just
reports that no aborts were executed). it could be useful for
testing Cancel with blktests.

V2: Reserve 2 commands per queue for cancel commands (the number is fixed
but in future it can be made configurable with trivial changes to the code).

John Meneghini (1):
  nvme: add definitions for cancel command

Maurizio Lombardi (6):
  nvme-core: function to check if a controller supports a specific I/O
    cmd
  nvme-core: reserve tags for cancel commands
  nvme-core: add a function to submit a cancel command
  nvme-tcp: use the cancel command to perform an abort if target
    supports it
  nvme-rdma: use the cancel command to perform an abort if target
    supports it
  nvmet: emulate basic support for cancel commands

 drivers/nvme/host/constants.c       |  1 +
 drivers/nvme/host/core.c            | 77 ++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h            |  3 ++
 drivers/nvme/host/rdma.c            | 43 ++++++++++++++--
 drivers/nvme/host/tcp.c             | 58 ++++++++++++++++++++--
 drivers/nvme/target/Makefile        |  2 +-
 drivers/nvme/target/admin-cmd.c     |  4 ++
 drivers/nvme/target/core.c          | 11 +++++
 drivers/nvme/target/io-cmd-cancel.c | 52 +++++++++++++++++++
 drivers/nvme/target/nvmet.h         |  4 ++
 include/linux/nvme.h                | 22 +++++++++
 11 files changed, 266 insertions(+), 11 deletions(-)
 create mode 100644 drivers/nvme/target/io-cmd-cancel.c

-- 
2.43.5


