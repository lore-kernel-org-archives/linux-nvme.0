Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5CD606A321
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ANM0yRRf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QUEL7ami9tBt93YnGorfmeiZG+8AFflik0IQpbpHjtQ=; b=ANM0yRRfPXquFJSaLgJIvqdzYI
	A9OrLxfhkSqHjeXE2qFMlhPCYklPKfVdI7up7F3RWrRGO/E8raU1zIUKJq7AxkHScNYcdfei/Kgas
	hYffN2nkHap4068KV5FQwG0huX9im0oyN3nFPibO7aTA+fqdxN8spWB+UiKfAKXiiBh+6m0mP/OJ2
	YdQV963zbqatzfzC2qYGlcSZkEkTd1WEP6pkIJ0nZnZ+7rHtg4cf5LvHprytLGLE1vkGydsYbOjgm
	gfCTYvkGHhSOwE6szsb59pHx5o4p8MYtfxiWK2nquXtrqwTdefJPuoSgyqI8gDsVoovJGT7R6NFHG
	Ck0EqO5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFhc-00000007kp9-0NJW;
	Wed, 11 Nov 2026 21:17:56 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlOU-00000003vrg-27pc
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 12:56:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB0C521ECA;
	Tue, 10 Nov 2026 12:56:08 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE1661339F;
	Tue, 10 Nov 2026 12:56:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o3haImgU82qJQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Nov 2026 12:56:08 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 53F33224E5; Tue, 10 Nov 2026 13:56:08 +0100 (CET)
Date: Tue, 10 Nov 2026 13:56:08 +0100
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
Subject: Re: [PATCH RFC 05/41] kernfs: use fc_init_pseudo()
Message-ID: <bktltatbokowanmaf2kqhfcjg47gok7lbk4bs2mjsbwu33tvbe@gxd5dq25slfp>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-5-4c998976c6c7@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-work-loop-pseudo-v1-5-4c998976c6c7@kernel.org>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: DB0C521ECA
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_045610_692726_E18F8BC6 
X-CRM114-Status: GOOD (  18.79  )
X-Spam-Score: -1.9 (-)
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:17:02 -0800
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

On Tue 10-11-26 10:14:21, Christian Brauner wrote:
> Initialize all kernfs based filesystems as pseudo filesystems in
> kernfs_get_tree() instead of raising SB_I_NOEXEC and SB_I_NODEV by hand
> in kernfs_fill_super(). This adds SB_I_PSEUDO for sysfs, cgroupfs and
> resctrl.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/kernfs/mount.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index a0be784bfb06..6b60d212b003 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/fs.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/mount.h>
>  #include <linux/init.h>
>  #include <linux/magic.h>
> @@ -298,8 +299,6 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
>  	struct dentry *root;
>  
>  	info->sb = sb;
> -	/* Userspace would break if executables or devices appear on sysfs */
> -	sb->s_iflags |= SB_I_NOEXEC | SB_I_NODEV;
>  	sb->s_blocksize = PAGE_SIZE;
>  	sb->s_blocksize_bits = PAGE_SHIFT;
>  	sb->s_magic = kfc->magic;
> @@ -388,6 +387,7 @@ int kernfs_get_tree(struct fs_context *fc)
>  	info->ns = kfc->ns_tag;
>  	INIT_LIST_HEAD(&info->node);
>  
> +	fc_init_pseudo(fc);
>  	fc->s_fs_info = info;
>  	sb = sget_fc(fc, kernfs_test_super, kernfs_set_super);
>  	if (IS_ERR(sb))
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

