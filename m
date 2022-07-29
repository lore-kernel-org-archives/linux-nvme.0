Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563C0C00144
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jul 2022 07:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tF1sn2U7j17m/eeaLKlXm/pQsSxYhR4zDewOl20OXW4=; b=1PXnC0915mg3mHlUlVPY6xy9T0
	ZWlMRdKwSoWDqtVOAlbpiYvzZsFGgGZl7Cpr61vlrt5VvDAdfTRqKBND9X0JfsdLbkV4FAfDvdzpV
	4qklBWBWUTmuxuhuDkOz/2m2h72kiLTVsc4cvBL8rWPZC61BFnNxCD983obvxIfUanvbMA/U3wDgY
	bn6VhVkMoP9haUt7RIDt6UClrkpyVhwOgln94HAq5VUUNNu+k6lwERPGG4mkAGm/xcCN1K7P10i6y
	kIgN79regCLpTFdqLjgK89beBXcXl7Ctws0mhMqQ6GzLRYz+zQs4o3Cusojmeur0WDKWgxVoybb5Z
	T9aEFNKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHKbJ-002gpg-OL; Fri, 29 Jul 2022 07:40:01 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHKbE-002gjW-S4
	for linux-nvme@lists.infradead.org; Fri, 29 Jul 2022 07:39:58 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LvK953qmDzlWKt;
	Fri, 29 Jul 2022 15:37:13 +0800 (CST)
Received: from huawei.com (10.29.88.127) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Jul
 2022 15:39:48 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>, <axboe@kernel.dk>,
	<lengchao@huawei.com>
Subject: [PATCH 0/3] improve nvme quiesce time for large amount of namespaces
Date: Fri, 29 Jul 2022 15:39:45 +0800
Message-ID: <20220729073948.32696-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_003957_096245_25CFDC35 
X-CRM114-Status: UNSURE (   5.30  )
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
namespaces, which also improves I/O failover time in a multipath
environment.

Chao Leng (3):
  blk-mq: delete unnecessary comments
  nvme: improve the quiesce time for non blocking transports
  nvme: improve the quiesce time for blocking transports

 block/blk-mq.c           |  4 ----
 drivers/nvme/host/core.c | 60 +++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 12 deletions(-)

-- 
2.16.4


