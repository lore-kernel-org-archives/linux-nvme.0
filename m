Return-Path: <SRS0=D+H5=A2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBCDC433E7
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 20:26:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D67620672
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 20:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GOIsu4Rr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PpmzzilW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D67620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VJuJ56PgcyXaAlI1bcNhEmkiDvjScr0G6G0MYGGXA4w=; b=GOIsu4RrljZmgo1E/QL3qPlqQ
	B0hZUZ+lCiyPSqKY4/QVVxoshNvnuF0giXmZt1SAZtsbI3kSyK+FAckFz0YVCW/Ou5ZhRUz70eYRS
	UPRLxMjo9ej84qnEwtM6bNxzBEt6fjhPyD3sqBwO3fhEYRu1JWz+UCf3Z5ZTu4WbrNAwmh2jWNDBY
	wvxYT3WmgGgmRcEZZI4uQjrovGLcQfKoRRAgajDang5pchmd2zwz1uR8vUeUIulblv3tD1soaouxt
	MX/SbLrYefmkQfPDvwuld+XCYpprhlfCOGt56b3iJdoY4i37eCBegWyCclGCgFGsWTWvpJbGbZwNn
	3BHsN1/2Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvnzS-0006yQ-AA; Wed, 15 Jul 2020 20:26:54 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvnzP-0006xX-1S
 for linux-nvme@lists.infradead.org; Wed, 15 Jul 2020 20:26:52 +0000
Received: by mail-io1-xd41.google.com with SMTP id c16so3640998ioi.9
 for <linux-nvme@lists.infradead.org>; Wed, 15 Jul 2020 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ef4z+9Yicabx/PBiZK3UH32DMjpUIF0+c5gTonOKaqA=;
 b=PpmzzilWUzM1i/qTP1Ch+MKMpdOU0msPV2HQZbI56F4OnSxOQ8SwWWVRNy6yrunVFH
 /w24G6AhWABCKBxq6W9DTrAwMGwhOuy74V6lF49lC3Dn3xWDMQqxDo1EWGsZ5dGjALMH
 eKhOy4CqgkZMRcuq/fqcecn9cyJ7H+Yv1MO8xjTUKm4TuhrfEkgXklAPRnIuQcUzN8xr
 vKSGMpt1eM60SB5Fe5mTpyKY675HJSLlKGPjEdl6bOa6o0Fpqvzrih5jCMxo5TfUO56l
 5MIg7m2BAdA0m8B3lbtrPoqhWKvHW7RheAaBBo/OMNlQqwmamVkGPYNgmo7HwR9BQ84h
 kPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ef4z+9Yicabx/PBiZK3UH32DMjpUIF0+c5gTonOKaqA=;
 b=nBHkol8sbQIyHdfZB249/SId00mP5XyDiT64vExl16+Fk4a3fPvdXk0Ii+Cju57rlx
 xBsoMEjcD6TzuNAdvZDwp/n1PZ7g60zmz4UKovHgjzhaxCMILLNJ41AjuP1x59CA/Pqg
 mUMLiJkr0aVG8PpGEobS5RSE3yL7pEpLl/JoJdIsCZbr9/XyTfQBs5zUc8gKcsc6+iS0
 ZSS/rmkzslv/KVNA3rSX3dgwlpYYOhOI4kZdErN6mSEU5pZlF02Mu2POc4SvpvWltv/X
 JG0LnuD9nX+oMpXLFG/pEvFhiq9XfPE2I5sn6K9umTgtEvh6uKYZD/9I8CXV/qRwjtKC
 N9LA==
X-Gm-Message-State: AOAM5318m3RECkw6wX/xNMwC9HoYIySY4+nlUk2atMxCrNApJy61gNFm
 Q6ejZrMta+FBP35K3I3v0kRsEg==
X-Google-Smtp-Source: ABdhPJxIVAK2QRW9sFfypKnRyRWe+EJVbCx66CK31VkDVrrWNAVS7DR5AIM8zVPWgrqC3n6xFAXg0A==
X-Received: by 2002:a6b:640f:: with SMTP id t15mr1044364iog.175.1594844809116; 
 Wed, 15 Jul 2020 13:26:49 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id a11sm1736327iow.26.2020.07.15.13.26.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2020 13:26:48 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] Export max open zones and max active zones to sysfs
To: Niklas Cassel <niklas.cassel@wdc.com>, Jonathan Corbet <corbet@lwn.net>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, "James E.J. Bottomley"
 <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20200714211824.759224-1-niklas.cassel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <58eac7f6-ab09-7f96-eb02-a19e8153e89a@kernel.dk>
Date: Wed, 15 Jul 2020 14:26:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714211824.759224-1-niklas.cassel@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200715_162651_519850_48BABF52 
X-CRM114-Status: GOOD (  16.91  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/14/20 3:18 PM, Niklas Cassel wrote:
> Export max open zones and max active zones to sysfs.
> 
> This patch series in based on Jens's linux-block/for-next branch.
> 
> All zoned block devices in the kernel utilize the "zoned block device
> support" (CONFIG_BLK_DEV_ZONED).
> 
> The Zoned Namespace Command Set Specification defines two different
> resource limits: Max Open Resources and Max Active Resources.
> 
> The ZAC and ZBC standards define a MAXIMUM NUMBER OF OPEN SEQUENTIAL WRITE
> REQUIRED ZONES field.
> 
> 
> Since the ZNS Max Open Resources field has the same purpose as the ZAC/ZBC
> field, (the ZNS field is 0's based, the ZAC/ZBC field isn't), create a
> common "max_open_zones" definition in the sysfs documentation, and export
> both the ZNS field and the ZAC/ZBC field according to this new common
> definition.
> 
> The ZNS Max Active Resources field does not have an equivalent field in
> ZAC/ZBC, however, since both ZAC/ZBC and ZNS utilize the "zoned block
> device support" in the kernel, create a "max_active_zones" definition in
> the sysfs documentation, similar to "max_open_zones", and export it
> according to this new definition. For ZAC/ZBC devices, this field will be
> exported as 0, meaning "no limit".

Applied, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
