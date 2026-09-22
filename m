Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D500AC982FF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 13:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0RmySBKlGGBq9L/ggLiFGvuzoukeCd8HUiktQ+sgSpQ=; b=uK+2ZbM4T2r56Zpf5UIlxGmXCm
	u/Xe+9A0hbaZQBWvA8GiUtr5kZP6dskYPwFfBbgRgp9Ic2T+sqnC+BnA8p3sZgrM3bF5c02zXpDh6
	t6zHQa3XsrmlJ4g7GMvfyBY3zaeJmYXBJiidQ/N3aUlLZGmEJ3eVawPwllmsVoOQ7O5crzQuEUjqV
	ZmcFZD7aDxYB7IYA2dzzndDXG8XLn+IfzRIitKzkhEe+CBMy21X2RI6uvjSkBq6GDi5HvP3sFZ3gk
	ebRx54xAqbwpvNjCpnVItptVFGcgNOBQ07kgiYbJhPykwygUy3H0MvmseBfj3Ngh3RVmxoAOt/z7c
	9LQWe6pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90YX-00000005WiJ-3uCo;
	Tue, 22 Sep 2026 13:29:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90YV-00000005Wha-3Aq3
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 13:29:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 301FD68BFE; Tue, 22 Sep 2026 15:29:03 +0200 (CEST)
Date: Tue, 22 Sep 2026 15:29:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v4 1/3] fs: configfs: add helpers for opening
 non-configfs paths
Message-ID: <20260922132903.GA31642@lst.de>
References: <20260921090559.41364-1-runyu.xiao@seu.edu.cn> <20260921090559.41364-2-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921090559.41364-2-runyu.xiao@seu.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_062907_941606_510D487C 
X-CRM114-Status: GOOD (  14.32  )
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

On Mon, Sep 21, 2026 at 05:05:57PM +0800, Runyu Xiao wrote:
> +bool configfs_path_is_configfs(const struct path *path)
> +{
> +	return path->dentry->d_sb->s_type == &configfs_fs_type;
> +}
> +EXPORT_SYMBOL_GPL(configfs_path_is_configfs);
> +
> +struct file *configfs_open_root(const struct path *root, const char *name,
> +				int flags, umode_t mode)
> +{
> +	if (configfs_path_is_configfs(root))
> +		return ERR_PTR(-EINVAL);
> +
> +	return file_open_root(root, name, flags, mode);
> +}
> +EXPORT_SYMBOL_GPL(configfs_open_root);

These two aren't used outside this file, so they could be static,
or in case of configfs_path_is_configfs even be folded into the
only caller.  Or do you plan to have other users?

> +struct file *configfs_file_open(const char *filename, int flags, umode_t mode)

Can you add a kerneldoc comment explaining how/why this should be used?


