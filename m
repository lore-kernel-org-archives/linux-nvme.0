Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84A2CDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 16:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ptrYh5r2a8lglUPhshOPUSg1YRXJbBxqB9uq9uZWH84=; b=bxiv8TG8KRc/+nRc87doSj6J5O
	gp3yywi7svJtUY4Pjg8PD6J8FqtAyFYqcNMmSr4zjo3qGN9lp8pPpXd6zfwyiF5i/3lwTWEAiQTjk
	oBwZXXagSz4LG3jbwKFNwlYfvSiwtPX4Y6meeplJ6ApP+K0OnxV65UbbTyEHYfY0CvsVyKfNO9Z4a
	Nsj2SKlLIjpaZ5Y1lX5xhFnXalSfo0ZP/fgBsdS71xt0bepcnziUlY/UXw8CNS9liDU3SqxS3/G2R
	5S2VKZ35EBgTv0MUSdp5WsRz1BayNyrT8h5b+uf5hmldNWWnZnAqtxS0Crp/WvhutqMdkw3P7Zxnj
	SkEjQmnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qt9kp-00FEGL-0y;
	Wed, 18 Oct 2023 16:50:43 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qt9km-00FEFy-2W
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 16:50:41 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32d9b507b00so4781750f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697647838; x=1698252638; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptrYh5r2a8lglUPhshOPUSg1YRXJbBxqB9uq9uZWH84=;
        b=cD/l7tW1yplcvwWP2tdIdgDgxSsGsdl4/K01XuYFVoVrEM6fyxdgpl5dH/n8c2tovS
         hOg2yglgrEuVgbL6W89svl2/79Dyk/tmzStRZjPlYZ/cxIZBBgO6Lvvv+oxN/8d1Bfjk
         47q9N8fW2kYur50J/m7WFf4s0GFZU8u/nkr901NQQ0KM/hV/6aHa92urZldNg9CYh0oZ
         IS27OKpVfAqVybnWsGQVYEC3tF8ioEONMF53sP/sdbB605clRLMb3ymZsa60zP3wJ+AD
         847TkTOncyjdw1K5NaRikaD08IrWvQHQHntGeXmCp3EaEvAL32WFw+/RcOMCHMn6BTE7
         9rRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697647838; x=1698252638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptrYh5r2a8lglUPhshOPUSg1YRXJbBxqB9uq9uZWH84=;
        b=mbfrW17jWtdUig0DHGbA16sHUwwp8i9kdxJtu5jkRiiDkdOLdn58+1V9j1rhyxGTIq
         bOjoCGP6tidnwfrdy7/PO+4DB5601+231Y5jYRDm8mzvM/JWxz4ydLEa+OBLskrgxKRL
         AmUr8uQ3+Fehew676m4usgt60TjUR1bt8H6WMYeO+YaizHovqCnXq/t8yzqMvH5Hi7Ut
         hLfKtERHRA0JuOzFfrUhS4g7Arh+kVOcqaia9c3FvyPvuKKR7HbcXq6D8LsMLBtSIuqV
         fKUgpD9P+bZb6NbkJ6+qU3q8DS7vewJANFNgO3dAc26dw7JrXLHAnGlqfyUkf/C4GT0L
         okWw==
X-Gm-Message-State: AOJu0Yzq7XZUgvAGMhf2akCA75TAUBUMrcVETR5+rtzCekBbFxd1+Qff
	kpKb33FkCZ/j1bDMu4Vgo3TK3EVfQ6FKYn9NK0k=
X-Google-Smtp-Source: AGHT+IEcAK5lO73RFzZttR+J82lAn35MsTda2kYMI6qmsWtTMh5iKi+Sk+5s6zpHMJY+G9THENq5rtDkRwSkUvM79mY=
X-Received: by 2002:adf:f84c:0:b0:314:15b7:20a5 with SMTP id
 d12-20020adff84c000000b0031415b720a5mr4973078wrq.54.1697647837833; Wed, 18
 Oct 2023 09:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231018140334epcas5p128c55c56fb9203a19479cbf86175a1d6@epcas5p1.samsung.com>
 <20231018135718.28820-1-joshi.k@samsung.com> <20231018155020.GA26481@lst.de>
In-Reply-To: <20231018155020.GA26481@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 18 Oct 2023 22:20:10 +0530
Message-ID: <CA+1E3rLS0y9nZ0Kg1OKf6SX-nLpSps8S9ZHSRSFbPV6STM841g@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix error-handling for io_uring nvme-passthrough
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, axboe@kernel.dk, 
	sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_095040_843890_377B6D7B 
X-CRM114-Status: GOOD (  11.99  )
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

On Wed, Oct 18, 2023 at 9:20=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Oct 18, 2023 at 07:27:18PM +0530, Kanchan Joshi wrote:
> > @@ -508,8 +508,11 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(st=
ruct request *req,
> >       req->bio =3D pdu->bio;
> >       if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
> >               pdu->nvme_status =3D -EINTR;
> > -     else
> > +     else {
> >               pdu->nvme_status =3D nvme_req(req)->status;
> > +             if (!pdu->nvme_status)
> > +                     pdu->nvme_status =3D blk_status_to_errno(err);
> > +     }
>
> Hmm, shoudn't err take precedence over the nvme status?

Since this is for passthrough interface, nvme status should get the
precedence since that is what we want the users to see.
Same happens for sync passthrough too (in nvme_execute_rq).

