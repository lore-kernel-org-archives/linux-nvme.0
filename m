Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D91DCDDE5B
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 10:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0lkwWXIlhGKVP4z0onrkdlxRvUNDSOzcfhh5w8YfnEo=; b=2MUvfe4pHXxGcEAHxjuo3ZuuXA
	ylc6O64Snn210urh6sJgnyIyDFGJEZIIhHbdGYshvD2+iAjCXSrtRhR/N4strhjO9rAbY4y+1Xxdh
	quBnTIH/lXnZRuNO10wzo2Z7XOGVdHtZzS5e0XwkkasgR0u9VAUJkQqW5My46kOcZOr+IgVqilThA
	IG+X//RGvLyBUbIkgDu39Is/862Wa0X2UAmmrom8Z/P/Sv7kw8lRJJSxk4BCIqcFyNtEx5OWfbRR1
	WRyK67GKD22pVuNoF3rmz2uZ0k5id5LODx3DBaXdb/+Pr0dvzoOgjPMavRAj2s6Omjpn1r8pd+pyE
	t2hQ6Cbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3YTW-0000000DxgM-2BxZ;
	Wed, 23 Oct 2024 10:20:22 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3YJv-0000000Dw0h-3Wfy
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 10:10:29 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2e5a0177531so2724607a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 23 Oct 2024 03:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729678227; x=1730283027; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lkwWXIlhGKVP4z0onrkdlxRvUNDSOzcfhh5w8YfnEo=;
        b=N4X73Moi0WlzkX2Bkg5RYb+aYKr1XwzS+IGlkvpzs8JFoRbPhr91lEqd9SriWsQ45U
         skF4RnjhnPGe6C+m37UEfscH0zn5RFFFRsBGcX/PYTH+BMkprQa7GLhePnyE3iarW45h
         3T/qdBQqEF3wvK8hIQUwDYiyUNtA3jiOPvnrbEgLLnNvO+xYhM+XNoc9B3Dum3xw4Szl
         jGQFuiiUNPRN2Gf4f7ZxmDrXieSaViVz7kWoQmOUQLVM3/TcXHMWwa7hdGcEhqGVVG5B
         ReN/6iFQ2iK77ZKWBBRX5ucxddKkrQClE+gkoSNfhS1i6W53vmW6vlTdQLMDxk1/Mn4U
         XWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729678227; x=1730283027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lkwWXIlhGKVP4z0onrkdlxRvUNDSOzcfhh5w8YfnEo=;
        b=bSDCjnBARcCPCFn3M/vXx2Mcz1qXTIc2T43FE02951aBKxVO7KndB5tgGxwTJ3tm7i
         JUbHtDxdbsIWGGhhhZLtVfK3//LwMzR4pWoP5hbEEbhropoIbl4aOsP9YwBJiVE8TWwx
         8FGctQ86K0/of+UI5UwgGNl88SKlRu84VsTW4cnlhbnSJCgkzo9v03f4gOIAiRkjSKa/
         msr30ceBE4ORaNSa6Yes4LEpwa2Did2OuipGyjYt1jBBFHV6YKvYuCAjBMgcvL30WtKZ
         glXwlsJhZuCn8/d+31WAzGeDl5gliMyKdu7x66fAy7VxPGdYDz/cgqbRk3pZwnitD5zQ
         WWkg==
X-Gm-Message-State: AOJu0YwIm/JKpE7mtu9JoNUSJAlBcyVmLME12E4LBuwt7mGPY0kBESJo
	WlmHS2Nu0jLlRpvlf5mEnZsNf27aMGJUKu1MA3WmMlsLZOeSAX9rJ1yc/w==
X-Google-Smtp-Source: AGHT+IEkXbvncpUGr1O33Gf6A9I/rR9OqlwcSOAGp3AtT6X7Tbj/fvPV/2rtLznGWKkT6+16+A0yig==
X-Received: by 2002:a17:90b:4a41:b0:2e2:aef9:1d8 with SMTP id 98e67ed59e1d1-2e76b5ddd58mr2014514a91.11.1729678226817;
        Wed, 23 Oct 2024 03:10:26 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:2599:5aa5:a0f:e0fd? ([240b:10:2720:5500:2599:5aa5:a0f:e0fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76ddc9e6dsm1000893a91.0.2024.10.23.03.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 03:10:26 -0700 (PDT)
Message-ID: <e18b8cc8-adf1-412a-829a-251601d72a71@gmail.com>
Date: Wed, 23 Oct 2024 19:10:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme: fix nvme_ns_has_pi() to check PI size if
 metadata size or below
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20241022181132.19871-1-ikegami.t@gmail.com>
 <Zxf7DJ-BTW9odH7M@kbusch-mbp>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <Zxf7DJ-BTW9odH7M@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_031027_910956_86C612DD 
X-CRM114-Status: GOOD (  11.36  )
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

Just fixed the function name as mentioned by the v4 patch. Thank you.

On 2024/10/23 4:20, Keith Busch wrote:
> On Wed, Oct 23, 2024 at 03:10:54AM +0900, Tokunori Ikegami wrote:
>> The PI is the first bytes or last bytes of the metadata.
>> So its size is not equal to the metadata size only but below also.
> This is still wrong because the only users of this function are with
> respect to PRACT. If anything, you could change the name from "has_pi"
> to "supports_pract", or something like that.
>
>>   static inline bool nvme_ns_has_pi(struct nvme_ns_head *head)
>>   {
>> -	return head->pi_type && head->ms == head->pi_size;
>> +	return head->pi_type && head->ms >= head->pi_size;
>>   }

