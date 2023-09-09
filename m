Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2170EEEB580
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Sep 2023 05:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T9QdRpHmKF7Dl0phviBz7WSuqViIRbheRKqXILmxCEw=; b=QaD0gb0SzdWpHFmivg7fKkj1Mm
	NsS54LnKxsbPwiUJTRJtZg0g71OocU0WUwB2kDENbOXJoVSNXcCdcQmtXaqQ7fY7sL29IfAmnQHRG
	3CJOzWgUFjz85ydrNVtT0hUTWNIbUL9GZIMMsa5xyrqhZCSeD1N1Ibo6FMUnM0/V0hDYd35/srAqO
	IpDH/M+F+KwcUrahDBzTntdLSGO/e3Y9gHMPWADKCHH6L2fGkZJ2AA/KIeTWEJCThgpqt5XXiHlYK
	ST/jPxvA4P59usyRhxin+LjYHvbfNZSLNFlJVUhQ/4ttk0r8ITVLFN5RxHD1QvY66uV0J579U8+mo
	QL8LxOyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeqdr-00F2wg-35;
	Sat, 09 Sep 2023 05:36:23 +0000
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeqdp-00F2vm-0g
	for linux-nvme@lists.infradead.org;
	Sat, 09 Sep 2023 05:36:22 +0000
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1c50438636fso1869871fac.1
        for <linux-nvme@lists.infradead.org>; Fri, 08 Sep 2023 22:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694237779; x=1694842579; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9QdRpHmKF7Dl0phviBz7WSuqViIRbheRKqXILmxCEw=;
        b=dqO3YiLkwU90gxAJh9gavdY+qc+EGpEUyGHRX6KYRXfGwETpmRy81wCdX3dqE9zbbp
         OgRbbyZWdXAa5155RXQmr9Let4VjN0maZZh3Q8xDO7laBeaE7iUXBUkSq1FTZlAx9rBt
         +NyYCKu/EE7iVK3Fg7y5Ho+3UMQsUZty8hRncU90xV/ppWZExKPRcbz3UjhEXWxwg7+f
         vbVgDqHjKqXdbuEVTCLbzZdFL4aJkcYTYi+fzLKCo0MzLN2PV0UvZ2dya7hhrWPXnaIO
         iZ79tci60ayY4grMNftsGppYoBs19Y8JFrO4Iap6Dwn4ndHV7qmE0hUXR3Vp5wN0MdMC
         My9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694237779; x=1694842579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9QdRpHmKF7Dl0phviBz7WSuqViIRbheRKqXILmxCEw=;
        b=qZdYhKVtb7glIeskcCIBT2P/KEQOIQ3CxWTgBf40tSwMtYF96T2Pt3zenpc8es1jrG
         LFpG5mZDqKM3GugS8iRHn2vnyivFi68c3xX6VcNwpj1wjdcEQU2FHr8bl1aKD5vs+T8/
         A7JfXRF9fLrg1WKpgTuKO0tI1FgbR72ev6bA+H2vDakqkJLdk/Ug+ddC76eLAFLu0ftu
         hPIHjV6frRy01aVi9kSoLo+YAqFFx6Nn4F6ZEtC4ilK2gk4NfLyziP9KSsKtnDWRRvhK
         Vg9H5kGdvffi5A+gTa/ySoCjo/Sc50J62AJd4fEyv5gE2Cgadd6JJ4kiP1gHmvPLuL/A
         TwlA==
X-Gm-Message-State: AOJu0YxTKeAns5ZGap5jNk7Ykp+Lx9lWRr6YSEkX4JHKHdhJE4mOig6+
	fMOqsZTfvvfIMRsgm2rQCGo=
X-Google-Smtp-Source: AGHT+IFsBaaCIIBHfXy6K9EBhaseuwvlm/ZF7VeyFi6SRkSkOxHCXNBxcjku48ptQPAr+1Rdzbe1Sg==
X-Received: by 2002:a05:6870:fb8a:b0:1bb:6cca:3468 with SMTP id kv10-20020a056870fb8a00b001bb6cca3468mr4623544oab.47.1694237779496;
        Fri, 08 Sep 2023 22:36:19 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a01d900b0026b46ad94c9sm2312333pjd.24.2023.09.08.22.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 22:36:18 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id 165109A5D464; Sat,  9 Sep 2023 12:36:14 +0700 (WIB)
Date: Sat, 9 Sep 2023 12:36:14 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	shenlinghai@163.com, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, dwmw2@infradead.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux NVMe <linux-nvme@lists.infradead.org>
Subject: Re: Fwd: Ubuntu 22.04, "nvme list" will hang for 60 seconds after
 "nvme subsystem-reset"
Message-ID: <ZPwETorRO60QGen6@debian.me>
References: <8edde583-2b5f-2332-e59a-f1f4688b9e40@gmail.com>
 <d7290782-bf72-3a65-26fa-b58e75bcae2c@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NwbKn5UmL+2AYyp/"
Content-Disposition: inline
In-Reply-To: <d7290782-bf72-3a65-26fa-b58e75bcae2c@leemhuis.info>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_223621_271890_008FA1E3 
X-CRM114-Status: GOOD (  14.53  )
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


--NwbKn5UmL+2AYyp/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 12:30:30PM +0200, Thorsten Leemhuis wrote:
> >> root:~# uname -a
> >> Linux dapu-Star-Lake 5.19.0-46-generic #47~22.04.1-Ubuntu SMP PREEMPT_=
DYNAMIC Wed Jun 21 15:35:31 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
>=20
> Bagas, please don't forward reports to the developers (and also don't
> add them to the regression tracking) if the report is about a problem
> with a vendor kernel that is known or likely to be patched[1].
> Developers otherwise will just start to ignore your mails, as you are
> wasting their time.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--NwbKn5UmL+2AYyp/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPwETgAKCRD2uYlJVVFO
o2JTAQCJLs9Rku/9XRes2BQ/A134vw5Uq14Ob4IgfIZtAQclqQD+P+WKjV56tT5N
6XJnoVyWpHG3yHNHWtMHvwS0QKpfoAY=
=Pizn
-----END PGP SIGNATURE-----

--NwbKn5UmL+2AYyp/--

