Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D56AC2D0E2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 12:15:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70EF22395C
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 12:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RCkhVt91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EF22395C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mp1Jva+voIU1eMgMEMjK0UxC1SCuBWyuYk6jB+ZgCCA=; b=RCkhVt912ju1hTnoetBNuFR5N7
	yLneUti7bh4QQUYRATaqJm9a6tEZol3qtZKxv9AVQ4zmiC+rir3GUr6YAzVgblZxEUvqwTYox5mIE
	9Q7qmeMMrRAbiGMbbDQCz6QiutRO3akdzQEaoXRREhalhxg3wgV0yLzmDmTS4wppIhmZdU9UnLuuR
	r7QscJ9NXMAGA3UzJ56+8r+/XACj2felTpYeGgN4evOQR1AHcxARI1n3V9LRgoOFCpGToIQCxuzQr
	BIWQE52l0UhnyCE+UPvu49YaKN4Bhfh/Rl1ayGw11bhn2+fVm1b99HKyyWd5IB+Pg+7td0Sja0MOq
	+ngq3KJg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKhCX-0003oI-Vz; Tue, 22 Sep 2020 12:15:18 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKhCU-0003lh-N6
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 12:15:15 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A03D3AF55;
 Tue, 22 Sep 2020 12:15:48 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/7] nvme-fcloop: fix shutdown and improve logging
Date: Tue, 22 Sep 2020 14:14:54 +0200
Message-Id: <20200922121501.32851-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_081514_908218_21469E0F 
X-CRM114-Status: GOOD (  12.26  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 James Smart <james.smart@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

there's a long-standing issue with fcloop that it triggers a use-after-free
when removing ports as the disconnect I/O is still running while the ports
are being removed.
This patchset fixes up this issue and also creates a device for each localport
and each nport; with that the logging is vastly improved as we now have
readable device names in the logging output and not "(NULL devuce *)".

Blocktests will be send separately.

As usual, comments and reviews are welcome.

Hannes Reinecke (7):
  nvme-fcloop: flush workqueue before calling
    nvme_fc_unregister_remoteport()
  nvmet-fc: use per-target workqueue when removing associations
  nvme-fcloop: use IDA for port ids
  nvmet-fc: use feature flag for virtual LLDD
  nvme-fc: use feature flag for virtual LLDD
  nvme-fcloop: use a device for nport
  nvme-fcloop: use a device for lport

 drivers/nvme/host/fc.c         |  93 ++++++++++++++++-------------
 drivers/nvme/target/fc.c       | 122 +++++++++++++++++++++++---------------
 drivers/nvme/target/fcloop.c   | 131 ++++++++++++++++++++++++++++++++---------
 include/linux/nvme-fc-driver.h |  12 ++++
 4 files changed, 241 insertions(+), 117 deletions(-)

-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
