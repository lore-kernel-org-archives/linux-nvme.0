Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3121CC00A5A
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 03:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=960IVmsZ9To/VifNgAGQMUlqzUX9d/iKqOt0VhAMV68=; b=eiBvqzrG3JZArV70bUzCV+p349
	Q88N3SHtn+aK0/8EPRo2fKzlOxQ9bO0jwil/pexnUMVnhKhGI9JlgV9sMOJ6sA+L0bJ5caLX4MQRJ
	dbKEcdh7a8kovPplfNgg+ZFb3W233qmXKQEA8+c2MHW6P4rMURf543bef+ZORo6Nrf0FQ576kuGqj
	e73eb/8KVj7te1qGuF33jGiP2amJr5ocHNyWki/e+DCYIIR74DQ0UZvTXxv0GP4tBxeKc8w7t4K5z
	p0w2fBhkmmDs1k0yHlURmx3cpYj0MM/1qNVy0FXyv6j2tXmamvWIs0nOoAXBR/ncsQ0VeRzLPSLhN
	inmZ0vXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pILKq-003HBT-Ah; Thu, 19 Jan 2023 03:11:28 +0000
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pILKo-003HAm-0V
	for linux-nvme@lists.infradead.org; Thu, 19 Jan 2023 03:11:27 +0000
Received: by mail-vs1-xe2f.google.com with SMTP id 3so821400vsq.7
        for <linux-nvme@lists.infradead.org>; Wed, 18 Jan 2023 19:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=960IVmsZ9To/VifNgAGQMUlqzUX9d/iKqOt0VhAMV68=;
        b=XwcHEd9EYpjZEBPxHqshjJdEFcyX9gtmvtcodJLfCn5RjsiAzrEhQfTr8X90X9MT7N
         QalirrHz52gmchR0fbW5rmADwG4gbI5R4CnM4z+k1swUaYNNfcVg5KovZLrFC1hDe9V9
         Ab0Tqou9YGuuz+4pmI+aPfmKpULkhODl6oOd7451ESsxFeM6A9T/WFJ+xuehiQ1AmL+r
         JYw6rAPG/84FmXAJO8piDABYvT42RkLhgYsZjUqVKxxNBgoZ7llOEESK95ukfL2Vsmxk
         kZTH7+1bNb2wIZuMWcO2sDtowiRTjpSSP5VYytn8cnNX4LSe7sZCNKXJDHiDM3FfyO3Q
         iXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=960IVmsZ9To/VifNgAGQMUlqzUX9d/iKqOt0VhAMV68=;
        b=ajh4bfGnjsJN6rFFxsxVrhIZYCv2OG/G3ekaEfNiMBkq2T451om1u16jEIzLl1rZQN
         pqYvCn7lxuw+OgQ8KYYHl+R4AV8ybsZnCB8rfvycS2o7dkxY7cLBkWo4pNGrVMxAzSwW
         q243p3yD+1hA/8NNrW8dg1QZsVpe2MXHc2KRnjjVdN49QtMLjJ6NN2nzD1ZOrPAlOU7F
         yyTppk5+kubr0ONm0hMQkjkGUyYfT3x3zm0ouuxI3Jpiq0tNlJKsQQrfsOUFZysalvj1
         rcXH9Y2Ty2Eo9M/Tkw5a3gA4B/8F8mvFI4r1lLYOJimKWJD2zttjzC6YgjwEMKatrloc
         TZhA==
X-Gm-Message-State: AFqh2koKpVmaLk9qhdrsSLxMwkKKRDn3CVScJ+K4jaLmTM8SROLuPa2E
	VLSNzA/tOOMS8E1O1j38WJ+ZBq21YxrisIH+2hg=
X-Google-Smtp-Source: AMrXdXv5PYOGmr4SnFGgeLMEj9BAYk2S+B8fIaCCmhugSR4upZT4M1lcorxE9MNG1kHyrG/EI6Av2RjL1Q3nlioF3iU=
X-Received: by 2002:a67:e14a:0:b0:3d3:f10a:4f56 with SMTP id
 o10-20020a67e14a000000b003d3f10a4f56mr1268218vsl.10.1674097883643; Wed, 18
 Jan 2023 19:11:23 -0800 (PST)
