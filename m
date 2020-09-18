Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67279C43463
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 18:39:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF4521534
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 18:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="thVz7W+H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yRQhO426"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF4521534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BFFA38Tmzy/3G28XYfO82MU/GQ57ciBmnnHf527z/Aw=; b=thVz7W+HqvWhYd0mOIk7cpPMU
	3QSgrdhhRyb+zdPeqjUL0rc0fvwAISgBc/qzLpkx8o/yCM2AmUMzPp/7I4A3a85EJpiyALqppqSEY
	CkFaHstuKZxhM/Zisc/ikd0YHBtePxVZQM7CbhQ2QyDcf69kOFENeOCtdDcImZxYYdopkkI8iC44T
	0DBelk0TuUSx4rQyenKLBB2RrfC9snYLzrLpiFbKDJe0RPvYymPv3QqqFQK3iP6AGIU8/OOCUNWm9
	C79aZN0KwqOp0/BgsFOWyh923kKxzRKYRpbgQUyj+dVQy7GrA2R+Qtmd0h8UWCcepCNv2pUHecD+S
	9iu9BCY2A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJLHm-0006CB-MW; Fri, 18 Sep 2020 18:39:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJLHk-0006Bm-QP
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 18:39:05 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2170421534;
 Fri, 18 Sep 2020 18:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600454342;
 bh=eQ/mXtuCe+QeGTc/RHYTchYYCdqA6wa/fyMARmJkKYI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yRQhO426pkSn/S1aW1IFu5mAljw7OTAJ7e2YYg4sKk/I02XDBTab9dLY4Dl/AaUU3
 sL1kHZ3tuieW5XOvQQiX5uXyXVB4WsTKsViE6yn6MisLANKeeDXlx/8ndAVd91Eqtm
 lZ2s979pBBxWqn4eD7/EnsoEVjPFKsIUE8wFPYiM=
Date: Fri, 18 Sep 2020 11:38:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Tong Zhang <ztong0001@gmail.com>
Subject: Re: [PATCH] nvme: fix NULL pointer dereference
Message-ID: <20200918183859.GA4030639@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200916153648.5475-1-ztong0001@gmail.com>
 <20200916165433.GA3675881@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4B-KpRvFuf+5YR4iOqNzic=fuYm=_seqwLoLp9+_xOqdA@mail.gmail.com>
 <20200917171437.GB3766534@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4Bj3BqYt-J=YqWKMWLFxDaMwQa4qAqPibyikpX5FBSzRQ@mail.gmail.com>
 <CAA5qM4ADbaO25t7GzC7jqB_jamHgegUyuNMvpo5h1+h=rir2mA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAA5qM4ADbaO25t7GzC7jqB_jamHgegUyuNMvpo5h1+h=rir2mA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200918_143904_935731_3FEC85E7 
X-CRM114-Status: GOOD (  19.13  )
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
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 17, 2020 at 11:32:12PM -0400, Tong Zhang wrote:
> Please correct me if I am wrong.
> After a bit more digging I found out that it is indeed command_id got
> corrupted is causing this problem. Although the tag and command_id
> range is checked like you said, the elements in rqs cannot be
> guaranteed to be not NULL. thus although the range check is passed,
> blk_mq_tag_to_rq() can still return NULL. 

I think your describing a sequence problem in initialization. We
shouldn't have interrupts wired up to uninitialized tagsets.

A more appropriate sequence would setup request_irq() after the tagset
is ready. It makes handling a failed irq setup a bit weird for io
queues, though.

> It is clear that the current sanitization is not enough and there's
> more implication about this -- when all rqs got populated, a corrupted
> command_id may silently corrupt other data not belonging to the
> current command.

The block layer doesn't do anything with requests that haven't been
started, so if your controller completes non-existent commands, then
nothing particular will happen with the rqs.

If the request had been started and the controller provides a corrupted
completion, then the fault lies entirely with the controller and you
should raise that issue with your vendor. There's no way the driver can
distinguish a genuine completion from a corrupted one.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
