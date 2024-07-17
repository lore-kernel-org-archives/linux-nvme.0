Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D8FC3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 22:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s0M64jRxdtrIITpN4HFOHIiK/TKB1YJndYfAL1oKmq0=; b=S5pPgB5+pA5xvzk0OqKJd6CBNG
	g6VduKi7NxhAc1ZVVmvIkV6wtqfhsqlH8ltnJpdy6XYj456BEWkzjNVG7qLILt6oGNJ2qWGxZ5WGT
	1PfwplRZe4jGHudvnKFY6GMIv+w+CGGs+sh8nE/YzF1QoKhLWbJvjmKx71YBY7Nknv80Z1MBGd3Fm
	fDYjUrsGuoT6ZLTk3x9vc8kVndUbR17iwgg2kUt7GpM1nG+cY+GgcjhXfBPxGibK4zI0U/Xn0ngVB
	Cri8FgYhaI5GwL3JHJk4LyK8W1tNuFmMYZwLN5KaQN2YykwaApnrdA06VlYkjj7eal/ZELugCSYNS
	5IfMcPiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUDWe-0000000F9xT-3nHz;
	Wed, 17 Jul 2024 22:53:32 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUDV5-0000000F9pw-0TYa
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 22:53:31 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4265f823147so291365e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 15:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721256714; x=1721861514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0M64jRxdtrIITpN4HFOHIiK/TKB1YJndYfAL1oKmq0=;
        b=iBdErz5tr/Lp7wFwKZx1UTQhDyYyJA++C3VD69fPCFKtVG+YYp2LTB0YQljsSMfRcC
         A7bmkzBEGLglIF3KIcOMuhIpKCOmbVwCi7dE2aH8l7kbuFQAUSzaCY/U7ulbHbve9dhx
         rsrnGMvyeLnbmVwfdH6AzHb9eNzxgB3VWVLlVGsmqtc8Aw4fkPQ3lhSuoarpJNwwDXMf
         JteCcqq7yyyMXG81BqJ9xjKXsMfMLwwv+9m2lN9kVzKhf5zESKygt3tlEok389kiQqQX
         2zOXT1sLqFlBsoaiv4NgL2OsBAs/KZYvJg4SH+wbuHqFGwgWz34s+dwjIbtNlDtc6vEk
         Jnjw==
X-Forwarded-Encrypted: i=1; AJvYcCW7anqyUhz8rjLOHh6wcOKEf+0ffOZ/bmyfuoV9o3kJuflqgKrJMox2PdXgiBmZiGcar06tLmdlQ3aP@lists.infradead.org
X-Gm-Message-State: AOJu0YxZH/7QJnpw5AVf5izgcZJsO9NO2uYXHtYJJIc8WpVXsdZm2SS4
	NbEbVACx+FjCDA8Ip99JCVE9GzOZ7WM3FCup/CuHZjp6oPUe9aUL
X-Google-Smtp-Source: AGHT+IGjse9ynxNLLxkSLaOFMZvanW6vy86VI1WLzh8tqLRb+7IQ7INQFlIBWZ7Hb1LYbkNNUkxvHA==
X-Received: by 2002:a05:600c:5101:b0:427:9f6f:9c00 with SMTP id 5b1f17b1804b1-427c2d52195mr14721745e9.6.1721256713451;
        Wed, 17 Jul 2024 15:51:53 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c7857eadsm12107835e9.40.2024.07.17.15.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 15:51:53 -0700 (PDT)
Message-ID: <3f675a0f-45c1-41bd-887a-fe6e6d793ecf@grimberg.me>
Date: Thu, 18 Jul 2024 01:51:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] libceph: use sendpages_ok() instead of
 sendpage_ok()
To: Ilya Dryomov <idryomov@gmail.com>, Ofir Gal <ofir.gal@volumez.com>
Cc: davem@davemloft.net, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 ceph-devel@vger.kernel.org, dhowells@redhat.com, edumazet@google.com,
 pabeni@redhat.com, kbusch@kernel.org, xiubli@redhat.com
