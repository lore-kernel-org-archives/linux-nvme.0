Return-Path: <SRS0=XVsr=XL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F7FC49ED7
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 19:56:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F2020644
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 19:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZRtv1UYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F2020644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=N82KF8xXDVZE6kSJbQL6pLGTsuyGlCXKmmpAlJB4DCs=; b=ZRtv1UYUUHR7FwgFof98Sv5+n
	voT9tBHfHOdts1anp9FHKpes7QLKyvE9sphGQCuIlZJ/7Z6m7TsEgKNLBkDcfxbwEdLp3k1DHEtHB
	j8G/LlQqOx6pj/O1A9hZOBjZnYg/qSw3Im2xzyjL6nOO/v8JwPlAfH4Eh3HEZ+3WOOJgqoP2UkZuO
	2pOrSGxdrmaQhTURoqIO+DCBWtCE3oHUs1WOc+0yztL8SWXvAZPiSa4C++6aK3j2AI8ulMzMPyR9W
	YESM4/15x4f2Hrrdb/DRkvUNGOWdGlB7gnFxYe2S7iPkUls9LUKdh/q2VH4P0pF0q9YSseiJSWj2p
	wiTE9E9mw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i9x7C-0006No-8G; Mon, 16 Sep 2019 19:56:50 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9x79-0006NO-1T
 for linux-nvme@lists.infradead.org; Mon, 16 Sep 2019 19:56:48 +0000
Received: by mail-pf1-f196.google.com with SMTP id q7so554952pfh.8
 for <linux-nvme@lists.infradead.org>; Mon, 16 Sep 2019 12:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6AWbdouvmwXmtLTx5u4tNAaw3m+p86ppGR+eBYz+iaw=;
 b=J2YiqhdtO8whMbJskowUPkSaFb2p75MxyHUWMt+PcICNK4TPSKxzKRChWlZ613jl6j
 K0XKCCbuhCQx82w8MGvdVEn3+mmobuhfERKrNIcAaasLFoJI4wTq1MBx8YlgW2uecpf7
 e8rQNznwhcy2N23MHQHwcye65z/MgyqBW6lI9rlG7werUPTv3joEpMOyPO/XQE1sFFTb
 z2bOqA2Edu0XnEed8ZQy+ZGmsjYo0eEfcpWLydT0JkCSWNQXdAIsX8JxX63cy+U83WjA
 1XR9zdFi4IQavMVeU/1qgqGa9LNpCzdJ+zF/htjMaHckMhB9Bq4A9KXWST/buAQbOn5i
 DA1g==
X-Gm-Message-State: APjAAAVEOPpCetbFvgPLzufyDNn4T1Ud4WcSg2dOjU6/Hhyqzc/9gxgD
 QtBKB5YxbwG//HES4AXU699iujxIWog=
X-Google-Smtp-Source: APXvYqzZ5O2c+Q52uUgco7a9iB7Zl/AJ2w0eO649h2MYk0//WYq4Lhzlkf1HxuQ1imz4E1opJoDmGw==
X-Received: by 2002:a63:ff66:: with SMTP id s38mr799220pgk.363.1568663805869; 
 Mon, 16 Sep 2019 12:56:45 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com
 ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
 by smtp.gmail.com with ESMTPSA id z10sm384713pjr.15.2019.09.16.12.56.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Sep 2019 12:56:44 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] nvme/host/pci: Fix a race in controller removal
To: "Singh, Balbir" <sblbir@amazon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sblbir@amzn.com" <sblbir@amzn.com>
References: <20190913233631.15352-1-sblbir@amzn.com>
 <7017c4c1-75a9-1e37-eb54-6126dfbb251b@acm.org>
 <25d9badc90a1eb951cb5103774e8360edaa8ec15.camel@amazon.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <14becaec-2284-d680-b3b2-c38537c91521@acm.org>
Date: Mon, 16 Sep 2019 12:56:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <25d9badc90a1eb951cb5103774e8360edaa8ec15.camel@amazon.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190916_125647_084487_182731D8 
X-CRM114-Status: GOOD (  18.23  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/16/19 12:38 PM, Singh, Balbir wrote:
> On Mon, 2019-09-16 at 08:40 -0700, Bart Van Assche wrote:
>> On 9/13/19 4:36 PM, Balbir Singh wrote:
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index b45f82d58be8..f6ddb58a7013 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -103,10 +103,16 @@ static void nvme_set_queue_dying(struct
>>> nvme_ns *ns)
>>>    	 */
>>>    	if (!ns->disk || test_and_set_bit(NVME_NS_DEAD, &ns->flags))
>>>    		return;
>>> -	revalidate_disk(ns->disk);
>>>    	blk_set_queue_dying(ns->queue);
>>>    	/* Forcibly unquiesce queues to avoid blocking dispatch */
>>>    	blk_mq_unquiesce_queue(ns->queue);
>>> +	/*
>>> +	 * revalidate_disk, after all pending IO is cleaned up
>>> +	 * by blk_set_queue_dying, largely any races with blk parittion
>>> +	 * reads that might come in after freezing the queues,
>>> otherwise
>>> +	 * we'll end up waiting up on bd_mutex, creating a deadlock.
>>> +	 */
>>> +	revalidate_disk(ns->disk);
>>>    }
>>
>> The comment above revalidate_disk() looks wrong to me. I don't think
>> that blk_set_queue_dying() guarantees that ongoing commands have
>> finished by the time that function returns. All
>> blk_set_queue_dying()
>> does is to set the DYING flag, to kill q->q_usage_counter and to wake
>> up
>> threads that are waiting inside a request allocation function. It
>> does
>> not wait for pending commands to finish.
> 
> I was referring to the combined effect of blk_set_queue_dying() and
> blk_mq_unquiesce_queue() which should invoke blk_mq_run_hw_queues().
> I can see how that might be misleading. I can reword it to say
> 
> /*
>   * revalidate_disk, after all pending IO is cleaned up
>   * largely any races with block partition
>   * reads that might come in after freezing the queues, otherwise
>   * we'll end up waiting up on bd_mutex, creating a deadlock
>   */
> 
> Would that work?

I don't think so. Running the hardware queues is not sufficient to 
guarantee that requests that had been started before the DYING was set 
have finished.

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
