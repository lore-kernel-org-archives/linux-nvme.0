Return-Path: <SRS0=NvMH=XE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB627C4740A
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 19:26:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF3821A4A
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2019 19:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h0XGE8dP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF3821A4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PDRz269a4Yx9kVMWaV3PHYkdzJfMiPFscE88K1nkmGw=; b=h0XGE8dPD73hx5kJOmOsIEYqW
	lr3yZyF9w+AH8PlzlS5bWoQKBtNkokECat+67W55Z/ojATAFN2a6m77HScvw6yRSi78JZyPHY/hH8
	EgzK/kMCJ1NtwPdqUhjy/RlktUZBICVfaEWpyGQcSS4+ygvG+SFpNUgJhsKv6ruLE/AbHWihxBHT9
	p914Rlrroag3ujHJM+ZqFZYdmBebWkO3Xjtj07TTXt5ONDHm19/37djSRPs1LnAfEKjeb6dWIY3cy
	5BDLn2Xei4k/4YSr2xxYOAOKusKEYfB0ZKt1+OX32H1IERURxR/8UuXzIKIJt8Sqt1qSZvtXSunjq
	R6mqf6pAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i7PJE-0006Ia-Fg; Mon, 09 Sep 2019 19:26:44 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7PJC-0006Hb-1X
 for linux-nvme@lists.infradead.org; Mon, 09 Sep 2019 19:26:43 +0000
Received: by mail-ot1-f66.google.com with SMTP id 67so14077171oto.3
 for <linux-nvme@lists.infradead.org>; Mon, 09 Sep 2019 12:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gLM1CCeC9p531hDNHLzC8mfBfqp2fYYPYblncN2/1Rc=;
 b=Hrk1Ezxi7du8Ru4EMojcj7sDsIvU7y/QEkA3pxH2gXjjgG2DGDCKwHgWTZ7CAgeL5Y
 fZvgnoQpk+iF13t0MiCOjCYqOwNiM7mEOx9M20XRpM0UprOxwETIqJKccIx9+R95AjSo
 CpAlFcll8GUHx1gIp7rWi+phq1bYAN+g91e9frYYqc9LR/wT94Z0IXuyIHsKWSOfPh1d
 tuYniS3GgoyvIsIlxpHEp9R+FDGZHAo1BK7AkWkLf5IRHv9GuXCWATq9V2vgrnnseWzo
 TCsDazYaKCHdj9m1MHZyffg/0v5/Eu1nsyyhQwahA/tPDE1xNHeIA4rnvbp2G+a1HP7S
 rq8w==
X-Gm-Message-State: APjAAAVIqegOmNw5Hpkd/MxCg01p0IRspFxC4ySZfjP36YWeFB98aGYJ
 wQLpf8r5umpPrID1sF5anr5YGL1G
X-Google-Smtp-Source: APXvYqxvv9Dl8xhPxigif8op9MALNHTzy1+8Tpt1rHFifjQ8+bhuULtTy/MLAuruuc/2+om5BkVnKA==
X-Received: by 2002:a9d:77c1:: with SMTP id w1mr5081503otl.9.1568057198903;
 Mon, 09 Sep 2019 12:26:38 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id k10sm2043237oij.16.2019.09.09.12.26.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Sep 2019 12:26:37 -0700 (PDT)
Subject: Re: [PATCH v8 13/13] nvmet-passthru: support block accounting
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-14-logang@deltatee.com>
 <92d61426-65a2-827c-936b-55f12f3d6afb@grimberg.me>
 <ca4ebcd9-fa5d-5ddf-c2a7-70318410dd97@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7954e8a4-6026-2210-7192-94a4e483facf@grimberg.me>
Date: Mon, 9 Sep 2019 12:26:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ca4ebcd9-fa5d-5ddf-c2a7-70318410dd97@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190909_122642_089334_49FF5073 
X-CRM114-Status: GOOD (  16.09  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Support block disk accounting by setting the RQF_IO_STAT flag
>>> and gendisk in the request.
>>>
>>> After this change, IO counts will be reflected correctly in
>>> /proc/diskstats for drives being used by passthru.
>>>
>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>> ---
>>>    drivers/nvme/target/io-cmd-passthru.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/target/io-cmd-passthru.c b/drivers/nvme/target/io-cmd-passthru.c
>>> index 7557927a3451..63f12750a80d 100644
>>> --- a/drivers/nvme/target/io-cmd-passthru.c
>>> +++ b/drivers/nvme/target/io-cmd-passthru.c
>>> @@ -410,6 +410,9 @@ static struct request *nvmet_passthru_blk_make_request(struct nvmet_req *req,
>>>    	if (unlikely(IS_ERR(rq)))
>>>    		return rq;
>>>    
>>> +	if (blk_queue_io_stat(q) && cmd->common.opcode != nvme_cmd_flush)
>>> +		rq->rq_flags |= RQF_IO_STAT;
> 
> Thanks for the review!
> 
>> Does flush has data bytes in the request? Why the special casing?
> 
> Well it was special cased in the vanilla blk account flow... But I think
> it's required to be special cased so the IO and in_flight counts don't
> count flushes (as they do not for regular block device traffic).

I think that the accounting exclude I/O that is yielded from the flush
sequence. Don't think its relevant here...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
