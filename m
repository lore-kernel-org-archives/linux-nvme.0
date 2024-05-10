Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5F9C25B10
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 22:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e2CazBCTSgp1TUq9jpEmkZgMWYdjxt4eNofKqQj0BCk=; b=S9wyg42gtIEpj2hazYEOg2Vl4T
	M09O+D6fJvpaNH3sa+kyZNuPTsJ9wz3kFvo+deZzd6RHVXxY4EPip0zXXOJPJH6XH91gP8IAx/iS7
	4ANLrNT8bjEqF2ij436cBKaDztlByZBEx7gEkqU7S4zlyDXDh8CeQpm1Bpv+5J5piug+iTVv98CM4
	tP+4KZLLFALj1lgz+L8JvRspshS6S+S91SHfRV7Xp1moDo83fVSSvbshuAYbghYTbXFjGlxyJsqeb
	ZjAP6LVrUWO/1bT2sL7mym8Q2Z5jcDhe+cKRvj/HRJtQmzOfobkpB61A+R7XBqTQVcQvXEiscqbvR
	NJ4LkNNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Yev-00000006eTn-2nO4;
	Fri, 10 May 2024 22:24:09 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Yeu-00000006eTU-0XQ7
	for linux-nvme@bombadil.infradead.org;
	Fri, 10 May 2024 22:24:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e2CazBCTSgp1TUq9jpEmkZgMWYdjxt4eNofKqQj0BCk=; b=FZX9429YkWjp/wUG+nsLMnz/jv
	j+vjZd667ZnraKzIiTjENAUQXTGzjA/LURoGLW33SkrMRGvwUsthaw/qWgE70mWgPTVx5dwZ1Ri1e
	Lt7SxsXR2/rSeylWVFs0jvpvvVjJxr9eLe6d6ZHWMnlWYgWtOHFn/WLgk/ErB2LcbMiDEExgN8If5
	dIaIjai7GhxSPzAUvcfFWhNX0M/bIBj/j9DEd/K/S5VADTbe+m0fikplmMGkUmEce5kcdf7qxrg8b
	bN8e7gOzv7Q45YrBcTvvW+dIgkj/YOi0lmDPTxeJ9+LEFd65fy/aIiAB3UY5XxRYYE+KqWfjCjnlv
	B1MbFi2w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Yes-000000043qU-2vi9;
	Fri, 10 May 2024 22:24:06 +0000
Date: Fri, 10 May 2024 23:24:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/5] fs/mpage: avoid negative shift for large blocksize
Message-ID: <Zj6ehjm1iVcc_x2m@casper.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-3-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-3-hare@kernel.org>
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

On Fri, May 10, 2024 at 12:29:03PM +0200, hare@kernel.org wrote:
> -	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
> +	block_in_file = (sector_t)(((loff_t)folio->index << PAGE_SHIFT) >> blkbits);

	block_in_file = folio_pos(folio) >> blkbits;


