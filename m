Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375AAFEC11B
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 22:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VjdB1bisLn3opbaYV+Zxr7v6nojA9GAZ6tP00QuXhDo=; b=Pl9wdFS4dQIL3hU0pd2IymvP2w
	mAKga9ET9C9LpfTQ//fEwrUYgHFbg2XASULzdXNlCqDDUHDXN7ulXJ3oztjpfeaY25izzsl69NuMZ
	O5JS+7yo0/5NBif3Wy7AoAW6vTUzH+XX1zGZDNf3YGbl33K3f7OFSDlThQ6+t00pFeF+SXhms05c5
	UEe1zGNOIZ9yAE33UMRiV0hKkJOeHz5Gx+UrFwWxO9rqLR2Z5U9OoBrV78JhRJjj9/hgn8Q9WfJm1
	I+WqEhPCNvS7WTE+r3DlcFD+/wqpiX/x7/BjWBt/UXRqylHFcRl74Ce0FX9RoHQ3fHEikAaPnBBc0
	Tt+IC08A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w59vS-00000002Hh4-0YtY;
	Tue, 24 Mar 2026 22:08:38 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w59vQ-00000002Hgv-31ad
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 22:08:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D05BA600AC;
	Tue, 24 Mar 2026 22:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08302C19424;
	Tue, 24 Mar 2026 22:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774390115;
	bh=582lj4Q0QSxQ7zL9ehprIYOP8OizZRoaVEMHubw+uL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QD4Reiq8trHN+TxVedul3xM8RiSrBZBn5ViIefrkniy2BfPbUF4Jif0VjF1JGSdJT
	 buy+Vf3ySYwXbq9rup/MBG0rW8Sdqp1i8WSbwJ8/mf28mRGZd7bF1Swn9X9/dvUcLM
	 qE1gDiG+UDU3DERNhvhh+Pfsd4dMjnN6wPBZ/NbNFyehc3BnxhBPMnAz33GEfviAV+
	 j6X3+EvReM5GqL+OC6E7bYD/jOqBwQBXO1bCyoXl3ADCpSFcXLwO2+Rr4BS42vz21A
	 TVQFCHzGZr3sXKZD6P64Z029M0+CwBdxnX0By71NpYAeJlNsLrqkPlUJ21P989smqX
	 /brFN65X4q/Qw==
Date: Tue, 24 Mar 2026 16:08:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kiran Modukuri <kmodukuri@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	"song@kernel.org" <song@kernel.org>,
	"yukuai@fnnas.com" <yukuai@fnnas.com>,
	"linan122@huawei.com" <linan122@huawei.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/2] md: Add PCI_P2PDMA support for MD RAID volumes
Message-ID: <acMLYSsatGfMiFRA@kbusch-mbp>
References: <20260323234416.46944-1-kch@nvidia.com>
 <20260323234416.46944-2-kch@nvidia.com>
 <20260324064816.GA1409@lst.de>
 <DM4PR12MB8473B3907CAF51AEBAE573E5D548A@DM4PR12MB8473.namprd12.prod.outlook.com>
 <acMCQaEOAqZEfyyT@kbusch-mbp>
 <DM4PR12MB84736C00E876FD160464EB35D548A@DM4PR12MB8473.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR12MB84736C00E876FD160464EB35D548A@DM4PR12MB8473.namprd12.prod.outlook.com>
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

On Tue, Mar 24, 2026 at 09:43:15PM +0000, Kiran Modukuri wrote:
> Hi Keith,
> 
> So do you suggest we leave the current patch as is without restricting the P2PDMA support for RAID4/5 or restrict the support only for the RAID0, RAID1 and RAID10.

I think you currently have to remove it. If you want to do parity
against P2P memory (which sounds like like a nice feature to me), then
you'd have introduce a prep patch to detect that an xor dma offload
exists for the raid volume to use, and do something to ensure it will
always get offloaded for P2P memory instead of falling back to the CPU
driven synchronous implementation.

Unrelated suggestion, you need to change your email client settings to
plain text in order for the mailing list to accept the message.


> From: Keith Busch <kbusch@kernel.org>
> Date: Tuesday, March 24, 2026 at 2:29 PM
> To: Kiran Modukuri <kmodukuri@nvidia.com>
> Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>, song@kernel.org <song@kernel.org>, yukuai@fnnas.com <yukuai@fnnas.com>, linan122@huawei.com <linan122@huawei.com>, axboe@kernel.dk <axboe@kernel.dk>, sagi@grimberg.me <sagi@grimberg.me>, linux-raid@vger.kernel.org <linux-raid@vger.kernel.org>, linux-nvme@lists.infradead.org <linux-nvme@lists.infradead.org>
> Subject: Re: [PATCH 1/2] md: Add PCI_P2PDMA support for MD RAID volumes
> 
> On Tue, Mar 24, 2026 at 09:13:55PM +0000, Kiran Modukuri wrote:
> > Hi Christoph,
> >
> > We tested with RAID0 , RAID1 and RAID10 only. You're right that parity RAID personalities
> > need CPU access to data pages for XOR/parity computation, which won't
> > work with P2P mappings.
> >
> >
> > We'll send a v2 that moves BLK_FEAT_PCI_P2PDMA out of
> > md_init_stacking_limits() and instead has raid0, raid1 and raid10
> > opt in individually during their queue limits setup. raid4/5/6 will
> > not set the flag.
> 
> I think the parity could work with P2P memory if the calculation is
> offloaded to a dma_aysnc_tx. It doesn't look like we necessarily know if
> any particular xor is going to get offloaded, though.

