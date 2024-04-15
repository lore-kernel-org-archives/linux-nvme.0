Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019D8C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Apr 2024 16:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9yTW7BY1WRHxj9qXQ4APRkFZ8y1Q/Ynzz7GxZW9rM3k=; b=G6t1H5b+QI+DXWrOCZZUPPHc3K
	+M66fHN7x4QJjyCOa7tPdEsMtSGVqPrFx9TNhi7ELqlNSLmy7SHQvrS3FbaEF+PJBpvwEh2kkbzLn
	mnxCLq1WvqxijpDIbaWyP423VV1/VQW8h+6ITx2ijT1tRRa3VKZjbZZ6i9kmHoWI9Vro20aLsptOE
	M4ukAli9wAL94sClmGHczav+jrYqGbP/K22+/JAoYH+ApVoCErKOsrNye2uDZPZhgNNXWI/oX8oU5
	45cbJoBVBHAi976g6vUeqehilB9NCO8DDqXPw6WRzyFbPHpIrABK3IZ3RNC4Al5oEGJW5duqU700f
	GdmZj9Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwPcv-00000009AYK-0Hdu;
	Mon, 15 Apr 2024 16:56:17 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwPcs-00000009AXY-0oQo
	for linux-nvme@lists.infradead.org;
	Mon, 15 Apr 2024 16:56:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B7C92CE0E39;
	Mon, 15 Apr 2024 16:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6D6C113CC;
	Mon, 15 Apr 2024 16:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713200171;
	bh=1DiLZidZg1+2/QSnCHcehXCyYubSAg7C8mzi1aIlxXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQA8x55KIsSKyiCdHJmzLuxiOIw3RjKe7KDlNzW6Sifh/A5Rg/wWFUo+fogL+WbMn
	 9J6M2paD7IZHupmq22BfzZOo9RmANxynJwZjFVuWg01Y+A0Y25rJvcpRDh/ea5s/T5
	 fwLpXd3oy5Sk86dcqeknUCRhjEnqrd9WGJ99xXorB5fMND3GpFTgUWy9bu8E8Wjtt0
	 AOon3Qgt2rMZmBb4mCF3y3/tCUTKpuLMDXvw8Cy8kP71/Tm2ga+klxkGiax1oYSQ1X
	 MXyT438M5RoqaSKNrP7oLuLrogmZ55V+BNvHBuZm3yzYodXlpEL+JEUygKgYONITSp
	 LRxPWldubMsJA==
Date: Mon, 15 Apr 2024 10:56:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, hch@lst.de, gjoyce@linux.ibm.com,
	axboe@fb.com
Subject: Re: [PATCH] nvme: find numa distance only if controller has valid
 numa id
Message-ID: <Zh1cJwMo4cntWoHS@kbusch-mbp>
References: <20240413090614.678353-1-nilay@linux.ibm.com>
 <afcd5e05-f4af-40de-8d13-9bacf5fadd80@grimberg.me>
 <ffcfbe15-8e6f-422a-87cd-52c30ebf726c@linux.ibm.com>
 <81a64482-1b02-43b2-aacd-9d8ea1cea23c@grimberg.me>
 <7b188849-5c3f-45ff-9747-096ffdaff6ee@linux.ibm.com>
 <05dbae65-2cc2-40d7-9066-a83cdfdc47be@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05dbae65-2cc2-40d7-9066-a83cdfdc47be@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_095614_440484_D1227339 
X-CRM114-Status: GOOD (  20.88  )
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

On Mon, Apr 15, 2024 at 04:39:45PM +0200, Hannes Reinecke wrote:
> > For calculating the distance between two nodes we invoke the function __node_distance().
> > This function would then access the numa distance table, which is typically an array with
> > valid index starting from 0. So obviously accessing this table with index of -1 would
> > deference incorrect memory location. De-referencing incorrect memory location might have
> > side effects including panic (though I didn't encounter panic). Furthermore in such a case,
> > the calculated node distance could potentially be incorrect and that might cause the nvme
> > multipath to choose a suboptimal IO path.
> > 
> > This patch may not help choosing the optimal IO path (as we assume that the node distance would be
> > LOCAL_DISTANCE in case nvme controller numa node id is -1) but it ensures that we don't access the
> > invalid memory location for calculating node distance.
> > 
> Hmm. One wonders: how does such a system work?
> The systems I know always have the PCI slots attached to the CPU
> sockets, so if the CPU is not present the NVMe device on that
> slot will be non-functional. In fact, it wouldn't be visible at
> all as the PCI lanes are not powered up.
> In your system the PCI lanes clearly are powered up, as the NVMe
> device shows up in the PCI enumeration.
> Which means you are running a rather different PCI configuration.
> Question now is: does the NVMe device _work_?
> If it does, shouldn't the NUMA node continue to be present (some kind of
> memory-less, CPU-less NUMA node ...)?
> As a side-note, we'll need these kind of configuration anyway once
> CXL switches become available...

I recall systems with IO controller attached in a shared manner to all
sockets, so memory is UMA from IO device perspecitve (it may still be
NUMA from CPU). I don't think you need to consider memory-only NUMA
nodes unless there are additional distances to consider (at which point
it's no longer UMA).

