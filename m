Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F256C43334
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jun 2022 14:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6zCJCSVlAUXRaGnISCtHsz/5Pjr48JRZxmR0ns3GnNg=; b=Vs9kfelgNufzHGj5XRxANNMxf8
	VMTJFGEx6WToWj7XJsKuYLDFUstQmRAPTjmqHFkHFlqLg/xEuP1fGsSsOKGcJrLDMIeU//dV2i4yX
	aVsgfTAGYjzi9GqHcP6z7o1XYwDp1dfWckIVmsgMvzhu4TQE67uk6aUHOZKnSOkxgUuF45nHBFcq+
	qJ1DiG+dqW5lYTwOmvTYPNCVIXxGzK2w9ZPA8a/8p0TYv6GV1AhynSZXfUvz7eFNo9vnPkj7LlGHb
	EAkFfXAaSqdgYDj9eEDVQzPD+qFP9RjMMBpHw0C8bVHuFUmTd3AYWiyDgxBba3mZW5SydISXKr5Cb
	RyiF+Ghw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5T3i-00C7R5-2l; Sun, 26 Jun 2022 14:16:18 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5T3f-00C7PY-Hr
	for linux-nvme@lists.infradead.org; Sun, 26 Jun 2022 14:16:16 +0000
Received: by mail-wm1-f46.google.com with SMTP id u12-20020a05600c210c00b003a02b16d2b8so4112939wml.2
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jun 2022 07:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6zCJCSVlAUXRaGnISCtHsz/5Pjr48JRZxmR0ns3GnNg=;
        b=aCFhU+OSiG6wgswbtFXpxYHBiuPvYHnCzOQDdcwUYCLVgGiSr9Xn35dObKodSqdc5A
         wrvL9ke/97ru0Pbd3Y25a8Td+ylUDs0HlQ2d4+3tKNirXsM2RToMs7LT6YzWgRCI65YC
         1lVvHLP4Ww6LVsGwYt6y3exS8u8zY6YaiaafjpJMwjqwDNA5JsrgKnBHkPteL4KVpRsa
         A/NdMuiTnQVlm4txLuwvS1Dn/ChqvQBRVKnYx2smhAd/SjDMK7SUrac5P5ZO40GDrqlt
         qRGRdW2qjhsJ5P9lc3TPLFzQJSk07xE+mkQb+0BFewnPkNhm87xJR18uVoKJrKVZALzp
         M2wQ==
X-Gm-Message-State: AJIora+6JW/zlleuumJBfuDX9mTfeTg+E2FP+EdyIJiT6U0wH0eOu+NL
	y7JfxS6i8tLCF2N2yy4NPPL85ND8wl4=
X-Google-Smtp-Source: AGRyM1sspwWvVudAHE6sLY9L60sphjiPlvm76BAMYyUot88IugqA5kzn6bsXWcWV02k874t3pUk54A==
X-Received: by 2002:a7b:cb03:0:b0:39e:e826:ce6d with SMTP id u3-20020a7bcb03000000b0039ee826ce6dmr14601812wmj.102.1656252969976;
        Sun, 26 Jun 2022 07:16:09 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z5-20020adfe545000000b0021b81855c1csm9515775wrm.27.2022.06.26.07.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 07:16:09 -0700 (PDT)
Message-ID: <1a253c74-9dd7-60f3-33f4-037d92c179ea@grimberg.me>
Date: Sun, 26 Jun 2022 17:16:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bug report] kmemleak observed from blktests on latest
 linux-block/for-next
Content-Language: en-US
To: Yi Zhang <yi.zhang@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs8iJPnQ+zGHNTapR9HWMk9nBXUPbhYi5k-vKZf4qRmz_A@mail.gmail.com>
 <YqavC8hwLXwPVnor@T590>
 <CAHj4cs8y5HHYjr0FtWm1AmkEY=ZqOL4OmgzrWBEhbRpu5V8dWA@mail.gmail.com>
 <YqdIWcgnEylFuSci@T590>
 <CAHj4cs-66nWX_8HvN4_j8QmrTKA9tXNrdfejPagaDNOzNTGs_A@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs-66nWX_8HvN4_j8QmrTKA9tXNrdfejPagaDNOzNTGs_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220626_071615_639758_8BAE2130 
X-CRM114-Status: UNSURE (   9.78  )
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


>>> Hi Ming
>>>
>>> The kmemleak also can be reproduced on 5.19.0-rc2, pls try to enable
>>> nvme_core multipath and retest.
>>>
>>> # cat /sys/module/nvme_core/parameters/multipath
>>> Y
>>>
>>
>> OK, I can understand the reason now since rqos is only removed for blk-mq queue,
>> then rqos allocated for bio queue is leaked, see disk_release_mq().
>>
>> The following patch should fix it:
> 
> Hi Ming
> The kmemleak was fixed by this change, feel free to add
> 
> Tested-by: Yi Zhang <yi.zhang@redhat.com>

I just tripped on this myself...
You can add,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

