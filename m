Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0305C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 07:40:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE34D206B5
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 07:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uZ4d9ViO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE34D206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mW+pDf/CMu4/CHPYrc1my6fce1YAx4BRKD4KBvoucXQ=; b=uZ4d9ViOoYEAGAFd2xrpVLGnF
	ilpOHmHCzNX52M6/IfxVUrhIgOfMfVFWafdnCyTz4yAeA+cT8jZhQxTdw5F63MAHmcdDOJOhY3eyh
	ml+Uoq93fDDvgFrwOyLUPXBhOPpK7fVvl97WaEln9TniUfMmvrle7imkVnoNX0yAQlyhAu78pjjI7
	XfKvXKHQMhq57pNeq/DiIm4fd2dF9iIIKuNXGP5N8qqRo0Exa1mmBjwpxcCrvdHWjdiD++FQOz2xB
	MTlqWJxnsb0Zjl+XSKhl1dda7aelDtiE/OyFPFulvr+B6iPakJtyCFwYBp5fhAGDi4BUbp2Bi3v2I
	UHEbZCB9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8IiB-0003IW-O3; Wed, 19 Aug 2020 07:40:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8Ii9-0003Hb-2R
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 07:40:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 910686736F; Wed, 19 Aug 2020 09:40:35 +0200 (CEST)
Date: Wed, 19 Aug 2020 09:40:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Javier Gonzalez <javier@javigon.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200819074035.GA21991@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
 <20200818155004.GA26688@lst.de>
 <20200818180428.obipue6adpqqpwjj@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818180428.obipue6adpqqpwjj@MacBook-Pro.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_034041_335894_B0342DFD 
X-CRM114-Status: GOOD (  19.38  )
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
Cc: axboe@kernel.dk, Damien.LeMoal@wdc.com,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, johannes.thumshirn@wdc.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Nitesh Shetty <nj.shetty@samsung.com>, kbusch@kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 18, 2020 at 08:04:28PM +0200, Javier Gonzalez wrote:
> I understand that you want vendor alignment in the NVMe driver and I
> agree. We are not pushing for a non-append model - you can see that we
> are investing effort in implementing the append path in thee block layer
> and io_uring and we will continue doing so as patches get merged.
>
> This said, we do have some OEM models that do not implement append and I
> would like them to be supported in Linux. As you know, new TPs are being
> standardized now and the append emulation is the based for adding
> support for this. I do not believe it is unreasonable to find a way to
> add support for this SSDs.

I do not think we should support anything but Zone Append, especially not
the new TP, which is going to add even more horrible code for absolutely
no good reason.

> If you completely close the door this approach, the alternative is
> carrying off-tree patches to the several OEMs that use these devices.
> This is not good for the zoned ecosystem nor for the future of Zone
> Append.

I really don't have a problem with that.  If these OEMs want to use
an inferior access model only, they have to pay the price for it.
I also don't think that proxy arguments are very useful.  If you OEMs
are troubled by carrying patches becomes they decided to buy inferior
drivers they are perfectly happy to argue their cause here on the list.

> Are you open to us doing some characterization and if the impact
> to the fast path is not significant, moving ahead to a Zone Append
> emulation like in SCSI? I will promise that we will remove this path if
> requests for these devices terminate.

As said I do not think implementing zone append emulation or the TP that
shall not be named are a good idea for Linux.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
