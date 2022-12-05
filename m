Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EB3C47089
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Dec 2022 20:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mFukHabHzU9nHDP00BQaLwWH/W2xDMgDd01lQ3KmF6E=; b=BgfqS7JLqOTiP26tpO6V66ZO+m
	Px3EBL4loSl+axmxaZzG3gFMxJIpLDBUCOgoGVoi5lLAayGBaGKQlyOlyDzysxvKXOgI18VffAt/1
	hERNrVFKFmosNdyaANBKHlofU5MGVZ1Tfr3HbAsGd3FZoRKZMvap3MJXVS7euJNoOHaSd6TanHa6A
	xBaOhyqbMmbfVQNXQTja+uOpzBl3nqf8w5QTjDM8igTbWA4dNK67Lwy/Z0fUxR9Y4kVJ3IKlaSw2K
	JfGPr3eK6Y8GEwDqbNO6GC0F3+QA4hynUPBz2vOVsRwhYWN9HGeUde+wzlCEvYupde1sKFc0kS0qH
	iLprnPrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ICe-00AMY6-DH; Mon, 05 Dec 2022 20:36:40 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ICa-00AMPT-MA
	for linux-nvme@lists.infradead.org; Mon, 05 Dec 2022 20:36:38 +0000
Received: by mail-pg1-x52f.google.com with SMTP id h193so11503818pgc.10
        for <linux-nvme@lists.infradead.org>; Mon, 05 Dec 2022 12:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFukHabHzU9nHDP00BQaLwWH/W2xDMgDd01lQ3KmF6E=;
        b=NNvVrw/SaRYNVz6zgzonsBqZmmjEaeLgCOfnluncK7lzNAVOaG9ygyyaqPstFoAppn
         ll73AaC1B2DojbiNRyG8S34lhlKyLga47dapY6NwA4R0CVK+5iRJ9KsjScR+uU6gHBXB
         kK/C5gW0vge2xRULkPNa7XOit6YT2deDSv+2MoWWiOAutgACnhRwJt/ZacGDYQksDFdn
         e6bFx5w829JDx+mh3Mn2wrgMdUrXugkNinks5ArlUQMzQkoZo6lw+cx1EIWTABoY2BdG
         9CnOabSYUa10FgbiVx4xn18wRASpo/Ip0ufc9djgDTe9LwMjf57JsMkE42j40ZFlkQuS
         xvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFukHabHzU9nHDP00BQaLwWH/W2xDMgDd01lQ3KmF6E=;
        b=3rA+aUjtZ4NiUK9nvyprugW7kgaM0CNJ6UIKFjGFXPoQmyc1vqQbuAkO4xCkLbrolI
         fk4pRJR6gpbgkihUriuASZUDpWhWv5wS1O8bJVYLA2pYgZs9/AKhuTeEccPhAi5RrWEm
         V/YPc+/4UqRoPWeuDrPbhLDAiujhTrEwSbhcztzwBJmS2SpsY3LmSRbsJ1SuqoDIwPi2
         9xHcUDgNb0ygF9XYy171xfWUJb4U9LQ5sDVz63qUYa7m4tuZzPt9Ubvpc4RuUA8kuLfh
         3YfCwuCTYgiO/4aVIrDsq6qcT10laj1FKvRefgOgFg5lRDWsSF3DQIhDxTtDJAyIR093
         gMIg==
X-Gm-Message-State: ANoB5pnqAytTEQkxnyV9nkpdRdRKgEf+k0jTy6jHHT9OQu53kRjbdtwR
	MEz2+bNR3rBzMX1tiJ0X2HmgDQ==
X-Google-Smtp-Source: AA0mqf6f+5SrZjNmKrcYL9Lk5NtIaRvWLquHrmzDMU6yHBU3IEsPNFkTv5vSl/5woSgdox3nRtaQvw==
X-Received: by 2002:a63:191d:0:b0:46f:1cbd:261f with SMTP id z29-20020a63191d000000b0046f1cbd261fmr58570124pgl.329.1670272587255;
        Mon, 05 Dec 2022 12:36:27 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d24-20020a631d18000000b00478dad38eacsm183557pgd.38.2022.12.05.12.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 12:36:26 -0800 (PST)
Message-ID: <c062d9cb-e8c6-543a-88be-016973058d43@kernel.dk>
Date: Mon, 5 Dec 2022 13:36:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Enrico Granata <egranata@google.com>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <fe2800f1-aaae-33e8-aaf0-83fd034162d5@kernel.dk>
 <CAJs=3_AKOMWBpvKqvX6_c=zN1cwEM7x9dzGr7na=i-5_16rdEg@mail.gmail.com>
 <23c98c7c-3ed0-0d26-24c0-ed8a63266dcc@kernel.dk>
 <20221205152708-mutt-send-email-mst@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221205152708-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_123636_758530_295D626F 
X-CRM114-Status: GOOD (  23.28  )
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

On 12/5/22 1:29?PM, Michael S. Tsirkin wrote:
> On Mon, Dec 05, 2022 at 11:53:51AM -0700, Jens Axboe wrote:
>> On 12/5/22 11:36?AM, Alvaro Karsz wrote:
>>> Hi,
>>>
>>>> Is this based on some spec? Because it looks pretty odd to me. There
>>>> can be a pretty wide range of two/three/etc level cells with wildly
>>>> different ranges of durability. And there's really not a lot of slc
>>>> for generic devices these days, if any.
>>>
>>> Yes, this is based on the virtio spec
>>> https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html
>>> section  5.2.6
>>
>> And where did this come from?
> 
> 
> Here's the commit log from the spec:
> 	In many embedded systems, virtio-blk implementations are
> 	backed by eMMC or UFS storage devices, which are subject to
> 	predictable and measurable wear over time due to repeated write
> 	cycles.
> 
> 	For such systems, it can be important to be able to track
> 	accurately the amount of wear imposed on the storage over
> 	time and surface it to applications. In a native deployments
> 	this is generally handled by the physical block device driver
> 	but no such provision is made in virtio-blk to expose these
> 	metrics for devices where it makes sense to do so.
> 
> 	This patch adds support to virtio-blk for lifetime and wear
> 	metrics to be exposed to the guest when a deployment of
> 	virtio-blk is done over compatible eMMC or UFS storage.
> 
> 	Signed-off-by: Enrico Granata <egranata@google.com>
> 
> Cc Enrico Granata as well.

Alvaro sent me this one privately too. To be honest, I don't like this
patch very much, but that's mostly because the spec for this caters to a
narrow use case of embedded flash. It's not a generic storage thing,
it's just for mmc/ufs and the embedded space. That's a missed
opportunity. And either it'll become mostly unused, or it'll actually be
used and then extended at some point.

While I'm not a fan at all, if you guys are willing to take it in
virtio-blk, then I won't stand in your way. I would rename it though to
more specifically detail what it deals with.

-- 
Jens Axboe

