Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF1EC04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 02:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aQxaeeJ5JgMVcJcw8Ko279QSx3iejqMvsto3fG7z2rc=; b=Bd85CzgRwY+W6jx1L+0yQNTBVQ
	bjT7ery13Qq7THPPP5toBX4NbPH2mTHAkIMs/k9S6wg4/NUBDfeNMbTM81vnzeH0sBVxiyC5R06oy
	KphOQOgiTAI6Qbu7RI3EvvRakN/DDuWDdaI3Kc/898/y8CVYeXJr6TPsvUITmW528gL8XpuChP13c
	NyD6wPtBvO2d8+JgryJ7fljD+3PEPb7Kpr9GbHbA1w3nkgtbbZLcRNwH+/9r/eAefXAeab00vKRF5
	qXzPQaNg1MJd1kUYZNsX5iYMFFrZoAq3pBDrY2qHLlaBrWQpf+oi/X17OcV+xqqqtpKFGGToGdNhK
	O6dYY47A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGtiw-003EVQ-Fs; Thu, 28 Jul 2022 02:58:06 +0000
Received: from mail-pj1-f51.google.com ([209.85.216.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGtiu-003ETO-90
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 02:58:05 +0000
Received: by mail-pj1-f51.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so875026pjl.0
        for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 19:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aQxaeeJ5JgMVcJcw8Ko279QSx3iejqMvsto3fG7z2rc=;
        b=eKrQpnDhhLIiU0vTE9rO8QLNE65ONngluLXdInDo0BgmKdbexIYj2KSXdXeTPoHoFM
         y9beeFyBw1NaEtdqxcpc6YHoflsR+EjWlhyU92dO7GH+DyS0zBeXpcuYaDU1g5P5Oy6H
         oP6YJVq0wbTZ3ukEvB7YMxDUkYltgDt8pItHztW+jifo0N90GxtYDaQdCzu4GMKnNTkF
         EFN2Tuhhs/Nzu5MY+HNVapmWppdUukKSAQbJRdbhI/k1/CGz+77EoWdFvFy5hNcUZPgP
         kr+vvvfFmiJoASISIoQqoL18LdmmR08qTP6q7mqtKTYcmu5CTJJRvxj/N6vrv7YIMruM
         VpfA==
X-Gm-Message-State: AJIora/iohEiudM0KE8kUzQa8ffgJCsZPuZH7YHwIUqY9vZWbxgkRSvc
	ULibNlEeaUEgdyzpjIldcCw=
X-Google-Smtp-Source: AGRyM1vzNaQ3usdPkws9TvBM7VWRcatZbgUmBSHGre6iDPg8J6DngaQMIdNpC0DUbU1GPefINTER8g==
X-Received: by 2002:a17:902:d590:b0:16d:8a08:fa7d with SMTP id k16-20020a170902d59000b0016d8a08fa7dmr13863590plh.122.1658977083051;
        Wed, 27 Jul 2022 19:58:03 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7990b000000b005281d926733sm14543586pff.199.2022.07.27.19.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 19:58:02 -0700 (PDT)
Message-ID: <024d16ac-d685-0fcf-1ad3-e99946852b03@acm.org>
Date: Wed, 27 Jul 2022 19:58:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 00/11] support non power of 2 zoned device
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, axboe@kernel.dk,
 snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc: matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, hare@suse.de, linux-block@vger.kernel.org,
 pankydev8@gmail.com, jaegeuk@kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org
References: <CGME20220727162246eucas1p1a758799f13d36ba99d30bf92cc5e2754@eucas1p1.samsung.com>
 <20220727162245.209794-1-p.raghav@samsung.com>
 <51255650-ddc2-4f3d-52e5-14007b9ff538@acm.org>
 <f2f29f97-5994-37f9-c922-31158c1c1b9a@opensource.wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f2f29f97-5994-37f9-c922-31158c1c1b9a@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_195804_348464_0939456C 
X-CRM114-Status: GOOD (  13.06  )
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

On 7/27/22 18:52, Damien Le Moal wrote:
> On 7/28/22 08:19, Bart Van Assche wrote:
>> On 7/27/22 09:22, Pankaj Raghav wrote:
>>> This series adds support to npo2 zoned devices in the block and nvme
>>> layer and a new **dm target** is added: dm-po2z-target. This new
>>> target will be initially used for filesystems such as btrfs and
>>> f2fs that does not have native npo2 zone support.
>>
>> Should any SCSI changes be included in this patch series? From sd_zbc.c:
>>
>> 	if (!is_power_of_2(zone_blocks)) {
>> 		sd_printk(KERN_ERR, sdkp,
>> 			  "Zone size %llu is not a power of two.\n",
>> 			  zone_blocks);
>> 		return -EINVAL;
>> 	}
> 
> There are no non-power of 2 SMR drives on the market and no plans to have
> any as far as I know. Users want power of 2 zone size. So I think it is
> better to leave sd_zbc & scsi_debug as is for now.

Zoned UFS devices will support ZBC and may have a zone size that is not 
a power of two.

Thanks,

Bart.

