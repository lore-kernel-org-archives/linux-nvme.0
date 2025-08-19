Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CC6CA0EEB
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JhdsKX56RwsGICp3BQp/z9mrdacLx4xWU2W+rdbaAgE=; b=tWh4hne+64vgtzD178UVTDAQM9
	L0AnRHwJffqEmrkwoSm8S4BueG43T4l2N2ZUcTDHWDlLRGaizGpYwvV4908Zn6KF5kpt8kMOrp0w2
	aY3angeXJZfsUDoEfjPB6pjQLeuhfjVRJ8udcR6txUER8pU2ACXVumieG3kJe67FxhXgzIXKW/IOx
	p248wsV6aTFadujDfEYwYtCPtSzW4gp8C7FPFkNAVayjeXelKowm5RHI7go1I/vN8n9xvk+K1inbO
	L9QiSAUWDdi9ipN63XQRUwzpXLGUO9rRTv/5ZkfzOrN/aUX51YF6KVZgXsV5YMlBhwjxJBrE+voOs
	V9LcmiPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoKns-0000000AKWI-2GkE;
	Tue, 19 Aug 2025 11:47:00 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoJAJ-0000000A3xR-2Tll;
	Tue, 19 Aug 2025 10:02:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 08BDC43854;
	Tue, 19 Aug 2025 10:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC44AC4CEF1;
	Tue, 19 Aug 2025 10:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755597722;
	bh=pw2fnfhmflhIZ1bq9JJ2pTYcVzb7LXTiDoC60DsC640=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PSrIBn5uEJo54gUUN0UoLpYD3c1+PxV/rMhboUSl03RK7VARtjkynNxTz1k+Jr9ee
	 mZpssBb475d5oZxbWZINXl3wS2z4JWXLpQKzlrIc729FGIlhg2jlrbK2IGRt5s1MKC
	 3kt2SygUnQrp0D+Ate39vermY65xaeBwJakkdHHBjkTJF7aUFk+BxspRplvBcGlPTU
	 Smx4jIR5LXurX6sjK1vV06M7gQbIH4mnucf8tPUnxNe+hWYJyAHP+puWDqMbXbYnWl
	 gQEvkNoapYYK9DGdXdm46nQbwhs1mxIYQ6sJsxSy1hiSE+GPtPn3GUKXXYR0Zqu/wV
	 4B89QRfZt5XSw==
Message-ID: <8ac418ae-7ff0-4d5c-9f11-c24e36618ac1@kernel.org>
Date: Tue, 19 Aug 2025 12:01:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
To: Krzysztof Kozlowski <krzk@kernel.org>, Nick Chan <towinchenmi@gmail.com>
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
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
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250819-polite-papaya-catfish-1a9d1a@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_030203_672292_6F23CD0F 
X-CRM114-Status: GOOD (  22.50  )
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

On 19.08.25 11:18, Krzysztof Kozlowski wrote:
> On Mon, Aug 18, 2025 at 04:42:59PM +0800, Nick Chan wrote:
>> Add ANS2 NVMe bindings for Apple A11 SoC.
>>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>> ---
>>   .../devicetree/bindings/nvme/apple,nvme-ans.yaml          | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>> index fc6555724e1858e8a16f6750302ff0ad9c4e5b88..4127d7b0a0f066fd0e144b32d1b676e3406b9d5a 100644
>> --- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>> +++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>> @@ -11,12 +11,14 @@ maintainers:
>>   
>>   properties:
>>     compatible:
>> -    items:
>> -      - enum:
>> -          - apple,t8103-nvme-ans2
>> -          - apple,t8112-nvme-ans2
>> -          - apple,t6000-nvme-ans2
>> -      - const: apple,nvme-ans2
>> +    oneOf:
>> +      - const: apple,t8015-nvme-ans2
>> +      - items:
>> +          - enum:
>> +              - apple,t8103-nvme-ans2
>> +              - apple,t8112-nvme-ans2
>> +              - apple,t6000-nvme-ans2
>> +          - const: apple,nvme-ans2
> 
> When some months ago this pattern of generic fallback appeared, I
> believe I commented it is bad idea. So now months later we have a proof
> - generic fallback is useless and you should have been using SoC
> specific compatibles from the start.
> 
> Now it is just confusing and this broken pattern will be spreading more
> and more, because you folks put generic compatibles everywhere.

I haven't commented on the dt-bindings yet because I suspect this patch 
is wrong but haven't had time to test this yet.

I believe we want "apple,t8015-nvme-ans2", "apple,nvme-ans2" here and
then use the code Nick added for "apple,nvme-ans2" by default and only
enable additional features (NVMMU, linear submission queue) when we see
the SoC-specific compatibles for t8103, t8112, and t6000. IIRC these
newer SoCs still support the old way of submitting commands just fine
and the new way was added at some point to add support for this weird
integrated IOMMU.

I've already seen some strings about ANS3 somewhere which I suspect
will be the controller in some future SoC (or maybe M3/M4 which we 
haven't reverse engineered yet) that actually breaks compatibility.

It's too late to drop them here but if you're strongly opposed to these
generic fallbacks we can just switch to only use tXXXX-nvme-ans3 at that
point without making anything confusing. Same for any other new hardware
blocks we reverse engineer and upstream.



Sven



