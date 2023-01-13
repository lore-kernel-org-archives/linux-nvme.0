Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C439EC54EBD
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jan 2023 12:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pXHvi2sDYotp+flcrr0cEQVYMDUeKT/Siu/DP01paMs=; b=n4qehBj696qRieBiC50RGm2TB4
	8gYCRO0kBQSxgt6V07+6WmsPo7KQfSAThF+rjVQKkHY+AJvnBs9T8VknP3R8TCEyloy64ohyWL0p7
	Y4VAG+l7aEPQB6bEshzQXGFQOq/1crdf1kzvsH98aZ3WJP6khfpoNQkWLKp1n+dFdo/70IGoN4/Hr
	ZHGbYINcxFiNpRLj/aGhdHhEyac9STuYuiXTP8uyKpUXuke8au7/BgLvCgeTqX4W2foHoDtsdE6QT
	HWvBpF8YSaBum9fWDvV4POJJQbtnSstvAcFNtYL6dSzavkrt08l1bk/v8/iNyRcwoT0RZj/XbKOEz
	yK3b8EGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGJEi-002Yu0-Sd; Fri, 13 Jan 2023 12:32:44 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGJEg-002Ysz-1d
	for linux-nvme@lists.infradead.org; Fri, 13 Jan 2023 12:32:43 +0000
Received: by mail-pj1-x1030.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso24246318pjo.3
        for <linux-nvme@lists.infradead.org>; Fri, 13 Jan 2023 04:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pXHvi2sDYotp+flcrr0cEQVYMDUeKT/Siu/DP01paMs=;
        b=JUExiaQSJ8OeJlCnR+mKauqc4zRK1/iOJbObVfLG2jVj9tcAZ0juNF5VJesAa7VTmC
         tY6fxPd2pbREeZU8dtRmR8YTuYjn4GNMBrC+iZ/vcJwm65y0++QMlXYCJfsFueKbWHSn
         l9JNTsujyP3gbdpBTct8jS8G8Z/XF6Rb4AY9JkaJ7o1u/Np/CpThY2AJABDiHoLrAvbu
         CTEKEfw3oUym0Bj/L/XbcZ02gJM3z2JgMT6LQ53xeocAvLzv31jOCjWLre/8yyfkt63Y
         OMfHdV5fI5ioMs43LlGLJpm2hPle+SjK9g2zMJ367ap2Kz9ioKOvTH7ocUJOvPcZhRyA
         20qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXHvi2sDYotp+flcrr0cEQVYMDUeKT/Siu/DP01paMs=;
        b=3gw3y3xeiVGIIIxZYmDpE4oaLn+1KmHfnVIP2EkdAGYQxE2u05y8XIa5t2ylBDUJRl
         d4AIlcVCxD+vfx7oC0QorNKDc5ESwB6oKMTkUiLWiTMfH0AUTi3/pK1v9pWlowXWH+MX
         5tWTs1sv2mm9IdHsxiXAfT7eJy09sqUlD92nKYljDVNhoe0apTpBy5Q5If0dX9M4Du1+
         MdlDg9gbls5HKzmm0sye/MI5shNxU/dvaMSChdrm8WvZz29N/Lo+wahrqfKSRnDSiJsX
         C5ND8T5B1qf+bt6FwhZIPLBsjGNxzbZKektsAkZQDShD89vuDjk85Tz+3gpZZ+eFMG23
         dxEA==
X-Gm-Message-State: AFqh2ko/ZV/jQ2KGZ7Bb4SjMMlZrH0G66jPLeSBYBzjLVz4tivIkbZAZ
	nmMAnYEWEKDGHvY3T7csCiL2gRi4d6rtCmAKQBRG6Q==
X-Google-Smtp-Source: AMrXdXv6VWqjBeWYalofNoO0TIFL61KvOGZjh+8aSFjzCfLWyJgfOKGEaB0gEcLnM9KXprGDuTyTwrDTDYVjNUvimiA=
X-Received: by 2002:a17:902:b287:b0:192:ff91:98b6 with SMTP id
 u7-20020a170902b28700b00192ff9198b6mr1693226plr.90.1673613160841; Fri, 13 Jan
 2023 04:32:40 -0800 (PST)
MIME-Version: 1.0
References: <Y8AG21o/9/3eUMIg@cormorant.local> <Y8EcOFE52X5KbzO7@cormorant.local>
In-Reply-To: <Y8EcOFE52X5KbzO7@cormorant.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jan 2023 12:32:29 +0000
Message-ID: <CAFEAcA9y0E=EZwmetyvymvt64BpQxAnKMHs0E=BBH9_3OfMwFA@mail.gmail.com>
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
To: Klaus Jensen <its@irrelevant.dk>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, qemu-block@nongnu.org, 
	qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230113_043242_177040_A5E7D2CF 
X-CRM114-Status: GOOD (  11.22  )
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

On Fri, 13 Jan 2023 at 08:55, Klaus Jensen <its@irrelevant.dk> wrote:
>
> +CC qemu pci maintainers
>
> Michael, Marcel,
>
> Do you have any comments on this thread? As you can see one solution is
> to simply deassert prior to asserting, the other is to reintroduce a
> pci_irq_pulse(). Both seem to solve the issue.

Both seem to be missing any analysis of "this is what is
happening, this is where we differ from hardware, this
is why this is the correct fix". We shouldn't put in
random "this seems to happen to cause the guest to boot"
fixes, please.

thanks
-- PMM

