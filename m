Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B945FC4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Apr 2024 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=08xepRFTKXV8RSlAKPzn77yH+CZ3T3GONZovW8FkgKI=; b=yOzvIXZ+DJQ040A3mCZFhl9VgV
	m8XlHVWk0VMtP+25lMEmlNsDq+zv21ysYrsbzFSoNW7/jfQVlF2om58gV+64mcY+u2H821VV4Gtxo
	gIktpqw5kqTs+WHZqpA2NXjO9BGC4U7CRBybk8lnkoGTyLr7auxlYRCc9qqK/RWCkv49XZshMS7y3
	Lf46zOcNWdltFsY8Z6VtYKvevjvuK+Z13Rxyx9Ajb55T5n1EnS+uZUenYemUpJ64K7VZ90vPJv7nM
	THYRawHj+0SE17AjwRvEMDzgJhbpwaaWCcw+G89mzrbR05P9Oe2V/8RpCVJNXmq4cEd+uihn/PE02
	+nT2Z+ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1UVU-00000003gSw-12p1;
	Mon, 29 Apr 2024 17:09:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1UVS-00000003gSH-0L63
	for linux-nvme@lists.infradead.org;
	Mon, 29 Apr 2024 17:09:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A34F1227A87; Mon, 29 Apr 2024 19:09:29 +0200 (CEST)
Date: Mon, 29 Apr 2024 19:09:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	martin.petersen@oracle.com, kbusch@kernel.org, brauner@kernel.org,
	asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 04/10] block: avoid unpinning/freeing the bio_vec
 incase of cloned bio
Message-ID: <20240429170929.GB31337@lst.de>
References: <20240425183943.6319-1-joshi.k@samsung.com> <CGME20240425184658epcas5p2adb6bf01a5c56ffaac3a55ab57afaf8e@epcas5p2.samsung.com> <20240425183943.6319-5-joshi.k@samsung.com> <20240427070508.GD3873@lst.de> <03cb6ac3-595f-abb1-324b-647ed84cfe6b@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03cb6ac3-595f-abb1-324b-647ed84cfe6b@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_100934_309823_1379AD5D 
X-CRM114-Status: GOOD (  16.49  )
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

On Mon, Apr 29, 2024 at 05:10:59PM +0530, Kanchan Joshi wrote:
> > This feels wrong.  I suspect the problem is that BIP_COPY_USER is
> > inherited for clone bios while it shouldn't.
> > 
> 
> But BIP_COPY_USER flag is really required in the clone bio. So that we 
> can copy the subset of the metadata back (from kernel bounce buffer to 
> user space pinned buffer) in case of read io.
> 
> Overall, copy-back will happen in installments (for each cloned bio), 
> while the unpin will happen in one shot (for the source bio).

That seems a bit odd compared to the bio data path.  If you think this
is better than the version used in the data path let's convert the
data path to this scheme first to make sure we don't diverge and get
the far better testing on the main data map side.

