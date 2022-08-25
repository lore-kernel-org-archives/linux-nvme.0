Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7028ECAAA2
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 21:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lGNBkkp4BBDEjfSCq8/qdn5/LeotKxcjg6+Pkd51G6g=; b=GqpWomDEzDsGjYrkK/0oNf7wZK
	V8DlP6L0avWr6F5bL92PaGpSfz6umkcvf01yi9RV4N87zk/FSZTIScd1YgVKhhLXjV3MyUW3i7mEE
	JbQUhM6Z9iXfi577i4382boXQ79FgmE3McLdTmdhYAGRHGOByHlLtaFTi7Hs3rwEzX2I7mIqr2391
	DWciGX2Oj/HFFXgqsq1NUhD8gmaqVf01KTtHSItAbietw9xIYpIlQInMOLXg57pW+BOLTq8A4wT8I
	rD9xfhZnTxCyoS7SjmZWZbKnOGegX+k0czQlWWVRJmaBfa7nnDdVWbx9A2ZV595LtY5Ep9w+vdNsm
	Y19Of4Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRKrq-003exF-7e; Thu, 25 Aug 2022 21:58:26 +0000
Received: from mail-pl1-f172.google.com ([209.85.214.172])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRKf3-003Xgp-3t
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 21:45:14 +0000
Received: by mail-pl1-f172.google.com with SMTP id v23so14343720plo.9
        for <linux-nvme@lists.infradead.org>; Thu, 25 Aug 2022 14:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=lGNBkkp4BBDEjfSCq8/qdn5/LeotKxcjg6+Pkd51G6g=;
        b=LtTup6sqHBuziBAtiuNp2msnwfK8hV1CxI8FC1PRtY5z0G0v9iCXYta1SH7gHmPCPd
         ewGDD8tM7m2KKEnHuiNiF1XACYKnR6HMnW+eE41+DrRGcnhWPI76cBsW0TGkRdCqljG3
         XNA7dqQxlsjY41w2zPmjHWKZaaD1XyGomtakTFd1UTWPO0NUXGHEj+c5XzantVTyamK2
         CyAJiGXlRKjueN9MHTQ1Kz4OWyP2af5KciVeaAicxzNAwiEFPJ4JtLv9BXy44Darj6pG
         LV0o3AyTrz8fshmANGM4jHg6Pzg86hfcntdM7dxgF3mt7YRfMc0wktYQtuin2sUcy/Qr
         hpcQ==
X-Gm-Message-State: ACgBeo1JaNAGfD/RQS0cf1HgOmAnvxJQUI2Vg+4EQhXpBt7ixQGED2bn
	RyxurT/24mjJjCbjCSNO5Hs=
X-Google-Smtp-Source: AA6agR58tZ3AbGEr4+IDC4kJWx8+thB6yGtM5mk3JNCEDcPv9jIHtgQv1Iqu8vhglb6GJZCV3zC9Ag==
X-Received: by 2002:a17:903:2310:b0:173:10e1:3a76 with SMTP id d16-20020a170903231000b0017310e13a76mr991620plh.160.1661463909550;
        Thu, 25 Aug 2022 14:45:09 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:349c:3078:d005:5a7e? ([2620:15c:211:201:349c:3078:d005:5a7e])
        by smtp.gmail.com with ESMTPSA id oe3-20020a17090b394300b001f5513f6fb9sm209053pjb.14.2022.08.25.14.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:45:08 -0700 (PDT)
Message-ID: <66c80b87-da28-bc9c-11c3-7a9f7354fa15@acm.org>
Date: Thu, 25 Aug 2022 14:45:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v12 02/13] block:rearrange
 bdev_{is_zoned,zone_sectors,get_queue} helpers in blkdev.h
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, agk@redhat.com, snitzer@kernel.org,
 axboe@kernel.dk, damien.lemoal@opensource.wdc.com, hch@lst.de
Cc: pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
 linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
 jaegeuk@kernel.org, linux-kernel@vger.kernel.org, matias.bjorling@wdc.com,
 gost.dev@samsung.com, linux-nvme@lists.infradead.org
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121903eucas1p230518b312d5260d28e356ba911a27469@eucas1p2.samsung.com>
 <20220823121859.163903-3-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220823121859.163903-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_144513_226556_A9BCFDEE 
X-CRM114-Status: GOOD (  11.39  )
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

On 8/23/22 05:18, Pankaj Raghav wrote:
> Define bdev_is_zoned(), bdev_zone_sectors() and bdev_get_queue() earlier
> in the blkdev.h include file. Simplify bdev_is_zoned() by removing the
> superfluous NULL check for request queue while we are at it.
> 
> This commit has no functional change, and it is a prep patch for allowing
> zoned devices with non-power-of-2 zone sizes in the block layer.

It seems like a space is missing in the patch subject after the colon? 
Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

