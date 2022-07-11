Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96C0C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jul 2022 18:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y0P+4h7ySBU/z8rjGZsOBQC8EJ5TjD4canO3eG4CCIM=; b=e1NYUuwMUSWyKzvTDgBaiRBHjr
	PlQCEWiWgrFnOGRnTCI0DehOq4S7blACDbgsuKU7Sbn0XGa2O2h1ZuFyySd9rJC19vxDmFkkmfZqx
	7e/qlquAyEbrhyZ+mDiLc/hCX3B71YnPK+FIwhXw2RjdMzFiWAKVVZtxxHn4Sml7KiDCxc2BiXYe4
	1VjxRS6P9Cgs27Au35ZIEjPCbwW0NblL3vUfpyIQxbjbKOw6N+qyPuct15ofTTli3xHW+nksnqTOn
	2ZzhEkCV5ZDYT8FyJ5G1Q8U/oaMp0/MztQD5JQJCAEA5Dj3lIs3XMQVqar5IzFciy8m7JX5C7sktJ
	XskdFJqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAy3i-003pGk-J9; Mon, 11 Jul 2022 18:23:02 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAy3f-003pEF-Lj
	for linux-nvme@lists.infradead.org; Mon, 11 Jul 2022 18:23:01 +0000
Received: by mail-wr1-f46.google.com with SMTP id o4so8114226wrh.3
        for <linux-nvme@lists.infradead.org>; Mon, 11 Jul 2022 11:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Y0P+4h7ySBU/z8rjGZsOBQC8EJ5TjD4canO3eG4CCIM=;
        b=n+sGuoCRhLgWYCBN8b5hPwEShfN2+mwgfq7WiD1Uh1OiRy7g+7W08lL27X0GRdJbyM
         Dfb/NpLw3g+MtbeJBNiXhEsjnr3baXOLVFchwV+AValYr3w4XNWcJ5RZTtRpOyYrnLhd
         OUjhQU53jTXAv5tCPv3QtxIe/ShlqFbubxs51Wg+nuL3WeZJ8MXk1jFWWumQnxKqDFoD
         B97Urui0d2oGgj2HvRRIjPjRJhCnf+P+ZUUoEmmoWQr7MK8YYFwC0eLLtX+GnDreY6wX
         W3DA0iskpBOHwttnpSH6ux1ZAy8bNv+5sX00uzbQ63Ljo3Hunl4iY2c/LcrYkXJouIP5
         +gWg==
X-Gm-Message-State: AJIora+hqFuNO3eEMYNC5K9QFvW4AougfZlalGSYy/yW+2lwQGz5rQ/g
	tSwQXK1Zv+3tdcrkUkKg7Nc=
X-Google-Smtp-Source: AGRyM1v/8JwGwAd1zYxp9kSiFFeDIrbV06UmhKleUuhUnwMbqwvaZOddWVcI+DiLLnS0X4vWWUT+gw==
X-Received: by 2002:a5d:440f:0:b0:21d:888b:a65b with SMTP id z15-20020a5d440f000000b0021d888ba65bmr18507485wrq.655.1657563776628;
        Mon, 11 Jul 2022 11:22:56 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id b13-20020a056000054d00b0021d7d251c76sm6318193wrf.46.2022.07.11.11.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 11:22:56 -0700 (PDT)
Message-ID: <96fcba9a-76ad-8e04-e94e-b6ec5934f84e@grimberg.me>
Date: Mon, 11 Jul 2022 21:22:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next 3/4] io_uring: grow a field in struct
 io_uring_cmd
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
 hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, asml.silence@gmail.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110824epcas5p22c8e945cb8c3c3ac46c8c2b5ab55db9b@epcas5p2.samsung.com>
 <20220711110155.649153-4-joshi.k@samsung.com>
 <2b644543-9a54-c6c4-fd94-f2a64d0701fa@kernel.dk>
 <43955a42-7185-2afc-9a55-80cc2de53bf9@grimberg.me>
In-Reply-To: <43955a42-7185-2afc-9a55-80cc2de53bf9@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_112259_738502_8C90396B 
X-CRM114-Status: GOOD (  13.61  )
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


>>> Use the leftover space to carve 'next' field that enables linking of
>>> io_uring_cmd structs. Also introduce a list head and few helpers.
>>>
>>> This is in preparation to support nvme-mulitpath, allowing multiple
>>> uring passthrough commands to be queued.
>>
>> It's not clear to me why we need linking at that level?
> 
> I think the attempt is to allow something like blk_steal_bios that
> nvme leverages for io_uring_cmd(s).

I'll rephrase because now that I read it, I think my phrasing is
confusing.

I think the attempt is to allow something like blk_steal_bios that
nvme leverages, but for io_uring_cmd(s). Essentially allow io_uring_cmd
to be linked in a requeue_list.

> 
> nvme failover steals all the bios from requests that fail (and should
> failover) and puts them on a requeue list, and then schedules
> a work that takes these bios one-by-one and submits them on a different
> bottom namespace (see nvme_failover_req/nvme_requeue_work).

Maybe if io_kiocb could exposed to nvme, and it had some generic space
that nvme could use, that would work as well...

