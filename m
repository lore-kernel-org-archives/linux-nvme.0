Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3219CC4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Nov 2023 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4zZVFPu6senN+BF3Gp/7203o4m+A35efjfx8SF363+M=; b=fVrko+fXjG55liCy7yvxttRkY0
	ht5PniL3M0XWe1znKEAllG4aLOll+ARH75QbLBTDRnIQ6udkNawCL/my4+S4CuSP/lifnJWx2WCCh
	tFsrrIIF4EJWk9fhXeUQbvMbjW31l49YPjxG6VWBCePAGvpWqVGe8m6GJrqUyr2y1W7z2boP4Y7JC
	/LOpvYjswe77j8ndS6qkUrDdlj5VEfTDMQ4dAo5vqf/YjN4lHFwJz7DdeeVrXei4W627ep5sZ1lTY
	CP6eJmrQNwudCobwbsiOEBVuv3g1fFqp7WMNbxn7bot2dxQ42GWLUBUIq35Ccf3qbiP8m/JeKK3N5
	8HrKbjaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7eV4-002zV5-0F;
	Mon, 27 Nov 2023 16:30:22 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7eV1-002zTq-25
	for linux-nvme@lists.infradead.org;
	Mon, 27 Nov 2023 16:30:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 1F2BEB836A4;
	Mon, 27 Nov 2023 16:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119C3C433C7;
	Mon, 27 Nov 2023 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701102617;
	bh=VQ294nCR6/7aI+HtxIgb1t+5lA/sOhUAPy8Ess4W+k4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imJ1oOKsMju4Hk+0o8KUdr6MiKFYjYQ4Mw76S/B9/pFFsd1OQmZeRWVSVBohJzYIg
	 gll0ZzGFwcyMcl+p0we/8HJsswfUiFrPn4iOfbhaaejykFiHVm+Ps7FXzUCsVqRrSn
	 FJqtRUMUI5zRAa2JZF3nIs8EsWUOaHX8jMYBPHed2Dxohigz8kxdszEgegi0cjpL32
	 bNKiTLP4LoR/3zvX/o1JlWNGFoBfRoqMm/fMVm0B9R7k/TxZslYE/HgjGDJex1RwYo
	 vpDPs9LAT//tOCM+822v9cAHs7G2PNnbYOjTnkXYpcIaLhpcU0TIqLptk7wNZjz6v3
	 j6GJ8fzXmq8Lw==
Date: Mon, 27 Nov 2023 09:30:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <ZWTEFvYbI1bFTXyZ@kbusch-mbp.dhcp.thefacebook.com>
References: <20231127103208.25748-1-dwagner@suse.de>
 <20231127141857.GA25833@lst.de>
 <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com>
 <20231127155649.GA1403@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127155649.GA1403@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_083019_834199_92F17D35 
X-CRM114-Status: GOOD (  15.36  )
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

On Mon, Nov 27, 2023 at 04:56:49PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 27, 2023 at 08:44:52AM -0700, Keith Busch wrote:
> > > I'd probably spell out metadata_size, or probably even better
> > > metadata_bytes to match the unit postfixes elsewhere in the block code.
> > 
> > Should this even be an nvme specific attribute? I thought we should have
> > blk-integrity.c report its 'tuple_size' attribute instead. That should
> > work as long as we're not dealing with extended metadata at least, but
> > that's kind of a special format that doesn't have block layer support.
> 
> Reporting the tuple size is a good idea.  But is that enough for
> the existing nvme-cli use case?

nvme-cli currently queries with admin passthrough identify command, so
adding a new attribute won't break that. I assume Daniel would have it
fallback to that same command for backward compatibilty if a desired
sysfs attribute doesn't exist.

