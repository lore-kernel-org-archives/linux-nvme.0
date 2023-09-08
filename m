Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F45CEE57E6
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 08:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oFxQWufNZPj+UVdvDwOEYmLSczmPnEzE02oXUxetDWw=; b=Cf51U8exMISxcybTR8K9eAhG4J
	4lf7HjoQZBnKMlldT9GfGhniBkHPNbJDj4REzozpXhH+eCr/f9nogFDNYu24KRiAu+uYYth8H+CSI
	CmQonWGGUfC+5jraYYOyIWjJqUmgBH/n1VuTP873a6RH2LEU6XlKVREs4dRVSmS+R+hcMSZJ2r9TQ
	7cFH8ETqCPTOo4hslY29lLOmOtY4lPW5tQSZwyk4890u3/eF8nLte/UDve9Zei1zirxIJ/Q5JqCV0
	4ih2IzH0pubYeG+Xb2mrFslmkbLj5mqaApUl3b5NZ8j+UFJPHj/Qh3N/1ABwqCiLcZFJHxqfzxhEb
	UWwgqFrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeX6M-00DLE8-0x;
	Fri, 08 Sep 2023 08:44:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeX6J-00DLDQ-1w
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 08:44:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694162666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oFxQWufNZPj+UVdvDwOEYmLSczmPnEzE02oXUxetDWw=;
	b=YoZaEUe4/q0GXDvgwiXg2IuyGfTeL8sSDzSHpDGczjeNKcflN0Ddvv4b4vwwl47yVP4iMR
	v0/PdyNEkYeQ4rKtMr8v37tHvw713z9nKGpgG87xmDNDN6/+F5a1tDcOjgIWuupECztHQn
	xSi2ajTziNYW1xSxRDKB7/XoadXPczc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-l-qi6YriOymAKWMSoUiKng-1; Fri, 08 Sep 2023 04:44:24 -0400
X-MC-Unique: l-qi6YriOymAKWMSoUiKng-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-56f8334c253so2312025a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 08 Sep 2023 01:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694162663; x=1694767463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFxQWufNZPj+UVdvDwOEYmLSczmPnEzE02oXUxetDWw=;
        b=GDaR/aRsGPD4N0GXQXnWeRydAWFtVXp7zraAQBitTURTeNEqrgiM0W8gh0P+OxuaOy
         TNpwC4r0LS+Ub7nHvPn+1SHHQfUnUD3Qtl0K3ycIgicUGt4hCjcwuyEjz9/Nk7WSdjd7
         RHnVGQpiuRZjBS2hC2q6sd9zs/yIxlwJMaxYS1BGMBGVPf/wM3erq1pv6L2jlAoULNOH
         BdzDs1ZlCKQmscempl5I4JnmJo05w3JlTTm3s8Zg1sfKfrOCASRvvIW3wBWMtZA0Xx8h
         L00Cru+s8kN7HOrLfgvf6vLmsvCNIYph3ftZ1LN0l3L7t+pUmtABijbreB2SM4iIPcId
         imHQ==
X-Gm-Message-State: AOJu0Yxpu07IfykVNDaeXlJyfGwHhvABP8o9peEmdf4DREkEj1Eu+eFT
	0JZojw5BE4/ZDYDaOaiFe2M9oUdQoYiagQyOz4fNFgMOrw5un9/DvzHju/7csuQlK8evjERVkST
	B+Awa0vi3kgb5U1ieiXyeM3tboltYe6stqKkQ4SM0mow=
X-Received: by 2002:a05:6a21:71cb:b0:153:6e63:49fb with SMTP id ay11-20020a056a2171cb00b001536e6349fbmr2297174pzc.52.1694162663525;
        Fri, 08 Sep 2023 01:44:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmusW2khjukQ7iLhcSpXD7n7ZKFsJ85sNEgvHxoXw2AFtmypXoyR9IJAFcJAYFvqqtPfu4knM9zvan68UwN8M=
X-Received: by 2002:a05:6a21:71cb:b0:153:6e63:49fb with SMTP id
 ay11-20020a056a2171cb00b001536e6349fbmr2297166pzc.52.1694162663286; Fri, 08
 Sep 2023 01:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230726142939.10062-1-guoqing.jiang@linux.dev>
 <CAHj4cs9LppxseFzZe-fj7tDaeKd0x8t8Wr-aYcjXAU-8FyfoiQ@mail.gmail.com>
 <a403c942-5b1c-c7f7-243b-81545f7f83ad@linux.dev> <065d800d-8c6c-4257-ade2-9ffa92c36735@suse.de>
 <CAHj4cs_8iC5rn+xA7_bvRifE+1Uu9jjj0wHf=5EmuW7zvaxeYw@mail.gmail.com>
In-Reply-To: <CAHj4cs_8iC5rn+xA7_bvRifE+1Uu9jjj0wHf=5EmuW7zvaxeYw@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 8 Sep 2023 16:44:11 +0800
Message-ID: <CAHj4cs_bn=mCiVu1ZhZYUhf950TsHzdLe4++9N2ebHsLq2YGwg@mail.gmail.com>
Subject: Re: [PATCH RFC] nvmet-tcp: add new workqueue to surpress lockdep warning
To: Hannes Reinecke <hare@suse.de>
Cc: Guoqing Jiang <guoqing.jiang@linux.dev>, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_014427_728464_4DBD3E36 
X-CRM114-Status: GOOD (  20.76  )
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

On Fri, Sep 8, 2023 at 4:09=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrote=
:
>
> On Fri, Sep 8, 2023 at 3:15=E2=80=AFPM Hannes Reinecke <hare@suse.de> wro=
te:
> >
> > On 9/7/23 10:12, Guoqing Jiang wrote:
> > > Hi Yi,
> > >
> > > On 9/7/23 14:41, Yi Zhang wrote:
> > >> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> > >>
> > >> Confirmed below issue was fixed by this patch:
> > >
> > > Thanks a lot for the test!
> > >
> > > And I had got another similar lockdep warning about nvmet-rdma.
> > >
> > Please note that this issue is fixed by my patch 'nvmet-tcp: avoid
> > circular locking dependency on install_queue()' send earlier to this li=
st.
> >
> > Can you please test with that one to see if it fixes the issue for you?

Hi Hannes
There are changes in nvmet_tcp_install_queue and the patch cannot be
cleanly applied,
Could you check it, Thanks.

>
> Sure, will try it later this week.
>
> >
> > Cheers,
> >
> > Hannes
> > --
> > Dr. Hannes Reinecke                Kernel Storage Architect
> > hare@suse.de                              +49 911 74053 688
> > SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> > HRB 36809 (AG N=C3=BCrnberg), Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, And=
rew
> > Myers, Andrew McDonald, Martje Boudien Moerman
> >
>
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang


