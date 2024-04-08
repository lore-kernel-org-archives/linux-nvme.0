Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E652C67861
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 21:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FITK737ZhM3QzhgRU1Os6CCvR7uI3sY2IiiEL0GJLag=; b=TYLcLE5Ha/pZndbpFnNqVNkiMp
	bDpx922aXFhgM6TCVR/U1ZN/10DMEdJq1lY4nrtkwgZViVB95BVGn3gAR4reOjrOrv+uzovmrp0r7
	hZ/x18anw6A2Y9c2vRZBaGn/Aarqnr6tj9hcHOoUwJXdC0eQM3SICb3cgXNWClw+wokn/JeSEyfsr
	hsX10Mc95jyC0M8lw+o5No0zN11TNpgkO0XmP8rt0rG/MuCVqxgCDAAuJ3929F3Z1kh3X632KWW8U
	DmrzgrQCHbwWbEsAYbrlg9ahhQtl0obdY3frbP4MjyamLwJAjbY1o/Qrc8/FWVRlqBImzX631KYNq
	O63WsnRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtwSU-0000000Gsj9-3zAM;
	Mon, 08 Apr 2024 21:23:18 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtwSR-0000000Gsi0-1CIJ
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 21:23:16 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4166344b68dso1388345e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 08 Apr 2024 14:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712611393; x=1713216193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FITK737ZhM3QzhgRU1Os6CCvR7uI3sY2IiiEL0GJLag=;
        b=iDmixfsIgpjIUxQdUCmxsO9aI/F1YNzcLgoRsnisLHjNokytZRkNXogJMgzBUFh3Rn
         MW1or9gsQLVOmuaPaCVggGIXremfobRLcETRPL8mbC94Kic+/vU31wtkloxe+urZwID/
         VY6jEI5BFMILQqTL95/gXg8CesQD6k3RB50QO8ug922UY31j2mJd5obAcdxT2SrGalIK
         fqPvTyelSRavAJX2J0cLbGprbCWfSVTDl1ln4K2WYVfaetJcNLkH4JzqJQLaxrr/5Uw/
         cD8rqaaHwv0d+75p2z3rJa+XG6qFHkCLxjhQaCbBG/X7SgEtxhCqm+1WoUDvmTQv+id1
         bp+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8NKFzDcYuRSndNTA1FKt1xI8ZU7qLqxNG43XwvrzLelZiUN7ZLemc0gfYZFtBHuMzZ/OZvmrkk/VSNddWRDw4ejPwa2bHOzgF8I0YyFg=
X-Gm-Message-State: AOJu0YwUJKmwuc3Ee9Ckgr7Zt41Idgf77tS85P24DOKAY9bmf1fr4PDS
	YR13NbLT14pDEWEGX5tyHcm3VJnNP4hdGjRERB/5nVR6qzCOvYWUK1h4Edv0
X-Google-Smtp-Source: AGHT+IF7bNPai0vH/CvsEs5ZE9ynXFWcCJLApbkYeQ8lpBDGKqh/TSuo/KUycdcFksMdk6mI2LcMrw==
X-Received: by 2002:a05:600c:4f95:b0:414:f154:e652 with SMTP id n21-20020a05600c4f9500b00414f154e652mr7627646wmq.3.1712611392686;
        Mon, 08 Apr 2024 14:23:12 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id fl14-20020a05600c0b8e00b004166d303d6fsm5356461wmb.25.2024.04.08.14.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 14:23:12 -0700 (PDT)
Message-ID: <4438fdf3-2970-456b-acc6-fe26c355bfac@grimberg.me>
Date: Tue, 9 Apr 2024 00:23:11 +0300
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
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d055615b-2c41-45cd-8b15-c787eac0dc49@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_142315_567432_AFF29011 
X-CRM114-Status: GOOD (  19.54  )
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



On 08/04/2024 9:25, Hannes Reinecke wrote:
> On 4/7/24 23:49, Sagi Grimberg wrote:
>>
>>
>> On 18/03/2024 17:03, Hannes Reinecke wrote:
>>> From: Hannes Reinecke <hare@suse.de>
>>>
>>> With TP8018 a new key will be generated from the DH-HMAC-CHAP
>>> protocol after reset or recovery, but we need to start over
>>> to establish a new TLS connection with the new keys.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/host/tcp.c | 20 ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 94152ded123a..3811ee9cd040 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -2219,6 +2219,22 @@ static void 
>>> nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
>>>       }
>>>   }
>>> +static bool nvme_tcp_reset_for_secure_concat(struct nvme_ctrl *ctrl)
>>> +{
>>> +    if (!ctrl->opts->concat)
>>> +        return false;
>>> +    /*
>>> +     * If a key has been generated and TLS has not been enabled
>>> +     * reset the queue to start TLS handshake.
>>> +     */
>>> +    if (ctrl->opts->tls_key && !ctrl->tls_key) {
>>> +        dev_info(ctrl->device, "Reset to enable TLS with generated 
>>> PSK\n");
>>> +        nvme_reset_ctrl(ctrl);
>>> +        return true;
>>> +    }
>>> +    return false;
>>> +}
>>> +
>>>   static void nvme_tcp_revoke_generated_tls_key(struct nvme_ctrl *ctrl)
>>>   {
>>>       if (!ctrl->opts->concat)
>>> @@ -2321,6 +2337,9 @@ static void 
>>> nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>>>       if (nvme_tcp_setup_ctrl(ctrl, false))
>>>           goto requeue;
>>> +    if (nvme_tcp_reset_for_secure_concat(ctrl))
>>> +        return;
>>> +
>>>       dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
>>>               ctrl->nr_reconnects);
>>> @@ -2396,6 +2415,7 @@ static void nvme_reset_ctrl_work(struct 
>>> work_struct *work)
>>>       if (nvme_tcp_setup_ctrl(ctrl, false))
>>>           goto out_fail;
>>> +    nvme_tcp_reset_for_secure_concat(ctrl);
>>
>> This is really strange. I'd imagine that this would be needed only if 
>> the derived psk expired no?
>
> You are absolutely correct. But once you reset the connection the 
> derived PSK of the previous connection _is_ expired as DH-HMAC-CHAP
> generated a new one.
>
> Remember: for secure concatenation we _always_ have a two-step 
> connection setup. The initial connection runs for DH-HMAC-CHAP
> to generate the PSK, and then a connection reset to start over
> with TLS and the generated PSK.
> So upon reset we have to invalidate the generated PSK, reset the
> connection to run DH-HMAC-CHAP, and reset _again_ to start over
> with the new PSK.

So what is the point of setting the derived psk with a timeout?

Seems rather silly doing that _every_ reset/reconnect... But ok...

