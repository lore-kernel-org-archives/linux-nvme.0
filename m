Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0951DEB64D7
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 00:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sx3guVJL2WC5UvGEgGpdXl6+e1aLtSxlxlCaP4w5/lQ=; b=sTGoARdRG+ukRGO5czK5GbFGQA
	p6AqxQPAqErQZQ26+4znCVSIxnadmiyczlw2SXv+c1/kB+brkXRXoZ4yxvHify3vsseqt+xJZuCbP
	UelXTxzbDQePxnnSFnQ9BfVbVjbyIirxdSDgAYdVuYRO6r3/R1dbf9DCU4OCxnl5SkPalMwa/kMbL
	Sl9Ldx2hXrJXYGKkWhuDtN3TuG4yFAgrCesJ5AFUsGVXLDGBMz1I1kELew56pZ5GzO/Xbj4Ew1jEk
	7V4ni/+4Jarwy3UpV7N5pyhr6jxekDctZG+BKZwGWXCnw2T3nXabKKwluBmSL7OBLfSfjkaJGwfPc
	CTb7rZ8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEf8T-00H5Dp-17;
	Thu, 29 Jun 2023 00:03:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEf8Q-00H5By-0z
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 00:03:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687997015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sx3guVJL2WC5UvGEgGpdXl6+e1aLtSxlxlCaP4w5/lQ=;
	b=aP+pRvKyggO14woEw9+a/jiPDYNfFPSMfwhb0s2bfL0gd82X2Fxsede7IgeTPe3E2AerZO
	hVelpIbEUEKLml1SKiYATWFiWu0GmK9TN4XVaJRt+t2E0+dl4ks9GRi+O+PqCLQaUhYIZx
	jkw8IH/38VTB/5ima+0vwx6kSPqaMpI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-fIvPeCO9NC6G3_xT5-1ndQ-1; Wed, 28 Jun 2023 20:03:32 -0400
X-MC-Unique: fIvPeCO9NC6G3_xT5-1ndQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-262f9ac14e1so63891a91.1
        for <linux-nvme@lists.infradead.org>; Wed, 28 Jun 2023 17:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687997011; x=1690589011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sx3guVJL2WC5UvGEgGpdXl6+e1aLtSxlxlCaP4w5/lQ=;
        b=hSL3pEW/Yp2OOkpBFXIFywSVsmy4w9rWvhnhA0Jc94xwxC6SxFw2slMjmLXJwHb9O3
         65Jo03c60O1Pc0vJ6FgpxphcPZ16bqt8z7CqaVyi2ARL8eXq5Clkj4FCiAfyIrRyYdqH
         PdHXJKeHxzXeq5ytMITiZMMUWKWFcX1QUQuMAo6ncfYNTh+Udetv8w7ul+aH4PH5y7SO
         RePIvHvAgq+H2GMCitQ5u3JLn5lKBYibK2bblPElEp0Jb019p05bq9Jt+E0g5NejlQFf
         Gvj9FK77YV994SGK9++2ClG+n2n0JzuF4fg/uDLw1FtsLaVSs3gtZolCQ8RQ7Xo+htcB
         /gKw==
X-Gm-Message-State: AC+VfDwrEh9vkjk7yTCY67m+e+srTXw1wLTO84m0ZkWr4KWN3efex2or
	DIaGiIdm5ge7uNmA8cdypx2BX5018I2MAU1yeYSCM7QfZOm1eqp1w295hdmPcJ3qwXpOGpYTdua
	XhkQr4CylPn1uXssVHDrMTqoHfO39a4oXAAlxDXGE5ts=
X-Received: by 2002:a17:90a:2b88:b0:262:ceaa:1720 with SMTP id u8-20020a17090a2b8800b00262ceaa1720mr8892194pjd.5.1687997010839;
        Wed, 28 Jun 2023 17:03:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ561AomPYlPtzUqJ+aW+u6gvxozHO1/RACDoc2XPwj9tOvCwIck3lp3Mdozzr0I7b0LOE/oHMyAzdP2yX4hThM=
X-Received: by 2002:a17:90a:2b88:b0:262:ceaa:1720 with SMTP id
 u8-20020a17090a2b8800b00262ceaa1720mr8892179pjd.5.1687997010523; Wed, 28 Jun
 2023 17:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230628124343.2900339-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20230628124343.2900339-1-shinichiro.kawasaki@wdc.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 29 Jun 2023 08:03:18 +0800
