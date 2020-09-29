Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAB5C4346E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 09:14:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D0320848
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 09:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W2yTCqtL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bdi7sPqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D0320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AEC5B0NPJiRW4GUJzHHONu6eOlXB6a1eVCokW6pl8RA=; b=W2yTCqtLzgKouApgfrhY3gT40b
	ImszS5/a+u+am55hzvReYvBha8vWexrmWIsXN6WkLvvq5dvenMTeJBeYybHKhElvYRRzrbs3eO4nk
	1qHoss7bB80Pe+/9+POMEkaMflKt/xCY5LgAMpKZEjGHceI/M18QizHltN17lIfSZoVcRvWXStIRl
	6CjGJI5INznZ/zTWQ+809i3OGEQwiCO6y22oPYbIY2R2ket0G+T49bFS7rWTv4+va0ieBI662atm3
	jSgrKh4juhukr/SryMedzOkXxIu1D7SUNCMN/3j2NVy5krlm/JQszn2b2NVv3vuicCa1lDPP6q4/+
	ynvAPBXw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNBiO-0001oQ-6l; Tue, 29 Sep 2020 09:14:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNBi3-0001dB-JC
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 09:14:09 +0000
Received: from localhost (unknown [213.57.247.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6D68F204FD;
 Tue, 29 Sep 2020 09:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601370844;
 bh=Zd9UpoW6JRJ/ucEPMrtkJe/8coFXg+LYrhj/oUBaD2o=;
 h=From:To:Cc:Subject:Date:From;
 b=Bdi7sPqZh06EI8g/goIIEMz6G8OVAf9790vfiKw6Yz1SddLqyM7WYENSIxT+d93ni
 OTRf+Tt5fIWI93mdEFgegpbGhEdFzGbnDJx6oGB3+rkNe2olWYNvjBjbiEHpEf9iTj
 OQvxWAqel4xC0PZcraekXubc1B/+wbzozTybMBWg=
From: Leon Romanovsky <leon@kernel.org>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH blk-next 0/2] Delete the get_vector_affinity leftovers
Date: Tue, 29 Sep 2020 12:13:56 +0300
Message-Id: <20200929091358.421086-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_051407_812046_CC3A9147 
X-CRM114-Status: GOOD (  10.28  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Leon Romanovsky <leonro@nvidia.com>

There are no drivers that implement .get_vector_affinity(), so delete
the RDMA function and simplify block code.

Thanks

P.S. Probably it should go through block tree.

Leon Romanovsky (2):
  blk-mq-rdma: Delete not-used multi-queue RDMA map queue code
  RDMA/core: Delete not-implemented get_vector_affinity

 block/Kconfig                    |  5 ----
 block/Makefile                   |  1 -
 block/blk-mq-rdma.c              | 44 --------------------------------
 drivers/infiniband/core/device.c |  1 -
 drivers/nvme/host/rdma.c         |  7 ++---
 include/linux/blk-mq-rdma.h      | 11 --------
 include/rdma/ib_verbs.h          | 23 -----------------
 7 files changed, 2 insertions(+), 90 deletions(-)
 delete mode 100644 block/blk-mq-rdma.c
 delete mode 100644 include/linux/blk-mq-rdma.h

--
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
