Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93F4C001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 14:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RdQAM6VxGMfoMTaPvBMcsHXXQDS0t6wgyEF3X9osK3w=; b=UX+BpvuCAN32AyMhF/vmnrsHUg
	1keSSRWSMSMSWfuWMFbdkThCorHXrZJ8YlwQk2BgfpDr7WfkdJu8LJa9Q50KwASBrrcD4wWq/EiIV
	oVeT7EPdxG/6iQunvtCVBWWFeHlRK+Cglcw4lAcPqjxylakMXxe0ruVkstef2mKrhYwmn/MFzu7Wz
	SQGls667yeo/Mvf2uXGyBCWVger2i9iwxKabDmOIXL1YVOsB9DWzvIjZAQKpNCoHepSV0bDqhf14U
	L9Expbjvwj+3HdlSmply4ccNIVcOxQ+aeacOuqEVrP+QTBRO7TO+ifxPi2QOIkSoEQXt9y19WmcFh
	JyfrOItA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTxM-00G8oj-09;
	Mon, 31 Jul 2023 14:33:08 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTxJ-00G8n3-13
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 14:33:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C31D96117E;
	Mon, 31 Jul 2023 14:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98223C433C7;
	Mon, 31 Jul 2023 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690813984;
	bh=zSETG/ZitpLOxcM6B1R5a9FyDOKM69LLigtLZ5RJ5sI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FuJgYKk92kQfapeQD3sGS/ciPMajjBa1opzfb5BWJW/WqdAhl0sTM1zjRZ/6Hh/Sz
	 yOrGCZ09/XRym22Jj0mElDi9CW0Avdkq0XmmDvfyJ2TjZjh+uhr7nilrFq78iamaNV
	 Ywbnc5qhGJPaibb12gyjMjLJdvWPgjOdcJxRFu5DOMLRLlcYHd05pM0R7EhIQ/L+SF
	 mVFzx3fC9x888RZuGmYPkp4cUuk3G8Pm69DFNXHg2Q0rLb8UAzuzKCV3rHkKHPi1HE
	 nKs3RcNovmcO1ygil4u3Mru2n+n4LPs0i9JRB2gTYz8iBsG+5Ger+bGZhIWLbM8K2O
	 lvL/ZnpS92NPw==
Message-ID: <d3d9e1c5-e090-fe65-7d80-850f0d0d284d@kernel.org>
Date: Mon, 31 Jul 2023 23:33:02 +0900
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
 <8da417c3-f505-ebfc-c92a-509fee68cfa3@kernel.org>
 <ZMfEkFBT7D7fizuL@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZMfEkFBT7D7fizuL@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_073305_408922_056E908B 
X-CRM114-Status: GOOD (  15.68  )
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

On 7/31/23 23:26, Christoph Hellwig wrote:
> On Mon, Jul 31, 2023 at 11:12:43PM +0900, Damien Le Moal wrote:
>> max zone append sectors limit indicates the maximum size of a zone append BIO
>> that can be built without ever needing splitting.
>>
>> So if we fix the zns limit, zonefs does not really need a fix, eventhough the
>> code would be a little weird as-is.
> 
> You still need to fix splitting due to I/O layout and not just size.
> 
> E.g. if your do a writev() with two non-page aligned buffers (you'll
> probably need a arm64 or power box to trigger it), you need to split
> the bio even if it trivially fits into the size limit.  Similar for
> things like max_segment_size.

Good point. So fix needed.


-- 
Damien Le Moal
Western Digital Research


