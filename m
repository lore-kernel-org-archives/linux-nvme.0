Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36468C77B73
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 08:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uN44ThAsReaJEu+mEPgThZfAT6oBVuEr6BhHBNOIrts=; b=TqzHCb2EvX8VYhihPGli7k0/IB
	mN9bEWmPVaIbglP6Awi1EjdWWXBfwc+Hj8kM/vaGj7/o/nRxKMvGIAnaQNttw8lnpjPxDh6qrG/cH
	pdYkWHGPfQtthQH5MGImoWuctxS/qPnmAmkGiFaV8YKqHhNf9hOfKPLMBBblZLLz5xxEWYKzVxaP9
	pX5WdsubMHyO3IxCrLzNINpGIc0/8rvzo/xXLH0EB7cLm/7KJeIVCvgHLA4RyFcx4XBL4YMT89eqT
	psMwWSqzjLpEF3tmhgYB2vYLoZfZfMLLh0QRuqvaPMjLyQn5WuGd5W98mxgqcFsG8Qrnwcz73CNcI
	c7hZMQYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptP9H-00FTSO-0i;
	Mon, 01 May 2023 08:44:43 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptP98-00FTHv-1g
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 08:44:39 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f174c4b404so3202885e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 May 2023 01:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682930672; x=1685522672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uN44ThAsReaJEu+mEPgThZfAT6oBVuEr6BhHBNOIrts=;
        b=AkKbtggCoicnzS+wD2t0H/a3AwOiox2tOLV5Mqb3y20+ZTlRsyMT9CiWSwkRGaFK//
         IuTGbcFPrMfuIFOENkavaRL246euWhdFm3SuvhZ2AgRchRfGoaftsiSMkWnLnZRsKsCE
         tv6oI9Hq79BNxytJU3Y/y0qbHnZMmkzgUM9J8aOsYyxXU0WsRfd3X0Mt7KKmn4jQar2v
         CHDkh7wbPsKHBEg/Rx1Be+fXcDiWvKYsT0xxF8fmA3o4TwZlfgasmt5Li0UfgniOcaek
         jGMeSB3REN0Td3dGu2Z5+Q8l4F/G2E0S7Jy8XjlAts6K+pQvI/ag5Ik8mCF6rfhdBuW6
         NIYg==
X-Gm-Message-State: AC+VfDwHQMGA+fRk2xhNmmQhMJ8HSlvP89JQJg3OPAYy4xXKw4xR6QAz
	GQZSowmybRFOBdqiMGzViIY=
X-Google-Smtp-Source: ACHHUZ62M47GMYHvqloK+V4Z1y7qx8RrKV7E1EW8YnSr4aJMAJZCoW/8x02aI7rkcNrgylBqR3MLhg==
X-Received: by 2002:a05:600c:1d02:b0:3f0:a845:f215 with SMTP id l2-20020a05600c1d0200b003f0a845f215mr9870756wms.3.1682930671736;
        Mon, 01 May 2023 01:44:31 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v19-20020a05600c215300b003ee20b4b2dasm31961366wml.46.2023.05.01.01.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 01:44:31 -0700 (PDT)
Message-ID: <4f1c6b01-7abe-0599-8249-e3c77072ad61@grimberg.me>
Date: Mon, 1 May 2023 11:44:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [bug report] kmemleak observed during blktests nvme-tcp
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>
References: <CAHj4cs-nDaKzMx2txO4dbE+Mz9ePwLtU0e3egz+StmzOUgWUrA@mail.gmail.com>
 <6e06dffd-e9a1-da5a-023f-ac68a556692f@grimberg.me>
 <CAHj4cs99us_r4Ebth5oAJMqHHA9aXZCpq0A3uu1BEdNw2GeRww@mail.gmail.com>
 <f74df8a4-03c6-6687-7ada-35aa268f44b9@nvidia.com>
 <763959d1-8876-31f0-25ee-57ddb2049c75@nvidia.com>
 <CAHj4cs_urWYi_yPQ-FoFo2kV4h1gz-mwxfRiOTj7co3=bUnO5w@mail.gmail.com>
 <CAHj4cs-MtUM=7w=YG2ohATeA1HSZp_5CT1Y9DATDEqPPMZ8MMw@mail.gmail.com>
 <e5717ee0-e2af-9266-4bfc-e792d53f4403@nvidia.com>
 <CAHj4cs8DPVKPs8o+tN7cdZrvZKVRAjG5-cEZspL1N0JG-a4Oag@mail.gmail.com>
 <19c61e06-0d06-c209-d6b7-adac52df27fc@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <19c61e06-0d06-c209-d6b7-adac52df27fc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_014434_575352_8C066C47 
X-CRM114-Status: GOOD (  20.23  )
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



On 5/1/23 11:23, Chaitanya Kulkarni wrote:
> On 4/27/23 08:57, Yi Zhang wrote:
>> On Thu, Apr 27, 2023 at 6:58 PM Chaitanya Kulkarni
>> <chaitanyak@nvidia.com> wrote:
>>> On 4/27/23 00:39, Yi Zhang wrote:
>>>> oops, the kmemleak still exists:
>>> hmmm, problem is I'm not able to reproduce
>>> nvme_ctrl_dhchap_secret_store(), I could only get
>>> cdev ad dev_pm_ops_xxxx. Let's see if following fixes
>>> nvme_ctrl_dhchap_secret_store() case ? as I've added one
>>> missing kfree() from earlier fix ..
>> Hi Chaitanya
>>
>> The kmemleak in nvme_ctrl_dhchap_secret_store was fixed with the
>> change, feel free to add:
>>
>> Tested-by: Yi Zhang <yi.zhang@redhat.com>
>>
>>
> 
> I was able to fix remaining memleaks from for blktests
> nvme/044-nvme/045 with nvme-loop and nvme-tcp transport. I've tested
> following patch with blktests and memleak on, also specifically tested
> two testcases in question, whenever you have time see if this fixes all
> issues, below are the logs from my testing, here is the patch :-
> 
> linux-block (for-next) # git diff
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 42e90d00fc40..245a832f4df5 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5151,6 +5151,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct
> device *dev,
> 
>           BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
>                           PAGE_SIZE);
> +       ret = nvme_auth_init_ctrl(ctrl);
> +       if (ret)
> +               return ret;
> +
>           ctrl->discard_page = alloc_page(GFP_KERNEL);
>           if (!ctrl->discard_page) {
>                   ret = -ENOMEM;
> @@ -5195,13 +5199,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct
> device *dev,
> 
>           nvme_fault_inject_init(&ctrl->fault_inject,
> dev_name(ctrl->device));
>           nvme_mpath_init_ctrl(ctrl);
> -       ret = nvme_auth_init_ctrl(ctrl);
> -       if (ret)
> -               goto out_free_cdev;

This does not seem to me like a fix, but a particular way to hide the
issue.

