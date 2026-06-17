Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9012FCD98E4
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2026 11:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Kuyum3ZOu8vyChyP0CCx3KwpwUBf1l9eT41x3JiJcS0=; b=MUHl4sRsLzCCBIeEbhEY/CzM8F
	6Z+uULUNlRDXRk7+jP5X6V3goONkRMDk9/oUkExqzoI/xeLvyc9ZNqXx7KaZdWAMGhSwzXLAjRPah
	ELIjsd+DVW00h2j91QnvsHYweFMJ+2/Oohoac+nywE6Pp9sI4Oek+ah29Df6MMecV9GBwgsC2LnFx
	D7TB+N5YhtsZIF7Y7K+OiixFOFBquoUg9LxO3hig4ZX/IgMmJHODvnJQVNQp3QBBMlarTZxjNjaSh
	SyZWdPCYdMCF5eaDIGwfKaX0ewTMy3wmPbX/pbdE6akD8N+Uw3Tga7AzQlNZ1WAOWCyzBcc/fvshp
	nNOqCDlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZoiu-0000000HFzQ-43ND;
	Wed, 17 Jun 2026 11:46:24 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZoir-0000000HFxs-1IJr
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jun 2026 11:46:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781696772; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Kuyum3ZOu8vyChyP0CCx3KwpwUBf1l9eT41x3JiJcS0=;
	b=yYW2ohtZ44g5MnXXo/kgMIBc6zZy/yx2ifnsxPu1PTNmVi9FoPkY6m69lnwp7PpkT9f0tYu+juIqDUA7v1/jrZgHwE25SatERCYaBDP23p125Om7pGzN6jOjj1Qd+SpHrpYCyVNdq7PPFxSI2BKlKOXXiflivysYiSEOJAb/gO0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X53e-Rv_1781696763;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X53e-Rv_1781696763 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 17 Jun 2026 19:46:08 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	onathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-nvme@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 0/2] nvme: Introduce service-time iopolicy
Date: Wed, 17 Jun 2026 19:45:57 +0800
Message-ID: <20260617114602.2224074-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_044621_931053_B33229DC 
X-CRM114-Status: UNSURE (   6.39  )
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

Hi all,
  I developed the service-time iopolicy in nvme native
multipath, please review, all comments are wellcome.

Guixin Liu (2):
  nvme-multipath: add service-time I/O policy
  docs: nvme-multipath: document service-time I/O policy

 Documentation/admin-guide/nvme-multipath.rst |  31 +++-
 drivers/nvme/host/multipath.c                | 165 ++++++++++++++++++-
 drivers/nvme/host/nvme.h                     |   6 +
 drivers/nvme/host/sysfs.c                    |   5 +-
 4 files changed, 202 insertions(+), 5 deletions(-)

-- 
2.43.7


