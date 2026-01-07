Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD811CF6BF2
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 07:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yXAFSNVwhZEZuJtoEF6lJzer855mgbaMMWAmZJ63yOc=; b=vaBfSGOiuQjdaBW1vNN6K1yWI7
	QsUmGCwBZcFi8CQtQbB8egh2hNlCRaBzw/EfKljuQPGdNrrF+a2VGqceouCkjWXLJFBX4dQ9m0URv
	xl9hQjBCxTdo/A8LwTZNu4TTC71Qq4sVHu7MNheTB30ehsPITWaoxcLD0KgsmXGMYbPVxrqmHNyRJ
	Iy6yBU7a+fId0RyyKkwqAsqPSvtLMh7zZz50EQedRofcZT6SPPt2fo/f0P9X81OA9EEHDdVFaPqYi
	qDUnavVgIfpMRuuPLfMBTfHyW6U5Q3euUHcZIuJ3lZC5SdJG18Ar+wzgFnXrUwk29IV2daOBjaei0
	D68kbAag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdONe-0000000EKdj-22sG;
	Wed, 07 Jan 2026 07:54:58 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdONd-0000000EKdR-18VQ
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 07:54:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B228B60007;
	Wed,  7 Jan 2026 07:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BD9C4CEF7;
	Wed,  7 Jan 2026 07:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767772496;
	bh=WU9BYosDgytSGFm7ugxaTC6PwVTLaeQgkXlafkxHXxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BWX7k91r5EsQAB87qtbAZypQwDX0sEi6XAeCSrLfQFPos//pxQh2SX8BEmcWe8hG4
	 AMDkoj5SgHzz4WQ5DtKjpdQZjXUe1khZPvMeoPDuE6svQJS82YUtCt7qT2rLFgn4xp
	 WVCzmjeBK7x7Q0pLQ/7F1FXTBIQENMTH5Fzk+B/XpHUwo73KKuZzCh52rvaLLzAF2G
	 Dd9JhwlZ7fzsWz9Gk9MoeCp+tZo8QzZAVwEAokSQm7wxHy6MItUNBEuS1BZZ7aGdIF
	 fx56kc45HmhxfJZVfW3qJsCDWb6C8ACDDFlo4sto1ocbdWhGo5EtBdvcX3awoDLORn
	 fueO8cx/tbCdg==
Date: Wed, 7 Jan 2026 09:54:53 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
Message-ID: <20260107075453.GB11783@unreal>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
 <20260104151517.GA563680@unreal>
 <258e49de-7af3-4a35-852a-8f26fcb7ddbd@kernel.dk>
 <8f839d6a-02a2-47f2-97af-f77cb10c5790@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f839d6a-02a2-47f2-97af-f77cb10c5790@kernel.dk>
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

On Tue, Jan 06, 2026 at 07:13:41PM -0700, Jens Axboe wrote:
> On 1/6/26 5:46 AM, Jens Axboe wrote:
> > On 1/4/26 8:15 AM, Leon Romanovsky wrote:
> >> On Wed, Dec 17, 2025 at 11:41:22AM +0200, Leon Romanovsky wrote:
> >>> Jens,
> >>>
> >>> I would like to ask you to put these patches on some shared branch based
> >>> on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
> >>> and DMABUF code.
> >>
> >> Jens,
> >>
> >> Can we please progress with this simple series?
> > 
> > If Keith/Christoph are happy with it?
> 
> It's here:
> 
> for-7.0/blk-pvec

Thanks a lot.

> 
> now.
> 
> -- 
> Jens Axboe
> 

