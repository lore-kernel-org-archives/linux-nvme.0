Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B407CCFC538
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Nov 2025 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AoeYwuTA2OCKqGileGsNd+ysqL+d5N6ZH/jsAbQy4b0=; b=RrHjW6/NgEdK8OD/Gy3SwTwcO8
	VegT/YfpGeubpjmnC2ms/DIp32Ym1ygqqXNjaRsLAsjczyX8CpAvgX/1IuV7tfGIJqMrleWu9r8LW
	oIZUx7aFmLHmAeVjqpHM6j8kVl2Ps6A7lrhGYoiePQcNn1k+7WyvrFj5m+jXumChKcarpP+3dL4Yx
	MkZj9kHnVULjYuN3AR1mVRnsA9rdZViN78DO0DV71ttNa9/zwXyEPo+xXrS9xLZRtYVR7Z8WSLZ+t
	MH0hTHfElLkUGEgD3GvRA+h3kJIc7kbTbLawFscQIpTMqjrhfNP+4bYEX+/KY1P0GRhs/HL8+9TbY
	v536qXzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMp38-00000009g6E-0Kg0;
	Sat, 22 Nov 2025 14:57:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMp33-00000009g5h-1Tpw
	for linux-nvme@lists.infradead.org;
	Sat, 22 Nov 2025 14:57:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763823431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoeYwuTA2OCKqGileGsNd+ysqL+d5N6ZH/jsAbQy4b0=;
	b=Ww+pl2V8p/Ei8G2LzFV0Deobf6rlBBVDxLzff6He1jfpnj1M04DKWVfZQ+XqvRbOlZmz8t
	kFxRioFV+A5LnAWmYpehcfFaoxVPGIGVPu3qfIfviRNQhDPPwrdEm5NP+R5X1ZzY9CuqgT
	8rhuzLn6Usy+xBddmA8twGr0aR66cNY=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-j3bdCbarOTyhdpQUopqTtA-1; Sat, 22 Nov 2025 09:57:09 -0500
X-MC-Unique: j3bdCbarOTyhdpQUopqTtA-1
X-Mimecast-MFC-AGG-ID: j3bdCbarOTyhdpQUopqTtA_1763823429
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-63e35e48a1aso3744003d50.0
        for <linux-nvme@lists.infradead.org>; Sat, 22 Nov 2025 06:57:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763823429; x=1764428229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AoeYwuTA2OCKqGileGsNd+ysqL+d5N6ZH/jsAbQy4b0=;
        b=X67CCjKMrOKp8i8F2U+vFmhh5dbfjRgKdKwF8iM0zSQDSUqOhNvQTt6tD6t1R44lRz
         32L9ZzsElXAc7FockOTZ/cjyxzadnkg0O2PlIWUvxHpQ5O7Ab/OurRaLi2EnqMB7NGzV
         h0GsWljAXvnXU+ttu3nZ9W4x1QUzfTrYwWboMYthQhyqFAn+F/ZrG49epTvcZku5PmQX
         K5VW1DTJedB+EwwnPZWCK0EO9dbpL8n2ogdNK6Pu5Um7jgj799Z8zlj8qtXMjyGmxacf
         2AGyhcXsADxZ1ohdnpi9z/3RV0h9Y0U642a1+WVekSiL6BZoE+GP+GSxfIKCmEIbwOEl
         6/+A==
X-Forwarded-Encrypted: i=1; AJvYcCXu6vSx/r0AIdDU9WXlGs7yg2YPf7kbNhOG9H5v1XaozGIeo24kEw//t98AE7GCRyhArFCPn3aWzEBh@lists.infradead.org
X-Gm-Message-State: AOJu0YyUiFrlY1Ns7PpuT6y99MUmKj5Bxud9XKXpdzX1KrwAJ3NhZ9YR
	WdsDanBcmfbChAkrc84GgP78a3qY+4w4L1/9W9BiLApfVL00fdxnFZvcjfHYgRvM9tF+vYXQ2KY
	rh3M6zN5Qps2ysbMsL81jjoi5onvi2+i0eSWG7MTqNuOVVICYAzJfThvSB6hTMGWzGZRaod98DD
	Epbwkq63tawLBfkLh9zwhR7s0cIucsFCHfxIFzjgaPJLY49cv3+MVuDQ==
X-Gm-Gg: ASbGncv2nqVnW1Sabe+sWaAAMsN2/G6lnxQT68HMeHowIC78HFlUpcfRkHVqe8pMCDr
	0hCIpHqp9JTVUB/2X0m2LHmvm9r85NRZDv1PcnevkUGXDQd02kS+T+Lt9fUmUGJ3w3iiotyF+La
	D6UybpKmTgMW1a/tRloEKwCDcEhkMK42GJVclHA8sN1+HcF4F9OC8H8EWISEvTH+GC
X-Received: by 2002:a05:690e:1511:b0:63f:a324:bbf3 with SMTP id 956f58d0204a3-64302ab18damr4335097d50.42.1763823429380;
        Sat, 22 Nov 2025 06:57:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJA7IrsaRMoz4Q/MV8XxAm6kxOszSooFbnuk2I2D2sSCVAvxGo1WW7Hp8NfZ+CGh7b65wTnbGGciN5n9h/Z58=
X-Received: by 2002:a05:690e:1511:b0:63f:a324:bbf3 with SMTP id
 956f58d0204a3-64302ab18damr4335087d50.42.1763823429039; Sat, 22 Nov 2025
 06:57:09 -0800 (PST)
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSEvg8z9qxSwJmZn@fedora> <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
 <aSGmBAP0BA_2D3Po@fedora>
In-Reply-To: <aSGmBAP0BA_2D3Po@fedora>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 22 Nov 2025 15:56:58 +0100
X-Gm-Features: AWmQ_bkhaeO27ks2qTqUvx9zYAyPvR45fmibJyAeax_P7fjCjfN3MMivydMdvis
Message-ID: <CAHc6FU7+riVQBX7L2uk64A355rF+DfQ6xhP425ruQ76d_SDPGA@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Ming Lei <ming.lei@redhat.com>
Cc: Stephen Zhang <starzhangzsd@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lGi2xbzyuLA-gMkwwZ2n3kbf_Wz2YZePyxhYPip79Nk_1763823429
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251122_065713_822076_E8048E8A 
X-CRM114-Status: UNSURE (   9.41  )
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

On Sat, Nov 22, 2025 at 1:07=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
> > static void bio_chain_endio(struct bio *bio)
> > {
> >         bio_endio(__bio_chain_endio(bio));
> > }
>
> bio_chain_endio() never gets called really, which can be thought as `flag=
`,

That's probably where this stops being relevant for the problem
reported by Stephen Zhang.

> and it should have been defined as `WARN_ON_ONCE(1);` for not confusing p=
eople.

But shouldn't bio_chain_endio() still be fixed to do the right thing
if called directly, or alternatively, just BUG()? Warning and still
doing the wrong thing seems a bit bizarre.

I also see direct bi_end_io calls in erofs_fileio_ki_complete(),
erofs_fscache_bio_endio(), and erofs_fscache_submit_bio(), so those
are at least confusing.

Thanks,
Andreas


