Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC97C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 13:21:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734B123437
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 13:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734B123437
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ht6Tys46hozgCWaC7ruIpDJs3e6OuTzTWi6qOgW873A=; b=TArWmnrIqY92c/aVMXNQMPJ9JC
	vfgIuJf4lq0J+O+BowpGOQuWdDmNyUx0f+WeWH6R0XZ8LBvSj+cnl1aVtcxrPdQ0+UJgd0zrjiQ8n
	hqZrzKFVRu/tAaydJM8bEBSWqsjg2rKfptqO9tTrlMO3DwT+e5S54I/br9gPXXd6PTZg8jQsTfAAX
	1t8O/FCD9dfLy6IomPfTEdataBPazOAEi1dUArxyaJewCHKOjrS8++KnEXcamaxMcnLRsCBdERh8z
	BMf+lzv5G6lnLnfYq0TNVbGeFe6hfE/cX5gl7JkNlSmVmGZK1DdWgo4hLeQj28SN8trVEXvwsoB+w
	Iazj8d9g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmGSO-0005ts-FF; Mon, 07 Dec 2020 13:21:36 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmGSM-0005tT-4v
 for linux-nvme@merlin.infradead.org; Mon, 07 Dec 2020 13:21:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=W03PdcPB+vlMKGBqYsRRQuyZ1LSfMAxcuv9MFZzn4hQ=; b=jiyUndFtmZvRKMeXuCrruwaWhp
 Z95eJKehelQPebCoVeQCAkPPP6sBjAgZS+IWgJz7aMmumtD3tYZSApO4tJrh0hPh6fAnbBTZO43BH
 PqglVpskWlGYk+LRdE5mEPHxyaYYOGBeXJbDCrg0Aza5Fo/Ux7JL+FeloCrY7E3aVRQ9obroifmms
 hsJ9hlOmXVGH80n6cFJZdIicb/ltvLUCUdaXQVw+UHKB/+9ezcqsUmy3S+STWHgPE0bYl0P38lf8A
 q2IEXd8pY2mLt+BnlSxwP7TxtP54KARfzrDrStVke5Cw6LchV/p76FGQ3jvsF/Q5GXntrYt1xCD9P
 igM/Dsrg==;
Received: from 089144200046.atnat0009.highway.a1.net ([89.144.200.46]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmGSH-0006Oq-U3; Mon, 07 Dec 2020 13:21:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: split hard read-only vs read-only policy v2
Date: Mon,  7 Dec 2020 14:19:12 +0100
Message-Id: <20201207131918.2252553-1-hch@lst.de>
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
