Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D289C6379F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 16:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A4/5fYgXR1pyHfT5U1fw1lkncpm6Gmpw8YQoQ2kh474=; b=4Eugolh3ewNLNc1745FaDa0TzC
	+Teg2JYC3JnoBP4pVM6Jp8HhBHMNQYaPMSPVQoenahl1cXfpfY5DCMGfny5ry2qamsZ67BvkND+yH
	lzXXqMH7abfLsUfwLawzXq7iMDsvM4YXauFiNHCKmERrQmQL1hf3cSp4LM29KJ81kXIcp+ZOU+Gxq
	gBA825t+WjdjlQZLmsfK5AjQBRnePuJs7DGWWw5orKTjJFlWFVdPQ0Z5RM8yARZTL5DQcUjRornhT
	/b/9QkVQEkFa/S8dwm+Z+cfYr9KwcibtldVfaXIy7HzYkFfvsnVUMR/dKj9KQ/HdEFKrIHaQFJdgd
	u5jVQ3TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHofO-00F5HH-DB; Tue, 17 Jan 2023 16:18:30 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHofL-00F5Gb-QO
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 16:18:29 +0000
Received: by mail-pj1-x1032.google.com with SMTP id gz9-20020a17090b0ec900b002290bda1b07so57928pjb.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Jan 2023 08:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A4/5fYgXR1pyHfT5U1fw1lkncpm6Gmpw8YQoQ2kh474=;
        b=g6kqHK46iC0TL4hFdx4Ejv/5Jc9hvF+LpfPvYELv7OYWvz4EY7SoJjKFOkDtckAFHv
         WRORMaSYSz8jHfKdXPtZlc2kFKd3PTQBHcpJmCIzvpPVUuGtyB3eLDebJSIo1LLYgVOI
         ZusFKbMxtipRVcuxX6NTRt3+YRliDKaGQEP0OS0xXQoElWZtA80La+AUPv13qrOGSlJ6
         kSeYBqWykh1lseEM0+JVNPdTIZf82Dkw7SPW90PYA0vB6Zf9O6lb12YSmuqEUArPVdVQ
         x+wAk/Zwk97gfjapn4AZfYRvhfq7awhb3n1fH+/HyXtOb04G8bWvWvorX87m39T7mSaj
         un/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4/5fYgXR1pyHfT5U1fw1lkncpm6Gmpw8YQoQ2kh474=;
        b=GF1B8RnWXa8MUGGrQKU3S6mqQu/dSU4ENIJhqfgsQcixoFX8xWHfdTPFVRV40thKDa
         ABzLQ/ItC9AzP+zqIu7EoNkXuQy58aKDWwiRklLWew0FybFsncOUILuV7cTBTjpQI2CE
         ztnRHA+mxJ4i+xDt4lqo/DDWQr/8fLtChdy+9fWHhuZKUm5HeO35Wb0r6APBPEYxgGo2
         YrqcYphsH+T5GKmcPmHAA1J8A1d/fPenubD12lwoy/4zXV81eu4+P+W+JulIthDh2PZi
         FrELHIf9PItatQUDKYtAqD5cc7/GHOn1VulkOxH7PFVL9CulGZvO5zalZ6mp1BpZByvU
         K8iQ==
X-Gm-Message-State: AFqh2krilYpr6wg8x61xpDH9np296P8kj5Zi6FdWhrvL7aW7LHJs3hV5
	fC0tAMIwRB47lz1bM9HUGTkhQ+jttpQvuCaEz1/Yog==
X-Google-Smtp-Source: AMrXdXtmWyVfgJzmesu3dQ5gV8JtyaZEVyUkSSwHvXyWTabM8rQvvLSthYn27JPMpSrQzyPc6LZsxPem3F33nNJprIM=
X-Received: by 2002:a17:90b:46c9:b0:219:e2f1:81ad with SMTP id
 jx9-20020a17090b46c900b00219e2f181admr317716pjb.19.1673972305782; Tue, 17 Jan
 2023 08:18:25 -0800 (PST)
MIME-Version: 1.0
References: <Y8AG21o/9/3eUMIg@cormorant.local> <Y8W+H6T9DOZ08SoF@cormorant.local>
 <Y8Yq5faCjAKzMa9O@kbusch-mbp> <20230117160933.GB3091262@roeck-us.net>
In-Reply-To: <20230117160933.GB3091262@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jan 2023 16:18:14 +0000
Message-ID: <CAFEAcA9pS7P=SvKsOtRHPtkrNAD8LF2ZpFJ870G3B-rhWYap4g@mail.gmail.com>
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
To: Guenter Roeck <linux@roeck-us.net>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Jens Axboe <axboe@fb.com>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_081827_877536_D45B3A96 
X-CRM114-Status: GOOD (  27.48  )
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

On Tue, 17 Jan 2023 at 16:10, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Jan 16, 2023 at 09:58:13PM -0700, Keith Busch wrote:
> > On Mon, Jan 16, 2023 at 10:14:07PM +0100, Klaus Jensen wrote:
> > > I noticed that the Linux driver does not use the INTMS/INTMC registers
> > > to mask interrupts on the controller while processing CQEs. While not
> > > required by the spec, it is *recommended* in setups not using MSI-X to
> > > reduce the risk of spurious and/or missed interrupts.
> >
> > That's assuming completions are deferred to a bottom half. We don't do
> > that by default in Linux nvme, though you can ask the driver to do that
> > if you want.
> >
> > > With the patch below, running 100 boot iterations, no timeouts were
> > > observed on QEMU emulated riscv64 or mips64.
> > >
> > > No changes are required in the QEMU hw/nvme interrupt logic.
> >
> > Yeah, I can see why: it forces the irq line to deassert then assert,
> > just like we had forced to happen within the device side patches. Still,
> > none of that is supposed to be necessary, but this idea of using these
> > registers is probably fine.
>
> There is still no answer why this would be necessary in the first place,
> on either side. In my opinion, unless someone can confirm that the problem
> is seen with real hardware, we should assume that it happens on the qemu
> side and address it there.

Sure, but that means identifying what the divergence
between QEMU's implementation and the hardware is first. I don't
want a fudged fix in QEMU's code any more than you want one in
the kernel's driver code :-)

thanks
-- PMM

