Return-Path: <SRS0=M7ZW=NH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39AEC4320E
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 13:20:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C53A6329B
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 13:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C53A6329B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5jLORe1mFm8I8+q2an5Ygtom9TJKT1MMnB7O86r//Q4=; b=WnKHAiilGpVmd6
	5SQGMohFtMsLGMD/c4VgBzQAjfaqngXFbVW9ZQ/PP/qB/hmyBzf22t68vDK5y/5NOA0HYAuAes+4K
	r0n36B5c6hElZ5FEHr/T53znLXdzF7r4/5PeTcEJNdt0z+gyPAzG6QuffM/KjAIG3uwaMINeQAnBB
	O9VNiB/b7Ml6lL4bTxH5BPvtP5Nya/r7jzaz/7drpEWKqV47RsIg+eU80V3otI0nBW4DMXHhVSsd5
	aquNPkJm4jGtUy6TavQjg39iNSn4wjNNg0FBDrkfz14bUwWt0Vou/kqvG0LUM4mo1fKkl9F/AzGWx
	w+rCIu3rUXmziqWgyrvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mFcWt-00H4du-9P; Mon, 16 Aug 2021 13:19:51 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFcWs-00H4dm-1t
 for linux-nvme@bombadil.infradead.org; Mon, 16 Aug 2021 13:19:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=WrmoQ8Kp3XO7sv0E/Vt68M24WtgLki2ksIFJXIBFGrE=; b=sKevCjd4WMSoqB+bP3aS+IEo7d
 nSLie8iOwyZEVhvTLgmVIGfcbxq2+KZbHtbvhKQCVaCX5t5IVbmowLoyzLOYEu5NrRX3gtAomlfyj
 PMTMFUuGH9lvbNOxrMVkLvoWR11oZN37yPhVRsh5M6jdVAOu6QSb3klEfGYwOlhtIQHUYndIdAoei
 WwvVAE1gUZgz+Wz4Q4jlAxMORhgriM8G0XubGpA516e06UzoOK73UrFvHmDPsT2cSRBZADcBAj7e7
 5+PFktdSB6e9MyiLZD6YHkM6E/nOPseaUzhmWZEP6nwpbJRmypdh66FCcZciU+NLCksusRDnwB4+O
 D/EolM0A==;
Received: from [2001:4bb8:188:1b1:3731:604a:a6cd:dc60] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFcWG-001OSC-41; Mon, 16 Aug 2021 13:19:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Doug Gilbert <dgilbert@interlog.com>,
 =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
Subject: ensure each gendisk always has a request_queue reference v2
Date: Mon, 16 Aug 2021 15:19:01 +0200
Message-Id: <20210816131910.615153-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

Hi Jens,

this is the final batch of the gendisk interface cleanup series.  This
remove the last uses of the legacy alloc_disk interface and ensures we
always have a request_queue reference for a gendisk.

Changes since v1:
 - rebased to the latest for-5.15/block tree to fix minor conflicts
 - add a new patch to fix to fix a queue to disk look issue exposed
   by the bdi move

Diffstat:
 block/bfq-iosched.c             |    2 -
 block/blk-cgroup.c              |    4 +--
 block/blk-mq.c                  |    8 +++---
 block/blk-settings.c            |    8 +++---
 block/blk-sysfs.c               |   13 ++++------
 block/blk-wbt.c                 |   10 ++++----
 block/genhd.c                   |   32 ++++++++++++--------------
 drivers/nvme/host/core.c        |   33 ++++++++++----------------
 drivers/s390/block/dasd_genhd.c |    7 ++++-
 drivers/scsi/sd.c               |    6 +++-
 drivers/scsi/sg.c               |   32 +++++++-------------------
 drivers/scsi/sr.c               |    7 ++++-
 drivers/scsi/st.c               |   49 +++++++++-------------------------------
 drivers/scsi/st.h               |    2 -
 include/linux/blk-mq.h          |   10 ++------
 include/linux/blkdev.h          |    5 +---
 include/linux/genhd.h           |   30 +++---------------------
 include/trace/events/kyber.h    |    6 ++--
 18 files changed, 98 insertions(+), 166 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
