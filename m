Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D07CD5BD0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 13:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GvNA3oOuZVbGTJRJR3hCXHRcZPdQZoGiLD4FcxxJP/g=; b=ZXGQyKMkGaP8Qtb7JOqZSxqLig
	fb9BV8ccJVqjCWOTwTGQh3UMjSDLodOhagS6yK1q/uDo3d2HeNOsskc6u/tjqsaO9KI6yqx5+EoNL
	fk386zLIYSbAK5NA7zftrODck8Uwp0aa8IZHQju7gHO9TorByQcbz+w+tGHpQnHjOpjBr5ZOh388m
	ue0DkSvbb1wJ9Nxm68wOMXT5wz8rKQfCy12/XtsUrR0FRCJd2iLYAg0r0ycxiRaFwTg9hTsyWJuI/
	57FeavH8zHFNr3GRyH+FPoFVEdsu0rHfbBL1GQNxJNakI9mstU/HAV7pTntojxb+rCFAFFN8jgAIs
	nNxyFNzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEYy-00000004EDo-1vib;
	Wed, 27 May 2026 13:44:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEYw-00000004ECI-0dhQ
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 13:44:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0965F68B05; Wed, 27 May 2026 15:44:42 +0200 (CEST)
Date: Wed, 27 May 2026 15:44:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geliang Tang <geliang@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Roy Shterman <roys@lightbitslabs.com>,
	Solganik Alexander <sashas@lightbitslabs.com>,
	Hannes Reinecke <hare@suse.de>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvmet-tcp: fix page fragment cache leak in error
 path
Message-ID: <20260527134441.GA12536@lst.de>
References: <e4df8752611dc5914f849b1d17f5512434b954cb.1779787061.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4df8752611dc5914f849b1d17f5512434b954cb.1779787061.git.tanggeliang@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_064446_334113_64FE688F 
X-CRM114-Status: GOOD (  12.01  )
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

On Tue, May 26, 2026 at 05:22:22PM +0800, Geliang Tang wrote:
>  out_ida_remove:
>  	ida_free(&nvmet_tcp_queue_ida, queue->idx);
> +	/* Drain the page fragment cache if any allocations were done.

Kernel style is to keep the

	/*

on it's own line, but otherwise this looks great.  I think we can just
fix this up when applying.

Reviewed-by: Christoph Hellwig <hch@lst.de>

