Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55542CAC58E
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Sep 2025 13:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D1tJK7EVEEBpZOYAzUBVwhN8ghfGDKg4r3m5O2KBrig=; b=VSxm2BfMR9HWTaj6g/sByfpT1U
	5w+8iuGVoXi30FzTkKjMrV+aZpIWrf7jobzSkYCAbpKqDknw2Wr8Cbi4svj1LU8nguI5XKnbv4wE0
	D32oQXoTttM6xwQ/BZdnl/VxN5AFM7w+adPo6s0Ouj2k1SzWG/pskpWomoQ7CZ4ttYirNWuNGEVSA
	pOlhrXSaqMGxxnSeviwVeWuD/tjEVv2PbVFo1aPRDXKnWN0b/BGh/7pheH11KqfTxjbDoilGynegF
	8ESeW2L2WtjFP7lgolGMw0+FqRJ2ni4bUF25Z+P7YMxJup0oLukPcmsJhqwpl+lccIJsIBaVMg8Yl
	QJgpOgOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwh13-000000038n9-2flj;
	Thu, 11 Sep 2025 13:07:09 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwh10-000000038mo-2wmB
	for linux-nvme@lists.infradead.org;
	Thu, 11 Sep 2025 13:07:07 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-7728815e639so519207b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 11 Sep 2025 06:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757596025; x=1758200825; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D1tJK7EVEEBpZOYAzUBVwhN8ghfGDKg4r3m5O2KBrig=;
        b=RYbkdX5BduSt5yfya+trafSBLijYVEbFUvrG5MlPC7qr5BH4x5yataq8stW99jZgol
         5tW639L2b22AFA0cS7HskVQWWQeZddQUNBVDPF2KOddk0oJRneNXCcDdekaRoUER1gB0
         EYUTPrj6Jt6FN1K6jQDBDguosMJJAofSMCb0xXOMbFvqpCt8RXOyhyLt669swcstu3Td
         EuQRLsUhSSFEflel5CwaxFgfEpj39YFG7ChIkU6iiYQmITrIo8U0p7gnPo3mMdpQ9i5k
         XkXkt8FOo2Crt/dSia+sgPgS3Isc9o03rNdf5h7ZoG2rPCaouuFgv8jvWZiY/paAUT0L
         A5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757596025; x=1758200825;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D1tJK7EVEEBpZOYAzUBVwhN8ghfGDKg4r3m5O2KBrig=;
        b=XeRyXe3O4fXYCoTp1aVecoVLGsDxmloVhOptJN7J8ImNgb6nQxLxc+FaDySJ4g22b9
         iF8oQ1SCTu5/UDI2XI8P9FbA0cujyFp8El+o1x1+jeGTSzVbqFl4sisjBFRarXBf/TBy
         0LYw9AYmvMQIH2Iqf4+cFtNleaCTlmL5KAo6+Dfweek5BnCcDrvwqPM+2TxbCTt3EjPl
         WP4/nlVDuwMokmA8sVBW2hUDmfBprD8nN18rbAgNx+TreR4PTWUtCAgg1yyZME0JDzEu
         u889xqY+o4NjURmlBultsF7l/A57tN+bfIPaDWHzRjhzWRaO594wA3VFRmpmsMBioZHR
         Lc6A==
X-Forwarded-Encrypted: i=1; AJvYcCX2yPv+/RBM983RujoRD+DRv51Bbb9VxhPzaK3CQWyeAWysOPIsX6eV75KdzGQdz1uR+V72D/rvOip6@lists.infradead.org
X-Gm-Message-State: AOJu0Yyfg7f+afSL92OjLR4KdQ2ak20seU7hC4N2V8cH6NQWlEBqNUkw
	vxnx3CglCRwjw9hCS5T2KClZ3E4PmKtd4p8VMO/yUGsx8P28r2bV3BzG
X-Gm-Gg: ASbGncvMhpL+N5MlVNMO/cCYlWB0IFKyLnaaFBZTIV4WHKsu7J3zZf1Iyb5999qiEdO
	z7R2lFZeXT7uKq8XStJagTUvCjmeZGQgkTN1XmAfYV4wn3hrRbQ6gV65qNWm2/uWgm5rKr+aAda
	q9cJewINGWPaAKV1u5r1ujWUeH8RzsRD3KPsX+oTMZoenUPhSV9zfkESST8Ms75c32JrxTKlheN
	cDFTf7vftpBjmKK1F/WUXuXtiunCo/RsFrQ3gqINmvvDMc28elckpLEa4gtk+6Um14Z9tH0mMU9
	cTXl5o2QCovIKhIZcC/CKSPenoO6Ca0SNDCA1oOGQXLdsLMk3Aq9zDH/9JmFmXbFUml1j+IrWA0
	gxud8OHC57PJca3JmllaUqeUwxrtqbryJzsfrTA==
