Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE37CCF9E3
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 02:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tOBiGMjKhHhNm9iRoWYtTXCHrvcBZZIink414T14gME=; b=gRcwUR8qtnjYnJB2QyTleSm5Sc
	Gbwtc8wwxy180p5P5pG2AWB4a+hoOrIikyCEcfWzBRfrpSRrL/gslQ/TPKKozuoKVGzy6PHYDmOm2
	1BAX83l+mh0L3wgBHuqX4ApgLD9RK1VwDtYW4iTzphkZwnqXoOq5eDmu+T//4LMF+3CaQKUfHagSp
	FU4UwRbYlF4yOtKOdi6azGEFgOZ2boISFFBoGzs77Fx0+ZsqJ+lHSQodIbPNdEp3ROhvi/P3SOVWA
	CAwK37rxR+Jx6o+qtOAns6p91HON/vrA59V/K7K1P2StVrJqtIMith1zc/WAXMYBMge27/rdZzC1B
	fVP54djQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFkFv-000000093kK-2OYY;
	Mon, 03 Nov 2025 02:25:15 +0000
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFkFt-000000093jW-1pkK
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 02:25:14 +0000
Received: by mail-yx1-xb12d.google.com with SMTP id 956f58d0204a3-63f97ab5cfcso2211667d50.0
        for <linux-nvme@lists.infradead.org>; Sun, 02 Nov 2025 18:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762136712; x=1762741512; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOBiGMjKhHhNm9iRoWYtTXCHrvcBZZIink414T14gME=;
        b=OwBb0TjlK+9QYrXzKCfgcXJcLdfYR4T7B71Eh+rBzPbLLcaVd/DJ2EmMYovWsJYEvE
         Fjd4vAS66vGfReCTc1Nqa/oFkACHW6vRJYAsSZJt4fr52k2tuQhOGyTPeBcltU/uMmhl
         MeEIHgfZ8lFssC2Vj/buJ1QnmAkK9wf8RXUJxqjvHADvpqGtf70TpcZNoQL9DgfXcyxE
         YYp6vUdv7DW4qhcI7PodjRG0TIlmoB0JxmWxYgWvN0na7sBoVpfUywrEZ2lgUYIwTtbH
         3+b9Gij1VeoPhjIwiPKUVUpWKstdnreHmROlsj7ump9K4MZfm9JMFYoor5QMEs8hr4vc
         iPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762136712; x=1762741512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOBiGMjKhHhNm9iRoWYtTXCHrvcBZZIink414T14gME=;
        b=CegxE4kZhs1jKu2rOh7Fnomh0vXAEgQVElAA+1KjWwRpCY8/mou3vQZA8Z11G4Dlt1
         dgda12jbItjkvpNLi7u3m3BmscST04WG4OyVbEvgzj19gxwG3caBkSHSgH7xBr8MNP7D
         VmVNi+r5c7CMgY83Zq0KekGT5MJj+SKGa5xpdFGTEHQQbfdGToz84GgykWlS1imSTBYJ
         8o7OxRhEpXhAi2AZZam7u3RSDS83aks1cv3eVqO+E2Pj3JN4RiRq2+tdoCSnkehsv0Yu
         MxTInXfqEjpaJWXaH7rFoECzOSkfGUa3LGgnRwmhgFQ31Lk/Al1/1Q5rXf5tkD5ws9ih
         bIlA==
X-Forwarded-Encrypted: i=1; AJvYcCXkiFusppjhKvcyClcswre58ZktFa7eXrA1747uUNP0OlGqiFa4fgTP7fwBtzzHjUA538QHPoQnNsq5@lists.infradead.org
X-Gm-Message-State: AOJu0YwdM/zyRRFDQi50kppsUPJ0+HvH6o8dnDbv06D9N9L3m7IT9iwM
	qUI5TN6bpQdwRhAsIv6MxL+qYz1M5achiUe7EjkI+Xaufxdx9CHb5SKvjZ17FO1kOE+P6vLBJ0b
	AJQrZo9CB/mKTXF+qOOjvSIaV9QBzZsc=
X-Gm-Gg: ASbGncvra79riju5KlTWFtpt5VxbhRfvc5eTj3ncVb1wb93NYBx4ABU3eYuAeCydp/a
	fmg5QfGVfELPrY34Mfl5zIYG3uBtIYNItCQe8jg2/CfwplnG8hvxLy0yX6MWXBgheZQBG1Bpdk5
	cEgHelteIKcCU2B8jyQ873BD6EHt82xDVp4RLZWyTJfk858WR/7g8e+hlMSvBo5MnqI0QPFZ8GF
	MCOSVYq+rCXXIToSsNHRjcropJhFQPQjnMD4v/X8qE7ezlNF5sf7QbAJDFDxugZ9X+jUJSxLf0h
	DGQ7tgc9aQjgolDtOTGLV99pTA==
X-Google-Smtp-Source: AGHT+IEeBkFXELLCeDFxu+34BDAmWRmEEj7nNPJXW/YWouHM1T8Z4qQirvrUHGiy48XsOmU05GjJwP0NmEXrQU+38P4=
X-Received: by 2002:a05:690e:154f:10b0:63f:b366:98d5 with SMTP id
 956f58d0204a3-63fb3669c8amr1892576d50.9.1762136712170; Sun, 02 Nov 2025
 18:25:12 -0800 (PST)
MIME-Version: 1.0
References: <20251030035114.16840-1-alistair.francis@wdc.com>
 <20251030035114.16840-4-alistair.francis@wdc.com> <20251031140541.GB17006@lst.de>
 <CAKmqyKNr8N4r=9RvgErr-zj929gd8oRfdKGgrhVajK_UxR828g@mail.gmail.com> <b684812e-8ade-4adc-aa08-2e4fcc9811d7@nvidia.com>
In-Reply-To: <b684812e-8ade-4adc-aa08-2e4fcc9811d7@nvidia.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Nov 2025 12:24:44 +1000
X-Gm-Features: AWmQ_bmKh7TFL5lTYmkXWdj2JituwISVLIf_nQtPpzZV3P7FriZGvVY7GennhXg
Message-ID: <CAKmqyKP4sWF_HbP4FNK9w1AP_MxnTNBjzO+uYaumT9p4UigepQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	"sagi@grimberg.me" <sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alistair Francis <alistair.francis@wdc.com>, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_182513_519998_396C01C4 
X-CRM114-Status: GOOD (  19.62  )
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

On Mon, Nov 3, 2025 at 12:05=E2=80=AFPM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 11/2/25 5:47 PM, Alistair Francis wrote:
> > On Sat, Nov 1, 2025 at 12:05=E2=80=AFAM Christoph Hellwig<hch@lst.de> w=
rote:
> >> On Thu, Oct 30, 2025 at 01:51:14PM +1000,alistair23@gmail.com wrote:
> >>> From: Alistair Francis<alistair.francis@wdc.com>
> >>>
> >>> Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> >>> This can be done by writing the queue ID to te sysfs file.
> >>>
> >>> echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/replace_psk
> >>>
> >>> Note that only QID 0 (admin queue) is supported.
> >> Why pass the queue ID then instead of a boolean value?
> > I liked the explicitness of passing a queue ID instead of a bool and
> > it allows supporting more queues in the future if that changes in the
> > spec.
> >
> > I can change it to a bool instead if that's preferred?
> >
> > Alistair
>
> do you have any plans to add support for the I/O queues in future ?

No, it would require a spec change

> OR
> have a strong usecase for I/O queues to support this feature ?

I do not, but it does seem like something that maybe should be supported

Alistair

>
> -ck
>

