Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C89C05027
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 14:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=O2XPsXOkZmjvnYjEr9p+iVSdn6gc2Kjmaiy08tjDdw0=; b=sazwtBr5wRyjdL1i4+5aKK23jc
	aX6uS5ivCCGHMP2y5T4lTDrNJ3svjhI7So6ufiOkSdBw57NT2bVaIvFJ3O+UcwDTUypSSNJtpjki5
	VXCk15cGSBS8W2HAupagZwgf8tu9lOE2Ket8riT93BOFktRA87eLMnF9TNfjGSmtDD/hhOdc2ewlM
	gPnnUMzXo2qA/nxuDP7o0MzNM7fzk9QqMCLve9luhYYSah0aootDPEvDx9ptdhgogMiP/RB6JMmCP
	ubpFeTcJEmLdMNf180WMjhOPONGp/OqSvW21Xm45ADdOmTgngE//WO2EtWxXAMKqFqI1uVF4P8hT7
	c8Tl4MRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ84M-0020k3-4r; Thu, 09 Feb 2023 14:38:38 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ84F-0020eu-9R
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 14:38:33 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id C4C79375CE;
	Thu,  9 Feb 2023 14:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675953509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=O2XPsXOkZmjvnYjEr9p+iVSdn6gc2Kjmaiy08tjDdw0=;
	b=i45DbWYhrh8FaftLRsoQW2cBY7wmTHw5eH/ccAVuyJ1Nmzvk83PYhFXl+xoTSc9PMVhsUX
	CkdhUWah5D7ao8YNnf29bn7pLKzIL+KLXc0LlEE8xSnGLg/17w3Y+1ug8foLdU8EXPk7lr
	WhxSSELSdkiqknMYIpjMn43/bjiIXUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675953509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=O2XPsXOkZmjvnYjEr9p+iVSdn6gc2Kjmaiy08tjDdw0=;
	b=60q6P6/3mC7MLM1mjVcCneMw5ZEu9rW+Gd5VNvEDfuZnV2lpOjTiDL5GYT6SgVycR+p5rD
	wVqeDGdUYU5j5FBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id AE2D22C145;
	Thu,  9 Feb 2023 14:38:29 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 8F28D51BD136; Thu,  9 Feb 2023 15:38:29 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/5] nvme: rework __nvme_submit_sync_cmd()
Date: Thu,  9 Feb 2023 15:38:15 +0100
Message-Id: <20230209143820.118097-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_063831_528878_C0F7DE4B 
X-CRM114-Status: GOOD (  13.06  )
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

Hi all,

as Jens and hch complained about the argument list to __nvme_submit_sync_cmd()
getting too long, here's now a patchset to clean things up.
The first patch is to split off nvme_alloc_request() from
__nvme_submit_sync_cmd(), which serves to reduce the number of arguments;
it's also a nice cleanup as this function can be utilized to replace some
open-coded versions.
Then a patch to allow blk_rq_map_kern() to accept a NULL pointer; that's
really trivial and simplifies caller handling.
The third one again is pretty simple, and moves the 'result' handling into
nvme_execute_rq(), rather than leave it with the caller.
And with that we can open-code __nvme_submit_sync_cmd() in the callers,
and drop the function altogether.
The last patch to allow for retries of the authentication commands is
then pretty simple.

As usual, comments and reviews are welcome.

Hannes Reinecke (5):
  nvme: split __nvme_submit_sync_cmd()
  block: make blk_rq_map_kern() to accept a NULL buffer
  nvme: move result handling into nvme_execute_rq()
  nvme: open-code __nvme_submit_sync_cmd()
  nvme: retry authentication commands if DNR status bit is not set

 block/blk-map.c                |  2 +-
 drivers/block/pktcdvd.c        | 10 ++--
 drivers/nvme/host/auth.c       | 31 ++++++++---
 drivers/nvme/host/core.c       | 96 +++++++++++++++++++++-------------
 drivers/nvme/host/fabrics.c    | 62 +++++++++++++++++-----
 drivers/nvme/host/ioctl.c      |  5 +-
 drivers/nvme/host/nvme.h       |  9 ++--
 drivers/nvme/host/pci.c        |  8 ++-
 drivers/nvme/target/passthru.c |  6 +--
 drivers/scsi/scsi_ioctl.c      |  8 ++-
 drivers/scsi/scsi_lib.c        | 11 ++--
 11 files changed, 155 insertions(+), 93 deletions(-)

-- 
2.35.3


