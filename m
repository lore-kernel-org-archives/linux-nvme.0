Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64169D1359B
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 11:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sPyQIjlJWsNzCGW62U9jCjeLv5i9MvYUW0O6ATeMb80=; b=MlmDj/PWmO36ROVHmtJ780gsoN
	kP8zQ8G+Kk+Pf22nRN+oXUm9TjabNzqbEoThNPZ8yvaULTgSTDnkEZ5RWKdknvCxAjzf9SFnLHoNz
	sY4fzIKsQCsYfrsDkNlUtWk95jMS5XlOJ9a9QvnmgBth/ZkeeyXjjsO2TCZNqZ9SuXoZT6QXH3RIh
	GVROi30JfW90gqCQEfFOLnCOfITZpyn9pFKvMX4HjC1ORwZdQoZu69jcBOz5HqaZ4PYmdr7p6kzLn
	UpUSMxzr6frMXPbXildzfSx5tqhzVsXaOvnY9i6x7vEL4DW9HYFQ7AXimW+4DJ/skcIe1NmfEggJ7
	8OSz/5uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5OPO-0000000Ae7V-1R1e;
	Mon, 28 Oct 2024 11:59:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5OPJ-0000000Ae6h-3TCQ
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 11:59:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C76468BFE; Mon, 28 Oct 2024 12:59:33 +0100 (CET)
Date: Mon, 28 Oct 2024 12:59:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv9 4/7] block, fs: add write hint to kiocb
Message-ID: <20241028115932.GE8517@lst.de>
References: <20241025213645.3464331-1-kbusch@meta.com> <20241025213645.3464331-5-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025213645.3464331-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_045939_231283_D9F5A220 
X-CRM114-Status: GOOD (  12.24  )
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

On Fri, Oct 25, 2024 at 02:36:42PM -0700, Keith Busch wrote:
> +static u16 blkdev_write_hint(struct kiocb *iocb, struct block_device *bdev)
> +{
> +	u16 hint = iocb->ki_write_hint;
> +
> +	if (!hint)
> +		return file_inode(iocb->ki_filp)->i_write_hint;
> +
> +	if (hint > bdev_max_write_hints(bdev))
> +		return file_inode(iocb->ki_filp)->i_write_hint;
> +
> +	if (bdev_is_partition(bdev) &&
> +	    !test_bit(hint - 1, bdev->write_hint_mask))
> +		return file_inode(iocb->ki_filp)->i_write_hint;

I would have expected an error when using an invalid stream identifier.

That of course requires telling the application how many are available
through e.g. statx as requested last time.


