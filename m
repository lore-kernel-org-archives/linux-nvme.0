Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA7ACF6C00
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 08:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1CCt7alLCcsJZ0euzmRVgO2NBUskOJ/Fg6Yw/2h2HYg=; b=rugBbCpTwp0ovPzCNvMyc9fy1z
	yxENBCMYSSPQEzS/S/zkr6v9yH0S8JFm6O2YU/TRUXtE/3ay6MhZMCp5JDuEBO0mV31Ff24lP29td
	xQR8Q3Akf8fWLQR1Co1MrFixhxZmWQNDkVKbTcVLFw7EKY6WYsub7MyqKsP41oJi+9G7WbDRYbefc
	WgDDe55PVm7yve/tCsCXxW5fg6V5ck2GlkygL8yI2oGigM+/oFDCmHEHW0diQoe/lLDDBkbLWyeiB
	g5zEdhPphT+vXAth0rHanKqoYJnP6Rbta3KZeqYeMcUfyPS8SjkvuAewfagjSkhr97neyWCBUh4dy
	R1Px/s4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdOvJ-0000000EPax-0uIs;
	Wed, 07 Jan 2026 08:29:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdOvH-0000000EPaY-3YeI
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 08:29:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DE1636013A;
	Wed,  7 Jan 2026 08:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5592AC4CEF7;
	Wed,  7 Jan 2026 08:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767774582;
	bh=c9KnDRZffd89kv7fNSY4uCu0xvLE7udUDIgxRUUEgfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAwsxbl5/DK24CGjsFliYKleWSIZKrLT+jYQDNlVhbR98y106ubl/7YvMyLFcDc+j
	 uNA03nnOs64V1QoMqquuS/wXF864uGcgCY9UvVTs4vSOndUjvnFzlVvvJWzSPpMu+S
	 m80VpwPwOJIQyQiAvWePDuJ13vwFEjPgu0bEN/gKOBvxIHGiu670QKPSEm9g574EyI
	 GzKN3RRp4aCAhWXonV079oRR7S8lrDLcQ2c+iCj77LACT74ypShOXsz8pFgcn3IThD
	 Yvt6dahdoTJvI0QRIn8cP2wFKykhbmgFqY/AC4hEON0frdSP0qL9eexjeVN0A+mW1f
	 gfBF+OJomvo9A==
Date: Wed, 7 Jan 2026 17:29:38 +0900
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
Message-ID: <aV4ZcuXFjN_Eit6v@kbusch-mbp>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
 <20260104151517.GA563680@unreal>
 <258e49de-7af3-4a35-852a-8f26fcb7ddbd@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <258e49de-7af3-4a35-852a-8f26fcb7ddbd@kernel.dk>
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

On Tue, Jan 06, 2026 at 05:46:21AM -0700, Jens Axboe wrote:
> On 1/4/26 8:15 AM, Leon Romanovsky wrote:
> > On Wed, Dec 17, 2025 at 11:41:22AM +0200, Leon Romanovsky wrote:
> >> Jens,
> >>
> >> I would like to ask you to put these patches on some shared branch based
> >> on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
> >> and DMABUF code.
> > 
> > Jens,
> > 
> > Can we please progress with this simple series?
> 
> If Keith/Christoph are happy with it?

Yes, I'm happy with this. Sorry for the delay, I'm still abroad and
encountered some issues when I should have been holidaying (nothing
serious, just bad luck), so it's a slow start to the year for me so far.

Acked-by: Keith Busch <kbusch@kernel.org>

