Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF464C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 06:36:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB4D4601FC
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 06:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB4D4601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4EZVP4lxyqBvcs3v6tty/Uie6HGReiXFhI9/YxDQB78=; b=pKektCBHBQxZc/
	kZAmG2cu7F6TB9M92sJtHG89zHcgDx/gqCjwkMSSlFB27Ybv1JLBGSl3gA0s61TbjmLWfOhKjVI9B
	mX7WGtic8nXbUyrm/SqLfZRXLUAvSkt7x/GL4nONuKvFv8ULHyPIWYSIKN18JBC9XQtlqgx5py2wW
	QpOJz1zaaVX1+RvtwNaUAyHhKVDgNMDEXc0n6ARbcXOl+l4v5YGfwoXXuA991L7f2emEJJ1Bp6g6o
	vUl2VYjr/IttKXaRJf2KvISEL1sovagg7Ieup6TfNzn0NKlJnCusBeKeJh//qDbKFvOLD1wySprhA
	Dyne6Lz7lxbtirlQPz4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSvrd-0075uv-PX; Wed, 22 Sep 2021 06:36:17 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSvqq-0075b7-PZ
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 06:35:30 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 593AC201BA;
 Wed, 22 Sep 2021 06:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632292527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iGaqqPxrkwE64yKU54xDvhWA18vuW0ipUcnyzfrglOo=;
 b=A77YoZLnltp6/B0Y5YYZykVAizflFhZ/MO/QkI+7M7OHbxhCtego6M3Xz1r9iDWg5U75Zd
 MSWdVZQGSmg8Wc0Kh/tx5cDbRXCYjKaROrACNQCRq6pkKJPvLcp45i+HyYaEwcqQgeIDuZ
 O1hM8I/ckaAPAbSdPXnty1JF1NHgQ4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632292527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iGaqqPxrkwE64yKU54xDvhWA18vuW0ipUcnyzfrglOo=;
 b=0JwCpLO/hx92piqnYeXcrM6G+GMjon9/szA82/DeFzeTXGlH74NR6EvpEY/5Zq/E9BE47s
 mt6ATiECGzxEI0DA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id EAF32A3B9A;
 Wed, 22 Sep 2021 06:35:26 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id DCF92518EAEC; Wed, 22 Sep 2021 08:35:26 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 0/7] nvme: support unique discovery controller NQN
Date: Wed, 22 Sep 2021 08:35:18 +0200
Message-Id: <20210922063525.143045-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_233529_052698_D394D6F5 
X-CRM114-Status: GOOD (  12.04  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

with TPAR8013 a discovery controller can support a unique subsystem
NQN. This patchset adds support for this for both target and host.
For host support a new connect option 'discovery' is added, as we
can't infer from the NQN whether it should be a discovery connection
or not.

As usual, comments and reviews are welcome.

Changes to v1:
- Rebase to nvme-5.15
Changes to v2:
- Add nvmet_is_disc_subsys() helper
- Include reviews from Chaitanya

Hannes Reinecke (7):
  nvmet: make discovery NQN configurable
  nvme: add CNTRLTYPE definitions for 'identify controller'
  nvmet: add nvmet_is_disc_subsys() helper
  nvmet: set 'CNTRLTYPE' in the identify controller data
  nvme: expose subsystem type in sysfs attribute 'subtype'
  nvme: Add connect option 'discovery'
  nvme: display correct subsystem NQN

 drivers/nvme/host/core.c          | 36 +++++++++++++++++++++++++++-
 drivers/nvme/host/fabrics.c       |  6 ++++-
 drivers/nvme/host/fabrics.h       |  6 +++++
 drivers/nvme/host/fc.c            |  2 +-
 drivers/nvme/host/nvme.h          |  1 +
 drivers/nvme/host/rdma.c          |  2 +-
 drivers/nvme/host/tcp.c           |  2 +-
 drivers/nvme/target/admin-cmd.c   |  5 +++-
 drivers/nvme/target/configfs.c    | 39 +++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        |  9 +++----
 drivers/nvme/target/discovery.c   |  2 ++
 drivers/nvme/target/fabrics-cmd.c |  3 ++-
 drivers/nvme/target/nvmet.h       |  5 ++++
 include/linux/nvme.h              | 10 +++++++-
 14 files changed, 116 insertions(+), 12 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
