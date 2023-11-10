Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB98C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Nov 2023 15:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MT38o5Ae3OJBcTJQStAk3qjyADcvfwQVOXoScD5ddQA=; b=d23xv4OyOF4wEKKrTv6daLzTFb
	Z1IvyfJH19txiqEsptor5yeRmUAqypfLsjUKRrhxA9PKElme9Xp8c61krABqq1uqclsp+cjI0COgx
	oCSQI0Qvb3JETmlts07hHY4ESi6iSLgVJCaQMn7vDM+0Pmv4X0jJodd7QJ/XUbOW1MwhEMb56a54u
	tqOO+VnvXghnS3INHx+jgIjvXSjqL8+8vid6u808HqoFurQQEzNDZANXaRdCLiDiITBNDb4WJNl7K
	r0pTii2fA9EQz+vXueBzZ+a+yZykZL7Ja+6Td8u1iY+a8nPelP0lkb/bitGm+AXWtIGuiRBpXMTVR
	2esh7YGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1Tkv-0092nM-2y;
	Fri, 10 Nov 2023 15:49:13 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1Tkt-0092mT-16
	for linux-nvme@lists.infradead.org;
	Fri, 10 Nov 2023 15:49:12 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9e623356e59so131296966b.0
        for <linux-nvme@lists.infradead.org>; Fri, 10 Nov 2023 07:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699631349; x=1700236149; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MT38o5Ae3OJBcTJQStAk3qjyADcvfwQVOXoScD5ddQA=;
        b=JoUhZ24cfVnYSgeiz6S7p933KNAFg6rcv+OoRydi/sWnn/NXKvU2B3samYkW87N4W3
         HUd0gokcl7oWU3BBlWg5Z598Olu4koI4L3jnWE5WGx0ko5T5LNLavbT41xtt9lVm2fT5
         iWKqYa+8yH1FEekWeI1Rjfgu4dWy5Z1PPZfm8PPzh5dQ3B05JOEZeIhxgw0jdRVLKQRN
         0SJhvhyQjmunvI1/2ki7/aK4UjHIwZaZL5GT88dbKwgw6+K1Fdmwg9wbfQfZbjNRNI6J
         zCYzaIDBXWfetF8xuU8nWGmvketOSdxeob4CrW2cdVMTMY2UP0X1ioLILlKFqHbWfeHa
         2kgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699631349; x=1700236149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MT38o5Ae3OJBcTJQStAk3qjyADcvfwQVOXoScD5ddQA=;
        b=HFQHN5423jmQrbe39V6xLdoZ1uFRiQulLjz3jFaqLhDOQMc759agX4PX5QMIb56NiA
         EOVLypoWMgFokkNr7dpRwgYzq4Q8hEa/oAVnQxZJkpKRLX/wv5UvjWNHZP1cEoEHD9qG
         UHoM33Ow/cviDUGrzDfVmPF7nALFaYAZ7M6o0OocujQrMlb9PZqe4Pnv1JV5NBiVygCZ
         7MROJCK4fn0nHklBLJ6e37hvp2XbmizktQ7DFTiYe5HVVkvSE99KkIfZHtPRThpIiai1
         aH/Tt1dJC1PgWKNmt/xHWBbziEsxTB/CmKo4+e33oBfeyMiQ0bei9/nL3xCY1WBj4COz
         vTdw==
X-Gm-Message-State: AOJu0YxkalBwIBw1+0XVkwefhVVxMpa7OzilNwf/W6pOC5+W8mkJ8DfP
	8cjL3kLU0A0Vm+5P3CkIhtlW9FgAqNAJr8kQi2/Cv3iYSDw=
X-Google-Smtp-Source: AGHT+IFZRv/gmhNe3vmqGv3joy7cIQNamOM4EejfBBc6YPAA4CgEFoe7xZ7wu4IsYvBOZ2Mht/Jx+be+m+T9TBDItzQ=
X-Received: by 2002:a17:906:64f:b0:9e6:59d5:7a86 with SMTP id
 t15-20020a170906064f00b009e659d57a86mr1362381ejb.57.1699631349023; Fri, 10
 Nov 2023 07:49:09 -0800 (PST)
