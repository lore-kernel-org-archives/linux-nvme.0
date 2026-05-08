Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87B7CD342F
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2026 09:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=idvgbpaYFblAmbga0MoFspBOm/9DhfjLh4qLs1XVXTw=; b=BoJxVPTobKkBv5y6AF0OIJn2l1
	GNmlnqVXCUAeBsUcsBzN0+3KhQzWbXGcPvVkm654tYFlHMkzYMMdjBejzql8GdhN4+nxYUD0loJ8d
	JJj5s4xcLtJgn17jBmwKvkoy/3fmD1EzZHhJ3sjUKVH0eMHTiIsvTEHJZIyYlKxeEmQTUyaqzPUS5
	Ji6o4MFSL8WytgduAitMy79E/wFmnYHc3S9NbQLlru1W2ionDRYns1UqJz7lafOAVR5/GZUmZ81+w
	tNvy6v4Et8Wu7QnTle7sG/ptmJD9ieaLY64PXbmiX+L5PgXXkDEqM6FnVKaUW3fYHmUzgJXPm9451
	s8dLmRUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLHYq-000000067JY-0GL7;
	Fri, 08 May 2026 09:31:56 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLHYo-000000067JK-3cPP
	for linux-nvme@lists.infradead.org;
	Fri, 08 May 2026 09:31:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 928C0600AE;
	Fri,  8 May 2026 09:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F41C2BCB0;
	Fri,  8 May 2026 09:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778232713;
	bh=uA7GVZz2bi4jQUVlE6iItOdauDNxiqMvd6wJgnT5geE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojFU2lveFMGmHkHJ+rPBA4FXu291LnNpnuWu5MEr1SPktmx3lQRL4coRMuB1BB/+C
	 DbiNLXK22WZhrBU0om+6vMaMRQ2x3mrvNgNgT/0LiM8ZdmgH3ZvivOB/vP1rCNd1bs
	 zQoNA0ElyN1uUxqMDi8dvxyCuPoYo+v3i2zsySEgjVWKcrKpR6R0yXliIMZGBfXPvE
	 e72APpNLjde0mEnXK1enikyWHJ6F23aQAukwOZfiVOAtVs7KE/+WOqgEXZTNZU737Z
	 32am9XBXsg4dU6ip0x9npqdaa6ejb107HGyjaJZd613yE/cxBKh2aU559wq5SE+9ck
	 N1AyuCAPLbtfw==
Date: Fri, 8 May 2026 10:31:48 +0100
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Maurizio Lombardi <mlombard@arkamax.eu>, Chao Shi <coshi036@gmail.com>,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH] nvme: reserve a keep-alive admin tag for all transports
Message-ID: <af2thHcqZ28pDF2w@kbusch-mbp>
References: <20260428022911.1288485-1-coshi036@gmail.com>
 <afBYFfZJjiDDvlLv@kbusch-mbp.client.m3-hotspots.de>
 <DI4LPUI48MRH.3GC5TVZLMICXN@arkamax.eu>
 <afBgs0f8Et3jqijM@kbusch-mbp.client.m3-hotspots.de>
 <20260508090427.GA20593@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508090427.GA20593@lst.de>
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

On Fri, May 08, 2026 at 11:04:27AM +0200, Christoph Hellwig wrote:
> On Tue, Apr 28, 2026 at 08:24:35AM +0100, Keith Busch wrote:
> > > This field specifies the timeout value for the Keep Alive feature in
> > > milliseconds.  [...]
> > > The default value for this field is 0h for NVMe transports that do not require use of the Keep Alive
> > > feature (e.g., NVMe over PCIe). For NVMe transports that require use of the Keep Alive feature
> > > (e.g., RDMA and TCP), the default value for this field is 1D4C0h "
> > > 
> > > To me, it sounds like for nvme-pci, keep alive isn't required, but could
> > > be activated.
> > 
> > The spec says the support is subject to the Transport binding
> > specification, which does not exist in the PCIe transport spec.
> 
> My memories from the fabrics working group back in the day is that we
> explicitly intended to support it in PCIe.  The wording in the spec
> referring to transport specs I can find is:
> 
> The NVMe Transport binding specification for the associated NVMe Transport
> defines:
> 
>  o the minimum Keep Alive Timeout value, if any;
>  o the maximum Keep Alive Timeout value, if any; and
>  o if the Keep Alive Timer feature is required to be supported and enabled.
> 
> which does not read to me like there is any required language in the
> transport spec to require keep alive.

So the absence of defining a minimum means it's simply optional? I
suppose I can see it that way as the intended interpretation, but seems
counter productive to do on PCIe when you can MMIO the controller status
register to verify liveness. If the controller responds successfully to
the feature, then I have to agree we need the host to do its part.

