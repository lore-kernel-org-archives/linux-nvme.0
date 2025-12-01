Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F6BD116F3
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 14:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=futfLwuxMfN8o8RRQI0MN9ZW0WeatznJgAbhjLgO++g=; b=gj8QB14emyiMqqG58G6BaXGy70
	qUCoppyYKoc5TNgIRro6Z6Yj44HLfYiLCClhWdCzMkPdHhU5oWls75T8z0SMd2i6N6FcjNHlOZK5d
	HuToYZ1sYv4xm78Z+xVNLhCBGyOD/rQ/jUcL7i62kuwsVp2xc1hFoSKtjcvBl4ulhzbm6XO0mxdfE
	Pt1+qMvHoN7ipRzWUV9CX8yPfCwd5h/y4trPgMvM6IJ40yBzXo5COXM8ED5+pjq3KxSRHRL+PK3qd
	PafSAoRlcn3ExL9yCyiXh/0pNtvIqMLd91kIwKYzYu/qeKG+vHMX8n15kZPjIObG9i0KPTPOHWri4
	kRjX37ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ4hc-000000044es-25Hw;
	Mon, 01 Dec 2025 14:16:32 +0000
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ4hb-000000044eK-0Feq
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 14:16:32 +0000
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-656b32a0cc4so465698eaf.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Dec 2025 06:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1764598590; x=1765203390; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=futfLwuxMfN8o8RRQI0MN9ZW0WeatznJgAbhjLgO++g=;
        b=T7i3S/nYMeMgK5Cu0TZtFRke26GOkmDB33m4iIVi9pc0hO+DcppHiAB//Wjv2Vy5jX
         9MgSQ7JVA11jdDpd7vwbba/1UZu7ITp7WVAhW80TjM1r67evyovBm3+iAVZMZhX8uB1G
         6TuLeT9DzQYJIPofhWn1ELJBoek/A1Jh4xtLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764598590; x=1765203390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=futfLwuxMfN8o8RRQI0MN9ZW0WeatznJgAbhjLgO++g=;
        b=TyBwQuRusiJxukGonfjkRftPoWl24hFzvavxwYCyJng1Mk3cY1BRKZKThnkL4O1ybl
         YD389+ertj0+8V/pBTt+9MwcLaT4WJMi7fDZReC0HnveFZuxo+LAfIzQFaPi0DJZ+zG/
         WmNndaxc2Fi0/jyUWtT9kIPu8x9mpwt+aEGhDAmiMQORYnmXWsNgzwEqf5zkiW8cVaAW
         3ywvD1ZXAsG2x4WG+MOXCgr4NfxKtykL3bsja5qC71+Jxm3ooUWx294A6eQa5NFki5YT
         tnmLSFVk7dV89u0OvhrmqfG9v55Hs4/ZUxUEpQqIGNUF4Yfpa7+K2NglycBwawMo485V
         nbeg==
X-Forwarded-Encrypted: i=1; AJvYcCUuYSGEF80ReGSydLIRok9zWpk6aov7t33lvz1DxcoUzYn5A3Or7AasfGdRRgKuK4Qkh3C3NmeU5oHg@lists.infradead.org
X-Gm-Message-State: AOJu0YwQDzPkkLHPhn9US+cm1YMMB2/z0QvHYVe9b76N9ou2aVu6F9RN
	6uKosXV3NIKmEc5g+oS2I2MMbLGMI1O//Z1FRRj7ZKjR3IboKfdRc0QGiprjWL8G0dESTETeryl
	0JME5qHeqzFXuqHwfqTDRSl8yQer1pcvtLK/CtJ74zA==
X-Gm-Gg: ASbGnctiJsoVDzkTMfOjDYex8OqogLtFntqQMkdT5oZvsQzyTJyiUHMVwAapx/ZjiBV
	nGtTgoWWXIV4BGBdrUG0bFBu5SYC74dIvtNVcpLUHvj+BZr5WdyKQB151lRLfNFf2ZIwvj/cy6P
	trJIvB8jC2o1YQgaHQu7FIHZAOs/c5N9a28JiyXTce0jYpJx58/Sd3RrKCRGWFSQLk1e6d/UDEr
	dyxU409wTa2eleR4Fgz3SBn9a6yTmytRAF5SX9skN1EcZdPytC8xE8fBA1r1QB7q+/NNk39wpC9
	9+QQgFbakaJlGvq8ANV18aTOyi3+WEXZbNEriofwhS4/gWVEw+7gG/00/vP8OJo=
X-Google-Smtp-Source: AGHT+IETd4D+lPkgqKBaD9OLW1UljeD0G2Ftcrq1oe00FJeXYsJTNA4CJ9fq8Mfi18rJWJ9VbmrP27VCz3fdAcbVd24=
X-Received: by 2002:a05:6820:81d4:b0:657:6678:1b48 with SMTP id
 006d021491bc7-65790b69644mr13368876eaf.3.1764598589905; Mon, 01 Dec 2025
 06:16:29 -0800 (PST)
MIME-Version: 1.0
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
 <07500979-eca8-4159-b2a5-3052e9958c84@youngman.org.uk>
In-Reply-To: <07500979-eca8-4159-b2a5-3052e9958c84@youngman.org.uk>
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Mon, 1 Dec 2025 09:16:18 -0500
X-Gm-Features: AWmQ_blOCs9kCWQUm9Pt8F4AtMcgJ0EybOhWkrFmmWIYSdJj1aJZLOPXaOfTHoI
Message-ID: <CAO9zADyyQPjtRNy136=WNQnS4siVSd_N4wXqMjB+pRzQVOqrxQ@mail.gmail.com>
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
To: Wol <antlists@youngman.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, 
	linux-raid@vger.kernel.org, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_061631_098299_BDBB5B7B 
X-CRM114-Status: UNSURE (   8.53  )
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

On Tue, Nov 25, 2025 at 1:24=E2=80=AFPM Wol <antlists@youngman.org.uk> wrot=
e:
>
> Probably not the problem, but how old are the drives? About 2020, WD
> started shingling the Red line (you had to move to Red Pro to get
> conventional drives). Shingled is bad news for linux raid, but the fact
> your drives tend to drop out when idling makes it unlikely this is the
> problem.

For awareness and tracking purposes the drives are a little over a
year old but this issue has been occurring since they were put into
production/use.

