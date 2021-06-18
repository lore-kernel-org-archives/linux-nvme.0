Return-Path: <SRS0=tf27=LM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B55C48BDF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 14:02:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B776120A
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 14:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B776120A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8KE+Gpv7vDaYH7r+SVscjUkUtpK64mDC4YvCv7CP5yk=; b=ThRvOSbMufMMMG
	LTa9BmIPoYZRaCIdwM7hw27xoKoSXZ+RswO5nyoAZPts2H+QWvNNZ2lFRmy9bnFnkbSZL/JNUx7Mf
	qrdsKNOD0tXmGOtRzwd7z9PBKSPl9oWCG8skv+sNzyNOeNUdAobkEsbCjxIwOq/EXHdCjuAutZ5H2
	30CWR944mHSZJlfL8+PKjx7AnqWf5rL2AvPx4NMbEOyzthAqh/DgakV3y4CkEvQ3hM2i5b+nABKPn
	fxa/Luv8wGG96L4rvaJGrmN4h/oXyMWJmhyOVq9ZKSFLajeVhy4bbumFQwbqVbt0RQl9ayn7Rv5b4
	U03j1dGAZC2jIVktK5Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1luF4I-00EP8e-LS; Fri, 18 Jun 2021 14:01:58 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1luF4F-00EP6s-99
 for linux-nvme@lists.infradead.org; Fri, 18 Jun 2021 14:01:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D8BE068D08; Fri, 18 Jun 2021 16:01:47 +0200 (CEST)
Date: Fri, 18 Jun 2021 16:01:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Jeffle Xu <jefflexu@linux.alibaba.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 13/16] block: switch polling to be bio based
Message-ID: <20210618140147.GA16258@lst.de>
References: <20210615131034.752623-1-hch@lst.de>
 <20210615131034.752623-14-hch@lst.de> <YMliP6sFVuPhMbOB@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YMliP6sFVuPhMbOB@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210618_070155_512934_CD62FD96 
X-CRM114-Status: GOOD (  15.04  )
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

On Wed, Jun 16, 2021 at 10:30:23AM +0800, Ming Lei wrote:
> Not sure disk is valid, we only hold the disk when opening a bdev, but
> the bdev can be closed during polling.

How?  On a block device the caller needs to hold the block device open
to read/write from it.  On a file systems the file systems needs to
be mounted, which also holds a bdev reference.

> Also disk always holds one
> reference on request queue, so if disk is valid, no need to grab queue's
> refcnt in bio_poll().

But we need to avoid going into the lowlevel blk-mq polling code to not
reference the potentially freed hctxs or tags as correctly pointed by
yourself on the previous iteration.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
