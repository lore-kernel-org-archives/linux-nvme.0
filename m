Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887E7C021A0
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2025 15:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l9Gpp6exxOAKgR4+qfssuhnpHihI75y6MvQ08e29riQ=; b=lSvZmoGEWQ8jeBONKa5pcaib74
	51GxbPsO7smfOalZj4ffy/hCZABRSET23YGgSNL89BzAtmiYrEG7YZFdY9mIcOrJIZNbWJhaueHh/
	YsYqBPhvDe2BCcbPV6y0QZRZuve6i2rxi1hUPsdhZFybCLZ7AIjvrvIpOQjC0iT2le0cA+IQ9TeI/
	lY8dSTJbI1Hpq6OxgEjS9wYt7WzY5T6T8K9RwFJET6xo8iKPE1jHhBDGgCO+ZUDw4JOi7e+Kj/OKp
	2R2AqtVRp59txX0yLzP/kXRQy7zkyiwzAtjgJ9ytWUcWFfkM+tpCGK8icJ5bcZHNgyVfwyzhwbV9N
	8QYPXdTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiEu1-00000007uBm-3yGd;
	Wed, 12 Feb 2025 15:43:53 +0000
Received: from mail-ed1-f41.google.com ([209.85.208.41])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiEsb-00000007txG-1idU;
	Wed, 12 Feb 2025 15:42:26 +0000
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5de64873d18so7772876a12.2;
        Wed, 12 Feb 2025 07:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374943; x=1739979743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9Gpp6exxOAKgR4+qfssuhnpHihI75y6MvQ08e29riQ=;
        b=ApFttmTn5ZW3b0v5jjT37XImc7flA7SeTBgwAOGBAAH8feNg4AmnZGeKh3hRMGm+Oi
         pWx+qPRtvjUtLWvXz0yPDamhWRxQj3jyJX/nLslrZ1+Tg5Bqk558iD2D2G7WnnQZAqdc
         nck6YmbOsZQF+G1dJUQtqhIfmswtqtQX/D1Xj/v6aM1zull/EQeJkoNQ6KjECTqWAFvg
         76oyag9oBmL1GTFbt8q2sXWxi5Jg648g1/atRsAK3Dm6vB+uo8rcvlx7CD3dDpfxAny4
         YquPTVvatmcxm8BYo0qXatS864VZcSCWhLTgqWgaFzN5dtaSwfvkTW3FTNr9oyKmTFJU
         sHDg==
X-Forwarded-Encrypted: i=1; AJvYcCUC/cPwgb02rIfVU+CLkmf+bTjJdQ3yFdWiSaNI4KYVv09hMaLXrDdzozbd5QSjGiuh1XVcTo9k1xGq1A==@lists.infradead.org, AJvYcCVjTHak/vNdSylWCYBQ1kPWpJTWZbMGle56sQVkUG96najfLF4pmUy0+Q+I8cwXzCjn+dqn3yYe04Ntf3ACmts7@lists.infradead.org
X-Gm-Message-State: AOJu0YxHw2f0RUP+h+JSZFmIgHUWHPTxunTV5Oq2DHDF9lN2j9rkD92f
	sk6U8OTu/02y2WQqq8WHkR0CDoai6wXB9d9m7sHUVdPUTUQee3Y11NP0vQ/X
X-Gm-Gg: ASbGncs/9lDuYcBoorbliYTKN7Gp6LZ8U3BCAbYLJq/1ucJN62YhdDth3XHmHWazJkP
	2rZ06Sg/30DEwoyjaRgK0AIJTEDd8K3iuTcepQQh4IsmnSAOuF9OVW5c6JtXKVTIteS6Y+I52HD
	K6NCg2SfiR3lyucrHZnUw1Ud2wbmC7tkgjX8S9h/UU7Ivpu+KnA2CP/WQ7CWPfyRat3sMkSdq3h
	2+DasPNvXZyTd9xnOuOQVF4KZ8quutItCz8sLprv4LEUiGgXTDpQ52kkJ2uXXN9qh7HBC5tXtNR
	ys+diWXfWFrjUhVHE5Mh2D2dXxKI1wEeVU/DnDxIJFhIkA==
X-Google-Smtp-Source: AGHT+IHgivfNP//Fq+3fAuBTc36KC9ZQR+TSEA5OAexod70fHF95hnP0Bao7ywYrLoW0OyFxNTfPlw==
X-Received: by 2002:a05:6402:2807:b0:5de:aa54:dc33 with SMTP id 4fb4d7f45d1cf-5deade04238mr3364338a12.25.1739374942808;
        Wed, 12 Feb 2025 07:42:22 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de61830117sm8235107a12.6.2025.02.12.07.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 07:42:22 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7f838b92eso110605766b.2;
        Wed, 12 Feb 2025 07:42:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVAMboY71u2m9ylkyePoXfTOHhiDX/GIPx1obxlk+inwY24RbIpzCbC4K71Ic0JLk51gRHe8abZFw3rnbR0Shm8@lists.infradead.org, AJvYcCWYr4Wd/Ia6Q9ydfxEGR/Nig/J+94oGSLFLcCJcqB+ffss7Qjzoq93fC7CiHRWtn553nUH+PjI4T4+jYQ==@lists.infradead.org
X-Received: by 2002:a17:907:d8f:b0:ab7:be81:8940 with SMTP id
 a640c23a62f3a-ab7f3365c62mr272181066b.10.1739374942419; Wed, 12 Feb 2025
 07:42:22 -0800 (PST)
MIME-Version: 1.0
References: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io>
In-Reply-To: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 12 Feb 2025 10:41:45 -0500
X-Gmail-Original-Message-ID: <CAEg-Je9cagWShwMbSqdrW9iqV+kiwJMdJBfjUru6kjXvoZ9rmg@mail.gmail.com>
X-Gm-Features: AWEUYZmWQeHLZ0J8NFYXZ_GuzgNgnx9jWhxS5Mn1NK7iDLLdbRqxrj4qVt0xYjc
Message-ID: <CAEg-Je9cagWShwMbSqdrW9iqV+kiwJMdJBfjUru6kjXvoZ9rmg@mail.gmail.com>
Subject: Re: [PATCH 0/3] apple-nvme: bug and perf fixes
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Philipp Zabel <p.zabel@pengutronix.de>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_074225_447676_5B13E203 
X-CRM114-Status: GOOD (  17.89  )
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

On Tue, Feb 11, 2025 at 1:26=E2=80=AFPM Alyssa Rosenzweig <alyssa@rosenzwei=
g.io> wrote:
>
> This small series fixes three unrelated issues with the Apple NVMe
> driver.
>
> * fix NVMe on firmware/machine
> * fix a power domain leak
> * fix pathological driver performance with random writes
>
> The first two are strict bug fixes, the last is technically an
> optimization but given the measured 200x performance difference I do
> consider to be a fix ;-)
>
> Given the early stage of mainlining for these SoCs, none of this needs
> to be backported.
>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> ---
> Hector Martin (2):
>       apple-nvme: Support coprocessors left idle
>       apple-nvme: Release power domains when probe fails
>
> Jens Axboe (1):
>       apple-nvme: defer cache flushes by a specified amount
>
>  drivers/nvme/host/apple.c | 124 +++++++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 107 insertions(+), 17 deletions(-)
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250211-nvme-fixes-29c409c2553f
>
> Best regards,
> --
> Alyssa Rosenzweig <alyssa@rosenzweig.io>
>
>

Series LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

