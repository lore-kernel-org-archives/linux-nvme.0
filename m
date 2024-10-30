Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D46AD6B6DD
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 22:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d1OED8QhZCDVVg/KsaDYslZr5WCrhMHdJIPeqydogdM=; b=xTZNvEjvvjOsCoxcmvECYQ5UgZ
	CxMQEmVmxwutMHVi1wzhGhocJJIMg7pg3Vhd4/gpuKLioZ2cWf+GKO5CGwBXNQv+zsrgiOtiXE+nP
	Sr4VkptsCFANm2HaCVnkLoKdAtOzI3+sYgrrcipcYUIxAfqKMd2bAaMNelUSgBwMyoqseyI5MMXco
	7H0Rsf8UPu+3ezGaL8VvHmzuVlnrsyzEa7Gp9q8P6vtTupmdAkMaaZ8WRhtd4C6fP6gdO4htuzpwK
	N0Z/hnXUQsoOE+t3RENTTPalUVUV/zEd03P6wdYby/kGMrQdpbhmXtmikGyHlvflQAqaOoUwQEUwQ
	41CZIg1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6HFR-00000001ydI-1s95;
	Wed, 30 Oct 2024 22:33:05 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6HFN-00000001yco-1rq0
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 22:33:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D8E5BA431DD;
	Wed, 30 Oct 2024 22:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E300C4CECE;
	Wed, 30 Oct 2024 22:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730327580;
	bh=pG2dV6wbFJ9/N3Eo79eG7sTCZARua6TPwKbzaZm5T8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOLGBIAcEYrCYSFurialDE1/dDbk0s5VsobxcNkWosTwMWsHUtEwV2Dp6K1Bt2xB/
	 Fr9YO4uhhAZ+bYoWwuhY2pbaLrRSeZCZGIRh48gST8/NSWTSOpVy4vmedCkJGiHmok
	 evunMKCuBVIHpmHm+FOgsiNNdCqGZnbXnl58AgDLjkC3DkO9NldpetChGi52nPYqxm
	 O6ZwqatzbxIPcJW8GOiZeuM9otwid4W0Il7PCsaI1J094cFyXVVLrj2x3Yi1K/uHqf
	 pK8aowBq29IKzesQio0R+lZ1Rty5SsD0ych9kGkC73wmjtsa6CtFfbObGwNhCGncFE
	 CMtEjbWx7DpbA==
Date: Wed, 30 Oct 2024 16:32:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <ZyK0GS33Qhkx3AW-@kbusch-mbp.dhcp.thefacebook.com>
References: <ZyEBhOoDHKJs4EEY@kbusch-mbp>
 <20241029155330.GA27856@lst.de>
 <ZyEL4FOBMr4H8DGM@kbusch-mbp>
 <20241030045526.GA32385@lst.de>
 <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com>
 <20241030154556.GA4449@lst.de>
 <ZyJVV6R5Ei0UEiVJ@kbusch-mbp.dhcp.thefacebook.com>
 <20241030155052.GA4984@lst.de>
 <ZyJiEwZwjevelmW2@kbusch-mbp.dhcp.thefacebook.com>
 <20241030165708.GA11009@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241030165708.GA11009@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_153301_571315_6442CE2C 
X-CRM114-Status: GOOD (  14.50  )
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

On Wed, Oct 30, 2024 at 05:57:08PM +0100, Christoph Hellwig wrote:
> On Wed, Oct 30, 2024 at 10:42:59AM -0600, Keith Busch wrote:
> > With FDP (with some minor rocksdb changes):
> > 
> > WAF:        1.67
> > IOPS:       1547
> > READ LAT:   1978us
> > UPDATE LAT: 2267us
> 
> Compared to the Numbers Hans presented at Plumbers for the Zoned XFS code,
> which should work just fine with FDP IFF we exposed real write streams,
> which roughly double read nad wirte IOPS and reduce the WAF to almost
> 1 this doesn't look too spectacular to be honest, but it sure it something.

Hold up... I absolutely appreciate the work Hans is and has done. But
are you talking about this talk?

https://lpc.events/event/18/contributions/1822/attachments/1464/3105/Zoned%20XFS%20LPC%20Zoned%20MC%202024%20V1.pdf

That is very much apples-to-oranges. The B+ isn't on the same device
being evaluated for WAF, where this has all that mixed in. I think the
results are pretty good, all things considered.
 
> I just wish we could get the real infraѕtructure instead of some band
> aid, which makes it really hard to expose the real thing because now
> it's been taken up and directly wired to a UAPI.
> one

I don't know what make of this. I think we're talking past each other.

