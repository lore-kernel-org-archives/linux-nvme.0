Return-Path: <SRS0=h+kd=CH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD14C433E2
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Aug 2020 15:32:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE8C20791
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Aug 2020 15:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ul3sAfwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE8C20791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VwGyjY/Vl/NpgPpIeDXb1Eg+ZUIyvRlUpeZf8lDQDIU=; b=ul3sAfwteXjvBeENPlXcq3rofC
	pwayxYKpgJX9W3+sFWNr51e5laQeE3XTuRywU0ePTWtCpyryje68sK0AGpEnw36bCPgaEN+fYebKi
	nj4ljRHi7OK2NMoAx0Zso6t/5IdRRLUayiVu8F8Hky0ZYXCHnvN0IoRvkbb86I95d+KTY6gM6geHg
	ZAb1hyNr+4/+UaJGySPDyAhlhRY0yx1S+dS4zoTRnls3VdQ1ldddZZpIouBShsDGDaIIG6BE5zNhO
	q02TLxN9L++xAobzIXpG5cgGi46mFMINZl5gGl1oRmDCqbREO3K/uNdjvKXuG3vJxt8PFkBSsx6H+
	SbHOyozg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kC2qW-00026Y-V9; Sat, 29 Aug 2020 15:32:49 +0000
Received: from mail-pf1-f173.google.com ([209.85.210.173])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kC2qU-000266-DE
 for linux-nvme@lists.infradead.org; Sat, 29 Aug 2020 15:32:48 +0000
Received: by mail-pf1-f173.google.com with SMTP id o68so2200918pfg.2
 for <linux-nvme@lists.infradead.org>; Sat, 29 Aug 2020 08:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bwBvPhzWsgBMA4B93AZzg5eo/lFdR101ys5gclkTz9k=;
 b=ckGr3J3fuFPpmwjXXkAzaTy1aYhnx4WnM+Is0TCic70j30VFIBjxRvQD3BVq1vWsIY
 JYSxTXDpL2omeXHbeRddiMRPOQYkQYp8wjimgjo8Af5TQSj26Ij9lpPB1Kq+qp2H5Ki5
 PgUj+GYHf7XykEL0KU00PcscCh5Zbk9rr6new+VELelPHUFq0+wiSrLBMO+SRVhBPUio
 M3hV4T3b/OXspQyJcmTIiu9Deiv3o82gcty5ZzGXqUjBPkUVCYnnNZh1RtwMds0Uo/Zu
 RKb1SbcLT0U5xZTlbCiWClVIJqBN76yFJ7xe9b7ihTY5N9HUbbO+9riCpIiJ4ZnO3STy
 1o8w==
X-Gm-Message-State: AOAM533CZpp19PIq1bCe/zusDdg7dZIXXp+yAYWEMlcx3SzCUyND+tyx
 pe/iRu8KFz1BqrCHAPlArzE=
X-Google-Smtp-Source: ABdhPJxlMGWzjpDeG454J8od1jHKSel7r0h1mstGi3paW/6nHqcoi8dnfmlH+/FwwMmJEmkuMqsVmA==
X-Received: by 2002:a65:4083:: with SMTP id t3mr1500745pgp.201.1598715164916; 
 Sat, 29 Aug 2020 08:32:44 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:b43d:4be3:4cfb:fd9e])
 by smtp.gmail.com with ESMTPSA id p184sm3182347pfb.47.2020.08.29.08.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2020 08:32:44 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme fixes for 5.9 next rc
Date: Sat, 29 Aug 2020 08:32:43 -0700
Message-Id: <20200829153243.324252-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200829_113246_469107_84DB709B 
X-CRM114-Status: GOOD (  10.95  )
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
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey Jens,

Some more nvme fixes:
- instance leak and io boundary fixes from Keith
- fc locking fix from Christophe
- various tcp/rdma reset during traffic fixes from Me
- pci use-after-free fix from Tong
- tcp target null deref fix from Ziye

Please pull.

The following changes since commit a433d7217feab712ff69ef5cc2a86f95ed1aca40:

  Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.9 (2020-08-28 07:52:02 -0600)

are available in the Git repository at:

  ssh://git.infradead.org/var/lib/git/nvme.git nvme-5.9-rc

for you to fetch changes up to 7ad92f656bddff4cf8f641e0e3b1acd4eb9644cb:

  nvme-pci: cancel nvme device request before disabling (2020-08-28 16:43:57 -0700)

----------------------------------------------------------------
Christophe JAILLET (1):
      nvmet-fc: Fix a missed _irqsave version of spin_lock in 'nvmet_fc_fod_op_done()'

Keith Busch (2):
      nvme: fix controller instance leak
      nvme: only use power of two io boundaries

Sagi Grimberg (9):
      nvme-fabrics: don't check state NVME_CTRL_NEW for request acceptance
      nvme: have nvme_wait_freeze_timeout return if it timed out
      nvme-tcp: serialize controller teardown sequences
      nvme-tcp: fix timeout handler
      nvme-tcp: fix reset hang if controller died in the middle of a reset
      nvme-rdma: serialize controller teardown sequences
      nvme-rdma: fix timeout handler
      nvme-rdma: fix reset hang if controller died in the middle of a reset
      nvme: Fix NULL dereference for pci nvme controllers

Tong Zhang (1):
      nvme-pci: cancel nvme device request before disabling

Ziye Yang (1):
      nvmet-tcp: Fix NULL dereference when a connect data comes in h2cdata pdu

 drivers/nvme/host/core.c    | 56 ++++++++++++++++++++++++-------
 drivers/nvme/host/fabrics.c |  1 -
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/pci.c     |  4 +--
 drivers/nvme/host/rdma.c    | 68 ++++++++++++++++++++++++++++----------
 drivers/nvme/host/tcp.c     | 80 ++++++++++++++++++++++++++++++++-------------
 drivers/nvme/target/fc.c    |  4 +--
 drivers/nvme/target/tcp.c   | 10 +++++-
 8 files changed, 167 insertions(+), 58 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
