Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE438C433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=s1x6wfg6aB8qdQQpbkSOnP/Y7MiybS3pCWLlf8P2jcI=; b=a0Ojp4kEkglSpyqavFdem6AaxQ
	nlxq9WoHIXS8C58k+qqj0XGNOxBAM+2Qb3LD66wML6MTZ0zTbDAd69kjmb/qrSx2oq+zwVxB3aE9h
	G/SAo7xiwtXJjOOhRJiJIVP+OOuhDG36d3Me6QMG53qEB03CMaluDzpzB0wAgTnjkSmQg+Ok3Rr9U
	rN6riFpv37HPK5zEEZ2H4KOXf1nCbggz+0KS/436V0gUMTQw34TgXDtWd0h6pBlO9Kj/80tDAtyV0
	TboUb0LgHunnUVgcNwjnf5a+p/zOcBcdB5KyzoNvfS0lcYb4VWOagrIUlfTb30EoRV7ZHlObmNq8S
	gsZFLPdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6G-00B6N6-0f; Sun, 13 Nov 2022 11:24:32 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6D-00B6Lk-0R
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:30 +0000
Received: by mail-wr1-f42.google.com with SMTP id k8so12427394wrh.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1x6wfg6aB8qdQQpbkSOnP/Y7MiybS3pCWLlf8P2jcI=;
        b=qfGIsnNtny6KIVfpRDroHTXvwJFrAY9Vfj+cm0JwomTRgD7nKC54TzmzEr08QxoUCe
         i5Me+JhxJXHeN/fkw2bZ21ZVaVelFXjYPErYPUYu9OrFBgYGe1zZxsFBUuolJi7m3UoN
         CHoW+/M8Dre3ZqzoNEeTWyrHbSYUpLCantsuA0OEkHy2QZ+wWKgmdVv4JLZzAeHfTKZ7
         71zhSOCBmMBjUSuB3SYTCtI1pkXktXWA4GFb4vvBqkEBj57HInPjqshKIO8tbJ9o/3B5
         MrI1Csz7TaQQZJt5bdTMtvY34qE0DqIVeHaKPuV+kC6k0GfmDT5bpKvye0pi5iv/UP5f
         zQOA==
X-Gm-Message-State: ANoB5pnUmc6aG/j+Zf4ucnqA6p3UHrLfW0neufX4hTSc9gWkv3HcaKey
	1tO7G9DHFwnne9uji0sRbRkavTFu1VE=
X-Google-Smtp-Source: AA0mqf5X5ZV9ylwrbYbosoke6YbEfSIHlLJdOuQPa2guoji8OYzh9f2eO4Ad0pokrzV8gmXyobZqUA==
X-Received: by 2002:a05:6000:1241:b0:236:d8f8:b87d with SMTP id j1-20020a056000124100b00236d8f8b87dmr4959727wrx.343.1668338666973;
        Sun, 13 Nov 2022 03:24:26 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:26 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 00/20] nvme: fixes, cleanups and enhancements to the dhchap-auth host code
Date: Sun, 13 Nov 2022 13:24:04 +0200
Message-Id: <20221113112424.1049834-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032429_074620_C97C1671 
X-CRM114-Status: GOOD (  13.25  )
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

Currently the authentication code is fairly fragile with respect to
mutual locking between secrets sysfs override, re-authentication, and
controller resets.

This patch set attempts to resolve these issues by:
1. freeing queue chap context as soon as authentication completes
   - including making the chap 4k buffer short-lived (added a mempool
     to overcome memory pressure situations).
2. allocate a simple vector for queue chap contexts so there is
no list/tree traversal to resolve queue chap context. queue chap
contexts are 1x1 mapped to queues, which are stored in a vector as
well.
3. flush chap auth_work from the ctrl dhchap work, this simplifies
how we flush inflight authentication sequence
4. use ctrl dhchap_auth_mutex to protect only the resources that are
accessed and modified via sysfs and the authentication flow (i.e. ctrl
host_key and ctrl_key)
5. move drivers (rdma/tcp) nvme_auth_stop later in the error recovery
flow to expedite failover and not block on I/O.

Feedback is welcome.

Changes from v1:
- split some of list->array conversion patch to make it simpler to review
  still it involves the locking changes in it so no regression is introduced.
- removed dhchap array macro foreach and accessor as the dhchap queue context
  is now typed in nvme_ctrl.
- Added mempool for chap buffers to overcome memory pressure situations
- removed redundant chap->buf_size
- renamed __nvme_auth_work to nvme_queue_auth_work (also nvme_dhchap_auth_work
  to nvme_ctrl_auth_work)
- converted macro to static inline function (ctrl_max_dhchaps)

Sagi Grimberg (20):
  nvme-auth: rename __nvme_auth_[reset|free] to
    nvme_auth[reset|free]_dhchap
  nvme-auth: rename authentication work elements
  nvme-auth: remove symbol export from nvme_auth_reset
  nvme-auth: don't re-authenticate if the controller is not LIVE
  nvme-auth: remove redundant buffer deallocations
  nvme-auth: don't ignore key generation failures when initializing ctrl
    keys
  nvme-auth: don't override ctrl keys before validation
  nvme-auth: remove redundant if statement
  nvme-auth: don't keep long lived 4k dhchap buffer
  nvme-auth: guarantee dhchap buffers under memory pressure
  nvme-auth: clear sensitive info right after authentication completes
  nvme-auth: remove redundant deallocations
  nvme-auth: no need to reset chap contexts on re-authentication
  nvme-auth: check chap ctrl_key once constructed
  nvme: move nvme_dhchap_queue_context declaration to nvme.h header
  nvme-auth: convert dhchap_auth_list to an array
  nvme-auth: remove redundant auth_work flush
  nvme-auth: have dhchap_auth_work wait for queues auth to complete
  nvme-tcp: stop auth work after tearing down queues in error recovery
  nvme-rdma: stop auth work after tearing down queues in error recovery

 drivers/nvme/host/auth.c | 282 ++++++++++++++++++---------------------
 drivers/nvme/host/core.c |  32 ++++-
 drivers/nvme/host/nvme.h |  43 +++++-
 drivers/nvme/host/rdma.c |   2 +-
 drivers/nvme/host/tcp.c  |   2 +-
 5 files changed, 200 insertions(+), 161 deletions(-)

-- 
2.34.1


