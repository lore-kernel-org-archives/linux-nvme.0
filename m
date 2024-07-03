Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1F6C30653
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 13:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5l0VbpLFEVSJBKbkgtLMXU2JlEmNzYMYbZuesP9bgUE=; b=REmHFwV1Qc7Dbuc1RrZotKImt7
	1ROSVQGIEkeUsxCy2SRq4G52BXxuhmDOeG140gfjezg0PM+nLHR7WifdPf4dDMNF5qp6OA7f6bg5F
	mvJoiwduza9fqueWMLf4RT2usaUk8DRMABuingvDGnqK6sOOv2eIBS1LIr6OW7GQRMxTC5wpSnFOs
	+QM6rwEWx6GqRnGuRV8Ypp3WAr9MWni5vc9Dmpo+MPSMYh9nHncUVQ8TV1lMrvxy6DbzRhRWlyQYL
	jJ7P/xHzGOQlOKUT2kwQOIIStUIs90NJHKl7d3zVgIIouoh7kta2hi7K1BbgEhij0rlDtqhQkdepZ
	5mSUbi2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0NT-0000000AM2c-3D4j;
	Wed, 03 Jul 2024 13:50:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0NQ-0000000AM1i-0sUf
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 13:50:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 826E36222E;
	Wed,  3 Jul 2024 13:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC83EC2BD10;
	Wed,  3 Jul 2024 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720014626;
	bh=XijVjpZSZurPWo0rHEhK7K2Elx7MDeOBH0IXVYhVo7k=;
	h=From:To:Cc:Subject:Date:From;
	b=nmvSaPGsMoV2BvG1Z4QJrtaJ1AxXrCY+XLOdsu5I5sHHsnuOzkLM3bcN2dh+KPDf7
	 4Jtcg48bljaalQcAL1eeEkVHDWQZ2kBTdeRIMF0ddiVzgfNnLTC0FlyN9ojD7bVm2z
	 rrrigLCs6azfdIGvjftHBYLHRimVVOyt5weFFc8PTj+mUZu7rCyAI+DsOjUeSJ1MKM
	 j688E8tK8gINzUFmjw8unfM7d5UjYReovpd+bJT5mOzef35VyYRxPdAXT8KDQ0Rl0h
	 vlOY9L435tvHK9a6XsMNmUhW0PS71R/bTi3AYGggS8Irmzelet1vpCGaZITvr8E6lB
	 UKbJWTIT8ETQQ==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 0/4] nvme-tcp: improve scalability
Date: Wed,  3 Jul 2024 15:50:17 +0200
Message-Id: <20240703135021.34143-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_065028_390092_C53A45CD 
X-CRM114-Status: GOOD (  10.62  )
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

for workloads with a lot of controllers we run into workqueue contention,
where the single workqueue is not able to service requests fast enough,
leading to spurious I/O errors and connect resets during high load.
This patchset improves the situation by introducing per-controller workqueues,
and modifies the 'wq_unbound' module parameter to include the blk-mq
cpu information for improving the locality.
With this we reduce the spurious I/O errors and improve the overall
performance for highly contended workloads.

Performance comparisons are hard to get as the original code would
abort with I/O timeouts such that fio has a hard time completing...

As usual, comments and reviews are welcome.

Hannes Reinecke (4):
  nvme-tcp: per-controller I/O workqueues
  nvme-tcp: align I/O cpu with blk-mq mapping
  workqueue: introduce helper workqueue_unbound_affinity_scope()
  nvme-tcp: switch to 'cpu' affinity scope for unbound workqueues

 drivers/nvme/host/tcp.c   | 84 +++++++++++++++++++++++++--------------
 include/linux/workqueue.h |  1 +
 kernel/workqueue.c        | 47 +++++++++++++++++-----
 3 files changed, 93 insertions(+), 39 deletions(-)

-- 
2.35.3