X-Google-Smtp-Source: AGHT+IE5KCoVUC08AWBthUC6tD+cMtnhPBgIMpX5A2BFKgITNRxlg/b4fWnvYXi+fUbXyPN/VD5xuw==
X-Received: by 2002:a05:6a21:33a5:b0:243:ad4f:add9 with SMTP id adf61e73a8af0-253430ae1bdmr27572823637.30.1757596025014;
        Thu, 11 Sep 2025 06:07:05 -0700 (PDT)
Received: from 10.0.2.15 ([223.185.135.45])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a36d0d5bsm1889729a12.22.2025.09.11.06.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:07:04 -0700 (PDT)
Message-ID: <ee638169c6fd15b448449e7dbe3d8aacaf7fc093.camel@gmail.com>
Subject: Re: [PATCH] nvme-tcp: send only permitted commands for secure concat
From: Martin George <martinus.gpy@gmail.com>
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, hare@kernel.org, 
	pnayak@netapp.com, prashana@netapp.com
Date: Thu, 11 Sep 2025 18:37:00 +0530
In-Reply-To: <1f7cd5e4-45f0-40cb-ab6a-6936a5062ae0@suse.de>
References: <20250909103509.10343-1-marting@netapp.com>
	 <1f7cd5e4-45f0-40cb-ab6a-6936a5062ae0@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_060706_749543_30874524 
X-CRM114-Status: GOOD (  27.85  )
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

On Wed, 2025-09-10 at 14:58 +0200, Hannes Reinecke wrote:
> On 9/9/25 12:35, Martin George wrote:
> > In addition to sending permitted commands such as connect/auth
> > over the initial unencrypted admin connection as part of secure
> > channel concatenation, the host also sends commands such as
> > Property Get and Identify on the same. This is a spec violation
> > leading to secure concat failures. Fix this by ensuring these
> > additional commands are avoided on this connection.
> >=20
> > Fixes: 104d0e2f6222 ("nvme-fabrics: reset admin connection for
> > secure concatenation")
> > Signed-off-by: Martin George <marting@netapp.com>
> > ---
> > =C2=A0 drivers/nvme/host/tcp.c | 3 +++
> > =C2=A0 1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index c0fe8cfb7229..1413788ca7d5 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -2250,6 +2250,9 @@ static int
> > nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
> > =C2=A0=C2=A0	if (error)
> > =C2=A0=C2=A0		goto out_cleanup_tagset;
> > =C2=A0=20
> > +	if (ctrl->opts->concat && !ctrl->tls_pskid)
> > +		return 0;
> > +
> > =C2=A0=C2=A0	error =3D nvme_enable_ctrl(ctrl);
> > =C2=A0=C2=A0	if (error)
> > =C2=A0=C2=A0		goto out_stop_queue;
>=20
> Hmm. Not sure. While section 8.3.4.3 'NVMe In-band Authentication'
> states:
>=20
> =C2=A0 If one or more of the bits in the AUTHREQ field are set to =E2=80=
=981=E2=80=99,
> then
> =C2=A0 the controller requires that the host authenticate on that queue i=
n
> =C2=A0 order to proceed with Fabrics, Admin, and I/O commands.
>=20
> =C2=A0From which one could assume that none of the commands are allowed.
> But it then goes on to state:
>=20
> =C2=A0 The state of an in-progress authentication transaction is soft-
> state.
> =C2=A0 If the subsequent command in an authentication transaction is not
> =C2=A0 received by the controller within a timeout equal to:
> =C2=A0=C2=A0 * the Keep Alive Timeout value (refer to Figure 546), if the=
 Keep
> =C2=A0=C2=A0=C2=A0=C2=A0 Alive Timer is enabled; or
> =C2=A0=C2=A0 * the default Keep Alive Timeout value (i.e., two minutes), =
if the
> =C2=A0=C2=A0=C2=A0=C2=A0 Keep Alive Timer is disabled;
>=20
> one can imply that KATO is running during authentication
> transactions.
> But that might require additional commands, so really I'm not sure.
> Let me ask FMDS for clarification.
>=20

This is specific to secure concat alone, and not otherwise.=C2=A0

NVMe base spec 2.1 section 8.3.4.1 Fabric Secure Channel states that
"An NVM subsystem that requires use of a fabric secure channel (i.e.,
as indicated by the TSC field in the associated Discovery Log Page
Entry) shall not allow capsules to be transferred until a secure
channel has been established for the NVMe Transport connection."

And again in section 8.3.4.3 Secure Channel Concatenation, "This PSK is
generated by an authentication transaction on an Admin Queue over an
unsecure channel. Once the authentication transaction is completed,
that Admin Queue transport connection shall be disconnected by the
host. The generated PSK may then be used to set up secure channels for
subsequent Admin Queue(s) and I/O Queues."

So once authentication is completed on the unencrypted admin connection
as part of secure concat, the host is expected to immediately
disconnect from that and then proceed with setting up subsequent
encrypted admin & I/O connections i.e. no reason for the host to
continue with nvme_enable_ctrl() & nvme_init_ctrl_finish() on the
initial unsecure connection as that's futile and doesn't serve any
purpose. And that's what this patch is attempting to do above.

-Martin

