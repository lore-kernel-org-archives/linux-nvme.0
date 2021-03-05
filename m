Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8F1C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 01:47:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87E265005
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 01:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87E265005
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hd3Ka3BgewIi8UeyLAq9Iynsa2SZ1qLkfw8DBAAklho=; b=fIc7tdww8iLasckO8uLqR+FQ2
	U7cyDz/20lsn43TD+MFUKIboffXm9qzq4jHHv/WqtYD+yn8ZOWS8c9WGPT6gbSZSg3iOQIT7O+LLH
	m9DEww72PVXwCvGJbcjPQ/okMlzCEnP+MpZeBaHRzUfrYa2VaW7/OSIyK99EpkLBwKKuX3jO9OdWK
	+9tQ9n9t+sy8IzQK85l7rlE/LpPS1776bMMw70c7rHNYtPGHqqr/HNEc96ckeJpZXh9Qsbtp1ggjq
	RZdJpDPy0X9CSUDXGZHciKPhchw6eJsGSttTU7Pj2hoMic3hYMyryHkQAxC61la8CTMctVL1J74u/
	IUL8Da5Pg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHzYk-00BQw6-OE; Fri, 05 Mar 2021 01:47:18 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHzYW-00BQu7-SN
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 01:47:07 +0000
Received: by mail-pg1-x533.google.com with SMTP id o10so261607pgg.4
 for <linux-nvme@lists.infradead.org>; Thu, 04 Mar 2021 17:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LshAGE6p6myQmD07uPQReOdZiOzqC1u3Ks1YbjLsO4M=;
 b=RX3AoJVlGThIWTGEThs+iA1tzEtrHJPFhrGhLxrvC3ncaoVoYjc6FVno1YxFnX+rIP
 TFJSnFr7hDaIaB4vKvvfwJlckW0/BhXoHJ0wZfnKa5lxi3eODiPc+0KRYz0oVucEtXN2
 8DPcy2X0tR4BLT4fXqJmC3HWOd0NtEY9RwlGB2l09FL3b0E2Zjyz/QG4MlOWMHtUhhs0
 UDRsn1xICsIyl+8WTIej6mcWq7r4v995F3I6tl5K7R/LkhhZS42nOZYJCyK5INeGHeAG
 XFgXUDx6s+WW6hdTja4sUJ7goZFwWm4ZKhh6G6ZCTaq7BoxbdCO9u1TULBOxated5HyK
 RQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LshAGE6p6myQmD07uPQReOdZiOzqC1u3Ks1YbjLsO4M=;
 b=c4rpCP8TNjJ3UY1JGV1zVlaXVrAolM/Hv4q9nz2PFoEk6ZYG0fPvHyxFpQPerzYDPO
 tBSG9PbbfpipbXBkDZUm6urbcaUqNitwLLkhEp1NSGanNvWjfB+qM5jQXEjxMsNYjUZT
 cORQf+8b823Mdgqv+4YCl/8hknecGgU0DnFg08OEFp7QkxLvgcBXz9VsBy9a4bkCN6gB
 mPX1GzqgH3RtkQpCFDqMkBxyQzdNWn0eT+ESCHTEpr4pxfLMRg+/48eNPnGIDkXpYXHi
 AggSpsY8Yw5dh24QhA7tPYY3BYRJI/IEFYof5MUGUeIlzNjLO03WSYEFVIYV5d2kqJLn
 venQ==
X-Gm-Message-State: AOAM531otp1rt5TEmwnpOxkakW3w4wY3yfPZKcamcPN+7EKhCr55Baja
 chw8j04loLgh/3eRJi+nRgvz1g==
X-Google-Smtp-Source: ABdhPJz86LRvYlgNWtdeooxQLjUMnn2hKKPKVw3eiUAQxHw3GwyuLUh1EpuGmvnfw7GLPDfEDPBLPw==
X-Received: by 2002:a63:d24e:: with SMTP id t14mr5971182pgi.348.1614908823122; 
 Thu, 04 Mar 2021 17:47:03 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id np7sm452068pjb.10.2021.03.04.17.47.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Mar 2021 17:47:02 -0800 (PST)
Subject: Re: [RFC 3/3] nvme: wire up support for async passthrough
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Kanchan Joshi <joshiiitr@gmail.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>
References: <20210302160734.99610-1-joshi.k@samsung.com>
 <CGME20210302161010epcas5p4da13d3f866ff4ed45c04fb82929d1c83@epcas5p4.samsung.com>
 <20210302160734.99610-4-joshi.k@samsung.com>
 <BYAPR04MB496501DAED24CC28347A283086989@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CA+1E3rLvrC4s2o3qDgHfRWN0JhnB5ZacHK572kjP+-5NmOPBhw@mail.gmail.com>
 <BYAPR04MB49656F0B96D7D1190B293C1186979@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <54a2df06-8dde-1302-1109-d54d38ade488@kernel.dk>
Date: Thu, 4 Mar 2021 18:46:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49656F0B96D7D1190B293C1186979@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_014705_411587_F047390C 
X-CRM114-Status: GOOD (  14.08  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/4/21 3:59 PM, Chaitanya Kulkarni wrote:
> On 3/4/21 03:01, Kanchan Joshi wrote:
>> On Thu, Mar 4, 2021 at 3:14 AM Chaitanya Kulkarni
>> <Chaitanya.Kulkarni@wdc.com> wrote:
>>> On 3/2/21 23:22, Kanchan Joshi wrote:
>>>> +     if (!ioucmd)
>>>> +             cptr = &c;
>>>> +     else {
>>>> +             /*for async - allocate cmd dynamically */
>>>> +             cptr = kmalloc(sizeof(struct nvme_command), GFP_KERNEL);
>>>> +             if (!cptr)
>>>> +                     return -ENOMEM;
>>>> +     }
>>>> +
>>>> +     memset(cptr, 0, sizeof(c));
>>> Why not kzalloc and remove memset() ?
>> Yes sure. Ideally I want to get rid of the allocation cost. Perhaps
>> employing kmem_cache/mempool can help. Do you think there is a better
>> way?
>>
> 
> Is this hot path ?

It's command issue, and for a bypass (kind of) solution. It's most
definitely the hot path.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
