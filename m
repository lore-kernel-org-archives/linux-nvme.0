Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAD8E668AA
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Dec 2025 01:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PxDQMU940PzQqDDxqT3aeMe/40w/afBLMuPirlH6FY0=; b=H2yBMV0G+cdPn55zg0xX0/qwRU
	JmvG0tInw526rfybAP0hNh6bbEHTskVaUpvP4YgcS406A8xqhwdHkt25s+vN7k1tHDB29tjgU5mD+
	aLLdZOchmrxFRSvuIS2rytIW7X256EEZBA5lwg9a3xWMELXn2Mvi6p+ivQFLAUt74m80ctqIqfzbw
	DI7a2kS127oM9NM6vwY6PK3hJfAwJLmhCriuhqmzdxAfKfh8yWDzVGJ++ude4qbL3ZcSO7ZmwuwGV
	EicAux7B/CJIl01qMUdlpFl1bMHBcm4bEmDjgQ0xwITGAA8Gtryrk9yOzVLm6HXzHSHjfaphUooDh
	94QVO46w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWm1o-0000000BBW9-0uO4;
	Sat, 20 Dec 2025 01:45:04 +0000
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWm1m-0000000BBVm-1VCQ
	for linux-nvme@lists.infradead.org;
	Sat, 20 Dec 2025 01:45:03 +0000
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-93f5dd1046fso1374819241.2
        for <linux-nvme@lists.infradead.org>; Fri, 19 Dec 2025 17:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766195101; x=1766799901; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxDQMU940PzQqDDxqT3aeMe/40w/afBLMuPirlH6FY0=;
        b=fru59GYubd+vhzqbj2i8K2TKaFOLNf1gx83IEITma2m5PXmlqrMuUkufwm/3er+NSv
         WEkG/qUJLlysYqrXgbtqSOJVdAtEYcVmd5Azc1F/trNZs95RnkSUAnS8hu0+uyl3+qsN
         I19ZBqhs6JVVMyjYJ/nZ88ybKAwADTUxvnWBNW0QiYxguqIC4ivBiUXzETrHbiFAU5cT
         KhX63nsDoNGumc20jMxNz0EEtYRAZeNOLa0OmFH9aPtqtBG0MvvDbJ5KSLoxdyjq067d
         Lh2uThrnSocknEtDCs6FUAnusub/Pf/aSOfFYQiNPuL13UFOKcO97drn91HMBSKw1dgD
         77Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766195101; x=1766799901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PxDQMU940PzQqDDxqT3aeMe/40w/afBLMuPirlH6FY0=;
        b=uq3fPJksPEjinsvATJBblEwJ4gq4wVgRd5+pyc2LZc5CahDBqdFjdHNkyi+EOnAOfX
         GQtcka+SaouPIb9hPSt0YMqMh93x1JaAFaWGPgWK6y8lM4+I/zjXOD2ObKw+cu/u3OkY
         D2ZR5plVM+yf3inuSIAgk/uIJguLLb23Giljq4vpptmS7BaonPcTdSpa5Nzokj7EICwO
         nGrhKEPhypFohp2A8O403Vs2+315JIg1vptTZp2kkXkgwsH42PtWj/Wn5VZEDGeQa6pL
         6jKRhLTggHNce+OR2z1HJ+FealrhRE80SwdaPFj3hyeQYox9SgggLjea1immIMUpp2Iw
         mqtA==
X-Forwarded-Encrypted: i=1; AJvYcCWxBK1PdixK4HiHQKLKZffiLu49OrX8JnThbX6aYCW1lSWGvyuus5brkNjzcf4b3xt8YHRf5S2CBncp@lists.infradead.org
X-Gm-Message-State: AOJu0Yx5RBlPfhd072zXhAknnRjX3kQZLAWgz3ApUFQqYvAztGPXKqR1
	eAfVJgs6eFonxtyJ+GR6J3aPiIOU91knUxXwmq0RDs34grMIfymNkjD/tIRtb+ReYIax1ZDSBWc
	5w4JEtmZFlhwopwD5ri5d9OqF1AXDHL9TNQdZ6fSV63pNZNFEU5zlFZgIjw==
X-Gm-Gg: AY/fxX4bPg6hWaplQhILYMPzCf/nu4h4I3uhJe80b7dSKbekAAtSLCenT3d7zJU3d4f
	79rVrhuGW6ikkPxrrH+FVlr8aS6mv+Yq3NSmA0oipxnzUW/G6YH7kY4F5pZauXDv2yhkD1SO6O3
	9E+9QeNHjX5v06EwHY0V9ALMtYGswCZPYm9piN26Yuv90VtP9khzUJy4SIBHYIxFsZSTx/NAbAe
	7tR5B5S6kZ2Li2Lq9/owLELArHiXUT3uo9vi3eNFM5xdp5dHUUJLRu8dIuHGUDjnrsElpQfSeMh
	7inlQA==
X-Google-Smtp-Source: AGHT+IHEAYB/LYWMmzIP/QvubEBsJfZ3qdiT2xPlWZPYw7bJK9Qb98cQtDKBBow9/HDxL1KBX1q7K0zKOi6Bqx0kbx4=
X-Received: by 2002:a05:6102:3f42:b0:5db:f34e:5fa1 with SMTP id
 ada2fe7eead31-5eb1a8275bfmr1915089137.33.1766195100749; Fri, 19 Dec 2025
 17:45:00 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com> <20251126021250.2583630-15-mkhalfella@purestorage.com>
In-Reply-To: <20251126021250.2583630-15-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Fri, 19 Dec 2025 17:44:50 -0800
X-Gm-Features: AQt7F2rO_TGJdC-3Uvgb14nGoy_uIQR3AAWWkZse3ud2kDa7_XB1ewPP5zH5YiE
Message-ID: <CAPpK+O14EoCUJjShTEDV+rTLfLC1GBWm+sv2C1quPdK8fJnEbw@mail.gmail.com>
Subject: Re: [RFC PATCH 14/14] nvme-fc: Hold inflight requests while in
 RECOVERING state
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_174502_406892_8851913F 
X-CRM114-Status: GOOD (  14.64  )
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

On Tue, Nov 25, 2025 at 6:13=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:

> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c

> @@ -2083,17 +2092,34 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)

> +       /*
> +        * We can not access op after the request is completed because it=
 can
> +        * be reused immediately. At the same time we want to wakeup the =
thread
> +        * waiting for ongoing IOs _after_ requests are completed. This i=
s
> +        * necessary because that thread will start canceling inflight IO=
s
> +        * and we want to avoid request completion racing with cancellati=
on.
> +        */
> +       op_term =3D __nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
> +
> +       /* Error recovery completes inflight reqeusts when it is safe */
"reqeusts" -> "requests"

> +       if (nvme_ctrl_state(&ctrl->ctrl) =3D=3D NVME_CTRL_RECOVERING)
> +               goto check_op_term;
> +
>         if (!nvme_try_complete_req(rq, status, result))
>                 nvme_fc_complete_rq(rq);
>
> +check_op_term:
> +       if (op_term)
> +               __nvme_fc_fcpop_count_one_down(ctrl);

I think it is easier to grok:
+       op_term =3D __nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
+
+       /* Error recovery completes inflight reqeusts when it is safe */
+       if (nvme_ctrl_state(&ctrl->ctrl) !=3D NVME_CTRL_RECOVERING &&
+           !nvme_try_complete_req(rq, status, result))
                nvme_fc_complete_rq(rq);
+
+       if (op_term)
+               __nvme_fc_fcpop_count_one_down(ctrl);

Reviewed-by: Randy Jennings <randyj@purestorage.com>

