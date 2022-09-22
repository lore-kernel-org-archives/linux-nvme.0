Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76DCC6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 14:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iuhMtWLYIz8f/ypMK0Nj2dO0ak8cl7bYyVAWpeU4oPA=; b=zgdR9SlAA7NApovWO41Xj8rjZT
	WB71Af5z4i+dEzZuQ7JirRWHIXdvFaoKV+NgWYIUPzEHPmt58KRPPlrh1Pn/2YDDQRUvhjtYwc4ew
	mgKz+/OrR6kD7hg+iQfvIqzLR1BzxZwqh8sMiqdH0SxCqt/eEi4v/AT0eZ3rBi3pgg5ZMB8H2BVwl
	2d3VINSj7c6Ye00ogwZQxvYYTiE5QpRir1uMlvo1ADQIp8sxTwKFdtfr+gA5OcsBwDoxBN1iTR/FO
	JXxqWzUF/3Mrfwf8LA1z3GXXVvDQSNx5hy/D5c7b63FUmZpQ6xNKvRe8mElyZnR8epSdIBH++MRDT
	zN/tQAhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obN31-00FxBX-0n; Thu, 22 Sep 2022 14:19:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obN2v-00Fx8o-Ov
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 14:19:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1591168AFE; Thu, 22 Sep 2022 16:19:18 +0200 (CEST)
Date: Thu, 22 Sep 2022 16:19:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 01/13] nvme: add common helpers to allocate and free
 tagsets
Message-ID: <20220922141917.GB27549@lst.de>
References: <20220920171611.1289361-1-hch@lst.de> <20220920171611.1289361-2-hch@lst.de> <cc827eb3-96d2-ff65-7204-05213bc018e8@grimberg.me> <20220922054837.GC27338@lst.de> <5a1247d3-0f0e-ef51-a9e2-82794a8c5010@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a1247d3-0f0e-ef51-a9e2-82794a8c5010@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_071921_970101_CEDC5019 
X-CRM114-Status: GOOD (  14.82  )
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

On Thu, Sep 22, 2022 at 04:09:14PM +0800, Chao Leng wrote:
> Maybe we should not add the checking of NVME_F_FABRICS.
> +	if (ctrl->ops->flags & NVME_F_FABRICS) {
> +		ctrl->fabrics_q = blk_mq_init_queue(set);
> +		if (IS_ERR(ctrl->fabrics_q)) {
> +			ret = PTR_ERR(ctrl->fabrics_q);
> +			goto out_cleanup_admin_q;
> +		}
> +	}
> nvme_alloc_admin_tag_set should not check NVME_F_FABRICS either.
> The new helpers is just used for fabrics.

Right now.  As mentioned in the cover letter I plan to use it for
PCIe nvme-apple as well.  But that will need more work, including
block layer work for request_queue refcounting first.

