Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DBED116EA
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Nov 2025 01:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fs0ohHvC2dybiBLIXiSQxGJyUXrOOQGSRM7UOWCS5dA=; b=DLH0YFt8hA7oY0UbOLkiH7UDqY
	KIfgFaF/e+XhyqydFKbl8IqL4PhQl26izWL2tDYlXy6jffry8fnzrWhgyHd57chAfPWuwl/Isw1wl
	jD9pEPOTEaTy8cnNKiFVHlyePpJZLljr/L20co95/J6V71XOtwUpecwV/LS1lkraEA4rTGwxi2sid
	xfJ7n4CzctHESq1ml00fP/Gzownizbc5RSR2lQTMXxqAGw/m/KkYRcybgCnvx6lN9MtNiSETNUIQy
	O1KUk9qnmvDxhNp8mnh1qghRKc4e4OR2DHcMniqK1pAVd7W6viEimMhd2lMuSAMuiSlhs63103vxq
	7yzm1uNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vP9dA-000000017k2-2Hwd;
	Sat, 29 Nov 2025 01:20:08 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vP9d7-000000017jf-41xz
	for linux-nvme@lists.infradead.org;
	Sat, 29 Nov 2025 01:20:07 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4edf1be4434so16496961cf.1
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 17:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764379204; x=1764984004; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fs0ohHvC2dybiBLIXiSQxGJyUXrOOQGSRM7UOWCS5dA=;
        b=Cmd3WKi1Tm8+jioZB82lpEN77Se9chzaMg7HMHrtBZk8KnGdJVk4cKpunjiVjsWwCO
         74pttQAM6ZLtungYfGcoubBnyErGQc+Fx3jCjTSq7KT6mvUOxz86CgCXp86qgFrJZIdz
         Vyasp+GB6lTaAARpTYGjrpR6bmrTQrKQGcaHGADSkFd9HwbKZu0NPGRQphPCgn6EuIKJ
         f2sL4koCZSdAWczqsUij+wKAeegK3Fjqh8GMvvswB2AHHCrAJ1jH4Px4W+PBOvABIEtY
         jLCevGUmcsW22NrnKGadjfw5UrNrT57QSR8bwbDvjv/oqfOaYmlQf15Dn0AfmyGF1LmH
         taMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764379204; x=1764984004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fs0ohHvC2dybiBLIXiSQxGJyUXrOOQGSRM7UOWCS5dA=;
        b=aM4qg10mF6LXqxANi2NF3/84JJ0j9W6JxoSB7vyPGVJ91bxAI9LSj+VBqvwpPsw8c6
         7EDC7u6rRJ8Dn4TE2KWwXF0+cBNc1vsfyGEVwUAWaBSUKxPnui6uKwOVAUAFuYzquBeX
         Tawc/B2xRrqGKgNrKvOQPsfWM6UVw1NPAb3oSXoc5oK83gp0Wj10zKDfPFNdlaKcse4c
         GrLL3Oem3gxUMri6ODgSiTXEGLahkSIQQu0fUD1XVgKIeKd56L6uGxiU5N5i+EliOy0y
         H12KNwmXvk45bGAhO6F3o47EQH5WSEBoVMlPIkgm/bx/LgqxrclVU6k0F9601d/lEQmo
         imKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCQBYtuOoekPwZpy2Ml0kbZCKPwM6nWTu6QAjrqURPNTwibWKobIqLrV3wXM2RnROyz1jVeKCzZagX@lists.infradead.org
X-Gm-Message-State: AOJu0YzOdMoLsYao4bhyb0gJ9XG5dKI1Wp7xHpD7guLBuOPB3yLXmAg0
	bQkfGUJfl0JsmcpmFEJAjk2HvErwRd3vw41LoZfb3o70Q/gXSMTEWRHobuspR2dSAf8R9FEfoGi
	n6EI1WlhOdC/Eo0tMj+U127akx+bNXBU=
X-Gm-Gg: ASbGncsB9IGyERnqdVlT0smmFJfSdHh46Gz/p172mDsJmpR7XF/Uu0NORH/V1GBFXBw
	ZZtyCYiYOuXjpa+NZd7+r8ldafTVEEdllaMTQYR7noizZitDAnz53+LrW3Ix0d+OvglExW3OdT9
	mlu/zR9bafP7oJ3YWbO1eN5q4wLXTMZCqGOnmJNEWsrtGHt+J6ZvEpjAKLSWEKDhB3xnjk4OEl1
	+OMQDWfZ43u0W8kbsdBnxlAGK2JkTPUN4zOGoWI4gnlTVmOxdqU6+7tQGLKofKRs0W8yA==
X-Google-Smtp-Source: AGHT+IGvVajIc41VyAxCuPyxqWUXb2OrVTIXZXouCyBBkNWEtauVL8pGUlccoVwLRAWDPyhKgINw+5nh517v8WUU60c=
X-Received: by 2002:ac8:7c43:0:b0:4ed:b1fe:f87f with SMTP id
 d75a77b69052e-4efbda3957amr254551091cf.20.1764379203672; Fri, 28 Nov 2025
 17:20:03 -0800 (PST)
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-13-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-13-zhangshida@kylinos.cn>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 29 Nov 2025 09:19:27 +0800
X-Gm-Features: AWmQ_bn06KtcfeC8pChk4HEBjz19bArSXx8IRJxxttyX3p2OYoBSLr0JgGawFZU
Message-ID: <CANubcdXJyE6Y5J3C5Zgc1jA7qSXk+_Hb0pm8Q-8cTb3Z_eM4sA@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] nvmet: use bio_chain_and_submit to simplify bio chaining
To: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_172006_005365_99B20B2C 
X-CRM114-Status: GOOD (  12.92  )
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

zhangshida <starzhangzsd@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=94 16:33=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Replace repetitive bio chaining patterns with bio_chain_and_submit.
> Note that while the parameter order (prev vs new) differs from the
> original code, the chaining order does not affect bio chain
> functionality.
>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  drivers/nvme/target/io-cmd-bdev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c
> index 8d246b8ca60..4af45659bd2 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -312,8 +312,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *r=
eq)
>                                         opf, GFP_KERNEL);
>                         bio->bi_iter.bi_sector =3D sector;
>
> -                       bio_chain(bio, prev);
> -                       submit_bio(prev);
> +                       bio_chain_and_submit(prev, bio);
>                 }
>

My apologies.  I think the order really matters here, will drop this patch.

Thanks,
shida

>                 sector +=3D sg->length >> 9;
> --
> 2.34.1
>

