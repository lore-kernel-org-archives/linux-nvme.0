Return-Path: <SRS0=oVUq=4U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C47C3F2D1
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2020 22:02:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2510620848
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2020 22:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GKw4MhXX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvP8NxNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2510620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WsxWfnNeypt9NICo2qu38TI5Tk/ZG5endO8POxFFa3w=; b=GKw4MhXXRGMn0C
	e/djzPNxr7aknVanOOqc+Bxnp23Ga+8EXzrc1qjUphJOlMSnqcJGwUmP70TCBS8Tfgg75N4H6QpR0
	UbwtynNeKNW6zE/kZXPOsMJD3xaaMJ/+6wJaARp+47bsBNRRnfJjKXJBW6GEimxPh3jruywZd+jtW
	JjZ3RR2pvBrpzPiBnz4x3dPiJZvFHM9buLkcomY5qxDbAldC7p1lbVkPsIvweCT/xjfGeBa/lLWYr
	esrZbd28R/DmwRwBsCu/DGZ4nLuYQKDKfLVNpOdkv5xaNPMLevzgMNoLjoHJZ+bKKmdkKyRG8N2AD
	yvU7HdYXk2gOeJ+MyWNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9Fct-00012k-PN; Tue, 03 Mar 2020 22:02:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9Fcr-00011h-29
 for linux-nvme@lists.infradead.org; Tue, 03 Mar 2020 22:02:54 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1FB2920848;
 Tue,  3 Mar 2020 22:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583272972;
 bh=HSQRJP3KSvC/KIrOlVjd0RML3XWoJX2YZfIRsQwxSB0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MvP8NxNMn9ZmP58Tncs5HZmmUYtvCx6yR+iNKPIpUy1350U8oXlYnW4x/Zx5DoLyM
 d+FDG6BSxDuNO6o8RyjjYIJyjgB5nsuoGF7uJlrdfo6r1jk/QvF/zUP0itfEx+3i21
 G2HAQSGIJn6hjSybnviJcj0jD13ghBEYo+RCObYg=
Date: Wed, 4 Mar 2020 07:02:46 +0900
From: Keith Busch <kbusch@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: "I/O 8 QID 0 timeout, reset controller" on 5.6-rc2
Message-ID: <20200303220246.GA20545@redsun51.ssa.fujisawa.hgst.com>
References: <20200302020339.GA5532@zx2c4.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200302020339.GA5532@zx2c4.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200303_140253_123130_9582DA12 
X-CRM114-Status: GOOD (  12.14  )
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
Cc: linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Mar 02, 2020 at 10:03:39AM +0800, Jason A. Donenfeld wrote:
> Hi,
> 
> My torrent client was doing some I/O when the below happened. I'm
> wondering if this is a known thing that's been fixed during the rc
> cycle, a regression, or if my (pretty new) NVMe drive is failing.
> 
> Thanks,
> Jason
> 
> Feb 24 20:36:58 thinkpad kernel: nvme nvme1: I/O 852 QID 15 timeout, aborting
> Feb 24 20:37:29 thinkpad kernel: nvme nvme1: I/O 852 QID 15 timeout, reset controller
> Feb 24 20:37:59 thinkpad kernel: nvme nvme1: I/O 8 QID 0 timeout, reset controller
> Feb 24 20:39:00 thinkpad kernel: nvme nvme1: Device not ready; aborting reset
> Feb 24 20:39:00 thinkpad kernel: nvme nvme1: Abort status: 0x371

Sorry to say, this indicates the controller has become unresponsive.
You usually see "timeout" messages in batches, though, so I wonder if
only the one IO command timed out or if the controller just doesn't
support an abort command limit.

You can try throttling the queue depth and see if the problem goes away.
The lowest possible depth can be set with kernel param
"nvme.io_queue_depth=2".

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
