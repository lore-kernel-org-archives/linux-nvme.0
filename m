Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68D4C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Oct 2023 14:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vs4D/kqzw/eF/3nuRjb6imrkdJRO+iFoa+UL3OeOFuo=; b=FOoLJoeaay07CEMB2J4icVKGTu
	9RLHuOVNb2pnRw+o/nrz3T46aIBfFOf0VigybcNj6R5udlvhqRcmo/fAUXgLvhZF4qzaXZeCxuJAi
	FPm3Kc1SAK5LMEd54dPJUa2xZJ/7cEbt7PdlKlUPmGRW1HRHxqSc+ygKd/LYq0FmkWi9We1jA3C6B
	SlwD4R86nTeff78OCLMb045O0HmgWTzail49F26l4BJTsUSkB2TAk3wLKD4fGggCA0NmWFjHTABy2
	HbeOtVp/F6nyYx6RCylFvrMkJVtAMxQfM6zG5Rx/eqHC9NgLnLGZTslat2jxU44stVJqV/6tZUsGq
	Q3wljeug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxTeh-003W7C-1M;
	Mon, 30 Oct 2023 14:54:15 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxTef-003W66-0C
	for linux-nvme@lists.infradead.org;
	Mon, 30 Oct 2023 14:54:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id B5912B80D0D;
	Mon, 30 Oct 2023 14:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF88C433C8;
	Mon, 30 Oct 2023 14:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698677650;
	bh=IGxZ3WXFE2g5LtHStC1maMx/25lkQzHmz4Iz8FrsjIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=arfIcr1PLhx/XBZRkqc8eMahg/eKkqQyCDFGPdP6in7tfw5XcRfMMl8bfFUk2FOj1
	 h8JVbT0koyb35oGfarOrJkvw2R6sMStxMzsy3ogdG41x2Q92IXU1HTdw7HgdM5nmeu
	 wRp5iGcfJA55otgY73SSniYNAUCI8z6xnTR2lgiBYMv69zkQnT9G0Y7aXWoFJbmk0/
	 gfOgUAEaBwQe90fG1ty89wyGgbw4M88i5rCaAikuwtuxNsQqvLwVD/a/VsNoQMdRtV
	 iX73Ao8pJP8YCJ2ZMZ2bdw6vDlHRKSaTkzAz+QnrvivIR6FRgbZAGd3v853YOXXlHR
	 39FuqgD23s7/Q==
Date: Mon, 30 Oct 2023 08:54:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, joshi.k@samsung.com,
	martin.petersen@oracle.com
Subject: Re: [PATCHv2 1/4] block: bio-integrity: directly map user buffers
Message-ID: <ZT_Dj9Df07bCntQQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20231027181929.2589937-1-kbusch@meta.com>
 <20231027181929.2589937-2-kbusch@meta.com>
 <CGME20231030144050eucas1p12ede963088687846d9b02a27d7da525e@eucas1p1.samsung.com>
 <20231030144047.yrwejvdyyi4vo62m@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030144047.yrwejvdyyi4vo62m@localhost>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231030_075413_277644_49FC4385 
X-CRM114-Status: GOOD (  11.10  )
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

On Mon, Oct 30, 2023 at 03:40:47PM +0100, Pankaj Raghav wrote:
> > +	int ret;
> > +
> > +	/* if bvec is on the stack, we need to allocate a copy for the completion */
> > +	if (nr_vecs <= UIO_FASTIOV) {
> > +		copy_vec = kcalloc(sizeof(*bvec), nr_vecs, GFP_KERNEL);
> > +		if (!copy_vec)
> > +			return -ENOMEM;
> > +		memcpy(copy_vec, bvec, nr_vecs * sizeof(*bvec));
> > +	}
> > +
> > +	buf = kmalloc(len, GFP_KERNEL);
> > +	if (!buf)
> > +		goto free_copy;
> 
> ret is not set to -ENOMEM here.

Indeed, thanks for pointing that out. I'll wait a bit longer before
posting a v3.

