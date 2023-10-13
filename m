Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44DBCDB47E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wxYJJGDvjcSJxCqySszgXAh0IL7/JVL7xoApd38w8hQ=; b=RGjawrXQKg2/cSkLj5HXvlX8Dl
	aKtUrCQKeZglRJbGOw7qumcEX7myHLILhQkehEA1HglRNFXOpTbFMyF80Z4AkmUoF/Rpzz5nM3EWC
	jwqeN7ceN21oRDyOCw9qSw5HsorI3ebMPSnlhT+QbhKu/1Tx11yMbc/mS8HUuEoPC1zlGZYlM0g1W
	qvJcu0NzWg8jEWSAEACoPzaIIgq9iZn3TEzY3EkndRcOPs5/vvVj3o/gShzvuoacs3BgT5968Z2IR
	SJ564VX3Y6lEzLL9NTyqgv62tGF6e6TDNnA3KnCjTOCts1n3lwr0LOmy2vy+xnQW/Dek6lplsBNSP
	e8Pgqpmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrIcN-003XTs-0M;
	Fri, 13 Oct 2023 13:54:19 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrIcJ-003XT6-2f
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 13:54:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id C32E6B82AE1;
	Fri, 13 Oct 2023 13:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA90C433CA;
	Fri, 13 Oct 2023 13:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697205246;
	bh=lCM1IEBB6Zo6eHfhvNjtIDG9oDrI/zQMavuap6OoMB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VcrUECgrANyryGvjmWWjelTOGesYZ7oTxX3dZEBmoQWYna036SpxIX+sZ2UzL0ZfJ
	 y8GYsCRy/7WqWR0ZX9N1HN8GDrBlzrI95Tctnp12UTFL3KpZe7jF7aIHY6Pc+v/eKj
	 fZmAoFZvhHIclNtqFJmAraVC0qFC0Sta9ZPq3NnkPAnv8Yc7r5usdRCOfFP/uZMnU9
	 6v5oPsjPclyKS0FWenHcN5KkWa9djrDjfFvK0b2V0Ks4jj8WOA7I2G3EGPyoy1/iXZ
	 q1imhRoxC50x+ziAkKfAzSxD3npbM9xn6dWBZCUUohsZMH7NZQnA1+9FCnG34k/qyB
	 lJZy48+/nhoNA==
Date: Fri, 13 Oct 2023 07:54:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, joshiiitr@gmail.com,
	stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
Message-ID: <ZSlL-6Oa5J9duahR@kbusch-mbp>
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
 <20231013051458.39987-1-joshi.k@samsung.com>
 <20231013052612.GA6423@lst.de>
 <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231013_065416_034514_CA26E36D 
X-CRM114-Status: GOOD (  16.92  )
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

On Fri, Oct 13, 2023 at 03:44:38PM +0530, Kanchan Joshi wrote:
> On 10/13/2023 10:56 AM, Christoph Hellwig wrote:
> > On Fri, Oct 13, 2023 at 10:44:58AM +0530, Kanchan Joshi wrote:
> >> Changes since v3:
> >> - Block only unprivileged user
> > 
> > That's not really what at least I had in mind.  I'd much rather
> > completely disable unprivileged passthrough for now as an easy
> > backportable patch.  And then only re-enable it later in a way
> > where it does require using SGLs for all data transfers.
> > 
> 
> I did not get how forcing SGLs can solve the issue at hand.
> The problem happened because (i) user specified short buffer/len, and 
> (ii) kernel allocated buffer. Whether the buffer is fed to device using 
> PRP or SGL does not seem to solve the large DMA problem.

The problem is a disconnect between the buffer size provided and the
implied size of the command. The idea with SGL is that it requires an
explicit buffer size, so the device will know the buffer is short and
return an appropriate error.

