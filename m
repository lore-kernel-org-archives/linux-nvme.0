Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1898CCA0EFF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Aug 2025 15:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T5XOc2oFyUVB17qt+WivFKZdA6SgWgwkp5XAbzpNVgQ=; b=teaya3S1gxFbkNQxQ79ze1SggC
	UR2IwgX11oVntZEgSDvEV+p3AN7lWl01QZqzKRxZRMbzj2X9Yv6DbHoKf1o7xyr3fqfNHr0RzjMll
	jijMvvNMe3qnCNu8Rlu1mmRduaXGzrIHN2vVFDf1tSotiqIG9tKgvkncxBj8N2Rc3Cs63+xUQeWwV
	TFxsBewjh31QBGozabPB1I8pjY2YEbSDSz5SYGQ5Yfmp46VauKvzLPepW6mlHZPLHlaxhhSb/kjQf
	FdSsppw8arHq4cAWid2LjYZ2JyP9cXuhqgEX5J3wcqA1SaeHXG9OTakMCCJObCBhuqvjD5QddTtpo
	9pn9nBmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urITl-0000000G46L-2cbH;
	Wed, 27 Aug 2025 15:54:29 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urG3Z-0000000FYVL-023i;
	Wed, 27 Aug 2025 13:19:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A01F24417B;
	Wed, 27 Aug 2025 13:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8ADC4CEEB;
	Wed, 27 Aug 2025 13:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756300756;
	bh=ZJBcfQdx2UO+F8GzktrZZ/rKqPLBDJPTs1143n9qhnI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sEEYsNI4MA2rrWtni3gO/oD1ASXHhvDO1WFuLivNTAVlh2m+MG37VPac8HjN2mobK
	 QP6whq2KAONXNy7ZNygbqcRBcPh6N2RbiQ7F0eRn0NUj7DewOXpuzKdYIbGbPNkuYN
	 B5qXkFWhRbPa6KZfZh/5tc3cNa2nla5/VmPPgnFtM4HLu1kh3bPt2xFCxf2TFPOY/j
	 cTUFNXVe4EPFQdKn/6bqEwH2YbJ+5IIfZRyWAU/JzSsqJbW0xq2VG891y8O/6nlYG+
	 9qCdXwGBSAuD6z/1x3f8kEA9GoIYI/X9fMItZ0Z0khwACuL+74KLxaQOAnvG94S8bK
	 n5FE11dvoOOeQ==
Message-ID: <6365acb0-6e4c-4561-bc0f-d34637e8308e@kernel.org>
Date: Wed, 27 Aug 2025 15:19:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Nick Chan <towinchenmi@gmail.com>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
 <20250818-t8015-nvme-v2-6-65648cd189e0@gmail.com>
 <20250819-polite-papaya-catfish-1a9d1a@kuoka>
 <8ac418ae-7ff0-4d5c-9f11-c24e36618ac1@kernel.org>
 <b3cd1b3f-fa0e-4a98-84c7-e4271f262795@kernel.org>
 <8279536d-c4f4-477a-9823-3e7b452c3c33@kernel.org>
 <12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org>
 <20250827122525.GA204299@robin.jannau.net>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250827122525.GA204299@robin.jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250827_061917_104499_BC92052F 
X-CRM114-Status: GOOD (  29.25  )
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

On 27/08/2025 14:25, Janne Grunau wrote:
> On Thu, Aug 21, 2025 at 03:09:42PM +0200, Krzysztof Kozlowski wrote:
>> On 21/08/2025 12:25, Sven Peter wrote:
>>>
>>> 1) For situations like this one where the generic one just doesn't make 
>>> any sense we deprecate "apple,nvme-ans2" in the binding and use
>>> "apple,t8103-nvme-ans2" as the fallback instead, i.e. just
>>> "apple,t8103-nvme-ans2" for M1, "apple,t6000-nvme-ans2", 
>>> "apple,t8103-nvme-ans2" for M1 Pro, and just "apple,t8015-nvme-ans2" for 
>>> A11.
>>>
>>> We keep the generic one in the driver for now but also add
>>> "apple,t8103-nvme-ans2". We then remove the generic one from all 
>>> upstream DTS files but keep it inside the downstream files we ship to 
>>> users for now to avoid pain with kernel upgrades/downgrades.
>>> A year or two from now we can then delete the deprecated generic 
>>> compatibles everywhere. This all has to be synced with OpenBSD and 
>>> u-boot as well since both also use these bindings.
>>> It's gonna be rather painful but this would clean up the entire mess.
>>>
>>>
>>> 2) We keep using the ones that are already upstream and just accept that 
>>> the situation is a mess and add comment above all the bindings that we 
>>> messed up and that this should not be used as pattern.
>>> In this case that means it'll just be "apple,t8015-nvme-ans2" for A11 
>>> without any fallback and we keep everything else the way it is.
>>>
>>> I prefer option (2) but if you really want to get rid of all this mess 
>>
>>
>> I also prefer option (2). That's the least disruptive option for users
>> and inconsistency in bindings naming is just inconsistency, no big deal.
>> You just need to remember not to grow the old items/pattern with generic
>> compatible.
> 
> This sounds to me like a mix of option 1) and 2).
> 
> All devices / SoCs already upstream will use the fixed current
> compatibles and thus are following option 2)
> 
> New SoCs will have to use
>     compatible = "apple,t6020-nvme-ans2", "apple,t8103-nvme-ans2";
> using t6020 as example even though they will be using the same driver
> code as "apple,nvme-ans2". Using t6020 as an example I planned to submit
> today.
> This will require adding the new fallback "apple,t8103-nvme-ans2"
> compatible string to the driver.
> 
> Asking for clarification as I could image such driver changes will raise
> questions from the driver maintainers.


I don't think they will question it. :) Just mention briefly in commit
msg of the binding reasons why style is different.


> 
> Is there a way do document/annotate the generic compatibles as
> deprecated / "do not use" for new devices?

You can deprecate existing compatibles ("deprecated: true"), but I think
that's not what is going to happen here and there is no specific syntax
to annotate that "do not grow this list, that's old style of doing things".

You can always add a comment like this. See also:
Documentation/devicetree/bindings/iommu/arm,smmu.yaml

(but this uses both comment and deprecated)

> 
> Thanks
> Janne


Best regards,
Krzysztof

