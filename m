Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87004EB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 08:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=94JwxtFLN3WnFOVWsRjqf+GWsT36hiQtk9qcpxUhQjQ=; b=eQJrQb7k+vAW6tnZjjFJzmxjVW
	s9rX8DfpwP/eKGn9TUGV8CfWdWRt705wi7g2G1ucaq0TofcQW+cth+uZEjrtC9FH6Qc1J8wiaVZKQ
	JooQ+irXEEGVNczukmQflLiyquVMlumV1pB+nCaa9a4yf+ZyvuYnsm8mtKJw3jwo+IncXeNcJtuOF
	dtbfgL5YEuZfRIkRJV00vWerBKVCEsyGcVLegUA0q90AFCd+4x+Y/X81D8kV2n2/eWc7p4XSWK5gv
	Xg/ItkoEro9XP7yYYI+oBosJZFE+8Q0zCg25UCpmUt4BQbdpiBg6GCsBfh7nXEftO+gwRfskWMqHt
	6OFygfaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qImBW-00ApsQ-2P;
	Mon, 10 Jul 2023 08:23:54 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qImBR-00AprA-2m
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 08:23:51 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fbb634882dso10263735e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jul 2023 01:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688977426; x=1691569426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94JwxtFLN3WnFOVWsRjqf+GWsT36hiQtk9qcpxUhQjQ=;
        b=Rj04X1C26e4jEoQXOyTgMv/lRwG2apkJZV5lmLXVZ9tu547Ju6VDnuMgBmQGn2MQsw
         ItQAuKmm+uys7JlINioLB8h4ctB9mgIJAZOwqqqnif7Di0ByHRfC9rMPoENh47UAtiB8
         Y83ymUIYxyIi66Kfd0MUsyceqKPkhiulCTSM4ug3T/gnQQKK9LWMB4VDw8QcsR8XiNgA
         lQtHCOC9MaTB+ZaGxMwza5swFpm0CRvo8wTyeHF7fyKqAKXTG591sPW7Yuf9/iSejrtT
         +mFLmuAxQQQ2GIovp+VstdDnI6RGzkJsqT4CnRns1inPxY2UD8bR0bPLHSK312Nmr8Fi
         ENdw==
X-Gm-Message-State: ABy/qLaHlAGaAT3NxyviUjsfo1i2C29/lvF4mVg3XekdEbmQsFHv03VK
	aNTNyVp0yDxK8PGOfLtYv5c=
X-Google-Smtp-Source: APBJJlHVH2Ob+BwdBbZ2GgJjym2J/v5gNpyZn7gOEHxyw8ZyJ2lxZ5qJhodLk0UMzMxxJo1MVHrtug==
X-Received: by 2002:a05:600c:43c5:b0:3fa:9587:8fc1 with SMTP id f5-20020a05600c43c500b003fa95878fc1mr10991986wmn.1.1688977426206;
        Mon, 10 Jul 2023 01:23:46 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k15-20020adff5cf000000b00314398e4dd4sm11070753wrp.54.2023.07.10.01.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 01:23:45 -0700 (PDT)
Message-ID: <b11743c1-6c58-5f7a-8dc9-2a1a065835d0@grimberg.me>
Date: Mon, 10 Jul 2023 11:23:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
 Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org
References: <20230628031234.1916897-1-ming.lei@redhat.com>
 <8dc6852e-ee90-ed64-1d3e-9ecdc9f4473b@grimberg.me>
 <148a3e62-939f-a74f-8075-8f37cda102ab@grimberg.me>
 <ZKt0wSHqrw3W88UQ@ovpn-8-21.pek2.redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZKt0wSHqrw3W88UQ@ovpn-8-21.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_012349_901285_D60FA6E1 
X-CRM114-Status: GOOD (  19.23  )
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


>>>> namespace's request queue is frozen and quiesced during error recovering,
>>>> writeback IO is blocked in bio_queue_enter(), so fsync_bdev() <-
>>>> del_gendisk()
>>>> can't move on, and causes IO hang. Removal could be from sysfs, hard
>>>> unplug or error handling.
>>>>
>>>> Fix this kind of issue by marking controller as DEAD if removal breaks
>>>> error recovery.
>>>>
>>>> This ways is reasonable too, because controller can't be recovered any
>>>> more after being removed.
>>>
>>> This looks fine to me Ming,
>>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>>>
>>>
>>> I still want your patches for tcp/rdma that move the freeze.
>>> If you are not planning to send them, I swear I will :)
>>
>> Ming, can you please send the tcp/rdma patches that move the
>> freeze? As I said before, it addresses an existing issue with
>> requests unnecessarily blocked on a frozen queue instead of
>> failing over.
> 
> Any chance to fix the current issue in one easy(backportable) way[1] first?

There is, you suggested one. And I'm requesting you to send a patch for
it.

> 
> All previous discussions on delay freeze[2] are generic, which apply on all
> nvme drivers, not mention this error handling difference causes extra maintain
> burden. I still suggest to convert all drivers in same way, and will work
> along the approach[1] aiming for v6.6.

But we obviously hit a difference in expectations from different
drivers. In tcp/rdma there is currently an _existing_ bug, where
we freeze the queue on error recovery, and unfreeze only after we
reconnect. In the meantime, requests can be blocked on the frozen
request queue and not failover like they should.

In fabrics the delta between error recovery and reconnect can (and
often will be) minutes or more. Hence I request that we solve _this_
issue which is addressed by moving the freeze to the reconnect path.

I personally think that pci should do this as well, and at least
dual-ported multipath pci devices would prefer instant failover
than after a full reset cycle. But Keith disagrees and I am not going to
push for it.

Regardless of anything we do in pci, the tcp/rdma transport 
freeze-blocking-failover _must_ be addressed.

So can you please submit a patch for each? Please phrase it as what
it is, a bug fix, so stable kernels can pick it up. And try to keep
it isolated to _only_ the freeze change so that it is easily
backportable.

Thanks.

