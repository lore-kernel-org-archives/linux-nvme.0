Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F272FC4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Apr 2024 11:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/s61TmuPvrOrn4NntVZ/W9eLZEV35tT0sA7C/tYbyG8=; b=2VUVgAof6OO/S04mur0Q7tyYoc
	NLo8jixPQ30fHdxXXUOkPrs0Ff/6h6+AcDTw9+ta9vfvvco1KempxtFxBApSW1l8tvLnsrMRlaYAm
	ofGVNy3Mpg3WXBseL1IVgnyKDvPRpiaCmv+sHXiIYDUBNWtpxZM9qGDbE4ezjSAqoHpNTwZbYJZMc
	kdO1mNen9YLYx/YoY9pzK8ctMDSLDGV8rTck3BV08yJtwhLm7k+iWmxyrGyvFafeDTSU7EYImvVDS
	IheC7BE1MApIt5io3fJPwtk++ue1MgDj5eTgVC04jkLqgA8r3rqjXQi8BNfphjnzEX92yG3N1qzEm
	Mp/SjdCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryVHG-0000000ANDi-2FEn;
	Sun, 21 Apr 2024 11:22:34 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryVHC-0000000ANDA-2wPZ
	for linux-nvme@lists.infradead.org;
	Sun, 21 Apr 2024 11:22:32 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-349a33a967eso127451f8f.2
        for <linux-nvme@lists.infradead.org>; Sun, 21 Apr 2024 04:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713698548; x=1714303348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/s61TmuPvrOrn4NntVZ/W9eLZEV35tT0sA7C/tYbyG8=;
        b=kfxXWcnUH2oY+HdeuqZvNwd8QhmRy/cZdHC1vFZ+Z8jzs3nF5N92McvJem4cJQ/mqa
         m89tums47SJRxbP784SYyeEjPYITmGBrwA6IiwHR7hlAOHGISHriberRVLbQhsWY0fZB
         OrX/hd9R/tHlReMDvEVKjH8crq/7nNTfAIKNn7bl/Yai2MaDk0sxYzq9aVE7KTRN5uHl
         WPyiz7+9UAeU+n/qukVQMQ6t2a1t2O3bVKs7Fv5847DvkM+2UTX9ajhqgqJtdeh8aHBL
         4sTSzeU6dqlAkK+Yr8l7/fhbGS7eq8RR7gxQvqaIlWuXPaPus3fxSieQmc31hdnW8Uji
         eZqA==
X-Forwarded-Encrypted: i=1; AJvYcCVCTind+F+XbNb8gouT9BNS2U03nIn9aGK3KYIThVz6a2lN1Bh1EbqY+NJkLE4alHZDvlJk2yGKIfNjmj6sJ5jE/1DfUklOdPDNZuFMHDE=
X-Gm-Message-State: AOJu0Yyt+4yddtvkkE6V2sxLM+psVbVzB0Ws47dZaVXtCmRcJs+fPt90
	BVNmu/wni2d1FL8vOAAh8LFE97zuBe8TlMGuRc+Y008EqRjkPSZK
X-Google-Smtp-Source: AGHT+IEVLyf5eh7U6Sr7FFhA1gebkovK9VbZyPOMsVDkDsPUpTM8lArM6fMouI+6phIEioqu3nqTAA==
X-Received: by 2002:a05:600c:4496:b0:419:db8f:dfa0 with SMTP id e22-20020a05600c449600b00419db8fdfa0mr3068536wmo.0.1713698548356;
        Sun, 21 Apr 2024 04:22:28 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id n2-20020adfe342000000b00343eac2acc4sm9058514wrj.111.2024.04.21.04.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 04:22:28 -0700 (PDT)
Message-ID: <0b2a2e0a-8003-4217-bdc5-af4d91ed9af2@grimberg.me>
Date: Sun, 21 Apr 2024 14:22:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] nvme-tcp: reset after recovery for secure
 concatenation
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-14-hare@kernel.org>
 <ddee2fd2-584c-42be-af5f-7e002b2d5441@grimberg.me>
 <d055615b-2c41-45cd-8b15-c787eac0dc49@suse.de>
 <4438fdf3-2970-456b-acc6-fe26c355bfac@grimberg.me>
 <44ae1549-9d39-42d5-a6eb-a6700d4ab873@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <44ae1549-9d39-42d5-a6eb-a6700d4ab873@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240421_042230_760385_65815354 
