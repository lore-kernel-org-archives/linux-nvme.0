Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD0DEEB580
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Sep 2023 05:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bFQ0t0uD6xgDoywgg3aN4cVqH93hmn9yTMWxAqceJW8=; b=RtQhsz/i9OBfUq2m3+yUrMpJnk
	d6fUxPVP+rsz+n+FMM6jB516rIApmxZDBgUKoftthBu04e6exA8c436KNGVAhOBvIQtv4HGdZekj3
	N8pyvehMVZipsdqHsKVYKKeCZ6Zgz7RbbJaRUpYi/uCyvZqDizuAj9BIsE9Hq4naysLe0tBFczyxH
	9b6mjdXKT7ne9MHcEbX+2IrvQyfn4NyLLxyudhGqF6onhxvYFSBr/Q9DLr4YxWwHuUSIxPrYr9puL
	BF+b41Db2+Ny6ZND1/IjafbeYTygP8/b2afKaEYcl79sp8rtJS+buzCZiY9NaJwywpBSbFskyD5rA
	MM6JZ0Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeqev-00F349-1O;
	Sat, 09 Sep 2023 05:37:29 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeqes-00F32u-0n
	for linux-nvme@lists.infradead.org;
	Sat, 09 Sep 2023 05:37:27 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68bec3a9bdbso2150456b3a.3
        for <linux-nvme@lists.infradead.org>; Fri, 08 Sep 2023 22:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694237845; x=1694842645; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bFQ0t0uD6xgDoywgg3aN4cVqH93hmn9yTMWxAqceJW8=;
        b=EsVgNOuq1pVa7J1t4F0sed0IwGKkZhC/K2ovqyxW1NgZZmN6HxC6aaEelNYDVZIxqS
         /Owvs4wGBotd8tuHyRgsH+IQU8FP1lQmBrp7ksduvQ8u6GPS/filAJQI08Y3TzVkRnOm
         P1YwqBpKqMuT60hJRl2yxyWv1c6ZspuZYLIViO9HXx9o5A3N4kCDTnJltHXfXl2os8b+
         qWmgbnTsWAHcHz8sQ9jE7sIEGtY7zZgcDWGfZCK5KmqzuqC0hn5nKzaW4Qhzuluy1NXG
         CkL7hRa+hYMSL2VweIenjS10/zGOt6nJsUwJqRno4qtUusq+rWOQGg2f2mYP85lh19ST
         0+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694237845; x=1694842645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFQ0t0uD6xgDoywgg3aN4cVqH93hmn9yTMWxAqceJW8=;
        b=VOgV/TCwwzilFTjmFANMz9vkCNkjMeCMiB+B0qoOjVHD6ZzaoR2kVF+EsthCwUM0IR
         DSswcsSkXaCTlwf+MFP3KjyPSN6JMTJ3jAvbmBtrz0Uir6JHF1S+0GSYlPkPoHheykJN
         WOF2oBTcj6cLyPAGCmaEC6BZZqrQJ/gS32o3ykKu388L2ezLIBvYyGaKVbq2k1gDsLRy
         R5udHdKdxfrRjUCtuSqP4gX2wCd9Dqop6+s/vlofSIYT20ydU/BxvLzAVlBLpE20Tc4Y
         CYcxtON3uYRPIE9fJ0jBeZ4hqWY2L028sAsuuAqzsvD04Dj8T9b4olVHNXXXeQFqow0W
         UUzQ==
X-Gm-Message-State: AOJu0YyqCSysbgc3VVihNhiAy6XS+iODUNykZeICOISieEVO5ZYHAaTY
	ul1ZIXa2fNY88Ap3Y9bGxeqeLaW3AWM=
X-Google-Smtp-Source: AGHT+IHNFDByETjzv4HPnQxVupj6RSk7YkzviBjkYMWjW45k+/RS05dM1OIhmQeWqnE91WNyi4a92g==
X-Received: by 2002:a05:6a21:61c:b0:14c:e089:94a8 with SMTP id ll28-20020a056a21061c00b0014ce08994a8mr3788602pzb.27.1694237844670;
        Fri, 08 Sep 2023 22:37:24 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id jj18-20020a170903049200b001b9d95945afsm2456479plb.155.2023.09.08.22.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 22:37:24 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id 5F1519A5D462; Sat,  9 Sep 2023 12:37:21 +0700 (WIB)
Date: Sat, 9 Sep 2023 12:37:21 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	shenlinghai@163.com, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, dwmw2@infradead.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux NVMe <linux-nvme@lists.infradead.org>
Subject: Re: Fwd: Ubuntu 22.04, "nvme list" will hang for 60 seconds after
 "nvme subsystem-reset"
Message-ID: <ZPwEkVraLm9WIkYK@debian.me>
References: <8edde583-2b5f-2332-e59a-f1f4688b9e40@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MPojfPQaeXRUiCUh"
Content-Disposition: inline
In-Reply-To: <8edde583-2b5f-2332-e59a-f1f4688b9e40@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_223726_291876_E81AC992 
X-CRM114-Status: GOOD (  10.02  )
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


--MPojfPQaeXRUiCUh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 06:41:01PM +0700, Bagas Sanjaya wrote:
> #regzbot introduced: 1e866afd4bcdd0 https://bugzilla.kernel.org/show_bug.=
cgi?id=3D217745
> #regzbot title: listing nvme devices hangs after subsystem reset
>=20

#regzbot invalid: regression reported using downstream kernel

--=20
An old man doll... just what I always wanted! - Clara

--MPojfPQaeXRUiCUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPwEkQAKCRD2uYlJVVFO
o5XAAP9HgtdqEDXnbtYY8DMvg7aMO62dgHjsURSMH2FST36TvQD+IMVvnH2iXslb
028fbd/9PzCQCfhZLz5BrPf2TWQ5WQk=
=G5rm
-----END PGP SIGNATURE-----

--MPojfPQaeXRUiCUh--

