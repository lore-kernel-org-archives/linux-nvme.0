Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0322DD3E78C
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 06:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RCOrgz2reIaOZGRK6UMilJ9dv/OAXy8rYDF87JmeAUA=; b=fFMuabaFGGKC7tS7A2oyfxvyNY
	7x8WFOwPTkVRhpveIy79BGQJLWeKITDxChZpxfcuaxjh0tPP9qPMMlTEtEw6pSuanL4jzuBUB5Ji6
	bemKIYUDlKtz8rSFPp+01SMxAEV124YCM6MnM2WK6iZcvAlyT3cWKVBKtqYbGpyDP+KnRNpyTzC/M
	ZvmtAtxwvUwHmrAal0l+47W1xMHJMEYVR20CiXGABHjf6FYO9nZFQqCMVCSvvro360UH+khNKSNz+
	mHfW1Bu1qfrFmJqUZF101KGG3Hefg4xvfnwqYftnNPVdLHn8HPniZHUtJzRZExaLTDCQJ2QCQy8rH
	TEImpuXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8ZMF-00000001y02-26jX;
	Wed, 06 Nov 2024 06:17:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8ZHZ-00000001xJl-2uoq
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 06:12:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E012268AFE; Wed,  6 Nov 2024 07:12:41 +0100 (CET)
Date: Wed, 6 Nov 2024 07:12:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
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
Message-ID: <20241106061241.GA32101@lst.de>
References: <CGME20241104141459epcas5p27991e140158b1e7294b4d6c4e767373c@epcas5p2.samsung.com> <20241104140601.12239-7-anuj20.g@samsung.com> <20241105095621.GB597@lst.de> <CACzX3AuNFoE-EC_xpDPZkoiUk1uc0LXMNw-mLnhrKAG4dnJzQw@mail.gmail.com> <20241105135657.GA4775@lst.de> <b52ecf88-1786-4b6f-b8f3-86cccaa51917@samsung.com> <20241105160051.GA7599@lst.de> <ZypGd_-HzEekrcMs@kbusch-mbp.dhcp.thefacebook.com> <20241106052927.GA31192@lst.de> <e68f0127-a8a8-46da-8e68-7a2f3af73627@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e68f0127-a8a8-46da-8e68-7a2f3af73627@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_221245_986052_E99E5D8A 
X-CRM114-Status: GOOD (  18.99  )
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

On Wed, Nov 06, 2024 at 11:30:45AM +0530, Kanchan Joshi wrote:
> >   1) some space to actually store the extra fields
> >   2) a flag that the additional values are passed
> 
> Yes, this is exactly how the patch is implemented. 'meta-type' is the 
> flag that tells additional values (representing PI info) are passed.
> 
> > any single value is not going to help with supporting arbitrary
> > combinations,
> 
> Not a single value. It is a u16 field, so it can represent 16 possible 
> flags.
> This part in the patch:
> 
> +enum io_uring_sqe_meta_type_bits {
> +       META_TYPE_PI_BIT,
> +       /* not a real meta type; just to make sure that we don't overflow */
> +       META_TYPE_LAST_BIT,
> +};

Well, then it's grossly misnamed and underdocumented.  For one the
meta name simply is wrong because it's about all extra features.
Second a type implies an enumeration of types, not a set of flags.

So if you actually name this extended_features or similar and clearly
document it might actually make sense.


