Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3662C004D4
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 10:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fQ96p0dBVQA/G18m2ezDd4as0ywpHwNy6NBGWRmwj7I=; b=mtTDTgTW+oiL/WsjgQpcjN25/Q
	Dk2rOi6cLVz/N4AGQNWb+/UiLN/SVUlL09/TWnNaiy26BGlqQdROtO033Lb0o9fNyPj4hskD+rRZ0
	Euwwm8ZK72ZcI8yaY/9ut1N/z92KR86CKnD6yzROmnoGMUZK0DK5B7SvoomhYixEoIcInIHnjgMfF
	rkIDWqUlLcyTE2yO9MJksPNf9JqWqaXmfRtI8kNxZPdGavjd5b1Wrdes2Tem/UNcPCPsyBWSwtSz/
	+S7d904V0/QF1An1iyDpZnmpu0o+pALNrHammK+rpO5Lt1eAPJnJwTjjqs3frqy2paP9gT+0xil8r
	cS8YTk5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pISGZ-004TCZ-Iy; Thu, 19 Jan 2023 10:35:31 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pISGW-004TAv-L9
	for linux-nvme@lists.infradead.org; Thu, 19 Jan 2023 10:35:29 +0000
Received: by mail-pg1-x536.google.com with SMTP id v3so1159024pgh.4
        for <linux-nvme@lists.infradead.org>; Thu, 19 Jan 2023 02:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fQ96p0dBVQA/G18m2ezDd4as0ywpHwNy6NBGWRmwj7I=;
        b=T/mXKQWaXaA/ANeRZX7kXcN/R5n7whgS4Q939roH6SWCIdnRShzuVlRFSPlMdGE9kw
         3hcPsZeQ8hj4Axtno6e9/fk+eyxbODRdh5r3aUPpou3xMv6R0GVJdLJWMF+4Bn7fvaNH
         yr6418GVRBCKU73CufE3ps53PfAPk4gHk3VRAFUkKycjCxO/oB3hTsQjgxpQ0ABgk6EH
         H08O541zFp3GXShf8s2ejv0HZZsRtw2gu9eT3zk8A+QICN+tN+ZJ+gHmd7R5zWzIsRZ/
         +9Zmiozd0YYkFIigOhbVKIlSh/QCHmtXirrxpduoROK/9Q9UG4yuyn4sUfKWVQCrN8r9
         735w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQ96p0dBVQA/G18m2ezDd4as0ywpHwNy6NBGWRmwj7I=;
        b=NQjUS8oAJc0QfgQphok5CXiCil9QqRwnrEPBjcJOBqI7xNRO+n6OT39SdMn5yI5K2G
         uoBDNaiLaT/eVvB9bbCl1kFpYtNmPPyxYDQg7sZGgz2DtnHf0JCCb4n1fa5uW3QH1rty
         gX8mQF+8VjwK2kqAX50n+a8pMTWzGo+qo5Ef4e/itkbasF4SHTz2Gq1xp4+S3IuVtgMX
         sdOyirFC5SgkBKlC9U02xAnm2FTl9h7ugTzUusbIzH6anlKx969V7d84ruD4cObuLRO5
         j1iHIkxwWm4tPtFVG+90mgaWZLEDzOrgNm/NXHIHzjvgNi7o7cPSJ3v0E60W4ipH7FQe
         I5cg==
X-Gm-Message-State: AFqh2kr5GXWqtX06OqfbL6gZjgjIxRpRrfCR6gUKosp28GU/VMe8s6FD
	Pj/FX6LARWCF41wHwUAO+v/6T8Huq5DMiOfVN197Mg==
X-Google-Smtp-Source: AMrXdXvcwbQeLzsDuN3Qzfoh21hfeuv3ksx7pR9Z4HNKckU+frp0+CHzvtYt7ll/5JIXTZYz8c0Ye1nrfsbnf0mUP6I=
X-Received: by 2002:a62:61c4:0:b0:58b:e9af:948b with SMTP id
 v187-20020a6261c4000000b0058be9af948bmr1022704pfb.26.1674124523131; Thu, 19
 Jan 2023 02:35:23 -0800 (PST)
MIME-Version: 1.0
References: <Y8Yq5faCjAKzMa9O@kbusch-mbp> <20230117160933.GB3091262@roeck-us.net>
 <CAFEAcA9pS7P=SvKsOtRHPtkrNAD8LF2ZpFJ870G3B-rhWYap4g@mail.gmail.com>
 <20230117192115.GA2958104@roeck-us.net> <CAFEAcA_T8QqSg4SzszP+wR3pR1P1WTZg4f7mHHBGRw4UrTw+DQ@mail.gmail.com>
 <Y8gfQXPYdHKd1v4I@kbusch-mbp> <Y8h7aOuVfCb+RsAP@kbusch-mbp>
 <CAKmqyKMHs_-RgagMDYE7vn3MHEP2caBc+RERjaK0DNJw4hFYiA@mail.gmail.com>
 <Y8iulgdgOdVCjuKE@kbusch-mbp> <CAKmqyKMveR=RD6fgnzY0SV39tofD+Ws_AbrSZXE_o4m=M6GZHg@mail.gmail.com>
 <Y8jBG/j8w2R43kYd@kbusch-mbp>
In-Reply-To: <Y8jBG/j8w2R43kYd@kbusch-mbp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2023 10:35:11 +0000
Message-ID: <CAFEAcA-wC=5v2Kq=CnbeFq+YNxrkLskChAW_OkK_qbK7RVZfQg@mail.gmail.com>
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
To: Keith Busch <kbusch@kernel.org>
Cc: Alistair Francis <alistair23@gmail.com>, Guenter Roeck <linux@roeck-us.net>, 
	Klaus Jensen <its@irrelevant.dk>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, qemu-block@nongnu.org, 
	qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230119_023528_711983_44C92248 
X-CRM114-Status: GOOD (  22.49  )
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

On Thu, 19 Jan 2023 at 04:03, Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Jan 19, 2023 at 01:10:57PM +1000, Alistair Francis wrote:
> > On Thu, Jan 19, 2023 at 12:44 PM Keith Busch <kbusch@kernel.org> wrote:
> > >
> > > Further up, it says the "interrupt gateway" is responsible for
> > > forwarding new interrupt requests while the level remains asserted, but
> > > it doesn't look like anything is handling that, which essentially turns
> > > this into an edge interrupt. Am I missing something, or is this really
> > > not being handled?
> >
> > Yeah, that wouldn't be handled. In QEMU the PLIC relies on QEMUs
> > internal GPIO lines to trigger an interrupt. So with the current setup
> > we only support edge triggered interrupts.
>
> Thanks for confirming!
>
> Klaus,
> I think we can justify introducing a work-around in the emulated device
> now. My previous proposal with pci_irq_pulse() is no good since it does
> assert+deassert, but it needs to be the other way around, so please
> don't considert that one.

No, please don't. The bug is in the risc-v interrupt controller,
so fix the risc-v interrupt controller. It shouldn't be too difficult
(you probably have to do something like what the Arm GIC implementation
does, where when the guest dismisses the interrupt you look at the level
to see if it needs to be re-pended.)

Once "workarounds" go into QEMU device emulation that make it
deviate from hardware behaviour, it's hard to get rid of them
again, because nobody knows whether deployed guests now accidentally
rely on the wrong behaviour. So the correct thing is to never
put in the workaround in the first place.

thanks
-- PMM

