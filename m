Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CFCEB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 09:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0+36Q9eI84qtxcdlzUKjOqUi1lcIRIGvrPgXpAYg71w=; b=kvKNVfAnI7RBcHlyTqSxhSBt14
	zcs6o61UaqrVThnR/wBxQeae38acB7LzirFGC3qVT/rIM0U9ws95rLKM+2/cQaPwerYs/ksSWslaJ
	IsouPnWbjUZtaaxT+Uaz0hp9iBtuFsTTFhAf6Kp0MDZREBVe+13097+0y7Mfx6rE3hZuvYbHK2Jrp
	wkZ5clIjO6hGSm7DPT7/T4Hols+vgzxSy8Ak4NXM+U2ZZDskH0d0Q+XoMm3gTpW+SUKg6g5Iz8spm
	e+oVjVeU3ZzdpqCsiA2AgF+RIAeNN124BAy5zrAEFqxOYTNgThr4xHBE8VBNbRdOy6Avk5shZ99iG
	XP7DacVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWZ2i-005tlX-1r;
	Thu, 17 Aug 2023 09:11:48 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWZ2f-005tl0-2M
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 09:11:47 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fe5c552dd0so15875865e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 17 Aug 2023 02:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692263502; x=1692868302;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+36Q9eI84qtxcdlzUKjOqUi1lcIRIGvrPgXpAYg71w=;
        b=CIQTupKQjRMimgN2xUOghziQc6BSmbyLhlNN0yrQ2G+RE4eLszmvegUn8yRFVfeDlW
         c4Tpe816v68W0p6QekdERMHjAk+xqqNMuRWmSkXzmEac2KoVaEDvlUGJvR6RoKYCT7fG
         AD5ZgA0eYd3V8FQ4qKnSgn7oyg5DCmu16pR54xQfWEblT4z0mudARMYAX+hT+STbg/iK
         DcQlY34ATS+shnc2fK3rUoVQIoRsROGaf+3/Xu5VFubGy12kagzbpY4BQH+49e5dZuRb
         tpXHFCSgn0mtctE1m4U5Gkou7znFm+EowjBrTTusxseZSWxo1138BDFOLXZRcZ29tUTV
         ongg==
X-Gm-Message-State: AOJu0YwYFOWRj9ksabGlgIsQmNeux2RRcnKmK1itXzNhv1anSYylrzT6
	+y+XOE4ENOf+cdxp73Lpe5s=
X-Google-Smtp-Source: AGHT+IGxZ1N2C64sNHklSa/Rh0UTzWVnfwn241r4oYciJYVyxu9MQERKEM8CzizjXNhHluRAYjxmPw==
X-Received: by 2002:a05:600c:4710:b0:3fb:aadc:41dc with SMTP id v16-20020a05600c471000b003fbaadc41dcmr3956462wmo.4.1692263501727;
        Thu, 17 Aug 2023 02:11:41 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c214a00b003fe263dab33sm2223240wml.9.2023.08.17.02.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 02:11:41 -0700 (PDT)
Message-ID: <8e72f698-af99-c8a4-a672-d51d28ee7a36@grimberg.me>
Date: Thu, 17 Aug 2023 12:11:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH rfc 6/6] nvme-fabrics: expose support for traddr as dns
 names to userspace
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <20230724092023.708335-7-sagi@grimberg.me>
 <7d60e267-be0a-41ff-8015-d3440b6eca2c@suse.de>
 <433182d8-c57e-2e51-2692-02ac8b474bf2@grimberg.me>
In-Reply-To: <433182d8-c57e-2e51-2692-02ac8b474bf2@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_021145_812235_D00A0BF3 
X-CRM114-Status: GOOD (  30.56  )
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



On 8/13/23 16:07, Sagi Grimberg wrote:
> 
>>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>>> index fadd25538d1b..6a7e8cbdaf69 100644
>>> --- a/drivers/nvme/host/fabrics.c
>>> +++ b/drivers/nvme/host/fabrics.c
>>> @@ -1331,6 +1331,7 @@ static void __nvmf_concat_opt_tokens(struct 
>>> seq_file *seq_file)
>>>           seq_puts(seq_file, ",");
>>>           seq_puts(seq_file, tok->pattern);
>>>       }
>>> +    seq_puts(seq_file, ",dns_ip_traddr");
>>>       seq_puts(seq_file, "\n");
>>>   }
>>
>> Don't we need to update the parser to accept this option, too?
>> After all, the implication is that all tokens in the output can be 
>> used as valid tokens for the connect string ...
> 
> I struggled with this bit here...
> 
> Today, we simply expose all valid tokens, but in this case
> what we really need is a capability indicator (in this case
> traddr can be a fqdn and not only an ip address).
> 
> So we could make this a parsed token, and make userspace
> actually pass it in case traddr was passed as a fqdn, but
> it is absolutely redundant to do so.
> 
> We could come up with a format that explicitly says this
> is a capability instead of a valid token.
> Like: "cap=dns_ip_traddr" or "format=traddr_as_dns_name" or
> something...
> 
> What we just need, is for userspace to know if it is possible
> to pass traddr in a specific format.
> 
> I tend to think that this is something that we will want for
> other options that can have multiple formats.
> 
> Another option would be to make this a separate token and
> call it ctrl_dns_name that would be separate from traddr, but:
> - that will cause the changes a spray of changes that would accept
>    an alternative to traddr, and validate that at least one exist, but
>    fail if both are given
> - bubble up the usage to userspace, leaving the admin with the
>    exact format of the traddr
> - keep track of this when doing reconnects and stuff.
> 
> So I figured that the current approach would be preferable if
> we accept how to expose that for a given kernel/driver, we can
> accept dns names, or we cannot.
> 
> What do others think? Christoph? Keith? Chaitanya?

Anyone has feedback here?

Seems that we want this, but the question is how to expose
a new format of traddr (now can be a dns name) to userspace?

