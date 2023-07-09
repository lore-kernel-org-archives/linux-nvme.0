Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B48C001B0
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Jul 2023 07:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BZT4OUEE+oia2xz8fV8wtOdivzl53DHGkdnBjhas2HQ=; b=vVsC29s79xVFeEooFs0PJwl9NB
	1rAfwfukoYWJlTXlFNFqMJdpTM7KlJWpJIYppxvbYp6pfd+X2mTpRsHQqmtj4z4jUIJbQHrabUO1c
	Ygw5vpiBrnJmj7Lg3xHXXStzd0tFU2czn+7BQSS4R9xeLIbhlWl68qEuNQl6DYDT787nwsPUAGuqo
	ER9TVBJSXlX6+gA2tqhQ9hP+wiXzoyXRlAaX39lxrNRQqW5G8KBnGlCJYF3ab7lNZj3p70+m0SOA0
	MS5dbp8vwxi2iKEzaK55SG74wR+/GbkDQ3o7Aagl9EdRJEuAahA2O/hFX4qKgziY91OdDZLlx3dZS
	I1oa2RUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIP06-008bbk-30;
	Sun, 09 Jul 2023 07:38:34 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIP04-008bb4-2y
	for linux-nvme@lists.infradead.org;
	Sun, 09 Jul 2023 07:38:34 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3159709a705so78999f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 09 Jul 2023 00:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688888309; x=1691480309;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZT4OUEE+oia2xz8fV8wtOdivzl53DHGkdnBjhas2HQ=;
        b=ClKie0KqC/CRwGs/RID9ZBQpBklNotI0sI+2LT3dJZQp/sHFb/nQyenUbRt7B99+JR
         IEHTYdsMZEDktKCIrUhf06o6qMukz1f0ktu17esHFIN4cSaI4uoTPzKD+8ddvpW0P9nx
         Ez3n7T7veWVa9G0XxEbsBiVHDZaF6WUYCSGYBrXnWh44cXmHjHNybuCdn2kHAExa/fix
         hpTWwrvy46kMn7kEHobwbX/cmiQQ24LgDqF+ljJ1+Eim+bm+tEB4Nmk2nuOSfrre7QKv
         gRGa+bKo8M05Bk6XvhgTT3ErWNavrUbeDoXrUyqAN0wPhH548X5Ec8lB2mkPK6VsPCt0
         K/ww==
X-Gm-Message-State: ABy/qLbVXejHEmmz9YVFrVPEtjQZGY3pzM6r+zDWHY/P2LaZ75FSdt8C
	dpJx6ekLU+jhddADt4+mBYo=
X-Google-Smtp-Source: APBJJlHPHKnmZpXdI8znJWdCmOoUhYkBUGALeHldxOsv49qxj+ziafD945e+N0G6WiZhxUx82BW1kw==
X-Received: by 2002:a05:600c:4f56:b0:3fb:f025:9372 with SMTP id m22-20020a05600c4f5600b003fbf0259372mr9065197wmq.4.1688888308860;
        Sun, 09 Jul 2023 00:38:28 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id n19-20020a7bc5d3000000b003fbca05faa9sm6966822wmk.24.2023.07.09.00.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 00:38:28 -0700 (PDT)
Message-ID: <148a3e62-939f-a74f-8075-8f37cda102ab@grimberg.me>
Date: Sun, 9 Jul 2023 10:38:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Chunguang Xu <brookxu.cn@gmail.com>,
 stable@vger.kernel.org
References: <20230628031234.1916897-1-ming.lei@redhat.com>
 <8dc6852e-ee90-ed64-1d3e-9ecdc9f4473b@grimberg.me>
In-Reply-To: <8dc6852e-ee90-ed64-1d3e-9ecdc9f4473b@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230709_003832_963872_26AD2CC8 
X-CRM114-Status: GOOD (  11.89  )
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


>> namespace's request queue is frozen and quiesced during error recovering,
>> writeback IO is blocked in bio_queue_enter(), so fsync_bdev() <- 
>> del_gendisk()
>> can't move on, and causes IO hang. Removal could be from sysfs, hard
>> unplug or error handling.
>>
>> Fix this kind of issue by marking controller as DEAD if removal breaks
>> error recovery.
>>
>> This ways is reasonable too, because controller can't be recovered any
>> more after being removed.
> 
> This looks fine to me Ming,
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> 
> I still want your patches for tcp/rdma that move the freeze.
> If you are not planning to send them, I swear I will :)

Ming, can you please send the tcp/rdma patches that move the
freeze? As I said before, it addresses an existing issue with
requests unnecessarily blocked on a frozen queue instead of
failing over.

