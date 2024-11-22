Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07828E65D10
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 02:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1iDNOTxS/zhKcM+lAwLGWpOioXGlApMkU9kCfRd9Vxs=; b=EI9xSsssdJy5WvCUDGnHKo4ICN
	7kOMASytAglOnzXdkDtOV1sGpJZlR1E4kCiwTqkod8uesGjc9TRDfUpXch39R+4+pAyrJWWmT/3K/
	eSGFCyCr/bO5l1B3Tj7uO6PubHAs1YYnw7A6BooN6S6p32dF7fT/tP5v7HxBWYTF36BWHrFTXpVQS
	sInEk1L6F+3kB5ZCYAVfi91P2kUaI7ONXDDvQyT8pgGNdXIyF5bbdrZWVnPmIovuuon5Zu13nnCQA
	xIoPtWIRg+36+s1Mb/WjqW/5baxaxCw93teegAKq0F8mo47jJzE4eQlSX1AmgH79QeTaXXzQ6lM4J
	68DiigfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEJFb-00000001S59-3hTe;
	Fri, 22 Nov 2024 02:18:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEJFZ-00000001S4A-02tn
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 02:18:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732241903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1iDNOTxS/zhKcM+lAwLGWpOioXGlApMkU9kCfRd9Vxs=;
	b=LPiPmfEAG+/AgGOTG8+GpZpNeT61hOPVJd0IgoambfBCVTXyqUAa8MChIv7hwR4geZJ/NC
	O4uLuUt4XA66q6GLba40pU4exNpwW57Y4V+JuDJCb7d/VahgHwHJf17Yl4olT1r95Un5BY
	dIlMIZQujYF6hxOBELY4XgXt1a1LgYw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-MZQ0-WQyO_ehMY0fxDk1UQ-1; Thu, 21 Nov 2024 21:18:22 -0500
X-MC-Unique: MZQ0-WQyO_ehMY0fxDk1UQ-1
X-Mimecast-MFC-AGG-ID: MZQ0-WQyO_ehMY0fxDk1UQ
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2fb50351d18so11611561fa.3
        for <linux-nvme@lists.infradead.org>; Thu, 21 Nov 2024 18:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732241900; x=1732846700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iDNOTxS/zhKcM+lAwLGWpOioXGlApMkU9kCfRd9Vxs=;
        b=EhrKq8oU4xAd/+awkOHAeyjwspctVE4wfZm+8h2BpRP1kjvgU+pHt8ahsbtmRShbCL
         2oGav2Kc7GAI7CROvK7jmj2gaztFqFHW+aDs/6711EWQxTFJRT9NSCdzeUFeqNqUmvSF
         FRx8FAgha9cRnpNYlqReH8JzHME3L/CVtA6UjTxc/dAstp+t6Kmbp2P9VV/hS5+jjt2Q
         XyfTeRvpQhYrENQ+of7xI48AsAkBM1xh9FRJKh0jHRn1Tc5xLs5A3o7UYk/ld1u0QJli
         ao3G/J/Ydk3nabw+QsaOuoJ0Crr9guyIE7q7FKRcwAbrBautD5+FkzFSf2ETnCeaQhGS
         ARZA==
X-Gm-Message-State: AOJu0YwUSkXQnPWPr9xtM9Me7jKZLVZBSyLViResRhsHrhN1KxgkxVUq
	IkveHwjzm7cAaMPkjRJhrZJp61otJEXQOp7d4NqaDgu70T/1DpQgojnPDhMHV0IlzAPnP2fDMst
	I59eYrnkxsIHZLf1xthbXMLGhqq/qvKw0hyn9Kz70bonInwWIY6kC4FB1pyt2H0dW6NlCEDDHmp
	5OS0gxUR6raxhuu+VtUs+8k/WyOEqhJHKPIoBBiv4=
X-Gm-Gg: ASbGncvz2a7Sh60AhMId0zlAh9qT6BpADi3+VUZtffPUFpHMoscOqqVO6zYeV2SuBNW
	nbg7+FKzgbWkhoYVm/RXHSxUNSCrPVJre
X-Received: by 2002:a2e:a592:0:b0:2ff:98c2:763f with SMTP id 38308e7fff4ca-2ffa71c398fmr4974331fa.34.1732241900462;
        Thu, 21 Nov 2024 18:18:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAY9y0V1VpfZqaiWJc8NCM/S+eOsGeHtXv/BAxw4zqSLl4A5wn32ba/qxPsczjP6KdQDZ1XUCG6azvyb8i2xE=
X-Received: by 2002:a2e:a592:0:b0:2ff:98c2:763f with SMTP id
 38308e7fff4ca-2ffa71c398fmr4974221fa.34.1732241900016; Thu, 21 Nov 2024
 18:18:20 -0800 (PST)
