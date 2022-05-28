Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6137EC433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 28 May 2022 19:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B9GIccXQ3NoEdoL+6p/0Pu0IeKbfV0Y1AR2ygTcEouQ=; b=RxEmBIdTwkOaffDYtTymMbqzR4
	iKAnr3KUI6KQYsSyJiFBaU9B+Q5Eyw8OhSybMOYhXqSY08l5mt6OdHZBhbW7GWC8Ic5VOm3pxa6Hz
	KW1I7Q0gdNgEh3Y+5FDjNH+96/3/ZoaLlM1tSJsnWWhWystrEwiD63TVNfi4JumSHDyGcLq0hOFWT
	vx/gKZoKxww5G1v0i93pKFFcrPkoce0QzmwxAbMEXaZXT85qr1DYtWaQ7HGc7lf7e6OQKo+2HKkNz
	CgAnpstyAuk4gksx/QaVUon8WCFHsE+l239EdN5rMNY2nPyyCna/QUojKdZa0UNzBKFSE8UsRjIU7
	chYD2xNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nv1gG-002aad-FH; Sat, 28 May 2022 19:00:56 +0000
Received: from mail-pf1-f172.google.com ([209.85.210.172])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nv1gB-002aX3-9t
	for linux-nvme@lists.infradead.org; Sat, 28 May 2022 19:00:54 +0000
Received: by mail-pf1-f172.google.com with SMTP id y189so7093241pfy.10
        for <linux-nvme@lists.infradead.org>; Sat, 28 May 2022 12:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B9GIccXQ3NoEdoL+6p/0Pu0IeKbfV0Y1AR2ygTcEouQ=;
        b=yM8oX3RQNrE7UCS7qxNs2+/dyVayz2nwvmiUw3bDQehy1OrZSA0hz0ox2zeKBVAVQp
         mzH9eDuQ8RWQvoPXxw6zGf4jeID3RXBQbIQlb4nH5WLjuSP9gDDCN0/6HRFbHdf6jHXF
         gur/CT/nLJt4yphIuR1STYVvEStpnZdwfjNJdHhAfivwSuswQ2C6kHuDcYye0n3ms3yR
         3une7Ngsk+7Ldo7iCX2g/7h386TiXIirLI1lLPwBncLErO8sRDt80Xuh7XkM7DAvtWcf
         M/yxqXr3YikQJOqj05d7jRveNXY/GvfEjncKx7bq8SZqJXYzB3rWBf15dhxi7rKwqdoc
         ay6Q==
X-Gm-Message-State: AOAM533/UpHxdReKUi75w0Sjy2pMcxftUR1PjcguP+Bbgojqu8+yn7kN
	j6kCVCKTWdSf1Gw0GsTlZd43HazxqC+n0ajJ
X-Google-Smtp-Source: ABdhPJwXJzyj98WMQZaBVyD+ZcuJ4zRI8MI/I1iLRqaCQGUqcYYWmvKFaCN/xFK5A4Ii5l8f8C/FCA==
X-Received: by 2002:a05:6a00:24cc:b0:50d:58bf:5104 with SMTP id d12-20020a056a0024cc00b0050d58bf5104mr49566653pfv.36.1653764446126;
        Sat, 28 May 2022 12:00:46 -0700 (PDT)
Received: from [172.19.249.174] ([205.220.129.27])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902e88900b0016362da9a03sm5934765plg.245.2022.05.28.12.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 12:00:45 -0700 (PDT)
Message-ID: <4d65a168-c701-6ffa-45b9-858ddcabbbda@acm.org>
Date: Sat, 28 May 2022 21:00:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
 RDMA mailing list <linux-rdma@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
 <20220527125229.GC2960187@ziepe.ca>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220527125229.GC2960187@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220528_120051_394756_85F6480B 
X-CRM114-Status: GOOD (  19.03  )
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

On 5/27/22 14:52, Jason Gunthorpe wrote:
> On Wed, May 25, 2022 at 08:50:52PM +0200, Bart Van Assche wrote:
>> On 5/25/22 13:01, Sagi Grimberg wrote:
>>> iirc this was reported before, based on my analysis lockdep is giving
>>> a false alarm here. The reason is that the id_priv->handler_mutex cannot
>>> be the same for both cm_id that is handling the connect and the cm_id
>>> that is handling the rdma_destroy_id because rdma_destroy_id call
>>> is always called on a already disconnected cm_id, so this deadlock
>>> lockdep is complaining about cannot happen.
>>>
>>> I'm not sure how to settle this.
>>
>> If the above is correct, using lockdep_register_key() for
>> id_priv->handler_mutex instead of a static key should make the lockdep false
>> positive disappear.
> 
> That only works if you can detect actual different lock classes during
> lock creation. It doesn't seem applicable in this case.

Why doesn't it seem applicable in this case? The default behavior of 
mutex_init() and related initialization functions is to create one lock 
class per synchronization object initialization caller. 
lockdep_register_key() can be used to create one lock class per 
synchronization object instance. I introduced lockdep_register_key() 
myself a few years ago.

After having taken a closer look at the RDMA/CM code, I decided not yet 
to implement what I proposed above. I noticed that handler_mutex is held 
around callback invocations. An example:

static int cma_cm_event_handler(struct rdma_id_private *id_priv,
				struct rdma_cm_event *event)
{
	int ret;

	lockdep_assert_held(&id_priv->handler_mutex);

	trace_cm_event_handler(id_priv, event);
	ret = id_priv->id.event_handler(&id_priv->id, event);
	trace_cm_event_done(id_priv, event, ret);
	return ret;
}

My opinion is that holding *any* lock around the invocation of a 
callback function is an antipattern, in other words, something that 
never should be done. John Ousterhout already described this in 1996 in 
his presentation [1]. Patches like 071ba4cc559d ("RDMA: Add 
rdma_connect_locked()") work around this problem but do not solve it.

Has it been considered to rework the RDMA/CM such that no locks are held 
around the invocation of callback functions like the event_handler 
callback? There are other mechanisms to report events from one software 
layer (RDMA/CM) to a higher software layer (ULP), e.g. a linked list 
with event information. The RDMA/CM could queue events onto that list 
and the ULP can dequeue events from that list.

Thanks,

Bart.

[1] Ousterhout, John. "Why threads are a bad idea (for most purposes)." 
In Presentation given at the 1996 Usenix Annual Technical Conference, 
vol. 5. 1996.

