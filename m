Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96923106FD7D
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2026 05:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f7XEow6bu1Teb55Lj22f1iewX9VtCt/XWVQ6YGKjVIk=; b=SLIQ1wQHG1Mwut7TgucNdpXyfK
	zWCyBf5El4BF2kfZlFyEjpBE0Mx+0W3BaAEVceuO6IHoVariYmurw8R/z73tibgjBXdJRbGJN8xBh
	r4vNySmyWqCvMYO+6c++S5+44SiquYPe4Tyerg8dZpzGiGTt4cwZUErireFDIlpzH7OTYUCwfn/Mm
	kDR81knMU+yKFJ7zG7CX8PAwn64ud+m06pkIQVnBwpd9MxrV0fP+v8bjsEu8dZwcaEd4eqKu/D/Nf
	mCuNWNjECIexOsnbXNcQKdlcw4W9PH7h1bOGMomJ+lIU0URSZEM/U6ZHWgGY/3Ax8/u5y2ZbK3jw5
	aMEqMkFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0vYE-0000000GiCS-1I40;
	Fri, 13 Mar 2026 05:59:10 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0vYB-0000000GiC7-2Uv8
	for linux-nvme@lists.infradead.org;
	Fri, 13 Mar 2026 05:59:09 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-827270d50d4so1750579b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 12 Mar 2026 22:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773381547; cv=none;
        d=google.com; s=arc-20240605;
        b=PXcSuQ/DxtOLYeTIKKWEYt2rHZ0BhzWykzNtAkODJam39Nd2x1N0D9dhqtsNwhCVli
         +FOSKAViVuRJHjNiPxnE3X1DvfPNSRb0WnzQQPHU0ulw4FeD+2bvxcCygBDs8F/VmgY7
         B9V9hbUOMn87GHS3fi6kK8JUgKWFjb0E/1fGKDkoXor/sb3eQYP/YNMDmjUyFk0SI1+L
         4m4jzLndFm25FfJhUr37ta0APZ5oiNysNSsowZgCHY7TUvrG5La3czIhwoAgr7MVvlPH
         5y4+z5HsUI+bXQ8cvlm+H89P+cjIgGQVPLKTtruKQy/kw8566KJun8x2U+6eA6y0+eDh
         uo7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f7XEow6bu1Teb55Lj22f1iewX9VtCt/XWVQ6YGKjVIk=;
        fh=UFeMmTIb72A8TsQtggGD/WQ74PzsRJHN8+NEouX0Lpw=;
        b=E7dI0hWpqkJ2axz5NOBYSYf4dzZHLUgZ0rBgbdvTNpMNtrkuCUXlZjikpdXt0j8t6p
         nwI8yulG9ftSih27x7UOJlL12Yz7Mhj+HnGSlnJJLT2NQmef3mgGHNGarZADT2kY3Lrw
         8N6/3w79K06d/gEpOhgpGnkjbrneAtNaTV3NxvOf1cCdrjA+4JldFgK7UzeuFP6g1kw8
         c1Eu/b2tnSi0deBK7FcKLtMJepZAuasE0I5mtNxzKcTJrB9Ovpwf836Gt+jY5DrafKnt
         jrsTOnLQpjPj6U8GzQJMzSCXLtS4CUBhokWJr2HifqEh+kOzQC3MISejW4AXWiyCCfZC
         Fpwg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773381547; x=1773986347; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7XEow6bu1Teb55Lj22f1iewX9VtCt/XWVQ6YGKjVIk=;
        b=Ii114X5dx3177j8qS/21Vvf5KagP4qJzzmivoCJcUl5AVXAJCjRIr1LM6LS0Yk8/TN
         UYEppUiL7ed/e2CXv/zYRbGNJLorOBH3GqUn2o/MvPW9xot8u+WoO0uhq11LtppUKTDA
         /zqdJBKrSDh0TbgV/0QCYfBAYjQQaf6EP79yhQfx95T4uebflkDJIUFFKh3emsHhzVTi
         THr/DOnh8iPjqZblxhYDYsYGrkUMcuTah7AxadKkoaGq1BFsWDWncDYJct6g6akfYiHZ
         QTIQuQ9g2OGOVvhwmcuiXJN4WM7k/Lk+WSrWZC6r+SkRd/PmJhSZ1zmcd9a2WQQtYdRK
         HNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773381547; x=1773986347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f7XEow6bu1Teb55Lj22f1iewX9VtCt/XWVQ6YGKjVIk=;
        b=DAYhK/z5c4RH+2O6rIe1S+VZoBETX15VdJomZkjbgLOBk+WRQPD3ZdQLmO7IIK7lcw
         ZtymchFkdxUFsdjTvO5itJ/4vGMgGfRWJLaxCoCpWECsZe/otqekHDqsT4jI8+yu6NHS
         MvfFzCsOOJAAQFFj7zklrQKw+1y/+3Djv3aCyvADi2/ifeM13LEsenYC/71hoTMR3oiD
         4G27Nk5y8FXRk2DDND1xHmYH5uapQXrPIaHe3pqPDswLH4spc1P7zW+w9+A2kzQr4Oxp
         eBOZQf3neug+rlzXg6Le/W+Mk1f+rQdjJJR8c5rapI7XUiHRC2ol4DbEV1QbMX2iBEHR
         NSQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLEAKJ4nb+4MNkDlTwcWsN32QTD8YUeL3ZreW5BQAyC4+kQZwh6rBtjQhE7hFX1EZK41/mePtrZ2Vl@lists.infradead.org
