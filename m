Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16814C35FFC
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Mar 2025 12:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pW4CgvyO8E8d5aodvOYqRFyiScdqSUa2dn7Pkrdkp8Y=; b=DIO3hyTLkNgHic2AVTnMrFf/k0
	9sct2jS0oK/525oa3VEmYR7c6qyPXn2T7FAFOSJMNp3s6irkjMt5wc1LBopXqNX5XR+8SNBmBBkcT
	BXEMKLYbrzRHMLexvacllZHs+XyEVapbdVDk29p9vKmNiEqmKhCAayYnOHQ+W3pWaShLIEGawFoH8
	lpPnosoDDhFvImHvOR411KinGBaCTxFtmCI4K8kdP7NZhTECxd8LhoSjf+BDO6oBQkXZu5FHgiM/E
	d56sXKYr7USqf56wSqZDCD/nnqln41DZCTekxE3gx3c8FU73Z7JOqnBiZiC7uZ4S9PqE/Jc0VNFkK
	tv8wbPpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvy1a-0000000HOyu-0qUY;
	Sat, 22 Mar 2025 12:32:26 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvy1X-0000000HOyU-2dh8
	for linux-nvme@lists.infradead.org;
	Sat, 22 Mar 2025 12:32:24 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5e4d50ed90aso4008787a12.0
        for <linux-nvme@lists.infradead.org>; Sat, 22 Mar 2025 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742646742; x=1743251542; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pW4CgvyO8E8d5aodvOYqRFyiScdqSUa2dn7Pkrdkp8Y=;
        b=HXu8QEq2T41Cg7M9kHYtsZOnNTbTMnbk9PltFmKUkuYC8KjrhHMwXpj/YOvObgY6yZ
         dBp7RGtQhk7BsL9lnzvr4895bwaWkCKB0xeyYl2MmVRlnbVh8lZxWegVjvjnDo0CC+HR
         PS9Q2YKrmHXLP1dtcs3iZA8ftwmJs+ROZqxsW4xhULUI5L5KdoM5AicbjOacuf9aUc0T
         w8IAVOzNtVkyt0U8nLCf7O/wz8VrrvUnzLhnwE9cnzmLYEiiPhgL1+IXMYGxgAclqHTc
         nSUBiRLkkyElwygmK00SE02AcWB1jMBC+LAW0ko3/Hoz7/SxuhsjmI8zuW24BfrAIiQS
         pP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742646742; x=1743251542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pW4CgvyO8E8d5aodvOYqRFyiScdqSUa2dn7Pkrdkp8Y=;
        b=LBvzrTnxf49C9Prz9E+l+6lP9Ny1V/6pYqxk4Ki8FkUYHt5VCeMqtP5EwnX7pBtTgJ
         SHdN36KduLbssT6b5dxYtp4V/qupWAFLWSgSJRMvkMiYf1kIGOlcjVtjl4HcAI6HOQ+a
         7RyX3JfRdu2pRfZIH+veYlllsaCsXcDARw0Qr/oQ8qC2BFJ6rd8VVbp23B5MD8XWBJb2
         aHqDU/SeLwe5sN3hvk2rMJ2HScoV96go3NdfrJBML0dYnBzq31/sK4s7GuMcyrSBcZpC
         gZ8dO+3ZskT6bYlNZe8N3KZaYqBaW+gp/JuRlR71aNhUZO1zHcr48N61ubScrns6iSda
         kHCg==
X-Forwarded-Encrypted: i=1; AJvYcCVWLNMvsH6QqHkaIwG0Nof+r+Vegn+nZ9bHLaai0ZCOVtcs6t4Ez4I+U3LL4TbW0C0yjnGPevYD30y7@lists.infradead.org
X-Gm-Message-State: AOJu0Yyhu7XAlI5O3onGdLeO2iVHEKxVrJc/idlBy8ylUw3JYyVwjdUw
	76g/qvv12OvUCSe0+e61JaVyYRcOvSYhKN23j6r96kdu6v8hy7jK
X-Gm-Gg: ASbGnctThLAFA4flE8be0qG2UJbcxTrhdYnZhgDQ7crEVOCm+HH62t7JCUvRpelNPFh
	K1VSz5qo4A3s8GBUmsfDqEWMvuwOCHfHCOFzmrZ8C1cDfC41ZfBUCVAvQ+HYV41j0s49uEv5mlB
	kf8U2LTyk3mUYtsmagFJ5yzwUKACRXbEfAzYQvzuVRz8wd2cyYVKnF6ESb9OnYtWVGRZg7tAFMK
	6aORiZUUcl8pXXTmnQ6stz8/EubzQ68m6xbQnex8PhRQBdPy5K2LQvnRxgGfJAa7DVkDYz9IKQp
	wgoz7pz8wLKIcRtWY7Le4uyfGJ+RwnOUtFvSZgus/Lzeaydn+UFw
