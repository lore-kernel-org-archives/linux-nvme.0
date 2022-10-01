Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D379FC433FE
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Oct 2022 02:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=39nUKBxMEtQ4k/548GHzcQvvgKYGFvJDlLo/dLbAsKs=; b=VajGrYUWCTIR8vFH/o62qToe6O
	ivK2zvbnuPBa4GHpObKc8OupRgSSIi3FxCAelJyLjjnX1krSai4Y5r0Lp3Md/dsDEKvZdvnnmid4H
	RomFfljMtSMm4Ps4fpB9g6vw1vP6I02TW6fzrkfHQ/fVZaCCYsRjFSDnLnsbSLQZDTHxDO3jHAsfh
	BHabaYOEXiFBXOBnrmKtl3V6hTUS/Scee8s09RnmMFtvPSVMtbZ0sCb9oRjNUqoeWtYi3t/3KnDxz
	oPmojAWySzBqBIQPRhndNr/jy816rYQM4Se7Q+TfZdjnX4bs5lA9TfZoxYGR5XLivT4HHKgJHXpH8
	KQ+zoAvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeS1N-00CdHF-8V; Sat, 01 Oct 2022 02:14:29 +0000
Received: from mail-pf1-f172.google.com ([209.85.210.172])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeS1L-00CdG4-2y
	for linux-nvme@lists.infradead.org; Sat, 01 Oct 2022 02:14:28 +0000
Received: by mail-pf1-f172.google.com with SMTP id d82so5681283pfd.10
        for <linux-nvme@lists.infradead.org>; Fri, 30 Sep 2022 19:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=39nUKBxMEtQ4k/548GHzcQvvgKYGFvJDlLo/dLbAsKs=;
        b=Gedj7VJsOHddSZYskchoWCnEfsudQSC7A2O4l5mwxIcvZAiKW0JvGNOl0vmthX/h4n
         zCW+ssoyz/FalPZzBBk8VggU90Lb67Ta+o3iPBBbiDgagOeJ9S7SJk2AcmstLsAjxx4E
         Iz3qwzBD4d6HFbZVj42qoBHOuz6ixHvWJ7WRBEhTC+tY52rNGalDrV17WnS/Wj7s0hBm
         7lL4mziOP3u2efIjjOReUMzrGKg4Y7LplEw2SIlNmIJbnkFsus2TMJwnVSgg8TKXaNLr
         UOhLee2AKj6GTq/KPYtcJ+OolgV9y7tlT3eRQSwT040efh/4kh3+HWSHSwPrr9cPW8rX
         hw6A==
X-Gm-Message-State: ACrzQf2kRujAlE7FnHwrVfY6+6DMmJHLvxD7FpFTP4D9iAoKVLlP5krw
	HKmaxd/CaKUB4bloCsN86N8=
X-Google-Smtp-Source: AMsMyM5IZ9SWdvy+3MR23M5okJI2LPj5kq09p3lxCfop3u62wqmizBiTv5Ld8kTbr49f1xoKgTuRYA==
X-Received: by 2002:a65:42c8:0:b0:41a:8138:f47f with SMTP id l8-20020a6542c8000000b0041a8138f47fmr10062728pgp.476.1664590464635;
        Fri, 30 Sep 2022 19:14:24 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id o3-20020a17090ac08300b0020a73eec389sm69517pjs.3.2022.09.30.19.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 19:14:23 -0700 (PDT)
Message-ID: <c54b3271-1e3f-75cc-2a90-0d5b9b5e93b2@acm.org>
Date: Fri, 30 Sep 2022 19:14:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v15 00/13] support zoned block devices with non-power-of-2
 zone sizes
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Jens Axboe <axboe@kernel.dk>, Pankaj Raghav <p.raghav@samsung.com>,
 hch@lst.de, Keith Busch <kbusch@kernel.org>
Cc: jaegeuk@kernel.org, agk@redhat.com, gost.dev@samsung.com,
 snitzer@kernel.org, linux-kernel@vger.kernel.org, hare@suse.de,
 matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 pankydev8@gmail.com, dm-devel@redhat.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CGME20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65@eucas1p1.samsung.com>
 <20220923173618.6899-1-p.raghav@samsung.com>
 <5e9d678f-ffea-e015-53d8-7e80f3deda1e@samsung.com>
 <bd9479f4-ff87-6e5d-296e-e31e669fb148@kernel.dk>
 <0e5088a5-5408-c5bd-bf97-00803cb5faed@acm.org>
 <bb2b3784-422f-fc82-e5be-e4d24412e21f@opensource.wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <bb2b3784-422f-fc82-e5be-e4d24412e21f@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_191427_153369_4D19EE1E 
X-CRM114-Status: GOOD (  13.24  )
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

On 9/30/22 17:45, Damien Le Moal wrote:
> On 10/1/22 04:38, Bart Van Assche wrote:
>> Since this has not been mentioned in the cover letter, I want to add
>> that in the near future we will need these patches for Android devices.
>> JEDEC is working on supporting zoned storage for UFS devices, the
>> storage devices used in all modern Android phones. Although it would be
>> possible to make the offset between zone starts a power of two by
>> inserting gap zones between data zones, UFS vendors asked not to do this
>> and hence need support for zone sizes that are not a power of two. An
>> advantage of not having to deal with gap zones is better filesystem
>> performance since filesystem extents cannot span gap zones. Having to
>> split filesystem extents because of gap zones reduces filesystem
>> performance.
> 
> As mentioned many times, my opinion is that a good implementation should
> *not* have any extent span zone boundaries. So personally, I do not
> consider such argument as a valid justification for the non-power-of-2
> zone size support.

Hi Damien,

Although the filesystem extent issue probably can be solved in software, 
the argument that UFS vendors strongly prefer not to have gap zones and 
hence need support for zone sizes that are not a power of two remains.

Thanks,

Bart.


