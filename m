Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2428D711D5
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Dec 2025 01:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NFKWjCEKYgPRBt5jR8fhc9vEzWDxbCeMyrMZ7xG0Qao=; b=nYTRGMgm3dg1kcc2/0GlwhLW6S
	iBmhq72y765y3xqlEN1f1d6JY4TglZL5seHo9KBnDldRLEGQJflw5TDmGaagQTqD6TCGKlvHplDu9
	Ok6boiIRaz9NUlylQb/LqTWUC4kEHVo0fzKOKJ31/XZyUifLxlzCE2SsK5b1cyNA6AQqwQtGTiC2E
	xNy7zO0g4GmthSae0ilQ3n6rLI4Exa4qVITJn+SE9F3T6OwWU3OjygfJ6L/gqClquf1iCs9wKj++j
	LY9JeWB/e50nIphQ1tfG6sK1McAvecGbFUavOKWhbhRFOA2usjwGegCsbwypsyh6v4oavDUiitFik
	ADtHgqVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWPKx-00000009RBy-2TaD;
	Fri, 19 Dec 2025 01:31:19 +0000
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWPKv-00000009RBU-2tC5
	for linux-nvme@lists.infradead.org;
	Fri, 19 Dec 2025 01:31:18 +0000
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-93723104137so369706241.3
        for <linux-nvme@lists.infradead.org>; Thu, 18 Dec 2025 17:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766107876; x=1766712676; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFKWjCEKYgPRBt5jR8fhc9vEzWDxbCeMyrMZ7xG0Qao=;
        b=aFJHoPlwg1vRqwHd7H0T+HPMkF4Cz873Shh4NMZYZIGDskVS9KTjTiNl/lcd8aUrRh
         yOhBBZU6U2QqTSzm4gWYGdqELDOFMKtR3bT1LhPswnh1M5rEYkHWtEVjycZbKa8gv4AO
         dVMtkTIcgoel6Z+gaiYzq4b7ltZ47DHQOpQjUCjo41jl2WhY1yygNVT85qrqp85rDY1n
         OptkB3lGx+yHMuiiJxzNuVanjH1QLzM/WV0yDOqUOwk6/NaArpD60+wxffkXBTMcwobl
         gZsnmwZoK6OnxSTVXRmLh2MPwqq3gY/7h+t6NTJmIM65Sh5k9wroXqC+JDl9KaOr3TZX
         mj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766107876; x=1766712676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NFKWjCEKYgPRBt5jR8fhc9vEzWDxbCeMyrMZ7xG0Qao=;
        b=m0H1iHSg1+rZIqvzLCxd+yMG+kaFesbPK0GvliSwOjLzvVjkiBYzacvEddB90eBPCt
         e1jRAHyUthWvqmG+zacAYMvXpiDXw5TVjCG1OAEksL0yM0MqumLv4VEGGb08Wdg+vcSV
         A+O9z3xM1q2BnaXzvpsDjJ0BC1d8D6nfldoGWh3nLbxNuvD/y2r5i/r7mfTTIY9ETNDR
         mUDQzD6tG0NmxTN/51coXjrMm68C9nHGucJFm2B/OabU9ail4/1ycf9TpDc38623Y+HM
         uK2Bgv6RrJ7P7nF8AiL5cUlPYYLrpQcji3UENfQkKg59vpmGIyWgwP9wwFJj0+tMeQ/D
         3lTg==
X-Forwarded-Encrypted: i=1; AJvYcCXC/ijD2wLdYqppjNJAjejiUq1BFSfYXlzNR7FvrGBiFHNqpVlcK7IIkSyYahRlewAts/YhKr0DHKxC@lists.infradead.org
X-Gm-Message-State: AOJu0YyXDimBgcTWJoiIPiLMe8Rc2rsuyBkBeDYIyZ1OOflC8XjV0/Dh
	DN/Oz6ItkPNPtjPbHPiuuS9rUGCq8G+J19+4RmbLupC4lHC/KDd2H6jvCKhX7IUO3uipx3pH+91
	HU8vMtvHWGaf4COhQ0aYztlntbClsAd3gyogtDnTTLg==
X-Gm-Gg: AY/fxX48lvR6M2pK/+/rohJv/o+yMxaBKgRcDqY13waynKpGet1qnsVxLu6TpbVNCiO
	RYfrNIHKTyAcWgxKS8fdzJBIVorIOEdMz+CCCe8zf1xOeO/DTWmwNNo6BZ6/7q89neoFVxV0h7e
	KkbIRhV+PBcXVxBvwP5t/jwdSpzAQlhlfEUwJESIgTTGdl22qYP2jnkh7WctzlF5KSV+yaCJtBR
	onl08eoU2T/Sa5EC3cONjbJ8TmXaDpRYVsPqKwNii6+lcVA30c84obCzWZ3giWLlZb0BANA
X-Google-Smtp-Source: AGHT+IH8XOy4BYSrOfX1CFoo9OL+XnvlKNVF05FAHe0GVI/noYmXQvWkhb9b1/kBguNIvsiLF5yan2f3TMxvE0Ialmo=
X-Received: by 2002:a05:6102:e0d:b0:5dd:b32c:66f7 with SMTP id
 ada2fe7eead31-5eb1a656de4mr345365137.13.1766107876294; Thu, 18 Dec 2025
 17:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com> <20251126021250.2583630-10-mkhalfella@purestorage.com>
In-Reply-To: <20251126021250.2583630-10-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 18 Dec 2025 17:31:03 -0800
X-Gm-Features: AQt7F2rnImFh3hijF2m782dU9qpZqyul_GTDTLjnmI_pZqcD7ZXSaps4L7VFPCY
Message-ID: <CAPpK+O1sfhthFkLq2D2zSL=aYHunnC0hrmnGrecd2Ecd_297SQ@mail.gmail.com>
Subject: Re: [RFC PATCH 09/14] nvme: Implement cross-controller reset completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_173117_739052_D56C9DF3 
X-CRM114-Status: UNSURE (   7.46  )
X-CRM114-Notice: Please train this message.
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

On Tue, Nov 25, 2025 at 6:13=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> An nvme source controller that issues CCR command expects to receive an
> NVME_AER_NOTICE_CCR_COMPLETED when pending CCR succeeds or fails. Add
> sctrl->ccr_work to read NVME_LOG_CCR logpage and wakeup any thread
> waiting on CCR completion.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

Reviewed-by: Randy Jennings <randyj@purestorage.com>

