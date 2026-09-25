Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C78C9830D
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2026 06:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YGEj3pk3f9w2EK3J51qdT6ybyq1ME1h4zMKqxj/KJz4=; b=KIK7H1knCb12pyGvvX2zq3JTOz
	GN9idREVw061JFdE1uUWKSopkdB63fFf8NYWcOgWoLssutTMVrAzr4gac5WzlPmDlSR+CR8i3tsv9
	DPZLtooED6IaDvmuZGv4Vt3It7+7KxwCmf6ycGNgIiwfg41FbNFRrfTzMi4qRCk4N8Er36JWO+EmE
	Xa/6oldHGjz4hFwF+2Dnc3JVa3e7g3fKKcWZ44g7awXae+KclUYxsTDze2YE4eK+c9F7uPAv+7utD
	xvEuhmfogq8yefhabpWRtSz97ZZYsI6QHPgJKPIcwsO5h4chdqkUazmVreFOGIUW/kCgOQyxw2x0J
	0U9wyOWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9zc9-0000000ClZf-2xBD;
	Fri, 25 Sep 2026 06:40:57 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9zc7-0000000ClZQ-1jvw
	for linux-nvme@bombadil.infradead.org;
	Fri, 25 Sep 2026 06:40:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YGEj3pk3f9w2EK3J51qdT6ybyq1ME1h4zMKqxj/KJz4=; b=QW2OBnPC0A26kqEuotxCLvu2lk
	dmD1QPG+qsQai76YTT23889yClyawi0EBuV/e1DZFGfuK4d5bYBGj4lRQR0M2Bwg/rvVrHJxPnlBR
	YwrqzS14k+DdBJVlWkXMkuML/iIRxeY89UdHjLUYdWWK3ZXhI/0x+3SxPssvW2Zy4ICuj5Hf/FW/2
	+jnopJTntdS8zHxxReXH/kscicHGghRdOYiru81BxSB/1FNN93IlPIVBm1trZyfQ1D0v8hL+8yk7o
	olwBv1eLOJQphMslFYe1cb/qqMQYfHRRJDwloxmbNXPlUIxpWtQK8XGtFM2kb/ItNxLaXjgSO10zq
	/jBuKrfw==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9zbz-0000000Geop-40Vg
	for linux-nvme@lists.infradead.org;
	Fri, 25 Sep 2026 06:40:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0E45068BFE; Fri, 25 Sep 2026 08:40:39 +0200 (CEST)
Date: Fri, 25 Sep 2026 08:40:38 +0200
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
Message-ID: <20260925064038.GA4025@lst.de>
References: <20260921090559.41364-1-runyu.xiao@seu.edu.cn> <20260921090559.41364-2-runyu.xiao@seu.edu.cn> <20260922132903.GA31642@lst.de> <20260923023923.2002144-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923023923.2002144-1-runyu.xiao@seu.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_074048_191081_161E81A2 
X-CRM114-Status: GOOD (  22.86  )
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

On Wed, Sep 23, 2026 at 10:39:23AM +0800, Runyu Xiao wrote:
> > > +EXPORT_SYMBOL_GPL(configfs_open_root);
> >
> > These two aren't used outside this file, so they could be static,
> > or in case of configfs_path_is_configfs even be folded into the
> > only caller.  Or do you plan to have other users?
> 
> I folded the filesystem-type check into configfs_open_root() and dropped
> the predicate entirely.  configfs_file_open() is for callers that have a
> pathname, while configfs_open_root() is for callers that keep a resolved
> root and open files below it.

Which callers are those?  There are none in this series, so right now
this is just adding dead code.  If you have other callers, please send
everything in one series, as it needs to go together.

> 
> > > +struct file *configfs_file_open(const char *filename, int flags, umode_t mode)
> >
> > Can you add a kerneldoc comment explaining how/why this should be used?
> 
> I will add kerneldoc comments for both helpers in v5.

The versions added look like extremely verbose AI generated text.
Please use your own brains and your own voice to write a concise
description.

> 
> > Didn't you also have patches for drivers/target/ that should use
> > the new helper?
> 
> Yes.  The target-core patch titled "scsi: target: pin db_root for metadata
> writes" is another consumer of configfs_open_root().  I will rebase that
> patch on this series and drop its duplicate configfs changes.

Please merge everything into one series.


