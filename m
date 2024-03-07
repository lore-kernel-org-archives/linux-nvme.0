Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC5FC54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 08:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ud7CuoW6+QsWOOtRaJYd/+AdHfLj70+eGfxI3TXyUdY=; b=yPxKl1Aq2+GxrIxtQjkFE22Y6f
	VL/4gSQUIJaDMR0oB5WAGet1MZwU41Y3HYh6JscMUJEnaU2FrQTNImKae04Nyy292miCEYePzhB28
	EJsGLcdYpx3JwYUcn2w25UnW1VaWnEmPCIpGgZW5yu14n4g3SCPSE/xxkkjjbExA5Lsqbgj3HJ9D1
	SrUhFQPu+AIaPGGUXpR/GXL4aosudi+hXZLhvL45cP4+aXJirVDvTIGCRPFWWLY1WK4m19Ws/SQlX
	/Rud2pFpswt8Ah3KA1Ws4G68c1B+qMr77CUJ94jcK0+HBqNKR9oiN/7A5dEhvLVHR5iCYAqSYqCCH
	A6F4Wveg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri9Ti-00000003iOj-1ycn;
	Thu, 07 Mar 2024 08:51:50 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri9Tf-00000003iOG-0wGh
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 08:51:48 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412bcca7c56so184785e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 00:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709801505; x=1710406305;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ud7CuoW6+QsWOOtRaJYd/+AdHfLj70+eGfxI3TXyUdY=;
        b=TajU3TSeUAn6o+MQNTWjgmf5XMABhivjZQbNtqLNSLLN9vrBw2Lk1qJWqrUN7Oxp9z
         grIIsvwfrfAuULPMbsBJWvYsKtNqJY3ULBkIqFGeUcqds9P8aVDpbElTNvKMszVC8EoG
         iSW6Zy3jK8fQPprIW9vJUEJe8moPJQUmaTOTf429AOkAm2JQFz18yeI2eAcMWCa+XLW5
         HKv4Ne/EGZfku1++XJM2OYJKriX5Si7gbQ3FUWq2DyOBTykLUM9Uo5L9nT8jSwstpEVR
         y3+GpGfSNO9iPoFDv5qos3Z16dOEVjatylGiC9L3m8DiDiT944BaGprMvsHmNU0h9bbF
         EH6A==
X-Forwarded-Encrypted: i=1; AJvYcCXj90KLluP20q3FRKIZln2ceA2tg/3brR7TeSxvxngFXKBrkVPK2QaYWcWK8MBbJd9WNXBWHPpbBBHbHRx1wf+bUvh4O+X+qxvclSX4mHg=
X-Gm-Message-State: AOJu0Ywmzs3muNkQle5pq6eyNAEPdwvP2xy24UFAcJRxZE1/RL/FF+p4
	Hh+c65e6VAle2b/yPnmK8/+RSc42rpMtFNLH43FTjOxQT/sJQO2JwazgXn+h
X-Google-Smtp-Source: AGHT+IF/UkfdAyYdORNPUsJcOqrI8bYE+l/NRfh9EFWToYYnkEhd0JLTlYmw0QEQnOfqai0ZAogm5w==
X-Received: by 2002:a05:600c:1c1b:b0:412:b2af:2632 with SMTP id j27-20020a05600c1c1b00b00412b2af2632mr972540wms.0.1709801505098;
        Thu, 07 Mar 2024 00:51:45 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id bj25-20020a0560001e1900b0033e49aebafasm6731969wrb.3.2024.03.07.00.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:51:44 -0800 (PST)
Message-ID: <868727ce-5970-4296-9fc7-a431dccc8a63@grimberg.me>
Date: Thu, 7 Mar 2024 10:51:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvme: authentication error are always non-retryable
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240301112823.132570-1-hare@kernel.org>
 <20240301112823.132570-2-hare@kernel.org> <20240301131208.GA3586@lst.de>
 <f511975a-822e-470a-a3a2-d7ed652e3cfc@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f511975a-822e-470a-a3a2-d7ed652e3cfc@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_005147_365146_017BF8E3 
X-CRM114-Status: GOOD (  17.27  )
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



On 01/03/2024 17:26, Hannes Reinecke wrote:
> On 3/1/24 14:12, Christoph Hellwig wrote:
>>> -    if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
>>> -        return AUTHENTICATE;
>>> -
>>>       if (blk_noretry_request(req) ||
>>>           (nvme_req(req)->status & NVME_SC_DNR) ||
>>>           nvme_req(req)->retries >= nvme_max_retries)
>>>           return COMPLETE;
>>>   +    if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
>>> +        return AUTHENTICATE;
>>
>> This part looks fine (although I'd word the commit message
>> differently for it).
>>
>>> @@ -467,7 +467,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl 
>>> *ctrl)
>>>           if (result & NVME_CONNECT_AUTHREQ_ASCR) {
>>>               dev_warn(ctrl->device,
>>>                    "qid 0: secure concatenation is not supported\n");
>>> -            ret = NVME_SC_AUTH_REQUIRED;
>>> +            ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>>>               goto out_free_data;
>>>           }
>>>           /* Authentication required */
>>> @@ -475,14 +475,16 @@ int nvmf_connect_admin_queue(struct nvme_ctrl 
>>> *ctrl)
>>>           if (ret) {
>>>               dev_warn(ctrl->device,
>>>                    "qid 0: authentication setup failed\n");
>>> -            ret = NVME_SC_AUTH_REQUIRED;
>>> +            ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>>
>>
>> .. but the others should never use nvme status codes as they never
>> go out onto the wire.
>>
> Would love to, but to my knowledge we have the convention that NVMe 
> status codes less than 0 should _not_ be retried.

What nvme status code is less than zero?

> NVMe transport errors,
> OTOH, _should_ be retried.
Yes.
> 'connect_admin_queue' and 'connect_io_queue' now straddles the 
> boundary: technically it's an NVMe command, but in
> practice it's a transport command as there are quite a lot of steps
> before we even can send the 'connect' command.
>
> So, how do we handle the return codes from 'connect_admin_queue' ?
> The NVMe core style (with not retrying negative errors) or the NVMe
> transport style (with always retrying until we run out of retries)?

Not exactly sure what is the question here. I am still going over emails 
so there
may be some discussion around this, but it is unclear from the patch 
description
what is the issue this is solving.

