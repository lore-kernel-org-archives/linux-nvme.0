Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F84C54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 10:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f3uiQHSLKPmXu2jVNeyhXvQI9q93ArxPAwtLNpqT2b4=; b=P/5qGLmrBmzRtncq9vu2tDUqLD
	8GBUChSok3uscyrSDx1CmblBtK9554btm+vV9JrMUEp2s7XxdGHnygR9+s5HdzIy4JfjcHMziXd7y
	iVZ44ikYAXhKn0sfJuzEt8cXBE5fgsWyIeL8ipUlQD2jB4uaM+EiSsj0qLpeXreX/+SRz3wNSM15g
	72n8lEPrTm750IECaQ8lC1PPB9kLrUgTzbeW1dO4GtwjeOmsX/NKi5TevDSWzGav4qPQ2VG2oM9qg
	L4Mf2MjBGBWfZ0mxqBbIBAbBga4jVWbqWtoQZDq+waWwIrHoZYl90gcwMqmTr+C0liP7FcsAyNCNh
	tsDJYvuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riXgP-00000008p7H-1s5Q;
	Fri, 08 Mar 2024 10:42:33 +0000
Received: from mail-lf1-f46.google.com ([209.85.167.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riXgK-00000008p5o-3OwF
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 10:42:30 +0000
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5132bd70e7dso497186e87.1
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 02:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709894547; x=1710499347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3uiQHSLKPmXu2jVNeyhXvQI9q93ArxPAwtLNpqT2b4=;
        b=WBM3D6/rsbAXDQUvmUI8Okd4VRDD4w10jjU6f9ZmcMacYppsgAs8iY6svGFJY+vpH8
         qp1jVsoSgoKC9lcMUEypnM7ebkUEM3kTe2t8gKZEGGiXqOt4TPA9tFQY3qEt9+rbxtOy
         2u8n9/6Ze6x/wDwXRSeYU6nOjdfekGhFOUACMBfNuGx3WVq+eptyTwAG9AK2lRAlH1oY
         aSCN+OOTahRp4dv4yOVkYgRFd3G7bae3Wfvtxu9KzEnQAUBMZcTPaQhe65IHGkvnyfwv
         fNZcM5NbgtBqGKNQiAlw5Ce0yAtxPHUdhS8Yy8hJm/thlTka1wJnsXe03GUmO0xC0+RO
         CA6A==
X-Forwarded-Encrypted: i=1; AJvYcCV9OT1PSN5GJxP3Vf/iSvUYaiOuynjmfwGYoPy/ViZSDJ/NxZgdC3vTAiJYYPpv/0ebC9nKRdF3NxsO3A/nWuasVUbwy3vStkTVDn633Ac=
X-Gm-Message-State: AOJu0YwrB0afJBYqUmlXOi9IpJyM/ANEd6qjTuZwoReAACxHnV7AwF2O
	PMzz35LclS8yEoW9z4DRi1kyF/QEg+zWVVz0BCkX1kUam9R/+Hst
X-Google-Smtp-Source: AGHT+IGkp/yuT0W0GJEzuGFE/gQXA4JPt4p8Nv0Wt7lSVsG54Sox8j7K/HHPgFOt7Twb/HgTbDf8Hg==
X-Received: by 2002:a05:6512:2388:b0:513:2a5b:cae with SMTP id c8-20020a056512238800b005132a5b0caemr1384976lfv.2.1709894546824;
        Fri, 08 Mar 2024 02:42:26 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id dp14-20020a0560000c8e00b0033d8ce120f2sm22551854wrb.95.2024.03.08.02.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 02:42:26 -0800 (PST)
Message-ID: <e7d8627d-d6a2-429c-bf1d-6e995c0ca5a5@grimberg.me>
Date: Fri, 8 Mar 2024 12:42:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add 'static' suffix for user-specified TLS keys
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240226122449.46976-1-hare@kernel.org>
 <1aee2876-15dd-48dd-a6b1-76ac1ebfc682@grimberg.me>
 <bf86f3ec-738f-49e5-ad54-c817f9d9542d@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bf86f3ec-738f-49e5-ad54-c817f9d9542d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_024229_089797_C17BA754 
X-CRM114-Status: GOOD (  23.60  )
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



On 07/03/2024 12:47, Hannes Reinecke wrote:
> On 3/7/24 10:45, Sagi Grimberg wrote:
>>
>>
>> On 26/02/2024 14:24, Hannes Reinecke wrote:
>>> From: Hannes Reinecke <hare@suse.de>
>>>
>>> If the user specifies a specific TLS key via the '--tls_key'
>>> option to nvme-cli we should be adding a ';static' suffix
>>> to the 'tls_key' sysfs attribute to signal that this is a
>>> user-specific key, and not one auto-selected during TLS
>>> protocol negotiation.
>>
>> Static is not the best wording. Doesn't the user already
>> know what it provided? How is this indication useful?
>
> What I'm trying to achieve here is to differentiate between
>
> nvme connect --tls
>
> and
>
> nvme connect --tls_key=<key_id>
>
> both calls will result in key serial number in the
> 'tls_key' attribute, so if we try to generate the json
> configuration file from an existing connection we
> have no idea which of the arguments the admin has
> used. Problem is that first invocation will auto-select
> the TLS key, and hence we can do a key rotation.
> The second invocation will always refer to a specific
> key, and hence we cannot do a key rotation.
>
> So we'll need an additional setting allowing us
> to differentate here.
>
> I do agree that adding a field to an existing
> attribute is probably suboptimal, so I guess
> I'll retract this patch and send another introducing
> a new sysfs attribute ('tls_provisioning' ?)

What are the outputs for this new attributes?

>
> The alternative would be to add a new attribute for
> the keyring (ie introduce a 'tls_keyring' attribute).
> That would be empty for a pre-configured key (as we
> are looking up the key by serial, and don't care on
> which keyring the key is in), and contain the keyring
> name otherwise.
>
> Hmm. I guess I like this better, as then we would
> also be able to display the 'keyring' setting which
> currently is also not present in sysfs.

Agree that displaying the keyring in sysfs is useful to
have.

