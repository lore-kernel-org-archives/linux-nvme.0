Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BE3C10F29
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 13:41:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FFC920770
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 13:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sn76Y815"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FFC920770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Djx5Nigw8+4ToFkwq8+AOhYq/CMyHS8bs+fFPNLk6ko=; b=sn76Y815P5Yai2
	bJ/RArdR9r5Y0xE5v42RiX2YEz+m2+Tu3MRRNIQuSeoGLS7kIV0pXiOpqVoh4yVPlLBVpfHehF4de
	kAQXtWsvsXwsryswLij9+WNImxh3dMGQVXhbSRXKZPL1wy5iB9fEQEqTT41m1i6c9dQcGNN06/tD9
	+6ZbDBJtBFPUh8GurnbSHPnz+ii3xEMqSpADopAyGTU+HeQJSFqqv8GG+MX2WHJhp7T0PGgrVadt9
	pLscSSGR8xVU5fdPAKt8SO4O821LjdumYTHdIqi0yfavAbbCg7OVSLIgeq9m4/qQGLAnqUN39D/Ey
	pYD6Jb1NDoKzCvb7e8Aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jECTB-0001KJ-RS; Tue, 17 Mar 2020 13:41:21 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jECSU-0000a8-0P
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 13:40:52 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 17 Mar 2020 15:40:30 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02HDeUhb028750;
 Tue, 17 Mar 2020 15:40:30 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 loberman@redhat.com, bvanassche@acm.org, linux-rdma@vger.kernel.org
Subject: [PATCH 0/5] nvmet-rdma/srpt: SRQ per completion vector
Date: Tue, 17 Mar 2020 15:40:25 +0200
Message-Id: <20200317134030.152833-1-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_064047_310302_7AEBD3A3 
X-CRM114-Status: UNSURE (   9.69  )
X-CRM114-Notice: Please train this message.
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
Cc: vladimirk@mellanox.com, shlomin@mellanox.com, leonro@mellanox.com,
 dledford@redhat.com, jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org,
 Max Gurtovoy <maxg@mellanox.com>, idanb@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This set is a renewed version of the feature for NVMEoF/RDMA target. In
this series I've decided to implement it also for SRP target that had
similar implementatiom (SRQ per HCA) after previous requests from the
community. The logic is intended to save resource allocation (by sharing
them) and utilize the locality of completions to get the best performance
with Shared Receive Queues (SRQs). We'll create a SRQ per completion
vector (and not per device) using a new API (basic SRQ set, added to this
patchset too) and associate each created QP/CQ/channel with an
appropriate SRQ. This will also reduce the lock contention on the single
SRQ per device (today's solution).

For NVMEoF, my testing environment included 4 initiators (CX5, CX5, CX4,
CX3) that were connected to 4 subsystems (1 ns per sub) throw 2 ports
(each initiator connected to unique subsystem backed in a different
bull_blk device) using a switch to the NVMEoF target (CX5).
I used RoCE link layer. For SRP, I used 1 server with loopback connection
(results are not mentioned below) for testing. Hopefully I'll get a tested-by
signature and feedback from Laurence on the SRP part during the review process.

The below results were made a while ago using NVMEoF.

Configuration:
 - Irqbalancer stopped on each server
 - set_irq_affinity.sh on each interface
 - 2 initiators run traffic throw port 1
 - 2 initiators run traffic throw port 2
 - On initiator set register_always=N
 - Fio with 12 jobs, iodepth 128

Memory consumption calculation for recv buffers (target):
 - Multiple SRQ: SRQ_size * comp_num * ib_devs_num * inline_buffer_size
 - Single SRQ: SRQ_size * 1 * ib_devs_num * inline_buffer_size
 - MQ: RQ_size * CPU_num * ctrl_num * inline_buffer_size

Cases:
 1. Multiple SRQ with 1024 entries:
    - Mem = 1024 * 24 * 2 * 4k = 192MiB (Constant number - not depend on initiators number)
 2. Multiple SRQ with 256 entries:
    - Mem = 256 * 24 * 2 * 4k = 48MiB (Constant number - not depend on initiators number)
 3. MQ:
    - Mem = 256 * 24 * 8 * 4k = 192MiB (Mem grows for every new created ctrl)
 4. Single SRQ (current SRQ implementation):
    - Mem = 4096 * 1 * 2 * 4k = 32MiB (Constant number - not depend on initiators number)

results:

BS    1.read (target CPU)   2.read (target CPU)    3.read (target CPU)   4.read (target CPU)
---  --------------------- --------------------- --------------------- ----------------------
1k     5.88M (80%)            5.45M (72%)            6.77M (91%)          2.2M (72%)

2k     3.56M (65%)            3.45M (59%)            3.72M (64%)          2.12M (59%)

4k     1.8M (33%)             1.87M (32%)            1.88M (32%)          1.59M (34%)

BS    1.write (target CPU)   2.write (target CPU) 3.write (target CPU)   4.write (target CPU)
---  --------------------- --------------------- --------------------- ----------------------
1k     5.42M (63%)            5.14M (55%)            7.75M (82%)          2.14M (74%)

2k     4.15M (56%)            4.14M (51%)            4.16M (52%)          2.08M (73%)

4k     2.17M (28%)            2.17M (27%)            2.16M (28%)          1.62M (24%)


We can see the perf improvement between Case 2 and Case 4 (same order of resource).
We can see the benefit in resource consumption (mem and CPU) with a small perf loss
between cases 2 and 3.
There is still an open question between the perf differance for 1k between Case 1 and
Case 3, but I guess we can investigate and improve it incrementaly.

Thanks to Idan Burstein and Oren Duer for suggesting this nice feature.


Max Gurtovoy (5):
  IB/core: add a simple SRQ set per PD
  nvmet-rdma: add srq pointer to rdma_cmd
  nvmet-rdma: use SRQ per completion vector
  IB/core: cache the CQ completion vector
  RDMA/srpt: use SRQ per completion vector

 drivers/infiniband/core/Makefile      |   2 +-
 drivers/infiniband/core/cq.c          |   1 +
 drivers/infiniband/core/srq_set.c     |  78 +++++++++++++
 drivers/infiniband/core/verbs.c       |   4 +
 drivers/infiniband/ulp/srpt/ib_srpt.c | 169 +++++++++++++++++++++-------
 drivers/infiniband/ulp/srpt/ib_srpt.h |  26 ++++-
 drivers/nvme/target/rdma.c            | 202 +++++++++++++++++++++++++---------
 include/rdma/ib_verbs.h               |   6 +
 include/rdma/srq_set.h                |  18 +++
 9 files changed, 409 insertions(+), 97 deletions(-)
 create mode 100644 drivers/infiniband/core/srq_set.c
 create mode 100644 include/rdma/srq_set.h

-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
