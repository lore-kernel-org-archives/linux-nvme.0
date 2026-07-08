Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107CCC43458
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2026 09:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=orFT7TUeQckYmdEgKMD7lJFtMHQNexAlCE6rd5Gl6HI=; b=2AYzS7wid1UEllnKSyb4cwdv2V
	lIy94ccWRKCVOhZqMV95jWIfaNAQy55mXqVb85uqpYGH94VjmpwZ4IaasxtLPzDpVHc4Ddr0CtL+G
	6ePz4ae42GhtraJ0gwelkdWI5XThpvTgyI3yd6sV/y8lKf8obHg3r5EFDZ+SCB3dQ2i06ix8pYSdU
	YOcpzV4hIq74tHokMWs+p2GFo+oB/xoD3Q6REzpKqnpxixxAtsizfgcIeZXzVl7WJMa1jnLrf2k3j
	1qZB7K5f1K/PrGWghbYBpHbw/SuuPotYMxCnu7H+RSkC/MKbiPMq6sADXzQavXq39N+WmX8i2hSTd
	px8X5TvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whOPd-0000000GjTW-3KvS;
	Wed, 08 Jul 2026 09:17:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whOPa-0000000GjSh-2gd7
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jul 2026 09:17:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E3C9968BFE; Wed,  8 Jul 2026 11:17:42 +0200 (CEST)
Date: Wed, 8 Jul 2026 11:17:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: don't reference NS after unlocking in
 nvme_ns_head_ctrl_ioctl()
Message-ID: <20260708091742.GA6513@lst.de>
References: <20260706125402.615277-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706125402.615277-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_021746_825349_148AF045 
X-CRM114-Status: GOOD (  11.17  )
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

On Mon, Jul 06, 2026 at 12:54:02PM +0000, John Garry wrote:
> In nvme_ns_head_ctrl_ioctl(), once we drop the SRCU read lock we should
> not reference the NS to lookup the controller, so use the available
> controller pointer directly.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


