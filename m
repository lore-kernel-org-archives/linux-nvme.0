Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AF4C001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=50dBJhsoR1TbYC7NxTCn5GRgq4ac4dYi25vU3ndSy9o=; b=lpmc3KRo2e1WO/qtVudEGdqYZE
	7BGMOyrPYwr5A1FfGCiOkPtCM50+4lzmvRHiUbby7EIemwKyJjn/W8Vj5rMybKbhKxRoqiXhf87uX
	GJU1nv4cpRgqn7k/YHnI2YJ/4xDcHCYsOS4VVfs6gf3BgaC/pUyg36hawVdXsjQ0Kpet+wvwLHYam
	i78Vv9oznIQxUW+qqBHm01Zxn6eTwCG/8LBu3rH/EoiBMTN/ncgEyco7eePkANtLWC2Bqp2QuTSwy
	1OFbfA2l5PIMQpNr9xd8YJD+Br/KsHUZzPa2Qe5fQ7/v9YgsHMmkSoxEb8nmdQu7fVB7M/eMTtGKt
	driEyE3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTdq-00G5RV-1y;
	Mon, 31 Jul 2023 14:12:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTde-00G5Pq-1Q
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 14:12:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EAA1261121;
	Mon, 31 Jul 2023 14:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAFBC433CA;
	Mon, 31 Jul 2023 14:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690812765;
	bh=Ss7o1lftS9TL24S9JxZtulnSEfg0pRxmEPwnmCAsTCg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ou4owpfoDfgJLMJJ3UBlJw6VC8nRBJpPV161JvA4W+C6FTmLrwogRnyZhrSomc3xa
	 Jfakm6PzKC/9saHx3Il0SD0bEbvsEP5Kticz7xxw1W+uDtDs0CDEX7dfQbJcj6zG5F
	 cGsan1/ddLuwkWWM9A0Gr8cxRVh6RndEJ3+C/UZBEXZjtWdNuWVViIunJ1TlZTsV9p
	 UNWmwYdoT/JN5dOqKbujt1jSTQXHviB4Gpky2w3wEZNhCKq7yTUKGo//YrhHBVctog
	 2Kw1NXR+mu9B8brvtHUWK/u/Sc644+b2+8Q0jXmQrJXFaYoIbypnd6jk8U/P8sNVah
	 nvgs1jcZJTnDA==
Message-ID: <8da417c3-f505-ebfc-c92a-509fee68cfa3@kernel.org>
Date: Mon, 31 Jul 2023 23:12:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvme: zns: limit max_zone_append by max_segments
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230731114632.1429799-1-shinichiro.kawasaki@wdc.com>
 <e0f88870-73a8-05a3-024d-52cefcdef71d@kernel.org>
 <ZMe8XvFDDdAom97/@infradead.org>
 <3a827ef4-4143-a7d4-f3b1-6b50837f6fd9@kernel.org>
 <ZMfAA0yDhgvekjb4@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZMfAA0yDhgvekjb4@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_071246_542938_CB75DFE9 
X-CRM114-Status: GOOD (  14.93  )
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

On 7/31/23 23:06, Christoph Hellwig wrote:
> On Mon, Jul 31, 2023 at 11:01:21PM +0900, Damien Le Moal wrote:
>> We cannot do that in zonefs because there is no metadata to handle a possible
>> reordering of the fragments of a split large zone append. Hence zonefs limits
>> writes size to max zone append on entry and never tries to do larger writes. But
>> the ZNS limit bug resulted in the split. At least for zonefs, I think there is
>> no need to use the special bio add page since with a proper limit, we should
>> never see a split.
> 
> Then we need to bring back something like the code removed in
> 8e81aa16a42169faae1ba15cd648cc8bb83eaa48, although I'd kinda hate that,
> and I don't really say how that would protect against reordering either.

For zonefs, their is never any reordering because their is no split, as long as
max zone append sectors limit indicates the maximum size of a zone append BIO
that can be built without ever needing splitting.

So if we fix the zns limit, zonefs does not really need a fix, eventhough the
code would be a little weird as-is.

-- 
Damien Le Moal
Western Digital Research


