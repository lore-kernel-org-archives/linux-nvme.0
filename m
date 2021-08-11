Return-Path: <SRS0=LdLJ=NC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA93C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 01:01:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE4DE60249
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 01:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE4DE60249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SL9xHJV/HK9d0DprGmHzj2o0Yx3Y1PTdA8UqYbMuI88=; b=ZBfIsQaPSHqOvdBrXq9r0pJqJ6
	kf+I8yAwK98DkUmRuPlzbAvmr0eZk5KUAS1XshPYc0eZ4lxsGMb1cHjnMa1/W0NDKVMngXKqX8ru/
	Wt6EkdbG8Cgsr2pVIZFGKzNrpstNr16k8SrZrrbST/aglF/lGkE6MhREXWxG0RdJlhCM3g2izc6gM
	210Wyjc75pM+KZwnskDzX39PTLH5Eb0+oUcO5KuxnZvhe4XxCfpLxTwtrwD83qovYVqpglMIU79MK
	4lYii8EYB61B0ay+wyp1KSDjFMedY1U2MhhoySnkLTzVVMyWIV/8G2w+Ce+8z5T7pxVUf5acT3NBC
	BeFsXulw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDcbt-0057h8-FI; Wed, 11 Aug 2021 01:00:45 +0000
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDcbq-0057gY-I1
 for linux-nvme@lists.infradead.org; Wed, 11 Aug 2021 01:00:44 +0000
Received: by mail-pl1-f169.google.com with SMTP id e19so431541pla.10
 for <linux-nvme@lists.infradead.org>; Tue, 10 Aug 2021 18:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c6CO0pA6pVLFZ/vFVu8X+97qV7Slk2RpoxD9Zf89GuU=;
 b=ONj0llWmgJx8lOs2F0aSzuIZGxh7o4U0LflY7KkpvWGJJcxcRd2pasmV0etswYnjVp
 pcVKkYa35OBsTezJPoQ0ckzsRdXI2TZOv5nLgJTyOkQIMcoVSuSgq/vFA6oicXYzOpyH
 vmuGdmexZ9WaoYFizZ8GNj7BgJS2nJ9Ta2kKx9hLiwaJwk6FwCQLc2MZwSQmZH1ehodt
 IRgSMn9y3E5Zq+oTpvUjAZl/ce4B9sdPG/+okb7HmN5PXqZTggEo5KIGz5eTG4qw4JOY
 dEzhjqL/moPmJpwj+pLPw2beUb7Hct4in5ocbqINjg9LV0uFxbUoSWbaEKxqIIy80GA3
 Mi3Q==
X-Gm-Message-State: AOAM532O8AJTOUSPET9RnsrxnP4IB+S7ymgo1KM/d5eyA9/fPxzuNH4J
 o76g2SSZenYJ9uagifZ2zUQ=
X-Google-Smtp-Source: ABdhPJxFM5vHQM4W76wTi3b9DPvuMjuqvtkdWYYDU8gJzO4fUKIw/K01uqYv+0HNgfRX4ANvnaKK1w==
X-Received: by 2002:a17:90b:215:: with SMTP id
 fy21mr33666018pjb.203.1628643640011; 
 Tue, 10 Aug 2021 18:00:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:61e5:4b9f:b48a:e987?
 ([2601:647:4802:9070:61e5:4b9f:b48a:e987])
 by smtp.gmail.com with ESMTPSA id y67sm25244197pfg.218.2021.08.10.18.00.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Aug 2021 18:00:39 -0700 (PDT)
Subject: Re: [PATCH v4 2/8] nvme-tcp: Update number of hardware queues before
 using them
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
 Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-3-dwagner@suse.de>
 <8373c07f-f5df-1ec6-9fda-d0262fc1b377@grimberg.me>
 <20210809085250.xguvx5qiv2gxcoqk@carbon>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <01d7878c-e396-1d6b-c383-8739ca0b3d11@grimberg.me>
Date: Tue, 10 Aug 2021 18:00:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809085250.xguvx5qiv2gxcoqk@carbon>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210810_180042_698231_6BA0141E 
X-CRM114-Status: GOOD (  27.82  )
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



On 8/9/21 1:52 AM, Daniel Wagner wrote:
> Hi Sagi,
> 
> On Fri, Aug 06, 2021 at 12:57:17PM -0700, Sagi Grimberg wrote:
>>> -	ret = nvme_tcp_start_io_queues(ctrl);
>>> -	if (ret)
>>> -		goto out_cleanup_connect_q;
>>> -
>>> -	if (!new) {
>>> -		nvme_start_queues(ctrl);
>>> +	} else if (prior_q_cnt != ctrl->queue_count) {
>>
>> So if the queue count did not change we don't wait to make sure
>> the queue g_usage_counter ref made it to zero? What guarantees that it
>> did?
> 
> Hmm, good point. we should always call nvme_wait_freeze_timeout()
> for !new queues. Is this what you are implying?

I think we should always wait for the freeze to complete.

> 
> 
>>>    		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
>>>    			/*
>>>    			 * If we timed out waiting for freeze we are likely to
>>> @@ -1828,6 +1822,10 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>>>    		nvme_unfreeze(ctrl);
>>>    	}
>>> +	ret = nvme_tcp_start_io_queues(ctrl);
>>> +	if (ret)
>>> +		goto out_cleanup_connect_q;
>>> +
>>
>> Did you test this with both heavy I/O, reset loop and ifdown/ifup
>> loop?
> 
> Not sure if this classifies as heavy I/O (on 80 CPU machine)
> 
> fio --rw=readwrite --name=test --filename=/dev/nvme16n1 --size=50M \
>      --direct=1 --bs=4k --numjobs=40 --group_reporting --runtime=4h \
>      --time_based
> 
> and then I installed iptables rules to block the traffic on the
> controller side. With this test it is pretty easily to get
> the host hanging. Let me know what test you would like to see
> from me. I am glad to try to get them running.

Lets add iodepth=128

>> If we unquiesce and unfreeze before we start the queues the pending I/Os
>> may resume before the connect and not allow the connect to make forward
>> progress.
> 
> So the unfreeze should happen after the connect call? What about the
> newly created queues? Do they not suffer from the same problem? Isn't
> the NVME_TCP_Q_LIVE flag not enough?

Q_LIVE will protect against the transport itself from queueing, however
when multipath is not used, the transport will return BLK_STS_RESOURCE
which will immediately trigger re-submission, in an endless loop, and
that can prevent forward progress. It is also consistent with what 
nvme-pci does.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
