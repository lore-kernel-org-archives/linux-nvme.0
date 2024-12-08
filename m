Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC15E77173
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Dec 2024 06:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rS4gBKjSvbHUPLcuHHzUWyhSkZwzl2lWXz/BcxLU150=; b=AM5e3a5FRKZaqkYkWOYIKDcFhz
	PV3tuFGna1jwlkamEojLlImqqjE7ZwEmPrztSdX/dvLFkc9W7FZ8cBT/8+RnkQmYH+0EOuzxOrhw5
	CHjlsUwDfhikkIa4fxtb/JivDqKefiL05+XXX75J2Ih4Z/qOE7kqkuPNnJ/JCzJRlksgAXvgNggsR
	XgpzbxozdEYbpcTMRuxEED2hihLWfyKpKypoLhlTkDIv//pZZzCW6rX5Jqh8ZuMeC8rmEJRGfbUZL
	QVVJfE0tI2Y8n+LUQjKPdV4a9MAzCn+dqXW9wW/bPxTtPr2nyWXD/D3CiEtvss0pe3CGsQYVRxvJn
	IMVtNL9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKAie-00000004uk3-0PWR;
	Sun, 08 Dec 2024 06:24:40 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKAib-00000004ujd-3Ivf
	for linux-nvme@lists.infradead.org;
	Sun, 08 Dec 2024 06:24:39 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2163b0c09afso3218385ad.0
        for <linux-nvme@lists.infradead.org>; Sat, 07 Dec 2024 22:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kookmin.ac.kr; s=google; t=1733639076; x=1734243876; darn=lists.infradead.org;
        h=content-transfer-encoding:content-disposition:in-reply-to
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rS4gBKjSvbHUPLcuHHzUWyhSkZwzl2lWXz/BcxLU150=;
        b=JARqGh8/CWyezLAggtnZ+QRxlaVGkenqKH4wWl90Na5ryImEvr3GYq2b+w9L+p+fT3
         BMhaepaoPEFo/1I8Xk//k59ufgUfmI3E+FsHZ0kLQA0a1JS9f4T2KwVE9a/JjMERyJMm
         vQ1RK5KJzqV4lXEuB9p64iE9yMyREfuJwZeaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733639076; x=1734243876;
        h=content-transfer-encoding:content-disposition:in-reply-to
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rS4gBKjSvbHUPLcuHHzUWyhSkZwzl2lWXz/BcxLU150=;
        b=mE+AKO78dLguUQujZpqlQ4vbGPAsh3N/yeYH9MaI+AbQlgWpqOnYHPYjQZmJDPES3e
         WnQBVTEshSuhiR7lqqruQ1ntV+ikZ6OlUNjP7dC0Cnr3vM3LEkgCtBwd+Q/bKqLtE2kP
         mzb4urGNVAMYdDc0G4CT+ALBoMm1j7VGLc7RdrhtPqo3NkcRsu4zLWqsyC7bd6sf/I77
         Zi0S/Z0ss9OLHQydROR77aLlkdRQ8f5U9tcvGC3nQglm1JTUgonFyWLgszqzUB+x3UDa
         HxBqY8Vrem+wPFLjEPX5NM/ys8IvwSdwEvOLLWJVhqekezBIosmIk2HaU9/ApV+UKmEv
         nu4w==
X-Forwarded-Encrypted: i=1; AJvYcCXfm6vDf7XcxURYdP1EfzR5V0QSdvXCMtJxiwUfdIW7/NDsapR+bQ+iKb2z3qmcyZ5lPaaSmLc/WEbU@lists.infradead.org
X-Gm-Message-State: AOJu0YzQ41KJFfEc836Jl3APWHiHhoIv89ITgs5OLQC7/67V1H9vYl+S
	ntQs43uf0zczQm2PvSHWf+LqqS5vH0/fGZzUz6Vd2lXVFWcBWFtfUKaiKlj3WJTK1uTxslLDy/t
	e3ri6jSFUQB8ingCX8fjC67u97+96H0UGg6pQuc2KZtxEvHQ0srYfrJvLiQ==
X-Gm-Gg: ASbGncs5pHDO+mO+zQKn/RbXLdshBg5mcqI3byJ55HtgorGM2Sbt9xDoXI0cAwOhjnH
	aybAudx7zssJR7a2gDeIL4zMSyMT9RmwJYc0IG8G9eV1kiWdbp01JKwwfVjcGus9dXzgKSA3HYL
	cQcJOw3NGsM3dWp6FpHwd7a+xhxXcfGb7j2FmYz/Lm//r3EhECz8L3j56ajBiU8qN1xRwA8QxK7
	++B5OqimT7/vgM5mMq4N9S+/leD6G8fxhoGjKewYpU=
X-Google-Smtp-Source: AGHT+IE1yITtCnCNWv+WIMfi3cpwIkcZ9XD70Jh15V0gW6Bxat2Ew2qPL+pah7iH+6kI6HEfds083w==
X-Received: by 2002:a17:903:2447:b0:212:581a:8d8 with SMTP id d9443c01a7336-21614db6be2mr116836675ad.46.1733639075883;
        Sat, 07 Dec 2024 22:24:35 -0800 (PST)
Received: from ubuntu ([210.123.42.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2161ad3392esm33621955ad.236.2024.12.07.22.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 22:24:35 -0800 (PST)
Date: Sun, 8 Dec 2024 06:24:30 +0000
From: Yongsoo Joo <ysjoo@kookmin.ac.kr>
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix return type of nvme_poll()
Message-ID: <Z1U7npo/DINh2MR9@ubuntu>
References: <20241207045546.119933-1-ysjoo@kookmin.ac.kr>
 <Z1UOyFnUavHNJu5H@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
In-Reply-To: <Z1UOyFnUavHNJu5H@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241207_222438_126682_0DAFD1F6 
X-CRM114-Status: GOOD (  16.11  )
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

On Sat, Dec 07, 2024 at 08:13:12PM -0700, Keith Busch wrote:
> On Sat, Dec 07, 2024 at 04:55:46AM +0000, Yongsoo Joo wrote:
> > Change the type of the return variable 'found' from bool to int so
> > that any interested caller can see not only whether at least one
> > CQE was processed, but also the total number of CQEs processed.
>=20
> It looks like all the interested callers only care if it's not 0, so I'm
> not sure this is a "fix" as the subject says.

I agree that all the "current" interested callers seem to expect=20
boolean-like return values from nvme_poll(). However, the return=20
type of both nvme_poll() and nvme_poll_cq() is int, and=20
nvme_poll_cq() actually returns the number of processed CQEs.

The inconsistency between the two functions is, in my view, worth=20
addressing to prevent potential confusion for potential callers who=20
are interested the actual numbers. And this patch is=20
backward-compatible with the current usage, so no changes are=20
required for the existing callers.

I=E2=80=99d like to ask for your opinion on the followings:
- Do you think rephrasing the patch title to =E2=80=9Cnvme: change return=
=20
  type of nvme_poll()=E2=80=9D would be more appropriate?
- Do you believe it would make more sense to change the return=20
  type of nvme_poll() from int to bool instead?
- Or, do you think this inconsistency is not a big issue, and the=20
  current implementation is sufficient as it stands?

Thanks for your time and feedback. I look forward to your thoughts.


--=20


