Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F034EC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 03:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z73FKWerI4bxgvYG03ODrVw4LdOlyRkskk4smD8dqeA=; b=PwTvO8OVWeiaAShbsV7lUwMo0F
	Fc0RHA7ExwhKFSzWKzySrI3Kywdwz2+ueDNCTtdnDxibLXvkIY4VnCH9LvcK4YNuSb/GhpyhOXtCR
	YCe9R1PvMl2gwR522y1vqC0087EdEO4Kcac/bL8ZZZNQ+RWorQEvTFxVWkv8ZmEGBwpUbJNCn9Bnq
	VKUS8SiFsjTVKVofol8lwCTVG2PRV8AWlt1btF/iBE8Gg3lCAOO4LdmOP7r4/pwCHIo4bt+5zxJBR
	Cd+pkI3gjE0c0AIZCllYLX+g6VArnG88PZ/ycb5Kt27w0P43bQcbV5xIj/JprBNKJdigWjVZleya1
	D/tGAeFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olMdA-00A3UC-Fo; Thu, 20 Oct 2022 03:54:04 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olMd7-00A3SL-Ay
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 03:54:03 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MtD9Y26w3z1P77b;
	Thu, 20 Oct 2022 11:49:05 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 11:53:49 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>,
	<lengchao@huawei.com>, <axboe@kernel.dk>, <ming.lei@redhat.com>,
	<paulmck@kernel.org>
Subject: [PATCH v2 0/2] improve nvme quiesce time for large amount of namespaces
Date: Thu, 20 Oct 2022 11:53:46 +0800
Message-ID: <20221020035348.10163-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_205401_566022_284AA5F2 
X-CRM114-Status: UNSURE (   8.80  )
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

Now nvme_stop_queues quiesce all queues one by one. Every queue must
wait a grace period(rcu or srcu). If the controller has a large amount
of namespaces, the total waiting time is very long.
Test result: the total waiting time is more than 20 seconds when the
controller has 256 namespace.

This set improves the quiesce time when using a large set of namespaces,
which also improves I/O failover time in a multipath environment.

We improve for both non-blocking tagset and blocking tagset introducing
blk_mq_[un]quiesce_tagset which works on all request queues over a given
tagset in parallel (which is the case in nvme).

Changes from v2:
- replace call_srcu to start_poll_synchronize_srcu
- rename the flag name to make it accurate.
- move unquiescing queue outside from nvme_set_queue_dying
- add mutex to ensure that all queues are quiesced after set the NVME_CTRL_STOPPED.

Changes from v1:
- improvement is based on tagset rather than namesapces

Chao Leng (2):
  blk-mq: add tagset quiesce interface
  nvme: use blk_mq_[un]quiesce_tagset

 block/blk-mq.c           | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c | 57 +++++++++++++++---------------------
 drivers/nvme/host/nvme.h |  3 +-
 include/linux/blk-mq.h   |  2 ++
 include/linux/blkdev.h   |  3 ++
 5 files changed, 106 insertions(+), 35 deletions(-)

-- 
2.16.4


