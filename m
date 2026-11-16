Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AB2606A8AA
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tqYLhffk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/79yD/ePkhOWtFp46GUyu6ts/vcC2MmXQ7vdqbMevlI=; b=tqYLhffkj5bjKhOd+VnlETcysk
	t4I6aNubhSeLTWnvwW3g+Y3lH75pnODxvHpEM7V28Cr7BWBCFCZtv+4MkwF4rUQnJhLMaMZmyShas
	/XUAd5AULfbuQ2cYlEwTrS7LeKOZlC0RfzMxhFvnWvEG8gpK+6UFgHAo9+T7R6I+kAQ2f+ux2Mq9s
	f8wFGEj04yXwN32jHf3k4IytniEVGB4WJzoqHoH8RcBMT8JqU7WOemNBx/4AiBjPVN7Ks/TsiVczk
	xYq3/E1so913v5r01EurnTC9P7eB28Vuumoge0SzRYOVSPo2/74RAJUvsEpKJYFOzwJHfex2KKKsL
	e4xO+3yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwYA-00000002ZJw-0CBw;
	Mon, 16 Nov 2026 13:15:10 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwR0-00000002Xww-0EEa
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 13:07:47 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 19E8621DC4;
	Mon, 16 Nov 2026 13:07:44 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE2B51334C;
	Mon, 16 Nov 2026 13:07:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BvIgLh8A+2pNEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Nov 2026 13:07:43 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 6CC7424E06; Mon, 16 Nov 2026 14:07:43 +0100 (CET)
Date: Mon, 16 Nov 2026 14:07:43 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org, fuse-devel@lists.linux.dev, 
	linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v3 35/44] fs: add file_check_backing()
Message-ID: <fvmgoq6g3orrcbz5j7xoxrqkz4kc4jiopndjfar4cv45pj2y4g@bfgcucrsffnm>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-35-8cbbea1cf34f@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-work-loop-pseudo-v3-35-8cbbea1cf34f@kernel.org>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 19E8621DC4
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_050746_246811_334511C6 
X-CRM114-Status: GOOD (  45.28  )
X-Spam-Score: -4.2 (----)
X-Mailman-Approved-At: Mon, 16 Nov 2026 05:15:08 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon 16-11-26 12:05:08, Christian Brauner wrote:
> Loop, zloop, the nvme target, the scsi target, fuse passthrough, the usb
> mass storage gadget, erofs and acct all take a file from userspace and
> use it as storage. Currently, each of them has its own idea of what to
> check before using a file like that:
> 
> - loop and the gadget check for a regular file or a block device, the
>   nvme target, the scsi target and zloop take any file type
> - loop checks the open mode, the gadget checks FMODE_CAN_READ, the nvme
>   target, the scsi target and zloop only check for ->read_iter() and
>   ->write_iter()
> - apart from acct which refuses procfs and sysfs files none of them
>   cares whether the file is a kernel interface
> 
> Add a helper that does all of it in one place. It only accepts regular
> files and, if the caller passes S_IFBLK, block devices. It refuses files
> on pseudo filesystems. And it checks that the file is open for what the
> caller is going to do with it and implements ->read_iter() for reading
> and ->write_iter() for writing.
> 
> O_PATH files are refused unless the caller passes FMODE_PATH. That is
> for callers that only need the path of the file. fuse passthrough is
> one of them and has accepted O_PATH file descriptors since commit
> efad7153bf93 ("fuse: allow O_PATH fd for FUSE_DEV_IOC_BACKING_OPEN").
> 
> Block devices are fine even though bdevfs is a pseudo filesystem. A
> block device that userspace hands in is a device node on devtmpfs or
> some other filesystem. Files on bdevfs only come from
> bdev_file_open_by_*() and never end up here.
> 
> The pseudo filesystem check looks at the inode that actually provides
> the data via d_real_data_inode(). overlayfs accepts sysfs, cgroup2,
> debugfs, tracefs, configfs and securityfs as lower layers and reads of
> such an overlayfs file are served by the file on the pseudo filesystem.
> Checking the overlayfs inode would miss that.
> 
> For an O_PATH file nothing might have looked up the data yet. overlayfs
> only looks up the data of a metacopy file in a data-only layer when the
> file is opened. d_real_data_inode() does the lookup then and if that
> fails we return the error.
> 
> Note that the file type is taken from the inode of the file and not from
> the host of ->f_mapping like loop and the gadget do it. A driver can
> point ->f_mapping somewhere else in ->open(). It makes no difference for
> block devices as both inodes are block devices.
> 
> No functional changes. Nothing calls the helper yet.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/read_write.c    | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  2 ++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 6767283108991..9f1e7bfcbd4f1 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -866,6 +866,59 @@ static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
>  	return ret;
>  }
>  
> +/**
> + * file_check_backing - check that the kernel can use a file as storage
> + * @file: file that userspace handed in
> + * @mode: FMODE_READ and/or FMODE_WRITE the kernel will do I/O with, or
> + *        FMODE_PATH if only the path of @file is used
> + * @type: S_IFBLK if a block device is fine as well, 0 otherwise
> + *
> + * Call this where a file from userspace is taken as a backing file. Only
> + * regular files and, if @type is S_IFBLK, block devices are storage. Files
> + * on pseudo filesystems are kernel interfaces and are refused. The file
> + * must be open for @mode and implement ->read_iter() for reading and
> + * ->write_iter() for writing. O_PATH files are only fine with FMODE_PATH.
> + *
> + * Return: 0 on success, -EBADF if @file isn't open for @mode, -EINVAL if it
> + * can't be used as storage, or the error from looking up the data of @file
> + * on a stacking filesystem.
> + */
> +int file_check_backing(const struct file *file, fmode_t mode, umode_t type)
> +{
> +	fmode_t io = mode & (FMODE_READ | FMODE_WRITE);
> +	/* Drivers may point ->f_mapping at something else. */
> +	umode_t fmt = file_inode(file)->i_mode & S_IFMT;
> +	struct inode *real_inode;
> +
> +	/* O_PATH files are only fine for callers that just use the path. */
> +	if ((file->f_mode & FMODE_PATH) && !(mode & FMODE_PATH))
> +		return -EBADF;
> +
> +	if ((file->f_mode & io) != io)
> +		return -EBADF;
> +
> +	if (fmt != S_IFREG && !(type == S_IFBLK && fmt == S_IFBLK))
> +		return -EINVAL;
> +
> +	/* Look through stacking filesystems at the inode with the data. */
> +	real_inode = d_real_data_inode(file->f_path.dentry);
> +	if (IS_ERR(real_inode))
> +		return PTR_ERR(real_inode);
> +	if (real_inode->i_sb->s_iflags & SB_I_PSEUDO)
> +		return -EINVAL;
> +
> +	if ((mode & FMODE_READ) &&
> +	    (!(file->f_mode & FMODE_CAN_READ) || !file->f_op->read_iter))
> +		return -EINVAL;
> +
> +	if ((mode & FMODE_WRITE) &&
> +	    (!(file->f_mode & FMODE_CAN_WRITE) || !file->f_op->write_iter))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(file_check_backing);
> +
>  ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
>  			   struct iov_iter *iter)
>  {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 99caef43ff3c4..b1c7ebafbadbe 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2553,6 +2553,8 @@ static inline const struct inode *file_user_inode(const struct file *f)
>  	return file_inode(f);
>  }
>  
> +int file_check_backing(const struct file *file, fmode_t mode, umode_t type);
> +
>  static inline struct file *file_clone_open(struct file *file)
>  {
>  	return dentry_open(&file->f_path, file->f_flags, file->f_cred);
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