MIME-Version: 1.0
References: <20231110063837.810134-1-hch@lst.de> <CADUfDZpp4hen-K4zZZM_W1_2XaOomW-5aEDzaOXLyNv9Q3ZnEg@mail.gmail.com>
In-Reply-To: <CADUfDZpp4hen-K4zZZM_W1_2XaOomW-5aEDzaOXLyNv9Q3ZnEg@mail.gmail.com>
From: Alon Zahavi <zahavi.alon@gmail.com>
Date: Fri, 10 Nov 2023 17:48:57 +0200
Message-ID: <CAK5usQvxAyC3LJ4OnqerS1P0JpbfFr9uRZmq6Jb4QhaB7AQCoQ@mail.gmail.com>
Subject: Re: [PATCH] nvmet: nul-terminate the NQNs passed in the connect command
To: Caleb Sander <csander@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_074911_378764_D0EC1105 
X-CRM114-Status: GOOD (  20.33  )
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

On Fri, 10 Nov 2023 at 17:37, Caleb Sander <csander@purestorage.com> wrote:
>
> Won't this overrun the subsysnqn and hostnqn fields? Writing to
> subsysnqn[NVMF_NQN_FIELD_LEN] will clobber the first char of hostnqn:
> struct nvmf_connect_data {
>         uuid_t hostid;
>         __le16 cntlid;
>         char resv4[238];
>         char subsysnqn[NVMF_NQN_FIELD_LEN];
>         char hostnqn[NVMF_NQN_FIELD_LEN];
>         char resv5[256];
> };
>
> I think clearing the previous byte (index NVMF_NQN_FIELD_LEN - 1)
> would work. The spec requires NQNs to be under 223 bytes anyways, so
> they should never take up the whole field.
>

True.
We should zero the byte in the `NVMF_NQN_SIZE` index, making the
fields their real size.
Changing the patch from `d->subsysnqn[NVMF_NQN_FIELD_LEN] =3D '\0';` to
`d->subsysnqn[NVMF_NQN_SIZE] =3D '\0';`

> On Thu, Nov 9, 2023 at 10:45=E2=80=AFPM Christoph Hellwig <hch@lst.de> wr=
ote:
> >
> > The host and subsystem NQNs are passed in the connect command payload a=
nd
> > interpreted as nul-terminated strings.  Ensure they actually are
> > nul-terminated before using them.
> >
> > Fixes: a07b4970f464 "nvmet: add a generic NVMe target")
> > Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/nvme/target/fabrics-cmd.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fa=
brics-cmd.c
> > index 43b5bd8bb6a52d..0920fe7ce4ac99 100644
> > --- a/drivers/nvme/target/fabrics-cmd.c
> > +++ b/drivers/nvme/target/fabrics-cmd.c
> > @@ -244,6 +244,8 @@ static void nvmet_execute_admin_connect(struct nvme=
t_req *req)
> >                 goto out;
> >         }
> >
> > +       d->subsysnqn[NVMF_NQN_FIELD_LEN] =3D '\0';
> > +       d->hostnqn[NVMF_NQN_FIELD_LEN] =3D '\0';
> >         status =3D nvmet_alloc_ctrl(d->subsysnqn, d->hostnqn, req,
> >                                   le32_to_cpu(c->kato), &ctrl);
> >         if (status)
> > @@ -313,6 +315,8 @@ static void nvmet_execute_io_connect(struct nvmet_r=
eq *req)
> >                 goto out;
> >         }
> >
> > +       d->subsysnqn[NVMF_NQN_FIELD_LEN] =3D '\0';
> > +       d->hostnqn[NVMF_NQN_FIELD_LEN] =3D '\0';
> >         ctrl =3D nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
> >                                    le16_to_cpu(d->cntlid), req);
> >         if (!ctrl) {
> > --
> > 2.39.2
> >
> >

