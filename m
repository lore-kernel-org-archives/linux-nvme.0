Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC101C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Dec 2022 08:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2IiSGR/sr/MOQOF1eCBtZr28yaJD6SIbvYdmLsP4sYI=; b=QkPIEj+MsB+4Uf4U8z9BUau9/X
	J6d4J7LBG3eeOssaVFO//rV0SzaULIUArEyX/k5TMq0o1uxIXNlm4Eidxyj+5YCgTkqVjOXqgBeaK
	iRt/dZZFA8tp8XFuw/WQq7Nm3jA08b/drHYkSNEdholMVFN4rKGsgwcQ82sIL9Bvb94AmkLlWqBR9
	EznnKIQHSX2uW+PQp1JEsejn9LrE6G2c03hs4t0qr6b51xdSp2Q96CGQzl69Z/Ux8D+688WdJxGoB
	YV0LmPMf2xqUO299lTp98p6CYrhtuSAztpMHBWSrDxN/RMySCXIJiBN4AKyarXsM1tTM/kivazjAb
	YvnFK0cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7uZ9-00CDmc-74; Wed, 21 Dec 2022 08:35:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7uYw-00CDYI-6P
	for linux-nvme@lists.infradead.org; Wed, 21 Dec 2022 08:34:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 99C1067373; Wed, 21 Dec 2022 09:34:50 +0100 (CET)
Date: Wed, 21 Dec 2022 09:34:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Christoph Hellwig <hch@lst.de>, axboe@meta.com, sagi@grimberg.me,
	kbusch@kernel.org, linux-nvme@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] docs, nvme: add a feature and quirk policy document
Message-ID: <20221221083450.GA23903@lst.de>
References: <20221215125130.261098-1-hch@lst.de> <87zgboddb7.fsf@meer.lwn.net> <20221215132622.GA21083@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215132622.GA21083@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_003454_563150_DA74BFF2 
X-CRM114-Status: GOOD (  16.35  )
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

On Thu, Dec 15, 2022 at 02:26:22PM +0100, Christoph Hellwig wrote:
> On Thu, Dec 15, 2022 at 06:08:44AM -0700, Jonathan Corbet wrote:
> > The document looks fine, but I do wonder if it wouldn't be better placed
> > with the other maintainer entries in Documentation/maintainer?
> 
> Hmm, nothing in there looks very similar to me, while process
> seems to have real policy documents.  But we can live with either
> place.

Any strong arguments for moving it Documentation/maintainer?

I'd like to merge this with the fixups from Randy through the nvme
tree ASAP, and need to decide on the location.

