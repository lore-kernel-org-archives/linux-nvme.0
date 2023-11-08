Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02834C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 21:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YORmX9lr2fXkEvC4tyZOL3EX1Fvudq9WFOTSnxqClXM=; b=rstjiFBLP4XLbpfuUmW5q4yjpU
	tIJGTN184JpBWRpQpNDLHGPAfnzndfbXyaVWD/Rt3QNOE4LAFnnuVPQWVgSl73DFzSdytVuSuZUjB
	07ge2aIOUxd2LwoV/vUM5+D9GmS1R55Q1OS3y/Uxssrq6ot0y5A0azrsst2GWpUt3oDiEdXGBUJb6
	jttOEEfh0HGkhNb8WDSIZr8MrfPOLcvdcXJqkqrSjqTqsOPpUFRTYlfqqcEA8FoJb2lL7mQNDbj3Q
	eWk/Dyw2Va7Wyped/L/7/c9VaUtO59P4z0A6vQ8Lyq6VlCowzm0D51CjpWY2vhIbdwIySB06unzqp
	lwjK1CnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0prG-004lNM-2A;
	Wed, 08 Nov 2023 21:13:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0prD-004lMA-2D
	for linux-nvme@lists.infradead.org;
	Wed, 08 Nov 2023 21:13:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699477982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YORmX9lr2fXkEvC4tyZOL3EX1Fvudq9WFOTSnxqClXM=;
	b=bqneX3RLPzWuxL4O78b9nTPiEWnt6zGQWz3t763qDn5lCe+64wWM/f+/YvejRqxbnfDSlP
	mRbKcEjwLDAI4s8e7OAQsITERejt6PdQtUfkRboFq2iSvPWAtkGqCWDMOYee0pGcsZQgyr
	oTkym6EbKyiqfccIctAlsIuYB7jSz7c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111--eIhxpBWM-aARG_kuFpzDQ-1; Wed, 08 Nov 2023 16:11:01 -0500
X-MC-Unique: -eIhxpBWM-aARG_kuFpzDQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77ba7c63d9eso14282685a.0
        for <linux-nvme@lists.infradead.org>; Wed, 08 Nov 2023 13:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699477861; x=1700082661;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YORmX9lr2fXkEvC4tyZOL3EX1Fvudq9WFOTSnxqClXM=;
        b=rNXeSf6j7X9mzfNTMGllhXUSmJ9yD2wI1M+CsWNVsGvI6bCGszj7HPAcaLpUTZ8wY+
         7ll6+RgKc35hHDFzdPiQKurtgtOvgX61bRS2Vugm5OPjwDabP1Y7eHTkeSkUv/pMd4QV
         6rQmCAX5CVQ28BLsxpQ+NqDa06v9Jg6hX5hq2U1sKlZLjupFV5zErBLdb+hCVrjVk8+9
         QBHAa5Y8SkP4Rmag6RV/yZIpA1QMsycXgzqzgbWZiLYQ1UtVgyKHip3OoLeNqqdWfd3w
         mBEofbBCiVb7RkYlXB7F9Hfqz/4fPVLKsPmR8ZhEAuvibQY/Va8cOL2nzq/r/KcpSPuz
         1f/A==
X-Gm-Message-State: AOJu0Yy9pAMyFYV9jH4s+UAwCQaIjtM8Eop+GtLvmd23R5dZu96OW0uw
	jr5ohDJHlV84u3zMYtPdLHAXz4NZ8yCMS7AqvOC3Bwo91ikwlXWYvZddHeODoFoezJyyCQljesX
	xfNixN1FPvUdoeD0N7P3ZiMdlyBY=
X-Received: by 2002:a05:620a:6508:b0:778:99a0:d105 with SMTP id qb8-20020a05620a650800b0077899a0d105mr3295489qkn.23.1699477860748;
        Wed, 08 Nov 2023 13:11:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQVJyNkv0GlH9NY/6GEJDe2UFUXlPiJoOOFyBf/i7TlJ6tHSLjne78U0VruI67yQB1gCzd7g==
X-Received: by 2002:a05:620a:6508:b0:778:99a0:d105 with SMTP id qb8-20020a05620a650800b0077899a0d105mr3295467qkn.23.1699477860447;
        Wed, 08 Nov 2023 13:11:00 -0800 (PST)
Received: from ?IPv6:2600:6c64:4e7f:603b:2613:173:a68a:fce8? ([2600:6c64:4e7f:603b:2613:173:a68a:fce8])
        by smtp.gmail.com with ESMTPSA id po15-20020a05620a384f00b0076cb3690ae7sm1438024qkn.68.2023.11.08.13.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 13:10:59 -0800 (PST)
Message-ID: <ac4e257ff54c91c30ec2d792cf656cea1d3d741f.camel@redhat.com>
Subject: Re: Mellanox CX6 and nvmet connectivity failure, happens on RHEL9.2
 kernels and latest 6.6 upstream
