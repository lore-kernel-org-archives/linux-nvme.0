Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E74C54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 12:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UUpJVHQK75CMj1cYZbu27LSzgSyvc+MWdDmduW7vZJs=; b=BUaJujbTBJcXsKbVF1TiQtwnsO
	pH1+7Af+wwrgGXzUmqhAHLUwAIe+dhP0sUbaOzBEdkE6WSclG5yJ1BBNdmG+YxRXA4adGzw9LhBPr
	vK3uXPaBJr8MDTrfIrmlZwydHKBMC7G6XEkG882YtPprGeZZAZRHm0P5ZL7P+mSNkKIg4Sin4dPk/
	nOCze+YdjIUrl7OIAfh5gruVthUhXu9HXeSiRtLWOxFrVjcRm5tAo5FVWn1Hphw6o1ZA5t2OXT9d0
	suhF84Sbkefi0SxYjobjDd9xqGk34A6QKp+IH2J3zmAcygfzR8Atwn0Ei9ZE2pQ2JU7EZFAgkwKYP
	Wp3ceJkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCYQ-00000004V27-2mKW;
	Thu, 07 Mar 2024 12:08:54 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCYN-00000004V0m-3rAN
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 12:08:53 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412b30be60dso637605e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 04:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709813329; x=1710418129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUpJVHQK75CMj1cYZbu27LSzgSyvc+MWdDmduW7vZJs=;
        b=Onu/LoiBU2Aoh5S+AN+UVnz/EDi/6yj2X5VUSFpLNNDh/EEsr3SuP5/7aIWaUynhU6
         kU10zYUwJVHf04CAHCRFH7GI6mZZuHQ/fD/48BVADL50KhcVuBgxiiy6enJAE5kbaxTw
         XjnYfQPxB7ByF/Q7IjrmS0PSMKK1pgkEG9EzgfUGak4MiO4Z4PO8YG5j65WYerNsjOR2
         9it/BEEL0jxc5lnIDoE+/FmWGr0IN1CA6ed1ny28UclECivS4NQ9Q9dDeKtTNk+wFGVJ
         aD3e01crH1jE5HF5u/Hn2wS9VkcDmiKwpgnLPPZlGhm4TRY6VTUa9TxyBH6XkonPmeNB
         0RBA==
X-Forwarded-Encrypted: i=1; AJvYcCVoWSW2mOb0azMsCZL1/hMnJKHuu60BqsFB61XsAKtFSDwehifPlMfDpQ27SqnOXfhxjAAMVthnrsXZ+apu5qSK8fIQ3Gx9dOimkonfQVU=
X-Gm-Message-State: AOJu0YzQW+z9wVteYF7VxTv9zDcnBOsyz0yWR0+Nq+jQrwKGF1yx7LPP
	dyU4kUlq5bXRwI08kjMSzj0Tu3/F94jGhz/9Hy90sE5nnbAjPs96lyG0ZOZi
X-Google-Smtp-Source: AGHT+IFLvT8ebAk023f/U4DZy1bMEgucnPCFzUn3VxRNRcBo+fRbgWLpNeFeb0XJ6Jy6HDbwUrUJrA==
X-Received: by 2002:a05:600c:1d2a:b0:412:f887:644f with SMTP id l42-20020a05600c1d2a00b00412f887644fmr1279705wms.0.1709813328809;
        Thu, 07 Mar 2024 04:08:48 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id w14-20020a05600c474e00b004131310a29fsm797106wmo.15.2024.03.07.04.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 04:08:48 -0800 (PST)
Message-ID: <6273f295-9857-495e-bcde-b76627da8d35@grimberg.me>
Date: Thu, 7 Mar 2024 14:08:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] nvme-keyring: restrict match length for version '1'
 identifiers
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@suse.de>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240127093058.15699-1-hare@kernel.org>
 <20240127093058.15699-7-hare@kernel.org>
 <f43dc8c9-3377-40c2-a384-906fe893c80c@grimberg.me>
 <9a5c9df9-162f-4941-82e7-a82979e338ef@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <9a5c9df9-162f-4941-82e7-a82979e338ef@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_040851_981523_CC9DEECD 
X-CRM114-Status: GOOD (  15.49  )
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



On 07/03/2024 13:35, Hannes Reinecke wrote:
> On 3/7/24 11:49, Sagi Grimberg wrote:
>>
>>
>> On 27/01/2024 11:30, hare@kernel.org wrote:
>>> From: Hannes Reinecke <hare@suse.de>
>>>
>>> TP8018 changed the TLS PSK identifiers to append a PSK hash value,
>>> so to lookup any version '1' identifiers we need to restrict the
>>> match length to exclude the PSK hash value (which we don't have
>>> when looking up keys).
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/common/keyring.c | 21 +++++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>
>>> diff --git a/drivers/nvme/common/keyring.c 
>>> b/drivers/nvme/common/keyring.c
>>> index c16f9496643f..51b99b34e100 100644
>>> --- a/drivers/nvme/common/keyring.c
>>> +++ b/drivers/nvme/common/keyring.c
>>> @@ -44,6 +44,27 @@ static bool nvme_tls_psk_match(const struct key 
>>> *key,
>>>           return false;
>>>       }
>>>       match_id = match_data->raw_data;
>>> +    if (memcmp(match_id, "NVMe1", 5)) {
>>> +        char *e = (char *)match_id;
>>> +        size_t offset = 0;
>>> +        int n = 0;
>>> +
>>> +        while (*e != ' ' && offset < match_len) {
>>> +            if (*e == ' ') {
>>> +                n++;
>>> +                if (n == 3)
>>> +                    break;
>>> +            }
>>> +            e++;
>>> +            offset++;
>>> +        }
>>> +        if (n != 3) {
>>> +            pr_debug("%s: error parsing '%s'\n",
>>> +                 __func__, match_id);
>>> +            return false;
>>> +        }
>>> +        match_len = offset;
>>> +    }
>>
>> My eyes hurt... I am failing to understand what this even does...
>>
>> You have a concrete example?
>
> Yeah, it's ugly. What I'm trying to do here is to lookup TLS PSK 
> identities which are either in the original format:
>
> NVMe0[RG]0[12] <hostnqn> <subsysnqn>
>
> _or_ the TP8018 TLS PSK format:
>
> NVMe1[RG]0[12] <hostnqn> <subsysnqn> <digest>
>
> given that I only have <hostnqn> and <subsysnqn> as lookup keys.
> So for the memcmp() I'll have to exclude the ' <digest>' bit, which
> happens to the after the third blank space in the identity.
> I'll have a slightly better version queued, but parsing remains ugly.

Shouldn't strtok/strsep simplify what you are trying to do here?

