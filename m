Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A641C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 10:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2iioDhnq6PaBtfUsiXiq69Jr/DlZqSRNUpmEQVsu0H8=; b=qbCrzWkTA/TBmHGlgpNVBj3FXT
	VP01MTjPfVZDm90vv4W9QQGfu4SwsYYfYWy8xzj/oMHnWCr+3KOzA2Eak6IP5gCHbxHvm9bL+F3rP
	DhDw9MfYtpV0p4XKjgXa+V0NwYXZJ/xTAQ1IdsrOmHdsYs0fcOeA9k6kjlwich3eOptV5ANei/vcW
	lEhyrUc05LT3zV7BTKbvK7RudMnMLQhRPI14F66ncrImAMZvxKiZrZvupo32QFfqtjqbLE+3GPPlE
	CUy9A2IbsLzc1XX7FCoWKGkySs3v68Ow4KMG47YM+gDR+XVP8a0lPLdZo7CtUCVH+oGozcQqam8LA
	GTTMvTJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3xe7-009v1k-8v; Wed, 22 Jun 2022 10:31:39 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3xe2-009uzU-NA
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 10:31:36 +0000
Received: by mail-wm1-f50.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso8679481wml.1
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jun 2022 03:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2iioDhnq6PaBtfUsiXiq69Jr/DlZqSRNUpmEQVsu0H8=;
        b=is3jg6fw3yzMsFvy+rdTW/xOOigSaSq0cE266DU0Q4tix+AzzLoPe9xVNegrxZkfcX
         dsJHnB8Pr+AGySeQMbYOdHGWF90+m99lOzW/0wzZ4wN2J7QUXXpmYhkyecSLiuRgAN5t
         naEhGFXkbEz5cRPoVZywunzV85NEvMKv7wc/0cF/ZteH1YKj1yuIjVH0QkcRId+XZoPX
         3yGn31fcjVMOq0kU4eEAatucxVxg/G/poNHudj2Gt8Sk5ROFnNS9u6mrExHazOCndzHq
         qexAMoVU5drYdWKrUNtU5YbgskZh3M0DRtjQqvE058Lv7qUmy8UowyWxfKq7uBD45rnw
         DEag==
X-Gm-Message-State: AJIora+gUh3u/28EI1SeHwce5fRYBGptm1MbMK66t9czkSaRmD3hkMjO
	6z+FbxXMuXzMBbCzHP2UW+4=
X-Google-Smtp-Source: AGRyM1tfMFe2Bai7fFPzWLVLGR92GY1GyTZSKpgtVCgyHJK9e2PQnxMJWyibOVeuykFoEeIk2ZTeTA==
X-Received: by 2002:a7b:cd15:0:b0:3a0:26f3:ee7b with SMTP id f21-20020a7bcd15000000b003a026f3ee7bmr3080705wmj.119.1655893892129;
        Wed, 22 Jun 2022 03:31:32 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bg26-20020a05600c3c9a00b0039c45fc58c4sm21769814wmb.21.2022.06.22.03.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 03:31:31 -0700 (PDT)
Message-ID: <bd56ebbc-4895-b1cc-fc16-40dbaffb1879@grimberg.me>
Date: Wed, 22 Jun 2022 13:31:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220621090255.69549-1-hare@suse.de>
 <20220621090255.69549-7-hare@suse.de>
 <f8f0a631-6752-096c-4e85-bcde9bb2869e@grimberg.me>
 <22236c51-90cd-1707-05b8-3772ef4c548d@suse.de>
 <ab4aaf2b-444f-2b3c-091a-396de62afbd1@grimberg.me>
 <a32afeac-983c-2ea4-e693-2d46411e7f4a@grimberg.me>
 <3784f492-67f8-c75a-dccf-7f7272e0b4ad@suse.de>
 <b0e6fa33-ed59-eaa7-3629-3d72430b8ad6@grimberg.me>
 <c06b6657-b015-3ff4-6044-8e800aaeae81@suse.de>
 <5c650ecb-1459-d47c-ed9e-ebd552fe5ffc@grimberg.me>
 <2200e5f1-8af0-25bc-72fb-eac8eaaeeb72@suse.de>
 <e5de2ab8-cf63-d882-1e5d-e94f125bbaa3@grimberg.me>
 <7cedadf1-e1ef-f01b-2265-182181b58d18@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <7cedadf1-e1ef-f01b-2265-182181b58d18@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_033134_792201_C6531AEF 
X-CRM114-Status: GOOD (  26.93  )
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



