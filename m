Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C64C98302
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 02:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QhgHqZwIqPh5M6LZoA1GVbbob+NtuP/+uxfc51TgGmQ=; b=oxRWUpKqQQ/Zy/w+x4Z1m/MsC2
	a5gENbQZxcqBgmV0wr0ciz8rp4+GR8wh0Rnxye/znIlbqoKl43IlLx3IeqKP6mkO/wxlEjLAQG//2
	C/20lLc4+W1AfGzr511dk7xCQ8+jOPxrUpOZyZOtsfPzQdnFr7/MT0Ilh1BRmIfo0JRSXbO+yETYM
	IPfpRRVrl39dfa9IP6UQKGqneegxUHa2aEe1y7n7WX7zGogPUdpdiGIFsmE4lq1mzvsA/pNw18Lnd
	LxySDfrANXZgITu4rTOIr3AOb0w/SlPmZt4cN7BPD9/SKtBT4R8ws6MLjH2CfxHFQgO6j66yZ/pid
	TmMI+PsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Cta-00000006xBO-18ii;
	Wed, 23 Sep 2026 02:39:42 +0000
Received: from mail-m49197.qiye.163.com ([45.254.49.197])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9CtX-00000006xB2-1yVq
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 02:39:41 +0000
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ecd1d1b9;
	Wed, 23 Sep 2026 10:39:29 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v4 1/3] fs: configfs: add helpers for opening non-configfs paths
Date: Wed, 23 Sep 2026 10:39:23 +0800
Message-Id: <20260923023923.2002144-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922132903.GA31642@lst.de>
References: <20260921090559.41364-1-runyu.xiao@seu.edu.cn> <20260921090559.41364-2-runyu.xiao@seu.edu.cn> <20260922132903.GA31642@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0cc21e9fb03a1kunm6371805db4002
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSE9CVkhJT01CTxofTU9OGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=Uos8wgfWuvg97hGTXQCimpeDGL/KxfneoDrqQgzr79MbLXoTX6xxbEolj66AVIcvQQYC1fciY+/eyLfjWaya06i/eLR8by5hihZKBF3c2DvX8w5+Rc+p25g6Sp/dJXdhd/oINhxC/K7oQLtkVB4znv8WiRlgFEL4NVQmkTuBE3I=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=QhgHqZwIqPh5M6LZoA1GVbbob+NtuP/+uxfc51TgGmQ=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_193939_680576_EFB28DD8 
X-CRM114-Status: GOOD (  15.18  )
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

Thanks for the reviews.

> > +bool configfs_path_is_configfs(const struct path *path)
> > +{
> > +	return path->dentry->d_sb->s_type == &configfs_fs_type;
> > +}
> > +EXPORT_SYMBOL_GPL(configfs_path_is_configfs);
> > +
> > +struct file *configfs_open_root(const struct path *root, const char *name,
> > +			int flags, umode_t mode)
> > +{
> > +	if (configfs_path_is_configfs(root))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	return file_open_root(root, name, flags, mode);
> > +}
> > +EXPORT_SYMBOL_GPL(configfs_open_root);
>
> These two aren't used outside this file, so they could be static,
> or in case of configfs_path_is_configfs even be folded into the
> only caller.  Or do you plan to have other users?

I folded the filesystem-type check into configfs_open_root() and dropped
the predicate entirely.  configfs_file_open() is for callers that have a
pathname, while configfs_open_root() is for callers that keep a resolved
root and open files below it.

> > +struct file *configfs_file_open(const char *filename, int flags, umode_t mode)
>
> Can you add a kerneldoc comment explaining how/why this should be used?

I will add kerneldoc comments for both helpers in v5.

> Didn't you also have patches for drivers/target/ that should use
> the new helper?

Yes.  The target-core patch titled "scsi: target: pin db_root for metadata
writes" is another consumer of configfs_open_root().  I will rebase that
patch on this series and drop its duplicate configfs changes.

The separate patch titled "scsi: target: file: avoid recursive configfs open
in fd_init_prot()" will use configfs_file_open(), not configfs_open_root().

I will send v5 as a new thread.  Patches 2/3 and 3/3 are unchanged and
retain your Reviewed-by.

Thanks,
Runyu

