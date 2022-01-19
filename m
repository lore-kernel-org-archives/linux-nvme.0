Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3F6C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jan 2022 11:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v4axeg+ESBTvBgQ0GcEaPe9YP/WOPrunf7224+7KR04=; b=2ZKJjK18eY5l3UOqyoltJ8p/U9
	IDtgjBkVXeatkGSbeY8GAEWJQ5+l7v0ni96eKQFZGuK4r/mNGOaGH4aAd9Kmgz2sNnESu729+8TMm
	E9b7tQvuGFWhScwQK5sPfr18nN8zH/vlS7nZINBIZo+3MYnXNmr2FX24Sox1x84DLgbKJ8jzGuykZ
	sSGEa10W3TtHfFUCmzjJ1q2kl4YcE2ibQ3m/CGphxvRnUD0cc/vquQ9he1C7HLKLRqlcHuLCi7wND
	eU1mmBjWW6fViZySDQmbxwi+cPa1MWcj9RgnIgJWNbeKrwYwfzTzV4RrDG27w8JwTFw7HiumPuxuC
	VsuVLeHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nA94s-0058js-Ok; Wed, 19 Jan 2022 11:24:34 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nA94n-0058it-1b
 for linux-nvme@lists.infradead.org; Wed, 19 Jan 2022 11:24:30 +0000
Received: by mail-wm1-f49.google.com with SMTP id p18so4738951wmg.4
 for <linux-nvme@lists.infradead.org>; Wed, 19 Jan 2022 03:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v4axeg+ESBTvBgQ0GcEaPe9YP/WOPrunf7224+7KR04=;
 b=mZnq2fRQKSf3O2h/Y3zEECbGwIyxLnl8ivpnBO7J8iu/myvTyIBIq9EBSJYsKoSigD
 8NfsNY6U7yQXJXRtov6Gzhh37JWSsmNb5oDDUBLLCZZiURnTPtz9EP2p9nVmgEk/JlLw
 W9XnU4odO35XeDcImBDSgaXZMr3ptShupA/cEe/knoFj2gXySPfpLSdZ0xF5HriD8QTQ
 7qPeMArAE6/l/0qkBcu/aEARNY/nm4m44xGy5spA1ILGLXn2DMmbMbIdjLAbIYCiQt3L
 HEfrr9EYnUoqZheelxrVckZhAN37a57gyMOwh0xaM/j8O96C/Y93CcOBvpr/R6Mdpkxs
 ZXTA==
X-Gm-Message-State: AOAM532IppbhkGchjAovMWi7YFEIhB1DWdFipDMClmtu04Qv4VE5/dnm
 wYX1UX8+XqiBw8/RupvV8Qk=
X-Google-Smtp-Source: ABdhPJwHl9Nh58+mbgGtlZlXqFp6WzZvLLc1NcQOYo/5lWRkVTS6umA+EB2fCIiRHk+8sFzCrE56Zg==
X-Received: by 2002:a05:6000:91:: with SMTP id
 m17mr27063739wrx.533.1642591465326; 
 Wed, 19 Jan 2022 03:24:25 -0800 (PST)
Received: from [10.100.102.14] (46-117-118-170.bb.netvision.net.il.
 [46.117.118.170])
 by smtp.gmail.com with ESMTPSA id z17sm19338895wrh.87.2022.01.19.03.24.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jan 2022 03:24:24 -0800 (PST)
Subject: Re: [PATCH 5/5] nvme-fabrics: set ret to -ENODEV for error case
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
References: <20220112062101.90102-1-chaitanyak@nvidia.com>
 <20220112062101.90102-6-chaitanyak@nvidia.com>
 <20220113162840.GE3230285@dhcp-10-100-145-180.wdc.com>
 <09ae3d37-d22a-af44-9ea8-5d6f95c70ede@nvidia.com>
 <e90fda23-5438-c250-b530-30590867217d@grimberg.me>
 <b9d23021-05c8-0f34-e1b4-86e6a81ea80c@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d0ccb295-14a5-f2fb-f015-4a91bbb8f4b9@grimberg.me>
Date: Wed, 19 Jan 2022 13:24:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b9d23021-05c8-0f34-e1b4-86e6a81ea80c@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220119_032429_127052_91958B7A 
X-CRM114-Status: GOOD (  17.60  )
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


>>>> I missed the discussion on this. Doesn't the __nvmf_concat_opt_tokens()
>>>> already return parameters that indicate to the caller that no controller
>>>> was found?
>>>>
>>>
>>> The function I found in the repo returns nothing, is that the one you
>>> are referring to ?
>>>
>>> static void __nvmf_concat_opt_tokens(struct seq_file *seq_file)
>>
>> This is the path that Hannes added for userspace to detect kernel
>> capabilities. So probably its not appropriate to return an error
>> here, but rather take care of the original warning instead.
> 
> When I look at the code it looks unconventional to not return
> error when controller not found case, why is it not appropriate
> to return error can you please explain ?
> 
> Can we add a meaningful comment to avoid future such patches.

That is how Hannes proposed to read capabilities from the kernel
in terms of valid connection string arguments. Read /dev/nvme-fabrics
without a controller.

