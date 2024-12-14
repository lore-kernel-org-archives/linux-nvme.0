Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B28FE7716A
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Dec 2024 04:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=r/HpSQZwmseo9rDVHNNPLSwfRN+z5edQANw0G1dEzAc=; b=cqQQSw9rKAISUh
	LmqkntlZsk15sgLXsXqLEo32n1tCeu0Q9P3lWXN1deG2HEyWvqv2KtRw+/CLDMa2Gt+HwCCf5y7c9
	Ggme6zTET6dbLdsSFIe72JwEQFCI/2zzxpMQsAHyf+9FGpIwLJ0ZLSjWdmSLtyKFneHEmaCNk/Ysa
	yoxZ7hTrJHD/gpGNShT5+VFG6E6ftm1PDsTLs184K/hVvI+iR/IpSuDTi2VanbzSCZ2BJy6t0JOmu
	RV5GmeAcFxx33ecK1ECmPQATELyJdUWR7/6RiNs8EqUsVYS5ro36HkNyGaJZIJXXwfCoyL2YPb5Z9
	V1/F3jf6cHVU8FFCfqow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tMJwX-00000005hvI-1k7R;
	Sat, 14 Dec 2024 04:39:53 +0000
Received: from abb.hmeau.com ([144.6.53.87])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tMJwV-00000005huu-0MBf
	for linux-nvme@lists.infradead.org;
	Sat, 14 Dec 2024 04:39:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r/HpSQZwmseo9rDVHNNPLSwfRN+z5edQANw0G1dEzAc=; b=YlJN4FEPOoxStEHXvAGrVTJzda
	ZEGAqhEa4S4tPopJz4twfi2+MOogH5SRtDML1p0xqpg1k+0420a3dXmM7CEV7o8Lrdgw2jZjZRcpE
	0CiOZ0OAGlJurncucn0GplEj20u2z4YeCNTDc4K1KLmpKTXasuJA7f1WYdc+00od6iFEWSrbvf2+v
	gsXsUXzdLn+OgZoJmPHQehzyvC9keVzMgjFZjj9E2/gSRxE0hzfV1q9BmWBiQ0ZkfTosIXjKpHa7K
	Ng2twiehu3O+iKzV+0kR4D3YlE24G58ovrf7udSKxVIlE+yDBPFAYa162+g4g1bol0ULBIwWy3bw7
	Ude6tmbA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tMJjP-001RRD-2M;
	Sat, 14 Dec 2024 12:39:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 14 Dec 2024 12:39:40 +0800
Date: Sat, 14 Dec 2024 12:39:40 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Hannes Reinecke <hare@kernel.org>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, ebiggers@kernel.org,
	linux-crypto@vger.kernel.org, hare@kernel.org
Subject: Re: [PATCH 01/10] crypto,fs: Separate out hkdf_extract() and
 hkdf_expand()
Message-ID: <Z10MDHc8fYhLyfbw@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203110238.128630-2-hare@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_203951_126754_8B0CB60C 
X-CRM114-Status: UNSURE (   9.44  )
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

Hannes Reinecke <hare@kernel.org> wrote:
> Separate out the HKDF functions into a separate module to
> to make them available to other callers.
> And add a testsuite to the module with test vectors
> from RFC 5869 (and additional vectors for SHA384 and SHA512)
> to ensure the integrity of the algorithm.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> Acked-by: Eric Biggers <ebiggers@kernel.org>
> ---
> crypto/Kconfig        |   6 +
> crypto/Makefile       |   1 +
> crypto/hkdf.c         | 573 ++++++++++++++++++++++++++++++++++++++++++
> fs/crypto/Kconfig     |   1 +
> fs/crypto/hkdf.c      |  85 ++-----
> include/crypto/hkdf.h |  20 ++
> 6 files changed, 616 insertions(+), 70 deletions(-)
> create mode 100644 crypto/hkdf.c
> create mode 100644 include/crypto/hkdf.h

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

