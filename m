Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8656FCCA476
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Oct 2025 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LXAk2vNpOi2a4GZEEdq+/3BrMz7MdeYNSazlKM1phvE=; b=v0OxUADbaeCLGGcJH4/vkGXkiI
	VL+1BD7HS3lOHlfufq/NhLkcKfT1ve11jeYWlrPioHIKhQuU7a0TJFvV91eQI3qlTT5wNJR5H+HjM
	5oz2VR+h2Vv/955qY4YkGlGde6SS7IDtf/8aT4CQyI1BH+H8ODQELHrcBXi858a2sbS50pbPLliQz
	9g5lfmvsTnb+kUMDolnp/djJNJ4pnMAk0iPdHuImvHIBLClyVkoUxdCif3XxKcjDWqK1RyHbPK11M
	gv0/dc0ROzhxwWrdbioCJ+3l/xHLMNn+j04d9b0Jga7hQPcOeWsPKAwKlTUmnK8mbb10vR0U2R7l2
	jYh3a8Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v63wO-00000001heZ-01JX;
	Tue, 07 Oct 2025 09:25:04 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v63wK-00000001hdY-34Qa
	for linux-nvme@lists.infradead.org;
	Tue, 07 Oct 2025 09:25:01 +0000
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-b556284db11so5707301a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 07 Oct 2025 02:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759829100; x=1760433900; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LXAk2vNpOi2a4GZEEdq+/3BrMz7MdeYNSazlKM1phvE=;
        b=MRz0umGhy9PBNwzWl4An5zy+4s1HuNdNX4HTsYzD/n7zGqYup6uwSp4Lj8Dj2QLjTw
         Dqz1TiumeYBY319dtki7df3pXBCiBKMORYaW9OuVkPpxF1WBSJLbyr9tARJaVutCLC+Q
         wUsrFAQMXh8J6Igxuvl+ARNbe3kX+KEac1PAc/JGU4T9FbI1oEU0imQCiOsJjsX0ZrRj
         7HNVmOpqnN/MWuh6vmjFLc+fhOKIY1lWyCAi+KoB95gQsimlA5qEH2nDPA5s+bAaQMs0
         MYN3h2fIdsK8WMYo6Ald/gVV3GyeJx9+wOut+uFEqYqPXvx9rA3uSxmVjpQ7OGzddwsp
         DUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759829100; x=1760433900;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LXAk2vNpOi2a4GZEEdq+/3BrMz7MdeYNSazlKM1phvE=;
        b=KMiFwdDJjMNgKmPnHMyaaWF4VYalPTVmbxe5rH8eUr/NNhY7HxWNBIdIWVc2INJtPF
         EDlW3PpsBJMLI7q8kuN1P4xBI/Q5VjzOzjupKLlM78XnCvaC66VJh/Fm7tW0URTmWk2O
         Q8DRSnyrAXBdEM4aAtmtXtXsolUXPzNwckIBOru52UAsrT/lRrqbDvrEVxH8yBSaCsj9
         soWtJebY1XzBOtOPYd+ZOR8HdCDLCMXPUAXuy9mWfcIrjt8oNg98qbvs2SqljIz7Diec
         UCLjjt9IIft+68weBMCmFi1V0pifwLH8txx9JaRcC6r0FO60/4q0CoxGabCVCOSZUQyZ
         cc7g==
X-Forwarded-Encrypted: i=1; AJvYcCW4At58LLQny6eOtS9au72pYo0jOlXokfPSjxqt8GGv8yBPt9SJbkJhTy0gL5q0htFwRwpAjcsJkmuA@lists.infradead.org
X-Gm-Message-State: AOJu0YzcoWgdyoRpieMMsm+qFH4JeDSBzGirwSM6X1c4NDe0vk7/Rg/u
	TBwZdIf+NRLdYH4qjfKFKgMwuwVF8IncPDeMUjkPeEYsFlZ8M5MHLpHF
X-Gm-Gg: ASbGncuSA7ms3h/zlJlQ5+wnMI1T39tVW9zm1hUBv0+hGW9e8AYDH8MQltFJmf1mp8o
	9WsLvt0FODPxRcFLyquMNkrSu/PQIgt95MphXjWtONBbAuVOdZ6m4KkyZgGfl4W/yf2GrXaM6r/
	eizZNJ/l6w4ZxZD7qA6M/BiSjz5UOi1u0er9zwT2YBXpAOfWV8gtDVVhFqWWy1X4foLEC3cSMRF
	4xxAqEMo9kLpc49mXpu4RRp0/539g9h/QGRYwEp7Kc1gF9IEMx8vsLDGM0AEvyp6f2X/ZlqTdTe
	lfTn+zUG8D1W01ESuH2MPV0TH82lJ22brt3J2fIOzGHrrVIvX69KZXtBszWO/b5YNnvpL3nuVI8
	4Vp4oURhYS2t2B/vh2VC1iLpxrF2i6m6bm2xs0HhLHiU+GPs2IK3wgW0r/6aWn974K0CRwf9ehM
	az
