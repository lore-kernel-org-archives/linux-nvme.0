Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88A8C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 11:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oTq1KgURHV+q4hY8Ae/XNyf3vJBG5CKfTP/jocrgNTU=; b=u4LZH1qo024QQWHwc/dnj2CDwU
	NBLrtOeapekJDECIXM3afTS3heYQEItQ3570kPhpF8QFrweceLg/n69afHMB1PnKw5RRnTSxE08Co
	4Bka9cFOifPDtoiRi0unNauDr+TsBG10nNyboI2wPkkSdIaSVKEdpOEq11hjDsPA8DD3Qs7DJZ/91
	i4C9CxhNszu/lva5QMEG2Cj9NQQWi2QUKOD8xdOK9CiNRm4VRBcSBHqIYz57DU8cA1jh+lrBcE6LM
	ZNf7fJ1Gl2DB47I+nlF+onvnoTZV3aJ3/szXxlqzX7Lifg3+iAVJI3njDnOac/Yq/RS/3SPDmcWFe
	szN/eOww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riC3r-00000004KVQ-2fJJ;
	Thu, 07 Mar 2024 11:37:19 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riC3n-00000004KUk-3qtd
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 11:37:17 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412e41cab5aso342845e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 03:37:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709811434; x=1710416234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oTq1KgURHV+q4hY8Ae/XNyf3vJBG5CKfTP/jocrgNTU=;
        b=TYEeIR2ItP3rIcui+rEaw36ErZDIktUZA4xM5s0l5kZ4UJqRVqNl7Mr1/bqVWi7rk4
         yIPfCyWOLxKe3CeTyqKFC81aKMLnm1vufrUqf0TcB0D6zGbrzEGU/OImOOdRSrpGN8XG
         mx9ndzWMkTG1xRwfotEp1wUw/ZsRzNwSfm4OwTczMunBWJQfuJbST01e3LOaM1C8ng9L
         H2Gd2+NgyjPSYkwbnPG0IXUw3i9veIssjit/Vgc7AUWcTO3O7hVg1xB7BeZfyRyss6w1
         4VEiKkE+9k8J2Vt1IrS+cSTQx9pG1MPoYAEwgGbD5wZ3/4sZSXRb8v6/bdJSF8g8+0TD
         9wRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxVdP7EVSE/VqEztNdVS35hkcrFE4kbf2CYZQd4mb5bkdYuqGjP6nhWnzuJt1siFm8eH9yZfrBeQL59mThD+cr38kUypzJAHIJ/OOOLC0=
X-Gm-Message-State: AOJu0YyOQCY2pbJKZms6Yyn27Bn76X28VDlkqZWUPsecfYpAJfkOtLYI
	SkztSGUXFc3gI8MRDOC7uZwGZRck6CA6x3whQ6IDbpD6kFhitU7B
X-Google-Smtp-Source: AGHT+IHW96IB4T8Osp08eF7rg3w7ozk0B+apG708Mr1x/hrQcXeb6O6k3br0YCG2xrhN5Vh26/2G7g==
X-Received: by 2002:a05:600c:3ba8:b0:412:eb6e:2171 with SMTP id n40-20020a05600c3ba800b00412eb6e2171mr1235043wms.1.1709811433883;
        Thu, 07 Mar 2024 03:37:13 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id fl9-20020a05600c0b8900b00412eff2eb5bsm2461721wmb.13.2024.03.07.03.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 03:37:13 -0800 (PST)
Message-ID: <629656d5-2967-467b-8b80-759f4fccdfeb@grimberg.me>
Date: Thu, 7 Mar 2024 13:37:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvme: authentication error are always non-retryable
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240301112823.132570-1-hare@kernel.org>
 <20240301112823.132570-2-hare@kernel.org> <20240301131208.GA3586@lst.de>
 <f511975a-822e-470a-a3a2-d7ed652e3cfc@suse.de>
 <868727ce-5970-4296-9fc7-a431dccc8a63@grimberg.me>
 <20531716-b18d-4ab6-91e8-2ac0ea745343@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20531716-b18d-4ab6-91e8-2ac0ea745343@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_033715_984657_E219DA1C 
X-CRM114-Status: GOOD (  26.61  )
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



