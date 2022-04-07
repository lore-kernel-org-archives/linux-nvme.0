Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A47C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 13:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FYAt32anSHPyyV5iU/d1AJrW64tXears8hv3LonlPJs=; b=fuUy3L51YET9z+34TAYxTUWKWg
	AA3mAyfuBtycr9e50u+o2QSGNwWNwA/heAsUAbZLFXklR7chd5w/qg5WvimQp8KWQzNCZhVjO6jwN
	oCAKXw6q3IKBpftsgxn5P5DvUizjPjtLLcO/3RhyQq8VpXwKUpHPrewfeyGm27qCdyr9nZeRHwWYr
	MWPZ5ICUGd5I7QwN9b2l5WGE2LDP4MjVK4mqWQ3MPsiu9oVodazD/p2zjIWhuUjuMwRgzp2AHifVY
	tCJmIMOy9b+gFGPMx0YzGnawRQpGrzZSgh2gcGmkP0i7XhAJCqQO7SfZzzmsCGevmD0bmpKT0GhAD
	6PcMoyXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncRp4-00C3rW-Od; Thu, 07 Apr 2022 13:05:14 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncRoh-00C3dA-5B
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 13:04:52 +0000
Received: by mail-wr1-f54.google.com with SMTP id w4so7714561wrg.12
 for <linux-nvme@lists.infradead.org>; Thu, 07 Apr 2022 06:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=FYAt32anSHPyyV5iU/d1AJrW64tXears8hv3LonlPJs=;
 b=snlD5cSj9D3DsSqxUI9+Yiy/1Kq7pLodHEzDrmtF61PbbBRKS1N/JedkMlDjw2w/rE
 OwkblfdGf+iBl4HoaFJI3P5otV4cyH/HsvdC6KIiP0x+eGVJ5jqBQNCAcBi0Fg1dIjSQ
 2N4wOBCAyaf9Tvm/lwEdR7JVK5oZNDRe9/uFKTbBFTchgEiHxB+owSZydCzAq765Fl0+
 UbLPqsiJrASxf2ZNDoaXhft1bkROIVJi3YjePmOaKPrtyNcw7uauDzyowSsDplq4f7an
 jWNg1K9vILvnQifmEilIAtqtRmhVYVU7P0ek3TP7/LwPmWkasio7b7yuFiSw897HhOoY
 0hiw==
X-Gm-Message-State: AOAM532CKTlVcfx0tjk1k4RhBrY7iegSnbvDv5Kk7omVMExIbeXovJAl
 fhwWl4cSUlWz7/3O4VJCzWh+sXGeens=
X-Google-Smtp-Source: ABdhPJy+YV8Wdtew3PGwFKPKQzmJdmxHaYeLpuxa4kdxchMaK3pZgwRhYKglooYVardTV2oa4DZSOA==
X-Received: by 2002:a5d:648f:0:b0:204:14ed:13a5 with SMTP id
 o15-20020a5d648f000000b0020414ed13a5mr10735962wri.162.1649336686637; 
 Thu, 07 Apr 2022 06:04:46 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 b8-20020a05600c4e0800b0038c6c37efc3sm7479649wmq.12.2022.04.07.06.04.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Apr 2022 06:04:45 -0700 (PDT)
Message-ID: <129b9f99-fd4d-1920-dee8-652e774a3b57@grimberg.me>
Date: Thu, 7 Apr 2022 16:04:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme-tcp: handle failing req immediately for
 REQ_FAILFAST_DRIVER
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, Martin.Belanger@dell.com
References: <20220407092540.66227-1-dwagner@suse.de>
 <eef5eda6-f00f-b879-858f-80f7ce44a362@grimberg.me>
 <20220407122054.reywmgnysnhryvg2@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220407122054.reywmgnysnhryvg2@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_060451_253904_D1C34D8C 
X-CRM114-Status: GOOD (  16.78  )
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


>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 10fc45d95b86..f714d7ad38c0 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -1145,9 +1145,11 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>>>    	if (ret == -EAGAIN) {
>>>    		ret = 0;
>>>    	} else if (ret < 0) {
>>> +		struct request *rq = blk_mq_rq_from_pdu(queue->request);
>>>    		dev_err(queue->ctrl->ctrl.device,
>>>    			"failed to send request %d\n", ret);
>>> -		if (ret != -EPIPE && ret != -ECONNRESET)
>>> +		if ((ret != -EPIPE && ret != -ECONNRESET) ||
>>> +		    rq->cmd_flags & REQ_FAILFAST_DRIVER)
>>
>> I'm wandering if this will race with nvme_cancel_admin_tagset which
>> can also complete the command... The whole assumption is that the
>> cancel iterator will be running as the socket is shutdown by the peer
>> and error_recovery was triggered.
>>
>> I think these shouldn't race because we shutdown the queue (and flush
>> the io_work) and only then cancel. But I've seen races of that
>> sort in the past...
> 
> This particular request is issued by nvme_shutdown_ctrl() so we know
> exactly where we are. But this might not be the case for any other
> REQ_FAILFAST_DRIVER flagged request. So this might introduce the race
> you are pointing out.
> 
> The option is see is what Margin suggested in
> 
> http://lists.infradead.org/pipermail/linux-nvme/2021-September/027867.html

Don't know if I like the state check. Why this does not apply in a ctrl
reset?

