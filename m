Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD34C04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 13:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KVAZ1OoYcDPkaYDmhjB+rFFypTllysidvXvCw8//pAg=; b=CjxjINFM1L1eE09UrQZNuqcqKd
	+W/aI4NiiwSTizKbqz+mtNYU85C09+iup9wvz/MtFYGTBWXAldy/xvYE0UR1NMX1pgO7iEAfdK6fg
	Bn1psTZlGi1APOL5GnqBnIPIFGy/hMg9puksRSeXEjmsodQrmOdShh6J44Bia/dqDL89ShKri4DYy
	NZp6rQSmJHmID4IwoHsApWFAYf7UWiWM+qixR3/BPhOXaq6XqloYAfE7oh/Jbwa+QNcPh0oW3oiV3
	KTpcbZcsXgJ9NmtKtFTe+rueDlEq1mm0oUXSSRLudOV47FXz1a2rowawViI15J6inIFzyK/6Fd1wI
	nIb/lBrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oH3Zl-009gwp-Kg; Thu, 28 Jul 2022 13:29:17 +0000
Received: from mail-pl1-f175.google.com ([209.85.214.175])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oH3Zi-009gul-P3
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 13:29:16 +0000
Received: by mail-pl1-f175.google.com with SMTP id v18so1796785plo.8
        for <linux-nvme@lists.infradead.org>; Thu, 28 Jul 2022 06:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KVAZ1OoYcDPkaYDmhjB+rFFypTllysidvXvCw8//pAg=;
        b=NUfxB53bFwBPznUCJkQeXPID1N7wgrXa/zwoSABYbHKKVq7MSWdKQxTc25H4XwzJe5
         kxBnQDjosWrd27Who9ZfuQ2U3UTjPeKqnGV/bUc7om1dopQWvPrt65ycarzlL3jur2dH
         peJIzSrJZNb3CJK4K6y9699feYTKDINhYIlfIG0rGWDfTIxF4DPBtVdEx85mAU5Z2hRk
         /U7BmBSyyhRdfNubx9rHVlRak5+LJsqmaVZ3YxBl6f5S82pX3TzPv8PFmSovPL2pkZ+W
         DF43NOMkvTq2oxchOOUhtQYdePEGEcysi65pnEYA2NC6QHSn7CKQwihHLSyB03hk3Np9
         yNLQ==
X-Gm-Message-State: AJIora806HgflJntCIlyDMOXIqAHWPHTPmeJm3JiPsq0ooSecZJ5qyOe
	+qRSlrZgj88C2O1sjDOFknU=
X-Google-Smtp-Source: AGRyM1sVlJ4VxZdri5AJaXpK+abw9sqfSjFByJuWKJUf33Qsr5XtcruBoEo93wrUA8fG42N8cHOiXg==
X-Received: by 2002:a17:902:70c4:b0:16c:5306:9172 with SMTP id l4-20020a17090270c400b0016c53069172mr26736583plt.171.1659014952312;
        Thu, 28 Jul 2022 06:29:12 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id h1-20020aa796c1000000b0052b66304d54sm742466pfq.74.2022.07.28.06.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 06:29:11 -0700 (PDT)
Message-ID: <514f85ce-84fc-1186-7169-a29d7118e8cc@acm.org>
Date: Thu, 28 Jul 2022 06:29:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 02/11] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, damien.lemoal@opensource.wdc.com,
 hch@lst.de, axboe@kernel.dk, snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc: matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, hare@suse.de, linux-block@vger.kernel.org,
 pankydev8@gmail.com, jaegeuk@kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, Luis Chamberlain <mcgrof@kernel.org>
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9@eucas1p2.samsung.com>
 <20220727162245.209794-3-p.raghav@samsung.com>
 <7984b969-9025-6b31-2645-da08daeefafb@acm.org>
 <eed7d9ee-fd7f-e57c-598e-909dbb0d2380@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <eed7d9ee-fd7f-e57c-598e-909dbb0d2380@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_062914_854263_977125A5 
X-CRM114-Status: GOOD (  17.13  )
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

On 7/28/22 05:11, Pankaj Raghav wrote:
> On 2022-07-28 01:16, Bart Van Assche wrote:
>> The bdev_is_zone_start() name seems more clear to me than
>> bdev_is_zone_aligned(). Has there already been a discussion about which
>> name to use for this function?
>>
> The reason I did s/bdev_is_zone_start/bdev_is_zone_aligned is that this
> name makes more sense for also checking if a given size is a multiple of
> zone sectors for e.g., used in PATCH 9:
> 
> -		if (len & (zone_sectors - 1)) {
> +		if (!bdev_is_zone_aligned(bdev, len)) {
> 
> I felt `bdev_is_zone_aligned` fits the use case of checking if the
> sector starts at the start of a zone and also check if a given length of
> sectors also align with the zone sectors. bdev_is_zone_start does not
> make the intention clear for the latter use case IMO.
> 
> But I am fine with going back to bdev_is_zone_start if you and Damien
> feel strongly otherwise.
The "zone start LBA" terminology occurs in ZBC-1, ZBC-2 and ZNS but 
"zone aligned" not. I prefer "zone start" because it is clear, 
unambiguous and because it has the same meaning as in the corresponding 
standards documents. I propose to proceed as follows for checking 
whether a number of LBAs is a multiple of the zone length:
* Either use bdev_is_zone_start() directly.
* Or introduce a synonym for bdev_is_zone_start() with an appropriate 
name, e.g. bdev_is_zone_len_multiple().

Thanks,

Bart.

