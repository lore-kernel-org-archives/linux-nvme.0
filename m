Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0780C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 08:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SQaJGlyMxDxM92vESERhjv5rcWAKZ6ex7RCbOXz8fBQ=; b=CNPb7cSKQSBujMG6XR4NnA9snw
	oaQtRFhddF6N7OMjPSZzvx3Y8YTL7O7lC79lMHOzQ37TTsqCT1j7dykHQh0ZMVuVcdXvdMr/sBb9P
	1fB4qYfHSFiRkv5SWNqD4YiA0Rf7mMJBIFPi++DyK2jPo1iLJoWaUQaK8Snoysj7xkI/IxJAT2bLr
	czfUvdd3QLD5rCJUVGnh7pMefPBF/D1bFCAgsjG6TYfCD/M0SORv2/3zRfagBKpGUW7t9KoNjM8Gc
	uKxlvalkHKEjbr/qdjmuFiOBjxiDxZD6+mPDeG4edRgiix1d8aaf2YhO18heGiR+RojHyZm8GUGjB
	EmeOE1KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU2li-008K62-Uv; Tue, 15 Mar 2022 08:43:02 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU2lf-008K3W-By
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 08:43:00 +0000
Received: by mail-wr1-f42.google.com with SMTP id r6so27365680wrr.2
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 01:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=SQaJGlyMxDxM92vESERhjv5rcWAKZ6ex7RCbOXz8fBQ=;
 b=DcGxl2w1lhi3aLzgmboH00l9vf1zL7Xr7jVxp0jdrR7QOiP9fMwOTfsORY15ud83ub
 S/7emilV2kNWLNmM4EXxoyqMZLu9GxvUYGSzygPYyiDToHFUaYPsCkJUKwZ0nS85001Y
 A9ZVqBqUhQA7rCEIu8EZt8h1Ryc2sEp3V+h+UQ9ww55tUcOEw/fJ+EN7maZB+wOiogb0
 b5RK6w5CYe+o9Zs0mczs/vQG0tj3EXOsEW/O9XPPhxhI2LvRi8EzzoUlQsUIMNs1p9BW
 nYwnddj7XORUDLW9cA8TxWkG0jnPS0zqdz7egfi9xIoALEKydZTTnCRfGURebQQOeptJ
 zTuw==
X-Gm-Message-State: AOAM531HsFEpuayW0YR+uci2gh3bAovPHp3nKreTzixQNgExc2lIaX0S
 FHOe0KvAEoDX0Etatqv90Z0=
X-Google-Smtp-Source: ABdhPJwz23JwJGrmvxcd66EAJx6dzWlFeuh9jhCzDYWmqMSJXBX+pe4A9nWcHI6GAH4fuHhjqvsRkg==
X-Received: by 2002:a5d:5986:0:b0:1f1:f971:f02 with SMTP id
 n6-20020a5d5986000000b001f1f9710f02mr18678032wri.578.1647333777502; 
 Tue, 15 Mar 2022 01:42:57 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 u25-20020a05600c211900b00389d4bdb3d2sm2517865wml.36.2022.03.15.01.42.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 01:42:57 -0700 (PDT)
Message-ID: <6ac83f8b-01e6-5394-0570-023ac6b1a71d@grimberg.me>
Date: Tue, 15 Mar 2022 10:42:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] driver/nvme/host: Support duplicated nsid for the
 private ns
Content-Language: en-US
To: "hch@lst.de" <hch@lst.de>
Cc: Sungup Moon <sungup.moon@samsung.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
 <20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
 <20220315071230.GA2069@lst.de> <20220315071926.GA2137@lst.de>
 <a3051d85-c08e-a273-c7cc-2eb3e21df717@grimberg.me>
 <20220315084035.GA3834@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220315084035.GA3834@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_014259_447856_3E8F090C 
X-CRM114-Status: GOOD (  14.66  )
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


>>> +static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
>>>    		unsigned nsid)
>>>    {
>>> +	struct nvme_subsystem *subsys = ctrl->subsys;
>>>    	struct nvme_ns_head *h;
>>>      	lockdep_assert_held(&subsys->lock);
>>
>> IMO it is a bit strange that we now don't pass in the subsystem but
>> require that the subsys->lock is taken...
> 
> We do things like that in various places, mostly because information
> needed that is subsystem-wide hangs of the nvme_ctrl structure, in
> this case the various feature bitmaps.  We could move them to the
> subsystem structure, which would be the right thing to do but a fair
> amout of churn for little savings.

Yea I understand its not universally enforced, just popped up.

>>> +++ b/drivers/nvme/host/multipath.c
>>> @@ -504,10 +504,11 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>>>      	/*
>>>    	 * Add a multipath node if the subsystems supports multiple controllers.
>>> -	 * We also do this for private namespaces as the namespace sharing data could
>>> -	 * change after a rescan.
>>> +	 * We also do this for private namespaces as the namespace sharing flag
>>> +	 * could change after a rescan.
>>
>> What happens in this case? we now have non-unique shared namespaces?
> 
> The non-uniqueue NSIDs can only happen for private namespaces.

But what happens if this changes upon a rescan as you commented?

