Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592FBCCFA13
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Nov 2025 09:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yLyXjYFXqWstrak83rCupm0ESjDS9MUZyp6jbuMyBOI=; b=uxJXYB5CrwfdXhKmrNHiETs99H
	vwYMkCypOdGG651hiCd0l3cQeki3hsGGfsYz7NsuWd/FvwUeucDF3fzdcqBplSlZ+hi3LKKMSqRlf
	V09uwyWtZaocN+RP/XF9ExYQWx797kODIWys12YokETBYw2rPT6b60LH08Es22J9hqUbA+kj395MY
	z2uwRMO+Cv19SMSN9nyG7echOdRi7Y5SKSq7FtZ5xniQgO53CDlmXlnlnjzc9IeqPHx02SLW5ctDA
	HNaRGvsnkdhIryCZo3SLaNFz+BvEihRzy0/kFORFLkBw7sgvzgmILkABQrS6/4dGw5AKiB4ed/2YS
	a5roMrOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIOSe-000000057CL-0Lrt;
	Mon, 10 Nov 2025 09:45:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIOSV-000000057B5-2hAY
	for linux-nvme@lists.infradead.org;
	Mon, 10 Nov 2025 09:45:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762767909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yLyXjYFXqWstrak83rCupm0ESjDS9MUZyp6jbuMyBOI=;
	b=EZ7akTCdxRs7EzwWO7GNduVzJefrsX9d9UPCjeVxfyTvLcRg2bLRoasQ6+bEOCULZCq7tV
	F0Lu7M7tfB8YOzTuiNEE1yXJ088/4Ngg14whPcp/h9essUNHvL9jSTQwSVNlWwx0kizQv7
	2XVnI+9/ITxqUYW5cH6/V5q24TJW+uM=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-bnYueeM5PvuBTsqg3DYbcg-1; Mon, 10 Nov 2025 04:45:07 -0500
X-MC-Unique: bnYueeM5PvuBTsqg3DYbcg-1
X-Mimecast-MFC-AGG-ID: bnYueeM5PvuBTsqg3DYbcg_1762767907
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5dde32b5498so527592137.1
        for <linux-nvme@lists.infradead.org>; Mon, 10 Nov 2025 01:45:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767907; x=1763372707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yLyXjYFXqWstrak83rCupm0ESjDS9MUZyp6jbuMyBOI=;
        b=iBw/UuVe+eRTdOHtiCNJ+kwlQ+3C3UWRo5K8WO/k3Wa4asd3bDj/WDOpv1kioHZheb
         LHaEqnhRpB7894M2dQBbWlqi2Cxx0MMc4iRRzEs3LJtxfY6T92AAzSAlezIZE0cveCiF
         /baQ3ZDrDMwcJox0zttLo3EZhjUoHBeDdpDBoi8RnSANfet8xjBxEqo/i5snfvPC5fox
         Wbdpjwb2qnorNHdPvCu8iwXiXhexkq28Kv+kG/CUJXT9ZS9KuQR2v/8IOKKyIj+MqXzr
         JDNKet0zNBYQXfaOJKMW/7S7b2ac90CaeYTlRbQZYTrFEkH3ikeCdtb8dgzulPGLA/tn
         S17w==
X-Forwarded-Encrypted: i=1; AJvYcCXEqyOIuf3g6JevrA4owM32qze0lL4rWqdrVZ1Odk0F2Rac3SZcQ3iOuY8xoAwmwml0OaU1nhN7q7Ru@lists.infradead.org
X-Gm-Message-State: AOJu0Yx8mFil4xH4oRjCUtNFAwLW89VVIbQLgnljJ+vTpf5PuA9yZWLn
	ykS+24CptES/s3aSwx6mSrlfJwTQRFELZO8Bucz8TI2zt6U43P5DnLNHi5l2rClacCPhvnz3+Bi
	AcOP1Q2yzTPyeMeDjEi6s+T4hnOIAbWi8diSX6kXT6JSxInaGSq7QfVbn8b27VBZjNqaziSCRwv
	JnyPwKCtxleUDMfLBQfvbnDapHJpxhZNCyugufdJgqbKI=
X-Gm-Gg: ASbGncvSm0jrM6soEuKQR3k5mI2EhFU2ldWWNpOBbG0j13ntQSEa41YZThVedNimk5l
	5rseOgHvFUs554ET16lFHl4ODW8IOpAeEt5AXDuBaP8e35Jy1cxTRRyQ9W/UMnNGW6t0skdTCsr
	B9SY+qZd5CCm2Rmfj1HNXBg+tFl2MaX/hM2AYpSBNDWuPoubS6StPsS80Y
X-Received: by 2002:a05:6102:509f:b0:5dd:b288:e780 with SMTP id ada2fe7eead31-5ddc45376b3mr2501944137.0.1762767907014;
        Mon, 10 Nov 2025 01:45:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/yYFVdBstpEFb3Ck1k5v17TU9H66w5gxYmC9oJYim2lSVQ0mI7Bkz15ozgt0Kajlovah77rM8bEk8zqdRVoM=
X-Received: by 2002:a05:6102:509f:b0:5dd:b288:e780 with SMTP id
 ada2fe7eead31-5ddc45376b3mr2501936137.0.1762767906633; Mon, 10 Nov 2025
 01:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20220227234258.24619-1-ematsumiya@suse.de> <20220228092215.GA8549@lst.de>
 <36cfd242-6bb0-0af6-0faf-946c79baa378@kernel.dk> <20220301033001.tozk6cakdznww6wi@cyberdelia>
In-Reply-To: <20220301033001.tozk6cakdznww6wi@cyberdelia>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 10 Nov 2025 17:44:55 +0800
X-Gm-Features: AWmQ_bljs7L0oGwHxE2CM5naDDRqZ6T5ZNbQfm76vOzWoHAALjpDvqmytaIxKts
Message-ID: <CAFj5m9KDFNi+8AMdGeJzgbsKFnfanWJk2dESeCgdF=KXi+9arA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: trigger disk activity LED
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Up5KoD5vNf7CmnZ-9LSfsem7Qrr6NLlZO7j5Tj81TCE_1762767907
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251110_014512_099628_A6B1D15C 
X-CRM114-Status: GOOD (  19.38  )
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

On Tue, Mar 1, 2022 at 11:30=E2=80=AFAM Enzo Matsumiya <ematsumiya@suse.de>=
 wrote:
>
> On 02/28, Jens Axboe wrote:
> >On 2/28/22 2:22 AM, Christoph Hellwig wrote:
> >> I don't think we should add code to the absolutel fast path for
> >> blinkenlights.
> >
> >Agree. It'd be a lot better to put the cost on the led trigger
> >side, and not need anything in the fast path for block devices.
> >Monitor disk stats, or something like that.
>
> There's been at least 4 attempts to do so, as far as I'm aware (one of
> them being mine). All got rejected due to the complexity it introduced,
> that's how I ended up with this one-liner.
>
> Performance-wise, I'm understand the problems, but according to ftrace,
> ledtrig_disk_activity() adds an average of 0.2us overhead, whether an
> LED is assigned or not. Is that really unacceptable?
>
> If so, would introducing a CONFIG_NVME_LED (default =3Dn) and wrap that
> call around it make it better? Then at least there's a chance to inform
> users that desires this feature about performance costs.

Another solution is to do it in userspace by tracking iostat in a fixed per=
iod,
such as, triggering one led activity if any read/write IO happens during 0.=
5sec.

Thanks,


