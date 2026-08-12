Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C839C5B56A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 08:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sGgknNej65T1XdsO0iwYbCCTsP79cLh9TzxklhVQmbk=; b=rcitf8boP3W62Skd8zi7s6DwKl
	dPglWiEMsHSwN5Fpkv0usbl8mPvIfOLIPuhEfvozikxBgebX/k6rG/gF7AuF3pqRmYfrtCRkF7bLn
	n4dSDhv2LHaHW0f8en/b5c6Rv0Ega4mxQTjGMoF9AJ/kf3Cra5qiMQRvRjEP5pTADfrFyvGtdjcnn
	rHNKHKjRHXiPPwBZLwCgmvhOFIOA12fXXwA2/ivUUiDMs8tifVvtG5kp3UGAkUw7zYVNnJO/+eKzN
	2yLkMabWIJOLNCq02R9mbNAJmuWfMNXLxHBub7g6x8qmEv2yT2rUNitgfB5bSRVas/Zm5hzs4nKm3
	nha+pWNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu4bt-0000000Ffk0-1xAl;
	Wed, 12 Aug 2026 08:46:53 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu4br-0000000Ffjd-1GTk;
	Wed, 12 Aug 2026 08:46:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 97EA340D56;
	Wed, 12 Aug 2026 08:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD011F000E9;
	Wed, 12 Aug 2026 08:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786524410;
	bh=sGgknNej65T1XdsO0iwYbCCTsP79cLh9TzxklhVQmbk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ETUpMJ+KMNAq/sX3GCQqYtXMUqoyuCyxD83c7VmXmBWfszBIocr0oYuxtxXG9QeW+
	 iu49pQy+Ykge5SlqJ2SEJvsAPzXr45teeJ3oIi0N9dH9V+20uA5GABnXO0bbOiR65n
	 fD6SiebcUxJw7QwxpKDC9k7FbQhr9A/teDOoy6Hlhnev5nJut+0OqFh0bBtwsTsX5s
	 zeGqzfQh710hIuHP2LOwIsrijkMdXzoAN+8YsncaeuC50hfBXvbmysiczSjDwzivJM
	 LbtHfgRAwWeQu0sxoiZJdBlljXVqjTG96KhrpjSLqa6xR0hjoni0nlB9yHZ+brrQvy
	 mbdrLZE14AZYg==
Message-ID: <1e4b3f04-7367-4651-9cdd-5c95e92e5874@kernel.org>
Date: Wed, 12 Aug 2026 10:46:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: nvme: Add apple,t8132-nvme-ans2
 compatible
To: Yureka Lilian <yureka@cyberchaos.dev>, Rob Herring <robh@kernel.org>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260811-apple-nvme-t8132-v1-0-865be32e42c3@cyberchaos.dev>
 <20260811-apple-nvme-t8132-v1-1-865be32e42c3@cyberchaos.dev>
 <20260811231121.GA271810-robh@kernel.org>
 <cf6f4732-1122-4381-962d-e18b32ac178d@cyberchaos.dev>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <cf6f4732-1122-4381-962d-e18b32ac178d@cyberchaos.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 12/08/2026 10:08, Yureka Lilian wrote:
