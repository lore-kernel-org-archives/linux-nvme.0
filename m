Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7791CCD1288
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 04:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vaYfYYhNnougBEIHCmugJP458JcmntgkLx2vOXPDuho=; b=tePECFcz48uSk4jjQpTbcWdQGL
	nXYcxUpLCJp3ecUd9MabeJEBhnxwyWq1+5xQKqMf1uBepcGXAJrtLXtYKw+vrA/LIteLPsMylSNea
	J6fPapPJvalXR348+51eUvuXHkQ7K0ejvYeZVIrNdLOnE78Ks7b/uFj0J+mVBMxkQgy28zuudz1bB
	s9V+Grs5zXU24754HUatPKrPMZiRN5Kx8Yn5vaKcCaKVJEMggACKJglE08lc7+VvSoFidKajrOP7l
	5yvY/w98WEUDWSR5FUzlD6fzaxMuyXJcOPQUyLJXdb9URsyxs4uGazxAXCmBdD8drNRdwuU33ALVf
	rDWfBenQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrsTc-0000000DzFO-3L4L;
	Wed, 03 Apr 2024 04:43:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrsTZ-0000000DzE0-123s
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 04:43:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 249C468BFE; Wed,  3 Apr 2024 06:43:48 +0200 (CEST)
Date: Wed, 3 Apr 2024 06:43:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 17/28] null_blk: Introduce fua attribute
Message-ID: <20240403044347.GA23048@lst.de>
References: <20240402123907.512027-1-dlemoal@kernel.org> <20240402123907.512027-18-dlemoal@kernel.org> <7a3be43c-39d9-472a-9593-89a1c4e03004@gmail.com> <3b35dca4-e548-427b-a304-e21f3ee483e0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b35dca4-e548-427b-a304-e21f3ee483e0@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_214353_455285_6A1DD457 
X-CRM114-Status: GOOD (  13.38  )
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

On Wed, Apr 03, 2024 at 12:58:51PM +0900, Damien Le Moal wrote:
> No particular reason. I probably followed the pattern around the code when I
> added it.
> 
> Personnally, I find this checkpatch warning about S_IRUGO silly as it is far
> more readable than 0444... Just my 2 cents. I can make the change if you insist.

Checkpatch is useless.  Follow the code around it.


