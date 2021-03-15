Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730E5C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:09:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F018661494
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F018661494
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PDWt7HTA8ieBol/lW8zJ6a9YMeLZcioh3conM8w1vmM=; b=K9hh/XfzEzkciQLgq4I2OP8eO
	0PV3nFlTAYlSRYoxBKO3hoZq/93rKa/Hwxpv9Nazvq0k4flehSYfb9OahYsp6J8rpUNwwl6fYQP3f
	MZhHI6jRpZXHtdfFJnCBwgEGhtdX+sDkUG+vGbr88PabkdED92bD61Lc8oU6ibAe3ZIvvzUuspzdp
	wXQDZwqp+P0tDAfaStwP8lAMU5+IyF/qSR6TMa8fUYiWVu2rU3KAvxISWmdZgPj2fzzA7uWip9wFq
	AQcBHIJY2q/8w2VSt9QuIjq+YHb/FsQHV8r3iV9MiYurHfE5Mei0zI1/P6JcKavMn4VCWE3FI27vP
	VQ1dsN/dg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLqiQ-00GStP-5C; Mon, 15 Mar 2021 17:09:14 +0000
Received: from mail-pg1-f173.google.com ([209.85.215.173])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLqiH-00GSqu-Fk
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 17:09:09 +0000
Received: by mail-pg1-f173.google.com with SMTP id 205so3852528pgh.9
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 10:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EBls5YWDLbGVxadDWyRyp/hrNgBPjG/DfY5JldYkz2k=;
 b=Cu87DaogQtC+hW7CYzqehtT9BE2gVt4eesdNkt1dIzJkf1HnT6pY/txYbktvTa4cL4
 aSwU4aXagCarcOkqEhqYC0mzWhv/yQdp24YnDQV4MxUGp4Ejgc8QYpC0eptw4pAfuF66
 vcUEZxQkqSC6R3TvWB7BbCuPAHtfRTALcQXtVBvvnz43ycJ44z2drqh7NSHovObDoHgb
 woS0xb1CjNAptDfKFGcnBweFSJdCNDqNLRcRlhc9iTU+RSST+cR3FZtvMhZlqpqW5TVJ
 +kKjPJgV274V4myWM/H7jL3rYpv6u4KqqqreQ1sGWQ4H3wZNveMR5iZ30pXbZASYdx3t
 QeMQ==
X-Gm-Message-State: AOAM5308rsI4+3WZr/9TrOR/jpuobeNuVA2qttR75jn7yfqpchmV0Ho+
 b4cUelFucgA/SFtiN3b0G0U=
X-Google-Smtp-Source: ABdhPJwxajnwPrRrAVsm5gx2DrJFeVTqzkrvEm2OI/0tt+89CoM/Yyiu7j9ZOaE8zGh/gafZeXfqlQ==
X-Received: by 2002:a63:48a:: with SMTP id 132mr119198pge.366.1615828140586;
 Mon, 15 Mar 2021 10:09:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86?
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id j35sm14663758pgj.45.2021.03.15.10.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 10:09:00 -0700 (PDT)
Subject: Re: [PATCH] nvme-fabrics: fix crash for no IO queues
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
References: <20210304005543.8005-1-lengchao@huawei.com>
 <020b9f27-459a-2b98-2e76-ebcc874c9c32@grimberg.me>
 <78c5e9f9-f5b8-b8e5-1c36-3a5803d4b047@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <45d16780-79a0-c2e2-8e90-246dae0b3e23@grimberg.me>
Date: Mon, 15 Mar 2021 10:08:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <78c5e9f9-f5b8-b8e5-1c36-3a5803d4b047@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_170906_137590_DA3885FF 
X-CRM114-Status: GOOD (  16.15  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> A crash happens when set feature(NVME_FEAT_NUM_QUEUES) timeout in nvme
>>> over rdma(roce) reconnection, the reason is use the queue which is not
>>> alloced.
>>>
>>> If queue is not live, should not allow queue request.
>>
>> Can you describe exactly the scenario here? What is the state
>> here? LIVE? or DELETING?
> If seting feature(NVME_FEAT_NUM_QUEUES) failed due to time out or
> the target return 0 io queues, nvme_set_queue_count will return 0,
> and then reconnection will continue and success. The state of controller
> is LIVE. The request will continue to deliver by call ->queue_rq(),
> and then crash happens.

Thinking about this again, we should absolutely fail the reconnection
when we are unable to set any I/O queues, it is just wrong to
keep this controller alive...

This should be fixed for both rdma and tcp.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
