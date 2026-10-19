Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877B9CCF2D6
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 08:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y/cn1nw659hfdNL/u62UUjysTFQXLAmpwE8Xo3BKvYA=; b=QjVeCkBLi1rfRazuuef0qLjSsX
	sLQJRXbYwSyG7neenp9wGw5YYFtcQ/derJ1ufBGam0SO7V6runOBH+x98PMPTn8xInogl1EJxzbcg
	JsN8ScXTIzMPEpMqUJBlt2lGtvEclGPqSCGanBJQpcC68hZzq40Zcv0XX6+hN6NxzzgamA8x9LZIg
	EijOsOwj+qc25vepVu8QhjD6VMdKaBzZghz2jZb3tYuoVqpI7tSu5Soct2YZu04i0iwWzzbvXbH5w
	apXBoWfvCEXvy0Nvm8PoF0SSdd76EXhDvaEvO8ZQipfJqjpLgFt/KKm9m6ZCPtaAnAntsXs3V2nsw
	3DOD0C7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIii4-00000006rxY-3AZ4;
	Mon, 19 Oct 2026 08:27:08 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIii1-00000006rxB-14lb
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 08:27:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792398422; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=y/cn1nw659hfdNL/u62UUjysTFQXLAmpwE8Xo3BKvYA=;
	b=ZlTsGbzIdz3ejAx+6AOxpL7a2ET0rJVlT4B65aorD/q2q5GtZhqejBqiIpLJ7wdguUYsdma/WrkyLXDd2Bb1nD56LUaoxG92IdLDPkZY0JFsR84DLRhaMBZMscTYQ94ifx+05yIWDeGsKEjQlWlwkHoe1l8BtwDu3tyOWY9QOGs=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0XD3.0Wx_1792398421;
Received: from 30.178.69.0(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XD3.0Wx_1792398421 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Oct 2026 16:27:01 +0800
Message-ID: <1cd9132b-1c79-4073-a708-94fa333f2375@linux.alibaba.com>
Date: Mon, 19 Oct 2026 16:27:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] nvmet: translate placement identifiers of writes to
 write streams
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
References: <20261019033624.402337-1-kanie@linux.alibaba.com>
 <20261019033624.402337-11-kanie@linux.alibaba.com>
 <sashiko-outbox-176586@kernel.org>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <sashiko-outbox-176586@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_012706_014085_0296E623 
X-CRM114-Status: GOOD (  16.78  )
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



在 2026/10/19 11:44, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] nvmet: bi_write_stream lost on chained bios in nvmet_bdev_execute_rw()
> --
>
> commit ee4faa4396ddf960be1a3f58157a725fb3691c6f
> Author: Guixin Liu <kanie@linux.alibaba.com>
>
> nvmet: translate placement identifiers of writes to write streams
>
> This commit translates NVMe Data Placement Directive placement identifiers
> on write commands into block layer write streams on the backing block
> device when FDP is enabled on the namespace.
>
>> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
>> index f2d9e8901df4e..ff480f9ab9906 100644
>> --- a/drivers/nvme/target/io-cmd-bdev.c
>> +++ b/drivers/nvme/target/io-cmd-bdev.c
>> @@ -300,6 +300,10 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>>  	bio->bi_iter.bi_sector = sector;
>>  	bio->bi_private = req;
>>  	bio->bi_end_io = nvmet_bio_done;
>> +	if (req->cmd->rw.opcode == nvme_cmd_write &&
>> +	    nvmet_fdp_enabled(req->ns)) {
>> +		bio->bi_write_stream = nvmet_fdp_write_stream(req);
>> +	}
>>  
>>  	blk_start_plug(&plug);
>>  	if (req->metadata_len)
> [Severity: Medium]
> What happens when a write command spans multiple bios in
> nvmet_bdev_execute_rw()?
>
> When req->sg_cnt exceeds BIO_MAX_VECS (or bio_add_page() otherwise fills
> the current bio), the for_each_sg() loop allocates a new chained bio:
>
> 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
> 		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
> 				!= sg->length) {
> 			struct bio *prev = bio;
> 			...
> 			bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt),
> 					opf, GFP_KERNEL);
> 			bio->bi_iter.bi_sector = sector;
>
> 			bio_chain(bio, prev);
> 			submit_bio(prev);
> 		}
>
> Since bio_alloc() initializes bi_write_stream to 0 and bio_chain() does
> not copy bi_write_stream from prev, won't all subsequent chained bios for
> the write command be submitted with bi_write_stream set to 0 instead of
> the stream returned by nvmet_fdp_write_stream(req), preventing them from
> merging with the initial bio and routing the tail of the write to the
> default stream instead of the host-selected reclaim unit?
>
> [ ... ]
Sashiko is right, fixed in v2.
>


