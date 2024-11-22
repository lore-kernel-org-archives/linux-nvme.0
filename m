Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB1EE6918F
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 19:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HDMKzbwWOMWTM5BF5rByY0lyc5b7M4/t/D+1XsZ3TPs=; b=mbAyZsyF11spyCd+IRzs6LvfY5
	OGd4oooocYC10lKGCJIjA7+jnBHym2dO8V+QpTykPutegLQTsCSR+Ap5vFPU9fBiLeMSivdr2ZE0L
	P2AQxRDXSO0XP1Y2WTj6p7WhebVhGnzaIx9wm6fSmh1LSfOcC554OVk8DkJfIwH2LbY35IYw7Eu1V
	wUuQazm8LC8oRmYjEsJtbjcPNF2HPvyxZwoKZv1cnZORC7zZJRo2Mm6SzSXIrH0R9rHDX1ZqftPO+
	GFNf6pQVBAHBpx5HydqwKGKuhNroGHAJ1UbnmNpO3jkCIoDcyBDM1WSIjQef5uK99QHQMSvvm2Mxs
	HTtSUBTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEZSc-00000003CvZ-2di5;
	Fri, 22 Nov 2024 19:36:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEZSZ-00000003CvC-35gJ
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 19:36:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5B3975C4D3B;
	Fri, 22 Nov 2024 19:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3883AC4CECE;
	Fri, 22 Nov 2024 19:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732304214;
	bh=HEd5aBJ3V34Onf664GRVCd2iBvwbTpBtXpJbEPHxGho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+daD2HiAAZBrqAPWUK5vzZn/dwyWipto4WAyaAHb7vLkTjZALX6TcdkZllkg9/v/
	 XPYQ6q5CJV7JzSUVbE9DIFagxXYn3tOT7+l89vKH/gVMNqsEqe1zBa7u0k8P6ML9yw
	 ell+/GhlNHaffIgctGUdV2ECTh2qchW3kalTQtDYHWjbWQBGSTFHqoOuDvsK89EqY8
	 tE+74ufe4nDWb1yi/I532Hb4as8ISsP3hKDE12Cft3PRar3yZRfJRjejBD1TmTYZDn
	 HQ8Xx08Dax7fGvu4OPOmVcLZ7kP3Ca6DSY+MO1fjyHCnWRCWngVk4aQQzNPD1q20XH
	 nL2usENwwAaDA==
Date: Fri, 22 Nov 2024 12:36:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Robert Beckett <bob.beckett@collabora.com>
Cc: =?iso-8859-1?Q?=22Pawel_Anikiel=22?= <panikiel@google.com>,
	axboe <axboe@kernel.dk>, hch <hch@lst.de>,
	kernel <kernel@collabora.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	sagi <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <Z0DdU9K9QMFxBIL8@kbusch-mbp.dhcp.thefacebook.com>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241114113803.3571128-1-panikiel@google.com>
 <1932ad8722a.102613bdb3737.769617317074446742@collabora.com>
 <CAM5zL5rKsEd1EhOx1AGj9Au7-FQnJ5fUX2hLPEDQvmcrJXFFBg@mail.gmail.com>
 <1932b818328.ad02576784895.6204301822664878956@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1932b818328.ad02576784895.6204301822664878956@collabora.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_113655_860384_A96B680E 
X-CRM114-Status: GOOD (  28.98  )
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

On Thu, Nov 14, 2024 at 04:28:48PM +0000, Robert Beckett wrote:
>  ---- On Thu, 14 Nov 2024 14:13:52 +0000  Paweł Anikiel  wrote --- 
>  > On Thu, Nov 14, 2024 at 2:24 PM Robert Beckett
>  > bob.beckett@collabora.com> wrote:
>  > > This is interesting.
>  > > I had the same idea previously. I initially just changed the hard coded 256 / 8 to use 31 instead, which should have ensured the last entry of each segment never gets used.
>  > > When I tested that, it not longer failed, which was a good sign. So then I modified it to only do that on the last 256 byte segment of a page, but then is started failing again.
>  > 
>  > Could you elaborate the "only do that on the last 256 byte segment of
>  > a page" part? How did you check which chunk of the page would be
>  > allocated before choosing the dma pool?
>  > 
>  > > I never saw any bus error during my testing, just wrong data
>  > > read, which then fails image verification. I was expecting iommu
>  > > error logs if it was trying to access a chain in to nowhere if it
>  > > always interpreted last entry in page as a link. I never saw any
>  > > iommu errors.
>  > 
>  > Maybe I misspoke, the "bus error" part was just my speculation, I
>  > didn't look at the IOMMU logs or anything like that.
>  > 
>  > > I'd be glad to if you could share your testing method.
>  > 
>  > I dumped all the nvme transfers before the crash happened (using
>  > tracefs), and I saw a read of size 264 = 8 + 256, which led me to the
>  > chaining theory. To test this claim, I wrote a simple pci device
>  > driver which creates one IO queue and submits a read command where the
>  > PRP list is set up in a way that tests if the controller treats it as
>  > a chained list or not. I ran it, and it indeed treated the last PRP
>  > entry as a chained pointer.
> hmm, I guess a simple debugfs trigger file could be used to construct
> specially formulated requests. Would work as a debug tool.
>
> Though at this point, the simple dmapool alignment param usage fixes
> both of these scenarios, so it will be kind of academic to continue
> putting effort in to understand this. I am trying to get answers out
> of the vendor to confirm any of these theories, which I hope will be
> more conclusive than our combined inference from testing.

Any updates on this? I'm satisfied with the quirk patch, so we can move
this forward if you're okay with the current understanding.

