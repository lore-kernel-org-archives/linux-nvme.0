Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9191C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 14:59:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E246103D
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 14:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 54E246103D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=36c3UNcPzkU19kpeZf0NP9pidM0JNOtIlWlI3T4oflI=; b=o4VkzEJcvXoqkdi/n+PTgS4eO2
	+gGALo6zS7tvCjy1cnOkVPJgea+RFV3d0tRHkJmhVoQg2F0s/YiLiA3woqc+cImQZlnIXMUGhxxp7
	8PqaXQrcp8bTY99jMidSY2N1/h0qAdhL6YU/dZeT0iaEGd2QLrK4LK7fNst1t8C2w2vyRt6CFiesM
	usGmyRrpc92RgDhTPlsfgVRmTBs3Pf0E2IEKotXMMX8F2QbZPo8OWFsWHkf1AmV7ZqstZdUzSW0i2
	uBLRnDQTS/EMRsoPvv+hVLjYZetxzAjSTfcuN3ytgiBWGXwA7GIQ3wzXewymxWXtrET2T+GNFY7en
	CzS0ChEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maJEy-00DH5Q-He; Tue, 12 Oct 2021 14:58:52 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maJEv-00DH4K-7S
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 14:58:50 +0000
Received: by mail-io1-xd2b.google.com with SMTP id q205so23996187iod.8
 for <linux-nvme@lists.infradead.org>; Tue, 12 Oct 2021 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tqA23ObcMjBgZVvCWLFVqQeiCNLoGDBftx5XWNNYGp8=;
 b=1Ysqi5Tuua6c+DOLSCokMMRS0S3ouQULZDGn4I6OUS6O8h961XDJX5twQE8MEv3sYV
 yLKA+6+hnbhAFFd4liTVO0RAFAkhGdM/S74YHZB8IDjSJy7RI7fhnHIXklQCCs8tle6N
 4CC3iMtQeDwfxmML9nUnM23Mfe7YcrnJ1unghGz8N4xotNALRNSq4IKGWQxEJHDs6as0
 +/OD/rLxQ3TOY/Hj8Y5TUiXurkChyAiiljPthkqsePedmYW0D8a3EOhBhu/zsdhi2vQK
 c4L7JJLs0hXqLKYLbj3GRqS19j9cqxaDQp6KDApM/GdqunKznW5jYFku3mRxppSz02G0
 T3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tqA23ObcMjBgZVvCWLFVqQeiCNLoGDBftx5XWNNYGp8=;
 b=x+deB2MhfVgG1DThtc8WASOR2yOcTuDZbXJuIf1CdihiaBrS8LiT0IqE3ZlpNLVTtb
 KY8r+LzE0IotAFwZTBtpL+q9BBkdeCEb6Hcvhr9UfxbrlULDJyZnizswxzKruP7PFUXp
 I2200i5oW5NGZXXR9DXfXCG3ifD0uSlN2MX+r2ElIiItL/L+bzhQGJJQFVepqf0eiR3L
 zmHRTfuvnN4uFcU1QmOeEuyPL76TxiygQe2Ai3ztFskqDhWt5EDWl4dVYAqJKAXrdj4f
 GGqv+U5oLL/sASGot2+FsPUsn9C9Bh8rGWX8gSYybvT/01F+fwRuD1izK0B3L24rRu9d
 fsog==
X-Gm-Message-State: AOAM531pRfWAvq5UMyzexvcg3atQbGTDNTfVk5jIJuC/RL2co39m/5KN
 mieD2W4r0j1ftd1kzB6/Y5xGsDDLrovxwA==
X-Google-Smtp-Source: ABdhPJyv1Javrn/St42VuUvMZqKad4SdoRQwzO4D5Q9r1lS2yVB+cCZF7l5V9bE9h582nw9V5kHLyg==
X-Received: by 2002:a6b:8e52:: with SMTP id q79mr21218840iod.64.1634050727820; 
 Tue, 12 Oct 2021 07:58:47 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id c9sm5649857ilo.18.2021.10.12.07.58.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Oct 2021 07:58:47 -0700 (PDT)
Subject: Re: switch block layer polling to a bio based model v4
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20211012111226.760968-1-hch@lst.de>
 <07f31547-5570-4150-7a4b-1d773fb9fa87@kernel.dk>
 <040104f6-720d-35ed-7e15-a704e6488fd4@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1f53ea37-6825-de63-0f51-5ff54fa7618e@kernel.dk>
Date: Tue, 12 Oct 2021 08:58:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <040104f6-720d-35ed-7e15-a704e6488fd4@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_075849_310553_CFCEEFEF 
X-CRM114-Status: GOOD (  19.56  )
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

On 10/12/21 8:57 AM, Sagi Grimberg wrote:
> 
>>> Hi all,
>>>
>>> This series clean up the block polling code a bit and changes the interface
>>> to poll for a specific bio instead of a request_queue and cookie pair.
>>>
>>> Polling for the bio itself leads to a few advantages:
>>>
>>>    - the cookie construction can made entirely private in blk-mq.c
>>>    - the caller does not need to remember the request_queue and cookie
>>>      separately and thus sidesteps their lifetime issues
>>>    - keeping the device and the cookie inside the bio allows to trivially
>>>      support polling BIOs remapping by stacking drivers
>>>    - a lot of code to propagate the cookie back up the submission path can
>>>      removed entirely
>>>
>>> The one major caveat is that this requires RCU freeing polled BIOs to make
>>> sure the bio that contains the polling information is still alive when
>>> io_uring tries to poll it through the iocb. For synchronous polling all the
>>> callers have a bio reference anyway, so this is not an issue.
>>
>> I ran this through the usual peak testing, and it doesn't seem to regress
>> anything for me. We're still at around ~7.4M polled IOPS on a single CPU
>> core:
>>
>> taskset -c 0,16 t/io_uring -d128 -b512 -s32 -c32 -p1 -F1 -B1 -D1 -n2 /dev/nvme1n1 /dev/nvme2n1
>> Added file /dev/nvme1n1 (submitter 0)
>> Added file /dev/nvme2n1 (submitter 1)
>> polled=1, fixedbufs=1, register_files=1, buffered=0, QD=128
>> Engine=io_uring, sq_ring=128, cq_ring=256
>> submitter=0, tid=1199
>> submitter=1, tid=1200
>> IOPS=7322112, BW=3575MiB/s, IOS/call=32/31, inflight=(110 71)
>> IOPS=7452736, BW=3639MiB/s, IOS/call=32/31, inflight=(52 80)
>> IOPS=7419904, BW=3623MiB/s, IOS/call=32/31, inflight=(78 104)
>> IOPS=7392576, BW=3609MiB/s, IOS/call=32/32, inflight=(75 102)
> 
> Jens, is that with nvme_core.multipath=Y ?

No, I don't have multipath enabled. I can run that too, if you'd like.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
