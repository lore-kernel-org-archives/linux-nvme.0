Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267D3606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oCRRMOIp;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0RLUpOk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ieHdf5R61hmT44WRQHLcQZnp5moq75ApRgu6I+5303k=; b=oCRRMOIpMQAhJ3Z4TjW6XMZtSt
	ijfc7Yx8RYXyWqU7zD4VATBmuKS8M/W/5IJB9IloqD783kNyYyPa1T8vnH51jzhXyAh7mQQENSm+V
	jq1UdyJXI5qJA7zmhnE0vNS65Ixc9sSv99v151ZrgeMVTeV7RxeOi/mXqaWR4YJEhyt6g+1HY+ENz
	evgD9KHlJLZe0s7G0nY0/0tBp03Nay06Xm/zdjesIVQ2kRQMya7QkoESW8jE6+MfQkClz9tb28+SG
	kzwQsjZONVjQZU83OIpYWRnk97StpElI+56ALTdXuHUm8XAik3UV9xe8KCX2D9iVuJluty9PLVOWl
	GBUr8g2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5fK-00000007PKv-3Wjy;
	Wed, 28 Oct 2026 15:34:14 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5fI-00000007PJo-2GtO
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 15:34:13 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-89f639ba307so479149b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 28 Oct 2026 08:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793201651; x=1793806451; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ieHdf5R61hmT44WRQHLcQZnp5moq75ApRgu6I+5303k=;
        b=f0RLUpOkEqrfL6bSaox817ffvySAX7GytnL0SX2aXXT3Q2cHSbI+uEzI0JJr2m/mxI
         /GhwEUzXhdeT6/C70UJu4BPQtdPzcaw+unxzfoXOz+hQGq+oVN1jYO9IJy6as25UDxbP
         TBIyWjPeV/LhCB3qDVeNIXfQQcwNEsIIrC0EKyw9bdog7ggn9KSsh6w9CyT3sYFjv6Vq
         t/zyKdOriVopIL+Kwpbd9fhr1WNXQkOqInDP8YnPo28yOvNGnH1SM6qmbShKJoyU8XUE
         ShJtFStT2pY8WG/1N7rjaCnGBjMLC2ORJJHnWiziaXnhYUGrz8e9L400UJjKMYidkLxO
         OH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201651; x=1793806451;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ieHdf5R61hmT44WRQHLcQZnp5moq75ApRgu6I+5303k=;
        b=iHsj/L48BMYYke72gzjIJ7DUbN/MC8xeTF8K5r9vzROWFr+SnpiN3EMC3ZnRV0JCbV
         iU69cAB6auY1HEIFi29rO3SZ+f2MyVtdffJ8u4oKvIFLFL0AjAAS7ROUzcThvYHH3S+V
         T5rRgZXm64hF1gGOS02Gt2rTnkMt7uqTU6HN/irZ/Z82kfRs9bxv6ptsPQUQ3Rp0wqdm
         1yXYx45tw9Flqt/63iHBUJGXBwdOgh0Bze+sF8EYlr2hJ003R7CrXIERVJBMSS6U90oE
         7OLkAUMT9BF85CD4zfFDlMJ2MrL3wGsolRUDCRc+kFe9bzcdQABrHxdX8TOr0HpdXXlC
         yBTw==
X-Gm-Message-State: AFq9FYKNg5K0PRKbnYowec6kOWl+zw6qhktYpjldSroAOd3ZxxrG78Va
	YldMoEH8biR2tRdMwVIFrsU2KJr6kztGvrUyt8Xwnd0GeX6++Ciq0aBrXQw16omB
X-Gm-Gg: AYBFou1p3zxWkEDkHPsJ8l6BoH9w8nY7R0350JJnk8zOhLJPfyvPhhFDtPtjArDtASF
	QzsmZslipwh38bJChg87tg3p8Bv+Fkh+zFGUE103twccccmhdySo43gllyCxxifNqfTW7bQr3oZ
	pOcxwb+4uCwCB9cTCKyc5ubBk+nfCMaNpbw3aurLZNLgAD3Q05Py06NGiqLe3OOFxwRd8J75+EV
	2abCVeMmcU/n56cwfYNzp3DkkHi0C54OAOwRKzLE9wOsK5qPtlVuxZHpWanwYNKqu27Wbm7mKYx
	9cv50uPZkkUP/eQj5MNBUKFMeAKcy5ukPwP5L62b4gIeVrNmIuMJHbSpMir0zQhdil/7io9Fl58
	E+CbPe8eX12jY95cITlB9mNDMpajqeO/bF1WDxRZAtSdwBqFwYa74b7omysPWg///sKJPcP7Tor
	bCPhmQi0iQ9/BxrbcnCiBnkXsi6Zl3jRsRgqB2RQuM03BQgN+RMgHrj3ClhCU+XXYsTznKmJ52u
	hLyGxkiBW1yqjA1/JvL4mdWxfqZZrRCo9sffkvuc/5VcbkZEPHVswFIFcnxqhpJ3JVVR0eEVZPA
	VBvSJtFVxV9IYlHafiAkYEfKk2hOZ2zDjbJDIEVUW0/1PHg=
X-Received: by 2002:a05:6a00:3a03:b0:89f:4cd9:241a with SMTP id d2e1a72fcca58-8a6e8c7af4amr2167217b3a.41.1793201650598;
        Wed, 28 Oct 2026 08:34:10 -0700 (PDT)
Received: from [10.0.2.15] ([136.226.242.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6c2485703sm1202255b3a.49.2026.10.28.08.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:34:10 -0700 (PDT)
Message-ID: <7652b5deb5e947f6dfc40f46e9e05db472183b8d.camel@gmail.com>
Subject: Re: [PATCH] nvme: add nvme_is_disc_subsys() helper
From: Martin George <martinus.gpy@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me
Date: Wed, 28 Oct 2026 21:04:03 +0530
In-Reply-To: <20261028145818.GC15112@lst.de>
References: <20261022073144.5239-1-marting@netapp.com>
	 <20261028145818.GC15112@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_083412_577255_EDB43DB4 
X-CRM114-Status: GOOD (  14.93  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-10-28 at 15:58 +0100, Christoph Hellwig wrote:
> On Thu, Oct 22, 2026 at 01:01:44PM +0530, Martin George wrote:
> > Mirror the target's nvmet_is_disc_subsys() with a host-side
> > nvme_is_disc_subsys() helper, and use it for the open-coded
> > subtype =3D=3D NVME_NQN_DISC checks in the host code to help
> > maintain consistency and improve code readability.
> >=20
> > And while here, fix an error message to refer to the subsystem
> > rather than the controller.
>=20
> Not going to NAK it, but the helper feels a bit pointless to me.
> Do you have any bigger plans with it?
>=20

No bigger plans - it's just a small cleanup. Mainly two things:

- Consistency with the target, which already has something similar
- It folds the open-coded discovery subtype checks into one self-
documenting helper for current & future use.

So a minor net improvement rather than a prerequisite for anything.

-Martin

