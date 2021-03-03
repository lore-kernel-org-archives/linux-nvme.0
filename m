Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78759C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 18:52:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F9AC60295
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 18:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9AC60295
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=v4EJDLTu8NxcuCtq8Cuam4lPDf9Y7lFAuoq2gH6I9cE=; b=Xtm2C6PEzB4fPywxRfTeYHtmBI
	tiZqygr7WAgSqBdYltOyB+Qq/fQ401PU7nuVt7VILTmIvURlzDoT6BRBiMBSQKnvHxa7Ie+XN5yAG
	9uvFUJAw/FLrIhPqOofweL0dqWI9jxqHFZHANZw0lLVQKicI5MoRYvtyZfEOBWgtXiqkD7/OZoJKi
	YMwH7mJ+XLht/l3CFfjtwTTOyq08iOonPc4EuFK1E2Fxx6l0ch4jPALz7ljSVQHKVtS4qSA6947b+
	t8B+Agwx5b2LqnSoi6uEpSK5YmsnpvrhcFFjgrH+28lhe5ffJA53QSqoRAVeDNen2QoyjF0NBUDRC
	Ha0kjXsg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHWbW-00665U-KW; Wed, 03 Mar 2021 18:52:14 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHT1s-005HVZ-De
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 15:03:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Date:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=YskKaysoFKBlmCZn4q0T21VeMS7fIAXadw3vtRH9R74=; b=O5U1Wd2yFhfN/5tDVWq21D4hve
 VOlPSxSNP0HzC+shHNuHcyqXRXcnqMyDnRp0bT5uvOenanq95dvu+YB02Qo4dl8v1JRz01GAc9K1n
 W3VIkC3XyuwUeqqilOuO8dOZqSERv4z+EgZ/GokrCuIe50BRdEyXxI3B7523/Yceyuy3XxyCrSh+c
 yvAplUqIBOj3v/B6wjik1/kBG6nv3Z1Wm29hEkH+HvztKq+xS3ZLz0VGJHpZ7LPblYAUAhsjLp3Kb
 51x670A2NSRYhVdG+o3W0XpmUaxUBnhivtZV95TDY/tcekirGJWtVySOH38eK2yhkvvs5jag6vLv5
 iwdLMjDQ==;
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHHe9-00130P-Pw
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 02:53:58 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Dqz6w1XyJz7kNY;
 Wed,  3 Mar 2021 10:52:08 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Wed, 3 Mar 2021
 10:53:48 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>
Subject: [PATCH] nvme-fabrics: fix crash for no IO queues
Date: Wed, 3 Mar 2021 10:53:48 +0800
Message-ID: <20210303025348.32133-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_025358_266836_D93D427B 
X-CRM114-Status: GOOD (  10.05  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A crash happens when set feature(NVME_FEAT_NUM_QUEUES) timeout in nvme
over rdma(roce) reconnection, the reason is use the queue which is not
alloced.

If queue is not live, should not allow queue request.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/fabrics.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 733010d2eafd..2479744fc349 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -189,7 +189,7 @@ static inline bool nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 {
 	if (likely(ctrl->state == NVME_CTRL_LIVE ||
 		   ctrl->state == NVME_CTRL_DELETING))
-		return true;
+		return queue_live;
 	return __nvmf_check_ready(ctrl, rq, queue_live);
 }
 
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
