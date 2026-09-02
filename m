Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7378FC624D6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 10:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NntrNa+LjbXzL5+NEwgwv5qKKR87HRQq40P/TzsbGMM=; b=MCPAFt5QIbbCkQ1JuLPyI7kT0v
	cvwVgD7L7LAfG6ois85WRTkekI0t6GAgMTM800Ad1+z5sO6msFM9NJrCMM2e+QftnwPhjj2fhuK+R
	efl662tqvCTf/UiWxTpidcIlXlJRZgyeWo8tI99xjpQHL1HvUT+hSEH/1yDuosVMLwD/YyvjBqd2Y
	guh+tXx0jXwWEbcAEp+Qi8UWak88FmE4ie9Dwf3viMTEeE+TWT+9mct+suKjKPWp6+TB63mnws99b
	E5hHxlxV+IPIbE46qyiJhGd5jXxd+0Y+ck1Op+1KdKlrzQbzzRAUtpzKOwsvhCyeLhOFVS9MATbi3
	S7ormOBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1iGH-0000000EMLa-0VYI;
	Wed, 02 Sep 2026 10:32:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1iGF-0000000EML9-0PRm
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 10:32:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 82B5368BEB; Wed,  2 Sep 2026 12:32:03 +0200 (CEST)
Date: Wed, 2 Sep 2026 12:32:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v2 2/3] nvmet: avoid recursive configfs open for
 file-backed namespaces
Message-ID: <20260902103202.GB8095@lst.de>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn> <20260819155228.84938-1-runyu.xiao@seu.edu.cn> <20260819155228.84938-3-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819155228.84938-3-runyu.xiao@seu.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_033207_296990_C2F59804 
X-CRM114-Status: GOOD (  12.63  )
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

> +	ret = kern_path(ns->device_path, LOOKUP_FOLLOW, &path);
> +	if (ret) {
> +		pr_err("failed to open file %s: (%d)\n",
> +		       ns->device_path, ret);
> +		return ret;
> +	}
> +
> +	if (configfs_path_is_configfs(&path)) {
> +		pr_err("configfs paths cannot back namespace %s\n",
> +		       ns->device_path);
> +		path_put(&path);
> +		return -EINVAL;
> +	}
> +
> +	ns->file = dentry_open(&path, flags, current_cred());

This section of code really should have a helper in configfs.  And should
also be used in other callers like the SCSI target patches you also sent
out.


