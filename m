Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B827D74962
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 05:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uk6WLNu3sMbvJlDwxwwERLE399QRdFL2SJ+OamFkLJQ=; b=fVssyDr+zXUcZChvrGq6Xb9Gi6
	cLC4p8tMR13kY9oxQHM6VsohBXDxR8sIWD68O3bRljnOYHMncoZ5UTyPht6tV/AEJZmtbOPPQg8a5
	4S/D7WMYRrjaSTULXhI6c42eoBIiHWWT6HsSiPRW6H5bKU5zGsye2x5TgVOYqdSMAjCMi/2euxc/E
	HLHtLXW3lnVnAtdaLzb8fy+LLsAZLQp6QsC/jKVRSr/Yfu/cTAgp832+KA1sjj+5usdSHaqf6cXA5
	6YMHEa1oCktJqsWmsuiJRk+fSNTzQwJwznx/F54MCscJelztE/mCDZFJYwgSNY2APPZDHDwQHricu
	aMIjFQEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t60sF-0000000Gjy6-3YMe;
	Wed, 30 Oct 2024 05:04:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t60sC-0000000Gjwu-2HX2
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 05:04:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E8D5768AA6; Wed, 30 Oct 2024 06:03:55 +0100 (CET)
Date: Wed, 30 Oct 2024 06:03:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v5 04/10] fs, iov_iter: define meta io descriptor
Message-ID: <20241030050355.GA32598@lst.de>
References: <20241029162402.21400-1-anuj20.g@samsung.com> <CGME20241029163220epcas5p2207d4c54b8c4811e973fca601fd7e3f5@epcas5p2.samsung.com> <20241029162402.21400-5-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029162402.21400-5-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_220400_749733_F2AD7AA9 
X-CRM114-Status: GOOD (  10.18  )
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

On Tue, Oct 29, 2024 at 09:53:56PM +0530, Anuj Gupta wrote:
> +/* flags for integrity meta */
> +typedef __u16 __bitwise uio_meta_flags_t;
> +
> +struct uio_meta {
> +	uio_meta_flags_t	flags;

.. this is a bitwise type

> +/* flags for integrity meta */
> +#define IO_INTEGRITY_CHK_GUARD		(1U << 0) /* enforce guard check */
> +#define IO_INTEGRITY_CHK_REFTAG		(1U << 1) /* enforce ref check */
> +#define IO_INTEGRITY_CHK_APPTAG		(1U << 2) /* enforce app check */

.. but these aren't.  Leading to warnings like:

 CHECK   block/bio-integrity.c
block/bio-integrity.c:371:17: warning: restricted uio_meta_flags_t degrades to integer
block/bio-integrity.c:373:17: warning: restricted uio_meta_flags_t degrades to integer
block/bio-integrity.c:375:17: warning: restricted uio_meta_flags_t degrades to integer
block/bio-integrity.c:402:33: warning: restricted uio_meta_flags_t degrades to integer

from sparse.  Given that the flags are uapi, the it's probably best
to just drop the __bitwise annotation.


