Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E912C5B56A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 08:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g8o/j7j4w3KLWh32ubDeSN0JFxs0ZyyDKCxWJyyp8gQ=; b=DOp5EowodvZq2E/b5BPFWqQOl0
	4muqFQW6RwctsAmJdP4Am8Qj6chng9r7Ou3aR+/HmpgJn5IOkfEeD7VhWpXZzbB5F6LUbSZLFyLo5
	/1lwBzwa9scUR+1e/CLiZs7+LVZSBIuEvE6y84nttVvsdEHSC7147ZvG/QscKEQjuf6W1qLQY6Sz8
	p5uwiA4vfIWg6HU5PRFQ4+DUUfrTU6mXXpWKUHmK6pTTpPwC3J3sw/TSDh97sn6/josoxjE6EXuFL
	5G/QI5TtIPu7flHoZt0Qcg6GNEsPE7Z482twgiYvhoSq7lGsLCMMVxg4M0F04Ipmh/Hlr8nAsbtld
	ovO02BOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu40z-0000000FcdG-0Lw7;
	Wed, 12 Aug 2026 08:08:45 +0000
Received: from mail.cyberchaos.dev ([195.39.247.168])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu40w-0000000Fcbd-1xHc;
	Wed, 12 Aug 2026 08:08:44 +0000
Message-ID: <cf6f4732-1122-4381-962d-e18b32ac178d@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1786522118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8o/j7j4w3KLWh32ubDeSN0JFxs0ZyyDKCxWJyyp8gQ=;
	b=GEDyrtiYCcQ3apJP8ir4Ty/7Yf+NYe7qqakLArttAK2LHywzUmyCz+h6TozQyZlKsxx13T
	akmN81Jlx7RH/mIrSpMhhZVScA5EjGX0PtUd9uYl2Lvgl6LE08iVdQwIycievawyYvPU/X
	cKYrJo80sa72cBuy75AaZ0oCJiuNotY=
Date: Wed, 12 Aug 2026 10:08:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] dt-bindings: nvme: Add apple,t8132-nvme-ans2
 compatible
To: Rob Herring <robh@kernel.org>, Yureka Lilian <yureka@cyberchaos.dev>
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
Content-Language: en-US
From: Yureka Lilian <yureka@cyberchaos.dev>
In-Reply-To: <20260811231121.GA271810-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_010842_759366_0706C5B8 
X-CRM114-Status: GOOD (  18.27  )
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

Thank you for the quick feedback!

On 8/12/26 01:11, Rob Herring wrote:
> On Tue, Aug 11, 2026 at 10:49:47PM +0200, Yureka Lilian wrote:
>> Add a new base compatible for the ANS2 NVMe on the Apple t8132 (M4) SoC,
>> which uses a separate MMIO base for its NVMMU.
>>
>> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
>> ---
>>   .../devicetree/bindings/nvme/apple,nvme-ans.yaml   | 77 ++++++++++++++--------
>>   1 file changed, 48 insertions(+), 29 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>> index 4c0b1f90aff8..c8a41b268b9c 100644
>> --- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>> +++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>> @@ -16,6 +16,7 @@ properties:
>>         - items:
>>             - const: apple,t6020-nvme-ans2
>>             - const: apple,t8103-nvme-ans2
>> +      - const: apple,t8132-nvme-ans2
>>         - items:
>>             - enum:
>>                 # Do not add additional SoC to this list.
>> @@ -24,16 +25,6 @@ properties:
>>                 - apple,t6000-nvme-ans2
>>             - const: apple,nvme-ans2
>>   
>> -  reg:
>> -    items:
>> -      - description: NVMe and NVMMU registers
>> -      - description: ANS2 co-processor control registers
>> -
>> -  reg-names:
>> -    items:
>> -      - const: nvme
>> -      - const: ans
>> -
> Keep properties defined at the top level. More below.
>
>>     resets:
>>       maxItems: 1
>>   
>> @@ -68,25 +59,53 @@ properties:
>>   
>>         The SART address filter is documented in iommu/apple,sart.yaml.
>>   
>> -if:
>> -  properties:
>> -    compatible:
>> -      contains:
>> -        enum:
>> -          - apple,t6000-nvme-ans2
>> -          - apple,t6020-nvme-ans2
>> -then:
>> -  properties:
>> -    power-domains:
>> -      minItems: 3
>> -    power-domain-names:
>> -      minItems: 3
>> -else:
>> -  properties:
>> -    power-domains:
>> -      maxItems: 2
>> -    power-domain-names:
>> -      maxItems: 2
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: apple,t8132-nvme-ans2
>> +    then:
>> +      properties:
>> +        reg:
>> +          items:
>> +            - description: NVMMU registers
>> +            - description: NVMe registers
>> +            - description: ANS2 co-processor control registers
>> +        reg-names:
>> +          items:
>> +            - const: nvmmu
>> +            - const: nvme
>> +            - const: ans
> New entries go on the end.
Ack
> So nvmmu last and defined at the top level.
I did read the docs which said the properties should always be 
introduced at the top-level, however I couldn't figure out how to 
describe the intended constraints in this way.
> Then this is just 'minItems: 3'
>
>> +    else:
>> +      properties:
>> +        reg:
>> +          items:
>> +            - description: NVMe and NVMMU registers
>> +            - description: ANS2 co-processor control registers
>> +        reg-names:
>> +          items:
>> +            - const: nvme
>> +            - const: ans
> And 'maxItems: 2' on these 2.

When the three items are defined at the top-level, I can't seem to make 
the dtbs_check work:

[...]
arch/arm64/boot/dts/apple/t8112-j413.dtb: nvme@27bcc0000 
(apple,t8112-nvme-ans2): reg: [[2, 2076966912, 0, 262144], [2, 
2000683008, 0, 16384]] is too short
     from schema $id: http://devicetree.org/schemas/nvme/apple,nvme-ans.yaml
arch/arm64/boot/dts/apple/t8112-j413.dtb: nvme@27bcc0000 
(apple,t8112-nvme-ans2): reg-names: ['nvme', 'ans'] is too short
     from schema $id: http://devicetree.org/schemas/nvme/apple,nvme-ans.yaml
[...]

despite this compatible falling into the "... else ... maxItems: 2" branch

Would it be acceptable to define the reg and reg-names with just 
minItems: 2, maxItems: 3, but without specific items or descriptions, 
and then add the compatible-specific items and descriptions in the 
conditional part below?

>
> Rob


Thanks,

- Yureka


