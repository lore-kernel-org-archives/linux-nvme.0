Return-Path: <SRS0=eVk/=55=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7992C2BA19
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2020 14:15:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE50C20776
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2020 14:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tfij7vvB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cc2GAdH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE50C20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KE8/QELv8E0gDeeZq22eWoasj75zPuTxdR5a8uIqUBU=; b=Tfij7vvBNOSM4g
	IMKNaTr4+e5rBNXiVLjVF8+yi0zjZaMsBMMx2pgeKWzhp4K3KlcdyuI+JHl2EYKApWfOtfejAjZZg
	KWhj6giewFOWbiMCx8kA16tqIwCieSY8phw/JLp+aRS5r5V/wQlK2Az8I0crzYl6b3pQkyYk+uf1Z
	2Qm7+0TOkp5a4XRCTxn7MBGyqbZE7p1EIq2emu8ABOxRcpDGA8LM0SqhLfS4BtwgudtH9MD02MSMi
	K672p/R/ZmcQLdGfrcmLUDBwXF592apGmy2o5/8/ofz288pal/LQA2aAKcAQnCbIxpNCmROPBOTmP
	ffNiUKdvWPfHtUp7V0RA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jNzsK-0006M9-Bv; Mon, 13 Apr 2020 14:15:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jNzsF-0006Li-RW
 for linux-nvme@lists.infradead.org; Mon, 13 Apr 2020 14:15:45 +0000
Received: from localhost (unknown [213.57.247.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 417A92073E;
 Mon, 13 Apr 2020 14:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586787342;
 bh=p4H0mbNsqUXCc+rVKfiFXeEwB+ggGqgRm+g9Z3fEcEY=;
 h=From:To:Cc:Subject:Date:From;
 b=Cc2GAdH6dnHe8KR4lpmbGMf5sORxwT0GEUnUKFd8hZi3eGW5HejVhjHLQKnx3hrkQ
 N8IFris9OuI3EAyBxcks0qgFRnqc1Vi+1oYi7SScdH6CD1/6DU0YCBtHWoawpVE5UX
 t3k8dWDqrsJV4BbxHVbO3BkqmcK/PWt1HfJPSvhw=
From: Leon Romanovsky <leon@kernel.org>
To: Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-next v2 0/7] Add Enhanced Connection Established (ECE)
Date: Mon, 13 Apr 2020 17:15:31 +0300
Message-Id: <20200413141538.935574-1-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200413_071543_909943_C80539FE 
X-CRM114-Status: UNSURE (   9.23  )
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
Cc: rds-devel@oss.oracle.com, Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@oracle.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Leon Romanovsky <leonro@mellanox.com>, target-devel@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog:
 v2:
 * Rebased on latest rdma-next and removed already accepted patches.
 * Updated all rdma_reject in-kernel users to provide reject reason.
 v1: Dropped field_avail patch in favor of mass conversion to use function
     which already exists in the kernel code.
 https://lore.kernel.org/lkml/20200310091438.248429-1-leon@kernel.org
 v0: https://lore.kernel.org/lkml/20200305150105.207959-1-leon@kernel.org

Enhanced Connection Established or ECE is new negotiation scheme
introduced in IBTA v1.4 to exchange extra information about nodes
capabilities and later negotiate them at the connection establishment
phase.

The RDMA-CM messages (REQ, REP, SIDR_REQ and SIDR_REP) were extended
to carry two fields, one new and another gained new functionality:
 * VendorID is a new field that indicates that common subset of vendor
   option bits are supported as indicated by that VendorID.
 * AttributeModifier already exists, but overloaded to indicate which
   vendor options are supported by this VendorID.

This is kernel part of such functionality which is responsible to get data
from librdmacm and properly create and handle RDMA-CM messages.

Thanks

Leon Romanovsky (7):
  RDMA/cm: Add Enhanced Connection Establishment (ECE) bits
  RDMA/uapi: Add ECE definitions to UCMA
  RDMA/ucma: Extend ucma_connect to receive ECE parameters
  RDMA/ucma: Deliver ECE parameters through UCMA events
  RDMA/cm: Send and receive ECE parameter over the wire
  RDMA/cma: Connect ECE to rdma_accept
  RDMA/cma: Provide ECE reject reason

 drivers/infiniband/core/cm.c            | 41 ++++++++++++++++---
 drivers/infiniband/core/cma.c           | 52 ++++++++++++++++++++++---
 drivers/infiniband/core/cma_priv.h      |  1 +
 drivers/infiniband/core/ucma.c          | 40 +++++++++++++++----
 drivers/infiniband/ulp/isert/ib_isert.c |  4 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c   |  2 +-
 drivers/nvme/target/rdma.c              |  2 +-
 include/rdma/ib_cm.h                    | 10 ++++-
 include/rdma/ibta_vol1_c12.h            |  6 +++
 include/rdma/rdma_cm.h                  | 18 ++++++++-
 include/uapi/rdma/rdma_user_cm.h        | 15 ++++++-
 net/rds/ib_cm.c                         |  2 +-
 12 files changed, 167 insertions(+), 26 deletions(-)

--
2.25.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