MIME-Version: 1.0
References: <Y8AG21o/9/3eUMIg@cormorant.local> <Y8W+H6T9DOZ08SoF@cormorant.local>
 <Y8Yq5faCjAKzMa9O@kbusch-mbp> <20230117160933.GB3091262@roeck-us.net>
 <CAFEAcA9pS7P=SvKsOtRHPtkrNAD8LF2ZpFJ870G3B-rhWYap4g@mail.gmail.com>
 <20230117192115.GA2958104@roeck-us.net> <CAFEAcA_T8QqSg4SzszP+wR3pR1P1WTZg4f7mHHBGRw4UrTw+DQ@mail.gmail.com>
 <Y8gfQXPYdHKd1v4I@kbusch-mbp> <Y8h7aOuVfCb+RsAP@kbusch-mbp>
 <CAKmqyKMHs_-RgagMDYE7vn3MHEP2caBc+RERjaK0DNJw4hFYiA@mail.gmail.com> <Y8iulgdgOdVCjuKE@kbusch-mbp>
In-Reply-To: <Y8iulgdgOdVCjuKE@kbusch-mbp>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 19 Jan 2023 13:10:57 +1000
Message-ID: <CAKmqyKMveR=RD6fgnzY0SV39tofD+Ws_AbrSZXE_o4m=M6GZHg@mail.gmail.com>
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
To: Keith Busch <kbusch@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <linux@roeck-us.net>, 
	Klaus Jensen <its@irrelevant.dk>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, qemu-block@nongnu.org, 
	qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_191126_094222_4D3FF920 
X-CRM114-Status: GOOD (  24.22  )
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

On Thu, Jan 19, 2023 at 12:44 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Jan 19, 2023 at 10:41:42AM +1000, Alistair Francis wrote:
> > On Thu, Jan 19, 2023 at 9:07 AM Keith Busch <kbusch@kernel.org> wrote:
> > > ---
> > > diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
> > > index c2dfacf028..f8f7af08dc 100644
> > > --- a/hw/intc/sifive_plic.c
> > > +++ b/hw/intc/sifive_plic.c
> > > @@ -157,7 +157,6 @@ static uint64_t sifive_plic_read(void *opaque, hw=
addr addr, unsigned size)
> > >              uint32_t max_irq =3D sifive_plic_claimed(plic, addrid);
> > >
> > >              if (max_irq) {
> > > -                sifive_plic_set_pending(plic, max_irq, false);
> > >                  sifive_plic_set_claimed(plic, max_irq, true);
> > >              }
> > >
> >
> > This change isn't correct. The PLIC spec
> > (https://github.com/riscv/riscv-plic-spec/releases/download/1.0.0_rc5/r=
iscv-plic-1.0.0_rc5.pdf)
> > states:
> >
> > """
> > On receiving a claim message, the PLIC core will atomically determine
> > the ID of the highest-priority pending interrupt for the target and
> > then clear down the corresponding source=E2=80=99s IP bit
> > """
> >
> > which is what we are doing here. We are clearing the pending interrupt
> > inside the PLIC
>
> Thanks for the link. That's very helpful.
>
> If you're familiar with this area, could you possibly clear up this part
> of that spec?
>
> "
> On receiving an interrupt completion message, if the interrupt is
> level-triggered and the interrupt is still asserted, a new interrupt
> request will be forwarded to the PLIC core.
> "
>
> Further up, it says the "interrupt gateway" is responsible for
> forwarding new interrupt requests while the level remains asserted, but
> it doesn't look like anything is handling that, which essentially turns
> this into an edge interrupt. Am I missing something, or is this really
> not being handled?

Yeah, that wouldn't be handled. In QEMU the PLIC relies on QEMUs
internal GPIO lines to trigger an interrupt. So with the current setup
we only support edge triggered interrupts.

It looks like we also drop the pending bit if the original interrupt
de-asserts, which appears to be incorrect as well.

Alistair

