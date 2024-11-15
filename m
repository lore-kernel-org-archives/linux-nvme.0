Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A46D6DDEA
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 09:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pm75xYlE75CbvokVYLXl+3gSwliF/tT8QchOJ2JV2dQ=; b=YJ5cFQINzZXFZrCSfSKuNGwvu1
	A9RSdA5tRTWJYrimPDqLy5QfKW/bOENhehNsBVtPJtF063vHSIJdP44oArwq1W5b+BSkqAvfUOOh0
	qNRUIX659yjD3GYKHx9ar6+0+LcdncrQWTl9MDH2BPtlP+ibO/mEhvSopBKdOTVDiGkaeJfnlrVWc
	UrotLONOENNrVLTgj7aXZOC8o8C+rQHFXWTAj66AAgZK7FDd1y1nxo+VednWw56DP3lOYMrL6xcZf
	TDqOfV1ZotGvQzgcLZDuIkhqgED/Z5G5MM9PgPtiu2vCAQltukfiS8UsjcI+ipRKaniW+JnOgylRU
	k0j9HE1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBsLe-0000000290W-1Ls3;
	Fri, 15 Nov 2024 09:10:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBsLc-000000028zX-2CNv
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 09:10:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 00DA968C7B; Fri, 15 Nov 2024 10:10:27 +0100 (CET)
Date: Fri, 15 Nov 2024 10:10:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
Subject: Re: [PATCH 4/6] block: add a rq_list type
Message-ID: <20241115091027.GA1149@lst.de>
References: <20241113152050.157179-1-hch@lst.de> <20241113152050.157179-5-hch@lst.de> <20241114201103.GA2036469@thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114201103.GA2036469@thelio-3990X>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_011036_718665_E52492D8 
X-CRM114-Status: GOOD (  12.51  )
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

On Thu, Nov 14, 2024 at 01:11:03PM -0700, Nathan Chancellor wrote:
> This change as commit a3396b99990d ("block: add a rq_list type") in
> next-20241114 causes errors when CONFIG_BLOCK is disabled because the
> definition of 'struct rq_list' is under CONFIG_BLOCK. Should it be moved
> out?

Yes, this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


