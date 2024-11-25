Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4BBD58090
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 12:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LQtxieVHWM9koiiuYBNm81cZWH/nCFoP0WhoMzOLjH0=; b=lCEBX7ulBlW/tvpcYjV6RDfRY9
	sImq7FFpJFXtw7xcCoWWMg1qDaxXwHzW/3jZ5gy+pq+xveHD3cvIyOlwn6kE/l0clcPjd79lxtmr/
	lFIHlstfhNllWjH7R76oypp3XzbHjzHZxRZJZENy5YsqTomy+ejZ+DaF5sPubXkkCABc1IZIcCwg9
	QfBfcBSDt69BA4Ne2NMytZej3DTRU5rV4thxaHgfeBNA4OkrGfACg1vJa0OlcPeT9L5xIwAWgFAt4
	/Gyrh2tyLUqx029d9HilCjtiMeDLD52TNsAdLu6KpPsiC7F4A5Zobjp05OXxG+0FIQsQAHMkgwH5Z
	b5gkE7+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFYeQ-000000083D8-1OD5;
	Mon, 25 Nov 2024 12:57:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFYeN-000000083Cd-1LPl
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 12:57:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732539429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQtxieVHWM9koiiuYBNm81cZWH/nCFoP0WhoMzOLjH0=;
	b=edMzU9h9MSPu3a+2Pv4APijqonW4JIdixs9+0tfqIenRYuMnHdo9zOhr3yftM93rGmGajB
	LaKWytH/00vpt6a34mUZ8yK+M5fc70M7dAomcvpTPjVbCL5j/uqJKNG/qI7PzPx14Lggpl
	CEBUasWFryzpgtD0aqXnalihWSfAUn0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-5lPIeAIbN2eNDnHU6II6oA-1; Mon, 25 Nov 2024 07:57:07 -0500
X-MC-Unique: 5lPIeAIbN2eNDnHU6II6oA-1
X-Mimecast-MFC-AGG-ID: 5lPIeAIbN2eNDnHU6II6oA
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ffbff51db9so5076371fa.2
        for <linux-nvme@lists.infradead.org>; Mon, 25 Nov 2024 04:57:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732539425; x=1733144225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQtxieVHWM9koiiuYBNm81cZWH/nCFoP0WhoMzOLjH0=;
        b=TeLgQQT1yIp2QKHd7LTAO93xwle8FWd/aXRb8W6jQD1KxouHMTfN+DBtAsGuOAYb/C
         nOiLKW8fwkYdyC0mp+B2TekLwwVmrsow3NtjrKEvb9j7BQNzUVJCGJOrMsWS+4tfx1+I
         XSsBglWv3cDaWARzyfWJvJOaDLcFoo4esKW50LWV9CcPOwEAnd7fhCaA9q7HfS6b9Vte
         zA7zkDs2oTLNij0PnIEvHjcHnAJZr1d0pItwIH9cmmnAwLcLOb9yElzq/sxOs1sbJIG9
         XlbJ+qgeOU0b4Nulu08PxDV33eLQUTiFKT98p2y56Sv9/5Wi1oPRafznbKWgPEXrLxGi
         lEzg==
X-Gm-Message-State: AOJu0YzzMIzLROLvtKLxq8hZL7D8Qo+NAfnG6JnXtvC3q2INBJuDoX66
	MnA1VIVscMpMvO+kF6IHtoczbpHHQBAvYNA37ntr9RiMFPqHuNZoJ9NUGBZhr+ErCrhmNDO5Mzl
	WI+N3qKgjpuAcQu8Y2cg8KCZGL4dyVrO06stqwoUSuBFJVePy31duBwnwrUS4RXfbUtd5f3s3Jq
	MBwOJx8JfTKxF9cUAEEpA/w9VZV7zE4jtnPnABxRg=