Message-ID: <CAHj4cs_H+oEhGqDz_Nwa1SbShhep0eSm+qtf+aEJVHxe5SkuNg@mail.gmail.com>
Subject: Re: [PATCH blktests] nvme/rc: specify hostnqn to hostid to nvme
 discover and connect
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_170342_450115_54274AB0 
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

I've verified the fix on my environment, thanks for the fix.
Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Wed, Jun 28, 2023 at 8:44=E2=80=AFPM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> From: Max Gurtovoy <mgurtovoy@nvidia.com>
>
> After the kernel commit ae8bd606e09b ("nvme-fabrics: prevent overriding
> of existing host"), 'nvme discover' and 'nvme connect' commands fail
> when pair of hostid and hostnqn is not provide. This caused failure of
> many test cases in the nvme group with kernel messages "nvme_fabrics:
> found same hostid XXX but different hostnqn YYY".
>
> To avoid the failure, specify valid hostnqn and hostid to the nvme
> commands always. Prepare def_hostnqn and def_hostid even when
> /etc/nvme/hostnqn or /etc/nvme/hostid is not available. Using these
> values, add --hostnqn and --hostid options to the nvme commands in
> _nvme_discover() and _nvme_connect_subsys().
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Link: https://lore.kernel.org/linux-nvme/CAHj4cs_qUWzetD0203EKbBLNv3KF=3D=
qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com/
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  tests/nvme/rc | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 191f3e2..1c2c2fa 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -14,8 +14,23 @@ def_remote_wwnn=3D"0x10001100aa000001"
>  def_remote_wwpn=3D"0x20001100aa000001"
>  def_local_wwnn=3D"0x10001100aa000002"
>  def_local_wwpn=3D"0x20001100aa000002"
> -def_hostnqn=3D"$(cat /etc/nvme/hostnqn 2> /dev/null)"
> -def_hostid=3D"$(cat /etc/nvme/hostid 2> /dev/null)"
> +
> +if [ -f "/etc/nvme/hostid" ]; then
> +       def_hostid=3D"$(cat /etc/nvme/hostid 2> /dev/null)"
> +else
> +       def_hostid=3D"$(uuidgen)"
> +fi
> +if [ -z "$def_hostid" ] ; then
> +       def_hostid=3D"0f01fb42-9f7f-4856-b0b3-51e60b8de349"
> +fi
> +
> +if [ -f "/etc/nvme/hostnqn" ]; then
> +       def_hostnqn=3D"$(cat /etc/nvme/hostnqn 2> /dev/null)"
> +fi
> +if [ -z "$def_hostnqn" ] ; then
> +       def_hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
> +fi
> +
>  nvme_trtype=3D${nvme_trtype:-"loop"}
>  nvme_img_size=3D${nvme_img_size:-"1G"}
>  nvme_num_iter=3D${nvme_num_iter:-"1000"}
> @@ -442,12 +457,8 @@ _nvme_connect_subsys() {
>         elif [[ "${trtype}" !=3D "loop" ]]; then
>                 ARGS+=3D(-a "${traddr}" -s "${trsvcid}")
>         fi
> -       if [[ "${hostnqn}" !=3D "$def_hostnqn" ]]; then
> -               ARGS+=3D(--hostnqn=3D"${hostnqn}")
> -       fi
> -       if [[ "${hostid}" !=3D "$def_hostid" ]]; then
> -               ARGS+=3D(--hostid=3D"${hostid}")
> -       fi
> +       ARGS+=3D(--hostnqn=3D"${hostnqn}")
> +       ARGS+=3D(--hostid=3D"${hostid}")
>         if [[ -n "${hostkey}" ]]; then
>                 ARGS+=3D(--dhchap-secret=3D"${hostkey}")
>         fi
> @@ -483,6 +494,8 @@ _nvme_discover() {
>         local trsvcid=3D"${3:-$def_trsvcid}"
>
>         ARGS=3D(-t "${trtype}")
> +       ARGS+=3D(--hostnqn=3D"${def_hostnqn}")
> +       ARGS+=3D(--hostid=3D"${def_hostid}")
>         if [[ "${trtype}" =3D "fc" ]]; then
>                 ARGS+=3D(-a "${traddr}" -w "${host_traddr}")
>         elif [[ "${trtype}" !=3D "loop" ]]; then
> --
> 2.40.1
>


--=20
Best Regards,
  Yi Zhang


