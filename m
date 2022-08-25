Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F44DECAAA3
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 22:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PoKbqdZjqcMil3GUCh8PrCnRMNvOIz0uCEqvIuzke58=; b=sa2b/iTug4tB8FtfiF4Vlo0X9h
	NoyS+7uWX9RWAq884/GaqsyR8O8qZOtenEmiHZoYt0i8sy92hsZOtmhkZ7en2LuN/RdVGyHHCcIiE
	iHl5oLcyk4H0tbni/croGfmWEByhUClIo9lMlYBlsziln/RNIu++qxGtp8qagnQLQUobsMr9Pb2hd
	jVns/uLnpr+Yh3ndaawWym6hEyKCKXQJkpzimb7h5iMGZ5pir26R944Bzpi1vysHi3zYyTfSGqeXY
	qizV3Q0nowD8BvZWN0Zg1y97yalsxY4brmOeAsLHvtF31pmCjcwoK0ScgFA7eZtzy+CiMDe3HrXUR
	fACG/JcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRKxB-003hvu-98; Thu, 25 Aug 2022 22:03:57 +0000
Received: from mail-pg1-f175.google.com ([209.85.215.175])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRKnJ-003cRX-W1
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 21:53:47 +0000
Received: by mail-pg1-f175.google.com with SMTP id r69so19020287pgr.2
        for <linux-nvme@lists.infradead.org>; Thu, 25 Aug 2022 14:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=PoKbqdZjqcMil3GUCh8PrCnRMNvOIz0uCEqvIuzke58=;
        b=OHUV4gnlBWGpW3AvajxiDA3R3faSbfT1gt3Zd29bBsmN99Z29omwqeDU+sTi8ptBty
         dknS58yq93qtQIbiEAHoWrH6B488rHtS5JdvW+RJZZIphG/uHomNGkCdaIvf9xLq3312
         YNoEB+D37hYEaNINf6D46i2VMfSqVTNb4ybSVU9IKwX33xBGS4PAhtjIjAic2PWd3AsT
         guazfuZIyMtl91zZhlpQDikE+l3w+X6rO0Twrqiu2P+bggtNFWJynY2cKoFbez7xIJYB
         6cCTlpUpGZTQxLMVpmu8M2d20ghSFYHyYaimkCAAcp9WhCt3sil4gvIoYa28rrNVdN8B
         g72A==
X-Gm-Message-State: ACgBeo2bJD1N5Efd+XoNqWaxhx7nYWj48wrF9Zhn+FXNNB4gS8HNNjP4
	anBMKFGB1E+IzgTVcUH9UI8=
X-Google-Smtp-Source: AA6agR4oitY7DdgWzlDg0toNkuqiso8T3oQu+9kbXRQF5gO1MpCeX6jwibhLOIeQZecVmG/fiQTvbA==
X-Received: by 2002:a05:6a00:3497:b0:536:d6a8:6f62 with SMTP id cp23-20020a056a00349700b00536d6a86f62mr1039067pfb.79.1661464424600;
        Thu, 25 Aug 2022 14:53:44 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:349c:3078:d005:5a7e? ([2620:15c:211:201:349c:3078:d005:5a7e])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090a3b0800b001fb0a363c18sm195698pjc.52.2022.08.25.14.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:53:43 -0700 (PDT)
Message-ID: <9e81fd1e-b206-dd8d-4c27-1aa5cdcf4e10@acm.org>
Date: Thu, 25 Aug 2022 14:53:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v12 09/13] dm-zone: use generic helpers to calculate
 offset from zone start
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, agk@redhat.com, snitzer@kernel.org,
 axboe@kernel.dk, damien.lemoal@opensource.wdc.com, hch@lst.de
Cc: pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
 linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
 jaegeuk@kernel.org, linux-kernel@vger.kernel.org, matias.bjorling@wdc.com,
 gost.dev@samsung.com, linux-nvme@lists.infradead.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121911eucas1p2a55dec72a6d780123e6c7655aee72457@eucas1p2.samsung.com>
 <20220823121859.163903-10-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220823121859.163903-10-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_145346_084608_BF6510AF 
X-CRM114-Status: UNSURE (   8.20  )
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

On 8/23/22 05:18, Pankaj Raghav wrote:
> Use the bdev_offset_from_zone_start() helper function to calculate
> the offset from zone start instead of using power of 2 based
> calculation.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>

