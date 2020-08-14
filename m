Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65987C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 07:02:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CDB20708
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 07:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n5gfptDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CDB20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fn04j9z0BVN6IaxavWXRmN6BtMq3jgK0tZXyGgWzDnQ=; b=n5gfptDmyt6+QrMni2/nfMbrp
	8BovH7ryp+Z0TTihft27744ezRAgweIatq6DgUjwDygfdH5m6dyEQ7iRvLV3AVrHk5oNQjFXYc0FZ
	wEViJr6NSQQ9KJEJo0OVSfwoNkVgFpOty2FPoFWI+0FE8IZjWEzQQsQKEgfvwHG9PZk8YkfqN5hOK
	LgXkPwHa1eV+Bdvjgx1HaE9NAormnznisy2A+4TBPIwVeztIBbl/1Wcdc3s9pkUVjFsO3Owfm1vlW
	CxrDGfkj5+qBYamCkrCkOMXYxy7+rmsGEjTX4yAHFTTxOZIH9T2KXEGTjws9b9u0D+OGBGmJXDa5M
	rUXUstNlA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6Tjl-0007nt-7D; Fri, 14 Aug 2020 07:02:49 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6Tji-0007mf-Gd
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 07:02:48 +0000
Received: by mail-wr1-f41.google.com with SMTP id f12so7385892wru.13
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 00:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+ytoOyn3OrI2lGVFxmY4HgXuf5BgTgZI4BeBO5ABZrE=;
 b=EidSUlWOhofv0NbSpZ7QcsmRfqXKaW6x/RZHxHZqDvlJ09vHhllDztTVMjZBVn31ph
 PjAZ3WQfSJAdI+mcixVSIyqXsVD0XyS7TU5qrFiKcMt0VKS0YkZoiA8sJz9t4EW4MZOe
 HLgp3ByU86UZPgJOvOXlzwf6xt1/QO7YY96BG7P1OX6T8GXJMKvlYSxJ3b2Qw5wTVK6V
 HyriwQAiQZa09FgtaVgRf0CFa+gqLi7GMdFdr7/256I4NLOavinRCi8F7vD+yEyXF4Ff
 u0qQ7WqXeuYSKSadRtsHOREi55xi3Hz8QTTZEAeMxAtlzl6jrfVsvx4BTxCYHMJJlk1Z
 F8kA==
X-Gm-Message-State: AOAM5333p06NtO8Xs3i0B+5led0ehh5VWIADjrr4P8+gIKxBMRhtGc/h
 4YiV9ews8Y5/Bpzs/DUCOTA=
X-Google-Smtp-Source: ABdhPJwYqijp9QX7wIXUkWLCTJOejyUQdH0epva1BjXn3u3yZ8CT0jkomOJIJpcDXQoYokuCO2C0UQ==
X-Received: by 2002:adf:b302:: with SMTP id j2mr1368441wrd.294.1597388559816; 
 Fri, 14 Aug 2020 00:02:39 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f?
 ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id z8sm12425651wmf.10.2020.08.14.00.02.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 00:02:39 -0700 (PDT)
Subject: Re: [RESEND PATCH] nvme: explicitly use normal NVMe error handling
 when appropriate
To: Christoph Hellwig <hch@infradead.org>
References: <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
 <20200807045015.GA29737@redhat.com>
 <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
 <20200810143620.GA19127@redhat.com> <20200810172209.GA19535@redhat.com>
 <20200813144811.GA5452@redhat.com> <20200813153623.GA30905@infradead.org>
 <20200813174704.GA6137@redhat.com> <20200813184349.GA8191@infradead.org>
 <96aff2d0-5907-f5c9-9164-8fea0d030d95@grimberg.me>
 <20200814065559.GA29917@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9cced4a7-aafa-23c8-ad4b-d19e0b136585@grimberg.me>
Date: Fri, 14 Aug 2020 00:02:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814065559.GA29917@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_030246_578846_A8802F6E 
X-CRM114-Status: GOOD (  14.72  )
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
Cc: Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 dm-devel@redhat.com, Hannes Reinecke <hare@suse.de>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>, Ewan Milne <emilne@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> +	switch (nvme_req_disposition(req)) {
>>> +	case COMPLETE:
>>> +		nvme_complete_req(req);
>>
>> nvme_complete_rq calling nvme_complete_req... Maybe call it
>> __nvme_complete_rq instead?
> 
> That's what I had first, but it felt so strangely out of place next
> to the other nvme_*_req calls..
> 
> Maybe nvme_complete_rq needs to be renamed - what about nvme_req_done?

I'd suggest to call nvme_complete_rq nvme_end_rq because it really calls
blk_mq_end_request. That would confuse with nvme_end_request which
calls blk_mq_complete_request... Maybe we need some naming improvements
throughout.

>> Maybe call nvme_req_disposition again locally here to not carry
>> the is_ana_status. But not a biggy..
> 
> That means it would have to become non-static in scope, limiting
> inlining possibilities, etc.

I see.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
