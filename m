Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABCCC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jul 2022 09:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YMF1R+atiV7XYneSvuOle+Nn7z0QFySdiGNzm3ArXUI=; b=qGhqiOD8y2qh5N78tJPSqnem6w
	Fm0fgFiAW3+l/ZzN6khyqIRA7KGxxXi1TGuyxncCJytXBveTGRzrF/rfO0YgkMm/boI/OsqrfKq/M
	XWcGZyZ/rktjA7yEMRnpXb30HWvmVlfEUMTNyZ0KJNB4hCog52PoiVShwjbKQvg/9JD6mXtP6fZPR
	nDvP0YeLtxRQS8pNfAA7SvRCH3rSbIe3SPd98beMTqqb8kCRuV8LBfuLITUg2dKwmR7UKM6g0fGrA
	0ubtExy7yWsmt0hxjNR65C0SLIftagca7OvXPvGh+a4xmriLzCGKI40DJD+DEDcc7bAQzYC9fDCZr
	bseYqqzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE5bQ-002z8M-PT; Wed, 20 Jul 2022 09:02:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE5bN-002z2U-K0
	for linux-nvme@lists.infradead.org; Wed, 20 Jul 2022 09:02:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 69B8668AFE; Wed, 20 Jul 2022 11:02:34 +0200 (CEST)
Date: Wed, 20 Jul 2022 11:02:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	gost.dev@samsung.com, k.jensen@samsung.com,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH 3/5] nvme: refactor namespace probing
Message-ID: <20220720090234.GB18210@lst.de>
References: <20220718052503.235270-1-hch@lst.de> <CGME20220718052519eucas1p23ea18838828398065cf55f6c9ccb245a@eucas1p2.samsung.com> <20220718052503.235270-4-hch@lst.de> <20220720081912.uspwuwnsxna2pgos@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720081912.uspwuwnsxna2pgos@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_020241_831301_74986AC3 
X-CRM114-Status: GOOD (  12.07  )
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

On Wed, Jul 20, 2022 at 10:19:12AM +0200, Joel Granados wrote:
> > +struct nvme_ns_info {
> > +	struct nvme_ns_ids ids;
> > +	u32 nsid;
> > +	__le32 anagrpid;
> > +	bool is_shared;
> > +	bool is_ready;
> > +};
> Nitpick after looking at this for the second time:
> Should we use tabs instead of spaces to increase readability here?

Not sure why that would help.

> > -	unsigned lbaf = nvme_lbaf_index(id->flbas);
> > +	struct nvme_id_ns *id;
> > +	unsigned lbaf;
> Checkpatch.pl has a warning here for use of 'unsigned int' instead of
> just 'unsigned'

checkpatch is, as so often, rather misguided here.