X-Gm-Gg: ASbGncsLys+C+WIl91jOFKBML+W3i9yaZu+4gpIu5/z2zTc+TlcZR5XDE9aTMz5u1ma
	uCS3apInCKVgyq447a90J/UbXwyDUTPOP
X-Received: by 2002:a2e:a902:0:b0:2ff:a4c6:b144 with SMTP id 38308e7fff4ca-2ffa7180014mr61759971fa.25.1732539425230;
        Mon, 25 Nov 2024 04:57:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGoW36c4SyCt5Ts8vLHdgIannr8YCBy1YoI+9/Owz/30pylNnh+a/YieDIdSzpYFQ4KlSpF/uVJUK+vghkyPA=
X-Received: by 2002:a2e:a902:0:b0:2ff:a4c6:b144 with SMTP id
 38308e7fff4ca-2ffa7180014mr61759821fa.25.1732539424847; Mon, 25 Nov 2024
 04:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20241124125628.2532658-1-nilay@linux.ibm.com>
In-Reply-To: <20241124125628.2532658-1-nilay@linux.ibm.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 25 Nov 2024 20:56:53 +0800
Message-ID: <CAHj4cs9EE0Ty0TVEF-ChV=fK_fghoigzCJmV1zNGJGBc2toEjg@mail.gmail.com>
Subject: Re: [PATCHv2] nvmet: use kzalloc instead of ZERO_PAGE in nvme_execute_identify_ns_nvm()
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com, 
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com, mlombard@redhat.com, 
	gjoyce@linux.ibm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GDQRNj9sh53KNm60OC1u0RKa23qRlsWegS5j4wvcPUI_1732539425
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_045711_440050_3A41F6EB 
X-CRM114-Status: GOOD (  22.62  )
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

Thanks for the fix.

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Sun, Nov 24, 2024 at 8:57=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
> The nvme_execute_identify_ns_nvm function uses ZERO_PAGE for copying
> SG list with all zeros. As ZERO_PAGE would not necessarily return the
> virtual-address of the zero page, we need to first convert the page
> address to kernel virtual-address and then use it as source address
> for copying the data to SG list with all zeros. Using return address
> of ZERO_PAGE(0) as source address for copying data to SG list would
> fill the target buffer with random/garbage value and causes the
> undesired side effect.
>
> As other identify implemenations uses kzalloc for allocating a zero
> filled buffer, we decided use kzalloc for allocating a zero filled
> buffer in nvme_execute_identify_ns_nvm function and then use this
> buffer for copying all zeros to SG list buffers. So esentially, we
> now avoid using ZERO_PAGE.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Fixes: 64a51080eaba ("nvmet: implement id ns for nvm command set")
> Link: https://lore.kernel.org/all/CAHj4cs8OVyxmn4XTvA=3Dy4uQ3qWpdw-x3M3FS=
UYr-KpE-nhaFEA@mail.gmail.com/
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> Changes from v1:
>     - Use kzalloc instead of ZERO_PAGE() for allocating zero filled
>           buffer (Christoph Hellwing, Keith Busch)
>
>  drivers/nvme/target/admin-cmd.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
> index 934b401fbc2f..f92c5cb1a25b 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -901,13 +901,18 @@ static void nvmet_execute_identify_ctrl_nvm(struct =
nvmet_req *req)
>  static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
>  {
>         u16 status;
> +       struct nvme_id_ns_nvm *id;
>
>         status =3D nvmet_req_find_ns(req);
>         if (status)
>                 goto out;
>
> -       status =3D nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
> -                                  NVME_IDENTIFY_DATA_SIZE);
> +       id =3D kzalloc(sizeof(*id), GFP_KERNEL);
> +       if (!id) {
> +               status =3D NVME_SC_INTERNAL;
> +               goto out;
> +       }
> +       status =3D nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
>  out:
>         nvmet_req_complete(req, status);
>  }
> --
> 2.45.2
>


--=20
Best Regards,
  Yi Zhang


