Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A71ED5AE74
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 08:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V2TgsDpE5Xw1j6EAOxSi00KCJV4qJGmw0vEHKzIt2fY=; b=hPzAEihYB3WEy3EVXisfZ7Qzu/
	f512HFNssIrHa2a7fD9lih1fdovKhOXovOUK+teLlYbVLYAL+q3QKhvaKY3NHLsqHWK1+vLaU05oY
	x8lciyKwTqU0E8DWPAlLWmE1TYwClrzK7HnOMlVzKtiahk3ePIvlu+IgCo7EXyANVJ6vkoHEtohgx
	WyMXahcd9hO26/L3USCy3MbEBiu3MPMXmMaxv+fD0PZ/ar23zUvWrTx4yDk/CkFM7TXy8GB9t1teS
	MWi39pH/Vkdx7Mnsz/abpPssqnf3fgwuQfrAau8Fg4ytKre6ZvGupG+u44uG1bPRvGoG8qfBaFu27
	qpxbzT4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8yA8-00000006B4G-49q7;
	Thu, 07 Nov 2024 08:46:45 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8x6f-0000000611a-2NwS
	for linux-nvme@bombadil.infradead.org;
	Thu, 07 Nov 2024 07:39:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V2TgsDpE5Xw1j6EAOxSi00KCJV4qJGmw0vEHKzIt2fY=; b=qlD/57Rt7NstUuFiSLRFLkT5/9
	bSCApIrpwyM9VaiX14wzJZ34bHK+4WnFo6RDbEKVY25y1Q6cRmdv/uHw/feWssvX0JudWnV/J32IM
	SbVmM8rC9ZQFW0aXftK+EgYFXoastccTqWtEZ2HofWpjSe5+eL3I++4DmVFqXBI3YRN5AlZR2lvJC
	FreI5qXnLl1lTv3q/2OEoIO4juwidoLbEnnkOUkxWDqJATIhXlD3DjYhRXCLbV8HJ/nAulmw8yds/
	ky3PYRUlyuRcx1MXJmHcqxQzITTUnb+ilVEewcOoHtEByto0Lk+xR52zcoqkwnBoBEABQqjA1zaTP
	6Ia/wdOw==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8x6c-0000000C51F-0U9o
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 07:39:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9D0E4227AA8; Thu,  7 Nov 2024 08:38:52 +0100 (CET)
Date: Thu, 7 Nov 2024 08:38:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>,
	axboe@kernel.dk, kbusch@kernel.org, martin.petersen@oracle.com,
	asml.silence@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v8 06/10] io_uring/rw: add support to send metadata
 along with read/write
Message-ID: <20241107073852.GA5195@lst.de>
References: <20241106121842.5004-1-anuj20.g@samsung.com> <CGME20241106122710epcas5p2b314c865f8333c890dd6f22cf2edbe2f@epcas5p2.samsung.com> <20241106121842.5004-7-anuj20.g@samsung.com> <20241107055542.GA2483@lst.de> <CACzX3As284BTyaJXbDUYeKB96Hy+JhgDXs+7qqP6Rq6sGNtEsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACzX3As284BTyaJXbDUYeKB96Hy+JhgDXs+7qqP6Rq6sGNtEsw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_073902_464205_DCAE9707 
X-CRM114-Status: GOOD (  29.48  )
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

On Thu, Nov 07, 2024 at 12:56:03PM +0530, Anuj gupta wrote:
> > > +/* extended capability flags */
> > > +#define EXT_CAP_PI   (1U << EXT_CAP_PI_BIT)
> >
> > This is getting into nitpicking, but is the a good reason to have that
> > enum, which is never used as a type and the values or only defined to
> > actually define the bit positions below?  That's a bit confusing to
> > me.
> 
> The enum is added to keep a check on the number of flags that can
> be added, and make sure that we don't overflow.

Umm, it is pretty clear you overflow when you do a

#define EXT_CAP_FOO   (1U << 16)

and assign it u16.  Just about every static checker will tell you
even if you don't instantly see it.  Basic testing will also show
you it won't work..

> > Also please document the ABI for EXT_CAP_PI, right now this is again
> > entirely undocumented.
> >
> 
> We are planning to document this in man/io_uring_enter.2 in the liburing
> repo, right after this series goes in. Or should it go somewhere else?

Well, it needs to go into the code actually explaining what the flag
does.  Throwing an undocumented flag into a uapi is just asking for
trouble.

> The attempt here is that if two extended capabilities are not known to
> co-exist then they can be kept in the same place. Since each extended
> capability is now a flag, we can check what combinations are valid and
> throw an error in case of incompatibility. Do you see this differently?

You only know they can't co-exist when you add them, and at that point
you can add a union.

> 
> >
> > struct io_uring_sqe_ext {
> >         /*
> >          * Reservered for please tell me what and why it is in the beginning
> >          * and not the end:
> >          */
> >         __u64   rsvd0[4];
> 
> This space is reserved for extended capabilities that might be added down
> the line. It was at the end in the earlier versions, but it is moved
> to the beginning
> now to maintain contiguity with the free space (18b) available in the first SQE,
> based on previous discussions [1].

I can't follow the argument.  But if you reserve space at the beginning
of the structure instead of the usual end you'd better add a comment
explaining it.


