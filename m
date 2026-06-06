Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CCCCD8C88
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Jun 2026 16:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0CCEPdnbAf9O7YZGI5gomWMwSVZTv0vCb5M8aGMFXew=; b=Xq/pL/dCApbcXfBtopxzC4cxFM
	toQmuFgqLsC8TU9z95mM9FDpf5AHar8kj38RCxhAee01e+mXjnQowxIg8PKYPXb0bHupmAadMu17w
	y5IVI/NKZ7Pk9IBpjzIeRDbcF8KOaEa06nH5+ZiTV84n156uJ7KFfbDS2cj0XZ1EBgagGqKGUawuK
	3msvE3u8whIBFqWlGB1yjH5YcQPrz+nCI7dDuY5hnvl1l0SiGKlB1QJyily8TLRlc15XAnqTHhjtm
	EeWQ/lGliJQTp7gjJN13SPEKlQayBtH0DsjG9aKkmtd1xRtzpF+AbQAlwLP5znUbJn7y6tke4jUdr
	hRC0R10A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVuA1-00000001iXK-13FW;
	Sat, 06 Jun 2026 16:46:13 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVu9y-00000001iW2-11Op
	for linux-nvme@lists.infradead.org;
	Sat, 06 Jun 2026 16:46:11 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-36b903567fdso2986990a91.1
        for <linux-nvme@lists.infradead.org>; Sat, 06 Jun 2026 09:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780764369; x=1781369169; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0CCEPdnbAf9O7YZGI5gomWMwSVZTv0vCb5M8aGMFXew=;
        b=boliuFEvrnPyh/Kj4HBG4ukAdBkTeX44dy7fMLP+x6zuKbuSMP5pg24kgeUwICtlgs
         6HJbpBSJh/Gh3ucA6tuVoFxUQqpnHGoADpl2GIHn5Tc+g4b4IZE+BsLP6qI2W1lz6JMJ
         iJSNhq4xS+Ok8IZQH3G+nt4nJUb2HGapkuks9Lt8I2Qrk4DD83n8P4eN/q9NzLmZSZrY
         RAQeX7JlGeAP3UkfEKwEWzxMSGrcxRKFGNHFOaqTbXUy7CZjY7EGooj+Dy4Fvz6qksEG
         qx28pzdQavGwQ1J+pwwV0y9cov2cMIZtPLEVeA7VpYpTsJGjnGBAG6XETLLChwIEhVmG
         2d3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780764369; x=1781369169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CCEPdnbAf9O7YZGI5gomWMwSVZTv0vCb5M8aGMFXew=;
        b=eEoRmrzF1nziosRHTrOcJg6w4HuKpCtPG6UUJOo49LtoX6PcT7HnhsA+2l8pj3xN5V
         eytKjvqLG/R9T7UUdkG5SarT9HcKwK/9qYzbLUV0+LiFswm29j1F3RpHAjTAPoTtplTV
         C++DsxTRt81CyI+btglXPeAF3GLEY3rKOk7LchDSr171VbwNEGTAioOUFumKfiEk0yXF
         iPcdFY+Gi4Q7oJkDc/XLbJDNLR+QX2uKTV9O0JRpfhtOXM0D4JeOIDFqTFsYF6RZZrgP
         qAGAllKDrA4x6kRLysiedcBYj4k0iqd2QYiZCmtmR2mg5dCUCgJSpm47zcDhe2p1b9Pk
         tvaw==
X-Forwarded-Encrypted: i=1; AFNElJ/oqBFk6lp3pln8IniBdBk8ABimTe/F/aW7y7/aqSXvuhkoiIqR+R1x0WN6QtTxeSHjUTWzqgyH927o@lists.infradead.org
X-Gm-Message-State: AOJu0YwqRETGeOos2nuqInvriVf+BKzL4FXcCBYIhH1pmNsePLZNE0Wp
	qzyGp1DmWEZvGNS5/5MdCBgEHF43ajesVfzibXUJBnJXdQRIReDeTm2r
X-Gm-Gg: Acq92OHtzdoHG8quEFOqrojd1LtTju/HTM85/0uXRIt6cp66rD/hqSxqsTlbM3Y2YzD
	zjRgrIlcoTAa1T9bwzLZj+VjRoN8oCcAh7IywHJGECnQl1TjD83AxZJaabI9ERgzvt7FLJXnW7o
	spfL7gkhqU3xfeIEfZ5xcfUR0PPWoHibOm/+cuIn3d1TMIExR/3j7Sn6fYT9pBB2G8+YdOQ1zLA
	SdgSFovSr7DfJ7Sone//PdsLz1mLBn3k4ziPOLougL0QG93+8+STe9GW3CPmPSoGmw7dGJo7WTJ
	O69wl2VKFwUuLVmiFzZ4sh/FjqaATEgP0/92G3jGL0rdE1o/R6LK3yawHq9ynCL4hjJu8vlv/RE
	ookjtCfIt6z3lFkg5Jh9ra3l+wAxERQTBICFzVsfE9o81xi9b1yOOtFjDjmzz64D1LQcdYL7cMS
	hHK+vXa5VsJil6njf5UrJkDNVT00jhvRTF4L9LhnF0uQ==
X-Received: by 2002:a17:90b:1ccd:b0:368:a297:bd38 with SMTP id 98e67ed59e1d1-370eedfff8dmr9852447a91.7.1780764369256;
        Sat, 06 Jun 2026 09:46:09 -0700 (PDT)
Received: from [192.168.1.111] ([223.122.38.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f714e26afsm10414758a91.17.2026.06.06.09.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 09:46:08 -0700 (PDT)
Message-ID: <b791aed1-cd05-45cd-973b-4d8bef27ee7c@gmail.com>
Date: Sun, 7 Jun 2026 00:46:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-apple: Prevent tag collision across queues even
 if tag space is shared
Content-Language: en-MW
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Yuriy Havrylyuk <yhavry@gmail.com>
References: <20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com>
 <20260606-prevent-tag-collision-t8015-v1-2-93ccf4eca550@gmail.com>
 <a0b0bea4-998e-4196-a2b0-9fcaf531d9f3@kernel.org>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <a0b0bea4-998e-4196-a2b0-9fcaf531d9f3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260606_094610_282576_ABC91BA0 
X-CRM114-Status: GOOD (  14.53  )
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



Sven Peter 於 2026/6/7 凌晨12:12 寫道:
> On 06.06.26 15:25, Nick Chan wrote:
>> From: Yuriy Havrylyuk <yhavry@gmail.com>
>>
>> Apple NVMe controllers require tags of pending commands to not be shared
>> across admin and IO queues. However, on Apple A11 without linear SQ, it is
>> not possible for either queue to skip over some tags and must go from 0 to
>> the configured maximum before wrapping around.
>>
>> If a pending command tag is duplicated across queues, the firmware
>> crashes with: "duplicate tag error for tag N", with N being the tag.
>>
>> Instead of partitioning the tag space, which is not possible without
>> linear SQ, 
> 
> Isn't that just what the pci.c driver does with NVME_QUIRK_SHARED_TAGS 
> for the T2 macs or what we do in this driver with
> 	if (anv->hw->has_lsq_nvmmu)
> 		anv->tagset.reserved_tags = APPLE_NVME_AQ_DEPTH;
> ?

After adjusting the apple_nvme_submit_cmd_t8015() function to account for
the admin queue depth, it seems that the existing workaround for M1 of
reserving two tags for the admin queue works on A11 as well.

Will post a much simplified v2.

Best regards,
Nick Chan

> 
> 
> Sven
> 


