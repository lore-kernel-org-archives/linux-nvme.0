Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762A1C5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 10:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nOyJ0vXvYfxQRLj0ZrdvSqI4qJstkPbTgrDZPnLnrv4=; b=s8H2OsLgC3jxtHBLB+rMCBJdDp
	QrqBYq+oT0uaoAGOaOMNiaa/Uvlf1vyNGXW9HSsBCNLBtLe+8UR1MHEKqiXsd07qII8B5WtuFVttt
	XAC/exjPEp6ChIAa5Cdz2VcZgTwImyd3joabqmsip2BiRYLToFlsrtCQ48wt+qDQqNMgUO15tkSaV
	woQbG30TPh1jHJI/WWacEwOL8WgrJGYtKjM+By4hMqbdx+HvOKX6Nv1YDthj0NuSHZSGkxQfBLWUk
	4m613S9/LGFUalL8fQkGZOojjIWlRG2HUg9UD5PVkT81OpiyhvQRtnEHxpCVE2a2vhS23IWuym74p
	2CbbjzMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riXMK-00000008kCG-49cE;
	Fri, 08 Mar 2024 10:21:48 +0000
Received: from mail-lf1-f50.google.com ([209.85.167.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riXMH-00000008kAU-0HsE
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 10:21:46 +0000
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513830f18d9so195597e87.1
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 02:21:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709893303; x=1710498103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOyJ0vXvYfxQRLj0ZrdvSqI4qJstkPbTgrDZPnLnrv4=;
        b=D6hqMf1YrziZztoKvlACTmNAN/KucXG+SRNB6ARP+/r4P7BdrAZ5LYCG3ldb+8giGJ
         nwBapgg5GFfI0/fZQF8dZElLR8LgoTH9h1s2AignT5spZAe2327GUqhc9i0uFXZS5iHv
         KV7hqXteGNSI0pv3995OAzYEJKDHFRG4QU6lknkDOax+7Ld7mExFgrWiIkbzMX/7hXf0
         A99nyWfXJXqfej5wA2nO3w10ppXEv0q7eZIry2MSws67zClhuE4SLCwPMSN5KKvyqkU2
         9ScKBZf+tZHoXdaEjrQeUeqE/K5b7yB7F2PpnI0XWJ6w6M5ieC4nLIUQGuAKgEnZm9+R
         Bgog==
X-Forwarded-Encrypted: i=1; AJvYcCWbC4dBUCjAU52CIE+//vNf7T7jf1rpiNax/nqGXDIAoABvx3RGd63iR3wkyqrExlLVYTnQ2lUwDRhP1Moc98uNBkydWiDYGY+LP0zz6LE=
X-Gm-Message-State: AOJu0YydDGp3nQFxXfE2i2UrMnyt91TAYVl9cFxfh5akG4/z8FXTERPa
	iewUVM3DV9h6ROjd1Ri1yZkyBC1GlszDaA5m5eKCRCg3rTUKAV0m
X-Google-Smtp-Source: AGHT+IEg7otObSNvAQkRZFRGAB1RYZTFwqMGbwMIpvLuU2IT7sSktAUSbK5hI7G9hD5ARZBuyLu+aA==
X-Received: by 2002:ac2:48ae:0:b0:513:4467:523c with SMTP id u14-20020ac248ae000000b005134467523cmr891239lfg.3.1709893302423;
        Fri, 08 Mar 2024 02:21:42 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id jh3-20020a05600ca08300b0041304100fa9sm5430817wmb.45.2024.03.08.02.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 02:21:42 -0800 (PST)
Message-ID: <2cda7c9a-a460-4bb4-95f7-ab44f8f1007c@grimberg.me>
Date: Fri, 8 Mar 2024 12:21:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvme-fabrics: short-circuit connect retries
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240305080005.3638-1-dwagner@suse.de>
 <22b01fb4-b543-43b2-949c-1873105dc343@grimberg.me>
 <72c1d3a8-14ad-43e8-a68a-25be903698c4@suse.de>
 <432a39d5-6d08-4d38-a357-7c8d9123189a@grimberg.me>
 <08f3d804-f94b-4a2f-897b-7fee3411e6fc@suse.de>
 <b02588cb-6fbc-4116-86d6-173c115f50c5@grimberg.me>
 <b23a5c7c-a877-4cde-acd4-50c21c3ef1fc@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b23a5c7c-a877-4cde-acd4-50c21c3ef1fc@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_022145_136148_0BBEF4D6 
X-CRM114-Status: GOOD (  31.26  )
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



On 07/03/2024 14:52, Hannes Reinecke wrote:
> On 3/7/24 13:14, Sagi Grimberg wrote:
>>
>>
>> On 07/03/2024 13:45, Hannes Reinecke wrote:
>>> On 3/7/24 12:30, Sagi Grimberg wrote:
>>>>
> [ .. ]
>>>>
>>>> Where is this retried today, I don't see where connect failure is 
>>>> retried, outside of a periodic reconnect.
>>>> Maybe I'm missing where what is the actual failure here.
>>>
>>> static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>>> {
>>>         struct nvme_tcp_ctrl *tcp_ctrl =
>>>                         container_of(to_delayed_work(work),
>>>                         struct nvme_tcp_ctrl, connect_work);
>>>         struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>>>
>>>         ++ctrl->nr_reconnects;
>>>
>>>         if (nvme_tcp_setup_ctrl(ctrl, false))
>>>                 goto requeue;
>>>
>>>         dev_info(ctrl->device, "Successfully reconnected (%d 
>>> attempt)\n",
>>>                         ctrl->nr_reconnects);
>>>
>>>         ctrl->nr_reconnects = 0;
>>>
>>>         return;
>>>
>>> requeue:
>>>         dev_info(ctrl->device, "Failed reconnect attempt %d\n",
>>>
>>> and nvme_tcp_setup_ctrl() returns either a negative errno or an NVMe 
>>> status code (which might include the DNR bit).
>>
>> I thought this is about the initialization. yes today we ignore the 
>> status in re-connection assuming that whatever
>> happened, may (or may not) resolve itself. The basis for this 
>> assumption is that if we managed to connect the first
>> time there is no reason to assume that connecting again should fail 
>> persistently.
>>
> And that is another issue where I'm not really comfortable with.
> While it would make sense to have the connect functionality to be
> one-shot, and let userspace retry if needed, the problem is that we
> don't have a means of transporting that information to userspace.
> The only thing which we can transport is an error number, which
> could be anything and mean anything.

Not necessarily. error codes semantics exists for a reason.
I just really don't think that doing reconnects on a user-driven 
initialization is a good idea at all
unlike the case where the controller was connected and got disrupted, 
this is not user driven and
hence makes sense.

> If we had a defined way stating: 'This is a retryable, retry with the 
> same options.' vs 'This is retryable error, retry with modified 
> options.' vs 'This a non-retryable error, don't bother.' I'd be
> fine with delegating retries to userspace.
> But currently we don't.

Well, TBH I don't know if userspace even needs it. Most likely what a 
user would want is to define
a number of retries and give up if they expire. Adding the intelligence 
for what connect is retry-able or
not does not seem all that useful to me.

>
>> If there is a consensus that we should not assume it, its a valid 
>> argument. I didn't see where this happens with respect
>> to authentication though.
>
> nvmf_connect_admin_queue():
>
>             /* Authentication required */
>             ret = nvme_auth_negotiate(ctrl, 0);
>             if (ret) {
>                     dev_warn(ctrl->device,
>                              "qid 0: authentication setup failed\n");
>                     ret = NVME_SC_AUTH_REQUIRED;
>                     goto out_free_data;
>             }
>             ret = nvme_auth_wait(ctrl, 0);
>             if (ret)
>                     dev_warn(ctrl->device,
>                              "qid 0: authentication failed\n");
>             else
>                     dev_info(ctrl->device,
>                              "qid 0: authenticated\n");
>
> The first call to 'nvme_auth_negotiate()' is just for setting up
> the negotiation context and start the protocol. So if we get
> an error here it's pretty much non-retryable as it's completely
> controlled by the fabrics options.
> nvme_auth_wait(), OTOH, contains the actual result from the negotiation,
> so there we might or might not retry, depending on the value of 'ret'.
>
> Cheers,
>
> Hannes
>


