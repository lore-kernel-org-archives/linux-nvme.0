Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D53D68BCD
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 18:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E2BNdGt9ER/nWRwbgvy7UUTAJ2vjHj29ke2nprS1nqE=; b=iSYDLTMrttb99aPjQGx87ez3yZ
	rOFWwEbavnJM95wrewVJ2LYTdD/4fCGNk14x9+5xxobCgktYHeCiRGY4y0p80lUrcCAutMliNjUoa
	2Gzj3u/e55T673qAJrBh6x0BVEP8CVPwFaSmwX2SU2ghOUKEbJU/qJxCy0aDMxGJTg1UuNkyDMV69
	zvm1rxtBLBU9dfLs+3gzNIm/Z6WhbuerjQ4q8PibBsuxFxV7fT3H/bxhOjYDiAr+FHbnicCp57hHc
	l3XHQBnIiw4zQFZWP9cw7hokCOFZwYyoVJJn1ZSEXRjT4atI5Gi41Wihd7lolCb/WUQyN7GQigmK2
	UNvCuUNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tC0ft-00000003e8y-0ACR;
	Fri, 15 Nov 2024 18:04:05 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tC0fs-00000003e8o-2Bzo
	for linux-nvme@bombadil.infradead.org;
	Fri, 15 Nov 2024 18:04:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E2BNdGt9ER/nWRwbgvy7UUTAJ2vjHj29ke2nprS1nqE=; b=mLRtysRUSQWEXTgW0c4C6kFIrP
	2DbechyxUleqgdzwz+N6MegMggR0Uyr3mTxTTI9dNesYFLPGVl+DtM7fVkThDaFww6S4A9Vtm9OAC
	T8Ux6eQr0HDmFTqJVmuhaBXyJ/hI1075TQBZUNQzmTW4xnN7twG4vu0Tmmfu2/KlQ5+Yjj5HhiTVo
	XH0D0+YvgPnm/I8BcYTadFTYdW5uHe9MrXEluzEVrszfaQOPKAFLW2IkbuXyqZzR/bojlfPXBZKfn
	isHFuCTBr9HyMXSo4fzJOn6H3Wg2h6FYNDpd0gzcoI70i77zpzW7XKbUZKlf2CZSvQclgdYJ+3qzR
	onR+8a5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tC0fp-00000000AIu-1usX;
	Fri, 15 Nov 2024 18:04:01 +0000
Date: Fri, 15 Nov 2024 18:04:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>,
	axboe@kernel.dk, kbusch@kernel.org, martin.petersen@oracle.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
Message-ID: <ZzeNEcpSKFemO30g@casper.infradead.org>
References: <20241114104517.51726-1-anuj20.g@samsung.com>
 <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com>
 <20241114104517.51726-7-anuj20.g@samsung.com>
 <20241114121632.GA3382@lst.de>
 <3fa101c9-1b38-426d-9d7c-8ed488035d4a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa101c9-1b38-426d-9d7c-8ed488035d4a@gmail.com>
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

On Thu, Nov 14, 2024 at 01:09:44PM +0000, Pavel Begunkov wrote:
> With SQE128 it's also a problem that now all SQEs are 128 bytes regardless
> of whether a particular request needs it or not, and the user will need
> to zero them for each request.

The way we handled this in NVMe was to use a bit in the command that
was called (iirc) FUSED, which let you use two consecutive entries for
a single command.

Some variant on that could surely be used for io_uring.  Perhaps a
special opcode that says "the real opcode is here, and this is a two-slot
command".  Processing gets a little spicy when one slot is the last in
the buffer and the next is the the first in the buffer, but that's a SMOP.

