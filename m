Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8F4D78337
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 17:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TY2RNkMXPJD8Avo9kD2pk70Q+ZVywmDDBAMrAw6djsQ=; b=YHlI9F5dn7Sorvngoit1J6RBS8
	0QEyYxUw+Q1/kmXen+z2xaIAIPevkzjT/pxjY/XBw9NHVcHnKiDj9xis0axQXTCArGXbYVx3UeISx
	8VTkjYn7u/pEHtPJpSvv0NJr/8Ipq0BqoeMbdLu1pPVwyxfe4tXRGcnNYjPwIek31zOOtVxSlUtFf
	Ht1z8e9gHLuTbT5oJdSBE0w5AJsXw+Lc2QDFFttD2/Qe1Egn7j2R50DMKEizxN/qEOjfsGGmKa7Ix
	GRNBO2FCM4Dl9BMuUlLzih41vdWdW5v2ZKTE4tNdAAHe7Rm+Xw0qXi0zp+oYsTMGj01I5xThS+/m1
	Pvvf8WTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI9rL-00000006xQa-1fHY;
	Mon, 02 Dec 2024 17:05:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI9rH-00000006xPF-1wtO
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 17:05:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733159113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TY2RNkMXPJD8Avo9kD2pk70Q+ZVywmDDBAMrAw6djsQ=;
	b=F9wxpvj9Zl5mHDoIDZWEyBLqtiF+3WhFngGnw8BUiEJmX2D+b3yh45OQfdfLZBfbG5Yp29
	VCJ2ZhIAI2jYMvdcm59T/yphqz59goCBxjfpl2WIXimk4h9S+S35T41n4aE8vwKaaoAL8Q
	l1W3jcXdsN9x2g1QPJSQlTHjI0PANts=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-KOktph4EPXGZGEIH0NDtkw-1; Mon, 02 Dec 2024 12:05:11 -0500
X-MC-Unique: KOktph4EPXGZGEIH0NDtkw-1
X-Mimecast-MFC-AGG-ID: KOktph4EPXGZGEIH0NDtkw
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d899291908so41753506d6.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Dec 2024 09:05:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733159111; x=1733763911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TY2RNkMXPJD8Avo9kD2pk70Q+ZVywmDDBAMrAw6djsQ=;
        b=eWhRyH1DZ7Z2ePMfwfrMPRgrXh5YZpKSkTL0+PAiUh2TWP4rhMKCgWnIdgAOFreQ0A
         l0P0fwVRYx4mRDmPUf4JAFwDLeGYKKcQHx5pETzAuG6l7kSG/B19G6lLb0eS1UlzHF2o
         GSfV9MCW8+ifbIbhPgOCRKxt67PjJ31OrQBQkwW8OniyMqQqODqMGysuNN5RB7v/45Oj
         FO/DwxOhK6YL9gRI6hy9T+htfC1mwRG50qOow+1cnMwi9c2jN2Ii2c9lNZfA7veFRYOG
         trEoa+6MRoTOyzCN7HNerwLLAAySpcxyZAG0q6+KtkkZnbe2bxBPYdOE63jFnAQW02ih
         g6Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUKwGXEyNkz9Ep5HkSEbtjy6PlpeUnttYBgZKu2/3XnNcJZo82di3v8YDLEFVQ8zNM3eQOP0wBLF8MO@lists.infradead.org
X-Gm-Message-State: AOJu0YyCG+J9Nsl0x+rt+EulgF0ryEjVB0+h6AWmYLSWMUJpEcbh03NE
	+HzeWMc9oByviZ2FnfdK6KTkSKzMcQNHljJ5F4fz/Y9/CtwcXETet40HcaefnudayEjxw4ps17h
	1WQ5rZNe090cIaY65Y70BwD9HF72E50hHUL/lIoiqXIDAxCQ6USmvmO8cSB3ObLiOdGsEqp6//2
	myC1tEeRwRyhDQlRneTa3oOPmk2tY6cGKx55coffg=
X-Gm-Gg: ASbGncs3S9KQIQbuOl5kPQcRaRG0oRnKVv/UKFygBUyLeyUQycqVkOwkSwZ3DsQBbBb
	EPDiSfH5rtWAcuY2v7smjgdGjd/c5Ujw=
X-Received: by 2002:a05:6214:48c:b0:6d4:c6d:17fe with SMTP id 6a1803df08f44-6d864d791a2mr339245016d6.25.1733159111089;
        Mon, 02 Dec 2024 09:05:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPsLMeCA7wiyfC7KaB7AfgDMZdSETIQyMQz+hhgRNHzWR9AcawpYFXQ4wUarhrKHF5GO3vDo5BqhO6R6YoSv8=
X-Received: by 2002:a05:6214:48c:b0:6d4:c6d:17fe with SMTP id
 6a1803df08f44-6d864d791a2mr339244526d6.25.1733159110703; Mon, 02 Dec 2024
 09:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20241202142959.81321-1-hare@kernel.org> <20241202142959.81321-5-hare@kernel.org>
In-Reply-To: <20241202142959.81321-5-hare@kernel.org>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Mon, 2 Dec 2024 18:04:59 +0100
Message-ID: <CAFL455kHV2ADBs2wUe3i0j00c1SHyKdjs=OeGj4uTZyCDdP6iQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] nvme: add nvme_auth_derive_tls_psk()
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, Eric Biggers <ebiggers@kernel.org>, 
	linux-crypto@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BMMExyc8VuB-5BCLXKuQfqBqo8xMP2xYtrj4aB91KIo_1733159111
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_090515_570044_494784CC 
X-CRM114-Status: UNSURE (   7.96  )
X-CRM114-Notice: Please train this message.
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

po 2. 12. 2024 v 15:32 odes=C3=ADlatel Hannes Reinecke <hare@kernel.org> na=
psal:
> +       ret =3D crypto_shash_setkey(hmac_tfm, prk, prk_len);
> +       if (ret)
> +               goto out_free_prk;
> +
> +       info_len =3D strlen(psk_digest) + strlen(psk_prefix) + 5;
> +       info =3D kzalloc(info_len, GFP_KERNEL);
> +       if (!info)
> +               goto out_free_prk;

ret should be set to ENOMEM here

Maurizio


