Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5781C54ED1
	for <linux-nvme@archiver.kernel.org>; Tue, 27 May 2025 21:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KochXFU1aAKVODJkOXIjhWSOsL3ThtoY9fPOacj19tY=; b=oIRVgNAwBSiqchCOVskUI2FHsv
	sfKhYq/Eiwgoee2jd+5fvonojmeLRIrZogJSx1BdMahf6n5z+jKBpFxHLXauapRD5oa9c81WRimbo
	92YwjzUWkGFttfGj3ctdKu+mzWVDaaWgUzrHnb0mlZABbMJcUbJqOzKvrYgixVg6IDRdVEx4ekdAE
	ouM6rpZIUWlunOsfn425cTRJlFBWQeV72WjCuT9ASuc4ZsFv+da03XXio5GQu0u2F4JRn2ighqabC
	px4NdNJru/Cp15TwVqtcE/NmC4j0cN5WDBacbjuXOTP5ma3z5rchIglqCaQvn2YpnyBudo4bjDGNe
	s940L3PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uK2Bx-0000000BeHT-2mbd;
	Tue, 27 May 2025 21:50:37 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uK2Aj-0000000BeAy-3tXi
	for linux-nvme@lists.infradead.org;
	Tue, 27 May 2025 21:49:23 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so35000535e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 27 May 2025 14:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748382560; x=1748987360;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KochXFU1aAKVODJkOXIjhWSOsL3ThtoY9fPOacj19tY=;
        b=pvBNH+pXjSwRCT+qMH4BPfJPCI70SZxKmBasXF12kpB4gnkRBfxI/tsNQ1kg1EEbcE
         0/Yy2/4NfKhlS4h6YRfjFKY+rSouFnCSZEzCeRyGwLbOAVKMYJ+yWFC7zdypncvrKQYU
         9DdeUlw6pqnIAq6npvUUU6XRtNBmJehuwkbvebwn9L4Y8q9h7SmrzZIOi6hGrIl98fiW
         taJlsm4TD77b/jDa0GrtTKyOBKF+nwKdcAFi0CZfH5ErE8HKXvHj8o+QoqF9oPUF3isf
         AD6Wed6t2zG/QhDOGfujGsslgV1XlFPhs7+P23/WmelSNBpSdBgyNJXQF4sVGgfIFk6W
         FtmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFCRq1SDBkSWS0jNxN4HgXqdNWyJpd9+MGcJ3C5QhkrQpSrkbZyN35BhOzqqi4JKKZwtfhqzhBJGa/@lists.infradead.org
X-Gm-Message-State: AOJu0YymPZcUJF45EYNxnbf0ra/quePJUZjkEvvcg79Mu9Mx45pLOyBL
	dZr4xlcxmQ7RkXOln1hXIJAHJj7sLdZxaOzYatunUpYnRCYNvhBPmJ/v
X-Gm-Gg: ASbGncsmzLLhJ2xkOBzvkRQBPExGSWqphQZvp3HHb4pdOTAEHyF2gaOFrEwXNSTvsxK
	j0pevZrSgRd3lrgcpIIJ1NUSmzdebd18G9mtGE+tdftlyFp/H/s1uhlkC+oXMlrWOU0+2UAtJgb
	2sBseIrCK/vujm3AjAR7iuD+bQhoigdtMhInuiij4ej1De4rawr+kgLZGD92e8BNdiy8QIREyZE
	fX6lk2indo7pFV70rw/txnxabx03cVFBH2YXlL0Xts/2GVWVqBu77IZppU0ETwDpmzjrlCVHE3t
	o4PnMzcCbsfXdkLAFXWIlX2v/7MoAkj9Z3/k/iYsHUDyQWgQQOLp+7hPcD97yqPHYAP/mMoVHOb
	rZ2JWHXIp
X-Google-Smtp-Source: AGHT+IEmt3TsJKJ5A83qPRvmz27OMP1ad49sNBfT82vUQVXR6mKG+ZgQIMJeaTS59j1byKxLf7fDdA==
X-Received: by 2002:a05:600c:8187:b0:442:f4a3:9388 with SMTP id 5b1f17b1804b1-44c939c1165mr106511025e9.19.1748382559487;
        Tue, 27 May 2025 14:49:19 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4e8bc37f7sm176160f8f.78.2025.05.27.14.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 14:49:18 -0700 (PDT)
Message-ID: <7f7e08be-4930-47e5-80df-91329c827915@grimberg.me>
Date: Wed, 28 May 2025 00:49:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
From: Sagi Grimberg <sagi@grimberg.me>
To: Hannes Reinecke <hare@suse.de>, Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 Hannes Reinecke <hare@kernel.org>, hch <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chris Leech <cleech@redhat.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
 <eda7a691-037b-442d-bd36-a31f93e95cb1@suse.de>
 <976af4b7-578b-4e47-a2ff-7c74af0b9afa@grimberg.me>
 <30b16579-1a28-4d01-9afd-8ff3996db42d@grimberg.me>
 <BY5PR04MB68490F6DD7F1FDBE6999B54BBC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <6202ffd4-4a32-4f85-ab87-ac5a087c2f1a@grimberg.me>
 <BY5PR04MB6849D4BF87755B82A073BBDABC89A@BY5PR04MB6849.namprd04.prod.outlook.com>
 <4cff2b68-32e8-4593-8a91-345171ae147f@suse.de>
 <BY5PR04MB6849463BE09E64B198950B74BC88A@BY5PR04MB6849.namprd04.prod.outlook.com>
 <BY5PR04MB6849CFB39AB3E98605D30C4BBC8BA@BY5PR04MB6849.namprd04.prod.outlook.com>
 <e45b6c71-7007-4ec2-b87e-d66f99e85460@grimberg.me>
 <MN2PR04MB6862B06C88E4FDFD2C4F7603BC97A@MN2PR04MB6862.namprd04.prod.outlook.com>
 <be17f412-ce6e-4593-8364-b64f15380459@suse.de>
 <e0ec3a62-43ab-4dab-afc8-c1f40def942e@grimberg.me>
 <ede69310-a640-489c-8922-24dd62cf6ea1@grimberg.me>
Content-Language: en-US
In-Reply-To: <ede69310-a640-489c-8922-24dd62cf6ea1@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250527_144921_967483_766EA41A 
X-CRM114-Status: GOOD (  18.76  )
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

>>
>> We still need to hunt these down. I'm still puzzled why adding the 
>> WAKE_SENDER
>> flag was able to make this issue disappear? I'll have another look at 
>> this patch.
>>
>> For now, I think we can go with this patchset, and then incrementally 
>> fix the remains.
>
> Kamaljit, can you check the following patch on top of the patchset 
> from Hannes that
> gets a reproduction?
>
> -- 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 835e29014841..2f5f2fcfb078 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1075,7 +1075,7 @@ static void nvme_tcp_write_space(struct sock *sk)
>
>         read_lock_bh(&sk->sk_callback_lock);
>         queue = sk->sk_user_data;
> -       if (likely(queue && sk_stream_is_writeable(sk))) {
> +      if (likely(queue)) {
>                 clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>                 queue_work_on(queue->io_cpu, nvme_tcp_wq, 
> &queue->io_work);
>         }
> -- 
>
> This think this may be preventing the scheduling of io_work. But now 
> that io_work is
> also ceasing based on sk_stream_is_writeable, we should probably still 
> schedule it.

Kamaljit? Any info on this?

