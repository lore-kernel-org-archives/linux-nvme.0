Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EE8CE7B0C
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 16:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ThA79az8NKAEabW/GDtVqKt0NHUnbwrAb/R6DxsJ2pA=; b=a6g1W0xgwj/eFgqg/ujzUcOJA9
	hSCArDV0RZ4qRMS3c1YZQjyBGRSdgA4hr2G82BHLEkKBDMQJBIN0e4xp4yD849qRy1qtj4wRaNSpo
	WWK739uIAceDNKWZUKDHDII8OiIQWrLegf9W4+H8w4KWYCmuG0VEQ+PlOuXydEJWaEUKd+aKrTrkO
	XE9hoZg+ErX0qv7BQS/auHRTc9NgfxfVTpVN4G/mmSdTC+rVOzmMx41iE8z3B5L8SqkJPWmfRPCSK
	4KePAVZhPfScak9lUfatyVbSlwnUhVb0U2sq3Quq4FAaDWcVONoAd+odpaHMjbVJJU6zuYWJ5fkx9
	th//KB2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smbeZ-0000000Cw76-0LcP;
	Fri, 06 Sep 2024 16:17:43 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smbS1-0000000Ct57-3y8S
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 16:04:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7D9E9A450E2;
	Fri,  6 Sep 2024 16:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE2BC4CEC4;
	Fri,  6 Sep 2024 16:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725638684;
	bh=BZenlBD2N8AAYL+2OT/3WcZoQCY+AVCkF1sXui4p35Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F44be4vDFLCx4ewpp8POzx1WytGmpAJBWrkhnXMOdWZdPJlVz2kRfiKwhdznK2HDH
	 opmZNx1MGv+Ot9ffc1C52s2VRqmwR1+Of+AjJCAtAsF+gcLYZb+hD3RDiO0gqApc2n
	 2JpJCk/LkxV87d0eg/d63pqJaqhdDEIoFol1Z3x6rv1c+GMZVnl/XYM3RYvUcgFctx
	 IvltQxB3DnHjdi0hAXGlcKUCrn2he5m85TiQGBZlJG0mzCOc5NB1zzf6swc/B8xPHQ
	 bY+Xs9ZajwrORdx1JJQ1VQ2A+66EAIwjagZueN9BKO2sRMv6zySdjZ6i6wCYCU99LP
	 59fLRfoE1AW3w==
Date: Fri, 6 Sep 2024 10:04:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@hansenpartnership.com,
	brauner@kernel.org, jack@suse.cz, jaegeuk@kernel.org,
	jlayton@kernel.org, chuck.lever@oracle.com, bvanassche@acm.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Hui Qi <hui81.qi@samsung.com>
Subject: Re: [PATCH v4 5/5] nvme: enable FDP support
Message-ID: <ZtsoGX2QY-TjBolb@kbusch-mbp.mynextlight.net>
References: <20240826170606.255718-1-joshi.k@samsung.com>
 <CGME20240826171430epcas5p3d8e34a266ced7b3ea0df2a11b83292ae@epcas5p3.samsung.com>
 <20240826170606.255718-6-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826170606.255718-6-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_090446_072201_92841EC4 
X-CRM114-Status: GOOD (  11.97  )
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

On Mon, Aug 26, 2024 at 10:36:06PM +0530, Kanchan Joshi wrote:
> Flexible Data Placement (FDP), as ratified in TP 4146a, allows the host
> to control the placement of logical blocks so as to reduce the SSD WAF.
> 
> Userspace can send the data placement information using the write hints.
> Fetch the placement-identifiers if the device supports FDP.
> 
> The incoming placement hint is mapped to a placement-identifier, which
> in turn is set in the DSPEC field of the write command.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Hui Qi <hui81.qi@samsung.com>

I'm still fine with this nvme implementation.

Acked-by: Keith Busch <kbusch@kernel.org>

The reporting via fcntl looks okay to me, but I've never added anything
to that interface, so not sure if there's any problem using it for this.

