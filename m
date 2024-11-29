Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFACD6EBEE
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 08:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WeOdfkcz/bbr3KBju5TknUILGmfQ/psDhGM0NLqB0A8=; b=T4HJtwbRGuGLrDrQ3VwGvEI7mp
	qLuTsYdpsYfwAVZlHHdfnxkjYrYgFZARuj/Cj3ciphdt9vI6adHwhFYe43e8u7j9cxPUORz+V/Kci
	n+leuQwItwzyM5NmrHuhs7nfLDx0knxpY/YH5zyQJatrmmCLgvX6daQTYKisKFuNv6ZU7u9zaS08R
	6r/C/ER2+XwwQdehvqjvCUGugnoySH/bmgSExlQ7u1y9gnVuWxK+zIoy5UU7KIMh1Cr68bqnJ8WY3
	o9lnIN402l0qG82QzvONfBkEN0VAHUHJ5JmI+x0Kxw+JhnlSbd7F2gYmpbu8v+CHsGsdMJrWwAyXL
	+enRfLvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGw6Z-0000000H9Fa-3RVL;
	Fri, 29 Nov 2024 08:11:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGw6Y-0000000H9EV-0Yc8
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 08:11:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 06BFB68CFE; Fri, 29 Nov 2024 09:11:54 +0100 (CET)
Date: Fri, 29 Nov 2024 09:11:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] nvme-tcp: simplify
 nvme_tcp_configure_admin_queue()
Message-ID: <20241129081153.GD6819@lst.de>
References: <cover.1732699313.git.chunguang.xu@shopee.com> <8282314c0d688f51be9f9ee90cd3463ff76baa1f.1732699313.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8282314c0d688f51be9f9ee90cd3463ff76baa1f.1732699313.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_001158_308572_C5E8BAFB 
X-CRM114-Status: GOOD (  13.85  )
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

On Wed, Nov 27, 2024 at 05:27:50PM +0800, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> As nvme_tcp_configure_admin_queue() is the only one caller of
> nvme_tcp_destroy_admin_queue(), so we can merge nvme_tcp_configure_admin_queue()
> into nvme_tcp_destroy_admin_queue() to simplify the code.


Need a little fixing for the line length here in the commit message,
but otherwise looks good:


Reviewed-by: Christoph Hellwig <hch@lst.de>

