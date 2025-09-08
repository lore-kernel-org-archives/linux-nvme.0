Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D766CA1016
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Sep 2025 18:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CFKza0GDvDgJkR/yFGwy0aAl0UMATCtFfz4gL+KTA88=; b=CqCmSkHa6Zg6+Yx2iG4+YM/qKo
	ETVjpKmsUDFbDqE3J2VUp/oeRW+6XudzUt4yC0I7DtzOEUd8t+0pjQFQo6mQWCJH93OkTCd9WElj9
	bJVqg1XHfQI+iSei/OwnB+N5Oe2vSrDfinfBdU8Q1gBP6uJjHDE1yMNrCjifEsxxeso02Sa09Ro0c
	qXAgkCnEfnnQr+VIVwyrayjb9OH32l5D+m71VnzCkxgKUVIVlf7TiQHVQy4QoRQ1PmRJOZ/pPydqE
	k2Lg8y7BVt9IeQptmCQiBWtd3qjykTSvd9Nu0w8SZTeNKxgIFCMFALpNtiSxzuVmsxVTA70jDOIMS
	3lt1+XNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvgar-00000001YXc-2eni;
	Mon, 08 Sep 2025 18:27:57 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvdV2-00000000KIo-2tch
	for linux-nvme@lists.infradead.org;
	Mon, 08 Sep 2025 15:09:45 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so3463471b3a.2
        for <linux-nvme@lists.infradead.org>; Mon, 08 Sep 2025 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757344184; x=1757948984; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CFKza0GDvDgJkR/yFGwy0aAl0UMATCtFfz4gL+KTA88=;
        b=KxAKp7+ALFtTS04h2wlXiM04Q63yBi/QLmP/UmHksMD8jo78CWttYaj31F0x5BymBF
         TCQITD6VileYJfZvQr79lePEy6Hz9zNRIHwJ/nuzX9BMEOm3KLbr+ehegBNY3ip1Grqu
         PbUL3CuXD/y6cNAWQplx1TyAAXhuclJC+eQhNcR96mVGc3Dprq8y9cwVY1nOIteoNJQI
         vrtkmiIeG6ymP7klU9mOQwsMrjQ3qYUAGjlVgYIbzH12j7I0tuQSvURdJuFcPcBsNZ/1
         FCnX0TIsVPQUDXkfteMCuzNNfu/RitgUU+BiekoDRtAodZyzb4IXbxo57fk2XVtdVSEn
         oHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757344184; x=1757948984;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFKza0GDvDgJkR/yFGwy0aAl0UMATCtFfz4gL+KTA88=;
        b=LPL5OytoKQ2yQAtiK4fJwJiQZNCPNY8dXVL0w6H7Gir7DRY2DXsYRO2p/OanWcvAWM
         S5ktb9fN5TIfV1Brh66aAF2n3TxV091W7OIcFK1oiNSphoaqFJ5NmOUkIdu5MyUr5eLY
         C6Ls1KH4rfl1WZlRvtob01g+0LIJd8V8Pp+7Lv2LpS935rtZXbU0AY7zu3obUBFLOYFW
         Yxoi1eKl7mwIKSTuraxCo2Pm6j/lRIb8iaNx+PmTYq3SwZTnyMjO9uQEktjbmEcZiPvj
         6hFkodkCmJrvk7VS8sD9Xvo2eeF3VhGC9u1hKJoyCJ80uc1Fdn3r9NNtJ2dr8WmGJYCP
         2jDg==
X-Forwarded-Encrypted: i=1; AJvYcCV9zxe6kq8C1LoBPmDP+1KEhE48RWAvKAeDvgzz1NAeOowpeX7fcgAHSpNJm7mLkC5Edu0QhYPvszmm@lists.infradead.org
X-Gm-Message-State: AOJu0YxsPPDIfQssSug6iiWdi7o669eNcJT49Wq5EiY8cyN2r/7Jlm6o
	wgS7UX3AZGHv/3mRJZn9Vyp+jXrNgdJNPsNx7KThwsHvfrZovgk+OgPt
X-Gm-Gg: ASbGnct10i4lARte/crScYGeVQa8Zo/W6toKgJH3U1NdaB3IpBJU3Hcu46vK7BfN7z6
	GfXRySjVxJYo2HfEbC+ze+I3MqElGP2zmqEUcCqDtsf2ADi3swYY+FHeN0hRQGvQpqV9wFxA4XE
	TS9q/kom8AjRkLZgLODpVsXm+Rn7O+etHn4DfEbc8VcuaAaMUAIpKYB67FDioh7ijQIVJJIn0e8
	ZRliaDKh2TNFcWfHrOaLmQ+UaACjcetd7tZWPZMofzvjdqObszEULFsvijvVzDbk5mgLrxhtM7e
	TE8MX/SCo9Pe0fS5obhHTTdOsDSEsD0pgn51oETpWFkzM7AOvWO59VadnJQY99w0BkGygCX7rTK
	2C41q09e3boZXbCT5dfY0Qgi4Rw0McaUm8H1nLDj8Y6OWVrbWamtlCG/2Ix6FiDb8Ioc=
