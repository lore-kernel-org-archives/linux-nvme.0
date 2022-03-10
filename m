Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903E2C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 12:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5+S/19T7z8CqGJz5OOOtlJzN3mZfdNMJ1w7/PO7Phfo=; b=P37myGWhvisOO0HlCt1sfV/Q35
	6I/OGjDq3EBX0HiH2D+oHzbxPUGiKehaEje1x+Q9Mj7Z4ZcvfmXhxONgc3Z+skTjpcIlm0PjnY81s
	ovFYVBAnlaakQUQLd+LyB328rIVcu2xiFbQQWsBSjhJvfzHa4h5uEgSTEb8NN/wxo/I3//NEfAyx0
	W14koQJTQKmvnqeUdVoLTWBRWEbqXUdmXhhjKEoZfZAaF8Pvs36n9ZQZ8RQc+Zjv29WtBFm/cPIB1
	4dO4E8c56+JvHIrcDqIhUlRkDuklIi//GTt9hSCuph5IItmImN8mva7FaRaVJu1BoJhtuFWO379Kb
	pItVFtKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSHrI-00CmFH-FR; Thu, 10 Mar 2022 12:25:32 +0000
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSHrF-00CmER-PH
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 12:25:31 +0000
Received: by mail-lj1-x236.google.com with SMTP id 25so7444196ljv.10
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 04:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5+S/19T7z8CqGJz5OOOtlJzN3mZfdNMJ1w7/PO7Phfo=;
 b=nk+hj7MWuNgvAdNzdtNd0A6lvaKaHdkrpdRyvFi/F2c/bBXMOB8M701YRllaDH9Wvx
 +Tb+/eUbI+ukdykKaWWDDrgKeuoEUjq/eZ9SEcevo2tfDRht4CVXcDEGBnYf+TuIXmSj
 eyzKE/PcjKx2SuqxKqHK6AGpoKLtjonkXc7NjULd2qCWbOywtgdWla2nasjfcJG+xcJ3
 m2tzOh4XC1zi4YO/fe4NJ4kPU3al8dOJN/ylDqRMbXwRCNF0NVTNz3O6UN/nrNWYeF5J
 yhIrolM2pNKobaZ7OyNw/RxpvHQNLPecNi5i9embbAU3QhZ+aLLum+4etw/AO6NBS6qf
 48nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5+S/19T7z8CqGJz5OOOtlJzN3mZfdNMJ1w7/PO7Phfo=;
 b=RJrIf78ksDz0SCMwuLgbX14a5g5Ob/aSsIuUzdkBoSjduEFTCCzUNJZ7MO7qWDUSn+
 5pljP9UQYc9r0pH2FwclV5CcGP3HytjcgczP55kLeao4mTMrtG5q/FpOgX6pdLcULWi6
 wpYNhI0BpC6Z4N/NB7zmoqL3DBlnFNG1RPf6CQc8fXDVo8l0NhC/W2ZCeYQjkpgYV0T4
 tfjroDLsRvTRZyN/x8sRxuMbOKIB7xgJ3vKV0uMumaSPpAAs6dLTUZK/GDL8JX3HfhR/
 Ukchq7Qge9jeFZdvoHnMNvWnGH0hSo9Neb3EFWMv/WGcdoUFtoLisfTcWkjFU935Q8MP
 AvRA==
X-Gm-Message-State: AOAM5308yba9ftyeJZLqErtysoszo+jQVRaPdqO7MB1DCWV/Bs5WWKiX
 Qud/+lPylsuwgBB/Gvy/oilDXhJt/n13p+0hW64=
X-Google-Smtp-Source: ABdhPJzsG6bp2WM29pnDrFfkLztteUacWjOolraWs5IwAxOIBsy7dmQHWUuyglX9BAPiJLNIBiwnRBUE+lYZxUkRT4w=
X-Received: by 2002:a05:651c:b07:b0:247:e06d:8943 with SMTP id
 b7-20020a05651c0b0700b00247e06d8943mr2736349ljr.426.1646915127520; Thu, 10
 Mar 2022 04:25:27 -0800 (PST)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152716epcas5p3d38d2372c184259f1a10c969f7e4396f@epcas5p3.samsung.com>
 <20220308152105.309618-12-joshi.k@samsung.com> <20220310083503.GE26614@lst.de>
In-Reply-To: <20220310083503.GE26614@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 10 Mar 2022 17:55:02 +0530
Message-ID: <CA+1E3rLF7D4jThUPZYbxpXs9LLdQ7Ek=Qy+rXZE=xgwBcLoaWQ@mail.gmail.com>
Subject: Re: [PATCH 11/17] block: factor out helper for bio allocation from
 cache
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
 Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_042529_855698_D3315B3B 
X-CRM114-Status: GOOD (  10.85  )
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

On Thu, Mar 10, 2022 at 2:05 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Mar 08, 2022 at 08:50:59PM +0530, Kanchan Joshi wrote:
> > +struct bio *bio_alloc_kiocb(struct kiocb *kiocb, unsigned short nr_vecs,
> > +                         struct bio_set *bs)
> > +{
> > +     if (!(kiocb->ki_flags & IOCB_ALLOC_CACHE))
> > +             return bio_alloc_bioset(GFP_KERNEL, nr_vecs, bs);
> > +
> > +     return bio_from_cache(nr_vecs, bs);
> > +}
> >  EXPORT_SYMBOL_GPL(bio_alloc_kiocb);
>
> If we go down this route we might want to just kill the bio_alloc_kiocb
> wrapper.

Fine, will kill that in v2.

