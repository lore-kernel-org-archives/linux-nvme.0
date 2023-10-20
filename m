Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993BBC001DF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mF0w62trqYcHCfLDfzhxkaTZFMEm0P6zCkg1/3Jkv8s=; b=w3lz29zL/uGKTVKuJaZbXS3DRF
	+QlmtjcogifRjkuTUuIZZxjJf1CcaNZvuMeKc8D9MPCtEMhFbDCA4A1S9xcmpfDVPJd20B7rUgB5O
	69HQVEMZOC+nzFNcsiTJ35OrSJ7N93KCA21a457H5h9ocySdtL8W9ydT+AzRTxbqxkaLnL6IFOs1M
	S/zqjsolgCgT12d5wkjHDvo2XTB0y2DIPEvat3dnr0Wv/bz0olN+u29mRLFjbu0V7Xh+2rrvLx6CH
	p5iK/RZELGND77w8EN/ken6bHVJEnDaFiFUEKcCcRGCD+RQlUeaORFp3zOjJzuumSAKW6R7DDZUmv
	sc8e6SHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qttU9-002mcG-35;
	Fri, 20 Oct 2023 17:40:33 +0000
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qttU7-002mav-1O
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 17:40:32 +0000
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c51388ccebso16307231fa.3
        for <linux-nvme@lists.infradead.org>; Fri, 20 Oct 2023 10:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697823625; x=1698428425; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mF0w62trqYcHCfLDfzhxkaTZFMEm0P6zCkg1/3Jkv8s=;
        b=nIAx+RuF4ZW5cSWZWeq/UG6ExDBykZseTBASHA5EEGGTcg3fxyYVtZUBIz1PmUUlhz
         3iaQg1pZe1MM3loIluo92/6LNtKqc411DH0zNTnhoVQYTNoEyFwHF7Z3QUsEU3Ce/hNw
         0kYSmp2l2qZVfVeD9SZFWJUgePuO/uqp20WlODB+T/eXvTwaFoq6QtUrpwBrVys71CEw
         373hWOexLQEa5qT2OSsBLokIqDrSRxX3zlH9pu6T+CTV0IYZtcT0Lk503hXmsx+Bnh8X
         7Er7U0v3VGeqfXkF8hDz0lYIo0RFHD3srd6CA+O1EEGrQlW9nCCYfJ7q7/lEYGGQ6ZGI
         ZvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697823625; x=1698428425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mF0w62trqYcHCfLDfzhxkaTZFMEm0P6zCkg1/3Jkv8s=;
        b=G5U8UeAp0ov6AcSilEMis/06RvH2/9rTCjrUvm2/bR7ec4wXJkYULG85SmmjD3oJHf
         Jz7T3qeGmm5xLqoEiibRazOGbKzL36QMO0nUW650RbaUTZmc0Hd1CInK8XyF4RXgqfhV
         jqNfKcBEtUtM00BAN9g7zV1WzesUfpQwQzc6pqck3IwtrCE0Gb/CafDNLcooPUia+dkC
         9W1EpHgTJpx6WaZpUAabRo4PMpDQ+Y0xG7sDDdJYJvsXZnvvecoAPO8JVZ0KNGrrYaHN
         VXt5lfHnQUdkpPyQiP/gZBRP4IPIsycbcpClPOouCC/Xj/IoR3pLqzsZpNuAMwKnTQiw
         pv6Q==
X-Gm-Message-State: AOJu0YxZtx6GHVo4pkMkJ7zHrYgteojLwy1nKBRwY6QPEZ42E6Uk3m83
	auSPSdcGr0WjviDCXlSi7HH95afX4z0SaU2r+zD5Ww==
X-Google-Smtp-Source: AGHT+IGa8/lJXmLSId1P+cwpoUCl//EotM3rxi6/MgjhAIod6PDU4OLCGZng6oGIb1YJJRHEDd4b0KgzHntGWUqAxb8=
X-Received: by 2002:ac2:4573:0:b0:504:3807:22a4 with SMTP id
 k19-20020ac24573000000b00504380722a4mr1925746lfm.23.1697823625262; Fri, 20
 Oct 2023 10:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook> <20231020044645.GC11984@lst.de>
In-Reply-To: <20231020044645.GC11984@lst.de>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 20 Oct 2023 10:40:12 -0700
Message-ID: <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
Subject: Re: the nul-terminated string helper desk chair rearrangement
To: Christoph Hellwig <hch@lst.de>
Cc: Kees Cook <keescook@chromium.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_104031_470450_29013548 
X-CRM114-Status: GOOD (  15.87  )
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

On Thu, Oct 19, 2023 at 9:46=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Oct 18, 2023 at 11:01:54PM -0700, Kees Cook wrote:
> > Almost all of the remaining strncpy() usage is just string to string
> > copying, but the corner cases that are being spun out that aren't
> > strscpy() or strscpy_pad() are covered by strtomem(), kmemdup_nul(),
> > and memcpy(). Each of these are a clear improvement since they remove
> > the ambiguity of the intended behavior. Using seq_buf ends up being way
> > more overhead than is needed.
>
> I'm really not sure strscpy is much of an improvement.  In this particula=
r
> case in most other places we simply use a snprintf for nqns, which seems
> useful here to if we don't want the full buf.
>
> But switching to a completely undocumented helper like strscpy seems not
> useful at all.

There's some docs at [1]. Perhaps there could be more?

[1]: https://elixir.bootlin.com/linux/v6.6-rc6/source/include/linux/fortify=
-string.h#L292

