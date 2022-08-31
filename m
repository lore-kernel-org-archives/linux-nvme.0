Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD13AECAAD4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 21:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+e2KyNq8htAbaRkJoJGIVXxX+Vbj7WX7arDayr4Vf1c=; b=F6zepUbLts6Yn0qUdvQp6yVIXP
	luv5rIeF1ZGVuwFnbo7wTQDtIKbjMaIqViCWZXSDanWMObLmONprv1UYSoLM310mUQ3DETEBarue2
	f4wI0VEudTl34t4HSvlwQNl0NixpDoplJCf3U26/XGMnX8FOF77OglsD2jueKkialflRfwFeHBOzf
	6V3cp6FJ6cHwgoVqFxMjtvgh1IjUTOlFgSJcXhMPVXfkKcZrVcJWUOC2iiGPMCosA855KHexnNUkV
	GbKGaW8vKyy0t/gITDB3LYnHuTdZhX4LxHHnr3cgKM8/A/LXuo0fp9LOSaBSABaAnghEqTYhnqAqk
	71QEeBAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTV7u-008Is4-Cs; Wed, 31 Aug 2022 21:19:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTV7r-008IrT-0S
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 21:19:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6A2A2619D6;
	Wed, 31 Aug 2022 21:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8826FC433D6;
	Wed, 31 Aug 2022 21:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661980793;
	bh=EuFVtF27UHzZ95m2iAVZr88pBg2NFFrI0iNLOelRyrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wljct3mBAodbROj8O/9kcBwlEJPrCw4g2YpmVaVswGofxdOZBYvrIE8+6eh9YfBir
	 klg/v3l7dfsHdTX/SQxogCaudW9U6u7Wz+t1mLOORCl8zws8d83jAwrHCCgFVtw+X0
	 +MIS81RaFP9pSm2aLQVGY1p5T8j/tr8Yu3ob9Tkj5O+2h8lSEX6jzIYeIknePODM2x
	 zXXQak7U22takWnvrBDyCc2LOBM6JxjOEi98IUOj5EBTrxZgddGU0lVtKQwNxHlrzG
	 VZVwDYklnwrT8kqS+2ziWX65x4wuzl5efs6oClsQnV+pbWPGo0XPFuGaJBfCtgiRk5
	 zpw1BC5hLlrAQ==
Date: Wed, 31 Aug 2022 15:19:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCHv3 0/7] dma mapping optimisations
Message-ID: <Yw/Qdf+280vZSYU4@kbusch-mbp.dhcp.thefacebook.com>
References: <20220805162444.3985535-1-kbusch@fb.com>
 <20220809064613.GA9040@lst.de>
 <YvKPTGf56v/3iSxg@kbusch-mbp.dhcp.thefacebook.com>
 <20220809184137.GB15107@lst.de>
 <YvPzUSx87VkwSH2C@kbusch-mbp.dhcp.thefacebook.com>
 <20220811072232.GA13803@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811072232.GA13803@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_141955_171723_88579D76 
X-CRM114-Status: GOOD (  28.94  )
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

On Thu, Aug 11, 2022 at 09:22:32AM +0200, Christoph Hellwig wrote:
> On Wed, Aug 10, 2022 at 12:05:05PM -0600, Keith Busch wrote:
> > The functions are implemented under 'include/linux/', indistinguishable from
> > exported APIs. I think I understand why they are there, but they look the same
> > as exported functions from a driver perspective.
> 
> swiotlb.h is not a driver API.  There's two leftovers used by the drm
> code I'm trying to get fixed up, but in general the DMA API is the
> interface and swiotlb is just an implementation detail.
> 
> > Perhaps I'm being daft, but I'm totally missing why I should care if swiotlb
> > leverages this feature. If you're using that, you've traded performance for
> > security or compatibility already. If this idea can be used to make it perform
> > better, then great, but that shouldn't be the reason to hold this up IMO.
> 
> We firstly need to make sure that everything actually works on swiotlb, or
> any other implementation that properly implements the DMA API.
> 
> And the fact that I/O performance currently sucks and we can fix it on
> the trusted hypervisor is an important consideration.  At least as
> importantant as micro-optimizing performance a little more on setups
> not using them.  So not taking care of both in one go seems rather silly
> for a feature that is in its current form pretty intrusive and thus needs
> a really good justification.

Sorry for the delay response; I had some trouble with test setup.

Okay, I will restart developing this with swiotlb in mind.

In the mean time, I wanted to share some results with this series because I'm
thinking this might be past the threshold for when we can drop the "micro-"
prefix on optimisations.

The most significant data points are these:

  * submission latency stays the same regardless of the transfer size or depth
  * IOPs is always equal or better (usually better) with up to 50% reduced
    cpu cost

Based on this, I do think this type of optimisation is worth having a something
like a new bio type. I know this introduces some complications in the io-path,
but it is pretty minimal and doesn't add any size penalties to common structs
for drivers that don't use them.

Test details:

  fio with ioengine=io_uring
    'none': using __user void*
    'bvec': using buf registered with IORING_REGISTER_BUFFERS
    'dma': using buf registered with IORING_REGISTER_MAP_BUFFERS (new)

  intel_iommu=on

Results:

(submission latency [slat] in nano-seconds)
Q-Depth 1:

 Size |  Premap  |   IOPs  |  slat  | sys-cpu%
 .....|..........|.........|........|.........
 4k   |    none  |  41.4k  |  2126  |   16.47%
      |    bvec  |  43.8k  |  1843  |   15.79%
      |     dma  |  46.8k  |  1504  |   14.94%
 16k  |    none  |  33.3k  |  3279  |   17.78%
      |    bvec  |  33.9k  |  2607  |   14.59%
      |     dma  |  40.2k  |  1490  |   12.57%
 64k  |    none  |  18.7k  |  6778  |   18.22%
      |    bvec  |  20.0k  |  4626  |   13.80%
      |     dma  |  22.6k  |  1586  |    7.58%

Q-Depth 16:

 Size |  Premap  |   IOPs  |  slat  | sys-cpu%
 .....|..........|.........|........|.........
 4k   |    none  |   207k  |  3657  |   72.81%
      |    bvec  |   219k  |  3369  |   71.55%
      |     dma  |   310k  |  2237  |   60.16%
 16k  |    none  |   164k  |  5024  |   78.38%
      |    bvec  |   177k  |  4553  |   76.29%
      |     dma  |   186k  |  1880  |   43.56%
 64k  |    none  |  46.7k  |  4424  |   30.51%
      |    bvec  |  46.7k  |  4389  |   29.42%
      |     dma  |  46.7k  |  1574  |   15.61%


