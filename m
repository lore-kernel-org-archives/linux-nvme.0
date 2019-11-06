Return-Path: <SRS0=IwtP=Y6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BE5C5DF63
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 21:11:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4FA217D7
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 21:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LR7Qeqbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4FA217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hasenleithner.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UkzloJEv5NSFI3DG8v4CRlsosLWL2dusdIx7aLoihcY=; b=LR7QeqbjdKYBR+AMWzBKgPyiK
	S9hCGhUZ4pYSUuPVT+jMufvmKqIRxXjPEH4bar9cunY/umHMo2rYBXFqIT7IhvWj+YDwicKOpWHqo
	zjbVPxyWwfybA6OI2FlFjg/3EmgztkwV3rrbJdtOk+ymIGcf4AvHA4hrsAKVQzRkHGU16F2MdaGG9
	hofTrc8kJwKmAkCpPM87WaNJNA2YTji8FxVPINnTFojxFixKFRdBaB8jLIxq2Q9SPbni6ua+5jeH7
	Gh/FBARywOVyEQlHxkE/Pj291i9gwS6ZpBGSY63rETNUWO8zfJBw8duc8/hJERCdeBHXYlSPG/EV6
	DewbiltPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iSSa0-00072R-8x; Wed, 06 Nov 2019 21:11:04 +0000
Received: from hodge.hasenleithner.at ([2a01:4f8:c17:651d::2])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iSSZw-00071T-L8
 for linux-nvme@lists.infradead.org; Wed, 06 Nov 2019 21:11:02 +0000
Received: from [IPv6:2001:470:584d::10] (unknown [IPv6:2001:470:584d::10])
 by hodge.hasenleithner.at (Postfix) with ESMTPSA id 1DBD2760021;
 Wed,  6 Nov 2019 22:10:59 +0100 (CET)
Subject: Re: [RFC PATCH] Workaround for discard on non-conformant nvme devices
To: Keith Busch <kbusch@kernel.org>
References: <f220c69a-793d-9160-4f20-921c52748009@hasenleithner.at>
 <d96335fb-8907-6b5b-14e9-08eb1a796b0d@grimberg.me>
 <20191106182339.GE29853@redsun51.ssa.fujisawa.hgst.com>
 <f9e32847-00b1-59f5-8b15-860a94598e79@hasenleithner.at>
 <20191106204329.GB32215@redsun51.ssa.fujisawa.hgst.com>
From: Eduard Hasenleithner <eduard@hasenleithner.at>
Message-ID: <ea1ddc8d-9612-1fa1-09bc-ce803b0a38ef@hasenleithner.at>
Date: Wed, 6 Nov 2019 22:10:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106204329.GB32215@redsun51.ssa.fujisawa.hgst.com>
Content-Language: de-AT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191106_131100_849660_ADC7F180 
X-CRM114-Status: GOOD (  12.06  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 06.11.19 21:43, Keith Busch wrote:
> On Wed, Nov 06, 2019 at 09:22:00PM +0100, Eduard Hasenleithner wrote:
>> Couldn't we just simply use the discard_page for all discards?
> 
> That's normally just a fallback to ensure forward progress under memory
> pressure. It's not particularly performant, though.

So we are accepting a considerable performance impact for the "broken" 
devices?

>> Are there even nvme devices out there which have conformant behavior in this
>> respect?
> 
> I believe most of them do conform, but I don't have a large sample size
> to confirm.

Do you have an IO-MMU active on your setup? In my setup it is active and 
the nvme is directly attached to the CPU. So the CPU exactly knows the 
intiator and the IO-MMU page table defines with page granularity which 
memory the nvme may read or write. I'm under the impression that 
slightly older setups may be less restrictive wrt DMA IO.

Another aspect is that vendors probably only test with windows and I'm 
guessing that windows doesn't bother with maintaining anything but page 
sized/aligned memory for issuing discard commands.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