X-Google-Smtp-Source: AGHT+IH8IaODEbFJZ73jU5YNNWrbKeRhGSBDhqmPEMfJXu/w4VpklqvjWqqlypiPmg3Qz+KDVUviRw==
X-Received: by 2002:a17:902:ce01:b0:24c:e6fa:2a38 with SMTP id d9443c01a7336-28e9a606f2amr222264685ad.25.1759829099825;
        Tue, 07 Oct 2025 02:24:59 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28ec57a2dd6sm33737055ad.67.2025.10.07.02.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:24:59 -0700 (PDT)
Message-ID: <339cbb66fbcd78d639d0d8463a3a67daf089f40d.camel@gmail.com>
Subject: Re: [PATCH] nvme/tcp: handle tls partially sent records in
 write_space()
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, John Fastabend
 <john.fastabend@gmail.com>,  Jakub Kicinski	 <kuba@kernel.org>, Sabrina
 Dubroca <sd@queasysnail.net>, "David S . Miller"	 <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni	 <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>
Date: Tue, 07 Oct 2025 19:24:53 +1000
In-Reply-To: <0bf649d5-112f-42a8-bc8d-6ef2199ed19d@suse.de>
References: <20251007004634.38716-2-wilfred.opensource@gmail.com>
	 <0bf649d5-112f-42a8-bc8d-6ef2199ed19d@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251007_022500_802621_4936EA2C 
X-CRM114-Status: GOOD (  21.09  )
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

On Tue, 2025-10-07 at 07:19 +0200, Hannes Reinecke wrote:
> On 10/7/25 02:46, Wilfred Mallawa wrote:
> > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> >=20
>=20
[...]
> I wonder: Do we really need to check for a partially assembled
> record,
> or wouldn't it be easier to call queue->write_space() every time
> here?
> We sure would end up with executing the callback more often, but if
> no
> data is present it shouldn't do any harm.
>=20
> IE just use
>=20
> if (nvme_tcp_queue_tls(queue)
> =C2=A0=C2=A0=C2=A0=C2=A0 queue->write_space(sk);

Hey Hannes,

This was my initial approach, but I figured using
tls_is_partially_sent_record() might be slightly more efficient. But if
we think that's negligible, happy to go with this approach (omitting
the partial record check).

Wilfred

>=20
> > @@ -1306,6 +1313,7 @@ static int nvme_tcp_try_send_ddgst(struct
> > nvme_tcp_request *req)
> > =C2=A0 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct nvme_tcp_request *req;
> > +	struct tls_context *ctx =3D tls_get_ctx(queue->sock->sk);
> > =C2=A0=C2=A0	unsigned int noreclaim_flag;
> > =C2=A0=C2=A0	int ret =3D 1;
> > =C2=A0 And we need this why?
>=20
> > diff --git a/include/net/tls.h b/include/net/tls.h
> > index 857340338b69..9c61a2de44bf 100644
> > --- a/include/net/tls.h
> > +++ b/include/net/tls.h
> > @@ -373,6 +373,11 @@ static inline struct tls_context
> > *tls_get_ctx(const struct sock *sk)
> > =C2=A0=C2=A0	return (__force void *)icsk->icsk_ulp_data;
> > =C2=A0 }
> > =C2=A0=20
> > +static inline bool tls_is_partially_sent_record(struct tls_context
> > *ctx)
> > +{
> > +	return !!ctx->partially_sent_record;
> > +}
> > +
> > =C2=A0 static inline struct tls_sw_context_rx *tls_sw_ctx_rx(
> > =C2=A0=C2=A0		const struct tls_context *tls_ctx)
> > =C2=A0 {
> > diff --git a/net/tls/tls.h b/net/tls/tls.h
> > index 2f86baeb71fc..7839a2effe31 100644
> > --- a/net/tls/tls.h
> > +++ b/net/tls/tls.h
> > @@ -271,11 +271,6 @@ int tls_push_partial_record(struct sock *sk,
> > struct tls_context *ctx,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0 int flags);
> > =C2=A0 void tls_free_partial_record(struct sock *sk, struct tls_context
> > *ctx);
> > =C2=A0=20
> > -static inline bool tls_is_partially_sent_record(struct tls_context
> > *ctx)
> > -{
> > -	return !!ctx->partially_sent_record;
> > -}
> > -
> > =C2=A0 static inline bool tls_is_pending_open_record(struct tls_context
> > *tls_ctx)
> > =C2=A0 {
> > =C2=A0=C2=A0	return tls_ctx->pending_open_record_frags;
> See above. If we were calling ->write_space unconditionally we=20
> wouldn'teven need this export.Cheers,Hannes

