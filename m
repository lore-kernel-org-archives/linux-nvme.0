Return-Path: <SRS0=GxYq=6W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343FFC38A2A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 14:07:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0817424956
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 14:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EpB9mhgf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fao/d+W2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0817424956
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UhEd7FgSjBn4vUBbS8zlO/P+hQ23JMGEeqn+zMwiElc=; b=EpB9mhgfd5zOtp
	s1IeYirWq7aYiJBBmfveRKUfSzIP0e/UIi4ZpU92UrGvM8zD5XWBqZGlpUrKcCyliSsTt+NnWITXu
	SK81CqEXAPSpgTLWHZy9lpGVuZtDgvyfi5mg9AKdZkx2eP68rEFBiCiHqvwKbQ/URhE5+fcTqZ+iu
	W8SETzeDpAPu3+V1hulYrvs/hZ9y+MdC5ln/UrpsTakEpEmwWz4d8Siu8OcyFO1NHxSRxUGfR059r
	5izDcbzg9if/+THxu6llP9Qyc4XPxYaj1yz/31ZiASP3K+kerEewS/04Z2VVDp1tXnfMri8Xmlzw0
	lvr/Plda5MV3bxGrGYPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jX3f8-0002ZF-NE; Fri, 08 May 2020 14:07:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jX3f6-0002Yb-9n
 for linux-nvme@lists.infradead.org; Fri, 08 May 2020 14:07:37 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0EFC324955;
 Fri,  8 May 2020 14:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588946855;
 bh=hsbehdGBXyyFlGatFkNdQ6ZKCeqxkzesCK0JtAwU53o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Fao/d+W2UNdX6VaWhQFE6CwKOGhJss9Qs4u1zezXTKAd7xTXBcz9furzU69h8U9Kr
 ysYvWBC4ZLjvlaPBVGHFMRgcRViEknnjQdP3ERlHcBO4wq6my9gospCFhAJ0pNRVF2
 vBO4Qir5Bd3p58dk6URzeQu0T2HxkShqCHuQV+mY=
Date: Fri, 8 May 2020 07:07:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] nvme-pci: slimmer CQ head update
Message-ID: <20200508140733.GE2621480@dhcp-10-100-145-180.wdl.wdc.com>
References: <4dae5990-e81b-8b33-dafc-ee47e4f06b6a@arm.com>
 <e1643b53-d362-0b5e-573f-72f0ea249ebf@huawei.com>
 <20200507142352.GA2621422@dhcp-10-100-145-180.wdl.wdc.com>
 <8b297620-c72b-2184-36cb-032f5cfda05c@huawei.com>
 <20200507153506.GA2621480@dhcp-10-100-145-180.wdl.wdc.com>
 <9e04eebc-a55b-ac7e-3cb3-9c65f084ee6c@arm.com>
 <20200507173545.GC2621480@dhcp-10-100-145-180.wdl.wdc.com>
 <20200507174429.GA4466@willie-the-truck>
 <20200507180612.GD2621480@dhcp-10-100-145-180.wdl.wdc.com>
 <20200508114020.GA16247@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200508114020.GA16247@willie-the-truck>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200508_070736_362755_F1600355 
X-CRM114-Status: GOOD (  17.67  )
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
Cc: sagi@grimberg.me, John Garry <john.garry@huawei.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, axboe@fb.com,
 Robin Murphy <robin.murphy@arm.com>, Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 08, 2020 at 12:40:20PM +0100, Will Deacon wrote:
> On Thu, May 07, 2020 at 11:06:12AM -0700, Keith Busch wrote:
> > >   <Read the word of the CQE containing the updated Phase Tag Bit>
> > >   dma_rmb();
> > >   <Read the other words of the CQE>
> > > 
> > > How easy is it to check if that sort of thing is being followed?
> > 
> > We don't have such a barrier in the driver. The phase must be written
> > last, so having it visible to the CPU was supposed to guarantee previous
> > DMA writes are also visible. Is this not the case?
> 
> Without a barrier on the read side, something like the following might be
> able to happen:
> 
> 	CPU				NVME
> 	Read stale data
> 					Write data
> 					Write phase bit
> 	Read phase bit
> 
> So you need a dma_rmb() on the CPU side to prevent that reordering, and
> ensure that the phase bit is read first.

I hadn't mentioned the driver CQE reads use 'volatile' access, reading
phase first, then command id some time after.

> Anyway, the only reason I mentioned
> it is because it should  be relatively straightforward to add the barrier
> (famous last words...) and see if it helps with the problem. If not, we're
> looking in the wrong place.

I'll look into this as well.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