> Thank you for the quick feedback!
> 
> On 8/12/26 01:11, Rob Herring wrote:
>> On Tue, Aug 11, 2026 at 10:49:47PM +0200, Yureka Lilian wrote:
>>> Add a new base compatible for the ANS2 NVMe on the Apple t8132 (M4) SoC,
>>> which uses a separate MMIO base for its NVMMU.
>>>
>>> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
>>> ---
>>>   .../devicetree/bindings/nvme/apple,nvme-ans.yaml   | 77 ++++++++++++++--------
>>>   1 file changed, 48 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>>> index 4c0b1f90aff8..c8a41b268b9c 100644
>>> --- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>>> +++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>>> @@ -16,6 +16,7 @@ properties:
>>>         - items:
>>>             - const: apple,t6020-nvme-ans2
>>>             - const: apple,t8103-nvme-ans2
>>> +      - const: apple,t8132-nvme-ans2
>>>         - items:
>>>             - enum:
>>>                 # Do not add additional SoC to this list.
>>> @@ -24,16 +25,6 @@ properties:
>>>                 - apple,t6000-nvme-ans2
>>>             - const: apple,nvme-ans2
>>>   
>>> -  reg:
>>> -    items:
>>> -      - description: NVMe and NVMMU registers
>>> -      - description: ANS2 co-processor control registers
>>> -
>>> -  reg-names:
>>> -    items:
>>> -      - const: nvme
>>> -      - const: ans
>>> -
>> Keep properties defined at the top level. More below.
>>
>>>     resets:
>>>       maxItems: 1
>>>   
>>> @@ -68,25 +59,53 @@ properties:
>>>   
>>>         The SART address filter is documented in iommu/apple,sart.yaml.
>>>   
>>> -if:
>>> -  properties:
>>> -    compatible:
>>> -      contains:
>>> -        enum:
>>> -          - apple,t6000-nvme-ans2
>>> -          - apple,t6020-nvme-ans2
>>> -then:
>>> -  properties:
>>> -    power-domains:
>>> -      minItems: 3
>>> -    power-domain-names:
>>> -      minItems: 3
>>> -else:
>>> -  properties:
>>> -    power-domains:
>>> -      maxItems: 2
>>> -    power-domain-names:
>>> -      maxItems: 2
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: apple,t8132-nvme-ans2
>>> +    then:
>>> +      properties:
>>> +        reg:
>>> +          items:
>>> +            - description: NVMMU registers
>>> +            - description: NVMe registers
>>> +            - description: ANS2 co-processor control registers
>>> +        reg-names:
>>> +          items:
>>> +            - const: nvmmu
>>> +            - const: nvme
>>> +            - const: ans
>> New entries go on the end.
> Ack
>> So nvmmu last and defined at the top level.
> I did read the docs which said the properties should always be 
> introduced at the top-level, however I couldn't figure out how to 
> describe the intended constraints in this way.
>> Then this is just 'minItems: 3'
>>
>>> +    else:
>>> +      properties:
>>> +        reg:
>>> +          items:
>>> +            - description: NVMe and NVMMU registers
>>> +            - description: ANS2 co-processor control registers
>>> +        reg-names:
>>> +          items:
>>> +            - const: nvme
>>> +            - const: ans
>> And 'maxItems: 2' on these 2.
> 
> When the three items are defined at the top-level, I can't seem to make 
> the dtbs_check work:
> 
> [...]
> arch/arm64/boot/dts/apple/t8112-j413.dtb: nvme@27bcc0000 
> (apple,t8112-nvme-ans2): reg: [[2, 2076966912, 0, 262144], [2, 
> 2000683008, 0, 16384]] is too short
>      from schema $id: http://devicetree.org/schemas/nvme/apple,nvme-ans.yaml
> arch/arm64/boot/dts/apple/t8112-j413.dtb: nvme@27bcc0000 
> (apple,t8112-nvme-ans2): reg-names: ['nvme', 'ans'] is too short
>      from schema $id: http://devicetree.org/schemas/nvme/apple,nvme-ans.yaml
> [...]
> 
> despite this compatible falling into the "... else ... maxItems: 2" branch
> 
> Would it be acceptable to define the reg and reg-names with just 
> minItems: 2, maxItems: 3, but without specific items or descriptions, 
> and then add the compatible-specific items and descriptions in the 
> conditional part below?

No, because you do workaround for your own introduced problem. If you
list the entries in top level in correct order, then everything will
work fine with Rob's answer/comment.

This is your case:
https://elixir.bootlin.com/linux/v6.11-rc6/source/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml#L39

This is not your case:
https://elixir.bootlin.com/linux/v6.11-rc6/source/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml#L127
Unless you provide arguments why it is.

Best regards,
Krzysztof

