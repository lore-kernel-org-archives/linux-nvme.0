Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B02C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 10:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=El7DPG5/hda+xqYuuX0LwL0YlMWkzO4GgQoUo2g7/js=; b=usgiBqmIOFkjkAqjw8QnRiQ/RG
	hTrzajiZbFqT1++N2Se3T2QKlsJzNfBne7FgQt5lDlplW8wxaVKC7OXkSmHW3ymqDEpwW9uGM+oNE
	yi8rSyKkFIDYjwsSXkGMJ/mNKX4KGLVGfHtKlG0A9QDmX9R4BFTnSPh9Bl6faz6/IXmHiNMAXjAJF
	eRWFbvpHPN0c2ArQbl/liCh2BLrmO2AGzkUMtovM35jhwZzoQ/KJW/MY1Tb1MK9OqBbL+/tVTcqhX
	XR9fjdDGujBJhWDTOjHEwEbowjH7Rt4ewnlp5pbRmdpiQt6XUbRzM6zHknqkMgaaUjFUo4DWiHRvN
	r8U6UosA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyWiv-006mwt-TY; Tue, 07 Jun 2022 10:46:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyWiZ-006mjR-2e
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 10:45:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 78E4367373; Tue,  7 Jun 2022 12:45:42 +0200 (CEST)
Date: Tue, 7 Jun 2022 12:45:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCHv12 00/11] nvme: In-band authentication support
Message-ID: <20220607104541.GA25515@lst.de>
References: <20220518112234.24264-1-hare@suse.de> <bc8bea8b-2cdf-4d41-65b0-5c2bf28457d2@suse.de> <20220526090056.GA27050@lst.de> <99126556-65b8-d0eb-bcd5-7b850493b51f@suse.de> <YpCis+8bv/EJqdlc@gondor.apana.org.au> <c1114e13-79cd-364c-b9d2-7a149a642919@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1114e13-79cd-364c-b9d2-7a149a642919@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_034547_291140_E6B7ABFD 
X-CRM114-Status: GOOD (  10.99  )
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

On Fri, May 27, 2022 at 12:21:59PM +0200, Hannes Reinecke wrote:
> Christoph, you can pick either v12 or v13; the difference is just the check 
> for available hash and kpp functions. v12 has the dynamic version
> using the crypto helpers, v13 has the static version checking compile-time 
> configuration.
> Either way would work.

Please resend with these helpers included and any other fixups after rc2
is released.

