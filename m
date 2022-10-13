Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00984C433FE
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Oct 2022 05:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2IPrBznXbTQxoJPi7gWHCx7J9OvV+m601cNw6Qc6L7g=; b=Z11rLd7XDFT0UKlg1XyGK0i8kn
	b78UlR8S3o9iHb99NTHJK85Pl0cvyTA2zPv9Q+GI6rc8UOdqx3zVlfCIZPDPv1SJyt2eGacK29DtS
	cYz0/wkKFi3kzgh7TC1MTDl1A+ZgkkN9ukUypgqrBHj8Ss5qe5MXj2liNfiSWIUVZHSTtDSCwYvVY
	kmkizMPC8zgsTfohsBG1fNeHrl2P6iL1tm4fEijOzoCommTHZAO+2B0wiTGXXcAn1l0Ogaah+eYrg
	4KBe6bcIrT1Rzp2Q06P4REgKhXhMJQ5gk7/bXEr4JvWWOOxr7Ur7MJtRAwipmi9Le7Tlxkhke71Ti
	m3P/2DyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oja52-00GV9c-LN; Sat, 15 Oct 2022 05:51:28 +0000
Received: from mail.sf-mail.de ([2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiwa6-00BZeV-Mp
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 11:40:56 +0000
Received: (qmail 12515 invoked from network); 13 Oct 2022 11:40:25 -0000
Received: from p200300cf070ada0076d435fffeb7be92.dip0.t-ipconnect.de ([2003:cf:70a:da00:76d4:35ff:feb7:be92]:49034 HELO eto.sf-tec.de) (auth=eike@sf-mail.de)
	by mail.sf-mail.de (Qsmtpd 0.38dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
	for <fw@strlen.de>; Thu, 13 Oct 2022 13:40:25 +0200
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Florian Westphal <fw@strlen.de>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, "Jason A. Donenfeld" <Jason@zx2c4.com>, Andrew Morton <akpm@linux-foundation.org>, Florian Westphal <fw@strlen.de>, Herbert Xu <herbert@gondor.apana.org.au>, Thomas Graf <tgraf@suug.ch>, kasan-dev@googlegroups.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v6 5/7] treewide: use get_random_u32() when possible
Date: Thu, 13 Oct 2022 13:40:40 +0200
Message-ID: <11986571.xaOnivgMc4@eto.sf-tec.de>
In-Reply-To: <20221013101635.GB11818@breakpoint.cc>
References: <20221010230613.1076905-1-Jason@zx2c4.com> <3026360.ZldQQBzMgz@eto.sf-tec.de> <20221013101635.GB11818@breakpoint.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart22512332.f9tG50R4rC"; micalg="pgp-sha1"; protocol="application/pgp-signature"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221013_044055_070023_5EE52DFD 
X-CRM114-Status: GOOD (  11.70  )
X-Mailman-Approved-At: Fri, 14 Oct 2022 22:51:19 -0700
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

--nextPart22512332.f9tG50R4rC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Florian Westphal <fw@strlen.de>
Date: Thu, 13 Oct 2022 13:40:40 +0200
Message-ID: <11986571.xaOnivgMc4@eto.sf-tec.de>
In-Reply-To: <20221013101635.GB11818@breakpoint.cc>
MIME-Version: 1.0

Am Donnerstag, 13. Oktober 2022, 12:16:35 CEST schrieb Florian Westphal:
> Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > Florian, can you comment and maybe fix it?
> 
> Can't comment, do not remember -- this was 5 years ago.
> 
> > Or you wanted to move the variable before the loop and keep the random
> > state between the loops and only reseed when all '1' bits have been
> > consumed.
> Probably.  No clue, best to NOT change it to not block Jasons series and
> then just simplify this and remove all the useless shifts.

Sure. Jason, just in case you are going to do a v7 this could move to u8 then.

--nextPart22512332.f9tG50R4rC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCY0f5OAAKCRBcpIk+abn8
TncNAKCia3h4AG/9IzqybWbLcwE6uVgTqACfRr3dPUK8JMrKIqGzYOiL96isZhg=
=zppL
-----END PGP SIGNATURE-----

--nextPart22512332.f9tG50R4rC--




