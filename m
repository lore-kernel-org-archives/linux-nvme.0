Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0CDC63797
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jan 2023 22:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9wllrSnnUtP2lGzMZ5NnJc5XBcURZs1X9kJ2O+mtnmI=; b=zTu25lgWLF+1KGQwDRCQFsiQQv
	Do/XqeDG92E7KtNoFMCCKvmqjxugyvQnxFHnPSvaIR0Z4AGjr486x4JNY5+Aww5InI5tOAYb0w/6c
	Akp0rzJb0mSrNnj50cFvgFM+hwRG42l0Cm5K+4laQanESHPXmT3fHb703mXluIoSnubFzk5ZQTh4G
	9CIvwl+4xIL+0F5CB6K9EhgzpVGOTVt0t+Ea08PsbhHr9Ey2b/6yFikeKvXH+EVB1yTkyrhoNJx9q
	+n5zWIZvXxbEaICFOW7IJU+L+fMeDKphmunw3qi9Ce/MpIVUxvtYT5Q/jsi81BA3mxSjvmL6kHdIp
	HCdtsqew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDvNH-00FKQi-SJ; Fri, 06 Jan 2023 22:39:43 +0000
Received: from mail-pl1-f173.google.com ([209.85.214.173])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDvNF-00FKPq-9O
	for linux-nvme@lists.infradead.org; Fri, 06 Jan 2023 22:39:42 +0000
Received: by mail-pl1-f173.google.com with SMTP id d9so3187956pll.9
        for <linux-nvme@lists.infradead.org>; Fri, 06 Jan 2023 14:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wllrSnnUtP2lGzMZ5NnJc5XBcURZs1X9kJ2O+mtnmI=;
        b=H9Bf6JJG6p37dm90DVWP0H16ODP+JsGCCNssf6yTfP4rFOIAHLDBFbyECb7uiTQX+F
         f6BtGLgX01IIWgYGnRpO3Um2unWUDLwKqMZLB04YeqpwVKVw+sSsUyeZ4T0pZ/Kkm96P
         ukT6tDDhhbmSzc4GG3iJMBEbJTz8BtuEgGbBF24R5xMozenT29jYR0EuCWgefr+rxHNa
         x6c8O8KcCyKfveIG+h0tvev+AD88b7WbUhbTYJlzXnlklirccfuqXDQIfm8kQvb3eD9T
         zlmFH14h5P3Qev+9TohiSpkjzd6R8+jobGQiKUWEeNkKaWFEl/iemEyok2HTL5C9vK9h
         cs7w==
X-Gm-Message-State: AFqh2krKczcqm+1OFlU9WTtNk3FXZrsyLdzIGkrcmjqYjZ+69ZeaakS3
	RFxj2BX88TYOL0FF+/fXzDE=
X-Google-Smtp-Source: AMrXdXuMcgHd17Og+hOTPa7FzU9kTPhBKiF/SMXTbwL3fZXTnntDEJhZH/XSa/hH2zGddJvohv5qng==
X-Received: by 2002:a17:902:f7c2:b0:192:6cc9:922 with SMTP id h2-20020a170902f7c200b001926cc90922mr43243418plw.59.1673044779250;
        Fri, 06 Jan 2023 14:39:39 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:23c3:f25b:a19d:c75a? ([2620:15c:211:201:23c3:f25b:a19d:c75a])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b00174c0dd29f0sm1410874plg.144.2023.01.06.14.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 14:39:38 -0800 (PST)
Message-ID: <1484d284-e55e-4e3d-b4fc-5a685002c656@acm.org>
Date: Fri, 6 Jan 2023 14:39:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/7] nvmet: introduce bdev_zone_no helper
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc: kernel@pankajraghav.com, linux-kernel@vger.kernel.org, hare@suse.de,
 snitzer@kernel.org, dm-devel@redhat.com, damien.lemoal@opensource.wdc.com,
 linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org,
 gost.dev@samsung.com
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083320eucas1p1d23de4ad21d0a7aecb74c549ebc7757c@eucas1p1.samsung.com>
 <20230106083317.93938-4-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230106083317.93938-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230106_143941_364591_77AA948A 
X-CRM114-Status: UNSURE (   9.25  )
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

On 1/6/23 00:33, Pankaj Raghav wrote:
> A generic bdev_zone_no() helper is added to calculate zone number for a
> given sector in a block device. This helper internally uses disk_zone_no()
> to find the zone number.
> 
> Use the helper bdev_zone_no() to calculate nr of zones. This let's us
> make modifications to the math if needed in one place.

Please use the imperative mood in patch descriptions (... is added -> 
add ...).

let's -> lets

If these two issues are addressed, please add:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

