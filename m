Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54422C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 04:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Be3+26XptxIgmQQhBiL/mWzc+JWO9oS3P5KTSt/Lrqk=; b=bk/qPbtHkOrGl6cbNWNQ1MqSZj
	jayyXReTWG/ZLgBJIM9e7Mhn30TbH7TJcKaWgn7pSs7UXTOQo/l8KtkPAfZa/hEuATPwhjhLdtCF0
	kK+S5mx6nPsyebYjJ3yLysFloWm5qOazmkickZHGJ1Fzi25jlMNDNq3/yCeJiXyY6S+lqB1EHjj7u
	JGKtRqq9UTYLX+Go3JRW7OQw3i76Eh+2h31dtlFfc7L86n4HScw6UCHYlzjFCAmrGr/AsVLeUCnsh
	/VdlDQeja+29qDp1iVL8UtRL6xi653ughyfaS/kNf5YZxfJmQur7nzqlDXtMQBwoW7MURgumuZWhO
	OEVR+Ivw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh1wA-007FBs-Ul; Wed, 20 Apr 2022 04:27:30 +0000
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh1w8-007FBI-1C; Wed, 20 Apr 2022 04:27:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: make the blkcg and blkcg structures private
Date: Wed, 20 Apr 2022 06:27:08 +0200
Message-Id: <20220420042723.1010598-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

this series cleans up various lose end in the blk-cgroup code to make it
easier to follow in preparation of reworking the blkcg assignment for
bios.  The biggest change is that most of <linux/blk-cgroup.h> is now
taken private into block/.

Diffstat:
 block/Makefile                |    1 
 block/bfq-iosched.h           |    4 
 block/blk-cgroup-fc-appid.c   |   57 +++++++++
 block/blk-cgroup.c            |  154 ++++++++++++++++++++-----
 block/blk-cgroup.h            |  138 +++++++++++++++-------
 block/blk-throttle.c          |    2 
 drivers/block/loop.c          |   12 +
 drivers/nvme/host/fc.c        |   26 +---
 drivers/scsi/lpfc/lpfc_scsi.c |    4 
 include/linux/backing-dev.h   |    6 
 include/linux/blk-cgroup.h    |  258 ++----------------------------------------
 include/linux/blktrace_api.h  |   10 -
 include/linux/kthread.h       |    4 
 kernel/kthread.c              |    1 
 kernel/trace/blktrace.c       |   26 ++--
 mm/backing-dev.c              |   19 +--
 mm/readahead.c                |    1 
 mm/swapfile.c                 |    1 
 18 files changed, 343 insertions(+), 381 deletions(-)

