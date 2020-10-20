Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7A0C4363A
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 15:53:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 846EB22247
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 15:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OoajHwt3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSFY+JBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846EB22247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S2aJQl6/lNcuewY+Ykr4LqcWHMKQvkaZo10mfDX/QC0=; b=OoajHwt3aDX7OJ9eI5OkXCrZp
	bvI+noRGl2toPB8mNMOx2Ql8EkAbc6LZrrx/EV6lxU6Z8mqb4xGuvvNJW8tmMtX+4xEtxyqrEWmTA
	Jg3ErWX4anGKwbSFTw2kJBHe4zO0zqfH63UmQu5r/dTjnNUQbjazQyn6B8MpXXySy/EwtKZ9T1VAZ
	9jVQSD5xEVC+YAu9UYe86Drh0SO6D2ThobnD8zdJq2r7QYstOKZvIpv0g82AfTL/yhmZO/7orlC5Z
	YzKUvc0HpSzLRo/lsJQYFzRuGN3Chy+yyo9WXAsIu5SUXGGJdzEcmb1tOdCVUzXvidLy8ybw8Mpcs
	KZOKFqEKQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUtwt-0001oq-FY; Tue, 20 Oct 2020 15:53:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUtwp-0001nZ-NG
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 15:53:16 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 46B9622244;
 Tue, 20 Oct 2020 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603209194;
 bh=p5UeqLZ8O8JzWPLhqVWdJPRXE7tssr0zGVoCCuoiHMg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tSFY+JBgkVt7TcKErVzP9tQbS0GQu5hPdKx+CRkQM/AbyWFxXE2d+yep2L4EVvt3b
 WRth3qpMySttdXclVn7GbrFotArdr3nGzQ7+AJJugycZoU9ogT0rlz+APZb9tnmwLe
 32L/g8DUbfOAs0Ty4fi0XVvpL6Lz1vrNz7yuDxlM=
Date: Tue, 20 Oct 2020 08:53:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 0/1] nvmet: allow user to set req alloc flag
Message-ID: <20201020155312.GB1437971@dhcp-10-100-145-180.wdc.com>
References: <20201020014417.3604-1-chaitanya.kulkarni@wdc.com>
 <74e2bc85-3752-08fe-4f2c-07130ab4411d@grimberg.me>
 <a37ee655-c215-2354-4d55-267b11d92ae0@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a37ee655-c215-2354-4d55-267b11d92ae0@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_115315_843565_CF72DF07 
X-CRM114-Status: GOOD (  20.67  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 20, 2020 at 09:39:28AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2020-10-20 2:22 a.m., Sagi Grimberg wrote:
> > 
> >> Hi,
> >>
> >> When using NVMeOF target in the passthru mode we allocate the request
> >> with BLK_MQ_REQ_NOWAIT flag. This allocates the request in the following
> >> manner :-
> >>
> >> nvme_alloc_request()
> >>   blk_mq_alloc_rquest()
> >>    blk_mq_queue_enter()
> >>     if (flag & BLK_MQ_REQ_NOWAIT)
> >>    	return -EBUSY; <-- return if busy.
> >>
> >> On the NVMe controller which I've the fio random write workload running
> >> parallel on 32 namespaces with higher queue depth results in I/O error,
> >> where blk_mq_queue_enter() returning -EBUSY as shown above. This problem
> >> is not easy to reproduce but occurs once in a while with following error
> >> (See 1 for detailed log) :-
> >>
> >> test1: (groupid=0, jobs=32): err= 5
> >> (file:io_u.c:1744, func=io_u error, error=Input/output error):
> >>
> >> When the flag BLK_MQ_REQ_NOWAIT is removed from the allocation the
> >> workload doen't result in the error.
> >>
> >> This patch fixes the problem with the request allocation by adding
> >> a new configfs attribute so that user can optionally decide whether
> >> to use BLK_MQ_REQ_NOWAIT or not. We retain the default behavior by
> >> using BLK_MQ_REQ_NOWAIT when creating the nvmet passthru subsystem.
> > 
> > Why should we ever set REQ_NOWAIT at all? Nothing prevents the
> > host(s) queue depth from exceeding the controller queue depth...
> 
> I agree... I certainly found adding a configfs attribute for this rather
> off-putting. Why would the user want an option that turns on random errors?

Right, you really only want to use NOWAIT when waiting can lead to bad
things like a deadlock. I don't think the target passthrough has any
such issue, so you should be able to safely leave that flag out.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
