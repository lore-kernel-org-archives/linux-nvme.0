Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7AAC3ABDF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2024 06:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e/0YPUvuaLiWEAkJzh1AOKZrqRluEA0zzP4hr9kHNrg=; b=qYyB7phctKBpoIN4gbYi0lbGzr
	wFkBhEuBfHCyYYdx1oZY1y5C1+/TvmHySK6b8pHWrdKhUmuTlXOz61LgoCpPBRGCgyLkabbLtl1Ca
	+jHZsW7uEJ5hs9I6SC2/PgoTOpKdVIcP0fyXL7Ww9CtPVhEqJkdMIwgILHHAhQXqA9H0HIjH5gPm2
	W9WKOJYSZSgqZ64QLd4spa1ruJPwOXmzVb3a8fzlyg1AopNBxoXUiKyNhy/woOwrrt1BCsqrVsr3N
	APaxvS9Ntst9/YfTKMDrwnM2q0V07/VXd86dyuqX7YtKuSFwx3OakDGVtXx2lN9k+Qg21rGmFqzLL
	Lh21gobg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqRZS-00000005TiD-1ejd;
	Tue, 17 Sep 2024 06:20:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqRZP-00000005Thi-0dlm
	for linux-nvme@lists.infradead.org;
	Tue, 17 Sep 2024 06:20:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C391B227ACB; Tue, 17 Sep 2024 08:20:07 +0200 (CEST)
Date: Tue, 17 Sep 2024 08:20:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	jlayton@kernel.org, chuck.lever@oracle.com, bvanassche@acm.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v5 4/5] sd: limit to use write life hints
Message-ID: <20240917062007.GA4170@lst.de>
References: <20240910150200.6589-1-joshi.k@samsung.com> <CGME20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c@epcas5p3.samsung.com> <20240910150200.6589-5-joshi.k@samsung.com> <20240912130235.GB28535@lst.de> <e6ae5391-ae84-bae4-78ea-4983d04af69f@samsung.com> <20240913080659.GA30525@lst.de> <4a39215a-1b0e-3832-93bd-61e422705f8b@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a39215a-1b0e-3832-93bd-61e422705f8b@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240916_232015_369397_93785801 
X-CRM114-Status: GOOD (  29.03  )
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

On Mon, Sep 16, 2024 at 07:19:21PM +0530, Kanchan Joshi wrote:
> > Maybe part of the problem is that the API is very confusing.  A smal
> > part of that is of course that the existing temperature hints already
> > have some issues, but this seems to be taking them make it significantly
> > worse.
> 
> Can you explain what part is confusing. This is a simple API that takes 
> type/value pair. Two types (and respective values) are clearly defined 
> currently, and more can be added in future.

I though I outlined that below.

> > But if we increase this to a variable number of hints that don't have
> > any meaning (and even if that is just the rough order of the temperature
> > hints assigned to them), that doesn't really work.  We'll need an API
> > to check if these stream hints are supported and how many of them,
> > otherwise the applications can't make any sensible use of them.
> 
> - Since writes are backward compatible, nothing bad happens if the 
> passed placement-hint value is not supported. Maybe desired outcome (in 
> terms of WAF reduction) may not come but that's not a kernel problem 
> anyway. It's rather about how well application is segregating and how 
> well device is doing its job.

What do you mean with "writes are backward compatible" ?

> - Device is perfectly happy to work with numbers (0 to 256 in current 
> spec) to produce some value (i.e., WAF reduction). Any extra 
> semantics/abstraction on these numbers only adds to the work without 
> increasing that value. If any application needs that, it's free to 
> attach any meaning/semantics to these numbers.

If the device (or file system, which really needs to be in control
for actual files vs just block devices) does not support all 256
we need to reduce them to less than that.  The kernel can help with
that a bit if the streams have meanings (collapsing temperature levels
that are close), but not at all if they don't have meanings.  The
application can and thus needs to know the number of separate
streams available.


