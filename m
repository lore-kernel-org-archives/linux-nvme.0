Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C55BD40CF7
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 05:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KTZ8ox0Jyr36b7RDctOxaHbHLzY+hfFfPO/IxZNYcfs=; b=c5aL+4VwrxEpDmeslL9uOxASPZ
	YsJ0cn/LyyfL/CiUNKMk4Z79gtI/+BDcYFd5eFMNsAJ9gBJb1JOGKK2XRSD1dZNcZq8vCb5DJJysD
	zxyWMoo6Rp9NBpTkVlm90o0sV8uNl480vyHRRSlterLc+1bM5BfAq56lMrpCq2OATnxtDIf/ep8Qc
	LwbTTg1cK0MSMmBLDG7p3w8vGO8V9ZQKAbj7dbCWwQnVtPwVlgaTBS77wT/0hofNCetlWQ5AcZj3h
	y1IUk8dOrzKdYfWkunq+UQiOyRgIHPmlnfd9ox1vg7Gl9upoQ4mUqUkyCUYoqW6fvpJOq81RpJB7r
	noUg1nMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ybr-00000001ruU-3Ytj;
	Wed, 06 Nov 2024 05:29:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ybn-00000001rtj-2lWj
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 05:29:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id ADF7868AFE; Wed,  6 Nov 2024 06:29:28 +0100 (CET)
Date: Wed, 6 Nov 2024 06:29:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj gupta <anuj1072538@gmail.com>,
	Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 06/10] io_uring/rw: add support to send metadata
 along with read/write
Message-ID: <20241106052927.GA31192@lst.de>
References: <20241104140601.12239-1-anuj20.g@samsung.com> <CGME20241104141459epcas5p27991e140158b1e7294b4d6c4e767373c@epcas5p2.samsung.com> <20241104140601.12239-7-anuj20.g@samsung.com> <20241105095621.GB597@lst.de> <CACzX3AuNFoE-EC_xpDPZkoiUk1uc0LXMNw-mLnhrKAG4dnJzQw@mail.gmail.com> <20241105135657.GA4775@lst.de> <b52ecf88-1786-4b6f-b8f3-86cccaa51917@samsung.com> <20241105160051.GA7599@lst.de> <ZypGd_-HzEekrcMs@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZypGd_-HzEekrcMs@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_212935_891287_79C500D4 
X-CRM114-Status: GOOD (  28.48  )
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

On Tue, Nov 05, 2024 at 09:23:19AM -0700, Keith Busch wrote:
> > > The SQE128 requirement is only for PI type.
> > > Another different meta type may just fit into the first SQE. For that we 
> > > don't have to mandate SQE128.
> > 
> > Ok, I'm really confused now.  The way I understood Anuj was that this
> > is NOT about block level metadata, but about other uses of the big SQE.
> > 
> > Which version is right?  Or did I just completely misunderstand Anuj?
> 
> Let's not call this "meta_type". Can we use something that has a less
> overloaded meaning, like "sqe_extended_capabilities", or "ecap", or
> something like that.

So it's just a flag that a 128-byte SQE is used?  Don't we know that
implicitly from the sq?

> >  - a flag that a pointer to metadata is passed.  This can work with
> >    a 64-bit SQE.
> >  - another flag that a PI tuple is passed.  This requires a 128-byte
> >    and also the previous flag.
> 
> I don't think anything done so far aligns with what Pavel had in mind.
> Let me try to lay out what I think he's going for. Just bare with me,
> this is just a hypothetical example.
> 
>   This patch adds a PI extension.
>   Later, let's say write streams needs another extenion.
>   Then key per-IO wants another extention.
>   Then someone else adds wizbang-awesome-feature extention.
> 
> Let's say you have device that can do all 4, or any combination of them.
> Pavel wants a solution that is future proof to such a scenario. So not
> just a single new "meta_type" with its structure, but a list of types in
> no particular order, and their structures.

But why do we need the type at all?  Each of them obvious needs two
things:

 1) some space to actually store the extra fields
 2) a flag that the additional values are passed

any single value is not going to help with supporting arbitrary
combinations, because well, you can can mix and match, and you need
space for all them even if you are not using all of them.


