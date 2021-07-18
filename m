Return-Path: <SRS0=sDNq=MK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3CAC636C8
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Jul 2021 12:48:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA03D61181
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Jul 2021 12:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA03D61181
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LPlLilwWx23EB3F34JaWP0tYkmW3P3hjGFzbgfL6L0g=; b=tuymQbZrSFqiGN
	MJhgFoJpH1mVh1iIffSVlHsC5GNHzcnQQLOuPypvNx0VLXQ/ZEGHpuPL5Dh9EI7lD7nSl6xmB6aaZ
	c7St453KAQXQ/WZ0KqJluUiZFTlGG1PIqHBkpsoLub2AUn8gLT04M07ULBlZijNpLg3y2NFdBXxP8
	bjwrxtQB1SPaJp8UuDnmXxmxk7Q3siXWOArlbADO27jYlRK05ZLVDjqhyPc08jCn8IzosVDNM1V+y
	jYNQuQI2SU1RMfNzpfxUJ0c97F78QrJV/q3qJIhRwWfn+dVYnnh85vLeu2zzRfg7ye+cRQYfj08jf
	+4y/G66ech4AGkm6Q58g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m56D1-007iUE-5Y; Sun, 18 Jul 2021 12:47:51 +0000
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m56Cy-007iTH-Hw
 for linux-nvme@lists.infradead.org; Sun, 18 Jul 2021 12:47:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1626612455;
 s=strato-dkim-0002; d=chronox.de;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=p1yAbhZMGLVQP3MorUaxRlVTjrDgJwphS8789zGmb64=;
 b=W3v6nXsdUzwxeYMLvhC/MUFgtHID84HfppTwTGN+tBlw1ojVv29CDMvUnW15CRSuti
 +yFrWVsN/2NgeOubU8g0N1WDP0tTd/msSdcFYLM4wcQjEdAxY9A3E3PTwc0W4XXmPJVa
 VLIlcGokDaNwujPHtGjIFEcdmbzb31ye2pkUhzYzJQH2raujIA+B1HipJgLEvJnjAQpw
 y/lUUQ+Hol2LT9pvZp4Bj/zm3hdn8JWDcLZ3MbBowg4CcGtOUIhBjISCWKsPIne9+DuO
 PcKVSrOMXvPzEpZzTyX43YMHj52h8klI51zn85z3YKgauCz1HuxyZ4QdjB/GWB2tZuN/
 bxCw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbLvSWMgk="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
 with ESMTPSA id 9043bbx6IClXES7
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sun, 18 Jul 2021 14:47:33 +0200 (CEST)
From: Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
Date: Sun, 18 Jul 2021 14:47:32 +0200
Message-ID: <1892727.xFJX624jkQ@positron.chronox.de>
In-Reply-To: <b90298b5-28e7-1a9a-6a8a-5ae3562c1bfa@suse.de>
References: <20210716110428.9727-1-hare@suse.de>
 <5959906.z61SFhVlds@positron.chronox.de>
 <b90298b5-28e7-1a9a-6a8a-5ae3562c1bfa@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210718_054748_842542_FAA11034 
X-CRM114-Status: GOOD (  10.40  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Am Sonntag, 18. Juli 2021, 14:43:43 CEST schrieb Hannes Reinecke:

Hi Hannes,

> >> +	size += 2 * chap->hash_len;
> >> +	if (ctrl->opts->dhchap_auth) {
> >> +		get_random_bytes(chap->c2, chap->hash_len);
> > 
> > Why are you using CRYPTO_RNG_DEFAULT when you are using get_random_bytes
> > here?
> Errm ... do I?
> Seems that my crypto ignorance is showing here; 'get_random_bytes()' is
> the usual function we're using for drivers; if there is another way for
> crypto please enlighten me.

Apologies, I was looking at CONFIG_RNG where you set CRYPTO_RNG_DEFAULT. 
Please ignore my comment here.

Ciao
Stephan



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
