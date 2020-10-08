Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6925CC4363C
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 14:56:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 031A821789
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 14:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cvksvNTW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p+bjWLUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031A821789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z8BNF6lWpvihl+dJu++NGl+IYwoN7h6N13X4dEqOH2M=; b=cvksvNTWTjN1w8eyS7ic8tJUU
	ql2d7s6cCFQY2XwlHdOKoXCcVAKny9WB61vDoz+8kXl3ZnJ52fctqueT9Wqdx/7cKo4DzJ/MIotWd
	fTNx4cDzR2QDrGOGuh9pWVHcz8Uoso18w/WYz1zsonaP7XRa+MGJLK7yUfjvukUzswFSv/PmNfP5g
	9lKIZ8oMk4lV7rdtt2eFIx9MAnSA+CVOySbGfuGKuwz/7Byuj+R3wj4LMe8xcyJ0drd/BmFBx3YMO
	XkZnf7HH6t9DeCQdjAlFtTwLh/slrkmG4Nr2+NdY9emNZhJj+4vyUY5scRG2rs3ZivegEVoUVn0Oh
	HmEPM3xNw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQXL7-0002lj-Os; Thu, 08 Oct 2020 14:56:17 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQXL6-0002lb-BO
 for linux-nvme@merlin.infradead.org; Thu, 08 Oct 2020 14:56:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Mvs3fADzgkCcGR26Zeo/XCY+wu47PGGXRXwKmEJQoaM=; b=p+bjWLUugdwcPB0UxP8LJpA6UB
 ZWJ4DimINecNmcZ9dNcTnV7eYNykXL631aX6jg5iAysQvDdPfcS8coVKYY4GVanX5hYRZ5YksFXdN
 UCTm/dA6+cbzs3I55NbWTR1/r/8Msrbd4+agisBVFtXAbgW7flMDw5PX/IjK7FbTAUahmSGDiCWmU
 UbPvGRdv4FNEG4wj06NXVXXrAS7NkGXwyy+kGOdmBmgfZwKcDV8HELz5uxEwHZgUA6rlb5DYmXG9B
 vkvPOm9YPND4XUzugkQXXgmlC5gmgkM5m0b76MEpzYc+SZgzo6mbkdi27fiJvSNjbw8l4/9rqKrtO
 BDPDMlKw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kQXL4-0006BF-Ua; Thu, 08 Oct 2020 14:56:14 +0000
Date: Thu, 8 Oct 2020 15:56:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme updates for 5.10
Message-ID: <20201008145614.GA23622@infradead.org>
References: <20201008141041.GA1493538@infradead.org>
 <2b4ad1d6-3d77-d14e-2275-0f9326b19514@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2b4ad1d6-3d77-d14e-2275-0f9326b19514@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 08, 2020 at 08:52:50AM -0600, Jens Axboe wrote:
> On 10/8/20 8:10 AM, Christoph Hellwig wrote:
> > The following changes since commit 103fbf8e4020845e4fcf63819288cedb092a3c91:
> > 
> >   scsi: megaraid_sas: Added support for shared host tagset for cpuhotplug (2020-10-06 08:33:44 -0600)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-08
> > 
> > for you to fetch changes up to c4485252cf36ae62c8bf12c4aede72345cad0d2b:
> > 
> >   nvme-core: remove extra condition for vwc (2020-10-07 07:56:20 +0200)
> > 
> > ----------------------------------------------------------------
> > nvme update for 5.8:
> > 
> >  - fix a controller refcount leak on init failure (Chaitanya Kulkarni)
> >  - misc cleanups (Chaitanya Kulkarni)
> >  - major refactoring of the scanning code (me)
> 
> Seems to be a typo here, 5.8?

should be 5.10 of course.

Do you want a resend as this is also in the tag?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
