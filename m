Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110E3C433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Apr 2022 16:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2dLCpFjGJHcbliLHP8vYjYtyDcLFIAxcHG+FWPlYX0Y=; b=FVy5TTPmv/mKIdkFvmVye4IbUq
	kFUoc14mKqxab8EfD6Fl6NNOLlouCQ2kM4ou9lsqjScP07Jp9R0GZEKtaFv4KlrzHE3cyKv95UmZ7
	68hymEPDPH8ITUABDU11bfl3OmqryhvfBAZBzw6cd25UBKVbyhFZ5kmmGv/GuxCYoVgzTSBvzD/WV
	Bf6ItlSPOtjT417UFjPFl/vqywfWvOlEy+xoZmH+6yuEApY1/8NHXrlHH1F/Vg54bfYf9Oxrh/KkE
	lqbuXCY+3fgzKH4mUhOy3YiXLPZ8c5DTZQOYKgS97lPOkUnkJ5ZN6cFEFwPyBmtvhbIS9RlVwhahx
	Iw/hyfDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nagH6-009Xtw-Qy; Sat, 02 Apr 2022 16:06:52 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nagGu-009XqC-1c
 for linux-nvme@lists.infradead.org; Sat, 02 Apr 2022 16:06:41 +0000
Received: by mail-ej1-x62c.google.com with SMTP id o10so11735141ejd.1
 for <linux-nvme@lists.infradead.org>; Sat, 02 Apr 2022 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=2dLCpFjGJHcbliLHP8vYjYtyDcLFIAxcHG+FWPlYX0Y=;
 b=tBbneEJqkuWEmHvvIZ2sj5QjCxHGS/7MF+6hk0BfAE8Xwu14gShr3VDv9Mdxg+Nu0L
 PBWZp0jZXBL2NekdL4AVdzt5ZswjSTTAOmS2JJhNXmmwX1hKTWhiCpmf63LX/AQE+UtY
 y10dH21hYS4ZUw9S3dHRaGIpAN6S5pQeH3zOTfIl6Gj1aBMiyGH9Ud0wiDh7JBY+1zRz
 /0JANA/gvz/x7iDVE9OVEmHqb7f0/BIa815oh6GRJKVwguhCA+BrgGH6VYvwZ9p5VxbP
 8vqh+aIKx4jkPkQngehsTaqVvSG2klXmfuGhFtyp/dmQ0vCrIN08vKgGIrMEK2S2ZzVd
 1yWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=2dLCpFjGJHcbliLHP8vYjYtyDcLFIAxcHG+FWPlYX0Y=;
 b=hJAAQsx2PFgeKPJ0GUHwQe66W0hI3CNnMsPTnbaMg1+hOgR9gHo4+qVgufCHVtmOea
 kNvroC5St+WkVycFOc8n5oAIFeJzAZT4mwqijawrHun4T24DOjmaFVwcFM+DLMC+LC2g
 9QMPKRkcukKjtLwrwog/nW85LRnAS2Xm1v+4ymJCjp2vjd+/4BkDQqteLClFwkvRXKNI
 FtuYAlHkkHBzFV0QgmWLC0C2P6ijvFj4OSfnkPOyF0g8b0zqhtnZTrAVKCvlRuhNxwWk
 p4NlGZ7qYZzFCmUtQQx2Dbp8N1agMWs9L77gkHBpW4v8Sn9uWCuX9ucf9eSlTC6HD41k
 dTLA==
X-Gm-Message-State: AOAM532f520Nn15WvuqcphIM/upQzRlOIKAxWur7KeGBNvI/nxgWin0k
 ftbYjZNbRcJvx8dKMzZJcYNPXw==
X-Google-Smtp-Source: ABdhPJyjLMYxJ0JD5o8civ66zWl9Ru0vm3ZudlXy8sQnWNkm60+Uf6naquLmpxZS2J/JRuxzyTi5Aw==
X-Received: by 2002:a17:907:d8d:b0:6df:b214:392a with SMTP id
 go13-20020a1709070d8d00b006dfb214392amr4305563ejc.669.1648915597714; 
 Sat, 02 Apr 2022 09:06:37 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch.
 [188.155.201.27]) by smtp.gmail.com with ESMTPSA id
 u25-20020a170906b11900b006e08588afedsm2209474ejy.132.2022.04.02.09.06.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Apr 2022 09:06:37 -0700 (PDT)
Message-ID: <871296de-76f6-c587-9000-ce38ad14f519@linaro.org>
Date: Sat, 2 Apr 2022 18:06:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/9] dt-bindings: soc: apple: Add ANS NVMe
Content-Language: en-US
To: Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>, Arnd Bergmann <arnd@arndb.de>,
 Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-3-sven@svenpeter.dev>
 <40f7c074-198a-5ce0-02b3-e6042975e228@kernel.org>
 <692ae417-f0c6-4932-95f3-2a0984df5ad0@www.fastmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <692ae417-f0c6-4932-95f3-2a0984df5ad0@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220402_090640_138547_0AAE5F14 
X-CRM114-Status: GOOD (  16.83  )
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

On 02/04/2022 15:05, Sven Peter wrote:
> Hi,
> 
> thanks for the review!
> 
> On Wed, Mar 23, 2022, at 12:14, Krzysztof Kozlowski wrote:
>> On 21/03/2022 17:50, Sven Peter wrote:
>>> Apple SoCs such as the M1 come with an embedded NVMe coprocessor called
>>> ANS2.
>>>
>>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>>> ---
>>>  .../bindings/soc/apple/apple,nvme-ans.yaml    | 75 +++++++++++++++++++
>>>  1 file changed, 75 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml
>>> new file mode 100644
>>> index 000000000000..e1f4c1c572aa
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml
>>> @@ -0,0 +1,75 @@
>>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/soc/apple/apple,nvme-ans.yaml#
>>
>> Do not drop all code in soc/apple, but please use respective subsystems.
>> Apple is not a subsystem, is not special.
>>
> 
> Sure, the code is already inside drivers/nvme/host but I'll also create
> Documentation/devicetree/bindings/nvme and put the bindings in there as
> well.

Yes, please. We have also Documentation/devicetree/bindings/nvmem/ but
it seems its entirely different stuff.


Best regards,
Krzysztof

