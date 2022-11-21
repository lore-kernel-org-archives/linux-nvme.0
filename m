Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B02C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 11:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CJP7h+npxhO5VKykB8xYMm/E4EmA3Cz1dZUrnS/FoMw=; b=GETvYncTw3gH9IosYUbLj+ooiL
	h6UU5fezc7aWYtBygow1/FpaWB5Y33Bb68Z4uUFPbG9mhxw67R6xc4IigSMOpmeL3nc1xOlzbiSbQ
	HqnXlqcsc5hWrsVwNgtzlhyOTK94bEUFblhRkZM7eulJlGakqSKhoQd6VQpA4DKHH6bELHPH9k8zz
	FVf0B28yXFsZ1BEzErTG0ZvClLVlIz0TB8Ob9xn4eHhzRzbnEzaEUAzrnh18Dcbf6hWiEHsbngDkt
	yxv6AcEzLg56rSEl8PynRxD/DEkzqMS498I4H8Pry5oO2l7l0DlHn+Rp2bt5UnE+k0ZcVSrrQ9AKb
	1iEeThBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox59m-00D06u-O9; Mon, 21 Nov 2022 11:40:10 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox59g-00D03I-CM
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 11:40:05 +0000
Received: by mail-wr1-f53.google.com with SMTP id bs21so19431236wrb.4
        for <linux-nvme@lists.infradead.org>; Mon, 21 Nov 2022 03:40:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJP7h+npxhO5VKykB8xYMm/E4EmA3Cz1dZUrnS/FoMw=;
        b=NN22NTJxSFfGqaV+m1pGZrpT3/9NrIPLcf/6VyINV90uUXSt3CG7sJ2rp7skCH6KLG
         hESn/278lSUIAGImF5DDG1Jkj5okIij8rpwMovCDJFGucpquChZFsaJRtrjlCBewBR8Z
         qL0gXHD2RN9Zm2mKiZfW+A4Czd5hegRGr4xYAUp8CpBdqAZuRwhM0j0PdXuAQncM1wSk
         7LrPF8duuCd/hdqkR2x2tK70I+PT1g03/hnV8tjQZzPbYAvjHJpvAGRAX5S1CivetSF0
         c6LHjGlVnuw5zltjFQfnpUxinldz2MiLEznOQif8R7kxLoH+i71hu6VNk/5mTigWEkwk
         BDMg==
X-Gm-Message-State: ANoB5pnbSij0t3uwJK3GGWoumyy2Bg47NHtB02q/5bDAU1syIlTZSxm3
	iH5oJS+fgReLoPAw8IqgXw11fM9arrk=
X-Google-Smtp-Source: AA0mqf4hpBjwb/hEz7rDkEiVuMpH2HcZczWkf8KCOvnrZyps7ty68/8P8DAqcXqh2NjVg80vKDGMCA==
X-Received: by 2002:a05:6000:501:b0:22c:d27d:12e4 with SMTP id a1-20020a056000050100b0022cd27d12e4mr10452507wrf.546.1669030801398;
        Mon, 21 Nov 2022 03:40:01 -0800 (PST)
Received: from [192.168.64.178] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o7-20020a056000010700b002366f9bd717sm13261248wrx.45.2022.11.21.03.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:40:01 -0800 (PST)
Message-ID: <9a9512de-1bbc-fafb-74d1-3bd0a156ab81@grimberg.me>
Date: Mon, 21 Nov 2022 13:39:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSBudm1lOiBmaXggbWVtbGVhayBpbiBu?=
 =?UTF-8?B?dm1lX2N0cmxfZGhjaGFwX3NlY3JldF9zdG9yZSgp?=
Content-Language: en-US
To: zhangqilong <zhangqilong3@huawei.com>, "hare@suse.de" <hare@suse.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20221121062113.84721-1-zhangqilong3@huawei.com>
 <b86df48d-2fd2-fe90-a1c2-721cb51d826e@grimberg.me>
 <dacd7300dfe54845b6a5ef2ee8f940d7@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <dacd7300dfe54845b6a5ef2ee8f940d7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_034004_501380_5C99C739 
X-CRM114-Status: GOOD (  15.35  )
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



On 11/21/22 13:33, zhangqilong wrote:
>>
>>> If dhchap_secret is not consistent with options or
>>> nvme_auth_generate_key() fails, we should free the memory of
>>> dhchap_secret to avoid memleak.
>>>
>>> Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
>>> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
>>
>> Please have a look at nvme-6.2, if there is still a leak, please send a patch
>> against it.
>>
> 
> Hi
>       I have checked it,  there is still a leak at nvme-6.2.

Cool. Thanks

> 
> Thanks.
> 
>> Thanks.
>>
>>> ---
>>>    drivers/nvme/host/core.c | 7 +++++--
>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c index
>>> da55ce45ac70..e06d1b3961fe 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -3748,13 +3748,16 @@ static ssize_t
>> nvme_ctrl_dhchap_secret_store(struct device *dev,
>>>    		int ret;
>>>
>>>    		ret = nvme_auth_generate_key(dhchap_secret, &ctrl-
>>> host_key);
>>> -		if (ret)
>>> +		if (ret) {
>>> +			kfree(dhchap_secret);
>>>    			return ret;
>>> +		}
>>>    		kfree(opts->dhchap_secret);
>>>    		opts->dhchap_secret = dhchap_secret;
>>>    		/* Key has changed; re-authentication with new key */
>>>    		nvme_auth_reset(ctrl);
>>> -	}
>>> +	} else
>>> +		kfree(dhchap_secret);

Perhaps lets change the check above to strncmp directly against buf and
allocate inside the clause.

>>>    	/* Start re-authentication */
>>>    	dev_info(ctrl->device, "re-authenticating controller\n");
>>>    	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
> 

