Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C982C47074
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 08:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p+mg1IAp0mzlFZdK2KBDJssPaJEOCDthcu8q7czETD8=; b=s2wghzNLuR7+HxxsByktCLZI9U
	nP9OWg0Bl/mkHh8lU34Bn5tSfJNgKh6XChbLbpuJ4IlK+AhjFN61YdW7Aq6t6/9g3gNoU6jSST3c7
	VTJnMJzXw5wZSPlgSWVaJ6oR9JuJqkBFWQkUtNdJVaVmjCsia2N1VP94lpb1Fja7034d6l1IBvngW
	qvtt1e3n0GznjsWSgeZ2+1fNmr9O59UwfkkhJU/IMTCJ28HI0SC4yzF3R7phukPHyDAO8L5X6wmbH
	k8mV776kI78uUTJpu+njGOBizOn2sMl++bmrcSJQQr1bf9SXpD39vdBdfYSwseonAG0FGIEEeEQsz
	69UO+YcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJ4H-00DCmT-2V;
	Thu, 04 Jan 2024 08:27:09 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJ4D-00DCkM-39
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 08:27:08 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d5a733823so623145e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 04 Jan 2024 00:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704356823; x=1704961623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+mg1IAp0mzlFZdK2KBDJssPaJEOCDthcu8q7czETD8=;
        b=TL9/VyTJyBPWrhPCgKJ/ansaMvhIV6jIA6/dHkpwlvqOiMOV+Q90KabcU+YHUPkV+Z
         HXCYhQwxIvkbiWkPxtMVjM1Fc71z9ZoYIW5Or5xAWyQPvOFKebjXOXE9MqUQh0vVfmRA
         JjL27al73xvKYCXViRPk5BNcb8ZyAR+uMqEmX1NLvtbtFzC5QQAQR+7HPYDAVFRrGIQw
         Iy8J/X8AdFNl7ZlgILX5p8brEjKCkMhZkHDiTLGvs+SQllT66CVl6/hSZPj3OOyecakJ
         atz5/gSRFmTB2KthJStCyyr0BNWKoizfiEmr5PbO3pcwFPZ3xFLNudp2GeO+0G9GOdFv
         wkEg==
X-Gm-Message-State: AOJu0Ywu+TP3h7tTayxTDTql4iTq6bLvtMZvmQ5fceYQhr775WIZvvLf
	8kd/0aDe6JyhZLpCj9W0W8g=
X-Google-Smtp-Source: AGHT+IFDe9z/CXmguIdgfIHAqIwtrUfw7xsPGPpRGAw+ZrE8TtccM3KoDWUJIvBjS5Ei4SaVsC2cBQ==
X-Received: by 2002:a05:600c:3b1e:b0:40d:123a:50eb with SMTP id m30-20020a05600c3b1e00b0040d123a50ebmr294913wms.3.1704356822976;
        Thu, 04 Jan 2024 00:27:02 -0800 (PST)
Received: from [10.100.102.67] (46-116-232-10.bb.netvision.net.il. [46.116.232.10])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c450e00b0040d6d755c90sm4868854wmo.42.2024.01.04.00.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 00:27:02 -0800 (PST)
Message-ID: <18e0d08d-1391-4cde-811e-70273a82db76@grimberg.me>
Date: Thu, 4 Jan 2024 10:27:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] nvmet-rdma: set max_queue_size for RDMA transport
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-11-mgurtovoy@nvidia.com>
 <1493ff9c-f9f5-4c54-96c5-92eddeb85516@grimberg.me>
 <08b1645f-b4bf-4e76-8d7d-867e88f9a240@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <08b1645f-b4bf-4e76-8d7d-867e88f9a240@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_002706_013392_DA999638 
X-CRM114-Status: GOOD (  18.36  )
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



On 1/4/24 00:42, Max Gurtovoy wrote:
>
>
> On 01/01/2024 11:39, Sagi Grimberg wrote:
>>
>>> A new port configuration was added to set max_queue_size. Clamp user
>>> configuration to RDMA transport limits.
>>>
>>> Increase the maximal queue size of RDMA controllers from 128 to 256
>>> (the default size stays 128 same as before).
>>>
>>> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>> ---
>>>   drivers/nvme/target/rdma.c | 8 ++++++++
>>>   include/linux/nvme-rdma.h  | 3 ++-
>>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>>> index f298295c0b0f..3a3686efe008 100644
>>> --- a/drivers/nvme/target/rdma.c
>>> +++ b/drivers/nvme/target/rdma.c
>>> @@ -1943,6 +1943,14 @@ static int nvmet_rdma_add_port(struct 
>>> nvmet_port *nport)
>>>           nport->inline_data_size = NVMET_RDMA_MAX_INLINE_DATA_SIZE;
>>>       }
>>> +    if (nport->max_queue_size < 0) {
>>> +        nport->max_queue_size = NVME_RDMA_DEFAULT_QUEUE_SIZE;
>>> +    } else if (nport->max_queue_size > NVME_RDMA_MAX_QUEUE_SIZE) {
>>> +        pr_warn("max_queue_size %u is too large, reducing to %u\n",
>>> +            nport->max_queue_size, NVME_RDMA_MAX_QUEUE_SIZE);
>>> +        nport->max_queue_size = NVME_RDMA_MAX_QUEUE_SIZE;
>>> +    }
>>> +
>>
>> Not sure its a good idea to tie the host and nvmet default values
>> together.
>
> It is already tied for RDMA. I don't see a reason to change it.
> I will keep the other default values for fabrics separate, as it is 
> today, following your review in other commits.
> We can discuss it in a dedicated series since it is not related to the 
> feature we would like to introduce here.

OK, the discussion is too long anyways. I don't care all that much tbh.

