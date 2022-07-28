Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C0FC04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RdplHWE21v7uW0csMEy8w+746Uk8pAL1Z4Zo/u66MRc=; b=LYer5IcIciCE3cv5BwFNci5Y+a
	ivXIEZVyQgqeX3INdmRIGzn4WGTzqLUVdrO6ow2PHu81GML/OFGR+JHCQiORZkTuJVLhKsu7FYCMq
	hhG7rxlpH48UTR7/UOC8PZqonH2lbgCnmQwd2ArvdGD9ceigg2gEGaalEGjsMdAfaVsuzeppzdik3
	WZKR4KCVfqbsoBY7Q/Up6RpXPv/nXDlxAHHUqUOwwNMP8u2yuJdttambPVWGA86SpyEHo+rlM6ih9
	kRlZ4KrmsAptjH06doQ5gIVMqOnt9krq/qFWujpsRQ83wr+imxX2G5/2DceSw+UoEcJvU/NjZNU1c
	uoa3lASA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oH3ar-009hej-3m; Thu, 28 Jul 2022 13:30:25 +0000
Received: from mail-pf1-f177.google.com ([209.85.210.177])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oH3ao-009hbz-95
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 13:30:23 +0000
Received: by mail-pf1-f177.google.com with SMTP id y141so1933661pfb.7
        for <linux-nvme@lists.infradead.org>; Thu, 28 Jul 2022 06:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RdplHWE21v7uW0csMEy8w+746Uk8pAL1Z4Zo/u66MRc=;
        b=oJr5iDy/h+QtbPqB10YSM2AqoEHJORg/7xzb0lOj08uHTSD1DSFvSBgvYQTcym4xOi
         95W8s6AZZdAgAT5Do6Qesdi+WzymV7eoljSVBoDr/mIkTtVZ/nncBDZlSC5ZzJV8gkon
         8UqWSxsnMejfEQKft24bRFdF5l//mrR8L1NRv5NR2WAeD7Dqbjz51X9WPKewLMa02Cbn
         umoUq+e9c8lOBSzFXR+Mo1bR+w9MZQxQ7aeXvmhk7K98LCc+YX0XMN9dOZKT7DuJEPCN
         2ksON0WG+x5kJ5O3WYgIJfBLgwqf/fYaCzcaam07CiG8jltg6kkebrGIcg8ewpVCkRqG
         8OUg==
X-Gm-Message-State: AJIora/rJiiEd6Pa67N2NTfRhPunydo48Q1Mss/XdUfUoB4bD7c29Phf
	ajs2HejJeM+XyR5GswnQRPI=
X-Google-Smtp-Source: AGRyM1sEeS4b6mgBviJJaeM6ot/oR6bsjRTH3rUY3cbgsPHiPvABhB/Is7CL9HzuiOI0PM2NkdpFeg==
X-Received: by 2002:a63:1a56:0:b0:41b:3ef0:4eb1 with SMTP id a22-20020a631a56000000b0041b3ef04eb1mr8174445pgm.207.1659015019399;
        Thu, 28 Jul 2022 06:30:19 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id b2-20020a170903228200b0016a7d9e6548sm1273348plh.262.2022.07.28.06.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 06:30:18 -0700 (PDT)
Message-ID: <6ac6c0b3-ca3a-27da-0b8f-b4c39671bdab@acm.org>
Date: Thu, 28 Jul 2022 06:30:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 00/11] support non power of 2 zoned device
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, damien.lemoal@opensource.wdc.com,
 hch@lst.de, axboe@kernel.dk, snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc: matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, hare@suse.de, linux-block@vger.kernel.org,
 pankydev8@gmail.com, jaegeuk@kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org
References: <CGME20220727162246eucas1p1a758799f13d36ba99d30bf92cc5e2754@eucas1p1.samsung.com>
 <20220727162245.209794-1-p.raghav@samsung.com>
 <51255650-ddc2-4f3d-52e5-14007b9ff538@acm.org>
 <e0606903-c007-43f1-538f-b70ee607be0a@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e0606903-c007-43f1-538f-b70ee607be0a@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_063022_335296_CEF10299 
X-CRM114-Status: GOOD (  15.08  )
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

On 7/28/22 04:57, Pankaj Raghav wrote:
> Hi Bart,
> 
> On 2022-07-28 01:19, Bart Van Assche wrote:
>> On 7/27/22 09:22, Pankaj Raghav wrote:
>>> This series adds support to npo2 zoned devices in the block and nvme
>>> layer and a new **dm target** is added: dm-po2z-target. This new
>>> target will be initially used for filesystems such as btrfs and
>>> f2fs that does not have native npo2 zone support.
>>
>> Should any SCSI changes be included in this patch series? From sd_zbc.c:
>>
>>      if (!is_power_of_2(zone_blocks)) {
>>          sd_printk(KERN_ERR, sdkp,
>>                "Zone size %llu is not a power of two.\n",
>>                zone_blocks);
>>          return -EINVAL;
>>      }
>>
> I would keep these changes out of the current patch series because it
> will also increase the test scope. I think once the block layer
> constraint is removed as a part of this series, we can work on the SCSI
> changes in the next cycle.

That's fine with me.

Thanks,

Bart.

