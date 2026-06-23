Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30F7CD98F2
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 12:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mh9BxkZKhF75YYaZJCyW42tNBJ5dFvL68uL9K+9zjR8=; b=qKV86L3gcGLUNeIRABIOTcgq69
	Nylxgmdh3bXCbFuaVvSRUr+KMHCExzEuzTixvbtLBCwVgkh+GLH9BmqKeQgpxB7YHVcFlJ8Pq+e0k
	APcwDvQ0KnJTPw0X2zN1b65HHBz/iNK+vi1H6BFgU1L11aTJ1cGAJpy3J6ivhyC2Nl5t4FUlQBEL3
	9QhngarYtjIvAu0UkNLAWIE+ltUjrFmdWDC68dsm27SwrB1gq6YXCmIELwNq3VWc4u0b5ebMID2C6
	7WEpyRKTvKrEIGB7Vn7Px4vyzKsFjoy9dIRzJmuah+q1DYOYZl43Jn4mgAtnZbifKQFREkjrJMHTo
	oySrSvrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc0aw-00000006Hx9-3Qqa;
	Tue, 23 Jun 2026 12:51:14 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc0au-00000006HwA-1riq
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 12:51:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mh9BxkZKhF75YYaZJCyW42tNBJ5dFvL68uL9K+9zjR8=; b=LiQFJplKKHlTJAvsfdhJX3hvsj
	tkg2tYRKP2kQq4n3/eG8v0tGk7rT48aWRyFLOHYQDL1DCKDc6AO7fCMDJylL+jWJIU8nmWfmQzM7P
	gy6FLJ/ky8mtRPdIYMtWiT7PakXOBXH9FCYzAoN2xbpUhtoPCOx+cD/7YrUAAO12SUvfAFuQgiRoO
	zrl4zoYHahQ9RIYGvTDc9mi4E8/NXop40u8jW5AM6mJAn9jY6l5PtDjFCwGAn9flN57RUD5yjQlU1
	XMjq1zebAI1xwW5Nl3jtIA+V84cLg3fh6tlVvHzhuXoGe0fuhaeXX83E7S7CJOc2XU3Kd+8Yd/bz8
	7ckSV4xQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wc0aa-001ey8-11;
	Tue, 23 Jun 2026 12:50:52 +0000
Date: Tue, 23 Jun 2026 05:50:46 -0700
From: Breno Leitao <leitao@debian.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH RFC v3 01/12] fs/configfs: rework configfs_is_root()
Message-ID: <ajqASYHIzw3k7Okn@gmail.com>
References: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
 <20260623-configfs-ns-v3-1-841c100fd5dd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623-configfs-ns-v3-1-841c100fd5dd@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_055112_487272_DC99439E 
X-CRM114-Status: GOOD (  19.11  )
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

hello hannes,

On Tue, Jun 23, 2026 at 11:15:46AM +0200, Hannes Reinecke wrote:
> In preparation for making configfs namespace-aware rework
> configfs_is_root() to not rely on static structures but
> rather use the information in the structures themselves.> 

Thanks for the cleanup.  The approach looks fine: CONFIGFS_ROOT is
only ever set on the single static configfs_root dirent.

Nit: "namespace-aware rework configfs_is_root()" reads as if a comma is
missing -- "... namespace-aware, rework configfs_is_root() ...".





> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  fs/configfs/configfs_internal.h | 2 +-
>  fs/configfs/mount.c             | 9 +++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
> index acdeea8e2d69ac9d621e1a42b039719811c31757..6261e1f3ec201a58a5d46b08dfbced8c2a44d82b 100644
> --- a/fs/configfs/configfs_internal.h
> +++ b/fs/configfs/configfs_internal.h
> @@ -63,7 +63,7 @@ extern spinlock_t configfs_dirent_lock;
>  
>  extern struct kmem_cache *configfs_dir_cachep;
>  
> -extern int configfs_is_root(struct config_item *item);
> +extern bool configfs_is_root(struct config_item *item);
>  
>  extern struct inode * configfs_new_inode(umode_t mode, struct configfs_dirent *, struct super_block *);
>  extern struct inode *configfs_create(struct dentry *, umode_t mode);
> diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
> index 4929f343118946eaa55a539db4192e9c6621a8dc..88da7b428e52f2f4ab139ad3907101f685d617b1 100644
> --- a/fs/configfs/mount.c
> +++ b/fs/configfs/mount.c
> @@ -47,9 +47,14 @@ static struct config_group configfs_root_group = {
>  	},
>  };
>  
> -int configfs_is_root(struct config_item *item)
> +bool configfs_is_root(struct config_item *item)
>  {
> -	return item == &configfs_root_group.cg_item;
> +	struct configfs_dirent *sd;
> +
> +	if (!item->ci_dentry)
> +		return false;
> +	sd = item->ci_dentry->d_fsdata;
> +	return !!(sd->s_type & CONFIGFS_ROOT);

The old helper was a pure pointer comparison and never touched item, so it
tolerated a NULL or not-yet-attached item.  The new one dereferences
it (item). I suppose that item is never being called as NULL?!

Thanks
--breno

