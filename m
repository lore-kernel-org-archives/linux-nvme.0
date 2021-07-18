Return-Path: <SRS0=sDNq=MK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B730FC636CA
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Jul 2021 13:27:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A0061073
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Jul 2021 13:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A0061073
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2SglNBMnkH8ZPT8d2GOSGbiyNLFmMCNQOSpc+Dl9J4w=; b=E9MAInyoMIPZ6q
	X/FTni3gM8J6V88D7EBvl8XIa15cUtV5I9Zl+4UAMBjjL0zztXaCFleqMpd9W16BISkMcO+ue09b1
	PHEVtFoKEy+QhxmILGND96pBl8bdurKgazC742AP7Y6vfWgQrOijfcKK6gf04aOlbyIfRuT9FeMhk
	2JzFPjxo46Sn/vwJCKGAE7VM+UORsPJ3Mtx1ljkyEWDH2ROI0AqvxpTCC9VkGake67VgEa2zBNEW9
	oRQl44BvQ8icnL7k1FRrUeIxMKaH+K2ECk7PY1oM8QN6/Vw9IDYo2PVDVWwqxcF62gmN2EqKSGidm
	ntslIX5N900RrgUPkaoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m56p6-007kht-Jm; Sun, 18 Jul 2021 13:27:12 +0000
Received: from helcar.hmeau.com ([216.24.177.18] helo=deadmen.hmeau.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m56p2-007kha-OA
 for linux-nvme@lists.infradead.org; Sun, 18 Jul 2021 13:27:10 +0000
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
 id 1m56om-0003cS-3J; Sun, 18 Jul 2021 21:26:52 +0800
Received: from herbert by gondobar with local (Exim 4.92)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1m56ob-0003CV-F6; Sun, 18 Jul 2021 21:26:41 +0800
Date: Sun, 18 Jul 2021 21:26:41 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Hannes Reinecke <hare@suse.de>
Cc: Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 09/11] nvmet: Implement basic In-Band Authentication
Message-ID: <20210718132641.GA12275@gondor.apana.org.au>
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-10-hare@suse.de>
 <2510347.locV8n3378@positron.chronox.de>
 <a4d4bda0-2bc8-0d0c-3e81-55adecd6ce52@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a4d4bda0-2bc8-0d0c-3e81-55adecd6ce52@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210718_062708_828049_B45A4307 
X-CRM114-Status: UNSURE (   8.26  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Jul 18, 2021 at 02:37:34PM +0200, Hannes Reinecke wrote:
>
> > > +	response = kmalloc(data->hl, GFP_KERNEL);
> > 
> > Again, align to CRYPTO_MINALIGN_ATTR?
> 
> Ah, _that_ alignment.
> Wasn't aware that I need to align to anything.
> But if that's required, sure, I'll be fixing it.

Memory returned by kmalloc is guaranteed to be aligned to
CRYPTO_MINALIGN_ATTR, in fact that's the whole point of that
attribute.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
