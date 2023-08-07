Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A3FEB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 10:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uXyc/wrdVOMCx2ioTZwRZuQlkRDIw5Kg4k6n1EjG6pY=; b=znuAq4uHlXGHBcuzignXF7FxsH
	Mv/TXJOus/H2l51U2GCbvyShMksj4fRCryDNpQRKCZO6Ilbyq6fKcdLRqLBUQk4jEv/fL9mvyG/P0
	4VuQ8IXJaFLTY1UeMEtD4wDeR6E8+zl/XDlNCuz7XghihuABVsQaskfUC3ncVXAfc6RhGDmmKEq9K
	n0l52jiplpQ6R2ym6V1ymZG1llTl5nM6oSHQskrDj5XTVOhszEguP109GOrjy8LsbV49kbw5Eayot
	LmGAFFuUHBhT/AB//8CQe0OE1lZKjjiJWOgcc6cO5Ab82ZZS0waRn6h2t+Q8V7UE10zxefubbpbnk
	KcXf0F6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSxhI-00GtI5-38;
	Mon, 07 Aug 2023 10:42:48 +0000
Received: from mail-ej1-f44.google.com ([209.85.218.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSxhG-00GtGX-03
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 10:42:47 +0000
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-98273ae42d0so132165266b.0
        for <linux-nvme@lists.infradead.org>; Mon, 07 Aug 2023 03:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691404958; x=1692009758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXyc/wrdVOMCx2ioTZwRZuQlkRDIw5Kg4k6n1EjG6pY=;
        b=LtehY9RqvhDN0Uupnch8Lj9Wx0pGSgN+7rK3ICjYHVbsSy6KCx18o/JsLwY7ZuoR7D
         HAMOUMGJ8mp2AVvAW2NQ/bo+njZhEKA0TGloiV5+8G9XmZ5JfQoF/1RzojiDkfcVzTif
         B9UDox7ERjomS4qG50OouAOY2BXjRww3cMT+w/o6utFgzAsaxTROtrpMnmGYbF66QV+b
         40fYT5Ili9BBK/8PkqryaAArXWT0zNcPr71U04f2GcbW5Qjp2NU33RnQgA60ntWi7alp
         JfHgZB4sNBzGVgglJVHSUzIhE7z0XCa1fr6cgx+VedzRxBsruyc7SiPWo0RrR26oMlr+
         vQrA==
X-Gm-Message-State: AOJu0YyrWBA1sqmZg5Wh0WDKLqNZf0Sw4JHBJMkcQoINktDocODI38c4
	iHS1uFLr1oQ1moCU7SDeEd0=
X-Google-Smtp-Source: AGHT+IHEhTqaNVTNACmqeqOpYl/icVAqvFjMR4rwePWEcbo93XeZejZbBv7jF3Fp4URqj4DKUVeikA==
X-Received: by 2002:a17:906:1db:b0:99c:af57:2051 with SMTP id 27-20020a17090601db00b0099caf572051mr6583139ejj.6.1691404958128;
        Mon, 07 Aug 2023 03:42:38 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090612c900b009932337747esm5006915ejb.86.2023.08.07.03.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 03:42:36 -0700 (PDT)
Message-ID: <3dca56b7-f981-73a7-386f-099c6f008064@grimberg.me>
Date: Mon, 7 Aug 2023 13:42:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/14] nvmet-tcp: allocate socket file
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-13-hare@suse.de>
 <0ac55b10-6917-9247-59f3-5f3b8e121a9f@grimberg.me>
 <432fd12b-3da0-a3d0-73cc-863a272a0f85@suse.de>
 <8e0a1503-266f-0368-9eb2-ebeb256bd091@grimberg.me>
 <4e14f8b3-27ac-4afa-91e9-8ccb41a8b89b@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <4e14f8b3-27ac-4afa-91e9-8ccb41a8b89b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_034246_057536_B93AD9B3 
X-CRM114-Status: GOOD (  12.57  )
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


>>>>> -static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>>>>> +static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>>>>>           struct socket *newsock)
>>>>
>>>> Why does the function change from retcode to void in this patch?
>>>
>>> Because the return code was never evaluated.
>>
>> ??
>>
>> I see it is evaluated.
> 
> Yes, but this patch moved the 'sock_release()' call into 
> nvmet_tcp_alloc_queue(), making the return code obsolete.
> 
> But I can make it a separate patch if required.

But now who calls sock_release if you failed before allocating
the sockfile?


