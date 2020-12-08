Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746BBC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 16:30:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99A223AC8
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 16:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99A223AC8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nV8LXq71hx91fMMZLMkFMSCrVBrflEGidNF5xbFHFqw=; b=j7m+oIfPnJseB+c3p65qLpLwMf
	DBbXncf6wmLVh++OLP2VCvLY1iwIvlrKWBbOhuQ7140mcTTOiFOL7TrdY8D/xtqSkwJogBU8PnkDl
	lPQ/f1qNeap1GZ04f1WNt4EgJUU8qT2dOKQtlexESkLWTi9t5x/KZTIfRd4GGMW+iE5vNXG+jDbfZ
	VvclaZH4L2T1YfRFn8xvP5KVA59nTKMfB0fdiYFQMDHjLTHHtDfA/qHvJm8uK7GxOu0sfBmkQjcxU
	bKPsgWTncgMd2Gh8IEDTQnwdLpvjnYGICCxJoXoBiTAO3PMT71oZYyELOL1JuyaxZBT2VjEEa/Hig
	Lff40xKw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmft5-0000oO-Iz; Tue, 08 Dec 2020 16:30:51 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmft3-0000o9-Fd
 for linux-nvme@merlin.infradead.org; Tue, 08 Dec 2020 16:30:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=tk49uTd1GaXg7LbiRUxBP5Y/ceJT7HmrtRb4yzgC7VM=; b=s5apwAVNlLEMa6cM1nAlCU9QOr
 HpaUvcHRCo9Um44Ccv3X2MIbD6cV9z4y+nDP5l9XGJW2iGXdCWFr80CZRUN7cQxBruZ9KW78HG4IB
 fDNl/mNyIUPgKdgbtNV5Y90ECQ/Vf4Z+gW3FWXHyFWDM100/vJ8KXYTwAI6Ex5OrsRrvoTPkAYDrH
 fVKs4QmYZAuU0SIa5R34KSCvbF+PnyxhdqZsDMPW6W9EBJ75Old1waC95Vg+16bY0+volWZvYF/Tv
 /gk2WsDrZHTdiuy+gt5XhhdiebNQMSUgR41FC3yTCRmpNzaS+lo7+EEHXcXGBphBtrrMr8ac9gngO
 FMDshcRQ==;
Received: from 089144200046.atnat0009.highway.a1.net ([89.144.200.46]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmfsw-0000wg-4R; Tue, 08 Dec 2020 16:30:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: split hard read-only vs read-only policy v3
Date: Tue,  8 Dec 2020 17:28:23 +0100
Message-Id: <20201208162829.2424563-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@redhat.com>,
 Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Jens,

this series resurrects a patch from Martin to properly split the flag
indicating a disk has been set read-only by the hardware vs the userspace
policy set through the BLKROSET ioctl.

Note that the last patch only applies to for-next and not to
for-5.11/block.  I can hold it back for the first NVMe pull request after
Linus pulled the block tree.

A git tree is available here:

    git://git.infradead.org/users/hch/block.git block-hard-ro

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/block-hard-ro

Changes since v3:
 - rebased to the latest block tree
 - indent commit log lines starting with a "#" to make sure git commit
   doesn't eat them

Changes since v2:
 - fix a few typos
 - add a patch to propagate the read-only status from the whole device to
   partitions
 - add a patch to remove a pointless check from bdev_read_only

Changes since v1:
 - don't propagate the policy flag from the whole disk to partitions
 - rebased on top of the merge block_device and hd_struct series

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
