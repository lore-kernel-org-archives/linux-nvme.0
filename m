Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3293C5B572
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 05:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8H41Qn7w0P0HrQ02D9K5tegZop5rk1PmFzl+mEd0uNQ=; b=Aa7enlEYEuym3W9DgaG4Xms2HG
	xuWtZjXtInQjPbnSNz5DwNSI8Mzc1fMu+z2Sj+eVrZMeJRClsAh99coEfuF1Z7QAZHgNktAqzjseL
	TQl3lQfGRqe2dtHorCMYghH/V50enuDESAdKGmVeGYCE7DmK8N3uOoB6QxrWqXaiiVxKLNitF5DRr
	5uvyd8uN3zfXuGa80qhL9x6Xc7lX84jst08069ifMZBDO1o3ABksfhgEFnlDRbr4EzLMg5b6dglso
	drhTznkDsYDcJUbV/zoLFe65Q4pkrJHmUfOCwM61/DDpFkzbS7t65r8cGLvLahrH0+17zz9UqDrcJ
	nIncJaxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwZ7P-000000092RH-2vGX;
	Wed, 19 Aug 2026 05:45:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwZ7M-000000092QQ-3ZXM
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 05:45:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54C6F68CFE; Wed, 19 Aug 2026 07:45:37 +0200 (CEST)
Date: Wed, 19 Aug 2026 07:45:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-rdma: fix -EIO cleanup order in queue_rq
Message-ID: <20260819054536.GA32649@lst.de>
References: <nvme-rdma-queue-rq-eio-unmap.v1.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nvme-rdma-queue-rq-eio-unmap.v1.git.liuxixin@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_224541_042044_5418AE1F 
X-CRM114-Status: GOOD (  11.44  )
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

On Thu, Aug 13, 2026 at 05:45:00PM +0800, Xixin Liu wrote:
> -	nvme_cleanup_cmd(rq);
> +	if (err != -EIO) {
> +		nvme_cleanup_cmd(rq);
> +		ret = (err == -ENOMEM || err == -EAGAIN) ?
> +			BLK_STS_RESOURCE : BLK_STS_IOERR;

Please stick to the much more readable if/else here.


