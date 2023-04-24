Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E79C77B61
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 14:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r4eskZUVcjnMiLu1WZUJV4Ld+HSv75xTb3KF5hv2ytQ=; b=TXpS1TgkDDj32AMLw9YBv/lT0S
	X7++1+exeCJs/E20HtIziRu09SzVZKxQF22u49ylbtaxcWXA3tz/VstPubJ5imEycHCi6Akl5/du4
	IMAM6egOOZOsPw2kY/WaT9OtJ1pnngDkj4UA7vBHDo2M7b0qTvzgJV8AU9cFxxoNRK7pKXvm5VilP
	HubPlH27xHC6klappdls6JorTNxIxKzU4Sgyjqah561KQh1s48BQi6AvbDe6lLQZHQbp0/bKQdB2J
	UYqs8dRPmMgXJu1QoJrb1P5S+lc4y9KTJml1zQJnXGrZGcFvg276ugltjnY+PfkSV6mNFiev4sE+E
	8aa4cZ6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqwnw-00GWVj-2U;
	Mon, 24 Apr 2023 14:04:32 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqwnu-00GWU4-0O
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 14:04:31 +0000
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-32ae537c23fso1745365ab.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Apr 2023 07:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682345065; x=1684937065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r4eskZUVcjnMiLu1WZUJV4Ld+HSv75xTb3KF5hv2ytQ=;
        b=SrKEaPrxesGeUAPIgAbvRdnR40v1JV3NsJQejvBd/7+DB7yqBNYOvaPBVDCUUMhffK
         1FDN3sqiPio+bZhByOAC1il0qfxX6q+ijfaWzKPrLPgnJuid98L/2VrQbS4znRhLW3hz
         7D0ootOwY4sBo9ahjsJzg3gN9uL7ueO75DI70PCOEo713GoVL5aJwa16b5ZEJBgsQY0T
         KqJMsjF/7B4jGArJ61OhCbYMghz5O6R3tBVJhcvigDYH+7Y5WuLuin1ZUGGIrsDrd7Pl
         jgfupGVH/s3435qz7TYkhUsbePoiM80MbFUcoAGk8Yp2r5QIUFRZE0oUHn/Anr2qwHyN
         5+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682345065; x=1684937065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4eskZUVcjnMiLu1WZUJV4Ld+HSv75xTb3KF5hv2ytQ=;
        b=mD7Wy23QJYQWs6SMNk6OtCopeFL3NyuODORzTEFFSnVSZWyhNDwhWvsLqYX9Fdktkh
         N5UpfMY/yNJCvhtDPUNUoBgsP/f6ExSCg42FcrAf+SBCVUilcE1JyFI8ZQLQ4OKhQS2W
         SQPr0hb7i+QxmVecKvETeRUUxF8VP1nGOXjor7P6prtEBUtizl0+6WCJbmOqwbN2HKAn
         6tjYObwbMWlePe2zx4hluxb8nx+j+xNSG2LfpGJuis+2jIJcaAeXKBGogz1T1KLCY2Gx
         RjS52A1CDdjBL4n4FB5H+Jd3nt36YEURLeCy24Hxf6n5PM2rYjyD38g8oUxGkx3KChz+
         7WDw==
X-Gm-Message-State: AAQBX9cG1GrwNfCWqm+obckaw3rl2W8ZQ1MHQo4mzDhnDdOgxiP331PX
	V7g9PMfl8xOI4vXSAUq8CqQOUQ==
X-Google-Smtp-Source: AKy350Z9bK7VVpcmK2iAVeEzk47TdwrSkQttujXV6MaHKCoGfPOx2IuLksokrUJ6Pzzs0EMdGXb+tQ==
X-Received: by 2002:a05:6602:26c2:b0:760:ebcb:957 with SMTP id g2-20020a05660226c200b00760ebcb0957mr9831899ioo.2.1682345065313;
        Mon, 24 Apr 2023 07:04:25 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id w123-20020a025d81000000b0040fad79ac08sm3412273jaa.89.2023.04.24.07.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 07:04:24 -0700 (PDT)
Message-ID: <4eb35ad9-7422-fd9d-36ea-3f1ef895917e@kernel.dk>
Date: Mon, 24 Apr 2023 08:04:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 1/1] nvme: add a dedicated .c file for sysfs interface
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
 hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org
Cc: oren@nvidia.com, israelr@nvidia.com
References: <20230424130316.25805-1-mgurtovoy@nvidia.com>
 <ff1eb7b3-890a-7f12-94ad-6951bb1533ab@grimberg.me>
 <980a8241-407f-a3eb-a1b9-d5eb1ae0ecf5@kernel.dk>
 <97b1df55-33c7-d31c-d99a-6c6f5fe4f361@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <97b1df55-33c7-d31c-d99a-6c6f5fe4f361@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_070430_164808_C6383A3D 
X-CRM114-Status: UNSURE (   8.33  )
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

On 4/24/23 8:01?AM, Max Gurtovoy wrote:
> If the only comments I get is for copyright then we're good I guess ?

Didn't closely review it, but conceptually I agree with the change.
Declutters core.c and usually there's little need to touch the sysfs
bits.

-- 
Jens Axboe


