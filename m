Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F90EC44524
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2026 06:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VBdn2EWjCzaB/LsGvu5JNC2sbY5O5dhhwEkMKQrKz6Y=; b=vdjsQ3oz2uECkYdJ4hE1rK3vnq
	Sjz72z5iGyfwU/sRgta5S3So2VOcnrQ/x4qWHrNfZcXq18Bpxs9bpkS+cviyRt7AdDuwDA8r7RnLl
	Sm3OIgy/+5/4VhMpAPOkxx5eAFzvzhMvggkNfhZ6w/65gGcOVLAz5IbplbFBMnjXsTqkzYVggYfG7
	oznQ8RlDnsXJj72vzVxpD9sdljnJbb1umTHuaa6WfglTrIZ4cT+Klh4okd+++zzK7shZlrhhzqG5X
	p9rItLUUgQlKfJjw+o0nk2ZLrm29aAVJkV/zmd9RXp6Hgn9pKhwLAWVaS2pE85Lhoi89/+v+uT9Xy
	ghiirIWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmmeY-0000000DWmX-0M1y;
	Thu, 23 Jul 2026 06:11:30 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmmeU-0000000DWmA-451N
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jul 2026 06:11:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3DF9C43A8F;
	Thu, 23 Jul 2026 06:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7994E1F000E9;
	Thu, 23 Jul 2026 06:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784787084;
	bh=VBdn2EWjCzaB/LsGvu5JNC2sbY5O5dhhwEkMKQrKz6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jQI35ZHFBTChYjQ6kfiY3FIG5lc5U7yuTiFHA0MAJuCB5lQhyHKzfGFvMqu0Vg7oS
	 wbmqZnrDUGLV+3FxAGADTsdviVKQKmKxL5b42UsWs1FHa/mxdTow2mrTa9oHPGfiFq
	 7VcDodqNgInG29zaRfj9Q59DE3247biTYu4J02Ld6oUHDbnanBWeSf2IeYtx8nhSGh
	 C4UgTQZqxfkmK2AoIZyCTBNAVlrVMRTOt7Unzfeklkfjs4POShPbXDmJPwwg+nCZOz
	 P8UMjW2HY0eW3UKLb58b2RFEDv2qDkLqgPOUN6Ue6Zq6qTLfJTgAqH/sJ3VXsHAVsq
	 IPE4/hdrctM0g==
Date: Thu, 23 Jul 2026 09:11:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Mykola Marzhan <mykola@meshstor.io>
Cc: Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	Li Nan <magiclinan@didiglobal.com>, Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 6/7] md/raid1,raid10: skip futile retries on P2PDMA
 mapping failures
Message-ID: <20260723061118.GA110966@unreal>
References: <20260719105327.864949-1-mykola@meshstor.io>
 <20260719105327.864949-7-mykola@meshstor.io>
 <ee312bcb-92f4-4884-91cd-3bd56180c8c7@deltatee.com>
 <CAPzsNDsLr_BABgizujN0CgnLNfzS3S37vQ133fjbJzFMvRs7CQ@mail.gmail.com>
 <9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com>
 <20260722083015.GU110966@unreal>
 <CAPzsNDuGfneEmx_nWqw5vYLyPyK8krfWChNRcsxO7icTEDDX5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPzsNDuGfneEmx_nWqw5vYLyPyK8krfWChNRcsxO7icTEDDX5g@mail.gmail.com>
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

On Wed, Jul 22, 2026 at 09:00:16PM +0200, Mykola Marzhan wrote:
> > I had thoughts about this series too. It seems best to avoid
> > the P2P path entirely unless all legs support P2P.
> >
> > Can the md/raid code determine P2P support in advance?
> 
> Yes, and it already does: the block layer ANDs the P2PDMA queue
> feature across all legs, so an array with a non-P2P member
> (e.g. an nvme-tcp leg) never advertises P2P at all.
> 
> But that flag can only say "this driver can do P2P in general".
> md cannot see which HCA device does the DMA for a fabrics leg —
> and with multipath failover it can change at any time.
> 
> So the up-front gate covers what is knowable up front.
> This series is about the remainder.
> In mixed case, one local P2P leg plus a remote replica, with it:
> 1) a failed read just redirects to a capable mirror;
> 2) a failed write records bad blocks instead of retrying forever.

Thanks for the explanation.

> 
> Mykola
> 

