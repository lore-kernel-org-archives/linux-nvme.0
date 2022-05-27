Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9583DC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 27 May 2022 10:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r7uOG9Za4+f0fZITal4/ieZSnZYQdmsE2Ku37CvYUb8=; b=wd/zzHcbfmrMpG+qfa6oSqUJi8
	KGGDmF7n0SKHTQFxe4UkHUA+UjUZW4bNHXKGh+OoFTCLWFynKdf//Wi614PzthwZ0WiVeURtX8KU0
	/K6hrIBsrhgFV5fKDDLN/TfVgGN2+45zgOZA+YjFC8ORjGQv9UhEB2sKTVeOxOFLTfrHu8VvZ4mBj
	ouKCcvSh8U8ciQL0pPEqlgxibAxfeCKUnizQ9crkRPQ0+wfCXxMuh1K2hUgBHmjKVVO1xhEDUoB00
	bD0jluVD3sYMja9xPrUvG5GfOsrKOpc4GfSxuel5GJxlRLUNb5hjj05SJzc5fniq3Qcg1bCGD07lk
	EEWFvT0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuWrv-00HIC4-6A; Fri, 27 May 2022 10:06:55 +0000
Received: from helcar.hmeau.com ([216.24.177.18] helo=fornost.hmeau.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuWrs-00HIAw-4B
	for linux-nvme@lists.infradead.org; Fri, 27 May 2022 10:06:53 +0000
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1nuWri-000YOp-UK; Fri, 27 May 2022 20:06:44 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 May 2022 18:06:43 +0800
Date: Fri, 27 May 2022 18:06:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCHv12 00/11] nvme: In-band authentication support
Message-ID: <YpCis+8bv/EJqdlc@gondor.apana.org.au>
References: <20220518112234.24264-1-hare@suse.de>
 <bc8bea8b-2cdf-4d41-65b0-5c2bf28457d2@suse.de>
 <20220526090056.GA27050@lst.de>
 <99126556-65b8-d0eb-bcd5-7b850493b51f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99126556-65b8-d0eb-bcd5-7b850493b51f@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220527_030652_182263_B29E281C 
X-CRM114-Status: GOOD (  14.62  )
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

On Fri, May 27, 2022 at 07:50:42AM +0200, Hannes Reinecke wrote:
> On 5/26/22 11:00, Christoph Hellwig wrote:
> > On Wed, May 25, 2022 at 11:54:54AM +0200, Hannes Reinecke wrote:
> > > How do we proceed here?
> > > This has been lingering for quite some time now, without any real progress.
> > 
> > As said it is a high priority for the upcoming merge window.  But we
> > also really need reviews from the crypto maintainers for the crypto
> > patches, without that I can't merge the series even if I'd like to.
> 
> Hmm. Guess I can remove those helpers; after all,
> both are just wrappers around existing exported helpers.
> I'll resend.

I've just acked those two patches.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