X-CRM114-Status: GOOD (  16.58  )
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



On 09/04/2024 1:10, Hannes Reinecke wrote:
> On 4/8/24 23:23, Sagi Grimberg wrote:
>>
>>
>> On 08/04/2024 9:25, Hannes Reinecke wrote:
>>> On 4/7/24 23:49, Sagi Grimberg wrote:
>>>>
>>>>
>>>> On 18/03/2024 17:03, Hannes Reinecke wrote:
>>>>> From: Hannes Reinecke <hare@suse.de>
>>>>>
>>>>> With TP8018 a new key will be generated from the DH-HMAC-CHAP
>>>>> protocol after reset or recovery, but we need to start over
>>>>> to establish a new TLS connection with the new keys.
>>>>>
>>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>>> ---
>>>>>   drivers/nvme/host/tcp.c | 20 ++++++++++++++++++++
>>>>>   1 file changed, 20 insertions(+)
>>>>>
>>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>>> index 94152ded123a..3811ee9cd040 100644
>>>>> --- a/drivers/nvme/host/tcp.c
>>>>> +++ b/drivers/nvme/host/tcp.c
>>>>> @@ -2219,6 +2219,22 @@ static void 
>>>>> nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
>>>>>       }
>>>>>   }
>>>>> +static bool nvme_tcp_reset_for_secure_concat(struct nvme_ctrl *ctrl)
>>>>> +{
>>>>> +    if (!ctrl->opts->concat)
>>>>> +        return false;
>>>>> +    /*
>>>>> +     * If a key has been generated and TLS has not been enabled
>>>>> +     * reset the queue to start TLS handshake.
>>>>> +     */
>>>>> +    if (ctrl->opts->tls_key && !ctrl->tls_key) {
>>>>> +        dev_info(ctrl->device, "Reset to enable TLS with 
>>>>> generated PSK\n");
>>>>> +        nvme_reset_ctrl(ctrl);
>>>>> +        return true;
>>>>> +    }
>>>>> +    return false;
>>>>> +}
>>>>> +
>>>>>   static void nvme_tcp_revoke_generated_tls_key(struct nvme_ctrl 
>>>>> *ctrl)
>>>>>   {
>>>>>       if (!ctrl->opts->concat)
>>>>> @@ -2321,6 +2337,9 @@ static void 
>>>>> nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>>>>>       if (nvme_tcp_setup_ctrl(ctrl, false))
>>>>>           goto requeue;
>>>>> +    if (nvme_tcp_reset_for_secure_concat(ctrl))
>>>>> +        return;
>>>>> +
>>>>>       dev_info(ctrl->device, "Successfully reconnected (%d 
>>>>> attempt)\n",
>>>>>               ctrl->nr_reconnects);
>>>>> @@ -2396,6 +2415,7 @@ static void nvme_reset_ctrl_work(struct 
>>>>> work_struct *work)
>>>>>       if (nvme_tcp_setup_ctrl(ctrl, false))
>>>>>           goto out_fail;
>>>>> +    nvme_tcp_reset_for_secure_concat(ctrl);
>>>>
>>>> This is really strange. I'd imagine that this would be needed only 
>>>> if the derived psk expired no?
>>>
>>> You are absolutely correct. But once you reset the connection the 
>>> derived PSK of the previous connection _is_ expired as DH-HMAC-CHAP
>>> generated a new one.
>>>
>>> Remember: for secure concatenation we _always_ have a two-step 
>>> connection setup. The initial connection runs for DH-HMAC-CHAP
>>> to generate the PSK, and then a connection reset to start over
>>> with TLS and the generated PSK.
>>> So upon reset we have to invalidate the generated PSK, reset the
>>> connection to run DH-HMAC-CHAP, and reset _again_ to start over
>>> with the new PSK.
>>
>> So what is the point of setting the derived psk with a timeout?
>>
>> Seems rather silly doing that _every_ reset/reconnect... But ok...
>
> Mandated by TP8018. Generated TLS PSK should be renewed after a
> certain time. Makes sense in general, but still a pain.

I understand that psk can expire, I don't understand why we need to 
reset every
single time. What if I'm doing the loop: while true; do nvme reset 
/dev/nvme0; done?

Will it do 2 resets every time?