X-Google-Smtp-Source: AGHT+IGp5hwkWr906NGZ0zkAfG8EMxAhVXo8j4hSUKcbP/p5Nnj/IxjHJ+qxZsEPX0DS5ZT4Sf8jsQ==
X-Received: by 2002:a05:6a20:3d82:b0:24a:a45d:7a32 with SMTP id adf61e73a8af0-2534441f665mr11878410637.45.1757344183811;
        Mon, 08 Sep 2025 08:09:43 -0700 (PDT)
Received: from [10.0.2.15] (portal-nbc.netapp.com. [202.3.121.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b522e287103sm3935857a12.19.2025.09.08.08.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 08:09:43 -0700 (PDT)
Message-ID: <9ac883bfce6ac295fb7204c6c5ffb8c8a35fea50.camel@gmail.com>
Subject: Re: [PATCH] nvme-auth: update sc_c in host response
From: Martin George <martinus.gpy@gmail.com>
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, hare@kernel.org, Martin
 George <marting@netapp.com>, Prashanth Adurthi <prashana@netapp.com>
Date: Mon, 08 Sep 2025 20:39:38 +0530
In-Reply-To: <30fc92e8-924a-4d52-b50f-9459ade044a0@suse.de>
References: <20250908112642.3447-1-marting@netapp.com>
	 <30fc92e8-924a-4d52-b50f-9459ade044a0@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_080944_727608_8F363719 
X-CRM114-Status: GOOD (  20.78  )
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

On Mon, 2025-09-08 at 14:49 +0200, Hannes Reinecke wrote:
> On 9/8/25 13:26, Martin George wrote:
> > The sc_c field is currently not updated in the host response to the
> > controller challenge leading to failures while attempting secure
> > channel concatenation. Fix this by adding a new sc_c variable to
> > the
> > dhchap queue context structure which is appropriately set during
> > negotiate and then used in the host response.
> >=20
> > Fixes: e88a7595b57f ("nvme-tcp: request secure channel
> > concatenation")
> > Signed-off-by: Martin George <marting@netapp.com>
> > Signed-off-by: Prashanth Adurthi <prashana@netapp.com>
> > ---
> > =C2=A0 drivers/nvme/host/auth.c | 6 +++++-
> > =C2=A0 1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> > index 201fc8809a62..a7344faab2b2 100644
> > --- a/drivers/nvme/host/auth.c
> > +++ b/drivers/nvme/host/auth.c
> > @@ -36,6 +36,7 @@ struct nvme_dhchap_queue_context {
> > =C2=A0=C2=A0	u8 status;
> > =C2=A0=C2=A0	u8 dhgroup_id;
> > =C2=A0=C2=A0	u8 hash_id;
> > +	u8 sc_c;
> > =C2=A0=C2=A0	size_t hash_len;
> > =C2=A0=C2=A0	u8 c1[64];
> > =C2=A0=C2=A0	u8 c2[64];
> > @@ -154,6 +155,8 @@ static int
> > nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
> > =C2=A0=C2=A0	data->auth_protocol[0].dhchap.idlist[34] =3D
> > NVME_AUTH_DHGROUP_6144;
> > =C2=A0=C2=A0	data->auth_protocol[0].dhchap.idlist[35] =3D
> > NVME_AUTH_DHGROUP_8192;
> > =C2=A0=20
> > +	chap->sc_c =3D data->sc_c;
> > +
> > =C2=A0=C2=A0	return size;
> > =C2=A0 }
> > =C2=A0=20
> > @@ -488,7 +491,7 @@ static int
> > nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
> > =C2=A0=C2=A0	ret =3D crypto_shash_update(shash, buf, 2);
> > =C2=A0=C2=A0	if (ret)
> > =C2=A0=C2=A0		goto out;
> > -	memset(buf, 0, sizeof(buf));
> > +	memset(buf, chap->sc_c, sizeof(buf));
>=20
> 'sc_c' is just a single byte, please do
>=20
> *buf =3D chap->sc_c;
>=20
> Otherwise both bytes in 'buf' are being set to 'sc_c'.
>=20

Sure, will send a v2 of the patch with this change. Thanks.

-Martin
>=20

