Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2A5C0032E
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RWnVFl4yTMpGAhcxxisIXernnNmulU9evsnDUECP5nA=; b=xfKZC/PocKgj2co3FiG94k9sYe
	10VgSxGnWQNN8/Q4T4u0S9b5yvDZEIhVLojIkL0/c3Qxe2DU3C+LYmVYPq0XfPoWxSqt8LAhaH2VE
	k3s3EBiyutPWXY8lfMlEtfLc017cbVsaw4UJzuOSIle8KQd5oJC5+RA1jqOVSNqkVV6TFbaUcABkz
	QtZbIkK2cM2eUxF7pywEG4E8ZYLsZ4QPX4ntrf7azwGM+LZE97LMSpsCxkIAMOHsNvFNoGefnblfr
	wMhN/4x5EDOeSCUeOekV6BSQrnFmLegiZekEYSaLluUZI0UUmISYuSIp5stLnRIfFblRGRcRs/VBt
	s43kfcjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtqS4-002UOB-31;
	Fri, 20 Oct 2023 14:26:12 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtqRw-002UKe-1b
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 14:26:10 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 569EB21A2B;
	Fri, 20 Oct 2023 14:26:02 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 1D4342C8A7;
	Fri, 20 Oct 2023 14:26:02 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 4070451EC18D; Fri, 20 Oct 2023 16:26:02 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/4] nvme: start keep-alive after admin queue setup
Date: Fri, 20 Oct 2023 16:25:56 +0200
Message-Id: <20231020142600.47246-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [5.49 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(0.20)[suse.de];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(0.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[5];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-0.00)[38.47%]
X-Rspamd-Queue-Id: 569EB21A2B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_072604_761889_55AB6CF0 
X-CRM114-Status: UNSURE (   8.92  )
X-CRM114-Notice: Please train this message.
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

Setting up I/O queues might take quite some time on larger and/or
busy setups, so KATO might expire on the admin queue before all
I/O queues can be setup.
This patchset fixes this issue by moving the calls to starting
and stopping KATO into the quiesce/unquiesce functions.
That requires some refactoring/alignment with some transport
drivers which do not always quiesce and unquiesce the admin
queue.

As usual, comments and reviews are welcome.

Hannes Reinecke (4):
  nvme-fc: add missing quiesce in nvme_fc_create_association()
  nvme-pci: unquiesce admin queue before nvme_init_ctrl_finish()
  nvme-loop: quiesce admin queue on failure
  nvme: start keep-alive after admin queue setup

 drivers/nvme/host/apple.c  |  4 ++--
 drivers/nvme/host/core.c   |  7 ++++---
 drivers/nvme/host/fc.c     | 16 +++++++++-------
 drivers/nvme/host/nvme.h   |  2 +-
 drivers/nvme/host/pci.c    |  9 ++++++---
 drivers/nvme/host/rdma.c   |  6 +++---
 drivers/nvme/host/tcp.c    |  6 +++---
 drivers/nvme/target/loop.c |  6 ++++--
 8 files changed, 32 insertions(+), 24 deletions(-)

-- 
2.35.3