From: Laurence Oberman <loberman@redhat.com>
To: Mark Lehrer <lehrer@gmail.com>, jpittman@redhat.com,
 chaitanyak@nvidia.com,  jmeneghi@redhat.com
Cc: linux-rdma <linux-rdma@vger.kernel.org>, linux-nvme@lists.infradead.org
Date: Wed, 08 Nov 2023 16:10:58 -0500
In-Reply-To: <58dae256881123291880b1df49d99fe9ceb01944.camel@redhat.com>
References: <475a37e920badad12a0d71fff65e817979417594.camel@redhat.com>
	 <CADvaNzW1GYMDnD5ffTbB0wgbmWF1HNwgkikbL1=48=B2ouVGHw@mail.gmail.com>
	 <27ebfe1ffb5b9e1983466f6ad3a1726b66fc0799.camel@redhat.com>
	 <58dae256881123291880b1df49d99fe9ceb01944.camel@redhat.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231108_131303_819180_18B53C3C 
X-CRM114-Status: GOOD (  28.95  )
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

On Wed, 2023-11-08 at 15:55 -0500, Laurence Oberman wrote:
> On Wed, 2023-11-08 at 15:07 -0500, Laurence Oberman wrote:
> > On Wed, 2023-11-08 at 12:57 -0700, Mark Lehrer wrote:
> > > > [=C2=A0 286.547112] nvme nvme4: Connect Invalid Data Parameter,
> > > > cntlid:
> > > > 1
> > > > [=C2=A0 286.555181] nvme nvme4: failed to connect queue: 1 ret=3D16=
770
> > >=20
> > > It looks like the admin queue pair (0) worked at least.=C2=A0 The cod=
e
> > > path
> > > for the two is a bit different.
> > >=20
> > > This error sounds familiar.=C2=A0 I wonder if there's an error code
> > > 16xxx
> > > cheat sheet out there.
> > >=20
> > > We recently had to downgrade a ConnectX firmware version to fix a
> > > similar issue, but on a CX7.=C2=A0 I can't remember the firmware
> > > versions
> > > involved but I could probably dig it up.
> > >=20
> > > Have you tried TCP mode?=C2=A0 Whether TCP works or not will be usefu=
l
> > > information for debugging.
> > >=20
> >=20
> > Hi MArk
> >=20
> > I landed up changing the default kato from 5s to 30 and its working
> > now
> > We don't jump ship too early anymore and it connects fine.
> > See prior response where I answered my own message
> >=20
> > diff -Nurp linux-5.14.0-
> > 284.25.1.el9_2.orig/drivers/nvme/host/nvme.h
> > linux-5.14.0-284.25.1.el9_2/drivers/nvme/host/nvme.h
> > --- linux-5.14.0-
> > 284.25.1.el9_2.orig/drivers/nvme/host/nvme.h=C2=A0=C2=A0=C2=A02023-
> > 07-20 08:42:08.000000000 -0400
> > +++ linux-5.14.0-
> > 284.25.1.el9_2/drivers/nvme/host/nvme.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A02023-
> > 11-08 14:16:37.924155469 -0500
> > @@ -25,7 +25,7 @@ extern unsigned int nvme_io_timeout;
> > =C2=A0extern unsigned int admin_timeout;
> > =C2=A0#define NVME_ADMIN_TIMEOUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(admin_ti=
meout * HZ)
> > =C2=A0
> > -#define NVME_DEFAULT_KATO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A05
> > +#define NVME_DEFAULT_KATO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A030
> > =C2=A0
> > =C2=A0#ifdef CONFIG_ARCH_NO_SG_CHAIN
> > =C2=A0#define=C2=A0 NVME_INLINE_SG_CNT=C2=A0 0
> >=20
> >=20
> > I will wait for Sagi and Keith and then send a patch
> > I had the wrong email for Keith
> >=20
> > Thanks a lot
> > Laurence
> >=20
>=20
> Hello
>=20
> No fix needed, I was unaware of the -k option in the nvme connect.
> My colleague showed it to me.
> This works now to give the CX6 longer to handle the connection
>=20
> #!/bin/bash
> modprobe nvme-fc
> nvme connect -t rdma -n nqn.2023-10.org.dell -a=C2=A0 172.18.60.2=C2=A0 -=
s 4420
> -
> k 30
>=20
>=20
> Thanks
> So a Heads up for these newer cards I guess, need more time
>=20
> Regards
> Laurence
>=20
>=20
>=20
>=20
>=20

Finalizing this discussion and adding appropriate cc's


No patch needed, I was unaware of the -k option in the nvme connect.
My colleague John Pittman showed it to me. and in fact Mark also
pointed it out in a follow up email.
This works now to give the CX6 longer to handle the connection.
C.K Thanks to you as well for responding

Initiator
#!/bin/bash
modprobe nvme-fc
nvme connect -t rdma -n nqn.2023-10.org.dell -a  172.18.60.2  -s 4420=C2=A0
-k 30

Thanks
So a Heads up for these newer cards I guess, need more time

Learn something new every day