References: <20240611063618.106485-1-ofir.gal@volumez.com>
 <20240611063618.106485-5-ofir.gal@volumez.com>
 <2695367b-8c67-47ab-aa2c-3529b50b1a83@volumez.com>
 <CAOi1vP96JtsP02hpsZpeknKN_dh3JdnQomO8aTbuH6Bz247rxA@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAOi1vP96JtsP02hpsZpeknKN_dh3JdnQomO8aTbuH6Bz247rxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_155155_179117_34F7425D 
X-CRM114-Status: GOOD (  20.85  )
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



On 17/07/2024 23:26, Ilya Dryomov wrote:
> On Tue, Jul 16, 2024 at 2:46 PM Ofir Gal <ofir.gal@volumez.com> wrote:
>> Xiubo/Ilya please take a look
>>
>> On 6/11/24 09:36, Ofir Gal wrote:
>>> Currently ceph_tcp_sendpage() and do_try_sendpage() use sendpage_ok() in
>>> order to enable MSG_SPLICE_PAGES, it check the first page of the
>>> iterator, the iterator may represent contiguous pages.
>>>
>>> MSG_SPLICE_PAGES enables skb_splice_from_iter() which checks all the
>>> pages it sends with sendpage_ok().
>>>
>>> When ceph_tcp_sendpage() or do_try_sendpage() send an iterator that the
>>> first page is sendable, but one of the other pages isn't
>>> skb_splice_from_iter() warns and aborts the data transfer.
>>>
>>> Using the new helper sendpages_ok() in order to enable MSG_SPLICE_PAGES
>>> solves the issue.
>>>
>>> Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
>>> ---
>>>   net/ceph/messenger_v1.c | 2 +-
>>>   net/ceph/messenger_v2.c | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
>>> index 0cb61c76b9b8..a6788f284cd7 100644
>>> --- a/net/ceph/messenger_v1.c
>>> +++ b/net/ceph/messenger_v1.c
>>> @@ -94,7 +94,7 @@ static int ceph_tcp_sendpage(struct socket *sock, struct page *page,
>>>         * coalescing neighboring slab objects into a single frag which
>>>         * triggers one of hardened usercopy checks.
>>>         */
>>> -     if (sendpage_ok(page))
>>> +     if (sendpages_ok(page, size, offset))
>>>                msg.msg_flags |= MSG_SPLICE_PAGES;
>>>
>>>        bvec_set_page(&bvec, page, size, offset);
>>> diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
>>> index bd608ffa0627..27f8f6c8eb60 100644
>>> --- a/net/ceph/messenger_v2.c
>>> +++ b/net/ceph/messenger_v2.c
>>> @@ -165,7 +165,7 @@ static int do_try_sendpage(struct socket *sock, struct iov_iter *it)
>>>                 * coalescing neighboring slab objects into a single frag
>>>                 * which triggers one of hardened usercopy checks.
>>>                 */
>>> -             if (sendpage_ok(bv.bv_page))
>>> +             if (sendpages_ok(bv.bv_page, bv.bv_len, bv.bv_offset))
>>>                        msg.msg_flags |= MSG_SPLICE_PAGES;
>>>                else
>>>                        msg.msg_flags &= ~MSG_SPLICE_PAGES;
> Hi Ofir,
>
> Ceph should be fine as is -- there is an internal "cursor" abstraction
> that that is limited to PAGE_SIZE chunks, using bvec_iter_bvec() instead
> of mp_bvec_iter_bvec(), etc.  This means that both do_try_sendpage() and
> ceph_tcp_sendpage() should be called only with
>
>    page_off + len <= PAGE_SIZE
>
> being true even if the page is contiguous (and that we lose out on the
> potential performance benefit, of course...).
>
> That said, if the plan is to remove sendpage_ok() so that it doesn't
> accidentally grow new users who are unaware of this pitfall, consider
> this
>
> Acked-by: Ilya Dryomov <idryomov@gmail.com>

 From which tree should this go from? we can take it via the nvme tree, 
unless
someone else wants to queue it up...

