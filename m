Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CA6C5478C
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Feb 2024 05:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jv0hmkXz1dJ+3iS2KwSVorg76TeTkDy/ve4BbP186JM=; b=ED9q1QGEc5Mat0hQ1a69FfBFfx
	pYQpQLcP53MWmAUAjZpL5AMTpbUGrvKyFOxY+LbiG78aknUoNXIJS9ne/ZFPz6spgKd4ZZ3IqNh8D
	/Cwy+kWtxVdcBRMzYuRQGFmqxA8FfE+Hx30h/PQLpMiuJCOksGXgVIt5otyi4Ye/ovAeFNIFpvLNo
	hiRn25FK9DK1swx2ryo+BF4HDRVp7mXkrPD04eRJDMuT8WQjkTC7VlkWSHFhHGN3ll3ylYfNaXnG1
	yVRlIVsIuNCukvDbQuIsxP1kSmL3dC6UMezWHxFSt8PdzTtq1cSYH4cB8LosA7qZzug74igv2q1BU
	VI6NZCXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdOOB-000000083H9-3UoO;
	Fri, 23 Feb 2024 05:46:31 +0000
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdONe-000000083Dv-2je9
	for linux-nvme@lists.infradead.org;
	Fri, 23 Feb 2024 05:46:07 +0000
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2d23a22233fso6355611fa.2
        for <linux-nvme@lists.infradead.org>; Thu, 22 Feb 2024 21:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708667152; x=1709271952; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jv0hmkXz1dJ+3iS2KwSVorg76TeTkDy/ve4BbP186JM=;
        b=aQkgmK4vSeHUJtbGqabxUXNA67i+Tm7MFyh0h0W2rrVNRObHYsQA2FECKreHD3fiPf
         jRA6VMZw3rPzfkpgXwDxMdoZWa/uyYWYYH0zhxH4PjcgLo1Q0DsBVcFHfQU0gaXkCUzC
         sIOeRg/uJHGjMUmQkHY0VdAkyrW+9zVPgdbthM4u2YsYMX2bj1bHH8wxIq9ADomaMXWw
         QEwlsHItfOixnfrpU19EPZ50jc2viYHNyk3b5xbgqqL4PpSg8vQIipm4ErwrFGXTyuJP
         4mQdnCVQyOGxHTkopkLa2NpcvvLDN7bzp6ZcxmR+eUdvNPLXm7QYiiI3PucSHotkXy62
         jkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708667152; x=1709271952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jv0hmkXz1dJ+3iS2KwSVorg76TeTkDy/ve4BbP186JM=;
        b=la0K/y4/HIs2zJIsGVWpLNtpMJMw3rKEmVG/VM1Q0KNQSFY6wWgViryN/FdknKS7J2
         Kq9ZmVhpN1J4exefVSbA/G/DeLxaySI3qRcKj9GlGx6fKgcDxuTtFtwuQ0ZYjLcRFa/l
         dPA8lBZm0A2E7Pj1l1BWD0//+HRcaLr0DQuFBmYhQMEt09QzbuckxUT6ZyOztQ9kl7QK
         KObcsR90nwoih3qkt2Whz2fevMmxB/KBBbWQYp9ZFyp236ND4ztYyvHri7Ff4cCzbaS3
         nVsVhupk0FBkbcCUrCAKVlLOPiUBd8+shQSvDhM8H/FuQ7A/4d78vxYpikAioB8DpVvl
         MjtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCVOGh/U0uFU6xKjcc3YlhSydK4I9baBnhd192DEnPCebM1QzKujZnAEuWvhUeAZXjRPbOGNIO/1CBFBjHU4fZI3BNA3NfG7lOCTc1MVU=
X-Gm-Message-State: AOJu0YzTM/cwu7lesd+4f81N8y+UPS61jSIcKE6t4LwktzOIQzJzjLsd
	taFXIz+jQrCxRUvpSm6Uz7wuqk6DHIZvfqTeD/qPj+ffKXzvD8VBAEsSXWhCtpOQs0oblVYubH2
	4/avwQ/ZivAK4Z0OzPmR1fiV70dZjt5eL+aA=
X-Google-Smtp-Source: AGHT+IF0Gvi8T/+r11y07LKIgVhuhvMLQTzT01KI5hPXgmELdMq4XI2PllqsLqMHZzNe7K0l33fydqf6rnwtcaDddm0=
X-Received: by 2002:a05:651c:b1e:b0:2d2:4a87:f1e6 with SMTP id
 b30-20020a05651c0b1e00b002d24a87f1e6mr728701ljr.36.1708667152498; Thu, 22 Feb
 2024 21:45:52 -0800 (PST)
MIME-Version: 1.0
References: <CABj8AyhLjBkQUhp4CFY+xV4_GwDAyzU251St+BMoYUKCjj7M9Q@mail.gmail.com>
 <ZddusYydcaBkY24T@kbusch-mbp>
In-Reply-To: <ZddusYydcaBkY24T@kbusch-mbp>
From: Jaehoon Shim <jmattshim@gmail.com>
Date: Fri, 23 Feb 2024 14:45:41 +0900
Message-ID: <CABj8AygtU5-8Gdh0576QgZ7B7jc_ChgV=iEogj=pYYmrGPiWxw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Adding NVMeVirt to Kernel mainline
To: Keith Busch <kbusch@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_214601_617719_D4293529 
X-CRM114-Status: GOOD (  13.62  )
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

On Fri, 23 Feb 2024 at 00:56, Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Feb 22, 2024 at 10:38:03AM +0900, Jaehoon Shim wrote:
> > Hi all,
> >
> > My research group has recently introduced NVMeVirt, a software-defined
> > virtual NVMe device implemented as a Linux kernel module. Upon
> > loading, NVMeVirt emulates an NVMe device that is recognized by the
> > host as a native PCIe device.
> > - https://github.com/snu-csl/nvmevirt
> > - https://www.usenix.org/system/files/fast23-kim.pdf
> >
> > Advantages of NVMeVirt are:
> > - Deployable in real environments (not virtual)
> > - PCI peer-to-peer DMA support
>
> It looks like your module creates a single nvme device. How are you
> testing P2P with just one device?

We have recently developed functionality for multi-device support,
which will soon be merged into the main branch of our GitHub
repository.
One possible way of making multiple nvme devices using current
NVMeVirt code is making two nvmevirt modules with different names and
loading them.

During our research, we have used GPUDirect Storage to test the P2P
capabilities between NVMeVirt and an actual NVIDIA GPU.

