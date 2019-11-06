Return-Path: <SRS0=IwtP=Y6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DA0C5DF63
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 20:22:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB08217F4
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 20:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ViP79fBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB08217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hasenleithner.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DCfOVvViVMs0AqjIcBIo9bweKvwYRtxYixBHnRhqnC8=; b=ViP79fBAXTe9p6mUnVEWjQK/F
	7D7wxYlU0J/8OZZ+W0NNmBl25/6AlLDdRWUFNw1E5BDN5XS/ZtIZ1FM5DMKSqBAlGl/U7NbXsgfOC
	vWh/ZLW8tjMa62Wo2KFcRPTYTmVUwtafSwtTjp08k0p0xGsg7qfwytWpfHVNTHDMXlthtfWGHFgZK
	9jLKQxqToUkGiLVv2VSRTSqrG6zg62/sQfWbPunppukgGsiFujLCaztcWWBqI7nh3d9F4mU43tdOL
	E7Oo4aurkivOop4syXfOjs1drW7XK4d/KaEETKl1UApC/OrjuJn+46t9GQoqYiyKdpCOXFmBeS5gB
	sX1k4mbXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iSRoe-0004MW-T1; Wed, 06 Nov 2019 20:22:08 +0000
Received: from hodge.hasenleithner.at ([2a01:4f8:c17:651d::2])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iSRob-0004La-K9
 for linux-nvme@lists.infradead.org; Wed, 06 Nov 2019 20:22:07 +0000
Received: from [IPv6:2001:470:584d::10] (unknown [IPv6:2001:470:584d::10])
 by hodge.hasenleithner.at (Postfix) with ESMTPSA id B4770760021;
 Wed,  6 Nov 2019 21:22:00 +0100 (CET)
Subject: Re: [RFC PATCH] Workaround for discard on non-conformant nvme devices
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
References: <f220c69a-793d-9160-4f20-921c52748009@hasenleithner.at>
 <d96335fb-8907-6b5b-14e9-08eb1a796b0d@grimberg.me>
 <20191106182339.GE29853@redsun51.ssa.fujisawa.hgst.com>
From: Eduard Hasenleithner <eduard@hasenleithner.at>
Message-ID: <f9e32847-00b1-59f5-8b15-860a94598e79@hasenleithner.at>
Date: Wed, 6 Nov 2019 21:22:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106182339.GE29853@redsun51.ssa.fujisawa.hgst.com>
Content-Language: de-AT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191106_122205_816109_9C0799BD 
X-CRM114-Status: GOOD (  10.03  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 06.11.19 19:23, Keith Busch wrote:
>> This needs to come with a quirk for it.
> 
> Yeah, and have the broken ones to use the ctrl->discard_page so that you
> don't need to worry about the alignment of the address kmalloc returns.

This raises some questions for me.
Why bother maintaining a quirk list and have additional complexity with 
separate code paths?
Couldn't we just simply use the discard_page for all discards?
Are there even nvme devices out there which have conformant behavior in 
this respect?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
