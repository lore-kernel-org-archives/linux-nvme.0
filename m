Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D27C04A6A
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Aug 2023 05:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TE+ouoIqEz4IDU7UMwRykLkO97f8FPIcCydv1N4G4LU=; b=cZYvpLve2mPbvT1n39exy8uwA/
	X7qyN7/YomeS/Sk/GnUM7QKXdwOw7nG4xP2GQe7CmuRU7tjzoJGi7UugYEZ1Sj1hsEwjxkmEWbB1H
	4GUnxg2V3/819CbfvNaaBAkapmeOXr6f+mV9eyDEjtvpGdFVjGB8vT1IpMx/baICAWqCx6OHAQiO+
	ZC42L/DOWkt1QidtBXr0PydtklKIbRJtw/eICGrrbnHMB7p+uUzpzbv1TtG9/VBjdgGCjk9lapob0
	MV8/4TqEcA/Q+Gb1HIgrBUslGSTBvFB4YSScuw2u3o1FA+dspfIWyVwrkOIVCL4TEIYR5knfztEfJ
	1y3uemqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUhdK-00Cjnv-05;
	Sat, 12 Aug 2023 05:57:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUhdH-00Cjme-2U
	for linux-nvme@lists.infradead.org;
	Sat, 12 Aug 2023 05:57:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4578F64366;
	Sat, 12 Aug 2023 05:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58012C433C7;
	Sat, 12 Aug 2023 05:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1691819870;
	bh=ZThS3z/Cr+ADxRaKGfkjS2bncKPUrhLfkLKGIPqXyLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tC4fybrKzzSIpZkP6LpWo0wc5dCoYRMOxtLlRsCz5BEpNnK+aghoJXG2w5NJ2pDlK
	 1rw5+GJQtMzHq927M990P8aQpmHbs4F7CuunUc7TKGyK+ZJM/YnvN1Or9hEYmQZmLc
	 Bn1xTrEBhh4Lw4d5H2xpQV/egVolQyHxfKEALo4w=
Date: Sat, 12 Aug 2023 07:57:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Keith Busch <kbusch@kernel.org>
Cc: August Wikerfors <git@augustwikerfors.se>, stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Christoph Hellwig <hch@lst.de>, axboe@fb.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	nilskruse97@gmail.com, David.Chang@amd.com
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Message-ID: <2023081215-stock-huddling-03c9@gregkh>
References: <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se>
 <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com>
 <20230731201047.GA14034@lst.de>
 <36319a0f-34a6-9353-bc52-4d4d0fac27a5@amd.com>
 <20230801112403.GA3972@lst.de>
 <ae7fb9b2-d692-f9b8-5130-4555cc489846@amd.com>
 <ZMlrGNw5OMW3yxId@kbusch-mbp.dhcp.thefacebook.com>
 <b2e741b3-b581-40fe-2c28-e4660f52003d@amd.com>
 <0f422dbe-2e3f-4401-be87-2963cbbc1234@augustwikerfors.se>
 <ZNahNYGd3L8YYtiQ@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNahNYGd3L8YYtiQ@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_225751_855504_64F1A5DF 
X-CRM114-Status: GOOD (  13.52  )
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

On Fri, Aug 11, 2023 at 02:59:33PM -0600, Keith Busch wrote:
> On Fri, Aug 11, 2023 at 10:19:35PM +0200, August Wikerfors wrote:
> > On 2023-08-01 22:34, Mario Limonciello wrote:
> > > If you can still change it before sending out can you add a stable tag
> > > as well?
> > 
> > This didn't get added in time, so, stable team, please backport:
> > 
> > 688b419c57c1 ("nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and 512G")
> 
> Perhaps bad form on my end for relying on it, but in my experience, the
> stable bot has a great record on auto selecting nvme quirks.

It's better for everyone if you mark it for stable, so you know it will
get reviewed, otherwise you are at the mercy of our scripts and free
time to dig for patches :)

thanks,

greg k-h

