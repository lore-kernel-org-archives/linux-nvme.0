Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880A1C77B71
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 10:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vVcOCrGLH0tQIvj6TC4WA++T6xHKTjj21P8pX9bFbus=; b=VLGTMBZxv/PIwjB7FJc6P93Ppg
	nvnegMOPb4XyvxjVG2aI9slxatUl5iBrtsooo88PHwWA6mg1fxlZwHnFA1BRO6Kd6BCU0h1M1JcHh
	bSW4JZ6KmpX9Ds4eHGd15aOHvQ3FHjlstqyeGmJ+FD3LFaKEMX2IJ8ehFZLOhWdznzuIg4mTNP3+w
	uTLNbuPwlbdmYVg4VwtKWm8Fmm3ltO/NnIOuCQsgMRGjx87xr3fJiISrajtdXWjK6snsCrO7f/nG+
	pW8TeGnHbHoFtRrzcbwzx1Epm1eKj1a/m2t3wEkovr0JgNInOnHRrh1DQKumzuF4V4Ow7vbTNjJ/H
	liutTleQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poidI-001hCS-1g;
	Tue, 18 Apr 2023 10:32:20 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poidE-001h9t-2D
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 10:32:18 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-2f4130b898cso432644f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 18 Apr 2023 03:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681813935; x=1684405935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVcOCrGLH0tQIvj6TC4WA++T6xHKTjj21P8pX9bFbus=;
        b=H/Qqr5CX8iWkqXpgIqzS1w3RnCs7JERWdrrSGrFWCog1Z+iro/NFQ1fmlwY9RU2BW2
         p74xcajtwSzt31OuuR71CxAZyEHaeyNPU2m9+E6DWnD4c8SXZpG+QpCcQt2kiv6jO3JG
         Y+w/ZZ4U0nX8/+CCuU4l0/qCIqe56Siq6u0cy9XmTSe0TODoxC+0m22jsCdI7yztZ0al
         ci8IGh/pVL62gwSmKh4PNJX8Tk+Nq0/EmcSjNypSQqoTRz+45Rz2Lce2nK8LEU/B/+Nt
         0sRYWuYXbAoconNTAmiElyC0c3tIFYtZpRk2eVXBx4NkHtkSAqJkMgna5qsw5YB6vQUM
         Bvaw==
X-Gm-Message-State: AAQBX9f2nJCqtqU5lPZxm0bv00/gPy0MIM16Lp914BO/7viJeOgLDduZ
	4cFGbdBFKHm8EiS3CMJTJxQ=
X-Google-Smtp-Source: AKy350ZHkQOzkQPltNiwqs3Ihj4mwazPQWDYyqriNPfFcI7RWa0jwcM6XE/0Nsj7J2HHnOxG0EbdOg==
X-Received: by 2002:a5d:548e:0:b0:2c7:1c72:699f with SMTP id h14-20020a5d548e000000b002c71c72699fmr8803274wrv.4.1681813934723;
        Tue, 18 Apr 2023 03:32:14 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x14-20020adfdd8e000000b002efb4f2d240sm8118944wrl.87.2023.04.18.03.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 03:32:14 -0700 (PDT)
Message-ID: <b26166ce-3c3f-912e-d057-9a1a2dc45967@grimberg.me>
Date: Tue, 18 Apr 2023 13:32:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 11/18] nvme-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230417130302.86274-1-hare@suse.de>
 <20230417130302.86274-12-hare@suse.de>
 <msf6bjfbqiaj7s3ejxjwiueg7omvctsjftnux3qfvwadeg2jiq@hawgvoslzjo2>
 <c6ff524b-df91-f0ef-259e-ada0e1623cd5@suse.de>
 <f3c2fd60-b09c-6dd4-86f1-1c1e5b371ff4@grimberg.me>
 <aaa05f01-5047-03ed-2356-2f9544ee4b22@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <aaa05f01-5047-03ed-2356-2f9544ee4b22@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_033216_720252_1DE34CC4 
X-CRM114-Status: GOOD (  22.99  )
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



On 4/18/23 13:28, Hannes Reinecke wrote:
> On 4/18/23 12:12, Sagi Grimberg wrote:
>>
>>>>   --- a/drivers/nvme/host/fabrics.c
>>>>> +++ b/drivers/nvme/host/fabrics.c
>>>>> @@ -609,6 +609,7 @@ static const match_table_t opt_tokens = {
>>>>>       { NVMF_OPT_DISCOVERY,        "discovery"        },
>>>>>       { NVMF_OPT_DHCHAP_SECRET,    "dhchap_secret=%s"    },
>>>>>       { NVMF_OPT_DHCHAP_CTRL_SECRET,    "dhchap_ctrl_secret=%s"    },
>>>>> +    { NVMF_OPT_TLS,            "tls"            },
>>>>>       { NVMF_OPT_ERR,            NULL            }
>>>>>   };
>>>>
>>>> Coming back to your previous discussion about this. 'tls' is always 
>>>> announced
>>>> but not always supported. This renders the unsupported option 
>>>> filtering added to
>>>> libnvme useles:
>>>>
>>>>    https://github.com/linux-nvme/libnvme/issues/612
>>>>
>>>> Let's assume we go ahead with this patch. The user set explicit the 
>>>> tls option
>>>> via 'nvme connect ... --tls' and the kernel will return EINVAL, but 
>>>> userland
>>>> can't really know what it was and drop --tls and retry again (or 
>>>> print some
>>>> useful information). It could be any other parameter provided by the 
>>>> user.
>>>>
>>>> How is userland supposed to do any feature detection?
>>>>
>>> And that is a good question.
>>> I've just removed most of the #ifdef annotations on request from Sagi.
>>> If we were going with your suggestion I would need to bring them back.
>>>
>>> So, Sagi: What should we do?
>>> Re-clutter and allow nvme-cli to figure out if TLS is supported?
>>> And have it always enabled and invent other means for nvme-cli?
>>
>> I don't understand the issue.
>>
>> userspace already has a way to know if a feature is supported by reading
>> the misc device.
>>
> Yes. But the output there is generated by evaluating the fields from the 
> fabrics 'opts' structure.
> 
> So if the 'tls' option is present it assumes that TLS is supported.
> With my current patchset the _option_ is always present, but the 
> evaluation of the option once set by nvme-cli might return -EINVAL if 
> it's not compiled in.
> 
> The request from Daniel is to have the compile option for the fabrics 
> 'tls' option, too, such that it doesn't show up with the misc device.
> IE revert the changes which you requested to convert all the
> '#ifdef CONFIG_NVME_TCP_TLS' conditionals.

Thanks for explaining.

Then we can add the ifdef on the opts statement alone, with a comment.