X-Google-Smtp-Source: AGHT+IHJAD6ahRLJfliFILL9MhKgl55JdXEMg4d/m5h9z2bwL6EhEJ1WElQ80YTk2VaHYjmxB8orNg==
X-Received: by 2002:a05:6402:270d:b0:5e6:17fb:d3c6 with SMTP id 4fb4d7f45d1cf-5ebcd4f3827mr5389659a12.25.1742646741523;
        Sat, 22 Mar 2025 05:32:21 -0700 (PDT)
Received: from [192.168.8.100] ([85.255.234.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0dfdcesm2999752a12.65.2025.03.22.05.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 05:32:19 -0700 (PDT)
Message-ID: <814281f1-3b8c-4cb8-943b-0edb818168dd@gmail.com>
Date: Sat, 22 Mar 2025 12:33:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Consistently look up fixed buffers before going async
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Xinyu Zhang <xizhang@purestorage.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250321184819.3847386-1-csander@purestorage.com>
 <5588f0fe-c7dc-457f-853a-8687bddd2d36@gmail.com>
 <CADUfDZo5qKymN515sFKma1Eua0bUxThM5yr_LeQHR=ahQuS_wg@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CADUfDZo5qKymN515sFKma1Eua0bUxThM5yr_LeQHR=ahQuS_wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250322_053223_669482_D5389BB0 
X-CRM114-Status: GOOD (  34.24  )
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

On 3/21/25 21:24, Caleb Sander Mateos wrote:
> On Fri, Mar 21, 2025 at 1:23 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 3/21/25 18:48, Caleb Sander Mateos wrote:
>>> To use ublk zero copy, an application submits a sequence of io_uring
>>> operations:
>>> (1) Register a ublk request's buffer into the fixed buffer table
>>> (2) Use the fixed buffer in some I/O operation
>>> (3) Unregister the buffer from the fixed buffer table
>>>
>>> The ordering of these operations is critical; if the fixed buffer lookup
>>> occurs before the register or after the unregister operation, the I/O
>>> will fail with EFAULT or even corrupt a different ublk request's buffer.
>>> It is possible to guarantee the correct order by linking the operations,
>>> but that adds overhead and doesn't allow multiple I/O operations to
>>> execute in parallel using the same ublk request's buffer. Ideally, the
>>> application could just submit the register, I/O, and unregister SQEs in
>>> the desired order without links and io_uring would ensure the ordering.
>>> This mostly works, leveraging the fact that each io_uring SQE is prepped
>>> and issued non-blocking in order (barring link, drain, and force-async
>>> flags). But it requires the fixed buffer lookup to occur during the
>>> initial non-blocking issue.
>>
>> In other words, leveraging internal details that is not a part
>> of the uapi, should never be relied upon by the user and is fragile.
>> Any drain request or IOSQE_ASYNC and it'll break, or for any reason
>> why it might be desirable to change the behaviour in the future.
>>
>> Sorry, but no, we absolutely can't have that, it'll be an absolute
>> nightmare to maintain as basically every request scheduling decision
>> now becomes a part of the uapi.
> 
> I thought we discussed this on the ublk zero copy patchset, but I
> can't seem to find the email. My recollection is that Jens thought it
> was reasonable for userspace to rely on the sequential prep + issue of
> each SQE as long as it's not setting any of these flags that affect
> their order. (Please correct me if that's not what you remember.)

Well, my opinions are my own. I think it's reasonable to assume that
for optimisation purposes IFF the user space can sanely handle
errors when the assumption fails.

In your case, the user space should expect that an unregistration
op can happen before a read/write had resolved the buffer (node), in
which case the rw request will find that the buffer slot is empty
and fail. And that should be handled in the user space, e.g.
by reissuing the rw request of failing.

> I don't have a strong opinion about whether or not io_uring should
> provide this guarantee, but I was under the impression this had
> already been decided. I was just trying to fix the few gaps in this

I don't think so, it's a major uapi change, and a huge burden
for many future core io_uring changes.

> guarantee, but I'm fine dropping the patches if Jens also feels
> userspace shouldn't rely on this io_uring behavior.
> 
>>
>> There is an api to order requests, if you want to order them you
>> either have to use that or do it in user space. In your particular
>> case you can try to opportunistically issue them without ordering
>> by making sure the reg buffer slot is not reused in the meantime
>> and handling request failures.
> 
> Yes, I am aware of the other options. Unfortunately, io_uring's linked
> operation interface isn't rich enough to express an arbitrary
> dependency graph. We have multiple I/O operations operating on the
> same ublk request's buffer, so we would either need to link the I/O
> operations (which would prevent them from executing in parallel), or
> use a separate register/unregister operation for every I/O operation
> (which has considerable overhead). We can also wait for the completion
> of the I/O operations before submitting the unregister operation, but
> that adds latency to the ublk request and requires another
> io_uring_enter syscall.
> 
> We are using separate registered buffer indices for each ublk request
> so at least this scenario doesn't lead to data corruption. And we can
> certainly handle the EFAULT when the operation goes asynchronous, but
> it would be preferable not to need to do that.

-- 
Pavel Begunkov


