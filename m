Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4D8C19F29
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 23:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kOepgtwcdLQRP/qRZeoxPArZsGP7iFtltMUiXWZxlTA=; b=3hpVYw0PXttswuxJcpQgJ7QPI7
	2AbIijMpPq3tXhrda3fCa0cZJUJ2IixoKJXQzN/T3FV67fnRI5Q1BKamlpXjp8dqrjcYz9s8YwufK
	l3IT2aa5CrQHDRv0AsACNVoNXzltXugJT4QOdy6zARrjAIUuueyePAqNv/Hqm+okgxc8k1L0yoLoK
	54Zfr6MQmssSt+mhUEBGpHfbyAd7P/e7OuO7Tg4kzOG8m8w4hpuIUfM5wquV3TAXMJsl4oslHmUmN
	MD8pRKaPHIxgkYjIhAnl3rGxtpB+7ULkKXlu9Bu0fj6droXbQaSVKLCw3RrXiQmkjJuKIDLekl5In
	d+V/XIOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGqJe-001OXh-6Y; Wed, 27 Jul 2022 23:19:46 +0000
Received: from mail-pl1-f172.google.com ([209.85.214.172])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGqJa-001OUw-SU
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 23:19:44 +0000
Received: by mail-pl1-f172.google.com with SMTP id z19so319419plb.1
        for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 16:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kOepgtwcdLQRP/qRZeoxPArZsGP7iFtltMUiXWZxlTA=;
        b=8P3m1wMcu0vRZu37sK7XcN7KulAO/UUz4K6amWzAfBpSBLoBOu6S9FcRTuhA4hFANH
         Q2hFU2JAu4d0b10oTMxn8ncQrWcEkThG1JvoTf27J/Y/O1uIGQXDiYSeqVyhOsKKGW4G
         MDzzvSW7vPADVgyoL3R4gaTMS8EryLgoMnLI/p9ihYRNP3v+UlmfmD4zd8xzILYP05OR
         0kRufnhgVghzF0TfbdEaw964/eO+/j8fOUSk4PYsasLh2GstIrIbywJIhMVC56RZ8RYC
         IS//Z9ldzxp5OGQE0tgdkWF34XpTqAaQNzHNhIz01DRyW9NeJatJoy1PGEDB2OG2sSA3
         J7aA==
X-Gm-Message-State: AJIora+cg5rNh8DUeWggltbtZkuU5s3Hjor3C4lC3QFPdJ5kOyGx+KUy
	3/bBsis6f/SWeLNwQ4OYvvk=
X-Google-Smtp-Source: AGRyM1v4arIrU8OrBsKV8oknRZWNQ7p4sPrLDkPKFw6Y11E+aVKagxx/UxaZflYaD5XeZX1L1eA7ig==
X-Received: by 2002:a17:903:2282:b0:16c:500f:b78e with SMTP id b2-20020a170903228200b0016c500fb78emr23736794plh.49.1658963981476;
        Wed, 27 Jul 2022 16:19:41 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a84e:2ec1:1b57:b033? ([2620:15c:211:201:a84e:2ec1:1b57:b033])
        by smtp.gmail.com with ESMTPSA id q13-20020a65684d000000b00419cde333eesm12516908pgt.64.2022.07.27.16.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 16:19:40 -0700 (PDT)
Message-ID: <51255650-ddc2-4f3d-52e5-14007b9ff538@acm.org>
Date: Wed, 27 Jul 2022 16:19:38 -0700
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
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220727162245.209794-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_161942_999007_F7F933B5 
X-CRM114-Status: GOOD (  11.16  )
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

On 7/27/22 09:22, Pankaj Raghav wrote:
> This series adds support to npo2 zoned devices in the block and nvme
> layer and a new **dm target** is added: dm-po2z-target. This new
> target will be initially used for filesystems such as btrfs and
> f2fs that does not have native npo2 zone support.

Should any SCSI changes be included in this patch series? From sd_zbc.c:

	if (!is_power_of_2(zone_blocks)) {
		sd_printk(KERN_ERR, sdkp,
			  "Zone size %llu is not a power of two.\n",
			  zone_blocks);
		return -EINVAL;
	}

Thanks,

Bart.

