Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77194ECAAD4
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 07:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9/H5Qvlrgl/HUILsfJOcnJpXdTRDk86RdJ/hKBMTRF4=; b=NCKRK/gQDS1O5PRjyHZ0Dj/9uZ
	XXhOMh9mlmAQSj5JJJ4vMSBU0Tvqy6xkkBp6dk3rrIOSD2qq4jBuYks5QCcVA4ndkPVxRYRUz3W+p
	paNA5q937Q93X9LIcDNAQ/Hbqv7v6vBpYEAC/Ubh8xFtkBugJ/QCZq8qmzQ3IbcDCOz3LvgA82X/w
	5/APVKhOpsxG6Of1qyJawj8NzKGWdf1etLRqN3Iy5HhSA38OTU9KC52D+YDErrnOOg/HeYIRwiazu
	rMgUuA/6YOauA46Oeos/jmaGo54Scl+da6yYFYegIXftQz4hUTAEAST4Qij0nA3o31rGYKEijTchD
	xy+GJ8Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSwA6-00Ezg1-LE; Tue, 30 Aug 2022 07:59:54 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSw87-00Eyeh-5Q
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 07:57:52 +0000
Received: by mail-wr1-f52.google.com with SMTP id c7so6382700wrp.11
        for <linux-nvme@lists.infradead.org>; Tue, 30 Aug 2022 00:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=9/H5Qvlrgl/HUILsfJOcnJpXdTRDk86RdJ/hKBMTRF4=;
        b=yu4S1HnhgLKC8kWoNAsjX0cLoPM9nPbcKeo1ETjoLdiQfOZC5/ANUfdgpEyc2P7Pmx
         uuuifyWxqZnAABD2/EYrWdlGm8VKoU38dSzETrarcNCBjeudPz4193CQsSbPekT6cED6
         YsXwskxCbiBgCC+j9FXGaLjoErYHqpSN2/simeO/yaoqkjMjfeVo5u0knmPRGkSSQyNI
         6FimsrikUQW7E2xXeDlzZI6f9IsknlyqV2RVsPxY+9bWEtYmageYCAMBa0nA6tdrGZ1T
         id+zOdeoVlwG0HwJzWfKN5A2N94+RlfIOIgYtvvcpv9OYKNkx9yPOh6oJ2gxX7mzMVsY
         ODNg==
X-Gm-Message-State: ACgBeo1+S6pxchpDjKeldcO/hKyQe5F8i1b3Ig+paw78Cnl1IBun39Pu
	jfG9gHjG0fGk0KjEaS5ANnd6nJImGM0=
X-Google-Smtp-Source: AA6agR5uQlkqD9PGmB+Qo6TOZkpLdxgApRf8WDPyIQRHoozq/U2f7dRGMKM/b28iFKXDyK8qubhd5g==
X-Received: by 2002:a5d:6b10:0:b0:21e:4bbd:e893 with SMTP id v16-20020a5d6b10000000b0021e4bbde893mr8242920wrw.613.1661846268362;
        Tue, 30 Aug 2022 00:57:48 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id a12-20020a05600c348c00b003a5bd5ea215sm12063996wmq.37.2022.08.30.00.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:57:47 -0700 (PDT)
Message-ID: <0779654e-3945-ad08-a18a-1c195b8dfbe0@grimberg.me>
Date: Tue, 30 Aug 2022 10:57:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/3] Handle number of queue changes
Content-Language: en-US
To: James Smart <jsmart2021@gmail.com>, Hannes Reinecke <hare@suse.de>,
 Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: Chao Leng <lengchao@huawei.com>
References: <20220829083856.1850-1-dwagner@suse.de>
 <f8ee0fd3-45c2-7848-aa5a-6627c7672349@suse.de>
 <c5af9904-48f2-93b8-404a-4dc23c63b7c7@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c5af9904-48f2-93b8-404a-4dc23c63b7c7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_005751_261378_A7441862 
X-CRM114-Status: GOOD (  22.45  )
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


>>> Updated this series to a proper patch series with Hannes and Sagi's
>>> feedback addressed.
>>>
>>> I tested this with nvme-tcp but due to lack of hardware the nvme-rdma
>>> is only compile tested.
>>>
>>
>> One does wonder: what about FC?
>> Does it suffer from the same problems?
>>
>> Cheers,
>>
>> Hannes
> 
> 
> Yep, wondering too. I don't think so... FC does do this differently.
> 
> We don't realloc io queues nor tag_sets.  We reuse the allocations and 
> tag_set originally created in the 1st successful association for the 
> controller.
> 
> On reconnect, we set the queue count, then call 
> blk_mq_update_nr_hw_queues() if it changed before we get into the loops 
> to change queue states.

That is the same as tcp/rdma. We don't realloc tagsets or queues, we
just reinitialize the queues based on the queue_count.

> So FC's call to update nr_hw_queues() is much earlier than rdma/tcp today.

The only difference is that you don't freeze the request queues when
tearing down the controller, so you can allocate/start all the queues in
one go.

In pci/rdma/tcp, we start by freezing the request queues to address a 
hang that happens with multiple queue-maps (default/read/poll).
See 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic").

I don't think that fc supports multiple queue maps, but in case the
number of queue changes, blk_mq_update_nr_hw_queues() will still attempt
to freeze the request queues, which may lead to a hang if some requests
may not be able to complete (because the queues are quiesced at this
time). However, I see that fc starts the queues in the end of
nvme_fc_delete_association (which is a bit strange because the same can
be achieved by passing start_queues=true to
__nvme_fc_abort_outstanding_ios.

But that is the main difference, tcp/rdma does not start the queues when
tearing down a controller in a reset, only after we re-establish the 
queues. I think this was needed to support a non-mpath configurations,
where IOs do not failover. Maybe that is a legacy thing now for fabrics 
though...

