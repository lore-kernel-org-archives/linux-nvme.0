Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47657C433FE
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Oct 2022 17:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PUblIN5Wh6zH5g9gh27sJq0v/KZBkaRAUrtXxM31u1M=; b=CCfjWW/GrRVPRIacOPVXiAdlrV
	aQ+k8fQDB7SZYKOvv4R3ex1wS+rvCyKYAy5FanXbntjdD5obNdlFMtO7EYeGoAahWUbKbrNpYjA96
	+S4ACAZ8YAPFVUky9Fw2f397XlnGLYKAuGtKkI0Yi336kXb/9EJ9JyEUndV907EGUG/PChL7o1/8W
	GPbkt6WIoX/ploFsgHL0VAHVShLNFs5Gf1GFQ3rkZTurLJ40CHBS4Y+qzNAh3iBkHg7jtuZVOiu2Q
	GTFEJqGZZ7kD7m6R9NKnxI4aCcP6BdbwHoe3SEr607nBU/MwNlezHB9YW9XbaM4ycPsMifdmKblBp
	4i5dN7AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1of2k9-001vHi-En; Sun, 02 Oct 2022 17:27:09 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1of2k6-001vGr-OO
	for linux-nvme@lists.infradead.org; Sun, 02 Oct 2022 17:27:08 +0000
Received: by mail-qt1-x82b.google.com with SMTP id j10so5320733qtv.4
        for <linux-nvme@lists.infradead.org>; Sun, 02 Oct 2022 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=PUblIN5Wh6zH5g9gh27sJq0v/KZBkaRAUrtXxM31u1M=;
        b=abT7qsZmBlJLoO5ttGFytfUlnGJ5zYIyRmLHQ5nax8GhApvO8H3dvCLfbF/kQD5SRZ
         O/un0zbH7XtmnHw6Y0CSNzqHgowgIv0JPCLuk/haI/GW0NccmaNttMzlyBICp/V5ynRm
         S9Fqah2pDvzZjT0CVj08deJt8zDeg304bwHhNGfhZ0nLuaqYec6bzfsWZynnfsbSivd1
         k4abYSIbK2dHLvOh2NNBGKd66rCm2YUUIwoWaG3uJ8Ho9mB5YBxHGxJgbB2KEIdtFSRz
         L5LjMB2Ew4MHP/7/y7rQ9wVJ1iqywFeqa85fBWRkQ+9G3vIKPnogsppQlj4AdA5wgHID
         UBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PUblIN5Wh6zH5g9gh27sJq0v/KZBkaRAUrtXxM31u1M=;
        b=gWB476XR4SnP4MhwP8joJxNNw03pUK2XlwDfv8bjpP1d8LOTgqbnIvEJk7dSb/s4dS
         AjqqNPs8BgRGHRuwRqp0vPaY4u9q/jh+YLObuzhug8/qKfqr8AYecZM/Xkc9GGF+ZbxY
         kt0EeXTvPT1oHknXBQ5d4fDO6ui4gH9lGOV5ABGMcmUNcgvM8D6leEXHqUwvjVw8priL
         bkzFf7+wM+ky0BiILqfMf4nItF7x1WzamHLh0aBxIczUbS7hB9YhOSTWgPpiI8wFYrp9
         xvhcR7M+z9sR9njWEv9PbP/YEcve9Nh792YDY0TsX4Zew/ToXM7IJJ6BPuP1ZyxYzpK3
         YUwg==
X-Gm-Message-State: ACrzQf1bmApww2MlQv68ha38vhnDYqbhFnLuVPyKiCy1MxJQh4T8caB3
	9ktC/9TTGUkapoBDAklXskdxf5UT6FU=
X-Google-Smtp-Source: AMsMyM6PtNGJ2PUiFYRlGfawLaw7vMQJ5zpdzJm5HfTzYmPVvEv8Up0CPPkKvTph5nSWB7exYE+Giw==
X-Received: by 2002:ac8:5f09:0:b0:35c:dc80:93c1 with SMTP id x9-20020ac85f09000000b0035cdc8093c1mr13724628qta.657.1664731625236;
        Sun, 02 Oct 2022 10:27:05 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id bp42-20020a05620a45aa00b006cea2984c9bsm9031003qkb.100.2022.10.02.10.27.03
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 10:27:03 -0700 (PDT)
Message-ID: <876aaebf-4e72-28ec-e2a6-04d3378c222f@gmail.com>
Date: Sun, 2 Oct 2022 10:27:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] nvme-fc: Improve memory usage in nvme_fc_rcv_ls_req()
Content-Language: en-US
To: linux-nvme@lists.infradead.org
References: <87a93f5fadd6e3cba2bb263b8853a5d33f589287.1664704751.git.christophe.jaillet@wanadoo.fr>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <87a93f5fadd6e3cba2bb263b8853a5d33f589287.1664704751.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221002_102706_821038_95B785C7 
X-CRM114-Status: GOOD (  26.13  )
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

On 10/2/2022 2:59 AM, Christophe JAILLET wrote:
> sizeof( struct nvmefc_ls_rcv_op ) = 64
> sizeof( union nvmefc_ls_requests ) = 1024
> sizeof( union nvmefc_ls_responses ) = 128
> 
> So, in nvme_fc_rcv_ls_req(), 1216 bytes of memory are requested when
> kzalloc() is called.
> 
> Because of the way memory allocations are performed, 2048 bytes are
> allocated. So about 800 bytes are wasted for each request.
> 
> Switch to 3 distinct memory allocations, in order to:
>     - save these 800 bytes
>     - avoid zeroing this extra memory
>     - make sure that memory is properly aligned in case of DMA access
>      ("fc_dma_map_single(lsop->rspbuf)" just a few lines below)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is only a RFC to see if this kind of approach makes sense or
> not.
> I've not checked all paths, so it is likely that it is incomplete.

I think it's ok.  some of the other paths that behave similarly may be 
aware of the contiguous allocation, but I don't think this one is.

> 
> Anyway, it is just a trade-of between memory footprint and CPU usage (3
> kzalloc() instead of 1)
> 
> I don't know if it is a slow path or not, nor if the "rport->ls_rcv_list"
> list can get big (each item overuses these 800 bytes of memory)

It is slow path/not often and the ls typically doesn't stay outstanding 
long. thus it hasn't been critical to optimize.

Should be few items on ls_rcv_list, but in rare conditions there could 
be a burst.

> 
> 3 kzalloc is more than just 1 (sic!), but with this patch, 800 bytes are
> not zeroed anymore. Moreover, maybe the zeroing of rqstbuf and/or rspbuf
> can be saved as well.
> So, it could balance the impact of the 3 kzalloc().

zeroing of rqstbuf may be skipped, as the meaningful part of the buffer 
will be memcpy'd a few lines below.

rspbuf should be zero'd.


> 
> So, if it looks promising, s.o. with the corresponding hardware should
> make some measurements on memory and CPU usage.
> ---
>   drivers/nvme/host/fc.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 

I think the mods are fine

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james



