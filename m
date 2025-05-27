Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FD6C5B542
	for <linux-nvme@archiver.kernel.org>; Tue, 27 May 2025 21:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YjdFkLFoSV533Zt+Y5Ll10aijjNyb7hZwqwar5IyIUw=; b=LLK6d8ExhRuYZawGet1Zrz7mN/
	aUTOa6oGFZE+CLLcSjDFPmAmYrFOgUE3YRiReqstSpD6joTP2SSczemTQqXZeFSiLJ5hXEOaW9u7W
	CN8RTTYlUPM1qJmmakCOpiaIq+oac/OYf5AdQ81ausExIB79tpZV1Ma8e/PNDOoejvt7qibGZ6odm
	j0gq30hceE9xVkcPYowAFah9SdIEj08ySV5F7+Tt3EVtXdvwBujztGzx8kiEl8jPZxYL6xbKaBDqf
	40B+0nI4OT0Ae4TrVqyjOViC+9/kbNuCI4sRVWCbTzADDPGMgwcb2Eh+W709/pnMlaNzABU/1+wjF
	XW2Ta4dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uK1vM-0000000Bcbj-06Ug;
	Tue, 27 May 2025 21:33:28 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uK1uy-0000000BcZk-1Rgm
	for linux-nvme@lists.infradead.org;
	Tue, 27 May 2025 21:33:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 734E7A4F23B;
	Tue, 27 May 2025 21:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF777C4CEE9;
	Tue, 27 May 2025 21:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748381583;
	bh=AGs9X2CYdiqd1UEmpwxAc4YS4cDP1HJekBBrTkn1KQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhhEmXaZa8iQ3lubsGKhgoEZD1rtwjFAh88h+0E4nTUR52mnm8yJppTY2ZpvqJ0ub
	 y2TYZ92UWeVdyKzSqmypAhdJR8N5JFvSJqoAE0nzw39q+wk/+zKn9SI3v6TXWgbIg3
	 NhwdYOnhEZdjOLfLnk41FJv7vhTdYZzoGtssMpZ6w2RtvXgXqJUDxN0kE2t+4PVPO5
	 OhtyVVHoNJxGxkEG1sSmKbpR/9jQIUn5r9I33fXHroAPcB7aU3rvSvlEJyghcVhR2P
	 oG4CRiHJejiKhsrO/a7ORhRUWK4zrRu3xSseG/zH57O9MAS1QOeB7pJ/txbwMf7mGf
	 2ADYEKnQbr3xg==
Date: Tue, 27 May 2025 15:33:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] block: add support for copy offload
Message-ID: <aDYvjGcswPkbHlR7@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-3-kbusch@meta.com>
 <aDBuQbsBRVjOc5wU@infradead.org>
 <aDB3lSQRLxjDHTSE@kbusch-mbp>
 <aDB6Hdp9ZQ1gX5gr@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDB6Hdp9ZQ1gX5gr@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250527_143304_452577_CF9715D6 
X-CRM114-Status: GOOD (  19.14  )
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

On Fri, May 23, 2025 at 06:37:33AM -0700, Christoph Hellwig wrote:
> Anyway, below is a patch to wire it up to the XFS garbage collection
> daemin.  It survices the xfstests test cases for GC when run on a
> conventional device, but otherwise I've not done much testing with it.
> 
> It shows two things, though:
> 
>  - right now there is block layer merging, and we always see single
>    range bios.  That is really annoying, and fixing the fs code to
>    submit multiple ranges in one go would be really annoying, as
>    extent-based completions hang off the bio completions.  So I'd
>    really like to block layer merges similar to what the old
>    multi-bio code or the discard code do.

This series should handle bio merging REQ_OP_COPY. If it's inconvenient
to get multiple source sectors, bios that fit in the queue limits will
merge to one request when the using the blk_plug like you're doing.

>  - copy also needs to be handled by the zoned write plugs

This is about emulating "copy append" behavior for sequential zones? In
case it gets split, we can't safely dispatch multiple copy operations
targeting the same destination zone, right?

