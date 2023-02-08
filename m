Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15979C05027
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 08:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EZjhymGVGHyVsB8ngo0oW8Za7Zik1Om+k9DFYHicdXM=; b=SdRrCXzKWyhzLgCPsswXWlXD25
	wCz+kB2wHIC+OKry1huWm3SYaJltlPKiYATgu6Lt+efx8m4IMHTAdo1Si2KzE3GRZal/6XuTdeKGE
	IhWInUDlMY+GOrdLL/GWTSQzYmrh0yJCBttsmHOtR++dS3oZNSwjX0PYoRqeKLw/50GXHyHxwlarQ
	dq7V6i416zqNWoPtVZlhDvIzbbpgoUDGBAkzvJY2v32klEDMhBOS61Jqo4ZA3MOPFcbmJVp28WS/R
	l3TpvkB9KlwJDxg/woS6hIqz1cTutHtNHUOruOWEOVNgEiP53jXM3KIWzJRW7JHCEQ8bqJObtbVoE
	8UL+kIHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPg9N-00Ee65-7O; Wed, 08 Feb 2023 08:49:57 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPg9K-00Ee47-M3
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 08:49:56 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 0906D208A5;
	Wed,  8 Feb 2023 08:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675846190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EZjhymGVGHyVsB8ngo0oW8Za7Zik1Om+k9DFYHicdXM=;
	b=Puy71wYvRUeQg7PSR3rH2D/Dk4qfwf4x8pJgEiHc+uueBjK21b5K/i0r7fcI2N7tEEcxgq
	qgrBf7T0skUo5FNrD9mjA9d0GrnrFCGyv1L50BPeqkr/FFHEdggIysh4NQ4z3J3Rja1vYo
	YU+zXXv4nzzcBMk/fDk5hppq27Nvkso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675846190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EZjhymGVGHyVsB8ngo0oW8Za7Zik1Om+k9DFYHicdXM=;
	b=uRWAi150OWfHWodtJ48+5SH6pCLkNSOWgpRDdTgTiqn7xuDJ8SlweBkIIwjlL2jZLPAqIq
	K/ZZcgvn8/q+KiAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D81752C143;
	Wed,  8 Feb 2023 08:49:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id C380451BD068; Wed,  8 Feb 2023 09:49:49 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/3] nvme: rework __nvme_submit_sync_cmd()
Date: Wed,  8 Feb 2023 09:49:36 +0100
Message-Id: <20230208084939.145257-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_004954_879709_8EF35170 
X-CRM114-Status: GOOD (  12.32  )
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
The first patch is to split off __nvme_alloc_rq() from __nvme_submit_sync_cmd(),
which serves to reduce the number of arguments; it's also a nice cleanup as this
function can be utilized to replace some open-coded versions.
The second patch is to introduce a 'retry' argument to __nvme_alloc_rq(), to
indicate whether retries for this command should be allowd.
And the third is another cleanup; the 'at_head' argument to __nvme_submit_sync_cmd()
really should be a boolean, as it can take only two values, and it's being
converted into a boolean within __nvme_submit_sync_cmd() anyway.

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  nvme: split __nvme_submit_sync_cmd()
  nvme: retry internal commands if DNR status bit is not set
  nvme: make 'at_head' parameter for __nvme_submit_sync_cmd() boolean

 drivers/nvme/host/auth.c       | 10 ++++--
 drivers/nvme/host/core.c       | 65 ++++++++++++++++++++++------------
 drivers/nvme/host/fabrics.c    | 46 +++++++++++++++++-------
 drivers/nvme/host/ioctl.c      |  2 +-
 drivers/nvme/host/nvme.h       | 11 +++---
 drivers/nvme/host/pci.c        |  9 +++--
 drivers/nvme/target/passthru.c |  3 +-
 7 files changed, 96 insertions(+), 50 deletions(-)

-- 
2.35.3


