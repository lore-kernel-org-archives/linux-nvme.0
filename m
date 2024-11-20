Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FD4D6E2DD
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2024 09:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qBZ6UUZZwvEQL67qJwpQZ+nmkrlZxJXle7enHkkmbv8=; b=G8BuQCnGhNbTVfcy+mNg2kuI2s
	dmhaFb2Um+HrmXjPDfoXaiz9HmKXQkLPT2dkoBODmK4UsIlke731jqcwkfXFsw9tYVqcZRTJQAeN+
	ENOjagZQtWTpVlEWhv5OATxhsFclugNhyZ5ErPqTZZCXY6uH3WfkPdmgWSr+1410dZ2gZuQd01ydp
	JkKXiL4VzJov7g1snPlj63seFvLzu08Nlesp5rxw8eAnUnNNOHEubD26MxQT/WlgqaRbfnKHAEe84
	+6SOwVxp+bKsb8Hyy07mvL/Z8WwbJnU1YngfCPYCndyafEt/lmcsbkReBHkhx8jPkKXWh7GKHQXVe
	+PQEs9KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDgfo-0000000EqvJ-3h7N;
	Wed, 20 Nov 2024 09:06:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDgff-0000000EqsC-0gZt
	for linux-nvme@lists.infradead.org;
	Wed, 20 Nov 2024 09:06:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B0D9A68D47; Wed, 20 Nov 2024 10:06:39 +0100 (CET)
Date: Wed, 20 Nov 2024 10:06:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/2] nvme: introduce change ptpl and iekey definition
Message-ID: <20241120090639.GA16607@lst.de>
References: <20241120071008.106933-1-kanie@linux.alibaba.com> <20241120071008.106933-2-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120071008.106933-2-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241120_010647_340497_966865DD 
X-CRM114-Status: GOOD (  12.43  )
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

On Wed, Nov 20, 2024 at 03:10:07PM +0800, Guixin Liu wrote:
> This is for the next tuning pr code more readble patch, make
> linux/nvme.h's changes separately.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


