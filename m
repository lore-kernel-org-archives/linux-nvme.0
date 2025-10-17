Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1163CCD199
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Oct 2025 04:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OBjQikdRqKatsJQb/j0RXPtax2Qn/aZ7x9kY1kED9uI=; b=0kGYRPNKSKBBmFhJHXNJiQdMyC
	ciJCbiINCLUs3+ZEfJmy9V86NcuG+LiZb5cWXDVlKuLiK7pfYTtzGISFuSAClJg5RyK7Uz5KgwVaJ
	QK057K0Lzrjkd/mUcV1aJ1SX+pWbgHPTha3e2VCV5IU80JTqjpBb8DCd/ELzazH/l1bhCqB4dfKN3
	PfPSfmGaC9e0pez6MLILYuJJ44bn/lZNZs1bD9cno246LbkAgCLBxwpwFqLi3EkRKdOOioGjFMhrq
	4MvqgWte9jzUzoNtqjFsnEw0dtsX4zx8YH4W3WeFioMwU/NigOvEdgPCTF9M9JAcMnLAxkzCDj9+P
	4XuHdc4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c8M-00000006XyG-08ca;
	Fri, 17 Oct 2025 04:32:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9c8J-00000006Xxd-1nhr
	for linux-nvme@lists.infradead.org;
	Fri, 17 Oct 2025 04:32:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 88013227A87; Fri, 17 Oct 2025 06:31:57 +0200 (CEST)
Date: Fri, 17 Oct 2025 06:31:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v4 6/7] nvme-tcp: Allow userspace to trigger a
 KeyUpdate with debugfs
Message-ID: <20251017043157.GB30271@lst.de>
References: <20251017042312.1271322-1-alistair.francis@wdc.com> <20251017042312.1271322-7-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017042312.1271322-7-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251016_213203_606207_206A8263 
X-CRM114-Status: GOOD (  13.71  )
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

On Fri, Oct 17, 2025 at 02:23:11PM +1000, alistair23@gmail.com wrote:
> +#ifdef CONFIG_NVME_TCP_TLS
> +#define NVME_DEBUGFS_RW_ATTR(field) \
> +	static int field##_open(struct inode *inode, struct file *file) \
> +	{ return single_open(file, field##_show, inode->i_private); } \

Please use normal indentation in the macro, but do not add an extra
level of indentation just for being inside a macro.

Then again the macro is only used once anyway, so why add it at all?

> +static ssize_t nvme_ctrl_key_update_write(struct file *file, const char __user *buf,

Please avoid the overly long line.

> +					  size_t count, loff_t *ppos)
> +{
> +	struct seq_file *m = file->private_data;
> +	struct nvme_ctrl *nctrl = m->private;
> +	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> +	char kbuf[16] = {0};
> +	int queue_nr, rc;
> +	struct nvme_tcp_queue *queue;
> +
> +	if (count > sizeof(kbuf) - 1)
> +		return -EINVAL;
> +	if (copy_from_user(kbuf, buf, count))
> +		return -EFAULT;
> +	kbuf[count] = 0;
> +
> +	rc = kstrtouint(kbuf, 10, &queue_nr);
> +	if (rc)
> +		return rc;

kstrtoint_from_user?


