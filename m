Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD1FC10DAA
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Nov 2023 16:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r4yCaE0BNm7ZZBUV6+RgTCxO9kmv5FRdc2qKplxr/js=; b=OIrwf3E9odp/9XjDeeY9G7ahmv
	ZPJfuQoqXmibVahwn7QfWYvD7zpefj7g6hgK6pfQ8aw03VoO/NFM1ioE3FNrlYepW+FSukSv5iFVr
	zFusaJ5+80d5eJxj1HZNMCgwKj5/iLWkgy+zHyr+oAnnpNa4/M7PLyTgcmxChOmFomUm+/D7+N3g2
	iFfXAHZDQmUGUtgF4CdF+3+HKleb8Pq/fY88Fbo6FpsGFx+j3zz9PXO+sPWQxxqMR6CTudhHTm/uv
	wh18K6iJQtAykoe+T+ZT2z6MNEU/ek2WlD+TJlP+waNCcTE9wTpANaZL4ycLW9wRl3ZC2nFpFJOJT
	JDwVzVpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8NXA-008uPh-1Y;
	Wed, 29 Nov 2023 16:35:32 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8NX7-008uNZ-2n
	for linux-nvme@lists.infradead.org;
	Wed, 29 Nov 2023 16:35:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 50DDEB83F49;
	Wed, 29 Nov 2023 16:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E37C433C9;
	Wed, 29 Nov 2023 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701275727;
	bh=eOjkRPVgX0VcHNh7RX+k1LOyqo1PtzlUuZb0jt0NekI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNKHpEYxm2MblF/x9ck6IR8M74a3B/2DUKLTdYCZvJSvH069KjVLP52RxPFKLBH94
	 BvmXPN3Jh/xayNb7sh0GfQ0CqzhA5VetVG1cHAFpnsR9phLheWfNCdrYy/e1JlpQWj
	 s5MfMaunxJ6GYGlP1mp+eoIpLPwQCOIBMqL0oeCErCBuEOPzAFvnh1Yd7VI6BJ3ci/
	 /9CZsUD8olOADonP1zLnBZmV2muokDFyNNqtHGX2SVfTL0gyUXyoxsVxscR+m4f6XZ
	 ad9hY6n/othTAHB6CnoYUo/ToXwCU1d8MRFmJjP7y6V1MgNO/Eu0HP0RRNzTPkIo4q
	 xGLy50AN2EpCA==
Date: Wed, 29 Nov 2023 09:35:24 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	ming.lei@redhat.com
Subject: Re: [PATCHv4 1/4] block: bio-integrity: directly map user buffers
Message-ID: <ZWdoTOtNbomVQFd3@kbusch-mbp.dhcp.thefacebook.com>
References: <20231128222752.1767344-1-kbusch@meta.com>
 <CGME20231128222827epcas5p19beb5067fa55290aef73f96dee91c4ec@epcas5p1.samsung.com>
 <20231128222752.1767344-2-kbusch@meta.com>
 <249c59bb-794b-f8ec-c4e7-17308ecf7f2a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <249c59bb-794b-f8ec-c4e7-17308ecf7f2a@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_083530_066114_D660DEB0 
X-CRM114-Status: GOOD (  12.61  )
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

On Wed, Nov 29, 2023 at 08:48:41PM +0530, Kanchan Joshi wrote:
> On 11/29/2023 3:57 AM, Keith Busch wrote:
> > If the user address can't directly be used for reason, like too many
> > segments or address unalignement, fallback to a copy of the user vec
> > while keeping the user address pinned for the IO duration so that it
> > can safely be copied on completion in any process context.
> 
> The pinning requirement is only for read. But code keeps user-memory 
> pinned for write too. Is there any reason?

It just makes the completion simpler. I'll split the cases so we unpin
on writes after the copy during setup.