X-Gm-Message-State: AOJu0YxegjFJxNptqbY7WSch524d5v6SBWUPPZjv6pS6W+5knSmLj9QY
	JXDrarIXAaRnmh8Y/HSpOOwE7CuH+5+bI0xRXFMcPOYasqzE/uPnaIDUxNGjj5/Ypvi+Wn2crrm
	kpk8/BXuF+PCiuMZdoLpoFJcqY2NbkHU=
X-Gm-Gg: ATEYQzzN1GwYbJ/FHVXaP+tyj9gDJ5N/p3EahAoqx1Oix8dYi2mXeVONxPYtiYMNdYF
	RgFpiFo+FKKqc3ZF78zrkxYdyaz/l8go3lENCSgdoFpfmvtEn4WfnDyn+TWr5HqKcUB52rSi53j
	n23rKtNIynATo8wca3luaP/10mDBArFAyqSnqtlBMF4AYQAJCOdJ9b087986ZYd4Wb2WZ0QGd8o
	aOR5K8lKwq+EVXOhEZZDKVK7avHO1VTCt7usYplJtV14CKkd3Eoa69ZvbrP+XIKfg/5b3Bc+KD6
	7YlFK5lF
X-Received: by 2002:a05:6a00:2d91:b0:827:3883:7318 with SMTP id
 d2e1a72fcca58-82a198d7927mr1843569b3a.31.1773381546679; Thu, 12 Mar 2026
 22:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260311160920.465209-1-mlombard@redhat.com>
In-Reply-To: <20260311160920.465209-1-mlombard@redhat.com>
From: yunje shin <yjshin0438@gmail.com>
Date: Fri, 13 Mar 2026 14:58:55 +0900
X-Gm-Features: AaiRm53aA3gVfTU5pF1d07Mi9Givz4AZ2m2GBVHaLXnlMU1gduTPL1D3LOPhhqE
Message-ID: <CAMX6_QHFZE35qNXZyn8-SDkoQ6dUAuSLXSH__65CWxLtSTx5rg@mail.gmail.com>
Subject: Re: [PATCH 0/2] nvmet-tcp: fix receive path error handling and state machine
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, dwagner@suse.de, 
	hare@suse.de, sagi@grimberg.me, chaitanyak@nvidia.com, mlombard@arkamax.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_225907_639238_65FC5235 
X-CRM114-Status: GOOD (  11.19  )
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

On Thu, Mar 12, 2026 at 1:09=E2=80=AFAM Maurizio Lombardi <mlombard@redhat.=
com> wrote:
>
> Patch 1 fixes a potential issue where network data could be read into an
> uninitialized iterator. Currently, nvmet_tcp_build_pdu_iovec() returns vo=
id,
> meaning callers are unaware if an out-of-bounds PDU length or offset trig=
gers
> an early return. Consequently, callers blindly overwrite the queue state =
to
> NVMET_TCP_RECV_DATA. This patch modifies the function to return an error =
code,
> shifting the handling responsibility to the callers to ensure proper sock=
et
> teardown.

Thank you for the patchset =E2=80=94 the error propagation cleanup looks
really clean and makes the receive path error handling much clearer.

I've been trying to reproduce this crash scenario on my end [1],
but I haven't been able to trigger it reliably in my test
environment so far.

If you have a crash log or call trace available, could you share it?
It would really help me verify that my test setup is exercising
the right code path.

[1] https://lore.kernel.org/linux-nvme/DGUSGT9WLRH8.GBZ0CM62IV9T@arkamax.eu=
/

Best regards,
Yunje

