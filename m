Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB9DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 18:34:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A329C60F23
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 18:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A329C60F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=movementarian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K1LT+3GYm3Uxq+VmZ7tKtKkjFMSLqSJjxv1/KNTaTXI=; b=BWfYb7fKQrZw7pmUAWHkxAiCyA
	RPLM6hNV6rhTFoqTtbTuE8B28d5KC297jXZ+q80U3JyIrULta217xPBenJc7ddxErYDgc0Q5lUJ3U
	VxyJ1hM+ogw4bE2QPJjTVht6yQzUq6iLbnwFh63H/p/Jcy/ITzjuKB5xG1QVa2SLMnQBwNHLTj5+8
	Z6JyiaDyiwcRIY0Phvwe2HClHJXUw0mWQzoZfWyUsKmHw3vPOKJHS/mC1kj8JDUhVeuE93V1kf1ev
	1AehhZt0psJoFOOkdGAyaVH91PDtDDPjB5Nix5Xm9RhtjzedFVNTuByzImTaKmFMk0O795Jo+UVo3
	+vlIBe3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mb5YI-00482E-Bn; Thu, 14 Oct 2021 18:34:02 +0000
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mb5YF-00481o-RC
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 18:34:01 +0000
Received: from movement by movementarian.org with local (Exim 4.94)
 (envelope-from <movement@movementarian.org>)
 id 1mb5YD-003iix-2z; Thu, 14 Oct 2021 19:33:57 +0100
Date: Thu, 14 Oct 2021 19:33:57 +0100
From: John Levon <levon@movementarian.org>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCHv2 2/2] nvme-pci: remove cached shadow doorbell offsets
Message-ID: <YWh4FYa7TNEfdUj6@movementarian.org>
References: <20211014164543.1821327-1-kbusch@kernel.org>
 <20211014164543.1821327-3-kbusch@kernel.org>
 <YWhkSnjjTo3YioC+@movementarian.org>
 <20211014174938.GC1821373@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014174938.GC1821373@dhcp-10-100-145-180.wdc.com>
X-Url: http://www.movementarian.org/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_113359_906081_0C6C5FD0 
X-CRM114-Status: GOOD (  23.64  )
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

On Thu, Oct 14, 2021 at 10:49:38AM -0700, Keith Busch wrote:

> On Thu, Oct 14, 2021 at 06:09:30PM +0100, John Levon wrote:
> > On Thu, Oct 14, 2021 at 09:45:43AM -0700, Keith Busch wrote:
> > 
> > > And when this feature is in use, the specification requires all queue
> > > updates use this mechanism, so don't don't treat the admin queue
> > > differently.
> > 
> > This would cause implementation difficulties for a controller, right?
> 
> If the controller is not maintaining the admin queue shadow, then the
> event index will always tell the host to ring the doorbell, right? So
> the same host behvaior would ultimately happen.

The eventidx only causes the additional BAR0 writes if the doorbell update
crosses it (for example, a 4->6 transition when host sees eventidx of 5). So we
couldn't just leave eventidx at zero, and neither can we maintain it to force
BAR0 writes, as there are races that means we'd have to look at the shadow
doorbell value - and make assumptions - anyway.

This would all be a lot easier if zero wasn't a valid doorbell value, but we're
stuck now.

> > Currently we presume that the admin queue's shadow doorbells aren't valid, so
> > always look at the BAR0 location. Given we need to support older Linux versions,
> > we don't have any non-hacky way to handle this: we'd need something horrible
> > that presumes those Linux versions - and any other driver implementations -
> > always leave the admin queue shadows at zero, so if we see a non-zero value, it
> > must be doing shadow doorbells.
> > 
> > It's unclear to me what the advantage of fixing this is, given Linux has been
> > out of spec for so long.
> 
> Ah, I skimmed the part that said we are not up to spec compliance, so
> aligning with the spec with any feature usually justifies itself. I see
> your point was the opposite :)

Exactly. The test SPDK client is out of spec in exactly the same way.

I'm trying to follow up on the spec side so it reflects reality (I can't find a
driver that behaves differently here), but that's obviously a slow process.

thanks
john

