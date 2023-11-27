Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1B4C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Nov 2023 20:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nrVYVydZbyRGYPHj4jJ2zvO5RbpjbPIEOTYbXLBhDfA=; b=ToNORFLxHmyEnwC/+oLIVKRjuK
	v11Cf1jukzujM/zrFlWStSY9yf9igJWTeVuAcHfbBJ8AVi19Zc1gou5VffyXN+rYW6HniDOxjz32B
	JZ/+paHsl75SCYZj4Zo/C1zi8tNbyd1F7PCzmc7UHGx7S0+H/4uVcA4OxBrFJmcG+M0CRxLsQSJpd
	uCnHDqNyFoBVM0EnPbP8o8zlBGgnwQyho8fTHWCI1fh2J1mchfBg8RWQN3X1dzufdmsI/fbOiwMEe
	fGFI5svTS7Xa9O4nOv4LaUMeo0hVkW0M0ri21tjgF0ab7t5/mMZVPaO30a/s/J8QQvk9hEBdMtqVV
	oSyFvqxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7icQ-003TG7-3D;
	Mon, 27 Nov 2023 20:54:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7icM-003TFh-39
	for linux-nvme@lists.infradead.org;
	Mon, 27 Nov 2023 20:54:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701118447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrVYVydZbyRGYPHj4jJ2zvO5RbpjbPIEOTYbXLBhDfA=;
	b=elPh19CNeZAnrUBiE9JXzzBnFiyo3JjrqGd69MB4N+NUlYgRnBkmcqEICbTvvVDKP+gABY
	/z2OFxx0Wn1Nxqu7XcsPYZvoqsh1TtnrACFuyhDOHl4TFQM23TuDn1ALdWbFJBtOwoGGWo
	xtZKF4YlWfrlg4EZZgJHCn0Q0DXvA+4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-cBYGQWuoMlyF9x0VMTEK8Q-1; Mon, 27 Nov 2023 15:54:06 -0500
X-MC-Unique: cBYGQWuoMlyF9x0VMTEK8Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-332ee20a3f0so2428468f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 27 Nov 2023 12:54:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701118425; x=1701723225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrVYVydZbyRGYPHj4jJ2zvO5RbpjbPIEOTYbXLBhDfA=;
        b=n3Fy3ef760EiRFflb7xTvVNvXigq5THbinbwOynkXj2tm9DqXZ+G0O03O9RtTe7+l8
         1aw0vYS/hVXtnIAaWomAF6AlxIR+ysz6S6obbYoazs3AXuxwEnBAzNWPAsfqDWKK2AyI
         zxMm3CsvVN+gHg/5Ua69jJNXQCktlVLCEfhmVFs+iYNzt3E/o2KAYlA4p3eL/gje0Uoh
         uB+G2AKA/yQ5yRj6kQXfN3Z8z9/YXHKH0JBV8ndU6S/31R6cSGAzAgARRdBNIZgnFS+m
         F4Q8eAx/6DtqAWhX1krwEorA8IttycO6xQkq38DlC0XQfPwEJnsoM1p/Usu7iDfZ2i0N
         1B4A==
X-Gm-Message-State: AOJu0YyXY/nuUiyoZu8wcmKljslqp5gMO5ZSn0HzAiMoyNQZod36Aotp
	kfhaVR2PAY7sUD2oaKXZjwbOW0LrF1zqFPZETYhXYltuqvYkNUEK8ASlL4Y4jrBj0UBLdUPtw66
	hl0Uq1LpCUuVLANWZKeUf7BNtZhubstQ7J4kTOFgF9cY=
X-Received: by 2002:a5d:49d1:0:b0:32d:9d99:d0a5 with SMTP id t17-20020a5d49d1000000b0032d9d99d0a5mr8579005wrs.5.1701118425347;
        Mon, 27 Nov 2023 12:53:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhxZjfyUCU56h7kF5M3MofC8prEy8sT5V67Fj2awR5wnpc0pAYSPwxA6fHVcewN5JiyghmtNm8HvmFOFskTvE=
X-Received: by 2002:a5d:49d1:0:b0:32d:9d99:d0a5 with SMTP id
 t17-20020a5d49d1000000b0032d9d99d0a5mr8578998wrs.5.1701118425036; Mon, 27 Nov
 2023 12:53:45 -0800 (PST)
MIME-Version: 1.0
References: <20231110163721.15292-1-emilne@redhat.com> <CAGtn9rmMLQfsocZvWJnnekRxfL2_s3oDYcUNTy3M0c2d8UYYfg@mail.gmail.com>
 <CAGtn9rkynCF1De25--d39D0o2Eh2QV4aDLOxaRYrw2m1ouu_4g@mail.gmail.com> <ZVzzW0P6CtataBLK@kbusch-mbp>
In-Reply-To: <ZVzzW0P6CtataBLK@kbusch-mbp>
From: Ewan Milne <emilne@redhat.com>
Date: Mon, 27 Nov 2023 15:53:32 -0500
Message-ID: <CAGtn9rmcHUG4TEVh1zzGPmGAGnpsp9UrO5tT0gysVznhxDz2Zg@mail.gmail.com>
Subject: Re: [PATCH] nvme: check for valid data from from nvme_identify_ns()
 before using it
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_125411_118875_1E2B960E 
X-CRM114-Status: GOOD (  17.58  )
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

On Tue, Nov 21, 2023 at 1:14=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Tue, Nov 21, 2023 at 06:49:35AM -0500, Ewan Milne wrote:
> > Oh, never mind, I see it.  Just didn't see anything on the list.  Sorry=
.
>
> Is it? I don't see it in any of the staging or upstream trees, but thank
> you for pinging me on the patch.

Sorry, I wasn't clear.  I hadn't seen any replies to my original patch
on the list, but
I saw a rather long time of receiving nothing from linux-nvme, so I wasn't =
sure
if my original mail went anywhere.  But I found it on the archive.

>
> > > > @@ -2027,6 +2027,12 @@ static int nvme_update_ns_info_block(struct =
nvme_ns *ns,
> > > >         if (ret)
> > > >                 return ret;
> > > >
> > > > +       if (id->ncap =3D=3D 0) {
> > > > +               /* namespace not allocated or attached */
> > > > +               info->is_removed =3D true;
> > > > +               return -ENODEV;
>
> The concept sounds good, though you are leaking 'id' in the new error cas=
e.
>

I will send a v2 to correct this, Maurizio has fixed the other caller.

-Ewan


