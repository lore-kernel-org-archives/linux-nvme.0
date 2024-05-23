Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4501C25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 10:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ebL6HaU3GdxWXH9bjbvtlMoHiAW2gcv2Q5qh8IlHrEA=; b=bMDHLKmu9fku699iKOKWt6QAp6
	7Yuka+QAXCQ4/2shyFCNx7+p08mujqScJufwCOYwrR/pRLQLsP5jY2EZpxLgoFTBa2velOcdATFNZ
	9yduV1qwlniWHvzCKf5VjdbCAIM9r565uQ0VcrlV2Jeaw6P1lwx8G5TmtaQ8fU555rOV7nruVKhQt
	DvWJFSK/5yz9jn/IoMnB88b0m4O+zw10e2uXXRs6jrF9jwptO9C/gZiX4JVQEu7JNvVK2ugFnhFzO
	o2UvzF7v6Hi6VXV1tuCCW1SathRbLvZIjaX8XLc58719bcb25NbRyGkEQWyBnN4RiGp7zkVoyMjMA
	Q94CpLeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA5HH-00000005nAP-1opa;
	Thu, 23 May 2024 10:02:27 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA5HD-00000005n7t-1MIQ
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 10:02:25 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3550266e90eso7182f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 23 May 2024 03:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716458540; x=1717063340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebL6HaU3GdxWXH9bjbvtlMoHiAW2gcv2Q5qh8IlHrEA=;
        b=a9qZAzltGaxSheYOwTHSN9t74r7Fp4XDaw6EBTaPx9HXgPA/tIoH0HdMfU1meaQGLq
         1F+S16G7gRT9pQVIhIcDFxtJiKsBoEAL+kstN6LIq3P8sCoSj0JPcu4vzlM9GcC9yip2
         WridH9HPuTF8UFwAc0lqn9G3X4amQEwbV3Qr8uU3G/QhL+fB6uhPE0Cme3nf3gBKnJfu
         T2e05Y+w8WXhzKNv2kk3uGOAwJNaSj3kkhYKEJXXj2Bvg0MQcKj0/6RglBnvO+V9lNce
         I1Mwqgwkavf74+zPQhs2wxbD3p1ffB+f1dlWK417E1/0F9DpgGxGdq6EQLGjLd7jJy1K
         eO6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDXRMp4KvYEQpi28L2kdEVGCQMvTXKLwkit2yKdGo1QeeoC2fcHomlcG+Le63MEvnx69gFvM7vuZQMfCW5itkIsA6dDYw1YYW5IuxBWvQ=
X-Gm-Message-State: AOJu0Yzu0IVnFuCjhK9ByiXIXxiX6cqxKM4ePES7dud1Y/CsJEh0gRYj
	jkiffWtKyuVMzzDPiBJWmITR354jUVhyJ3An2LbKnHP77HE1KDJW
X-Google-Smtp-Source: AGHT+IEuPcJDhy4s0Z/XTpgJp2o0aJtzN8RJVfHN0aiN+ZRZkNrh2QTMcFExpfcK3hpmzdL57q6Nlg==
X-Received: by 2002:a5d:46ca:0:b0:354:fa0d:1421 with SMTP id ffacd0b85a97d-354fa0d15d9mr828698f8f.1.1716458540286;
        Thu, 23 May 2024 03:02:20 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354f5e593dasm1702399f8f.109.2024.05.23.03.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 03:02:20 -0700 (PDT)
Message-ID: <98c860ce-57ca-4451-a4fa-1af93834e8f5@grimberg.me>
Date: Thu, 23 May 2024 13:02:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Keith Busch <kbusch@kernel.org>, John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, emilne@redhat.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, jrani@purestorage.com, randyj@purestorage.com,
 hare@kernel.org
References: <20240522154212.643572-1-jmeneghi@redhat.com>
 <20240522154212.643572-2-jmeneghi@redhat.com>
 <Zk4VtiCjeqkBKCBA@kbusch-mbp.dhcp.thefacebook.com>
 <cef5a764-ffab-495c-bea2-e4c6a7c76944@redhat.com>
 <Zk4ddPmottdOJND1@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Zk4ddPmottdOJND1@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_030223_401168_D3484354 
X-CRM114-Status: GOOD (  20.31  )
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



On 22/05/2024 19:29, Keith Busch wrote:
> On Wed, May 22, 2024 at 12:23:51PM -0400, John Meneghini wrote:
>> On 5/22/24 11:56, Keith Busch wrote:
>>> On Wed, May 22, 2024 at 11:42:12AM -0400, John Meneghini wrote:
>>>> +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
>>>> +{
>>>> +	struct nvme_ctrl *ctrl;
>>>> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
>>>> +
>>>> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
>>>> +
>>>> +	/* iopolicy changes reset the counters and clear the mpath by design */
>>>> +	mutex_lock(&nvme_subsystems_lock);
>>>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>>>> +		atomic_set(&ctrl->nr_active, 0);
>>> Can you me understand why this is a desirable feature? Unless you
>>> quiesce everything at some point, you'll always have more unaccounted
>>> requests on whichever path has higher latency. That sounds like it
>>> defeats the goals of this io policy.
>> This is true. And as a matter of practice I never change the IO policy when IOs are in flight.  I always stop the IO first.
>> But we can't stop any user from changing the IO policy again and again.  So I'm not sure what to do.
>>
>> If you'd like I add the 'if (old_iopolicy == iopolicy) return;' here, but
>> that's not going to solve the problem of inaccurate counters when users
>> start flipping io policies around. with IO inflight. There is no
>> synchronization between io submission across controllers and changing the
>> policy so I expect changing between round-robin and queue-depth with IO
>> inflight suffers from the same problem... though not as badly.
>>
>> I'd rather take this patch now and figure out how to fix the problem with
>> another patch in the future.  Maybe we can check the io stats and refuse to
>> change the policy of they are not zero....
> The idea of tagging the nvme_req()->flags on submission means the
> completion handling the nr_active counter is symmetric with the
> submission side: you don't ever need to reset nr_active because
> everything is accounted for.

Agree. We should probably remove it from the patch.