On 6/22/22 13:26, Hannes Reinecke wrote:
> On 6/22/22 11:58, Sagi Grimberg wrote:
>>
>>
>> On 6/22/22 12:20, Hannes Reinecke wrote:
>>> On 6/22/22 11:09, Sagi Grimberg wrote:
>>>>
>>>>>>>>> Looks like if I pass a malformed ctrl key to nvme connect I am 
>>>>>>>>> able to
>>>>>>>>> crash the system:
>>>>>>>>
>>>>>>>> This was what I used in this:
>>>>>>>> $ nvme connect -a 192.168.123.1 -t tcp  -s 8009 -n testnqn1 -S 
>>>>>>>> "DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I:" -C 
>>>>>>>> "DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"
>>>>>>>>
>>>>>>>> The dhchap_ctrl_key is the offending string...
>>>>>>>>
>>>>>>> Right. Should be fixed with the attached patch.
>>>>>>> Can you check?
>>>>>>
>>>>>> Yes, that works.
>>>>>
>>>>> So, to summarize: With this one and the tentative patch I've sent 
>>>>> earlier:
>>>>>
>>>>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>>>>> index 53184ac76240..a03f41fa146e 100644
>>>>> --- a/drivers/nvme/host/auth.c
>>>>> +++ b/drivers/nvme/host/auth.c
>>>>> @@ -842,6 +842,10 @@ int nvme_auth_negotiate(struct nvme_ctrl 
>>>>> *ctrl, int qid)
>>>>>                  dev_warn(ctrl->device, "qid %d: no key\n", qid);
>>>>>                  return -ENOKEY;
>>>>>          }
>>>>> +       if (ctrl->opts->dhchap_ctrl_secret && !ctrl->ctrl_key) {
>>>>> +               dev_warn(ctrl->device, "qid %d: invalid ctrl 
>>>>> key\n", qid);
>>>>> +               return -ENOKEY;
>>>>> +       }
>>>>>
>>>>>          mutex_lock(&ctrl->dhchap_auth_mutex);
>>>>>          /* Check if the context is already queued */
>>>>>
>>>>>
>>>>>
>>>>> your issues are resolved?
>>>>> Just to clarify before I sent another round of patches ...
>>>>
>>>> No. I don't understand why this patch is needed. As I noted
>>>> earlier, when I pass a wrong ctrl key I fail to connect do
>>>> to authentication error. Also when I pass a malformed ctrl key.
>>>>
>>>> So what does this patch fix? Can you give me an example that should
>>>> have failed before and only with this patch it fails?
>>>>
>>> Reasoning is as follows:
>>> When an invalid controller key is passed via 
>>> 'ctrl->opts->dhchap_ctrl_secret' we'll end up with an empty 
>>> 'ctrl->ctrl_key' in nvme_auth_init_ctrl() (which is what caused the 
>>> original oops).
>>> But the negotiation will still start, and, seeing that 
>>> 'ctrl->ctrl_key' is empty, will _not_ attempt controller authentication.
>>> But as a controller key is passed from userland we should have 
>>> attempted it, and hence an error is in order.
>>
>> Yes, I see it now.
>> And the patch seems to work.
>>
>>>> And for the other issue, please read it again, I think it is related
>>>> to nvme-cli and not this patchset.
>>>
>>> Hmm. Okay, I'll check, and possibly have to create another blktest 
>>> for this ...
>>
>> Looks like a libnvme fix makes the behavior go away:
>> -- 
>> diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
>> index 53199a29e264..2dd863fb8b4c 100644
>> --- a/src/nvme/fabrics.c
>> +++ b/src/nvme/fabrics.c
>> @@ -596,8 +596,11 @@ int nvmf_add_ctrl(nvme_host_t h, nvme_ctrl_t c,
>>                                          nvme_ctrl_get_host_iface(c),
>>                                          nvme_ctrl_get_trsvcid(c),
>>                                          NULL);
>> -               if (fc)
>> +               if (fc) {
>>                          cfg = merge_config(c, nvme_ctrl_get_config(fc));
>> +                       if (fc->dhchap_key)
>> +                               nvme_ctrl_set_dhchap_key(c, 
>> fc->dhchap_key);
>> +               }
>>          }
>>
>>          nvme_ctrl_set_discovered(c, true);
>> -- 
>>
>> Looks like when we scan to see an existing controller in the config,
>> we find it, but merge_config does not touch the ctrl dhchap_key.
>>
>> Maybe it would be better to just add the dhchap_key to the ctrl cfg
>> and have merge_config merge it as well? Or we can live with dhchap_key
>> merged explicitly?
> 
> Hmm. That runs slightly afoul of the merge logic.
> 'merge_config' will overwrite any value _not_ being the default.

There is no ctrl dhchap_key default though...

> Consequently, if a non-default value is already set it won't be 
> overwritten.

Makes sense.

> Which means that if the 'cfg' structure already contained a controller 
> secret (which could've been used, say, for discovery) we won't overwrite 
> it in merge_config().

We probably shouldn't override it this way either if it was explicitly
set by the user no?

> Hence I fear we have to go with your suggestion.

Whatever you choose. Don't really care...

> 
> Will be preparing a pull request.
> 

Thanks

