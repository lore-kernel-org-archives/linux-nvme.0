Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771E3C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 07:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a0j+eGyIExxw/xCWRVi02HB4i2K9lQe+UZypWJ7Vo34=; b=ZRaosif3QjOhHup5i7esFpCsw2
	id3bvRrxmrVTDu9gxopWRR7/UzvZODhuiMsOnKI2Kd4OX5Tx7rOc49qksOA7FLkmLpqBX7tPtyh0n
	4dLQ6gBDbDxYSDC7wPCyIaWvdHwJbxu+HWHAJwGATm1MzNtOzfpet9gleOF+Mtc9O0ebd5h77pmSP
	plzV/d4lr1XTXUtTd0SfsTYxQEwL5wSKHrSI2g17NQX68249TmxQb5+bdkpqvq7b2r7KhvR3xBjc7
	iV2b5vxy73fmiP/O9vZhbLMSJgWk/+BwhETp+alWJupAqkwWVVxQR55rHPuSme78vDdbc4Y+OHZZo
	pA0BznEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntOkE-0072C6-OL; Tue, 24 May 2022 07:14:18 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntOkC-0072BC-3s
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 07:14:17 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB95F1F8B8;
 Tue, 24 May 2022 07:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1653376452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0j+eGyIExxw/xCWRVi02HB4i2K9lQe+UZypWJ7Vo34=;
 b=NcY9en9mfR0ufFWjwKCLJCZhg2UJx0dSnuukRvQ9/GZsd1X6RwoZ4D/v3xSy05H7SG/SKs
 ijz/enAnj7z8V3y/g4iBc/2Yrl/6ih05ucelgpEuecPccuhWXle8TAkzTvDEjKrjbsIRu8
 Y+qzyAFx1JY1y94ObP8u0HeMiHkg1ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1653376452;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0j+eGyIExxw/xCWRVi02HB4i2K9lQe+UZypWJ7Vo34=;
 b=U2qG3aZqBm+6MXLn1ccnhetjs3ksEvlga9okE/jR3YPr4H7ATlUUkR6iPgmWHAjZaF+oTH
 x38VoXDTKmUE4sCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A61113ADF;
 Tue, 24 May 2022 07:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eUf7GMSFjGL1QQAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 24 May 2022 07:14:12 +0000
Message-ID: <83ef402e-1cff-a675-eab6-9fac9bb7565d@suse.de>
Date: Tue, 24 May 2022 09:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 2/7] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk, hch@lst.de,
 snitzer@redhat.com, damien.lemoal@opensource.wdc.com,
 Johannes.Thumshirn@wdc.com
Cc: linux-nvme@lists.infradead.org, dm-devel@redhat.com, dsterba@suse.com,
 jiangbo.365@bytedance.com, linux-kernel@vger.kernel.org,
 gost.dev@samsung.com, linux-block@vger.kernel.org, jaegeuk@kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220523161601.58078-1-p.raghav@samsung.com>
 <CGME20220523161606eucas1p2676c4d47f9fcb145f69b29db1f04fe6e@eucas1p2.samsung.com>
 <20220523161601.58078-3-p.raghav@samsung.com>
 <a7a409dc-4cf3-7096-50f6-7f794d4a0b9b@suse.de>
 <214e0c82-ce20-ba0f-77bd-21f3b83fd1f1@samsung.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <214e0c82-ce20-ba0f-77bd-21f3b83fd1f1@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_001416_338908_887CFB3B 
X-CRM114-Status: GOOD (  11.01  )
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

On 5/24/22 09:10, Pankaj Raghav wrote:
> On 5/24/22 07:19, Hannes Reinecke wrote:
> 
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index c4e4c7071b7b..f5c7a41032ba 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -676,6 +676,21 @@ static inline unsigned int
>>> blk_queue_zone_no(struct request_queue *q,
>>>        return div64_u64(sector, zone_sectors);
>>>    }
>>>    +static inline bool blk_queue_is_zone_start(struct request_queue *q,
>>> sector_t sec)
>>> +{
>>> +    sector_t zone_sectors = blk_queue_zone_sectors(q);
>>> +    u64 remainder = 0;
>>> +
>>> +    if (!blk_queue_is_zoned(q))
>>> +        return false;
>>> +
>>
>> Not sure if we need this here; surely blk_queue_zone_sectors() will
>> already barf, and none of the callers did this check.
>>
> I totally agree with you but all the other blk_queue_* functions had
> this defensive check and I didn't want to break that pattern:
> 
Ah, fair enough.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

