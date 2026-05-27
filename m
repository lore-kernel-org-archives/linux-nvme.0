Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E996CD5BD0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 13:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HXQdIUOV9WxRKeofDM+Fjt8PraYHjhn0wqolOHXj/L8=; b=wI2vJ5GcaQfvnzt4TzWQRsTFYB
	tJl3NDFzCj6g//x5g42C+HT+JSONnkWiQMq5FF5sxg7XhLAawUwzWoLi7AILAU91/1Y9suLWIWXKq
	QTqcOJ6UxM62enOvxoGsOglpJOOYNhOT5xiawpXPmpzJm6VSBB/fMGTLtw3pZjOaNlMjtXt6P9pwK
	Bb5AFbm4DAbEZEFF7AoJ6lnLSqGfXQdODLPxJtVR1qnAmh1IiTT52kExD7Iz20bV1kQEwAwx9nLZg
	41P3qNrL6d9E9tr5iiMcCY/tNKp0ppCAz1r8TKNnqkM4Ax2AxRzrcaa9H056HJuh2Fzuax7dBwoVj
	mPrCHP8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEJS-00000004C4M-0RHH;
	Wed, 27 May 2026 13:28:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEJP-00000004C3s-3Apr
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 13:28:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4DE6068B05; Wed, 27 May 2026 15:28:41 +0200 (CEST)
Date: Wed, 27 May 2026 15:28:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, nilay@linux.ibm.com
Subject: Re: [PATCHv2 1/2] block: export passthrough stats enabled
Message-ID: <20260527132841.GA12022@lst.de>
References: <20260526153921.2402015-1-kbusch@meta.com> <20260526153921.2402015-2-kbusch@meta.com> <20260527131458.GA10351@lst.de> <ahbwAxG1Pj2z3Q21@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahbwAxG1Pj2z3Q21@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_062843_936465_AA7CE4B8 
X-CRM114-Status: GOOD (  16.95  )
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

On Wed, May 27, 2026 at 07:22:11AM -0600, Keith Busch wrote:
> On Wed, May 27, 2026 at 03:14:58PM +0200, Christoph Hellwig wrote:
> > > +static inline bool blk_rq_passthrough_stats(struct request *req,
> > > +					    struct request_queue *q)
> > 
> > The kerneldoc requested last time would be really nice to have.
> > Also, now that this is a public API killing the q argument and
> > just using req->q would make the API easier to understand.
> 
> Oh, my missing kerneldoc is clearly a problem. We need a separate
> argument for the request_queue because the q we want to count stats for
> may not be the one providing the request.

Even more argument for having the documentation :)


