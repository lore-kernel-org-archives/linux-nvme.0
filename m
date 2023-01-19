Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAB6C677F1
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 02:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mp0pFFM2xuEepnFLCVlyCeucPIIIIfVuIO/Z1JKUQG4=; b=l/9e9bOOwzb7fr5hJhsYb4a6f7
	B63kxttPkXvFI1tD3sVP/yPyk23QndYPYMZc5J3dufhH6gZKfZr058zo/K1dh2fMBdOsrsvD3p9aV
	YQQKkhlUCpoQ2xb9zoO5lB5h51AkZRxU65WRJG8eGg4SlMbsKoJKhtQutGVnBHJy9SBbycq5YeIIg
	5jl4f/nYH+KttrvbWTL8wBXZ1v1EetqWrxAEj3YiKa62Pdjpj1RhuOUFV6+naIWltN0hAl5BP7V4O
	n3IbrUollj5/1/3KuGFocvtZX7c9yOYyaiCY82sqE2QXu3ez5FB7S4UT4lINKbrJ9pvQ9IEAuqWSZ
	u0YZq7TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIKv1-003EFN-RQ; Thu, 19 Jan 2023 02:44:47 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIKuy-003EER-DN
	for linux-nvme@lists.infradead.org; Thu, 19 Jan 2023 02:44:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id C7303B81FBE;
	Thu, 19 Jan 2023 02:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB958C433D2;
	Thu, 19 Jan 2023 02:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674096281;
	bh=kaQPZ3vl61qloDRzyxbeymvoxuaByonmR13aIH8Dfxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktJH/PDK4f2yKzWtYHCEhdRmk7+MzpgVGFIPOWcb7YvVwZzzk8/luAanxtQC5Rkiy
	 daEtByBaXM4taF29eyhUaQuZvYmzeVgfRECSQRHJz18f5LG418bfL8KUZe+Rjb0k0Y
	 27SJ9DgGsN2k4Uz36N/IIeplGyf4DgELrgT/xtvx/1lb26JbCrrxBFuo1+zqRoDgOG
	 +syHMWV9OFanI3ACEFW8oZZVp3QqLDVNQzIRMUDfHP13cyM0GE8HS/R2bcKyeq/Bjz
	 cjk7tm8ja/9n4AaxqpdTFxW/ATd2wK5qipKStqxyK9xi4EJvnhMH1BwzhUUQOcH5l/
	 YHEfmJd0LKmRA==
Date: Wed, 18 Jan 2023 19:44:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Klaus Jensen <its@irrelevant.dk>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Message-ID: <Y8iulgdgOdVCjuKE@kbusch-mbp>
References: <Y8AG21o/9/3eUMIg@cormorant.local>
 <Y8W+H6T9DOZ08SoF@cormorant.local>
 <Y8Yq5faCjAKzMa9O@kbusch-mbp>
 <20230117160933.GB3091262@roeck-us.net>
 <CAFEAcA9pS7P=SvKsOtRHPtkrNAD8LF2ZpFJ870G3B-rhWYap4g@mail.gmail.com>
 <20230117192115.GA2958104@roeck-us.net>
 <CAFEAcA_T8QqSg4SzszP+wR3pR1P1WTZg4f7mHHBGRw4UrTw+DQ@mail.gmail.com>
 <Y8gfQXPYdHKd1v4I@kbusch-mbp>
 <Y8h7aOuVfCb+RsAP@kbusch-mbp>
 <CAKmqyKMHs_-RgagMDYE7vn3MHEP2caBc+RERjaK0DNJw4hFYiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMHs_-RgagMDYE7vn3MHEP2caBc+RERjaK0DNJw4hFYiA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_184444_642102_11784E87 
X-CRM114-Status: GOOD (  19.67  )
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

On Thu, Jan 19, 2023 at 10:41:42AM +1000, Alistair Francis wrote:
> On Thu, Jan 19, 2023 at 9:07 AM Keith Busch <kbusch@kernel.org> wrote:
> > ---
> > diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
> > index c2dfacf028..f8f7af08dc 100644
> > --- a/hw/intc/sifive_plic.c
> > +++ b/hw/intc/sifive_plic.c
> > @@ -157,7 +157,6 @@ static uint64_t sifive_plic_read(void *opaque, hwaddr addr, unsigned size)
> >              uint32_t max_irq = sifive_plic_claimed(plic, addrid);
> >
> >              if (max_irq) {
> > -                sifive_plic_set_pending(plic, max_irq, false);
> >                  sifive_plic_set_claimed(plic, max_irq, true);
> >              }
> >
> 
> This change isn't correct. The PLIC spec
> (https://github.com/riscv/riscv-plic-spec/releases/download/1.0.0_rc5/riscv-plic-1.0.0_rc5.pdf)
> states:
> 
> """
> On receiving a claim message, the PLIC core will atomically determine
> the ID of the highest-priority pending interrupt for the target and
> then clear down the corresponding source’s IP bit
> """
> 
> which is what we are doing here. We are clearing the pending interrupt
> inside the PLIC

Thanks for the link. That's very helpful.

If you're familiar with this area, could you possibly clear up this part
of that spec?

"
On receiving an interrupt completion message, if the interrupt is
level-triggered and the interrupt is still asserted, a new interrupt
request will be forwarded to the PLIC core.
"

Further up, it says the "interrupt gateway" is responsible for
forwarding new interrupt requests while the level remains asserted, but
it doesn't look like anything is handling that, which essentially turns
this into an edge interrupt. Am I missing something, or is this really
not being handled?

