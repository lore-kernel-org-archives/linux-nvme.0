Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DA9C3064D
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 07:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0bR90yF9CxK5qNKIXPi1mTv8uwRBPcQ1z40D3aWH0sE=; b=3PYWMT2O6IX3cHwZNhijMDdk20
	5v4svBhr1BUyX/gTZuSmn1hUr0z11GlMI0Gjp/Q4hQYJEBVL686WpURDkP42NYnp9PNNQ98qYE0Cc
	YUbZULipfxDxLgr2nZ1bNAVtcJAQ50J0wSrnHry6UYVXDmsfUOtBRr09jPqODJJlPS8ftvUhtQxS4
	4XuSSMK/1WN8FnUn6uPx8ygPq45lV2rM7BmZSgmS4Gx5rlOEXvSNoDnZsmCBaXvCkDmElQg/WI1Qv
	TNx2DFhmybtwYMtmf5CNz/O1zy7vhKK4gU/D0XD9lO7+2kwO6ANOr2RslUA43qI4nHIIz2w+EKEX/
	XDewlwfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMjaO-00000009Z3s-24Tt;
	Thu, 27 Jun 2024 07:30:28 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMja8-00000009Z0p-3qU4
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 07:30:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7D525CE2DB0;
	Thu, 27 Jun 2024 07:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A6EC2BBFC;
	Thu, 27 Jun 2024 07:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719473409;
	bh=L0iDbGCphSHH/3ZKqfEW7HtNdel6Lk26zULKayrmyUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0iTGi8ciwkk0hWC8JQsX60EJpqDx+oxe+mR/d4pDNiRZmwhf5xVqm5vAynPenA31B
	 v2Fxa34RenmP+eg6dNXYUoTLWFtitiIvPB/xmpOPtv0HJwdxU/zG6TB7WOHG/n/fBh
	 YeabEevW2RldDVgeUYcTT1W1Cb7KJwgyU2+RLCdE=
Date: Thu, 27 Jun 2024 09:30:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v7 1/4] driver core: don't always lock parent in shutdown
Message-ID: <2024062751-itunes-silk-ae8d@gregkh>
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
 <20240626194650.3837-2-stuart.w.hayes@gmail.com>
 <20240627055121.GA15415@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627055121.GA15415@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240627_003013_234654_676003DA 
X-CRM114-Status: GOOD (  14.60  )
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

On Thu, Jun 27, 2024 at 07:51:21AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 26, 2024 at 02:46:47PM -0500, Stuart Hayes wrote:
> > Don't lock a parent device unless it is needed in device_shutdown. This
> > is in preparation for making device shutdown asynchronous, when it will
> > be needed to allow children of a common parent to shut down
> > simultaneously.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> .. but I guess this means async shutdown won't work well for busses
> that set this flag (just usb currently)?

USB can't do async shutdown due to the tree topology requirements here
so hopefully this should be ok.

thanks,

greg k-h

