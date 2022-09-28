Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9C7C04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 17:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KSrt651hXuLjL+U774sJamtVg2PGZROw7PyRl8/U4mc=; b=I8PMeusecqAob0YgWS4YGay9xC
	RSDXjW4NhOB2J8hxjtom2yAx9z2drWoTIu9+wpLE2cZaZukC/qrdY+hMsfqvUG3cJkawCHAi7HQaB
	Cr1XWOBmjLWtrMHxPJ5EonzuMQne3jOP5De0fCRLJ2BC5TWQc3lZN3W8vW8tQkxG+WskYMATXEoKF
	psxkChssaH9/m9BRxsPCOUTVe8jv8iWC2+8V3kf61Y+qelnf1ka3Oqil3i29Mod8IKDcERl0P2RCW
	WzGNd0HbC3q9cXQjBIIHQbJdUve71st9Oqzuw4NEXwWcpBHodvIkgxIx0HdUNm7ilYHiJex+A3b1B
	whhJGo5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odahM-00HK6k-4A; Wed, 28 Sep 2022 17:18:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odahE-00HK3P-Qs
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 17:18:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AE88868BEB; Wed, 28 Sep 2022 19:18:05 +0200 (CEST)
Date: Wed, 28 Sep 2022 19:18:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next v10 3/7] nvme: refactor nvme_add_user_metadata
Message-ID: <20220928171805.GA17153@lst.de>
References: <20220927173610.7794-1-joshi.k@samsung.com> <CGME20220927174631epcas5p12cd6ffbd7dad819b0af75733ce6cdd2c@epcas5p1.samsung.com> <20220927173610.7794-4-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173610.7794-4-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_101809_080000_84E90FF1 
X-CRM114-Status: UNSURE (   9.93  )
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

On Tue, Sep 27, 2022 at 11:06:06PM +0530, Kanchan Joshi wrote:
>  		if (bdev && meta_buffer && meta_len) {
> -			meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
> -					meta_seed, write);
> +			meta = nvme_add_user_metadata(req, meta_buffer, meta_len,

Pleae avoid the overly long line here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

