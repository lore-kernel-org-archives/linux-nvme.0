Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E547C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 19:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gjDYcfQrPymPgf4zZHF6ExZnXFdO/ag78V3ukKEreZ8=; b=rhH/75QGuO9vlJ5oGGi7797rQQ
	1fWPXvnmZeBWynaqQSGb+PNQfY1/fvEv6kng/XlWSwPR0EPTGB0bvR+Uousij9+VeIgOvPrE/3Knx
	TdqEn4Komz/7UbIHYi/kdOGjDg9R4D7N7+vXFBCOwrF9M5HT9DUOhen8/eoK2bwzhtcW4qAmi9UP5
	HDP0Fmmj0soHErOChs7oWOtXz5U9LyhFCwShm+BXG2VeIMy7OZ7666t7qdwFSLjTcxsfZPkLpSg1E
	5GRNkLMpGNIwA7f4uUCSt9/wzJMeZxwnxwM6C+tybjCppG9qe2H1f4a4D7qbQ34tVZkNiZGA35iwT
	Bx7GABzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeLqc-00BEEh-PT; Fri, 30 Sep 2022 19:38:58 +0000
Received: from mail-pj1-f45.google.com ([209.85.216.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeLqZ-00BED2-Ew
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 19:38:56 +0000
Received: by mail-pj1-f45.google.com with SMTP id 8-20020a17090a0b8800b00205d8564b11so5099580pjr.5
        for <linux-nvme@lists.infradead.org>; Fri, 30 Sep 2022 12:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gjDYcfQrPymPgf4zZHF6ExZnXFdO/ag78V3ukKEreZ8=;
        b=xjwCgB7TqtQZeemx7ZYeSg7WZsmI64FvSs/cgFCYp7SloYiHKCsVY4yvs9SwozpkNU
         KDuzxNzziCfApdQshpyif1GO7Jjcu9nFBZInAKiZvrvG9qAAEHUXsfHJq6FQDiZr0qGT
         ptwwwLjYmNGFFaaiFfqbmPU9b8mH9IhGKbmwyJhqPnhzXmtQ1cnnElo0ybXagdpnVJ9n
         Amkr0zRWXsQX0u68LLjacNu/90BT6sRutmFdSF43f48tszex5AiCavY2yvV+jBuzUqSW
         NblCHvUDW3wkFV22Ea3KN5n9wYgAGjySctVDL3wDO+psEI5Kvydmq2bdjyWynkS/nOkx
         9eMg==
X-Gm-Message-State: ACrzQf2UcvDB+EaPzzfnMY9fDgKi2k8hkt939sVGoFKWwi+aGoFzRr98
	EWeVcMxK7f87QL4qGtSgT3gR214wuR/stA==
X-Google-Smtp-Source: AMsMyM6wPTQbb/wpm4NYDTyzteu9Ju/f5nYNm4NlJda34lAJsiPgMThwpAp8l1Io6xLGw26w5R/LwQ==
X-Received: by 2002:a17:90b:3149:b0:202:e9e9:632f with SMTP id ip9-20020a17090b314900b00202e9e9632fmr24463065pjb.96.1664566732077;
        Fri, 30 Sep 2022 12:38:52 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:56f2:482f:20c2:1d35? ([2620:15c:211:201:56f2:482f:20c2:1d35])
        by smtp.gmail.com with ESMTPSA id z5-20020aa79f85000000b0052e6c058bccsm2187903pfr.61.2022.09.30.12.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 12:38:51 -0700 (PDT)
Message-ID: <0e5088a5-5408-c5bd-bf97-00803cb5faed@acm.org>
Date: Fri, 30 Sep 2022 12:38:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v15 00/13] support zoned block devices with non-power-of-2
 zone sizes
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Pankaj Raghav <p.raghav@samsung.com>,
 hch@lst.de, Keith Busch <kbusch@kernel.org>
Cc: jaegeuk@kernel.org, agk@redhat.com, gost.dev@samsung.com,
 snitzer@kernel.org, damien.lemoal@opensource.wdc.com,
 linux-kernel@vger.kernel.org, hare@suse.de, matias.bjorling@wdc.com,
 Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, pankydev8@gmail.com, dm-devel@redhat.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CGME20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65@eucas1p1.samsung.com>
 <20220923173618.6899-1-p.raghav@samsung.com>
 <5e9d678f-ffea-e015-53d8-7e80f3deda1e@samsung.com>
 <bd9479f4-ff87-6e5d-296e-e31e669fb148@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <bd9479f4-ff87-6e5d-296e-e31e669fb148@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_123855_531777_EAEF3386 
X-CRM114-Status: GOOD (  14.54  )
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

On 9/30/22 08:13, Jens Axboe wrote:
> On 9/29/22 12:31 AM, Pankaj Raghav wrote:
>>> Hi Jens,
>>>    Please consider this patch series for the 6.1 release.
>>>
>>
>> Hi Jens, Christoph, and Keith,
>>   All the patches have a Reviewed-by tag at this point. Can we queue this up
>> for 6.1?
> 
> It's getting pretty late for 6.1 and I'd really like to have both Christoph
> and Martin sign off on these changes.

Hi Jens,

Agreed that it's getting late for 6.1.

Since this has not been mentioned in the cover letter, I want to add 
that in the near future we will need these patches for Android devices. 
JEDEC is working on supporting zoned storage for UFS devices, the 
storage devices used in all modern Android phones. Although it would be 
possible to make the offset between zone starts a power of two by 
inserting gap zones between data zones, UFS vendors asked not to do this 
and hence need support for zone sizes that are not a power of two. An 
advantage of not having to deal with gap zones is better filesystem 
performance since filesystem extents cannot span gap zones. Having to 
split filesystem extents because of gap zones reduces filesystem 
performance.

Thanks,

Bart.



