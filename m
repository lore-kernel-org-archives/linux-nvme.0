Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABAEC88E53
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 21:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/wlKQxvJwRMGUuaPvlhTarCoMPsEAwSJyj9999Zu1o=; b=Jg7OL3a2gGpkto31MFUHH348f+
	ne7WgDfi3P0MO71su1zeCBJ2cyjPbznL9EeVxh1z2yRbe+1UQRlNMnuQink6Py5QGW+J5DPBCV8ko
	MCzjI2/wtllOOb5NYrkJk4IBGPFXh8ILdsnkr4BHskkUakOauTEU3PuizVErG1h0oY/ADaJO8Ihj2
	a6zSBp65ijPXlCWdzfd46nyK6fxWhkqi7i5fGvogkWA3ul+BfqgJQiMAfVEvZsjQrXergfbgBFeuI
	SqVpY3uEqBKEwmhRDkDhZ4BKJV6/1oz3gFrqTPET10XyVPpfHncjli+UPC71QzNZAuAZSQeKbImmJ
	8mApUFnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x592h-00000000CKu-3cvy;
	Fri, 11 Sep 2026 21:44:19 +0000
Received: from mail-wm2-f12.google.com ([74.125.225.140])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x592d-00000000CKP-1GVh
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 21:44:16 +0000
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so2150565e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2026 14:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789163053; x=1789767853;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E/wlKQxvJwRMGUuaPvlhTarCoMPsEAwSJyj9999Zu1o=;
        b=ipOc0ubb/QRkcMkT/+DKqMDNdswMwBrToZTZV2zcwvSTZ/6BRklyYkEt6wCH0u8UJ/
         cfG8u8Y8/6JxUmrS6n8qVSG1LpOulkAqEQRrDTQUzgqacrfHbx+qKT33i3LLY1DsCKic
         25CJZwyGrQwv9ophpZkCBHCIGY/l8/asZ1MzGBJHpWHDb34yyp51f1aM3LphXTjEPGZR
         OEpUwTEUTcfv4Vp8d77GiuQVZcaoJ7gLm+63pHHJnb2M0NG6QIab2EZi9b0kzQI6EkLd
         gS2eJlP5X8DsGLggWcnlAZQg0JwdYf9cuWkg1663ZGh9UfhBZom+CjbkXieflZsdzGGx
         /XVQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7/yxH7rqKTbiDnLaJnZzLu4M59xDvoKSHVVdw0u/d9Yv2i9vDdtBivdU+DD99opcKZTccG16p836l@lists.infradead.org
X-Gm-Message-State: AFuF++kov1zLPtDYOc5GYWW5WgTpCIpMpjhFF5sP+PtsL6MzMourzPpM
	k8T3Zgf+WOcg5189AeC8ZlbQqLjp4fAQ91VstB1A5ETIy+o1ag9gDyRgLblJ03sc
X-Gm-Gg: AYBFou0p0yp1bVITqqRRlx1BLRs9J88HIRKW0Qf3Qd3Xo6Mg59BlgOCLJDVmj0uHTG1
	0LrGHfPU56qx2PRYV9s4icB2kzdSqGxm+tRcCwGI5rM8mx5mowtwjcdEUvHtCokWnv7SU/9R+ul
	mtJ9clgMb7ZQfUpqw4hYYh0+1hzn5CewtflU+PMrDaLN1ryrmHuY9DJOPE5XzR+taJ0j7ho93Wc
	+lYy9Ge0MvENRXY+ALGT24O9ln3+tD/GWVzuBh9MrFh0myGbOFc4KNZh6Y0xoFFmU+NJDZMc7Ga
	hTs0f3abWIMYJpMdVlec9Zqkr9NRV5bcy2hWO4uwq0nw2zivYBgIrJMByDdu7lmAzNY8wx4N+h0
	KNp76cAcsXN5IFMHxFRhoPj5Lh4W4e6wZjBkBwmDaXe5JZPV8w3shALs27mMM0SrlAeZcK4Dv+Y
	0MNvAPPFVDL7lV5wp2TDngcANnkQZlQKcNmbnXuKpKk7CrvJXOprPpIGj+KVtO+/+XOkNu9PDlH
	IYDdOXPyDDc96eEGizOpSjYfJ0YtCp3
X-Received: by 2002:a05:600c:2301:b0:49d:2555:1a6d with SMTP id 5b1f17b1804b1-49e619cbf88mr111236275e9.16.1789163053405;
        Fri, 11 Sep 2026 14:44:13 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c2985dsm314961395e9.6.2026.09.11.14.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 14:44:12 -0700 (PDT)
Message-ID: <b5128312-6e32-48a2-bbc5-fcc5f7d43c38@grimberg.me>
Date: Sat, 12 Sep 2026 00:44:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme-tcp: allow multiple queues per hctx
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, axboe@kernel.dk
References: <20260903152623.614951-1-kbusch@meta.com>
 <e940ccd7-3e7c-4118-a66c-1c17c33d2417@grimberg.me>
 <aqAZ6S6lBILltRwq@kbusch-mbp> <aqBBgzV1Q9pP7Z44@kbusch-mbp>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <aqBBgzV1Q9pP7Z44@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_144415_349033_826E02D9 
X-CRM114-Status: GOOD (  15.41  )
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



On 08/09/2026 20:10, Keith Busch wrote:
> On Tue, Sep 08, 2026 at 08:21:29AM -0600, Keith Busch wrote:
>> On Sun, Sep 06, 2026 at 03:04:42AM +0300, Sagi Grimberg wrote:
>>> I'm wandering if you guys can do the same --duplicate-connect and setting
>>> mpath with round-robin/queue-depth would get you the same result? Perhaps
>>> we can add this flag to nvme discover/connect-all for simplicity?
>> Thanks, I'll give that suggestion a try. I think I also need to tie the
>> "duplicate_connect" option to the module's wq_unbound option too.
> Initial results show there's some promise to this suggestion, however, I
> think in addition to the wq_unbound, it looks like I also need to adjust
> the "io_cpu" to change to the submitter's CPU. I incorporated that in
> this RFC, but there's also a proposal specifically for that here:
>
>    https://lore.kernel.org/linux-nvme/20260820083634.71689-1-saravanand@crusoe.ai/
>
> I need to catch up on the discussion there, but from what I can tell,
> the cpu hint provided to the queue work appears to be important.

Cool. So you see that setting io_cpu explicitly better than simply using 
wq_unbound modparam?

