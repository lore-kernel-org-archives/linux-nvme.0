Return-Path: <SRS0=oc1E=F3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110C5C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 15:49:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C1521D79
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 15:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C1521D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M2RWcluywyqhxdL28TLUWYtEJB3Tke83lttOzmvh51I=; b=b7a3lDMWp61gxMCZkEyjY4Cad
	DqCnwSlAYr10CgIrkTm4NGtoF7Y3SdA79flDg6Q6LRF2oUN57n3oowj9YERi0gvSIJ+T5XR5jRJ19
	jze1LSFOn/Kex7xT5bpupsj8x1DkAWsb6HgnsNORbfHmuemQ9z41UTbSJjLT/2KOIFhZZimdS4T4C
	BhCa4fFAJ0WksUb1IxMwXwCuQYeBQTNtJQSehBQ6oKmwoI7A4W7hvkqCjuwY7ZYzqPxUBjsD67gDF
	RDA4/C36kQAwsbRMms5mNbmyPd78Qx6ea6bP9BF8d6IcKQViBduVIfhOUL7OU9w/A6+HWmnCnTnAD
	HQym3gh+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ks6O1-0001UU-0L; Wed, 23 Dec 2020 15:49:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ks6Ny-0001Ta-OH
 for linux-nvme@lists.infradead.org; Wed, 23 Dec 2020 15:49:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0B65E67373; Wed, 23 Dec 2020 16:49:05 +0100 (CET)
Date: Wed, 23 Dec 2020 16:49:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [RFC] nvme: set block size during namespace validation
Message-ID: <20201223154904.GA5967@lst.de>
References: <20201223150136.4221-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201223150136.4221-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201223_104910_907786_324A7AFE 
X-CRM114-Status: UNSURE (   8.24  )
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
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

set_blocksize just sets the block sise used for buffer heads and should
not be called by the driver.  blkdev_get updates the block size, so
you must already have the fd re-reading the partition table open?
I'm not entirely sure how we can work around this except by avoiding
buffer head I/O in the partition reread code.  Note that this affects
all block drivers where the block size could change at runtime.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
