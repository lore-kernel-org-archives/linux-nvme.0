Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7A4C4452A
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H0n99WzJYmk3UtsdjwZNKQMIVvVCi3vB5uugDJ5Cotc=; b=ubnaihaucHUhlI2sjxaxuFhCS0
	0riH0Hs7vLeRgGxMruRrSAvmTUL8pDXCqKDfHUCe8bBhWHhZn8OVp34Yfw+ov7+XjKDB7NM8KQd+t
	vjdRoVz84DXPNad4fsJ0nMLor00+UwLSHjeTGUS/Ur8CXZJBSIMIkaZQvSKnO9zIg+VIH2yrASotK
	AVlVJ/t9FiyPFDxUTxaybd8ArUx+Lx5sgoGw8PGoPVHgvhuImO4Iq27gQXKAUA1Mg1VjQKKD+QeV4
	+e2N6L/w3l7OU18uFfrG6iZskMLtRPx4Dj7GO07C1+wbNNAEIUDliXgnTTovtDLtH4FitJ6cmDhV4
	uIF5TAXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpMs-000000072RK-2WDX;
	Mon, 20 Jul 2026 14:53:18 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpMq-000000072R5-2CSh
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 14:53:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CC38760254;
	Mon, 20 Jul 2026 14:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CB31F00A3A;
	Mon, 20 Jul 2026 14:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784559195;
	bh=H0n99WzJYmk3UtsdjwZNKQMIVvVCi3vB5uugDJ5Cotc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XlGBSUl1tCfoL/eX6duBkgkUqjkPKvnqA4INhMXKSAJqMNcRo115oQC9ibsx5acVX
	 M+7/3TJujrUuaghSZbHc/xOx43Xr963wZN8E5Vw9Aiz1JCQ1xjLNDnk29zL27oOFIq
	 K8bNN1BtBmgk15vX2cbW60ZwSesDgkOqrs3dYnv/Zmz4Gq6zHrQ3usubZx3xrLU3ZC
	 O60BBcMg31XfD6qVXTgWg102NvLNmSa1NWZAj+slsJjQ4G8fk9x9gj0Tzb9RpG0AqE
	 ZAjUWVmxlCVzLHtlHcYf5TmbGStmngnih68+9KINP3Y/n6gHI+Is3ZyjZn566XRMn1
	 a9Ra+9wVtXUfQ==
Date: Mon, 20 Jul 2026 08:53:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Zeng, Jun1" <jun1.zeng@intel.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
	"Cao, Gang" <gang.cao@intel.com>,
	"Jin, Jun I" <jun.i.jin@intel.com>, "Hu, Yong" <yong.hu@intel.com>
Subject: Re: [PATCH v1 0/1] nvme-pci: adaptive interrupt coalescing
Message-ID: <al42VxiRTKzTtMf5@kbusch-mbp>
References: <20260715075703.15578-1-jun1.zeng@intel.com>
 <3c29b8cb-906c-4c48-89cf-59c676900616@acm.org>
 <DM4PR11MB5375E80B504445BEDD869E95B7C32@DM4PR11MB5375.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB5375E80B504445BEDD869E95B7C32@DM4PR11MB5375.namprd11.prod.outlook.com>
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

On Mon, Jul 20, 2026 at 05:24:12AM +0000, Zeng, Jun1 wrote:
> > >On 7/15/26 12:57 AM, Jun Zeng wrote:
> > > The IOPS for small IO can be significantly improved when enabling 
> > > interrupt coalescing in this case. However, in some cases (e.g., big 
> > > IO for bandwidth or latency-sensitive tests with small IO and small 
> > > queue depth), interrupt coalescing has side effects.
> > > 
> > > Solution
> > > ========
> > > 
> > > Monitor the IOPS and average queue depth of inflight IO periodically 
> > > on each NVMe drive and enable/disable interrupt coalescing 
> > > automatically without user intervention. This feature is enabled by 
> > > default and can be disabled/enabled through debugfs during runtime.
> 
> > An algorithm like the above can be implemented more efficiently in NVMe controller hardware than in software, isn't it?
> 
> Theoretically, this can be implemented in the NVMe controller's
> firmware, but we have no control over the strategies and decisions of
> NVMe vendors. We are simply making the best possible optimizations at
> the software level.

But the coalescing feature as it is is too coarse. There is/was some
proposal going through the nvme technical workgroup to improve it. I
really haven't had any time to participate in the standards work to say
if it's any better, but that's probably the forum to improve such things
across vendors.

I'm not sure what concern you have about distro support with respect to
just controlling this from user space. AFAIK, everything usable has
sysfs, and you can't stop passthrough ioctls, so everything you need
should be there.

