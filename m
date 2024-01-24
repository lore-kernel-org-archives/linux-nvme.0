Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFC1C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 13:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YrPINwPDPAEG/sSO6T5gcbubdHZY4aS5w1+Nwv+qokE=; b=077Rezs7WdUH6ltEytOSA0MnbS
	0r94xC+XelvCu6yZBmQmj4EmnvDFDoB1yqCyAc9mNYnJ9qqHGQ+jKwXn4wM0HSfm66r2F9Ua0HZ9O
	oM3PdrwwgXJ3Z9mMNVJ9hJC2uwyyTm+4Fu38e6GmEFYX/NAEa9K0jC9CfldPoi5RqtOu5/PUjFCks
	gZ71ek0tDCqX42YdPb2gL8yp6RPPkRJIibBI5MQ8D75Cgd9JKD9zfRizKWZLNR9gkAht/qo1UZ4x2
	LAIS5Wj08eh9akLgHfHel98EdXC8IjAe/B9+7IAoRpyoFEg89f6iT3K6KulYsWF4fISctQIaMqgJf
	s4rquo/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSd1e-003PxK-0M;
	Wed, 24 Jan 2024 13:10:42 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSd1b-003Pwl-0G
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 13:10:40 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e412c1c58so15213145e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 24 Jan 2024 05:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706101837; x=1706706637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YrPINwPDPAEG/sSO6T5gcbubdHZY4aS5w1+Nwv+qokE=;
        b=ffCWJ2ZmFP9S05Ax+yslMSxK1/GsEdG4fTusBehpOWnjjGU+dhsW4krgDXrg5/Gv0B
         E51LWk96B3gRvS0v6bsgeUIfhWZS5sOgC/ExYui2YjFgox8VCuQl+xt5GWzObbnLHjdu
         U5x10b+qiK31ZWowPGpXY9brx/I1rw1yjoxTKk95DUzKSDr86rm+Al/4BVDAZsieWRR5
         m7TA9B4qEDOAVXe8x+uqgWAhtlXmNObRTHTvEaG0yxIe2mdiVBW+y8dzsBV7tFLWV4Th
         0wx388RdDouA5kxTcVW5IWWXsC12d28T2WoOH0mKf0LNiAaOMvtVVsq3sbaLw4URmJkc
         NbUA==
X-Gm-Message-State: AOJu0YzmOitxMyOajC4PD2fd90ihcQmLaXbpogSYSJxrc7cS3osHFYWM
	ppUifBPtV2tTrOAnWD8OGE0Q/vvbzHCBB9PwJTJqK6W/9iIuGZy8OL4yUlVz
X-Google-Smtp-Source: AGHT+IGVjqUIkzXywWnLG+H84utbSdrlzUB60B7to17flArCjLhNJEsTQ/hY1cZWQBbT51vuNtI6tw==
X-Received: by 2002:a05:600c:5109:b0:40e:4cae:a407 with SMTP id o9-20020a05600c510900b0040e4caea407mr1583515wms.1.1706101836603;
        Wed, 24 Jan 2024 05:10:36 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c459300b0040e42391a12sm45397397wmo.13.2024.01.24.05.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 05:10:36 -0800 (PST)
Message-ID: <42fcd973-223a-4753-8b53-b4aa0b97f414@grimberg.me>
Date: Wed, 24 Jan 2024 15:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] nvme: sync the namespace scanning during ctrl start
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: oren@nvidia.com, israelr@nvidia.com, dwagner@suse.de, oevron@nvidia.com
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
 <20240122145659.5574-6-mgurtovoy@nvidia.com>
 <d964c7a4-9754-4f31-977e-68d5c08c6e6f@grimberg.me>
 <60f3e0d6-1fce-4f88-84f1-154a5cde4f7f@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <60f3e0d6-1fce-4f88-84f1-154a5cde4f7f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_051039_138651_1DD83DE3 
X-CRM114-Status: UNSURE (   6.80  )
X-CRM114-Notice: Please train this message.
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


>>> @@ -4537,9 +4536,10 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>>>           nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
>>>       if (ctrl->queue_count > 1) {
>>> -        nvme_queue_scan(ctrl);
>>> +        nvme_queue_scan_sync(ctrl);
>>>           nvme_unquiesce_io_queues(ctrl);
>>>           nvme_mpath_update(ctrl);
>>> +        nvme_kick_requeue_lists(ctrl);
>>>       }
>>
>> I really don't think its a good idea to block ctrl start
>> like that.
> 
> like how ? scan_sync ?

Yes

