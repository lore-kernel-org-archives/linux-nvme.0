Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4128BC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 10:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nym35LC3SXIiT2KgvrYSY+Br3Cm+ovwQ5bxS2T7hLes=; b=KGVyQ/hk6Ong55Tu4BHSqwfHe3
	4VKKxQNApqiyWWaF17aDQYpREYaWKdaH5umT2h6rF7vvaqKrB9E2DnnGd9Q+HCFULgKsk5fmThzDM
	xxrZTiCuFfWGiGVyphxcCdAlDtERofTKJYdCWQHzr6L+bqQhP31ofR2dQLr87CeDkps0RABFSGrIK
	oRmx33jybkSuMLr5rARArkcBBkZsyOy+KegbLnMNswNcZKU4I0miO+T8mTtQRkv1mB6+UyWSlKxSm
	d+zQqPmMnoTWOo00uKdBcsIppWxIxRqchqQpN4g+322M7bdEXb1gTfnCxOqQOWy/ACbZTAGvCUXcJ
	Y6CMnORA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9OWf-00AAVJ-1O; Sun, 25 Dec 2022 10:46:41 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9NhQ-009hvV-2Z
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 09:53:46 +0000
Received: by mail-wr1-f50.google.com with SMTP id j17so2728821wrr.7
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 01:53:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nym35LC3SXIiT2KgvrYSY+Br3Cm+ovwQ5bxS2T7hLes=;
        b=bPHN0C+RvrYEuvqg2KZxwwONi22T/4vvyix04V6XVj+C24F9PAn4rkDZ7wIvDM8seJ
         FVfVIu4F0llSkv3c1dlgL5TKVpv0IOuC2wObSbcI4tgUZmJV2U1JLJQnLk3BzG4rNVlB
         NmCLQuzz2sna7wjeZkaoMqcnQwlSZe4uvZsZMxeXJRpA3UbP9WnawcK72vpCT9wqk5JD
         u7YNKURI2kD7JGaza52pGhmyMjFm4u6RctydWEmbb6fDeo5YU0hHetrcs8tPL+jQVLA2
         wQOJR+yvx2D0NhtolcwkcmIz6B0YpoiFdqXMpNn6o/bVqYOpLsRFG4iK5lzpnPdjvBsG
         3TDg==
X-Gm-Message-State: AFqh2kpox33Q869MhKfHVWvt5eNYArmA+BQX/D5lOPzP+HaPBmXn1AqF
	lifRmkULpvld29jMf6pdXUAkmyBUsyg=
X-Google-Smtp-Source: AMrXdXtzKNArgQDisPuLoat8TAEuqqMKeFFwMZWUHhv8zFJled3+d4VWnzOtJ7pe9dc3ynTrS/ugtA==
X-Received: by 2002:adf:e8ca:0:b0:277:5349:2ada with SMTP id k10-20020adfe8ca000000b0027753492adamr2984741wrn.50.1671962022428;
        Sun, 25 Dec 2022 01:53:42 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r17-20020adfdc91000000b0027973315213sm2632992wrj.89.2022.12.25.01.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 01:53:41 -0800 (PST)
Message-ID: <715b6d53-07a2-dcd5-2f44-3c8369318588@grimberg.me>
Date: Sun, 25 Dec 2022 11:53:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvme-pci: place chain addresses in iod
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20221220182131.465092-1-kbusch@meta.com>
 <20221221081647.GA23377@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221221081647.GA23377@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_015344_359757_4AFE36AC 
X-CRM114-Status: GOOD (  12.63  )
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


> On Tue, Dec 20, 2022 at 10:21:31AM -0800, Keith Busch wrote:
>> -#define NVME_MAX_KB_SZ	4096
>> -#define NVME_MAX_SEGS	127
>> +#define NVME_MAX_KB_SZ	8192
>> +#define NVME_MAX_SEGS	128
>> +#define NVME_MAX_CHAINS	5
> 
> NVME_MAX_CHAINS sounds a bit odd.  Maybe MAX_ALLOCATIONS to match
> the nr_allocations field?

Makes sense.

> 
>>   
>>   static int use_threaded_interrupts;
>>   module_param(use_threaded_interrupts, int, 0444);
>> @@ -232,6 +233,7 @@ struct nvme_iod {
>>   	dma_addr_t first_dma;
>>   	dma_addr_t meta_dma;
>>   	struct sg_table sgt;
>> +	void *list[NVME_MAX_CHAINS];
> 
> I think this should a union nvme_data_ptr * so that we have some typing
> information.

nvme_data_ptr is a wire struct, Maybe it would be better if nvme-pci had
its own union for this.

Also, "list" is not a great name, primarily because it is not a list...
maybe data_ptrs ?

