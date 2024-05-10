Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9442DC25B4F
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 09:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dtge0EEParxc8B5Y/YH/YUClJnR3IODSvA9IhKfb4+M=; b=YkDNpGnQpJoYFKDgBmA6G9jA0a
	mqEJo60TfnHGxf1w1i2k6lEUyX9OPYdFMcrbjQz6f9wnrmGOgYO133wrnqQU0WCpjFljPn0OsOKt6
	u8h0NKiihU+nDaLDXwozNIP9hHQ5jNFyBJCDGPeQVeBo8jZDoGSFzNHWEvuSFxxQw2DFF9MlpFTHB
	1V7l+PIk4HrAO08l5cmJ3L1n67OqFBn8Wee9KqTufswpKu+skwpOvxBbpf90qrXqHILQrY+HveiEB
	8QZ9ZSIfiHgs0pVv6rcJ6Gz78XX8ciXBeY0nFLSojnDw10qqmwWlanYfacDx+g0d1SZZp1cttUVEm
	RHYCkWAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5MYb-00000004hXg-1joG;
	Fri, 10 May 2024 09:28:49 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5MYX-00000004hW0-3dSK
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 09:28:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 289F2CE1CF4;
	Fri, 10 May 2024 09:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D30C113CC;
	Fri, 10 May 2024 09:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715333322;
	bh=oxjnBw0YNQFYA5GB81I1XJ33OzLdua4xr2AApp9Wiss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P51B6Dt/bsfnrvqsI3zczK2l8toNlYkKJm+ymZrDnfP/5zfTTVeAJP1bWS+KRvDPv
	 BwMBAyWnRXmiG8MFxuBdcE0olUh2h+jFtlgi536ih7nxZgkREY49J6yuiFbFMZpjk9
	 ZwmUlo4Yy0Z/OgjuU5xeuYR2yiwsYvMT6eCacI+S2BcEdK4vGGjdMXC0Hi4rvh9sfF
	 se6PKSPQDAndTxlk8PdLcurOktGrFCsqAx8O1iJUDk/Hky8+++vXDPIc+q37VEqeyM
	 FxlNxqIoRX9UQ6A3fkjaHWCQ0UedVPkppTaKH591xNggb8qjSpztBBcnvjs0oQbOzm
	 KXoWaeixRiZsg==
Date: Fri, 10 May 2024 11:28:36 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: John Meneghini <jmeneghi@redhat.com>, tj@kernel.org,
	josef@toxicpanda.com, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, emilne@redhat.com, hare@kernel.org,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com, aviv.coro@ibm.com
Subject: Re: [PATCH v3 1/3] block: track per-node I/O latency
Message-ID: <Zj3oxKCGQYQ7xpjt@ryzen.lan>
References: <20240403141756.88233-1-hare@kernel.org>
 <20240509204324.832846-2-jmeneghi@redhat.com>
 <fcda2351-9ba7-4121-a993-184a4c02f9a6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcda2351-9ba7-4121-a993-184a4c02f9a6@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_022846_179928_30B03251 
X-CRM114-Status: GOOD (  10.77  )
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

On Fri, May 10, 2024 at 04:11:10PM +0900, Damien Le Moal wrote:
> On 5/10/24 05:43, John Meneghini wrote:
> > From: Hannes Reinecke <hare@kernel.org>
> > 
> > Add a new option 'BLK_NODE_LATENCY' to track per-node I/O latency.
> > This can be used by I/O schedulers to determine the 'best' queue
> > to send I/O to.
> > 
> > Signed-off-by: Hannes Reinecke <hare@kernel.org>
> > 
> > Cleaned up checkpatch warnings and updated MAINTAINERS.
> 
> This note should be before Hannes SoB. E.g:
> 
> [John] Fixed checkpatch warnings and updated MAINTAINERS.

Not before, it shoud be after Hannes SoB.
(Between Hannes' Signed-off-by and John's Signed-off-by)

See this example:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a37e12bcab22efa05802f87baa0692365ae0ab4d


Kind regards,
Niklas

