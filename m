Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708E0CD4F39
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 00:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8xQfgZ7+IQZ7TOJ0Rz2Wyj2D0WsNeMpOwH26MIpwY7o=; b=k83zNHncicCGGqKsUuLd6Twhaz
	shknk9tRq0ab45utgayBdTwooJTpd8xfmlkkiAKrtUfsSGgmlbbWj3yEvIWZbqXHlm9lEYEVLUDaP
	XF2w9NL1D8sZo25mnitHTJw/SIljE0XWmwApyvLVIwG1b2yiWGT2lNIG/pqngSQ8zuNvxR0Z4SjY8
	eV0li7SWEfVDwyKvIrNFwXKC00EpeJlsmZjXx1obBOsBsHYfYy3q7PUU8jOrWN/8ftNdkMWlSY+Ta
	42QPb1o12C2I5HxB30pW4jt3o48frnkPnJo+jzuvmw7A3+nDvOAXFHp6oiV4q/QlyYI1MroKeO7Cp
	7Lq5U1Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNgZo-00000006w8O-3ops;
	Fri, 15 May 2026 00:38:52 +0000
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNgZm-00000006w7l-2Q4C
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 00:38:51 +0000
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-95cc96eac66so5019977241.1
        for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 17:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778805529; cv=none;
        d=google.com; s=arc-20240605;
        b=Fhj5SBO1JD+KMPmuiQMfSzheBWQK2k+IbXFxy6Y2951XpU6NGiEM/e9SrEb4HP5IIe
         t0zDdRMtUN9ij3YK/YxFillzmZoWhhalk6g34r8/7VAqB8mAa5xsPK5TA7VFKhre1TeC
         hfsLlqtmeNZvmkT3bDI501t2K3o9G/pApsSKUqXhr6iJqbA3StzyxS3P/V1XSDj/46+6
         pBEp5VMZ4thdqvNb4u1rtAEyRGMpxlJu4YOLvubQBi0NEFBeev2q02tjG+yshTNEO9jd
         H7nhKZFa4FEExhiGiWVkAVms0tY1vNNH/3dwDXaAwc+d9ieOOW1w6V11DGFH7ORQ0t6F
         6e5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8xQfgZ7+IQZ7TOJ0Rz2Wyj2D0WsNeMpOwH26MIpwY7o=;
        fh=kES+ZEKXlEFkAGx13pQUflydYm4ie5oBKqYO9vntUGw=;
        b=f0tO1u0Ku3RWLvULkQ32HvrYfo1x631hhg1IMmIMbCkbAat4bAqY8vo8k2JJA5UPRQ
         nkhM2aJ06duxz/BXQyNUb1v742CntOKClUpftJYNuVVEyjhektfMrtd9woraZgFI1rsu
         cFjZ7If1v3AI6oDglT2ODMDIPIOI7pnq8gkOy/gw4eALD1yriAILcjk/p5aiCr/91Ies
         0qHrbeOcfb7yt4KxG+r70DFYtOA0b4fu9aooXNgmDf2v6D4VRYW3Cn6o3/9vasZ92m60
         lfPimMQJ7u0SIEzw5zfj9exG8BlQ3RTRTxW5t1csaCT1o278qFOr1wb+SDWAFJTNojRc
         6Tug==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778805529; x=1779410329; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xQfgZ7+IQZ7TOJ0Rz2Wyj2D0WsNeMpOwH26MIpwY7o=;
        b=EqDs/AbfZkVHcZ2BOXKhe+Wcc2jPdDwP/A3ollclexaEfkawyR3Xkwj+Reaz+u6csr
         cjcEPgH88hiEZMEjgfDKGWaIOXNkJwmzeQR7eamkNOw/XCZibnD3dj3M7WzX3fAjEe9P
         wpCzfTfabTr64iA+ebp5+oOrtomO6umvfbkXLJdMt/Rh7MI5OAMPD2gq5LpO/fdXzqLu
         Ofy8LHGVvGqjQRWC05F8NzkS0vq5Z+97NmUWgYZs0eWboX0KV3D1n9c1YNulMqxzdlzN
         y4C/XcQTdKJY38EqK60sK8hBQbjpSHyovCrXvD6GKrPUDbOLcYlgECq/6weCP8TWv1BP
         D8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778805529; x=1779410329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8xQfgZ7+IQZ7TOJ0Rz2Wyj2D0WsNeMpOwH26MIpwY7o=;
        b=E2a/5PmG65yReYHOovgnY5ag1HyJq4s3OHUjHb+aHGjE1/8v6eLNusL3OtdSSDA0Pg
         RUUFOOg6hkrn863X5cTTE50OUNxhq7pThbGFLADOaFE8jTrCtIG7yE8qfg/48m6w0aGg
         mA8gVoFBY1Rlf6UNYX+ziOBV6LBY1ogr/is84WPYhIU++n0NVdPWJuywd2BZyMbHEe7O
         Wy9UpfyUEe4IAXxnIOQ6FwQoggT7KIx5yd4yxXKM7mHmUHz/GD74p7Wy9JIk8h4XXLQM
         BcgpNMvsqMxIPYWMzNQzGshOIPebd4naPr/zHBM/PRnnviA/m6fs91GYX5pDpMEjCDiu
         R4/A==
