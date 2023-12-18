Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEE8C46CA2
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 11:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=okowarAQ8JjPhcFNkze/HZIg3vVCuZoGWnMUnU6UsRw=; b=yf6nWVevsL/Yj9sAeqLDhlTS1+
	o9yurUY6NrRUmY4D0z3DV0e1ZoZKMa88wApc0s8cLsuiUWP9twfELyayubaamirBlP+2Po3PfehFC
	gm/J7F7wjOOPJ0W6du6qjy8Wj6j0tHugQznbE4chsXf4ZkGdik5OkAXRp21l4krW3inD02aRahAbu
	Z8h5YO+8XFbNcS7AQUDxv6Vt8Rt05sE0Cy6NMSmByixtuv+ao2Jlr13n0Q+6w080xWyJ17BOhQn2f
	NojIKYO6aTV+0+itluE6YaSfJatsS6cXkvS9iMuvVLB5WeeBCFOcWkYbBt85aoxGsRnrgUAFt+x+W
	SZ/W+DPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFBRc-009yJz-2A;
	Mon, 18 Dec 2023 11:05:56 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFBRZ-009yCJ-0T
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 11:05:54 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VylMRHC_1702897533;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VylMRHC_1702897533)
          by smtp.aliyun-inc.com;
          Mon, 18 Dec 2023 19:05:38 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
Subject: [RFC PATCH 0/3] *** use rdma device capability to limit queue size ***
Date: Mon, 18 Dec 2023 19:05:30 +0800
Message-Id: <1702897533-49685-1-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_030553_371772_406BC358 
X-CRM114-Status: UNSURE (   6.27  )
X-CRM114-Notice: Please train this message.
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

Hi guys,

Currently, the queue size if nvme over rdma is limited with a depth
of 128, we can use rdma device capability to limit it.

Guixin Liu (3):
  nvmet: change get_max_queue_size param to nvmet_sq
  nvmet: rdma: utilize ib_device capability for setting max_queue_size
  nvme: rdma: use ib_device's max_qp_wr to limit sqsize

 drivers/nvme/host/rdma.c    | 14 ++++++++------
 drivers/nvme/target/core.c  |  6 +++---
 drivers/nvme/target/nvmet.h |  2 +-
 drivers/nvme/target/rdma.c  |  9 +++++++--
 include/linux/nvme-rdma.h   |  2 +-
 5 files changed, 20 insertions(+), 13 deletions(-)

-- 
1.8.3.1


