Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6D5C5DF6D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 05:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=do7achXnJ1oTlGHyK35YxPeNDqypv3a754o6hNJeG48=; b=K8dRkjx4pcMzuDJ8/MX9sYmhvB
	/iaYj6W6x8dM/edKy8JokOsjRYXCo1tdvEqw3xsvqvO0ZnZspF6D+BG8WQRyYxGIY6/YzHb5m0pp2
	y8J38Iuctg83+M0Y2wQ0v9K5Eb0KoMl7cvIG8Ll0cpJzgX3FVmhZp76zf3RLmojgehbBH5ua+zn1d
	460X4Nmp5ol044tCOeeQFcUTkx9qQPfUVXLlLUqIhCNu6CWiLtRZ4o+eLc0LZtny+ayCyOIv62CeR
	LQRt6dZZl59sBsUdt1oCy385/1aTyixWdpkNfXNJsXC6/1TxATHuyXRPh8YiAJ4/PwvwZ5p2cxhtj
	6jlu50DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwZ8a-000000092Ys-0CZ8;
	Wed, 19 Aug 2026 05:46:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwZ8Y-000000092YO-0oql
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 05:46:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D680268CFE; Wed, 19 Aug 2026 07:46:50 +0200 (CEST)
Date: Wed, 19 Aug 2026 07:46:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH 1/2] nvmet: avoid recursive configfs open for
 file-backed namespaces
Message-ID: <20260819054650.GB32649@lst.de>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn> <20260817143714.1344255-2-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817143714.1344255-2-runyu.xiao@seu.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_224654_384670_EE03C0AD 
X-CRM114-Status: GOOD (  11.74  )
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
> +	if (!strcmp(path.dentry->d_sb->s_type->name, "configfs")) {
> +		pr_err("configfs paths cannot back namespace %s\n",
> +		       ns->device_path);
> +		path_put(&path);
> +		return -EINVAL;
> +	}

String comparisons are a bit weird, checking the actual file_system_type
is a lot cheaper and more safe.  And please move this into a helper
in configfs as I bet there are tons of other users like this and they'd
benefit fro ma common helper.

