Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C46C83F16
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 13:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pZvP4akX1FNW4jsFlwLLkJZAHk1+SP6pnWAd6+58RhM=; b=YsK2T1+E+lTrPotY6wmlLC4Y+7
	iog5acru4ke99uk/3tRv9utH3myxCgZDoP95l3xfcyvCYxHsml3V5L7vdPG8Lsjn+iYm3+aJ0SMVf
	c9NwkEnGZhSKwFCD+l21TI+ys2O+2DVeToJutzJ4+GJ3nHVvMEenMOfrDw5Hlnr0SfbaJcDK8jzNW
	iSK23gPMas8jbIr6bgtPVAchNWb0s7uWEerX9aXndE9l+q/OcghI0gZus+r3GZVFVez1YBqMrj6kf
	x1Jk89pRCG98+OkYY3mpmAI+8qdWY04jbOlu6y3QDSSD3GY1B2VPoxWeXLTOOredRj8/KCgZQyF6s
	PkFfrXSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjfDp-00000002BNv-0C7F;
	Thu, 29 Aug 2024 13:29:57 +0000
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjfDe-00000002BKB-2RR7
	for linux-nvme@lists.infradead.org;
	Thu, 29 Aug 2024 13:29:47 +0000
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-2701c010388so243751fac.0
        for <linux-nvme@lists.infradead.org>; Thu, 29 Aug 2024 06:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724938184; x=1725542984; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZvP4akX1FNW4jsFlwLLkJZAHk1+SP6pnWAd6+58RhM=;
        b=EdtKGlCMvSdOvGXgCl8AASbUVEIkiuiV1pXZXtKu0/1Qk5/TCQivQcpd3Xz3pfm1Yb
         CoLeoKUv1bYQHALDJQi2WHkGJow0QUiRbdPGcpEyAzzkxNFszV8me5J19yrSLpWWvvGi
         DYt1P3FdJnqWbRZoYaYGWp9G2QIy1UoWsReiTjIFVsow1ndlLa4/ywYwRKXDilvwvwhF
         3Akuh4SfmQLaiEOylRlvpDyaIUdaKaiT0O/0Q5lj7wqA/egHu3ds5y9XZVc2HoStc5F5
         mea+ACxN+z8FfJKAEvSwAFG79gX95sCdsilHv2SJr6G3xrdulcRvq96qmqQX4hyPmLOG
         Gd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724938184; x=1725542984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZvP4akX1FNW4jsFlwLLkJZAHk1+SP6pnWAd6+58RhM=;
        b=ZQfUT5mDs6hEq1UqPZM4Xb9DDiRFa5YaPsbGZ3tkOaqn+wqPDB09tWFj/MMb/SMWJe
         oom2PPbSsQIhoO/xmvLHtL1P7yBJz3C4unVS2Nj1nzbjSKnYWqHWTjsnkZoxRORBC7vj
         njDLB2QUH+S61CqdumIIlb88tICEP8V9aRLnrcN7ycnJrR44b5k7lXtV+OpJBLnKaj1c
         X6FxbgzpGtlDnRpN5CA49SVEuGvLOkTedBv4KOtkMHtLOFplnnkaIdZJv9AgZ0rGhNDx
         anX3CyQDSeLK2IJkEfEG1DUyuGim0WT3OBdXgXii43JuquS0uOU8hLQ75iAaFQWnXa12
         xW4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmnIccwWt6LUGoWF5mBLW7Sh17u8uDtobnqfmq2sFUnn1rvSvsL3nq56Zc6yi7W3c+lo5pmhjO6yx9@lists.infradead.org
X-Gm-Message-State: AOJu0YxEYVwVPFeMv2m2qDEWC1P5d0G02WY0hsm2aEhICXgXejGfPoeo
	ceoEVmMSd9hFwNVvoXebjpcor5uHeuwGIewFehU/A6Let2hEwtqBcvxoKUrSaORBKKvRlGQPi2R
	vCmziilskSAlDRT5x9j5DVBk/DnS+MoW0Qw==
X-Google-Smtp-Source: AGHT+IEB9AghDWmQTaWbGpeIraxIQPqERplZzNtYk9DNetcO5Rt7NpJPuYrDDGDj8FK1DdGZ/2QbinPEhl0Lrhh+j2M=
X-Received: by 2002:a05:6870:f153:b0:229:f022:ef83 with SMTP id
 586e51a60fabf-2779035fabdmr3133038fac.43.1724938184280; Thu, 29 Aug 2024
 06:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240823103811.2421-1-anuj20.g@samsung.com> <CGME20240823104629epcas5p3fea0cb7e66b0446ddacf7648c08c3ba8@epcas5p3.samsung.com>
 <20240823103811.2421-8-anuj20.g@samsung.com> <20240824083553.GF8805@lst.de>
 <fe85a641-c974-3fa7-43f1-eacbb7834210@samsung.com> <yq1plpsauu5.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1plpsauu5.fsf@ca-mkp.ca.oracle.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 29 Aug 2024 18:59:05 +0530
Message-ID: <CACzX3AuX9FkxPoBRLmy_HEmu6Ex63jHLyz9Z8fhUd_Y5_MdJyw@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] block: introduce BIP_CHECK_GUARD/REFTAG/APPTAG bip_flags
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>, 
	axboe@kernel.dk, kbusch@kernel.org, asml.silence@gmail.com, krisman@suse.de, 
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, gost.dev@samsung.com, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_062946_657431_1317109D 
X-CRM114-Status: GOOD (  14.89  )
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

On Thu, Aug 29, 2024 at 8:47=E2=80=AFAM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Kanchan,
>
> > With Guard/Reftag/Apptag, we get 6 combinations. For NVMe, all can be
> > valid. For SCSI, maximum 4 can be valid. And we factor the pi-type in
> > while listing what all is valid. For example: 010 or 001 is not valid
> > for SCSI and should not be shown by this.
>
> I thought we had tentatively agreed to let the block layer integrity
> flags only describe what the controller should do? And then let sd.c
> decide what to do about RDPROTECT/WRPROTECT (since host-to-target is a
> different protection envelope anyway). That is kind of how it works
> already.
>
Do you see that this patch (and this set of flags) are fine?
If not, which specific flags do you suggest should be introduced?

