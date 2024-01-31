Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADA0C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 08:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hhIe6qc6z9B3fJvO+578ytjkAiUXY9w0x+SCBIlEfJk=; b=h+w+Rf/ASR99y2CnIQtbVinDsA
	WYww0aHd4W7S+ONDsscJKlMBkVduKmrW9APCkwMMuDNj59TU1cfL45aenl8IBVakHhppoBR4eQkb5
	qQ8lP0Mds3FM4e3CxmAPD8/Baw9VGI54EMb+rrWNeBG+gy4dFp82YCtJCXwZu2k3HRxo0yMmd7FfV
	x8CXXmNWtnP1VKqyoHXxUh8Nby/xWlq38oLWArv+5/D2xZiFSRPugL2wv8ykqd5M2keyf7SOnNFBg
	SR0N6U+4P1EDs3gjBPt3UQVCUAiacUnbixQpaxl1bKH+I+eImdFiriYJmgVeEAjYjAumoxev3ZkqW
	EQugmMkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV60H-000000027rV-1xGl;
	Wed, 31 Jan 2024 08:31:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV4ub-00000001mt2-3C6A
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 07:21:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 99E8B68B05; Wed, 31 Jan 2024 08:21:25 +0100 (CET)
Date: Wed, 31 Jan 2024 08:21:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Chinmay Gameti <c.gameti@samsung.com>
Subject: Re: [PATCH 2/3] block: support PI at non-zero offset within
 metadata
Message-ID: <20240131072124.GB17498@lst.de>
References: <20240130171206.4845-1-joshi.k@samsung.com> <CGME20240130171927epcas5p2814181a20402d08b96393ce4a5e06e03@epcas5p2.samsung.com> <20240130171206.4845-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130171206.4845-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_232134_038967_99E5BFBB 
X-CRM114-Status: GOOD (  12.39  )
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

On Tue, Jan 30, 2024 at 10:42:05PM +0530, Kanchan Joshi wrote:
> The block integrity subsystem assumes that PI appears first in the
> metadata buffer.
> Abolish this assumption by adding the ability to handle PI starting at
> a non-zero offset.
> Calculation of the guard tag includes the metadata buffer up to this
> offset.

Maybe rewrite this as:

Block layer integrity processing currently assumes that protection
information is placed in the first bytes of each metadata block.
Remove this this limitation and include the metadata before the
protection information in the calculation of the guard tag.

>  {
>  	unsigned int i;
> +	u8 offset = iter->pi_offset;

Nit: I find it more readable if variables that are initialized at
declaration time come first.  Also (with a few exceptions) it's nice
to read longer declarations first.


