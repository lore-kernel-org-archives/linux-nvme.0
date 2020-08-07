Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD3BC433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 09:06:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589262177B
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 09:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DnkF40Cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589262177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kRADkb5yqtk/RTmcYKwL6D0Y/rimmAmMVDJ3GgPuGow=; b=DnkF40CvuRDc24p5JSqcGFHmCF
	WwLTholkZNdzDCKkmBrbGiEJ2cN9TyH+Fd5WQd/J7TWWrNONIjEqGue7vmtzCv87zmajATxnympvY
	zH8frdzhPPVULUM20A00Y4wur6oBIvfrZoHufngkJk4GouMybOdgBaodiiADGHzSMTZK4AunEzDIX
	jObnjIaF/PpoW4kFXW4DaNh79DPy4Psyj8Fiad97SiUkPkPDstNHy0jbXx+TUckjidvvfG5Z4C3mi
	LW5qD3488Fgw/Zc6xETqa9EeAaxOGngpjFI+WQ4zB1yhRmeXJr5y/umCfgH5evKP1CemGXhQceFcZ
	shmSHhcg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3yKL-0008Ip-K0; Fri, 07 Aug 2020 09:06:13 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3yKJ-0008Ha-3K
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 09:06:11 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 889B452B4EBCE571D88B;
 Fri,  7 Aug 2020 17:06:07 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 7 Aug 2020
 17:05:59 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
Subject: [PATCH v2 0/3] reduce quiesce time for lots of name spaces
Date: Fri, 7 Aug 2020 17:05:59 +0800
Message-ID: <20200807090559.29582-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_050611_382452_44FCEF3D 
X-CRM114-Status: UNSURE (   7.50  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, lengchao@huawei.com,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_stop_queues quiesce queues for all name spaces, now quiesce one by
one, if there is lots of name spaces, sync wait long time(more than 10s).
Multipath can not fail over to retry quickly, cause io pause long time.
This is not expected.
To reduce quiesce time, we introduce async mechanism for sync SRCUs
and quiesce queue.

Changes from v1:
- add support for blocking queue.
- introduce async mechanism for sync SRCU
- introduce async mechanism for quiesce queue

Chao Leng (3):
  rcu: introduce async mechanism for sync SRCU
  blk-mq: introduce async mechanism for quiesce queue
  nvme-core: reduce io pause time when fail over

 block/blk-mq.c                | 28 ++++++++++++++++++++++++++++
 drivers/nvme/host/core.c      |  7 ++++++-
 include/linux/blk-mq.h        |  2 ++
 include/linux/rcupdate_wait.h |  6 ++++++
 include/linux/srcu.h          |  1 +
 include/linux/srcutiny.h      |  2 ++
 include/linux/srcutree.h      |  2 ++
 kernel/rcu/srcutiny.c         | 15 +++++++++++++++
 kernel/rcu/srcutree.c         | 26 ++++++++++++++++++++++++++
 kernel/rcu/update.c           | 11 +++++++++++
 10 files changed, 99 insertions(+), 1 deletion(-)

-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
