Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DB1C001DF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 14:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jzbq2JB8lJSn1Ax5dP77IrQRu8uz8LlgXyScUG59ycQ=; b=4djRpl7yfG8epYIRl8XrQefboo
	J4ADtqj4JqsB0GD+9xAjo2ZUjT450/mgt/7qj9ve821DY8CdNjl+0kgHLbEJybv/tEBjoEnhul4sE
	k22Ie/Xde8iT3m4xP6nTxJg7U9a6EkQzCpz09/IvY2GtAYz+IcgaVsmIjpnz/zbqWcltSfzuYAfgk
	rI+Jx6/r4OBFTsrtZxaZV+Qy4fpivf2mx63xLkQ6VvCBIDnV6FO4n+aYOFp+V7qx2GUINr5/h1Sv7
	zS8gY1vsqz5gMW8nusyb9KDDNe4ruEWFwCzDSrU4drKnLDhaYsRiwhkofk85SqlGxbFo7EEqx96Fc
	YKtZ4LDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtqRs-002UK3-0G;
	Fri, 20 Oct 2023 14:26:00 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtqRo-002UJK-2n
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 14:25:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 71845B830E6;
	Fri, 20 Oct 2023 14:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9B5C433C7;
	Fri, 20 Oct 2023 14:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697811952;
	bh=6PoCuKIk4FcuMpZ90SnR0HDzueQQozxpyNhjmXc4gV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mR0+wMwB9MgVqh1xf9P1DTnb4Kqg0R9i0FiyhIHY+UTt/x9lqjAlmAnB3moEEQ/gJ
	 bRafePEBbcDkRDiEfI9I5VjPvZ4DCioHHoJE/rYL+VR81vo7+GY5nnrWFM7fafx6ZU
	 Fufmh44bwknQy7Dyi9NCbMp3TYriYSyq7zNyggx2jT9emGI+y+AJnzEAiHGjerlOxZ
	 OrDE7MCUdkkE7BQwXJxHe3qUQH2tALhcRZRZmJzYDYPQ4z7Y9YYsW0bjP4ESibkLHP
	 Bh4atMZPi3Yc9eAP0Khrwc8potG9d3fngpWd3bFGDMkPjYcr/xX+GPWT1Nr1kJEnqb
	 aXgqgfrjvreQg==
Date: Fri, 20 Oct 2023 08:25:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	vincentfu@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Message-ID: <ZTKN7f7kzydfiwb2@kbusch-mbp>
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com>
 <20231016060519.231880-1-joshi.k@samsung.com>
 <ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com>
 <ZTBNfDzxD3D8loMm@kbusch-mbp>
 <20231019050411.GA14044@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019050411.GA14044@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_072557_075863_8BCEB5CD 
X-CRM114-Status: GOOD (  14.80  )
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

On Thu, Oct 19, 2023 at 07:04:11AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 18, 2023 at 03:26:20PM -0600, Keith Busch wrote:
> > On further consideration and some offline chats, I believe this large
> > change is a bit too late for 6.6. I think this should wait for 6.7 (and
> > stable), hopefully preserving non-root access in some sane capacity.
> > It's backed out now, and current nvme-6.6 PR does not include this
> > patch.
> 
> Umm, what are the offlist discussions?  We leave an exploitable hole
> in, so I don't think waiting any longer is an option.

Jens repeated what he told me offline on this thread here, and dropped
the pull request that contained this patch:

  https://lists.infradead.org/pipermail/linux-nvme/2023-October/042684.html

BTW, don't you still need someone with root access to change the
permissions on the device handle in order for an unpriveledged user to
reach this hole? It's not open access by default, you still have to
opt-in.