On 07/03/2024 12:32, Hannes Reinecke wrote:
> On 3/7/24 09:51, Sagi Grimberg wrote:
>>
>>
>> On 01/03/2024 17:26, Hannes Reinecke wrote:
>>> On 3/1/24 14:12, Christoph Hellwig wrote:
>>>>> -    if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
>>>>> -        return AUTHENTICATE;
>>>>> -
>>>>>       if (blk_noretry_request(req) ||
>>>>>           (nvme_req(req)->status & NVME_SC_DNR) ||
>>>>>           nvme_req(req)->retries >= nvme_max_retries)
>>>>>           return COMPLETE;
>>>>>   +    if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
>>>>> +        return AUTHENTICATE;
>>>>
>>>> This part looks fine (although I'd word the commit message
>>>> differently for it).
>>>>
>>>>> @@ -467,7 +467,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl 
>>>>> *ctrl)
>>>>>           if (result & NVME_CONNECT_AUTHREQ_ASCR) {
>>>>>               dev_warn(ctrl->device,
>>>>>                    "qid 0: secure concatenation is not supported\n");
>>>>> -            ret = NVME_SC_AUTH_REQUIRED;
>>>>> +            ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>>>>>               goto out_free_data;
>>>>>           }
>>>>>           /* Authentication required */
>>>>> @@ -475,14 +475,16 @@ int nvmf_connect_admin_queue(struct 
>>>>> nvme_ctrl *ctrl)
>>>>>           if (ret) {
>>>>>               dev_warn(ctrl->device,
>>>>>                    "qid 0: authentication setup failed\n");
>>>>> -            ret = NVME_SC_AUTH_REQUIRED;
>>>>> +            ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>>>>
>>>>
>>>> .. but the others should never use nvme status codes as they never
>>>> go out onto the wire.
>>>>
>>> Would love to, but to my knowledge we have the convention that NVMe 
>>> status codes less than 0 should _not_ be retried.
>>
>> What nvme status code is less than zero?
>>
> Not the NVMe status, but the 'ret' value containing either a 
> (positive) NVMe status or a (negative) errno.
>
>>> NVMe transport errors,
>>> OTOH, _should_ be retried.
>> Yes.
>>> 'connect_admin_queue' and 'connect_io_queue' now straddles the 
>>> boundary: technically it's an NVMe command, but in
>>> practice it's a transport command as there are quite a lot of steps
>>> before we even can send the 'connect' command.
>>>
>>> So, how do we handle the return codes from 'connect_admin_queue' ?
>>> The NVMe core style (with not retrying negative errors) or the NVMe
>>> transport style (with always retrying until we run out of retries)?
>>
>> Not exactly sure what is the question here. I am still going over 
>> emails so there
>> may be some discussion around this, but it is unclear from the patch 
>> description what is the issue this is solving.
>
> The question is what to do if nvmf_connect_admin_queue() returns with 
> a status with the DNR status set.
> In TCP the status is carried back to the return value of 
> nvme_tcp_setup_ctrl(), which is called during reset, reconnect, and 
> initialisation.
> For the first two the status is simply ignored, and always retried
> (ie every error is treated as retryable). For the latter, we will 
> always abort the initialisation (ie every error is non-retryable).
> Either way, we're completely ignoring the DNR bit in the NVMe status.

IMO We should always fail initial connect, for whatever reason. 
userspace can take care
of it if it wants to reconnect. If we managed to ever connect to a 
controller, we will retry
once we lose the connection.

>
> Daniel has sent two patches on my behalf, trying to evaluate the DNR
> status during reconnect and reset.

Didn't get to those yet.

> With them it suddenly matters how
> the return value from nvmf_connect_admin_queue() is to be interpreted.

OK, The spec should probably be clear about it.

> With my original idea of retrying authentication errors we will keep
> on retrying, even though the authentication settings won't change,
> and consequently each retry will fail. So in effect we go through
> pointless retries, and only abort the test case once the retries
> are exhausted. By making authentication errors non-retryable we
> can terminate the testcase directly.
> The only way I could think of to signal a non-retryable error
> is to return an NVMe status with the DNR bit set; every other error
> will cause a retry. But this will require us to fabricate an NVMe
> status code, which Christoph objects to.

Can we start with defining what is a retry-able authentication error and 
what isn't?

