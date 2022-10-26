Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2334EC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 12:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Mz6BnCuKVZQF4JvBhE3UqgpuenhtJimw1Y5NR47pF8=; b=ENn6Jzq+xzajWUKpRhLlN5wIpC
	tATjPI5dwGPjMaq8ARJVfbQFfvWTPyrzxF5vxkmsLHknll3ji4/YlxRnjdwg8gQYyPZtrfvX+hesJ
	B8IPSXbKI/v7nsUKa61EH992a9JWx8ow5hZRBwL0W4pILRFYQvPEkjbQ3HvJrqWgd5hvXNoK9rD6h
	CFv7hviEIhFYYm01KojK+fgzHj4NsHHP3Czai1XnWGmMF92OMo7BbsLmBcgHV1inqKvvTbUMryH/c
	kT3R7/f4HgjttLiiS8P39Rvfv2VIzdNhGCQgIaGwCpxBqR4tqY+xVc2JtOXRlgrb48pRffzveBuHY
	6hNKGU3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfVc-009Aam-EX; Wed, 26 Oct 2022 12:27:48 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfVa-009AaA-38
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 12:27:47 +0000
Received: by mail-wr1-f50.google.com with SMTP id k8so17398836wrh.1
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 05:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Mz6BnCuKVZQF4JvBhE3UqgpuenhtJimw1Y5NR47pF8=;
        b=vYww1+OGdczoTyWs95es6M/i06mmo0eHFmq182t2J5E7ZMljVyDHpMMbuWPCquUPTm
         zat9a5+6eg5PvGqF2OMVQH1rSeMM7ZmwxhzYtf4BUeWF76RN7i+Xa/JFMy7yBxjOruyj
         wqwPcljy0dIIV2rGIcCNAmKn+QyoLPytQN+s9rkhKylp6EJ670SN1NVejE86iLNXk0i+
         qxAeypQbd7yqdDCxKNUkNNWNmMyYLjYkjcMX4uA0eqpKWiWw+Kbdg4ZEmRE5x8mukeSv
         UtcFUII2Srf6ghHDNJ5GHNf9dlpF2oXSJ8Q8OsDT493r05BP3GNu7xOkgaeivy/z5eoq
         bkzg==
X-Gm-Message-State: ACrzQf19hOBDCrSUYgptzLanI7kzRGKJzV6KHac2R187H4ig/4DlFJ+P
	d6bo5rc85PEt2rlfBp4D5qiaJXxc8p8=
X-Google-Smtp-Source: AMsMyM6P0EnXX0XKXo7eOvvclkmwHKJo2clRfdeLRFsSnWLOuXwEx2bdbjXILmtejqUEZfdUC6Pw3Q==
X-Received: by 2002:a5d:6743:0:b0:236:6301:918 with SMTP id l3-20020a5d6743000000b0023663010918mr14568359wrw.247.1666787262979;
        Wed, 26 Oct 2022 05:27:42 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bp4-20020a5d5a84000000b0022e57e66824sm6467413wrb.99.2022.10.26.05.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:27:42 -0700 (PDT)
Message-ID: <d2e62abe-56a1-b29f-ca3c-03e07dd8da31@grimberg.me>
Date: Wed, 26 Oct 2022 15:27:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: bad unlock balance WARNING at nvme/045
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20221018080350.zir6xm6dnr4wgb7j@shindev>
 <93e16b0e-4fa0-c0e1-6cc5-dec018db5f5c@grimberg.me>
 <853f0eb7-1f0f-eefe-fd32-0b1a1a98d3d7@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <853f0eb7-1f0f-eefe-fd32-0b1a1a98d3d7@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_052746_152519_C3F1016D 
X-CRM114-Status: GOOD (  22.67  )
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



On 10/26/22 09:42, Hannes Reinecke wrote:
> On 10/18/22 12:57, Sagi Grimberg wrote:
>>
>>> Hello Hannes,
>>>
>>> I observed "WARNING: bad unlock balance detected!" at nvme/045 [1]. 
>>> As the Call
>>> Trace shows, nvme_auth_reset() has unbalanced mutex lock/unlock.
>>>
>>>     mutex_lock(&ctrl->dhchap_auth_mutex);
>>>     list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
>>>         mutex_unlock(&ctrl->dhchap_auth_mutex);
>>>         flush_work(&chap->auth_work);
>>>         __nvme_auth_reset(chap);
>>>     }
>>>     mutex_unlock(&ctrl->dhchap_auth_mutex);
>>>
>>> I tried to remove the mutex_unlock in the list iteration with a patch 
>>> [2], but
>>> it resulted in another "WARNING: possible recursive locking detected" 
>>> [3]. I'm
>>> not sure but cause of this WARN could be __nvme_auth_work and
>>> nvme_dhchap_auth_work in same nvme_wq.
>>>
>>> Could you take a look for fix?
>>
>> I'm looking at the code and I think that the way the concurrent
>> negotiations and how dhchap_auth_mutex is handled is very fragile,
>> also why should the per-queue auth_work hold the controller-wide
>> dhchap_auth_mutex? The only reason I see is because nvme_auth_negotiate
>> is checking if the chap context is already queued? Why should we
>> allow that?
>>
> Well; that's partially due to the internal design of linux-nvme.
> The controller structure itself doesn't have 'queues' per se; there just 
> is a general 'ctrl' structure. So while I would have loved to have a 
> per-queue structure to hook the chap authentication into, all I have is 
> the controller structure.
> Hence we have a controller-wide list holding all 'chap' structures for 
> the individual queues.
> Hence the controller-wide mutex to gate list modifications.

This stil can easily be an array that does not enforce a list traversal.

> 
>> I'd suggest to splice dhchap_auth_list, to a local list and then just
>> flush nvmet_wq in teardown flows. Same for renegotiations/reset flows.
>> And we should prevent for the double-queuing of chap negotiations to
>> begin with, instead of handling them (I still don't understand why this
>> is permitted, but perhaps just return EBUSY in this case?)
> 
> We don't double queue; we're re-using the existing entries.

I'd argue that you shouldn't. It'd be better to simply delete entries
once queue auth is done...

> Can you check if this fix works?
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index c8a6db7c4498..4e824aab30eb 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -926,7 +926,6 @@ void nvme_auth_reset(struct nvme_ctrl *ctrl)
> 
>          mutex_lock(&ctrl->dhchap_auth_mutex);
>          list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
> -               mutex_unlock(&ctrl->dhchap_auth_mutex);
>                  flush_work(&chap->auth_work);
>                  __nvme_auth_reset(chap);
>          }

How can this work? auth_work currently acquires the mutex. This
shouldn't solve anything.

