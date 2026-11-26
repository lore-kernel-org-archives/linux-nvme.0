Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FDD606A336
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Rr5CeLlM;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iIE9+hCX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=OFLHVUAo3FlFAtehQFPOjKyjhG5VjODsSSnSDvugi8s=; b=Rr5CeLlMo/R+hO
	LhjWiiGqJ3AHsmI2XW/o7YqL4NHdwwFdUs2pc3BrUUPdUbtfpWoM6nCot18LP4j6Du/Dvsq8lfGtl
	pF3BMOKmbPZwvqWLz7uLbmEy+AefYMlaQ9ojsmJu8pHes3rCk71zsa/q5jrxlIlS/+y8aCZeyVo10
	Kkkg2pSstsX3xVBYO89C04kdMYuo2XQBH8u8HHZ7SUx8TaodsRd6U3O/YUZ9Kchwoz3I8HQg/TX91
	PrYhObZit3dMb9FN8nphuyJ7g5TjMMVfhXpGqcwm9LPQzJn3ceKT7SyzdY0sM6DZeiPmnB1XfclR+
	Vdzx+HXLZ/U9WSkuwxWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWWOV-0000000Ci4L-2J2z;
	Thu, 26 Nov 2026 10:07:59 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWWOS-0000000Ci2t-3ezo
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 10:07:58 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-c50d3ac6b51so1390443066b.1
        for <linux-nvme@lists.infradead.org>; Thu, 26 Nov 2026 02:07:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795687674; cv=none;
        d=google.com; s=arc-20260327;
        b=BzjYRRmBhccje94pJyJ/c9FqxOIqEiqnAJsNPZunUCtxpBNlu9l2Xv41V3DL8R49Fy
         cwwLYeyHyq9Zll4yoVuYSgkxBNBvunCvJdTM50hYUkXMDQqHQ6x1MK0DvMrOEQQeqOUS
         qNI9ZVJWjr9OO21jLQhf/tQkSo6486+ESZH43HT8wts4HOvm51wL0Fw8t/onqG+i4LMO
         JjV1LSv8wbtLEusRUWQv1EGdh8NqM3UpSKgck2WMgADkinRK/orKt96eRIcq0n/0zwXm
         STNAAMOvwBgbUl+JfqxRvx2yf0QJyL8YW7KNNLgwsr6D/K8gzWih79OekD8hU/mUdVVX
         v+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OFLHVUAo3FlFAtehQFPOjKyjhG5VjODsSSnSDvugi8s=;
        fh=lOY3102ceXUBWDbwOzC2tD9veuTzsGr6IV3ieVP/XjE=;
        b=Cz1CX/5f3jNo+1v9bQHzLK4HN/rYawij/yRm9a5LfR6XeIDX9J2CczhXr2pi1x+HRL
         zxTFnASwQeVnixrQb60SoFrdsLxCzugZA+vLUss4yl9r0d00GSXK6s/lGMT3mgpSNYBd
         lyW+WHPP78OfanXqiUtxry3BsynU2xfC7/LgUA7/ZODc1D0mYL1+/n3lhRFyfmsUfep3
         MXIFHIYbo0PVa351rtynIqbg37bxLkn4eJ+kbq59PyTsV7V/LqlUE7kLlttIANUPqO9R
         6yGqau4CIEwzNVl8LV/tQtszsRCn/jKBItT6XFIHWqP5n2MLCDd9/ObdBcgcKLH6CVQ2
         qWlQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795687674; x=1796292474; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OFLHVUAo3FlFAtehQFPOjKyjhG5VjODsSSnSDvugi8s=;
        b=iIE9+hCXA1rp3HKkQvAEwYrBullwjr3UAmJAwkZHoiNk+J0ToyKuEWGISrqgpflL6E
         EMNP+spbhHGrTJeMuk1L0fteXc3aTLYgP1BqrPZqv1Qo547Fi/2EP4L15mvWv4QpOL51
         DeWVS8tSuQtV7PsFvv8AvH14xLJnbxM9v6f/Uun/JAUJPvH4kTI2zKgJzmD6sJDtVLtt
         DVuVYG0CX60B7xWHrupjadKj36OmsqG4dMnBfotC3ifBlff0y27kopFFpsLzC+H/NEzs
         DA6Wez0z67Pa/3OISt8A6KoxQIJQdQdKYkuyuNENNWBl3b8Zg1djC4z2BBrxtmLlpPk1
         Ui2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795687674; x=1796292474;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OFLHVUAo3FlFAtehQFPOjKyjhG5VjODsSSnSDvugi8s=;
        b=a/jL9Httrvm06havEy9nSKiUZ65WahpScOMofQROLCKIDDWw6j9eK1PwIr7441EYOD
         rvE5Aq1Yi7nWTbeH7q+wdbhUSGgYe5/xAwIcs3w4J79qeDYdT6JF7B7YE07+HEJv3nGY
         FEE8vo5U7u62iMAyYCpDCXURKT/MqzbFXgaWTQv7shcE/7xSpuMp7FKzQkwWi74VYhvn
         hZy935hc6el1Vvk9LlwDOjqAmGn76TqacnwrBp+NWVmMySkX88b8p7GH9F4gyMTftvu6
         DmvtkfYZVO47iUOTH7tQ64S24/2JtTjtYg51NcgPPGnDzWFoI2cSos9opMPb9iXUQG1H
         3cDw==
