Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42C1D1F9B0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 10:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mYIPCZ9n2K8+l0Gix4a6otBKT7xg4fSdpmU162wQnJQ=; b=mgvQI35Q+5XmHfoXXAnixqo/sD
	MEZARcGDoIvFgaPCbUjbAZZxCxsOVOsuy8d8v34kgS6tD0/SbGJjXc5Wfr50S9ZS1TP/KNBud9JIy
	u5g2Y3TbXcugyTEfPoYDULxng1j9bpRzVB66xt/xOUtV5TmtBeBxVJYuvAJdafLX9XO/FVhkF/76E
	vBmkN4mYnEuFWNeU2oSCwWghfGhBMT1jTim36Bx6P4y6Rj31+fTysUAe/dWiVPgrCJQfVviPoWaTn
	MMFw8sjuw1L6VFujJ9TUOP/bwH/JDiZinHAKd2lFxTMz/D8efiSu0S74Bo9FJrVyMFLvnywCstnmp
	qVnAySTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR6nD-00000007r2O-26Hi;
	Thu, 04 Dec 2025 10:42:35 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR6n9-00000007r23-1Ff2;
	Thu, 04 Dec 2025 10:42:31 +0000
Date: Thu, 4 Dec 2025 02:42:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC v2 01/11] file: add callback for pre-mapping dmabuf
Message-ID: <aTFllxgsNCzGdzKB@infradead.org>
References: <cover.1763725387.git.asml.silence@gmail.com>
 <74d689540fa200fe37f1a930165357a92fe9e68c.1763725387.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d689540fa200fe37f1a930165357a92fe9e68c.1763725387.git.asml.silence@gmail.com>
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

On Sun, Nov 23, 2025 at 10:51:21PM +0000, Pavel Begunkov wrote:
> +static inline struct dma_token *
> +dma_token_create(struct file *file, struct dma_token_params *params)
> +{
> +	struct dma_token *res;
> +
> +	if (!file->f_op->dma_map)
> +		return ERR_PTR(-EOPNOTSUPP);
> +	res = file->f_op->dma_map(file, params);

Calling the file operation ->dmap_map feels really misleading.

create_token as in the function name is already much better, but
it really is not just dma, but dmabuf related, and that should really
be encoded in the name.

Also why not pass the dmabuf and direction directly instead of wrapping
it in the odd params struct making the whole thing hard to follow?

