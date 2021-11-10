Return-Path: <SRS0=m9zU=P5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CC5C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 15:24:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C73E6103A
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 15:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C73E6103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=65uWoP1DQK7QlqEdSvFAIGzipx1+61pvrGfY+gp8isw=; b=XP6d8+9Ng5KB1r9FuFVG0Vspgy
	D4GRs8ZlSafy7gvrxvZkYdkJke6p90TY5PAADztUp11UzKsBwJOJrxXvXTU7uNcOmbbUGPE4iXtVa
	ey/idU1QhVf4jqFRVFNIfde/0qK9Vwieu4ApkxUPpR8Ma+kiy38ofFYiR+ORTvSX/+QhYKOsgXHyt
	6rE6/UhEPniXTwOTKCP+4eMiOTE/OYqMWLdvZiaIo/Hq9NWSwaTvrZyVHWYL+Nsvsca0uIkoIa+Ba
	a4vD53nWIdItdpK+bu2SGY8ioz37WZA/f3OUt8rpF2ObutzOgkCimv+oAs3FiaIutfQj9UROyrlsW
	AI7PQbDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkpSE-005jW5-VF; Wed, 10 Nov 2021 15:24:03 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkpSC-005jVG-Se
 for linux-nvme@lists.infradead.org; Wed, 10 Nov 2021 15:24:02 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F4A41FD33;
 Wed, 10 Nov 2021 15:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636557835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=65uWoP1DQK7QlqEdSvFAIGzipx1+61pvrGfY+gp8isw=;
 b=jFiK7q62CsXBiGWsHQDacGH7V5iQqFQavEWiWjaZfQhMklWe4aCUDYmUfi7v3gg1Bsc+P1
 Cix+trxy0Al97B4ryX4Jbn2RuewUx2Bej2bPYGFQB+TCJxC8M8fxQdZ5hRsr2dIe9PGt44
 BjbvSrCJM20ZY5r+GGcGxxf3yLfp6Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636557835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=65uWoP1DQK7QlqEdSvFAIGzipx1+61pvrGfY+gp8isw=;
 b=CxRxFNJ76/YgecUNBse6J2U1z1h64owAyCvTQ57GcxCv+iCKQdUip3eDa8fWrRXqvbP7lt
 okYwJl6Fv7P3z0AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F36A613BFF;
 Wed, 10 Nov 2021 15:23:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id d1oXLQrki2HHXwAAMHmgww
 (envelope-from <ematsumiya@suse.de>); Wed, 10 Nov 2021 15:23:54 +0000
Date: Wed, 10 Nov 2021 12:23:52 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH] nvme: add NO APST quirk for Kioxia device
Message-ID: <20211110152352.44l43fe5gg66mjna@cyberdelia>
References: <20211106020858.18625-1-ematsumiya@suse.de>
 <20211109080634.GA28581@lst.de>
 <20211109150405.uv2he4quk4dlud6p@cyberdelia>
 <e37edd78-a390-25a6-874b-8b69d2b80182@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e37edd78-a390-25a6-874b-8b69d2b80182@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211110_072401_121988_0DE0BCB8 
X-CRM114-Status: GOOD (  11.69  )
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

Hi Chaitanya,

On 11/10, Chaitanya Kulkarni wrote:
>Enzo,
>
>> I didn't, had to google. I see it listed on Kioxia's website as
>> CD6-V Series (6.4T model), but since customer was running on an
>> DL380 Gen10, I suspect it could also be HPE PE8030 (PN P19837-B21).
>>
>
>You can get more information about this controller using nvme-cli
>id-ctrl command.

I'm aware.

I don't have access to the system, but id-ctrl output was shared with
us.

AFAICS these are the only identifying fields, which all indicate to be
Kioxia's:

NVME Identify Controller:
vid       : 0x1e0f
ssvid     : 0x1e0f
sn        : [redacted]
mn        : KCD6XVUL6T40
fr        : GPK1
rab       : 2
ieee      : 8ce38e
...

Now something that I'm not aware. Would these change even if another
brand was using this Kioxia's chipset?

Is it crucial to have the product information (vs only chipset information)
for quirks? I'm already querying the customer for this anyway.


Cheers,

Enzo

