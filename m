Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63155C04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 19:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iyycBCK0NNl8E30Z+4DtXcZiRG0olQqpTeLI0obxIz8=; b=iT/pPfZHomELDI9pSw6vW3Wsqm
	Zt1ASbTe1657gDcta1h1lAmAjYoSq0lZSsQKJtEJGlzPh+Ezx+Zjo4m8wUZ9WrOwX5HMu4z7BIhnP
	TjAlQ1lC9+QK5Z9UVhYM7Vmzvy10HDbUJBB2+UITRGTq6nSxJWzpo5a783E+IpbCLPvL4yUkv6LYW
	rqRAGcpHhBk8y1Nrtp0NFX4h3wTszlw/nx6/wEqNlNRtvCmI+PohdaGQ5LbZaqYNAxZtzGfjewwDI
	NGNb8+h8TQOk8xXv+EmMkFOpy+F7HFFzNjJhc3vJbS5xssgBu4JR/mCJ9IYF8EOC7NVaIa/SKVgVo
	YIweI9Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odd9L-000BdF-7K; Wed, 28 Sep 2022 19:55:19 +0000
Received: from mail-ed1-f47.google.com ([209.85.208.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odd9I-000Bbe-P8
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 19:55:18 +0000
Received: by mail-ed1-f47.google.com with SMTP id a13so3539856edj.0
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 12:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=iyycBCK0NNl8E30Z+4DtXcZiRG0olQqpTeLI0obxIz8=;
        b=GvMAuLeCUnQb7R5O1X99SyAghc6rv/sBknvtDomC19OQ8Y5CmAsfLg+fboiOMPNKcb
         m9L2DOQrblhRwVm5DArbLOUBMsnfA1k7aVfAMsceX7GmiCgGUzjGbJF/Y9ae0cWXHmo2
         drOdv28KVBHNBVLB5mtWbczghtvrLlGatvuMf6FgHMb84XCrvXBaegHmg5ucxvyPHlKH
         FXPf9SLY79oNGxvXGjhPNLVB1OTpJZqFj0116Dsu6HUcjCJYjqMjwiBqu1/wdh1JHKxW
         dHFPNDBMvfvlV1V+BC142qfSyDcGIxzGLawkDneYAbG9ucJssndQIMNoWIL7J89zPsoq
         /7iA==
X-Gm-Message-State: ACrzQf1ps/nKnhsA+gwwQSgtIu2moZopNN5FQljkXzHLdO61mjFDGNol
	8T1ypl7JwDN/+f9kjFnDztZNT+onpIA=
X-Google-Smtp-Source: AMsMyM61kr+zoTEsDafTgmogLbwOkf40C75jIS2C9n2L4A0G+n1bvyNSuwEzneeXIJJ+lS8s1SUJJg==
X-Received: by 2002:aa7:cb87:0:b0:43b:e650:6036 with SMTP id r7-20020aa7cb87000000b0043be6506036mr34929160edt.350.1664394913026;
        Wed, 28 Sep 2022 12:55:13 -0700 (PDT)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906329000b007389c5a45f0sm2845747ejw.148.2022.09.28.12.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 12:55:12 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH rfc 0/1] nvme-mpath: Add IO stats support
Date: Wed, 28 Sep 2022 22:55:09 +0300
Message-Id: <20220928195510.165062-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_125516_840520_9AFC6F70 
X-CRM114-Status: GOOD (  14.84  )
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

I've been hearing complaints about the fact that the nvme mpath stack
device does not expose IO stats just like any normal block device,
instead people need to check the bottom namespaces hidden devices,
mapping back to the mpath device node.

This really sucks, especially for observability hooks/plugins that
I've seen people do.

This is an attempt to make the nvme mpath device expose normal IO stats.
Given that nvme-mpath doesn't have any context after submitting the bio,
we use the core completion path to start/end stats accounting on its
behalf, a similar practice that we use for other multipath related stuff.

Given that its not too invasive, I decided to keep it
in a single patch, but I can certainly split it in to
smaller patches if anyone thinks I should.

Feedback is welcome.

Sagi Grimberg (1):
  nvme: support io stats on the mpath device

 drivers/nvme/host/apple.c     |  2 +-
 drivers/nvme/host/core.c      | 10 ++++++++++
 drivers/nvme/host/fc.c        |  2 +-
 drivers/nvme/host/multipath.c | 18 ++++++++++++++++++
 drivers/nvme/host/nvme.h      | 13 +++++++++++++
 drivers/nvme/host/pci.c       |  2 +-
 drivers/nvme/host/rdma.c      |  2 +-
 drivers/nvme/host/tcp.c       |  2 +-
 drivers/nvme/target/loop.c    |  2 +-
 9 files changed, 47 insertions(+), 6 deletions(-)

-- 
2.34.1


