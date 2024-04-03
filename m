Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722E6CD1284
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 01:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cMH//IWit5Q73l9+1jJgIJ8K1fI4UHxQjIqRoK9+s/M=; b=OpWGpNdGRyrmd52jTWH2s15cXL
	koRc8m966KMhWqoDDPUW7kXbAv4loJP8Q5STM6lVtrkybY4X7SuXpSWt8KMILmkmXztmiWSsjAo/k
	e0OpmFY5SNfXDdJ10wiUvyy531PHVepT1B4Ci7fewqsedGpnTYbDyNdpP9RRD+EfSgCtlaxzvEDTZ
	b7PFfmcRw+3MXNBRhA2AsyWUXgYU86vQL23GwKUE8c+cDKyQXl59rHMREm0Gp0OQPcS1qcE1p/Gha
	68GtKaa7oqWN1/f38B+035fexCx8iMNIyoQlwO2bs9Gi4+FrmCdhVPMcMZQOy0X2DCS/UNXQEt6XT
	nhROGIOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrpVi-0000000DXEj-3Hdv;
	Wed, 03 Apr 2024 01:33:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rroZK-0000000DNW8-1uKh
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 00:33:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DB81C60C52;
	Wed,  3 Apr 2024 00:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49C1C433F1;
	Wed,  3 Apr 2024 00:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712104413;
	bh=9rVFT8lEiXwwEQGVXwFX3otLVQCYNh4uDYylC4oXnT8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=hIvT5O9g/kS5pPbKKfu8tYXKO6LLPT1S2P6ShP5DThpaqhnFYWotIK3vzLOCuTLNs
	 2ItIfydaybA/kQP9c4kRpVQBo15OOl57fVMDxB35dDmx+bYjZcLHe1oqVTJRujN/Bb
	 vpWvJm65jTpGIqJIZhFYVV9YrxLuPuaKlC0Dsy2mjA76P1Y7xRexmeMhmZXErrK/H3
	 fVPkNkFxdAZkZHbaMe6k29VpRkAow/13qUiTEHnisBDf8QdGMsAmd7x5qHLOqEdMWG
	 OPy3u6S8CElVS1LqzjncpJHaY9kR38z+c5XWtYr7ujHR1C6v8kmx031RxsQs4nCmY7
	 YoHCFyCr1LOsA==
Message-ID: <2703a06b-9144-4f44-b14e-fb94cc235b9d@kernel.org>
Date: Wed, 3 Apr 2024 09:33:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/28] block: Introduce zone write plugging
To: Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240402123907.512027-1-dlemoal@kernel.org>
 <20240402123907.512027-8-dlemoal@kernel.org>
 <25fd8351-d649-445f-84fb-ed1705275859@suse.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <25fd8351-d649-445f-84fb-ed1705275859@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_173334_558062_FA599824 
X-CRM114-Status: GOOD (  15.78  )
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

On 4/3/24 03:26, Hannes Reinecke wrote:
>> diff --git a/block/bio.c b/block/bio.c
>> index d24420ed1c4c..4ece8cef1fbe 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -1576,6 +1576,13 @@ void bio_endio(struct bio *bio)
>>       if (!bio_integrity_endio(bio))
>>           return;
>>   +    /*
>> +     * For BIOs handled through a zone write plug, signal the completion
>> +     * of the BIO so that the next plugged BIO can be submitted.
>> +     */
>> +    if (bio_zone_write_plugging(bio))
>> +        blk_zone_write_plug_bio_endio(bio);
>> +
> 
> Can't we move this check into blk_zone_write_plug_bio_endio()?
> We'd need to check it anyway ...

The goal here is to avoid a useless function call for regular devices or read
BIOs. There is no double check as the flag is not checked again in
blk_zone_write_plug_bio_endio(). Same comment for the other points you raised
(except the last one, see below).

If you really insist, I could play games with inline functions to "hide" the
check though.

>> +/*
>> + * Called from bio_attempt_back_merge() when a BIO was merged with a request.
>> + */
>> +void blk_zone_write_plug_bio_merged(struct bio *bio)
>> +{
>> +    struct blk_zone_wplug *zwplug;
>> +    unsigned long flags;
>> +
>> +    /*
>> +     * If the BIO was already plugged, then we were called through
>> +     * blk_zone_write_plug_attempt_merge() -> blk_attempt_bio_merge().
>> +     * For this case, blk_zone_write_plug_attempt_merge() will handle the
>> +     * zone write pointer offset update.
>> +     */
>> +    if (bio_flagged(bio, BIO_ZONE_WRITE_PLUGGING))
>> +        return;
>> +
> See? you have to check anyway ...

This is the only function checking again, and for a good reason as the comment
above the check explains.

> 
> Cheers,
> 
> Hannes

-- 
Damien Le Moal
Western Digital Research


