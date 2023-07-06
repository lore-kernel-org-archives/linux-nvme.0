Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A7DEB64D9
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jul 2023 19:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FFptGxWZhjj+ECCgeIrQpbXsXMNJ1NTHKYQf18zg0II=; b=spKaUBY8xpq7qA5Wf1v5NXLay+
	yI7SMJwlHZLn70v3UfLav1VrZg5XmbTjQip2+AL1L5b6+PhquxV08gSNmGKHVY7DYdyR81OmAv9Oe
	fqo85AytQSCE8UTkipYjvSmA5U2uKY/f3iI/UI4q50LYyazKeBEgurMygzUQCpGB+KjoIf/J/zYWK
	35/VTkH89mgxEcpNT85Gc1RqV9aUd0K20ndIgzcAFL4rnuk2CP79Z9PrdvYndsnLI1Veqt8MkWiJq
	gtcc0cEWah2Q8kw6t5eA1A1vMGFoE95gy418gb6O+0vn6bx7aJhYwiop7IDXBv4EL/AopfRqDZgzW
	yvSFHVpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHUHo-002TCB-2J;
	Thu, 06 Jul 2023 19:05:04 +0000
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHUHl-002TBL-1J
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jul 2023 19:05:02 +0000
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-56598263d1dso730200eaf.0
        for <linux-nvme@lists.infradead.org>; Thu, 06 Jul 2023 12:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688670299; x=1691262299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFptGxWZhjj+ECCgeIrQpbXsXMNJ1NTHKYQf18zg0II=;
        b=HFsMdtBRM0KtnicjHuErgqcKaWHNT+wf76Kw7qlGpFF+6j9K2wkG3XrGhYG5QRmDuy
         qPx0xQatoknegTs/pmNm06CqVMEY7Bg55ZSvB8sEni2s1EPzPdWrMXytk4IdYw/I0V56
         zGMqF00vtPv09zydW0aRQFSStblkBBWVBoWOgqH+MIW9Ht5FExLymmp4uw2khdx7Z5S8
         ownTxsROTiFpqQqVEFzz1YZWty+L4fXQEvf93lUbO7QAGXYwuMwHYTMSaA89mhP42jUa
         psfbeOosqRmcjYktTaDMxOOGt/7W9sqg1oCa1rWKh5cz0uPOxSFh7Noxtv9usI1H17Ek
         QYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688670299; x=1691262299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFptGxWZhjj+ECCgeIrQpbXsXMNJ1NTHKYQf18zg0II=;
        b=KovbyCHxZz+AEuebqsNJnQBwm6cOfqUIAQ+m1cyh7a9x34tXloWo8bFgIqZPIneYS/
         TPEAic+WbZG+7UJoVJRe5T0NaxQMQVKHQEMvpIztGX/fr7WrZKjG/qnHieBEvCNPGDKI
         Ci2fiD7Xauvs/NMG3XLXk7RpivFQAdVYI+EYNfbltdOAp0H6ojFLUb6R8VLcIdZJrtlB
         DMZnqFZbFw9mb9WhKTmDm9KEUMC4ICfa6HmOLEwCbc+iAmABXGyW676gOLFHUiNYRd/c
         sGp/mnU16caZqy60cTTjRHRX39ZE8KxaRSJd/ekVdhkL5kZFO2JhcRcPpDTIDOtCQngU
         pXpA==
X-Gm-Message-State: ABy/qLY7skQc56imkWartbatbKxkbltyL2AbTkYDl8cnyQJ12DjdFMnj
	CXP044A+InURlert+ngVvBf/p/7ETC/e42H/RWA=
X-Google-Smtp-Source: APBJJlGTtNXHOnWimnXxyrrp6a69dQVzlhmMLx/lXaGvSMC9Gia7/JYaI/7UwKEXn82PnrBG2ANoJmJd85MUJWJ4/so=
X-Received: by 2002:a4a:2c57:0:b0:547:5593:d6 with SMTP id o84-20020a4a2c57000000b00547559300d6mr2065659ooo.5.1688670299582;
 Thu, 06 Jul 2023 12:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230704073658eucas1p1f977a725486b9cc7e0bfe70b29286280@eucas1p1.samsung.com>
 <20230704073656.378760-1-p.raghav@samsung.com>
In-Reply-To: <20230704073656.378760-1-p.raghav@samsung.com>
From: Clemens Springsguth <cspringsguth@gmail.com>
Date: Thu, 6 Jul 2023 21:04:23 +0200
Message-ID: <CABfnBFqZkHXObCwhgf_SQy5221AGqivs-GDRZ+dnKZLs-omdmw@mail.gmail.com>
Subject: Re: [PATCH] nvme: add BOGUS_NID quirk for Samsung SM953
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: kbusch@kernel.org, jh.i.park@samsung.com, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, javier.gonz@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230706_120501_469044_E26AA348 
X-CRM114-Status: GOOD (  17.32  )
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

Hi Pankaj,
hi Keith,

thanks for making and submitting this patch. Tested this succesfully
on one of my hosts.

kind regards
Clemens

On Tue, Jul 4, 2023 at 9:36=E2=80=AFAM Pankaj Raghav <p.raghav@samsung.com>=
 wrote:
>
> Add the quirk as SM953 is reporting bogus namespace ID.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217593
> Reported-by: Clemens Springsguth <cspringsguth@gmail.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> Hi Keith,
>   I haven't tested this patch on a real device. Could you wait for
>   Clemens to test this patch before applying?
>
>  drivers/nvme/host/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 72725729cb6c..8754b4a5c684 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3396,6 +3396,8 @@ static const struct pci_device_id nvme_id_table[] =
=3D {
>                 .driver_data =3D NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>         { PCI_DEVICE(0x144d, 0xa809),   /* Samsung MZALQ256HBJD 256G */
>                 .driver_data =3D NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> +       { PCI_DEVICE(0x144d, 0xa802),   /* Samsung SM953 */
> +               .driver_data =3D NVME_QUIRK_BOGUS_NID, },
>         { PCI_DEVICE(0x1cc4, 0x6303),   /* UMIS RPJTJ512MGE1QDY 512G */
>                 .driver_data =3D NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>         { PCI_DEVICE(0x1cc4, 0x6302),   /* UMIS RPJTJ256MGE1QDY 256G */
> --
> 2.40.1
>

