Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7D4C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 23:53:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1B964F97
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 23:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1B964F97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GTYQ3Ht3dQYftIQeT8wPkwdol9gPvVsvnuLk9w3r8Dg=; b=pHL9gngxW7oNJvOXgVPtFwVNT
	UnrnEUtlaQy/EpryiMuCtUvP4Y/IrAbPQ+bhu5nkjxua3JqIMHcAfo5piAfh2HUeHqawsar1KmwBd
	lUlfP3JJQinFxJ3ewY+31WuHrsI7ug/uk9XpqLcFxbw/qza/apELANPNh8VwCjvz2EJlQdcSfAeIM
	lkIVqJGTG20XS8AmNciOxNOzBKxd+DdqYHkthTxGjsDRN4e+v80C2bE+cBxdB6XGc3bjxArF40mML
	4BOKE+1o9AvoW19OSXpq6lZKycu1HFOwspzw8zyn3VIj4YXKykpdg1Skvvh7rj/5vY+2q8ThF6/qV
	v/K+SLhnw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMJUZ-0022Zo-B1; Tue, 16 Mar 2021 23:52:51 +0000
Received: from mail-pg1-f176.google.com ([209.85.215.176])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMJUT-0022Yj-V5
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 23:52:47 +0000
Received: by mail-pg1-f176.google.com with SMTP id w34so22623196pga.8
 for <linux-nvme@lists.infradead.org>; Tue, 16 Mar 2021 16:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xm92YMd17D40Qboaid6WwaKmL9fZwP4fdVVJ3jNzEXk=;
 b=LLHruWSawuCe7RxA9ErT/HNN8hqYoXDaUWN7D8LQlSJ+xkZSWKVxiza6SPcf79Zi8e
 FnTFFlrj75zik8K87kxTrhHXZ6xvU/2jSTX0kJ4yE8A7Fr3HF7nZfmCGNW3hRXnb8VV+
 hjQUx6zbOWbQTPe2CEYaNuM2fVQ8SB4oWaMfaKNDyuGRfQQgWs/t7rhVdQ/4SxwFE5NW
 /PZ2tYv2AepOfM+4OG+kgNpfcxo5+VyadthohcclBVzd1xKPDRmCfz0QhZDCSkVJNF7q
 R4kXEbIp31fetq6ZLgoZUoTHwXObrqBB9yTk7d+DGQvFylnsLtX5QtFlmqJc800PgDM3
 +pJA==
X-Gm-Message-State: AOAM532r/4AFh+4rq7YDDCYUNmf40JFpg8wImwxLMQC2c9f2itmiOn4A
 bitCUTRw1cX+7M9H1Hwlvio=
X-Google-Smtp-Source: ABdhPJz1sl+Ue6g+pcs08uGySu+S9OwEFasUFXaAqVoCmMulJra+stsVvddrkcymaI+memh2fPHnFA==
X-Received: by 2002:a63:ea4b:: with SMTP id l11mr192347pgk.61.1615938764598;
 Tue, 16 Mar 2021 16:52:44 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:52e4:89ef:d916:a3a6?
 ([2601:647:4802:9070:52e4:89ef:d916:a3a6])
 by smtp.gmail.com with ESMTPSA id s194sm17988916pfs.57.2021.03.16.16.52.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Mar 2021 16:52:44 -0700 (PDT)
Subject: Re: [PATCH] nvme-fabrics: fix crash for no IO queues
To: Keith Busch <kbusch@kernel.org>, James Smart <jsmart2021@gmail.com>
Cc: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 axboe@fb.com, hch@lst.de
References: <20210304005543.8005-1-lengchao@huawei.com>
 <020b9f27-459a-2b98-2e76-ebcc874c9c32@grimberg.me>
 <78c5e9f9-f5b8-b8e5-1c36-3a5803d4b047@huawei.com>
 <45d16780-79a0-c2e2-8e90-246dae0b3e23@grimberg.me>
 <aac125ec-561a-002d-7054-782ee450067e@huawei.com>
 <20210316020229.GA35099@C02WT3WMHTD6>
 <21bc3b62-967c-6cb2-c9f3-7da479aef554@grimberg.me>
 <63ed162c-77a7-105f-5f29-47fcd32f57cd@gmail.com>
 <20210316212559.GA4161557@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1d3924e6-9b85-f0f4-6360-e0a054c21ebe@grimberg.me>
Date: Tue, 16 Mar 2021 16:52:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210316212559.GA4161557@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_235246_197209_6A0FD916 
X-CRM114-Status: GOOD (  17.32  )
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


>>>>> Now we have 2 choice:
>>>>> 1.failed the connection when unable to set any I/O queues.
>>>>> 2.do not allow queue request when queue is not live.
>>>>
>>>> Okay, so there are different views on how to handles this. I
>>>> personally find
>>>> in-band administration for a misbehaving device is a good thing to
>>>> have, but I
>>>> won't 'nak' if the consensus from the people using this is for the
>>>> other way.
>>>
>>> While I understand that this can be useful, I've seen it do more harm
>>> than good. It is really puzzling to people when the controller state
>>> reflected is live (and even optimized) and no I/O is making progress for
>>> unknown reason. And logs are rarely accessed in these cases.
>>>
>>> I am also opting for failing it and rescheduling a reconnect.
>>
>> Agree with Sagi. We also hit this issue a long time ago and I made the same
>> change (commit 834d3710a093a) that Sagi is suggesting:  if the prior
>> controller instance had io queues, but the new/reconnected controller fails
>> to create io queues, then the controller create is failed and a reconnect is
>> scheduled.
> 
> Okay, fair enough.
> 
> One more question: if the controller is in such a bad way that it will
> never create IO queues without additional intervention, will this
> behavior have the driver schedule reconnect indefinitely?

Until either ctrl_loss_tmo expires or the user is tired of this
controller and manually disconnects.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