X-Forwarded-Encrypted: i=1; AFNElJ85Xb/DnMyqV0FLCJezVDvzHiSzh0CuoWm7Vuw9X0Kwcl97P/uWple7yLhJNQfgQSOGgcVM2WXsZ1Yi@lists.infradead.org
X-Gm-Message-State: AOJu0YwWgp9rcLhMEJlkA3CFklryrzIrMrehR6RpGucdbkeKfmNieOpa
	NGtcGyCVZuEMeL64+mFQ5VJggLJ7rStuDFtTWYulUlObwISqSm6LrOF5EYj2rlSKxTtsfE6N5Ln
	1fj0xy9P7yGiJ8z1hZDq9+JXxWo1V+SNlZ6vrcw+Wfw==
X-Gm-Gg: Acq92OFrqutpTX0yKhCVqoTo/leWFXINEXGW9ivJZMkHd3G9EOKhSq2NSA5c9yKSMkH
	yzpJ+Nf+8GYTJjZCIUyUrZrSzz71FdI7emZdhmvRmgbui9BGj2ThAqII0mpmkN9x27gGIMcPJIa
	24xkTJvxK3uMd+iV7YtR43ZJLwj1uPjZtuXkl8gbPegXaVJM6RNixZfvSiCxE9qJPnTjKXvMvgG
	N/W3QekWICPBl1mecGVRAhR1MyYjTBN67AiefFvqILq50TBlTDURKW0zACDdRnYUKAQxlnyHxEq
	Ly+zohXEdSgkiyiXxlnht1+T+unOZKLWqHMi/Tphb6zwAk1gPQswvIDhljuncMVMFYs9RA==
X-Received: by 2002:a05:6102:3713:b0:62f:3e1d:a55a with SMTP id
 ada2fe7eead31-63a3cc12f5amr898246137.2.1778805529354; Thu, 14 May 2026
 17:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260328004518.1729186-1-mkhalfella@purestorage.com> <20260328004518.1729186-5-mkhalfella@purestorage.com>
In-Reply-To: <20260328004518.1729186-5-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 14 May 2026 17:38:35 -0700
X-Gm-Features: AVHnY4Jagk0hEroyvK1-XIG-of4mRpbaCQFLepJO8pqDIg6aN6SdwHdS3av7koY
Message-ID: <CAPpK+O2A-5vez-HhJm_2dDUC1nbdbbWnTWikq4_P9N77pnpM7g@mail.gmail.com>
Subject: Re: [PATCH v4 04/15] nvmet: Implement CCR logpage
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>, 
	Hannes Reinecke <hare@suse.de>, Aaron Dailey <adailey@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_173850_624283_68654664 
X-CRM114-Status: UNSURE (   9.54  )
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

On Fri, Mar 27, 2026 at 5:45=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
> Reset) log page contains an entry for each CCR request submitted to
> source controller. Implement CCR logpage for nvme linux target.

> +/* NVMe Cross-Controller Reset Status */
> +enum {
> +       NVME_CCR_STATUS_IN_PROGRESS,
> +       NVME_CCR_STATUS_SUCCESS,
> +       NVME_CCR_STATUS_FAILED,
> +};
> +
Looking at the rest of the code, all the enums are defined except
/* NVMe Namespace Write Protect State */
which does define the value of the first entry (0).

I think it would be prefereable to add explicit values here (0, 1, 2) even
though the implicit values should be correct.

Sincerely,
Randy Jennings