MIME-Version: 1.0
References: <20241120102051.247995-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20241120102051.247995-1-shinichiro.kawasaki@wdc.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 22 Nov 2024 10:18:08 +0800
Message-ID: <CAHj4cs-X=D=pZOPf6e_d=kKfFHXFMoAZb9m-fpT1Y+dtCWhMxA@mail.gmail.com>
Subject: Re: [PATCH blktests] nvme: delete all namespaces in _remove_nvmet_subsystem()
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>, 
	Daniel Wagner <dwagner@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5qnvomeBLJklPoE2dMhJeSyJhCb-WKybOKUtzbizlG8_1732241901
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_181825_131249_41ACAAD9 
X-CRM114-Status: GOOD (  24.19  )
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

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Wed, Nov 20, 2024 at 6:20=E2=80=AFPM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> From: Hannes Reinecke <hare@suse.de>
>
> A subsystem might have more than one namespace, so delete all of them in
> _remove_nvmet_subsystem().
>
> This change was to be made before the commit 67e25d71bc58 ("nvme/052: do
> not create namespace when setting up the target"), which assumes that
> _remove_nvmet_subsystem() delets all namespaces. However, commit order
> was modified then the test case nvme/052 now fails without this commit.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [Shin'ichiro: resolved conflicts]
> Fixes: 67e25d71bc58 ("nvme/052: do not create namespace when setting up t=
he target")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> This patch is a part of the ANA support work by Hannes. It was once inclu=
ded in
> the first series of the work, but it was dropped from the series to be in=
cluded
> in the later series [1]. After the second series of the work was applied,=
 Yi
> Zhang found nvme/052 fails [2]. It turned out that this patch is required=
 for
> the one of the patches in the second series, which is the commit 67e25d71=
bc58
> ("nvme/052: do not create namespace when setting up the target").
>
> Of note is that this patch also prepares for one of the new test cases to=
 be
> included in the third series [3].
>
> [1] https://lore.kernel.org/linux-nvme/20241024010025.2216242-14-shinichi=
ro.kawasaki@wdc.com/
> [2] https://lore.kernel.org/linux-nvme/20241120024925.1397864-1-yi.zhang@=
redhat.com/
> [3] https://github.com/kawasaki/blktests/commit/31091d116eaea4e7d5ad3cf76=
e106d1085209c07
>
>  common/nvme    | 5 ++++-
>  tests/nvme/016 | 5 -----
>  tests/nvme/017 | 5 -----
>  3 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/common/nvme b/common/nvme
> index 688193b..fd472fe 100644
> --- a/common/nvme
> +++ b/common/nvme
> @@ -640,7 +640,10 @@ _remove_nvmet_subsystem() {
>         local nvmet_subsystem=3D"$1"
>         local subsys_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>
> -       _remove_nvmet_ns "${nvmet_subsystem}" "${def_nsid}"
> +       for n in "${subsys_path}/namespaces/"*; do
> +               [ -d "${n}" ] || continue
> +               _remove_nvmet_ns "${nvmet_subsystem}" "${n##*/}"
> +       done
>         rm -f "${subsys_path}"/allowed_hosts/*
>         rmdir "${subsys_path}"
>  }
> diff --git a/tests/nvme/016 b/tests/nvme/016
> index dd3cb44..95b0df4 100755
> --- a/tests/nvme/016
> +++ b/tests/nvme/016
> @@ -47,11 +47,6 @@ test() {
>         _remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
>         _remove_nvmet_port "${port}"
>
> -       for ((i =3D iterations; i > 1; i--)); do
> -               nsid=3D$((def_nsid + i - 1))
> -               _remove_nvmet_ns "${def_subsysnqn}" "${nsid}"
> -       done
> -
>         _remove_nvmet_subsystem "${def_subsysnqn}"
>
>         echo "Test complete"
> diff --git a/tests/nvme/017 b/tests/nvme/017
> index a22c748..3483929 100755
> --- a/tests/nvme/017
> +++ b/tests/nvme/017
> @@ -47,11 +47,6 @@ test() {
>         _remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
>         _remove_nvmet_port "${port}"
>
> -       for ((i =3D iterations; i > 1; i--)); do
> -               nsid=3D$((def_nsid + i - 1))
> -               _remove_nvmet_ns "${def_subsysnqn}" "${nsid}"
> -       done
> -
>         _remove_nvmet_subsystem "${def_subsysnqn}"
>
>         rm "$(_nvme_def_file_path)"
> --
> 2.47.0
>


--=20
Best Regards,
  Yi Zhang