X-Forwarded-Encrypted: i=1; AL+hErFFan9DhRwgkWlzbk9mciYQAv+jwrxPwGP12SmukoE4qYJ/kFNQWHsqQU4eFeJK3YvpsB6bzw4t+F+2@lists.infradead.org
X-Gm-Message-State: APuU4Z99m20EcUhsryF9jABh106ITPXWngI/Pxj8MYjfO03BGs/+ZQun
	twDZmtbVIEy4QUTlOiunSry9dYDmdDgEkc9hd6y8bU89OaAeABuC8Ilk0JzDFsub0DRwosTFNX8
	GQwnSmuUwx+91QF4hgo7HPbFg2K5jNrE=
X-Gm-Gg: AZFdTZd23JSb5elNixjCDH0576wx499e2lFbYAbn5ii/Vet3udbt1XJt7shwXoU9Vn7
	zQ8fjuZvYiSTubM0j2Ij35i/csKYppNIYZihngFU184qcaiL2WUD4ATQlNXoQX11oq6qlZACEcE
	y0JGwxmUGWcJJJ0m9UhaqOdee/bU/0yJOW+Xj1ZEt0h+j8MC5N4Gx3R/mJd02liIhLBNooQ6CRJ
	pOe5IfIth2+YOEoUnWYU/rK2s9C8lra0elQfedgBXndVIaKnJ7Qc4v7LvoirGwkZsAjwGQPG3N2
	G5RfdZzoWqZrGJgF0wihI+B0RcU2FWgu2UIg8FBC9eugJS4Z8/gvpiNV1Ia4EMVNMRiBh3rjst+
	VCdbdB/Nm19mYbDrtRUg1ld+qckDadxEQmCanluL6g36rQpD3V++DtCn5vQSoAdOCOxQs7g8MyE
	jy0O2Us5xIcHX/VCwtJw8=
X-Received: by 2002:a17:907:a88f:b0:c51:45a:1a5a with SMTP id
 a640c23a62f3a-c513a1d1d4dmr1712012466b.0.1795687674332; Thu, 26 Nov 2026
 02:07:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016141208.2641974-1-e.velu@criteo.com> <atJXYHJa4jkUWJmP@kbusch-mbp>
 <CAL2Jzuz1qFwLSA=iivp5qLCTL6-4rvKmvFzJbOQzjPu6j_7Y2A@mail.gmail.com>
 <atJeazM_rJ0uj3vt@kbusch-mbp> <CAL2Jzux8v6zCxfcdd=MY5n0zQMVSa-_8Lki9z-fz7bFShNf7vw@mail.gmail.com>
 <atJk_2FmzjUZYO_Z@kbusch-mbp> <f665dc3e-fc5c-4352-8e41-a46b7ae97946@criteo.com>
 <CAL2JzuwuZp0gg1D7wSn7cdgpnhotnuLP6YpPd-SrdVyqhkeiJw@mail.gmail.com>
 <atqZmctbU0siYmVX@kbusch-mbp> <7fec6534-9e57-4041-8699-72c5950c7e2a@criteo.com>
 <auId5RuBhMFGirJ1@kbusch-mbp>
In-Reply-To: <auId5RuBhMFGirJ1@kbusch-mbp>
From: Erwan Velu <erwanaliasr1@gmail.com>
Date: Thu, 26 Nov 2026 11:07:41 +0100
X-Gm-Features: Aa3M54olkR-cFqYgfCrRKXNlLLxbmmF0Yq46YOc53exrFo_-QVGBX5tajZfE7sM
Message-ID: <CAL2JzuyZ9C0pGoBR6kBD1p7Hn8DOBVL_XEkENtNqNmad_GdTGg@mail.gmail.com>
Subject: Re: [PATCH] nvme: honor the volatile write cache enable state
To: Keith Busch <kbusch@kernel.org>
Cc: Erwan Velu <e.velu@criteo.com>, linux-nvme@lists.infradead.org, axboe@kernel.dk, 
	hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_020756_930107_BE166615 
X-CRM114-Status: GOOD (  10.17  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le mer. 28 oct. 2026 =C3=A0 17:08, Keith Busch <kbusch@kernel.org> a =C3=A9=
crit :
[...]
> > This patch is really about matching the spec and it would be probably a
> > great positive impact for many stable users to benefit from this patch.
>
> There's just a gap with the multipath head: if you start up with WCE
> cleared, then turn it on, the head isn't updated to indicate flush
> limits. Let's get that fixed, then I'll queue this up.

Hey Keith,
Any update on this additional patch you mentioned and status on mine ?
Erwan,

