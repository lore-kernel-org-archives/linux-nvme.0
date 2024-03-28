Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C77C54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 05:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DcC+wrkzoiUAxwZYm2oCTeanIJFav9yHBE/29Yscz6M=; b=RgK2pvvxu6isBjhwWbos9EhBFw
	lJpVBbnSbxFaFp5HbGG1yZv9rVzFNLNIP5FWgi2+AXXGC06Smyb7PLTZJ0s4VLouVIywL94BOq8tT
	ovNpXE2vnGlUfY4H3mLasYR1APPfsVTOamiYYcAnFPkfGMBHVL2cpv/En2PNU1uWPODSqlDi5vgeL
	iCzQ/BeoHk6UPpsES5lygXytdlil+VkeJ09cxkCNNupIfphJFs1K5WBp2MMVJq5YcdYgmh6J9DJLz
	a9gVRzEbLieBAFfH9o1PgSoJne1Kc8w4UeioT7EEm4asZVqG2BzeDd8L80joQz6sb2s0LPnMozvEG
	8Y/34Ffw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpiBe-0000000CXag-2mqX;
	Thu, 28 Mar 2024 05:20:26 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpiBa-0000000CXZZ-3LyX
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 05:20:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 32E05614D2;
	Thu, 28 Mar 2024 05:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4146FC433C7;
	Thu, 28 Mar 2024 05:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711603220;
	bh=xhf25+ggxrtfWdpFJalZY7ZD2A9ShjFcxIR0/21YZJg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=No/9ub/3qhoe1DZNXgYVGWg7izotLSo1qyyABkeFEKoIHjQ7kr8bxLuw8CPPf2kIP
	 mHENByqIcVBd+Q2SCa4Zs66tKwk/kmU9CFSC/UO25ZM3Y/9g8TnJLS5ZFquZflE4vc
	 YROLnKJhNkLNPlVHs9pU5GlkISJ4somiEisgpvzO8sfMHdJbjH/GfXS/FnwX4LVEpW
	 jlvtqaDz+vZQProMXEuR6IDiIBkIYRGEibAEBjrWmI6Rs0+nuK6Q7Ffdr1P2PvtiDl
	 //6UaH/u0GkJneC4NBEy0Cf37FjZG/wYh/3qCG5ZZgwfu5gGHi5DhO5F94mbV7exMz
	 /gJNujhPDtrjw==
Message-ID: <86114cba-535b-41e9-9b85-bac2fbdc1ed3@kernel.org>
Date: Thu, 28 Mar 2024 14:20:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/30] block: Introduce blk_zone_update_request_bio()
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-5-dlemoal@kernel.org> <20240328041457.GC13510@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240328041457.GC13510@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_222022_937098_60DBCB52 
X-CRM114-Status: GOOD (  12.02  )
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

On 3/28/24 13:14, Christoph Hellwig wrote:
>> -		if (req_op(req) == REQ_OP_ZONE_APPEND)
>> -			bio->bi_iter.bi_sector = req->__sector;
>> -
>> -		if (!is_flush)
>> +		if (!is_flush) {
>> +			blk_zone_update_request_bio(req, bio);
>>  			bio_endio(bio);
>> +		}
> 
> As noted by Bart last time around, the blk_zone_update_request_bio
> really should stay out of the !is_flush check, as otherwise we'd
> break zone appends going through the flush state machine.

I do not think that is corect. Because is_flush indicates that RQF_FLUSH_SEQ is
set, that is, we are in the middle of a flush sequence. And flush sequence
progression is handled at the request level, not BIOs. Once the sequence
finishes, then and only then the BIO original endio should be done, meaning that
we will then take this path and actually do blk_zone_update_request_bio() and
bio_endio(). So I still think this is correct.

> 
> Otherwise this looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

-- 
Damien Le Moal
Western Digital Research


