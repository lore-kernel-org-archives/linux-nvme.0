Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3074DC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Dec 2021 00:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T0qh5jeD4x9jhhfNhDAmmVEJuHJ7WMdDbLoZTgaEpgI=; b=zdz9gTxgwEa5g+FyAMlOramC3i
	9PIiYPJ/7pTI4tJR4QMNubKwFoyVz/VUN5xF5EBKd8KvKhTgbQVC81Tc8jZ/mlrr9AFHhv/0Vma9t
	LevRHthEwNEodEnyLFymvTtdbtOWFoUN1sbB84DjdCTYOOHFFwKLiZIHwYBio5D+hkDVztuKXKEHD
	iW4feB0fLQFxFcy0FsIQXgc/sQpbnodaC0fFaNZtl2aMGBg3xi3sorfhGtn1L6Z87WdJnUotRBfH3
	fMBi7bCuwIAfnfPcMziDZ0AqqOQmF+lo14+tXP2m4LNezxrQMvVRE1A+ojpAupoofQvCHr/ZOOKaQ
	J7ZepiKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n0Bac-00BX23-KJ; Thu, 23 Dec 2021 00:04:10 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n0BaZ-00BX1S-Sz
 for linux-nvme@lists.infradead.org; Thu, 23 Dec 2021 00:04:09 +0000
Received: by mail-io1-xd32.google.com with SMTP id d17so1843974ioz.0
 for <linux-nvme@lists.infradead.org>; Wed, 22 Dec 2021 16:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=T0qh5jeD4x9jhhfNhDAmmVEJuHJ7WMdDbLoZTgaEpgI=;
 b=7256zyulv2NU75NTnPFOLf8qooqaSW/71vbICsyLphHMKOOR/XGxCDmN+jjNZyEvjs
 oanlNT1/1eLRrea48Vd4GUit4FVEGlN977Rh/Xy5SeaGP/gVYMFfWAxFCv9naNIPjPwG
 onenCIpI6Jr9n2xXGvUeEgjkv77rjXnzc2jfSom4tSqicqwtN6nWWtPXTPd7VuNyl0Qr
 m/16VpWv3lCtF7kG0d18D4vMnkos6cWyXc3lasgURgJbwcF+u7OYzJaB9hPbRx2YIXwy
 DmEDeAoHPtIg4log+Yq8oaGWeLTi1B3qxnr5t00yQ0+/3CayZPoRMH3DXz/6R8xcVVYp
 v3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T0qh5jeD4x9jhhfNhDAmmVEJuHJ7WMdDbLoZTgaEpgI=;
 b=G6H3CPDulExjSxIYoDGggld5ZdJnV1XvX+2eO5dKJTPb5CngtQagYru5BOtzDBLiXr
 mNcYqm4XlyTRTMsKEbCisVkMQFu3/td9hgdYN1lGHhUapaWHFubXGEJJtk+cjeckXmzS
 o/wq/af7b1UsV4FJf1rq2J9lbnPbjB1yQvC7eKrkBWqFdNumlN4fad/ZI5/MQgUQbBeY
 P/aZi6k0u48+XME9MhMdaN83HF4N3kAcEGvxuKOnoyfXxwz2IN/AxoHF2tjRWqR9yKsJ
 s18SeHwaxb9LVN5QLrk9b8UQy2KUzx1/pvHb0wjWbAlDucyhLZtSJaHikDXAKiSwtXNF
 DQVw==
X-Gm-Message-State: AOAM5307CFeTKhmnj3SL3Z2T60Rb+laQOvH5uSrASu6BiH4d6emszqm9
 OetRRJZ9ElbkL+7R8YxU+CpS1A==
X-Google-Smtp-Source: ABdhPJy2Hp9B0vYxP7PTAcMtYE1MpDkCGFpTeAQEjxstWftfbK3XgPuSi3nr6SObutA/Ye88xzaiFQ==
X-Received: by 2002:a6b:e508:: with SMTP id y8mr28335ioc.177.1640217845835;
 Wed, 22 Dec 2021 16:04:05 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id s14sm1824906iln.9.2021.12.22.16.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Dec 2021 16:04:05 -0800 (PST)
Subject: Re: [PATCH] nvme/pci: fix queue_rqs list splitting
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me
References: <20211222214159.1767965-1-kbusch@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e8422de4-3f45-ebe5-dd23-e1dce96290f5@kernel.dk>
Date: Wed, 22 Dec 2021 17:04:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211222214159.1767965-1-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211222_160407_972834_0A6CD0F0 
X-CRM114-Status: GOOD (  17.94  )
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

On 12/22/21 2:41 PM, Keith Busch wrote:
> If command prep fails, current handling will orphan subsequent requests
> in the list. Consider a simple example:
> 
>   rqlist = [ 1 -> 2 ]
> 
> When prep for request '1' fails, it will be appended to the
> 'requeue_list', leaving request '2' disconnected from the original
> rqlist and no longer tracked. Meanwhile, rqlist is still pointing to the
> failed 'req' and will attempt to submit the unprepped command.
> 
> Fix this by updating the rqlist accordingly.

Good catch.

> Just IMO, the rq list manipulation looks a bit fragile for the lld. If
> more drivers want to subscribe to the new .queue_rqs() interface, I have
> another patch set ready for consideration with helper macros to make
> this sort of error handling a little easier for re-use.

I'd love to make it so that the driver didn't need the list manipulation,
but I also don't want to turn it into Yet Another indirect call. We could
potentially do the same trick as was done for:

commit c234a65392062504acf04afe0ae404cca61a8e1a
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Oct 8 05:59:37 2021 -0600

    nvme: add support for batched completion of polled IO

where the function pointer is known and gcc turns it into a direct
call instead?

-- 
Jens Axboe


