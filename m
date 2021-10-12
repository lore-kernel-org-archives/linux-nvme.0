Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5784C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 15:09:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9684F6052B
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 15:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9684F6052B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sD46WWgzAObSAcghdvkIp8oMObNkXZIkiaixyiqmeBs=; b=1A/4PorO/J7QJfkZthl5x55Xdk
	Pn0OZiB9NlYYCJfLXWXMhL92FRYWCqY2ooJRp8hx1GSYGQ8WaD0fmowPDfsmZLq7sbGcVLC2VZaEb
	tCxsYOPQTHkckrryQbv9NnSDyZ3ue1v0yj1zQcKrGOZ75XrccJhfWN+4xyaVgbKKI9kTFG0wLTAJW
	MsGJweRX2vszCJIuy4CIB/bogh1aD0TF0ZI0B4jUdQcsrozz9tI65fiSvkrYyFcpF/adaboVbtVJJ
	boLyWrAGokmIlyB5Cts996UZ2oyYYRowMANNGaC70qsOv3lERt3+/WWrlwgj5kziP9+AemsKDfs2V
	Kcxj8mhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maJPE-00DIkS-Bd; Tue, 12 Oct 2021 15:09:28 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maJPB-00DIjW-7k
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 15:09:26 +0000
Received: by mail-wr1-f52.google.com with SMTP id t2so67953017wrb.8
 for <linux-nvme@lists.infradead.org>; Tue, 12 Oct 2021 08:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J1LZaElNrkRTt0L3TOQg6vlE4jRHoB3hzqVL1wIyGtw=;
 b=zcqQ1/rgeGstosNwPvpl1TKErdP8nJmd9cX6W0A+76tL+NqoVYN3JVDW8yETuS9QcN
 +QOD6s/nwxyBnEZgp0ro4kCotWPHAkP2s5Ia/y839OMqV+x+PEkNqRASbjNhLgrKUJ3D
 bIvH6A9Lubt77udg04dsJkhHPrjNAxFpGLYTMRWGVSuo3ypl9T1refbdKJF6iN8Ae03P
 J11hLtxDKSD3fRsrwFQNzNElAn+sy0dvgN+KCst9jLoGc02bkISx2/A1c/+A8oQjT2jj
 QizitDL9G+/WYTlR9Ql5UunjosYB968Ubpz0QM6zFmEutpR7dTT8lA9kfx0xKie8Vrh0
 k8YQ==
X-Gm-Message-State: AOAM5335HSszpzhH8BteJ9TJXQ5cjJypc7MR97L7RrRw6qAyP1c4ljHS
 5obvNfN6kwz3QDiuNM/jnHqQTqEgSWI=
X-Google-Smtp-Source: ABdhPJzUa0NDblM2T2QL1+RHFgBKRczuoTxZUdRpZb6VVmvwDGzRabZJtooobPPXFM3WMF7ximyaQw==
X-Received: by 2002:adf:a550:: with SMTP id j16mr33357712wrb.180.1634051362822; 
 Tue, 12 Oct 2021 08:09:22 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id a63sm899421wmd.34.2021.10.12.08.09.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Oct 2021 08:09:22 -0700 (PDT)
Subject: Re: switch block layer polling to a bio based model v4
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20211012111226.760968-1-hch@lst.de>
 <07f31547-5570-4150-7a4b-1d773fb9fa87@kernel.dk>
 <040104f6-720d-35ed-7e15-a704e6488fd4@grimberg.me>
 <1f53ea37-6825-de63-0f51-5ff54fa7618e@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <054cd2ed-1996-d6dd-5842-2bf5a03fbdea@grimberg.me>
Date: Tue, 12 Oct 2021 18:09:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1f53ea37-6825-de63-0f51-5ff54fa7618e@kernel.dk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_080925_312274_291199F1 
X-CRM114-Status: GOOD (  21.07  )
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



On 10/12/21 5:58 PM, Jens Axboe wrote:
> On 10/12/21 8:57 AM, Sagi Grimberg wrote:
>>
>>>> Hi all,
>>>>
>>>> This series clean up the block polling code a bit and changes the interface
>>>> to poll for a specific bio instead of a request_queue and cookie pair.
>>>>
>>>> Polling for the bio itself leads to a few advantages:
>>>>
>>>>     - the cookie construction can made entirely private in blk-mq.c
>>>>     - the caller does not need to remember the request_queue and cookie
>>>>       separately and thus sidesteps their lifetime issues
>>>>     - keeping the device and the cookie inside the bio allows to trivially
>>>>       support polling BIOs remapping by stacking drivers
>>>>     - a lot of code to propagate the cookie back up the submission path can
>>>>       removed entirely
>>>>
>>>> The one major caveat is that this requires RCU freeing polled BIOs to make
>>>> sure the bio that contains the polling information is still alive when
>>>> io_uring tries to poll it through the iocb. For synchronous polling all the
>>>> callers have a bio reference anyway, so this is not an issue.
>>>
>>> I ran this through the usual peak testing, and it doesn't seem to regress
>>> anything for me. We're still at around ~7.4M polled IOPS on a single CPU
>>> core:
>>>
>>> taskset -c 0,16 t/io_uring -d128 -b512 -s32 -c32 -p1 -F1 -B1 -D1 -n2 /dev/nvme1n1 /dev/nvme2n1
>>> Added file /dev/nvme1n1 (submitter 0)
>>> Added file /dev/nvme2n1 (submitter 1)
>>> polled=1, fixedbufs=1, register_files=1, buffered=0, QD=128
>>> Engine=io_uring, sq_ring=128, cq_ring=256
>>> submitter=0, tid=1199
>>> submitter=1, tid=1200
>>> IOPS=7322112, BW=3575MiB/s, IOS/call=32/31, inflight=(110 71)
>>> IOPS=7452736, BW=3639MiB/s, IOS/call=32/31, inflight=(52 80)
>>> IOPS=7419904, BW=3623MiB/s, IOS/call=32/31, inflight=(78 104)
>>> IOPS=7392576, BW=3609MiB/s, IOS/call=32/32, inflight=(75 102)
>>
>> Jens, is that with nvme_core.multipath=Y ?
> 
> No, I don't have multipath enabled. I can run that too, if you'd like.

That would be useful to learn. thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
