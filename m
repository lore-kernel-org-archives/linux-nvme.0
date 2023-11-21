Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFC7C61D85
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Nov 2023 16:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y7pnqI74NKLkaXfyd8GQP0kyMyA4yNmTqJMM3pVvHaM=; b=h8cAWSQ21ZMDcmAeP4O6Bd7RbM
	L4LkXmIaDnN0wOSh2VgV0RC9/fV3I6n5K6hnWTAvuw3iVKOoXURe7njn7SPrnF+TSBSpdgHtyeY+i
	8U1JXZDexH1eMtS0IBb8ZlYbAkY3uP+j+1C9WJSU6zsTwyxQkqAtjflcg5n4Xq0Do2+SwGCvyvAFg
	tirJJRmysecrp1DazvT+kfvV/6lNoZ1ilt7mSGabaEQ/LvmUm4Y1MWyQTQ7Xqoko/ar/wVJTz99QJ
	Wdr/0oOXjm/wmYF1otIZbEBC+xJZBqLLeARQwv7QRXl6jZz76Kf1S2IIO8AoATJTnp7w4VSNCVe5/
	mk3NoD2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5TL7-00HFTw-1D;
	Tue, 21 Nov 2023 16:11:05 +0000
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5TL4-00HFTD-2J
	for linux-nvme@lists.infradead.org;
	Tue, 21 Nov 2023 16:11:03 +0000
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b6cb515917so3835337b6e.1
        for <linux-nvme@lists.infradead.org>; Tue, 21 Nov 2023 08:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700583057; x=1701187857; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7pnqI74NKLkaXfyd8GQP0kyMyA4yNmTqJMM3pVvHaM=;
        b=VaYfOErc8vmm/67OcCpKMqea0ypOSCNPT9zQBde04vgvA2wMZ60EVB5MdoLrslMzTu
         H2hei5aQciaC0LWFdgdc9VN6mIg2phwLy6ehySxiTGS/eis9CK+xiL4j1MpOgynTTP6k
         sdT2mh+E0b1xkhsAq51Lk9zFkkY1bLY/ciXsJS65rIEVn4P881Hep48vXdLmusAt5U8u
         389uCO+LmcNyYnwZFUlTCGhMWSOnBMdFyzQwaEqySJmi461HwoVTdASG5DkWdi64RZha
         hN5rpQPg3GT+GB8gDTPNAcBgy/lHuT37R3XtPsHjRnGTT0zdNkJuUlFcNcUVzd9O2k9E
         DhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700583057; x=1701187857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7pnqI74NKLkaXfyd8GQP0kyMyA4yNmTqJMM3pVvHaM=;
        b=S9obpglLiLkEU39LhQskDGKfycIupJoaxoCHQPwI8Nm1rKbSGLeu1DNzWSpN8fg6PW
         MuuxrtG80JAQNUrjbFDH8foflfixIWbz8OafXeZlO9IeVGhD4JF8+53vytucyJPCx9XE
         /Kyrj6tKuMJj+VFA0Xq1Wa6d1UbPKmryur4l3HQBVAIRW/AUb3pFyiTKyFbq/i8U8jKQ
         dQG3htDC+mG8eBh4RoNL0E+gml6qVAur3qgEtcxG2wghR97tdSrd1aZ/XKtykR9+me/b
         PSfsdLmjtUEzERZhVmCPT5RBmeMV7kP15EPvahtfY1ttt/RYx5yHcfbhOKNhy5Gxo4dd
         rkxw==
X-Gm-Message-State: AOJu0YyIlXxI2epDDuGzGKIrdOyd+KDn40jlz6qOCOjEmhuFRx1yS8w5
	13arYRU0uSHmstGcCCqglHWDEYoi9BoJou9pxw==
X-Google-Smtp-Source: AGHT+IFiRaCf/Q+x81UKnU4Wpey3wIOZJlFvG9RRGz5EHrrlf7aahHCnKG4nyEynHxf6qjGLknAONjzHifddupR97R0=
X-Received: by 2002:a05:6359:d23:b0:16b:b8b1:f684 with SMTP id
 gp35-20020a0563590d2300b0016bb8b1f684mr9672260rwb.22.1700583056876; Tue, 21
 Nov 2023 08:10:56 -0800 (PST)
MIME-Version: 1.0
References: <20231120224058.2750705-1-kbusch@meta.com> <20231120224058.2750705-3-kbusch@meta.com>
In-Reply-To: <20231120224058.2750705-3-kbusch@meta.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 21 Nov 2023 21:40:20 +0530
Message-ID: <CACzX3AvO2GSvwagd=PkxsG3uiKgT4vpiMzYA1RJOjEMQD=yN6A@mail.gmail.com>
Subject: Re: [PATCHv3 2/5] block: bio-integrity: directly map user buffers
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	io-uring@vger.kernel.org, axboe@kernel.dk, hch@lst.de, joshi.k@samsung.com, 
	martin.petersen@oracle.com, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_081102_779244_F2C4A748 
X-CRM114-Status: GOOD (  10.21  )
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

On Tue, Nov 21, 2023 at 4:11=E2=80=AFAM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> Passthrough commands that utilize metadata currently bounce the user
> space buffer through the kernel. Add support for mapping user space
> directly so that we can avoid this costly overhead. This is similiar to

Nit: s/similiar/similar

 >  /**
>   * bio_integrity_free - Free bio integrity payload
>   * @bio:       bio containing bip to be freed
> @@ -105,6 +136,8 @@ void bio_integrity_free(struct bio *bio)
>
>         if (bip->bip_flags & BIP_BLOCK_INTEGRITY)
>                 kfree(bvec_virt(bip->bip_vec));
> +       else if (bip->bip_flags & BIP_INTEGRITY_USER)
> +               bio_integrity_unmap_user(bip);;

Nit: extra semicolon here

--
Anuj Gupta

