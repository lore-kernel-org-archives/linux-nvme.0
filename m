Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC08C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 09:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TqHUHQyMJpBsitEPeVDKoPpQjokyQCVptfwt8QI15lM=; b=zshVO6WmgvuZOpVUPb/gZEbn2t
	XcnMORcLJM0M+LRL4CYug5BA+E1Q4pCMJw2DSkKNKnpYhEQmUUOhRji2BiBkE/vJqBYzyt/EfxErm
	wAUGRCZyKRa7Z55khHMaKD+xDApwDdOJSSLsdgzxgGrRJy74+u6QQB2i7h4deomRGn6linEE/NFRx
	IH+cVDDub8fdB3l0zF4VeyxBs3ZPt+dJmPWbxQ3MzrMoPem31aCIcMhoxXHtzkWJRrbXVFi7NHRdJ
	+I1SBT37nZIFFu9XlQgKjnLztHaaoeujzGkmcsZqR50H0wFOy1taYsiV0dWfITxyHbX11gslxu4oQ
	PU28tSrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiulz-00BKTv-Kc; Thu, 13 Oct 2022 09:45:03 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiulw-00BKR4-VV
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 09:45:03 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mp4Hz5F3yzmV9Z;
	Thu, 13 Oct 2022 17:40:15 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 13 Oct
 2022 17:44:51 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<lengchao@huawei.com>, <ming.lei@redhat.com>, <axboe@kernel.dk>
Subject: [PATCH v2 0/2] improve nvme quiesce time for large amount of namespaces
Date: Thu, 13 Oct 2022 17:44:48 +0800
Message-ID: <20221013094450.5947-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221013_024501_220305_E4C97C9C 
X-CRM114-Status: UNSURE (   7.08  )
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

This set improves the quiesce time when using a large set of
namespaces, which also improves I/O failover time in a multipath environment.

We improve for both non-blocking hctxs and blocking hctxs introducing
blk_mq_[un]quiesce_tagset which works on all request queues over a given
tagset in parallel (which is the case in nvme) for both tagset types (blocking
and non-blocking);

Changes from v1:
- improvement is based on tagset rather than namesapces

Chao Leng (2):
  blk-mq: add tagset quiesce interface
  nvme: use blk_mq_[un]quiesce_tagset

 block/blk-mq.c           | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c | 42 +++++++++------------------
 drivers/nvme/host/nvme.h |  2 +-
 include/linux/blk-mq.h   |  2 ++
 include/linux/blkdev.h   |  2 ++
 5 files changed, 93 insertions(+), 30 deletions(-)

-- 
2.16.4


