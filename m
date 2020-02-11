Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08071C352A4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 03:00:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6B020733
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 03:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t1DkUVJo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="za1z/7A6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6B020733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KZiubkx+0HiYIFfhNgR8088afCY1Owf4ZVt7hPjjnTY=; b=t1DkUVJoaOg7Ok
	BSTqIxsyA0n19Z5KYcApaZID8b1of/pHD0lj+UG+GB/cBa3nDwH8SUwEgUe8BqsdqkV6ny8b+RQTX
	icy5MBMeFFa4ooJVWNIKojFsgOkRcQICHqMNcU1jsjY2PCBLEzeqt3esGlT86Tn6tfu71gkgBONU8
	e8CwGqCl2Q4EpzNzXG/ZjGg2WNbmfR3XEEvf3GV90FJbLs8gjH3UilE6cicAXo0L9auZfiPL25ByR
	eBFzEIe0WuD2pZ4Vma7iQpBA9rJYxD5oKRR9vohuVVBuA/NRtiNW0p/+Kf1thWuhr+Z9D4yWzo6cZ
	eZj0ZoL7Qjurm2isaHQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1Ln6-0002KA-M6; Tue, 11 Feb 2020 03:00:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1Ln4-0002Ji-3b
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 03:00:47 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 366232080C;
 Tue, 11 Feb 2020 03:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581390044;
 bh=4zMUHs57CTHoyJ1F0K+Lq85X5KbnxiptUwYeauzmw4c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=za1z/7A6dYca5RMrcu8K7B+/w9uohmeptcWDzXZ55TGHmkDdk5WK0GPPTUvxnWfdg
 s4e7ia7UHvt6kw5rrIWkJ+t2yCOMvc09XsqMNFgndEXsbbBjn3M+o0HF6cqR9FkHH6
 Nq9n+Ot0fFc3TnMp8IuAZwZIvfIx7SC0Vly3QHNc=
Date: Tue, 11 Feb 2020 12:00:37 +0900
From: Keith Busch <kbusch@kernel.org>
To: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH 1/2] nvme: move keep alive processing to nvme-wq
Message-ID: <20200211030037.GA20916@redsun51.ssa.fujisawa.hgst.com>
References: <20200206191342.10190-1-jsmart2021@gmail.com>
 <20200206191342.10190-2-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200206191342.10190-2-jsmart2021@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200210_190046_173633_9D632B20 
X-CRM114-Status: GOOD (  10.40  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Nigel Kirkland <nigel.kirkland@broadcom.com>, maxg@mellanox.com,
 mark.wunderlich@intel.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 06, 2020 at 11:13:41AM -0800, James Smart wrote:
> Delayed keep alive work is queued on system workqueue and may be cancelled
> via nvme_stop_keep_alive from nvme-reset-wq, nvme-fc-wq or nvme-wq.
> 
> Check_flush_dependency detects mismatched attributes between the work-queue
> context used to cancel the keep alive work and system-wq. Specifically
> system-wq does not have the WQ_MEM_RECLAIM flag, whereas the contexts used
> to cancel keep alive work have WQ_MEM_RECLAIM flag.
> 
> Example warning:
> 
>   workqueue: WQ_MEM_RECLAIM nvme-reset-wq:nvme_fc_reset_ctrl_work [nvme_fc]
> 	is flushing !WQ_MEM_RECLAIM events:nvme_keep_alive_work [nvme_core]
> 
> To avoid the flags mismatch, move keep alive work to nvme-wq.
> 
> Signed-off-by: Nigel Kirkland <nigel.kirkland@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>

Hi James,

I'd like to include this in the next 5.6-rc pull, but just want to
clarify attribution: the author should be the first sign-off, so
should I amend the author to Nigel or move his sign-off below yours?

Thanks,
Keith

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
