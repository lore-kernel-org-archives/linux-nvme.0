Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B733C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 09:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R+7vE+jeNao9KtaodsC0E+DfZ/GIKkHkbM2HwIjt6us=; b=1by2mUBwEqxAKj+dKnVtnse+Y6
	lxqf03P5p26HTlwyBmU/u7ba1L1WgCLVzZLYOGY5Kb4aEgusHzfscJ7vmbHnONmlifXQ84tEfUH/4
	29owwP5/qSYDl8o7mQ/rMqfdBNut3I7q+LEFKqJn1YC+DEhjwiBhRvtN92+QG1dZerdVM51qnOQRF
	WduMmJJ63eqFoeUPw6SXlBfDlXyw6z7K85aJdWVkKymItDj8gICmAZaKFDYaOeNRghfTj3sDS4F5F
	kckFtoPavtY+zogwUez42L9d0YYYKcka0KqOPj7pI1uUl5pEcrg1i0rP7AI9X5VO+pMoPos3/l5bg
	jKcKBtow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3x8E-009kHU-2G; Wed, 22 Jun 2022 09:58:42 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3x8B-009kFW-7s
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 09:58:40 +0000
Received: by mail-wm1-f51.google.com with SMTP id u12-20020a05600c210c00b003a02b16d2b8so500535wml.2
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jun 2022 02:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R+7vE+jeNao9KtaodsC0E+DfZ/GIKkHkbM2HwIjt6us=;
        b=zsf0OaZ9V9RX7d7TkLYnsKJ8bfZlW3sMSitaBgBmnWPAqKNnBzr9caZ/Sa88BSLJwL
         KTI1Hm4MjihEvt6a3tOz+gYu1ARy+EufUQx5ViDNr4NGdl6PXRiUjIf5cjfUeN1pUVMh
         54HgbMZ4q8qR/zphE37x7Rl+cPwBriOsFgVbGdgYfV4s3vr7HUD95U/8+wD+3TTQrBMp
         KgKzhdXrq0J5gowuggDaWHKfZQaaW7l2D12/5zemrG+214BlYgdyrPTWRa6e40gqPVuC
         KmIB6SG/gakDDyfKjA42r8h3brj45Ef3D/iAY7DC6O8Z5ygsDrGRInpQSdNS4/3+Kr5q
         v3jA==
X-Gm-Message-State: AJIora8kn94LOhrwvvA1BtcXJbmdwICdzhgF9DzMBeksR8EIK5ou0Sms
	KMpoUcB+krDFAH65x9FHWlM=
X-Google-Smtp-Source: AGRyM1vNdf26VrgspXQsxa0xjx2U96VcUz+i7cS4jOhQLvnXnPA0wbDceLdO5jaup9y9BGvB6mHbfw==
X-Received: by 2002:a05:600c:3b02:b0:397:5cfb:b849 with SMTP id m2-20020a05600c3b0200b003975cfbb849mr2932177wms.183.1655891916295;
        Wed, 22 Jun 2022 02:58:36 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z7-20020a1c4c07000000b0039c4b518df4sm25939281wmf.5.2022.06.22.02.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 02:58:35 -0700 (PDT)
Message-ID: <e5de2ab8-cf63-d882-1e5d-e94f125bbaa3@grimberg.me>
Date: Wed, 22 Jun 2022 12:58:34 +0300
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
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2200e5f1-8af0-25bc-72fb-eac8eaaeeb72@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_025839_323136_98BA6C90 
X-CRM114-Status: GOOD (  26.00  )
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



On 6/22/22 12:20, Hannes Reinecke wrote:
> On 6/22/22 11:09, Sagi Grimberg wrote:
>>
>>>>>>> Looks like if I pass a malformed ctrl key to nvme connect I am 
>>>>>>> able to
>>>>>>> crash the system:
>>>>>>
>>>>>> This was what I used in this:
>>>>>> $ nvme connect -a 192.168.123.1 -t tcp  -s 8009 -n testnqn1 -S 
>>>>>> "DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I:" -C 
>>>>>> "DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"
>>>>>>
>>>>>> The dhchap_ctrl_key is the offending string...
>>>>>>
>>>>> Right. Should be fixed with the attached patch.
>>>>> Can you check?
>>>>
>>>> Yes, that works.
>>>
>>> So, to summarize: With this one and the tentative patch I've sent 
>>> earlier:
>>>
>>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>>> index 53184ac76240..a03f41fa146e 100644
>>> --- a/drivers/nvme/host/auth.c
>>> +++ b/drivers/nvme/host/auth.c
>>> @@ -842,6 +842,10 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, 
>>> int qid)
>>>                  dev_warn(ctrl->device, "qid %d: no key\n", qid);
>>>                  return -ENOKEY;
>>>          }
>>> +       if (ctrl->opts->dhchap_ctrl_secret && !ctrl->ctrl_key) {
>>> +               dev_warn(ctrl->device, "qid %d: invalid ctrl key\n", 
>>> qid);
>>> +               return -ENOKEY;
>>> +       }
>>>
>>>          mutex_lock(&ctrl->dhchap_auth_mutex);
>>>          /* Check if the context is already queued */
>>>
>>>
>>>
>>> your issues are resolved?
>>> Just to clarify before I sent another round of patches ...
>>
>> No. I don't understand why this patch is needed. As I noted
>> earlier, when I pass a wrong ctrl key I fail to connect do
>> to authentication error. Also when I pass a malformed ctrl key.
>>
>> So what does this patch fix? Can you give me an example that should
>> have failed before and only with this patch it fails?
>>
> Reasoning is as follows:
> When an invalid controller key is passed via 
> 'ctrl->opts->dhchap_ctrl_secret' we'll end up with an empty 
> 'ctrl->ctrl_key' in nvme_auth_init_ctrl() (which is what caused the 
> original oops).
> But the negotiation will still start, and, seeing that 'ctrl->ctrl_key' 
> is empty, will _not_ attempt controller authentication.
> But as a controller key is passed from userland we should have attempted 
> it, and hence an error is in order.

Yes, I see it now.
And the patch seems to work.

>> And for the other issue, please read it again, I think it is related
>> to nvme-cli and not this patchset.
> 
> Hmm. Okay, I'll check, and possibly have to create another blktest for 
> this ...

Looks like a libnvme fix makes the behavior go away:
--
diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 53199a29e264..2dd863fb8b4c 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -596,8 +596,11 @@ int nvmf_add_ctrl(nvme_host_t h, nvme_ctrl_t c,
                                         nvme_ctrl_get_host_iface(c),
                                         nvme_ctrl_get_trsvcid(c),
                                         NULL);
-               if (fc)
+               if (fc) {
                         cfg = merge_config(c, nvme_ctrl_get_config(fc));
+                       if (fc->dhchap_key)
+                               nvme_ctrl_set_dhchap_key(c, fc->dhchap_key);
+               }
         }

         nvme_ctrl_set_discovered(c, true);
--

Looks like when we scan to see an existing controller in the config,
we find it, but merge_config does not touch the ctrl dhchap_key.

Maybe it would be better to just add the dhchap_key to the ctrl cfg
and have merge_config merge it as well? Or we can live with dhchap_key
merged explicitly?

