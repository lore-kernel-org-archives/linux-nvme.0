Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1BDC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Mar 2022 08:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dYh+N+2mvNrWUXszh69Wz0m73OWIcHqgXRRaNyK/nnA=; b=kjtCTBxs3amG3C//O8BpZ1BZRl
	987SPoo0OwC4qEb7FdFfq6qQhD2eiP0sPEqiGAGPxactEgtwjYzy63KLJ7K5xN66QaQVzsF3FxT1X
	6x8x98B9WNmmTXPIKLlkWEfnPEm3u6lSwcjYP+worcHI6LHiDxJ0NyPVUb2zDAjyd/1f3BbLJ+4hv
	AN3lTKx+PyoTgbavqTiqfIhGwVbAdGYGXgeCEbR3wEUD67hpiyDWnQZENCfrQz5FQ5E4AyX6SVlG1
	XGttWelePdWnFSw1xXTF/svc7ynj/1cjMtVeCocQNHULa7QuCy3TIz9z6MQshZpe44+oauHOADC4F
	iF34yg5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nOxa3-00FW0q-37; Tue, 01 Mar 2022 08:09:59 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nOxZz-00FVzw-Gt
 for linux-nvme@lists.infradead.org; Tue, 01 Mar 2022 08:09:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BFE6D68AFE; Tue,  1 Mar 2022 09:09:50 +0100 (CET)
Date: Tue, 1 Mar 2022 09:09:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, kch@nvidia.com,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v4] nvme: add vectored-io support for user-passthru
Message-ID: <20220301080950.GB31595@lst.de>
References: <CGME20220210054304epcas5p14aa9d83205f74b2e4942ed9b4e43fc23@epcas5p1.samsung.com>
 <20220210053755.451855-1-joshi.k@samsung.com> <20220228114830.GA10899@lst.de>
 <CA+1E3rLQBxN3y-F+KVe9MhdgQD9+XGGacnGQ6F8h_hAQHsj3dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rLQBxN3y-F+KVe9MhdgQD9+XGGacnGQ6F8h_hAQHsj3dQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220301_000955_731675_B17413A3 
X-CRM114-Status: GOOD (  20.30  )
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

On Mon, Feb 28, 2022 at 06:11:39PM +0530, Kanchan Joshi wrote:
> On Mon, Feb 28, 2022 at 5:18 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Btw, I noticed this is not wired up for the /dev/ngX character device.
> > Can you send a follow on patch for that?
> 
> Err, do you see that it is not working? I actually tested it over both
> block and char.
> My test utility did write-vectored to /dev/nvme0n1 followed by
> read-vectored from /dev/ng0n1, and did data-comparison. It passed.
> 
> Code wise, the handler for NVME_IOCTL_IO64_CMD_VEC is added insided
> nvme_ns_ioctl().
> - for non-multipath char node:
> nvme_ns_chr_ioctl -> __nvme_ioctl -> nvme_ns_ioctl
> - for multipath char node:
>  nvme_ns_head_chr_ioctl -> nvme_ns_ioctl
> 
> Please let me know how I can produce the failure that you see.

You're right.  We do support it for /dev/ngX, just not the /dev/nvmeX
character devices, which is a good thing.

