Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BC0C25B48
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 15:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iDlzV+y2z8H3tBh9EXU4Qxp0YyVtmZgwmwZYJBZI90k=; b=s8nc4dOuhpMOzIMz2aXTvIh0zQ
	zNQPU3k9P4He43riDD7ZBRYEbkvMF269NP+M0I5F5u6vbmAuL68hP5aIco0rEugl81sIKGP+UI7nk
	AkTyKEZXPjfDBulyPRmxd4sPDbG16kJrF//wh9BLgXmt8eZuUN4377WJaODwZqigFFC5Kr0tvUlGV
	M5kUm4oktwfHCXWli+rOOnDgV+Ju8L1RdYCkbALIKBfgq9RIBFFEnwJ4w2PiWcZHXgqlS73DgWf9V
	VwyTYpJNIrLhcm+o8E5BlGx252POCqtrV5wDc3OzQH9/8pbhGjP6XaT8Clpdpsbu/M5kxaxVFpmEU
	c6sj5z+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qw24s-00Emc1-2V;
	Thu, 26 Oct 2023 15:15:18 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qw24q-00EmbL-0p
	for linux-nvme@lists.infradead.org;
	Thu, 26 Oct 2023 15:15:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A1CAACE39C6;
	Thu, 26 Oct 2023 15:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55055C433C8;
	Thu, 26 Oct 2023 15:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698333313;
	bh=wI+wGv6Oo7wOqhSkOwz6XtxndnqCso0L8Xld/XtNpZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amwxCP1EUd9hOyHB2fTUdbstJoU4QaBz3ja8wJKREaT8TgTOT+2aNOGQtu6tRBLgL
	 A5Sh2OrKJ6eddrJePv7BsPIHfhoKXuVCYwTXBZldV3I/ZeynYbRnI/qd+nz4VIogbs
	 //k3yKr+7uKxzCOT0MlwlbGJoGQbysLiYbNroaGu3Du+/6AmF7BQoth7cZ2lREsJ3N
	 k5hG39bjQhWk2pZbtuTweRH8NjpImMGLvVGj8CBjTfX2BMjDLeUQcatx8FX6+aJ0TI
	 wzRgRRIqAP4P7lysP6EWjmOyILnFPTM7YpWrLjFopPLY/2vQbtdW4Auw36M68eQVxn
	 NXZCE8KUVhqkA==
Date: Thu, 26 Oct 2023 09:15:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	vincentfu@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Message-ID: <ZTqCf27cj5ahr5r7@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com>
 <20231016060519.231880-1-joshi.k@samsung.com>
 <ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com>
 <ZTBNfDzxD3D8loMm@kbusch-mbp>
 <20231019050411.GA14044@lst.de>
 <ZTKN7f7kzydfiwb2@kbusch-mbp>
 <20231023054456.GB11272@lst.de>
 <ZTaOzORdmFwxCW1c@kbusch-mbp>
 <20231024070759.GE9847@lst.de>
 <d3a0c5ff-8d10-aa8f-cfce-a87a09f880c3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3a0c5ff-8d10-aa8f-cfce-a87a09f880c3@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_081516_469523_A31F64D1 
X-CRM114-Status: GOOD (  19.60  )
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

On Thu, Oct 26, 2023 at 08:01:36PM +0530, Kanchan Joshi wrote:
> On 10/24/2023 12:37 PM, Christoph Hellwig wrote:
> > On Mon, Oct 23, 2023 at 09:18:36AM -0600, Keith Busch wrote:
> >> On Mon, Oct 23, 2023 at 07:44:56AM +0200, Christoph Hellwig wrote:
> >>> Yes, you need someone with root access to change the device node
> >>> persmissions.  But we allowed that under the assumption it is safe
> >>> to do so, which it turns out it is not.
> >>
> >> Okay, iiuc, while we have to opt-in to allow this hole, we need another
> >> option for users to set to allow this usage because it's not safe.
> >>
> >> Here are two options I have considered for unpriveledged access, please
> >> let me know if you have others or thoughts.
> >>
> >>    Restrict access for processes with CAP_SYS_RAWIO, which can be granted
> >>    to non-root users. This cap is already used in scsi subsystem, too.
> > 
> > Well, that's sensible in general.
> 
> With that someone needs to make each binary (that wants to use 
> passthrough) capability-aware by doing:
> 
> setcap "CAP_SYS_RAWIO=ep" <binary>
> 
> Seems extra work for admins (or distros if they need to ship the binary 
> that way).

The way I usually see it done is add the capability to the user so any
binary executed by that user already has the caps.

