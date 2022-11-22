Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F07C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 09:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WHUnXg9I101OoRpDNYpbN9cYOK6pnknopVeWJ5Vc3lI=; b=gXuYZiEus4l+SGeX+mMEJtpVEN
	NBSgw4mGxy7Nan6xofCedmR94sRDaLCJygMYvRGTFT3jsXK/lVxHIdxGMWWViBn0Ow4SgKFpoRq/p
	I64Vw/bXM+tMFl2eBk5uzvRc9JvYPJEQ5NHg9t9M679pKydDUQgn9xhzi9pkpyfDZhNwCJgHyhoEL
	PSpsejE3RzWFBA0WyUVAAphOWqQkMXJBiHFtTdvWz+abDfJCp+Zdtzahkrr0r3X/TyZy/piSwSLW8
	je74qJGJ/B5gcG6Yc3NkAuckZkjpxzljIRpD43vd5aC0pVFa/MOD08PJ9t2jVk+PiefwI7J5JbGPZ
	A9yeaajA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxPpa-007Epk-5N; Tue, 22 Nov 2022 09:44:42 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxPpS-007Eea-CF
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 09:44:36 +0000
Received: by mail-wm1-f52.google.com with SMTP id v7so10316273wmn.0
        for <linux-nvme@lists.infradead.org>; Tue, 22 Nov 2022 01:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHUnXg9I101OoRpDNYpbN9cYOK6pnknopVeWJ5Vc3lI=;
        b=7M0fs3fo78eKrRht+3MMgWfpmkCTRqQyFIuYzbSG9CZQzFubXjRwVQYTeVtgVZgDUM
         RqvFYtU/5oBmR9ranxD02CpnRXuTMbO+Q/jTK2Cb92N+TcRHWqNRZ5sbQ9xCbAdbpC9q
         muIn7G5cNtES5BLyP8wMkusCFvPO8zhZ5lCmy4sW0wUxkC4m8e8FYOacofl5K+GZkv8o
         +c/B5hOoy/49v1q9X4fZvWLlLNp/qehnP009VKe5FncB+A3OhwbadUpWYRWf3yzAQmr5
         V9b/2Wsnolcr0SjxxdnvIbYZZieUWYzAEUsyzcKXAg3eA0+utiYHQLpHLyuElYemviX2
         sYEQ==
X-Gm-Message-State: ANoB5plTgVRAoJdZTEXepM3su4/683GBm/TCzJrt8a/La+vA2ok9Yl5i
	LlY+Z4BDmggGjlAmQGvOWP8=
X-Google-Smtp-Source: AA0mqf68lX1An2XrP+1o3hmoEaCok9cbOkhKPv7Z+c/8c0rL+GUBKWPZwUUIwI/K5aqcWChCM2x7ww==
X-Received: by 2002:a1c:6a13:0:b0:3cf:7801:c780 with SMTP id f19-20020a1c6a13000000b003cf7801c780mr15870531wmc.29.1669110270908;
        Tue, 22 Nov 2022 01:44:30 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id a5-20020adfe5c5000000b00241bc209ae0sm13118860wrn.32.2022.11.22.01.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 01:44:30 -0800 (PST)
Message-ID: <8b9cbaeb-1366-0c0e-356a-8d7ed5ebea04@grimberg.me>
Date: Tue, 22 Nov 2022 11:44:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 14/14] nvme: use blk_mq_[un]quiesce_tagset
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Cc: Shakeel Butt <shakeelb@google.com>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>
References: <20221101150050.3510-1-hch@lst.de>
 <20221101150050.3510-15-hch@lst.de>
 <20221121204450.6vyg6gixsz4unpaz@google.com>
 <a8e3d7a4-c5f6-13d0-a517-72097daa2a7b@huawei.com>
 <20221122060855.GA14111@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221122060855.GA14111@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_014434_496401_D9D19A88 
X-CRM114-Status: GOOD (  12.20  )
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


>>> This patch is causing the following crash at the boot and reverting it
>>> fixes the issue. This is next-20221121 kernel.
>> This patch can fix it.
>> https://lore.kernel.org/linux-nvme/20221116072711.1903536-1-hch@lst.de/
> 
> Yes,  But I'm a little curious how it happened.  Shakeel, do you
> have a genuine admin controller that does not have any I/O queues
> to start with, or did we have other setup time errors?  Can youpost the
> full dmesg?

Is this after splitting reset from probe?

If not, I think that probe schedules nvme_reset, which first
disables the controller, calling nvme_stop_queues unconditionally,
i.e. before the tagset was allocated.

