Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6F4CD1292
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 01:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ktY8liiGNHvrV2BTVBB4ELKmUMxB6oumBrYkWd/QRFc=; b=e3AIjfM1MjEJSptjCOd0a9oOF+
	deUR27RnNapPpdjkR2SxHSHPnJ8tWOdLB0OJfaJEt8ZBdq11Zg6F3xxpE242EWH975dq2nTpnKXoX
	vaV8dyEJNsf6pFPI759l4bd3SQLtEhsX7rIDsV9+srOlGDEFxioXfLPgENr0K5pnlQY50LJVOgk3R
	HRWUwD0T5lx0vcerM0EG4TFu46k+3Ap2yARXTKMqw3HHbcQOqW0tYBRA/EN2VOgP9FGZpBwPSiYud
	I/cc3AIill7AqEk0DAQWLVFWNyxHO+Bh52k0lkBiqnp6xndB8nPSeJ5PmOQ21HsAbZj76bcfgROZP
	yetuxq0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtdmB-0000000DtWE-0L7T;
	Mon, 08 Apr 2024 01:26:23 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtdm7-0000000DtUA-3nXz
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 01:26:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 75C19CE015B;
	Mon,  8 Apr 2024 01:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326A9C433C7;
	Mon,  8 Apr 2024 01:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712539571;
	bh=+UQXNtn1Uy7xaukPw1RWns7kxpirCo4Jp35Je0Y1ODU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dn5qm8kWLR9O4+p065nJcW0gqIUM2WETkhmlR6RkFFI1xAJkjzP9f/XpTgyeityUt
	 B+EnDeNGzLRbp4JuEfmYaG6ngRXx+raxAMp1hX/TzeLWJl4NJZ4BroeZ81oLkgJPj0
	 vbRrUJ2ShzKqlU/RBXr7W1JQUj3mAw/Hrd8ekOb9jZAVouzNyGOx/BAccqOd8neBAc
	 Fx0LjWPA1U1p2bp2M8jvfoBDxNJ0TKNBI1xBmVPi4oBaPUcqnIrJVBYrf84pNz1sG1
	 m+e+fYp89HYiyEzV6Inyp8kz6Xv359sHhcyIwhSRTR2szx9jNMNfcnzlFs/FeJMAeZ
	 00G0LnUFBjQzA==
Message-ID: <51f5c3eb-df8b-4e9a-97e3-7f100d98fd1d@kernel.org>
Date: Mon, 8 Apr 2024 10:26:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/28] dm: Use the block layer zone append emulation
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240405044207.1123462-1-dlemoal@kernel.org>
 <20240405044207.1123462-13-dlemoal@kernel.org> <ZhAc5JL9KwoDdiOO@redhat.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZhAc5JL9KwoDdiOO@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_182620_131099_C40526AD 
X-CRM114-Status: UNSURE (   9.35  )
X-CRM114-Notice: Please train this message.
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

On 4/6/24 00:46, Mike Snitzer wrote:
>> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
>> index eb9832b22b14..174fda0a301c 100644
>> --- a/drivers/md/dm-zone.c
>> +++ b/drivers/md/dm-zone.c
>> @@ -226,41 +154,32 @@ static int dm_zone_revalidate_cb(struct blk_zone *zone, unsigned int idx,
>>  static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
>>  {
>>  	struct gendisk *disk = md->disk;
>> -	unsigned int noio_flag;
>>  	int ret;
>>  
>> -	/*
>> -	 * Check if something changed. If yes, cleanup the current resources
>> -	 * and reallocate everything.
>> -	 */
>> +	/* Revalidate ionly if something changed. */
> 
> Just noticed this ionly typo ^ Please fix.

Good catch. Thanks. Fixed it. Also fixed a tab that became spaces in the
declaration of dm_blk_report_zones() in drivers/md/dm.h.


-- 
Damien Le Moal
Western Digital Research


