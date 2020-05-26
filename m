Return-Path: <SRS0=Hg5O=7I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFF4C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2020 10:33:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4592084C
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2020 10:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qar2xlt/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkE3vJD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4592084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=iVWGJ2BGGnLWdDyRhQrMEqX9tpKUu+HQ2cqtIKXM7Ro=; b=qar2xlt/X7axxW
	mlN9B9Ox22chppeQMbcu6zEDSHigflkUCMrJKHJ2CiPP+rs56MVizc0nu0liBwbmLHHyn0EkOuuik
	7xT0Sx8ivO824ROsMQ06KJZLKsaQTubp9HkT80NCNQtvVBUKZNUzTpH1T6OYIEl25qzpi8Q2A4IcM
	5cbuei1yEXCydK5VsilM5VfqaLWy2ehh7G6jmrbxVaI49hp3Ugj2AM7aEa7ikDdlx9+nsKerRPzyD
	tJl1BjWaXhrr9tsKwANIgROX9AnptzUfk1eEILUv9ZhocPOT+2IZSBysTIC8QdQHHFEJmVdCxl+yz
	n+aWWaHvUbIdt15GhaQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdWtV-000873-4w; Tue, 26 May 2020 10:33:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jdWtS-00085z-3t
 for linux-nvme@lists.infradead.org; Tue, 26 May 2020 10:33:11 +0000
Received: from localhost (unknown [213.57.247.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1A27020776;
 Tue, 26 May 2020 10:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590489189;
 bh=pq8On3WUlO+xI1ImWpqd/5ofHohCbw1G+yEvp3sHefs=;
 h=From:To:Cc:Subject:Date:From;
 b=qkE3vJD9pAkF3cpL6g/1BJ8bDOux9VE1YndQK4NqxcMh4hT2fmc40ZL5t9TsMrLkG
 qbQSJclWxYQTHsvHpBI2AXOJrwu3R5UBhsw9393Ad6ubNcE9wVhHthIvjWc46dgnlQ
 JIsvvXdejMOAtF4xzU3albNtewmk9ma1rOo0IF+Y=
From: Leon Romanovsky <leon@kernel.org>
To: Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-next v3 0/6] Add Enhanced Connection Established (ECE)
Date: Tue, 26 May 2020 13:32:58 +0300
Message-Id: <20200526103304.196371-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200526_033310_198000_2FEE4A13 
X-CRM114-Status: UNSURE (   9.64  )
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
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leonro@mellanox.com>,
 target-devel@vger.kernel.org, Danil Kipnis <danil.kipnis@cloud.ionos.com>,
 Jakub Kicinski <kuba@kernel.org>, Jack Wang <jinpu.wang@cloud.ionos.com>,
 "David S. Miller" <davem@davemloft.net>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog:
 v3:
 * Rebased on top of ebd6e96b33a2 RDMA/ipoib: Remove can_sleep parameter from iboib_mcast_alloc
 * Updated rdma_reject patch to include newly added RTR ulp
 * Remove empty hunks added by rebase
 * Changed signature of rdma_reject so kernel users will provide reason by themselves
 * Squashed UAPI patch to other patches which add functionality
 * Removed define of the IBTA reason from UAPI
 v2: https://lore.kernel.org/linux-rdma/20200413141538.935574-1-leon@kernel.org/
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

Leon Romanovsky (6):
  RDMA/cm: Add Enhanced Connection Establishment (ECE) bits
  RDMA/ucma: Extend ucma_connect to receive ECE parameters
  RDMA/ucma: Deliver ECE parameters through UCMA events
  RDMA/cm: Send and receive ECE parameter over the wire
  RDMA/cma: Connect ECE to rdma_accept
  RDMA/cma: Provide ECE reject reason

 drivers/infiniband/core/cm.c            | 39 ++++++++++++++---
 drivers/infiniband/core/cma.c           | 57 ++++++++++++++++++++++---
 drivers/infiniband/core/cma_priv.h      |  1 +
 drivers/infiniband/core/ucma.c          | 49 +++++++++++++++++----
 drivers/infiniband/ulp/isert/ib_isert.c |  4 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c  |  2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c   |  3 +-
 drivers/nvme/target/rdma.c              |  3 +-
 include/rdma/ib_cm.h                    |  9 +++-
 include/rdma/ibta_vol1_c12.h            |  6 +++
 include/rdma/rdma_cm.h                  |  9 +++-
 include/uapi/rdma/rdma_user_cm.h        | 11 ++++-
 net/rds/ib_cm.c                         |  4 +-
 13 files changed, 170 insertions(+), 27 deletions(-)

--
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
