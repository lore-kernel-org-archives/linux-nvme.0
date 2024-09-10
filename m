Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75540EDE996
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 02:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oo9et8eatV5v0o5cwFeOQ7zBYoEYomcd/MQiVgwvVEs=; b=zVnngJTpnh3+oC4TQuIL2ZaXP0
	VgDnnFyexvSjBo81kLFr7bH+YrMCVDlbFhI7pfWlL/FGezDNVc946/i7yezRNcPAsjtMBZXOYxYrY
	m5D8Jnay9rxb/LZx5s2nCaLW+Znqg7CZ6OsbIvKxbdZBn0cR/cfvA4iHxpYVEBx7P+J4vDJlc0/jS
	gfe6gkR/AVi0BjfDPXSJ0M+Ed+1OGekppz+RIedz0LmYXxyulyjhJV78t+mD87OIGA+0zqwCtwdOK
	KAhQCWX4IzVU0L5U2m8r3W5lTU8iRqhLrDQ4jJcQ0NGz7Iz2wdgTfakENn+kto1RCdWgKcoB8B7Yp
	4QS8edVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snqDA-00000003tkp-3EN1;
	Tue, 10 Sep 2024 02:02:32 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snqD4-00000003tjo-2sol
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 02:02:28 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1fee6435a34so1910375ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Sep 2024 19:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725933746; x=1726538546; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oo9et8eatV5v0o5cwFeOQ7zBYoEYomcd/MQiVgwvVEs=;
        b=IMLQ1NW2RuW6ZZ7vlmHzRlIC4FNZRrxcVQuhOVMDvapZq94xuSFFAepCrTPoEMQSa3
         FhLW0K7rmzVP7v8C3T0cCRaKKIQWtp5JjWzQcch1wx0GWRiqL85+If+5opQGTteWvUps
         5w3esj1UC6+BaGim6iJGzhEvfrqP9EjSJlznlObo2hVPWkFTqkAx6bcBJhKvwagVyDSu
         2Wxim1e4GgSgIBv2xcltcvUGNJknbs6AzFqxTGmOIVjbrWbvJSSMNGesZMAVew+rvKzG
         X6H6jSC2ihQmFLFVhGbscVDHECUDMj9dLBIEAklc9QsXu3oOFhSuQC5kq2MShndHdrZu
         KcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725933746; x=1726538546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oo9et8eatV5v0o5cwFeOQ7zBYoEYomcd/MQiVgwvVEs=;
        b=UXh+na/VYArq0kj4eoMYgZilUxr7HPsI2PFaZl/higk3xBFy9XRu8ewSDWGAMl5cRD
         XRT0/UCj0rMQlDG+4FaJnJMa9YNA9frNqwShG6hG5C5x1Zg3sgHiTJnXnRTb5O4lXjbd
         NBbxPlyhCO6VlVJMbC5a1mGO/CEc+t4r6T8HdmDI23rMoUHY/8sp0sw2uenI/I6tiMJo
         I7woTVD3pIVHPxQ71RL39+RWDevOcL/J0/6cliIwduhgo5mjkfvfnUzPRcOy3RdpaLN8
         Qv7WlaZqvb6ruV3CKfqEuSCYSx0au3XwCRVJ+famlO1BWSFPO8CvBZG79FYMfNbf4w0h
         tJbA==
X-Forwarded-Encrypted: i=1; AJvYcCV5ekwOTzrJsOh1/Ww26VXEFFDhNBHlnJosju7vKj7uZuF4lw8gO5dLG5BIq9eXwrmCdEW8W7ae0kBA@lists.infradead.org
X-Gm-Message-State: AOJu0YwC1UHgfQAbGNHQ20uimEfW8xM0use1c2YZWeqSsIG+Q47+v/5z
	h44i0mrMbNlzhHf4YoSAOi4cYjYGUzl7bcMSIK0xMGAaQNb6BEg836vjlQ==
X-Google-Smtp-Source: AGHT+IFE520PjC4tkS5HlvkQJ8Ze/9dl8z9Fj4HV6j3FUw28wJqwGyaFdtwAXDYkof0yQhV5q9iokg==
X-Received: by 2002:a17:902:ea0b:b0:205:2d09:9a30 with SMTP id d9443c01a7336-206f04f1ab7mr124575695ad.13.1725933745514;
        Mon, 09 Sep 2024 19:02:25 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2073c488bc8sm11934125ad.135.2024.09.09.19.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:02:25 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 50E894A0EB86; Tue, 10 Sep 2024 09:02:21 +0700 (WIB)
Date: Tue, 10 Sep 2024 09:02:21 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, cvam <cvam0000@gmail.com>,
	kbusch@kernel.org, axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Typo in the file 'feature-and-quirk-policy.rst'.
Message-ID: <Zt-orTrbAO5bJEKC@archie.me>
References: <20240909200253.19818-1-cvam0000@gmail.com>
 <8734m8h9ce.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BeuglxcILx6Ttd16"
Content-Disposition: inline
In-Reply-To: <8734m8h9ce.fsf@trenco.lwn.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_190226_767022_6BA267FF 
X-CRM114-Status: GOOD (  12.32  )
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


--BeuglxcILx6Ttd16
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2024 at 02:15:45PM -0600, Jonathan Corbet wrote:
> cvam <cvam0000@gmail.com> writes:
>=20
> > location: 'Documentation/nvme/feature-and-quirk-policy.rst'
> > tested: Not breaking anything.
>=20
> I don't stress a lot over changelogs for simple tweaks like this, but
> you could still try to write something in our normal imperative style.

Something like 'Remove duplicate "and" in 'Linux NVMe feature and quirk pol=
icy'
title heading.'

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--BeuglxcILx6Ttd16
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZt+orQAKCRD2uYlJVVFO
o9kWAQDyqIR4IxzJDaRN5ocAdAzJhdpQINXvVtj2T7FJtmWw+AEA6kHe261vKPHS
UTZ7bO7aqiEIS1XGgEP5slT1O7i+cAE=
=ZEWk
-----END PGP SIGNATURE-----

--BeuglxcILx6Ttd16--

