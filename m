Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0D7C43219
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 17:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LWG5AW4uepZlNBXb0EHfOL4zReGj23yawx02E17Ez/I=; b=PC1bevVDbiLM89gk0DtuP3Z2Qq
	p7SfLr7BX+DV4hiFFa8W2xSXWeoO/6t9nK2L6K/fIi2dolwMRGH4+zFUG9QSqblcGbBgQPvg8BXx7
	oQNbgiw5yGIxGidEyFCN+M5pz/mLOzBwcwIIVz8RTxCzOHNKxfd69Te0uaQqF+jH/ELBDHjXzYUSF
	sbgRhK8SgX4prwaZKCmbrqgEKe21CEZdm1+ZzTmpFRC2nitR9RBYPoOoprTQpyrdvMYpuZAiKAok1
	1b9fKpZMBN2PT0B6Wb3gKNrhqExiv8RDSp6vhEjTlZyleG/Zul2K6bDrQt8CA0TmmPQAgExM/1TuC
	AioIBFcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osoS4-00FJEB-Uq; Wed, 09 Nov 2022 17:01:24 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osoRk-00FIyI-Ph; Wed, 09 Nov 2022 17:01:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 992F261BE0;
	Wed,  9 Nov 2022 17:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7703BC433D6;
	Wed,  9 Nov 2022 17:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668013261;
	bh=sVFBQy+y379XCQ/u8pvwmu13MGl3CE6h+Ph3ingwOWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XS++TUs62Bia6YhlOz5VRjMrJCrsm8tepTzjtZ8hFG7uQ3JTExQWij6JG5dgoY9mi
	 ye+IWQfOsZ7yieYXjG1eGWvNAmNpyE2f70yWTDtI1ryAIZnSqKLuUE0KNKRjFrtSM6
	 HC/YIevKUO3uanpDSKYIpqtUYpsGecYj0dNvncXI+5bQq0ou+ylvo1rUZVmSYC8p1V
	 rJkq+2JaDEBbepTKZg2vyK7IVeMyq+dbTZFKMeddFexeDI2FHAA4ppjrAqLCR9vMgs
	 R3AXeTJV9JbuRiFbZjRkYPAJ4LBWsTWAvSIb5xttCWaRD5CUx5fJGXXQ/u3wQi5VLp
	 MYtxc/MrbtAgA==
Date: Wed, 9 Nov 2022 10:00:57 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 11/12] nvme-pci: split the initial probe from the rest
 path
Message-ID: <Y2vcyaOvD9M/5CEA@kbusch-mbp.dhcp.thefacebook.com>
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-12-hch@lst.de>
 <e1225fb6-0cac-ba47-df03-0be84cb3a09b@grimberg.me>
 <20221109063119.GG10528@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109063119.GG10528@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_090105_058987_BEDC8293 
X-CRM114-Status: GOOD (  21.10  )
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

On Wed, Nov 09, 2022 at 07:31:19AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 09, 2022 at 05:14:02AM +0200, Sagi Grimberg wrote:
> >> -		if (dev->online_queues > 1) {
> >> -			nvme_pci_alloc_tag_set(dev);
> >> -			nvme_dbbuf_set(dev);
> >> -		} else {
> >> -			dev_warn(dev->ctrl.device, "IO queues not created\n");
> >> -		}
> >> +		dev_warn(dev->ctrl.device, "IO queues lost\n");
> >> +		nvme_mark_namespaces_dead(&dev->ctrl);
> >> +		nvme_start_queues(&dev->ctrl);
> >> +		nvme_remove_namespaces(&dev->ctrl);
> >
> > Is this needed? isn't nvme_remove coming soon?
> > In fact, shouldn't all these calls be in nvme_remove?
> 
> This handles the case where a controller controller does not have I/O
> queues. For controllers that never had them (e.g. admin controllers)
> none of the three calls above is needed, but they deal with the
> case where a controller had queues, but they are going away.  I'm
> not sure if that can happen, but it keeps the behavior of the existing
> code.  Keith wrote it to deal with Intel controllers that can be in
> a degraded state where having the admin queue live even without I/O
> queues allows updating the firmware, so he might know more.

Right, firmware assert and other types of errors can put the controller
into a degraded state with only an admin-queue when it previously had
working IO queues. Keeping the admin queue active allows an admin to
pull logs for their bug reports.

