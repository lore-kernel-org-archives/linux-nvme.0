Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68DEC4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 10:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=817MwcjveCATsrSAXqSTNPvbG0R18dBt0V5rEKLaaiM=; b=kXkYD+EkVhFm+6QFpJjZMnqnRm
	SJ9SzzimdIAJ89C5d6z0lp+4OeDH012JqSfHO1XyYlYl98bXyA3yeutfVG7r4nzHQ0Sfspk/prpfB
	memwhgn5NDb5K0MQ6JhHOQ0+uk9bjyYuazX/NjSEPCGnyS/HjZAX6rCopxzSbYypiHlMNeBi8tm0Z
	Emf/jZsr1ab9pr+r6z473OTOPAjTYknr0ArGd6adNBDRJXB9wGP521JkcVAWJbLeXA8TWWPj3qmIW
	Y6EIixKtWjU0021jrS+Gkzm7JZN6T7OwlrL2GJGjy/jfFuKR1xM1rhwcVm092UEp+qElbD42moYIF
	ncBurHgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rASFQ-006ui8-1F;
	Tue, 05 Dec 2023 10:01:48 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rASFN-006uhD-0V
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 10:01:46 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40b2e763b83so5463765e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 05 Dec 2023 02:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701770503; x=1702375303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=817MwcjveCATsrSAXqSTNPvbG0R18dBt0V5rEKLaaiM=;
        b=sS8g7qk0uxAqhS3cakgvlEQHk/3FS5VTAAXwVjCgOQlh+K+TMR8r36qiFoGmo8TeYw
         d0SHSJLmoTP9nMVlvCZN5YWRY7NJpbLHFXpRsDAo9i2ctQFD984uPZKaSyH7D4B4ajq9
         WOh2AI5hAZZ9ivfnbAvY9HO0FTjVgBPtJ+s5n13J+AVoDTAm1idhIuxMC1qXAY5HPpN8
         CJ3I5GUHggiYWeuNTws4OrSg9qO+bOJ0aI7PoCyFmODGrHVET/7/FfAqdXGYQ/vOfpVN
         l1EDjyiIc7x9ki0cKsBzgp+ECqc6rY6hD8CKbNL/ND0Z9XbqMxaxzlOjnCllprHEubDz
         5mxg==
X-Gm-Message-State: AOJu0YyGdi3TqnWLZvvzkR9pwRmlxMkutyUW0dbqiSuj6bRerw3xvBGc
	BlKTLn4uLYE/4VS+YAGQkcLl6b0ezP0=
X-Google-Smtp-Source: AGHT+IGs91/zA37XJQCIFEXiiEVURQtyOGm4j/yMiWKYgjeyeFgff032I9O2QYM29PyxrgzpOiHMLw==
X-Received: by 2002:a05:600c:5024:b0:40a:771f:6a56 with SMTP id n36-20020a05600c502400b0040a771f6a56mr23957192wmr.4.1701770503083;
        Tue, 05 Dec 2023 02:01:43 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k13-20020adfe8cd000000b003333c2c313bsm8339592wrn.100.2023.12.05.02.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 02:01:42 -0800 (PST)
Message-ID: <40bedf74-e09e-43a4-bd05-e529f8fdd84d@grimberg.me>
Date: Tue, 5 Dec 2023 12:01:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 1/1] nvme: allow passthru cmd error logging
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "alan.adamson@oracle.com" <alan.adamson@oracle.com>
References: <20230831231827.3896883-1-alan.adamson@oracle.com>
 <20230831231827.3896883-2-alan.adamson@oracle.com>
 <20230905065348.GB19754@lst.de>
 <9d199a50-9f0b-a69d-4061-d443e6286dba@oracle.com>
 <bb57e86e-654b-a4b1-e60a-7573e59c30ed@grimberg.me>
 <8ffd46aa-81f8-4b82-9bfa-1753bb7610c9@oracle.com>
 <a2ce93a3-0427-4a37-8c1d-b70eb34a23ad@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <a2ce93a3-0427-4a37-8c1d-b70eb34a23ad@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_020145_189718_9ECC11DB 
X-CRM114-Status: GOOD (  13.50  )
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


> Sagi/Christoph,
> 
> On 9/19/23 09:02, alan.adamson@oracle.com wrote:
>>
>> On 9/12/23 4:39 AM, Sagi Grimberg wrote:
>>>
>>>>>>        if (req->q->queuedata)
>>>>>>            req->timeout = NVME_IO_TIMEOUT;
>>>>>> -    else /* no queuedata implies admin queue */
>>>>>> +    else { /* no queuedata implies admin queue */
>>>>>>            req->timeout = NVME_ADMIN_TIMEOUT;
>>>>>> +        if (!nr->ctrl->passthru_err_log_enabled)
>>>>>> +            req->rq_flags |= RQF_QUIET;
>>>>>> +    }
>>>>>>        /* passthru commands should let the driver set the SGL flags */
>>>>>>        cmd->common.flags &= ~NVME_CMD_SGL_ALL;
>>>>>> @@ -687,8 +720,7 @@ void nvme_init_request(struct request *req,
>>>>>> struct nvme_command *cmd)
>>>>>>        if (req->mq_hctx->type == HCTX_TYPE_POLL)
>>>>>>            req->cmd_flags |= REQ_POLLED;
>>>>>>        nvme_clear_nvme_request(req);
>>>>>> -    req->rq_flags |= RQF_QUIET;
>>>>> Isn't thisw now dropping the RQF_QUIET flag I/O commands that we
>>>>> previously set?  While we're at it, why do we only allow passthrough
>>>>> error logging for admin commands anyway?
>>>>
>>>> While working through this, we decided that for IO commands
>>>> (passthrough or not) error logging would always be enabled. For
>>>> passthrough admin commands, error logging could be enabled or disabled.
>>>
>>> Why shouldn't it apply to both?
>>
>> Currently, we have /sys/class/nvme/nvme0/passthru_err_log_enabled that
>> enables/disables logging for admin command only.  Are you saying it
>> should also enable/disable for IO commands across all namespaces or
>> should there also be:
>>
>> /sys/class/nvme/nvme0/nvme0n1/passthru_err_log_enabled
>>
>> /sys/class/nvme/nvme0/nvme0n2/passthru_err_log_enabled
>>
>> .
>>
>> .
>>
>> Alan
>>
>>
>>
> 
> Can we please have resolution on this patch so we can merge it ?

I'm in favor of the latter, IO commands enabled per ns, and admin
commands in the controller level.

