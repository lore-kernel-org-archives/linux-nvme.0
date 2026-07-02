Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FF5C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 03:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QPgROVRGuG+gCcZ8cKbGbVQdvYb8W4tW6Cb7XIZMovc=; b=WCOPiJ+CvQRAGerzMF3yVDCFx3
	Ii6bTcqW5IuzRhKmkGTepyUx+rMafjio59mwzvSUxLY30Tajh+Q5W1S0ggVCeLi2mNkY4piVHt9Qi
	AFQ6rSXR9VHNaUblHAN4/LY23aDp8qW86sV7L1GGiTpIPk68T9QDWvJ+DNYUWyFt0iwVtugwgon19
	cK1hZD3aOSFfKYXME7bcxowlP9A5IN/oJWxsVxjnigFlvDtHCm0Jc4XA1qpawcGecfMz9vc6hhFCX
	89c2i16+238nRV3XHcJNt0UZ0r4mrR2YUf52tZs5nbnJJFjHevfc5mKvPhrEbdEnF7n1bOuiVgzyl
	iD2uJlFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wf8Q5-00000003WSe-14Ey;
	Thu, 02 Jul 2026 03:48:57 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wf8Q2-00000003WRQ-0Yoy
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 03:48:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782964131; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QPgROVRGuG+gCcZ8cKbGbVQdvYb8W4tW6Cb7XIZMovc=;
	b=Rt/dL1WvV+G5iXvwExLMXAPzOnt5b/CS2H5wex4bUe+ThpY1vGLFIZdM5CeyWjuhPKhSUx13d1CI4YEAMr1DO9F1zWextX+w3lRRgiogcugQgFCR5BRQLjCMPqdSOjWeuZRtpE531YwDTtihKq/Znj/GhLeIu9R1Abs7KAImFuA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6CdeCY_1782964130;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X6CdeCY_1782964130 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Jul 2026 11:48:50 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH 0/3] nvme: add ABI documentation for sysfs and configfs interfaces
Date: Thu,  2 Jul 2026 11:48:42 +0800
Message-ID: <20260702034845.3066876-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_204854_891311_992AA8E0 
X-CRM114-Status: UNSURE (   9.05  )
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

The NVMe host sysfs interfaces and target configfs interfaces lack
ABI documentation under Documentation/ABI/. This series adds the
missing documentation and updates MAINTAINERS accordingly.

Each attribute entry has been traced back to its original introducing
commit via git archaeology to provide accurate Date, KernelVersion,
and Contact information.

This documentation was created with the assistance of AI (Claude)
for git history tracing and document formatting.

Patch 1 adds Documentation/ABI/testing/sysfs-nvme for host sysfs.
Patch 2 adds Documentation/ABI/testing/configfs-nvmet for target configfs.
Patch 3 adds missing F: entries in MAINTAINERS for NVMe documentation.

Guixin Liu (3):
  nvme: add ABI documentation for host sysfs interfaces
  nvmet: add ABI documentation for target configfs interfaces
  MAINTAINERS: add missing NVMe documentation files

 Documentation/ABI/testing/configfs-nvmet | 347 ++++++++++++++++++
 Documentation/ABI/testing/sysfs-nvme     | 444 ++++++++++++++++++++++-
 MAINTAINERS                              |   4 +
 3 files changed, 785 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/ABI/testing/configfs-nvmet

-- 
2.43.7


