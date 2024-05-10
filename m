Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAF4C25B10
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 22:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hBrnX+U4pxDm7jtcvPTU+zBs2Ty6Lb9srPF/queK5b8=; b=B4Li9GgUeQojKArfTnbY/sIia4
	yqdfyZhod8g+xfKUSn0Jzqc7vjnxUEUQ0P3p92MGKKHfz2Yh8OR5LDd63YhIbwMQHq+7qxOLrkQRu
	H+HErZMhJ9qzGkR3RJdzVSajFWAstaBaMsqK0tsLuarnibvn1FjIvM7FSqVOi2U0Q2Mk57BLORcGe
	VMxwwaudz5Q3AFLDnLOVRwlhWS4jV/DMBHNqtDZYrwkoFEtQWc3HB9vPmYThzLJnvq3s72Zi8PBKC
	gi6VQ6BEH/vb+4/BRyJU1DfCqTtR8RGS+MqYpe8aXmufpVOXPTRyTnHCXyPK1W+8lx5sWoD/Ur5xX
	hzczPeLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5YaX-00000006drH-2iKv;
	Fri, 10 May 2024 22:19:37 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5YaW-00000006dqe-0WKv
	for linux-nvme@bombadil.infradead.org;
	Fri, 10 May 2024 22:19:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hBrnX+U4pxDm7jtcvPTU+zBs2Ty6Lb9srPF/queK5b8=; b=UWW8rNo5+wP3OEtQWhtBvWYjYv
	MGWITLSJ1MEEzroRx6lXiYPQDQeJYKgiEjTZZisYpgkFAMwK8DzfFfz9T877tIgWZ6M5kyhpZcpRh
	WGyhh3MVNw//vQRpENVlUIJcK97i1nSxVOVu92vlxtrw1sIt5rpD9jkh1gReHciR0kjY10uW1xGgt
	5wCfmTqkcVKeF+gVQ3L284xijLAmESSG0DuXe8nxhU3U9bSJtme0vMZAH8NmqviSiYDOrHAAfePbj
	+I6UMOaPy3JxXCrTXvKJ703iGuO7BQlpvCCJ+vfxwoTewCiumxZYJRf2jJdzQsJkqNjhSj11tYNWc
	e1pb3RNw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5YaT-000000043J5-1hlz;
	Fri, 10 May 2024 22:19:33 +0000
Date: Fri, 10 May 2024 23:19:33 +0100
From: Matthew Wilcox <willy@infradead.org>
To: hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/5] fs/mpage: use blocks_per_folio instead of
 blocks_per_page
Message-ID: <Zj6ddYvmb2uIq5Ec@casper.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-2-hare@kernel.org>
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

On Fri, May 10, 2024 at 12:29:02PM +0200, hare@kernel.org wrote:
> +++ b/fs/mpage.c
> @@ -114,7 +114,7 @@ static void map_buffer_to_folio(struct folio *folio, struct buffer_head *bh,
>  		 * don't make any buffers if there is only one buffer on
>  		 * the folio and the folio just needs to be set up to date
>  		 */
> -		if (inode->i_blkbits == PAGE_SHIFT &&
> +		if (inode->i_blkbits == folio_shift(folio) &&

yes

> @@ -160,7 +160,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  	struct folio *folio = args->folio;
>  	struct inode *inode = folio->mapping->host;
>  	const unsigned blkbits = inode->i_blkbits;
> -	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
> +	const unsigned blocks_per_folio = folio_size(folio) >> blkbits;
>  	const unsigned blocksize = 1 << blkbits;
>  	struct buffer_head *map_bh = &args->map_bh;
>  	sector_t block_in_file;
> @@ -168,7 +168,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  	sector_t last_block_in_file;
>  	sector_t first_block;
>  	unsigned page_block;
> -	unsigned first_hole = blocks_per_page;
> +	unsigned first_hole = blocks_per_folio;

yes

> @@ -189,7 +189,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  		goto confused;
>  
>  	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
> -	last_block = block_in_file + args->nr_pages * blocks_per_page;
> +	last_block = block_in_file + args->nr_pages * blocks_per_folio;

no.  args->nr_pages really is the number of pages, so last_block is
block_in_file + nr_pages * blocks_per_page.  except that blocks_per_page
might now be 0.

so i think this needs to be rewritten as:

	last_block = block_in_file + (args->nr_pages * PAGE_SIZE) >> blkbits;

or have i confused myself?

> @@ -275,7 +275,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  		bdev = map_bh->b_bdev;
>  	}
>  
> -	if (first_hole != blocks_per_page) {
> +	if (first_hole != blocks_per_folio) {
>  		folio_zero_segment(folio, first_hole << blkbits, PAGE_SIZE);

... doesn't that need to be folio_size(folio)?

there may be other problems, but let's settle these questions first.

