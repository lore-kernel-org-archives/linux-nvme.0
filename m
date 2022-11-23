Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AA0C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Nov 2022 06:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zb+b/kQNpZ1iqoMRAgUR5SFjg/VsZKZLzWh53TxILaY=; b=1e/XfWfVtJlDSi4ug4XUkLjD8Q
	IrP7dZKWr6ItTcei0cdCrul63SKwTU+WAnzxhcWDAgrr5Bp1XF9WWQS2sBOVusBWpvpANUqO+CaN3
	fSRg8zn1bsRjhKibOjIN7IuOYVt1QKIrezJKarxPlBrtZrkFfdF+hbxIBSY09YO4LCrlwSlqNsjV3
	hrGB8oIeYCzsPA3DtGLYzAPLv1lc+6ZHet5PDrmsVfy4oyTdhY0ok4GhW4EcwAhPlAofTBKhVT1WF
	nu3SgrveDtjOMZSQPc+jvwbJGEPGv3HwqMBE6tkAf1Lp9EQqlY8ARCqLUmVu4ReGA4vCmhj+5yZLx
	JGvxUkSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxjdW-00EvJG-At; Wed, 23 Nov 2022 06:53:34 +0000
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxjdQ-00EvHP-Ce
	for linux-nvme@lists.infradead.org; Wed, 23 Nov 2022 06:53:30 +0000
Received: by mail-vs1-xe36.google.com with SMTP id p4so16606558vsa.11
        for <linux-nvme@lists.infradead.org>; Tue, 22 Nov 2022 22:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zb+b/kQNpZ1iqoMRAgUR5SFjg/VsZKZLzWh53TxILaY=;
        b=cbA+BA8+j8SetnMRGa68JJNXTTDD8h6MmbwDKtZ5PRWjQOfHGMfAi8tfjuoCxIu7Lf
         g+CnRIhCyD0OX7r/G/0rW24bn41X3H8Z+oIU4Fizh2H23Hsq1afG0qkvKt4eDV5HIHdd
         xHxTwdZTH9V7s5njavuTQ9rfH85INqJoICys2pJ8wdgvYN2p2mqF6InwhYksdfGQm9/K
         WOovykkZP9Bxwqy44D6FYZUqgk3OTwUo6lTAXBiT+6lubDXgw/2tG4lzcd9n4fyWlzPk
         RHWbIb26fA944e3LVY3AzeWzUJ0Lf+XU41mAm5btSf5wgSSVAJjXX9DWDEzQsQIPJ7HC
         YKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zb+b/kQNpZ1iqoMRAgUR5SFjg/VsZKZLzWh53TxILaY=;
        b=X9vG8gUQsf/NoSaE17R3Ey0xCwYVfPj1m3Zy8SiR6uBdVXDR8/dgAqS1k8edSKUGQI
         8I1Pacgaw02mod/iIJlwuJW8keBtR9hGKPuSUrMKeilT9mPmUMU9pPcQj6FnYOa9mp29
         4tmxuCayxyisaZg7VepJfwgLHeSttIWW/xOuNnfGFwZoETIWfXDH1JXm9KPOFNxK3nKI
         ga4NsuGtEaxg+xXz2Y3cM3KLjvqbYWfeFBXHpcygSQg+xygQvPmFvaoBW7pnBMfNOADQ
         7RgMQVtFRDCAHL8idPjLw04o/jAn65brO4ckb1cHq3OXoNS6koI9A3NdJvu8yM2kt1zT
         zgfA==
X-Gm-Message-State: ANoB5plAwZCYNtFaIhKcpwyoupsJ0eJ5zCP6m1AnO/Z6IHkwMshaGFjd
	12LnyD70I3B8kHpn220sYeEZkNm/iPDhH1FCYck=
X-Google-Smtp-Source: AA0mqf55Qvs1RVFZgpUB9hHpNmee060lzqmCf3GfjJCl+IAQ8LG2Guwv4fTQaouwtHsAyvEWcII2JptzlFh9ndmXW3Q=
X-Received: by 2002:a67:f60d:0:b0:3b0:6bb1:3168 with SMTP id
 k13-20020a67f60d000000b003b06bb13168mr2537799vso.36.1669186406338; Tue, 22
 Nov 2022 22:53:26 -0800 (PST)
MIME-Version: 1.0
References: <CGME20221123061044epcas5p2ac082a91fc8197821f29e84278b6203c@epcas5p2.samsung.com>
 <20221123055827.26996-1-nj.shetty@samsung.com> <20221123055827.26996-11-nj.shetty@samsung.com>
In-Reply-To: <20221123055827.26996-11-nj.shetty@samsung.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 23 Nov 2022 08:53:14 +0200
Message-ID: <CAOQ4uxhMX9MF0+6DD7NO5QzqDRwESkhiY5f9CB7DXFVa22Za+w@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] fs: add support for copy file range in zonefs
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, james.smart@broadcom.com, 
	kch@nvidia.com, damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com, 
	jth@kernel.org, viro@zeniv.linux.org.uk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, anuj20.g@samsung.com, joshi.k@samsung.com, 
	p.raghav@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_225328_477934_27532BB4 
X-CRM114-Status: GOOD (  30.27  )
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

On Wed, Nov 23, 2022 at 8:26 AM Nitesh Shetty <nj.shetty@samsung.com> wrote:
>
> copy_file_range is implemented using copy offload,
> copy offloading to device is always enabled.
> To disable copy offloading mount with "no_copy_offload" mount option.
> At present copy offload is only used, if the source and destination files
> are on same block device, otherwise copy file range is completed by
> generic copy file range.
>
> copy file range implemented as following:
>         - write pending writes on the src and dest files
>         - drop page cache for dest file if its conv zone
>         - copy the range using offload
>         - update dest file info
>
> For all failure cases we fallback to generic file copy range
> At present this implementation does not support conv aggregation
>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  fs/zonefs/super.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 179 insertions(+)
>
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index abc9a85106f2..15613433d4ae 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1223,6 +1223,183 @@ static int zonefs_file_release(struct inode *inode, struct file *file)
>         return 0;
>  }
>
> +static int zonefs_is_file_copy_offset_ok(struct inode *src_inode,
> +               struct inode *dst_inode, loff_t src_off, loff_t dst_off,
> +               size_t *len)
> +{
> +       loff_t size, endoff;
> +       struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
> +
> +       inode_lock(src_inode);
> +       size = i_size_read(src_inode);
> +       inode_unlock(src_inode);
> +       /* Don't copy beyond source file EOF. */
> +       if (src_off < size) {
> +               if (src_off + *len > size)
> +                       *len = (size - (src_off + *len));
> +       } else
> +               *len = 0;
> +
> +       mutex_lock(&dst_zi->i_truncate_mutex);
> +       if (dst_zi->i_ztype == ZONEFS_ZTYPE_SEQ) {
> +               if (*len > dst_zi->i_max_size - dst_zi->i_wpoffset)
> +                       *len -= dst_zi->i_max_size - dst_zi->i_wpoffset;
> +
> +               if (dst_off != dst_zi->i_wpoffset)
> +                       goto err;
> +       }
> +       mutex_unlock(&dst_zi->i_truncate_mutex);
> +
> +       endoff = dst_off + *len;
> +       inode_lock(dst_inode);
> +       if (endoff > dst_zi->i_max_size ||
> +                       inode_newsize_ok(dst_inode, endoff)) {
> +               inode_unlock(dst_inode);
> +               goto err;
> +       }
> +       inode_unlock(dst_inode);
> +
> +       return 0;
> +err:
> +       mutex_unlock(&dst_zi->i_truncate_mutex);
> +       return -EINVAL;
> +}
> +
> +static ssize_t zonefs_issue_copy(struct zonefs_inode_info *src_zi,
> +               loff_t src_off, struct zonefs_inode_info *dst_zi,
> +               loff_t dst_off, size_t len)
> +{
> +       struct block_device *src_bdev = src_zi->i_vnode.i_sb->s_bdev;
> +       struct block_device *dst_bdev = dst_zi->i_vnode.i_sb->s_bdev;
> +       struct range_entry *rlist = NULL;
> +       int ret = len;
> +
> +       rlist = kmalloc(sizeof(*rlist), GFP_KERNEL);
> +       if (!rlist)
> +               return -ENOMEM;
> +
> +       rlist[0].dst = (dst_zi->i_zsector << SECTOR_SHIFT) + dst_off;
> +       rlist[0].src = (src_zi->i_zsector << SECTOR_SHIFT) + src_off;
> +       rlist[0].len = len;
> +       rlist[0].comp_len = 0;
> +       ret = blkdev_issue_copy(src_bdev, dst_bdev, rlist, 1, NULL, NULL,
> +                       GFP_KERNEL);
> +       if (rlist[0].comp_len > 0)
> +               ret = rlist[0].comp_len;
> +       kfree(rlist);
> +
> +       return ret;
> +}
> +
> +/* Returns length of possible copy, else returns error */
> +static ssize_t zonefs_copy_file_checks(struct file *src_file, loff_t src_off,
> +                                       struct file *dst_file, loff_t dst_off,
> +                                       size_t *len, unsigned int flags)
> +{
> +       struct inode *src_inode = file_inode(src_file);
> +       struct inode *dst_inode = file_inode(dst_file);
> +       struct zonefs_inode_info *src_zi = ZONEFS_I(src_inode);
> +       struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
> +       ssize_t ret;
> +
> +       if (src_inode->i_sb != dst_inode->i_sb)
> +               return -EXDEV;
> +
> +       /* Start by sync'ing the source and destination files for conv zones */
> +       if (src_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
> +               ret = file_write_and_wait_range(src_file, src_off,
> +                               (src_off + *len));
> +               if (ret < 0)
> +                       goto io_error;
> +       }
> +       inode_dio_wait(src_inode);
> +
> +       /* Start by sync'ing the source and destination files ifor conv zones */
> +       if (dst_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
> +               ret = file_write_and_wait_range(dst_file, dst_off,
> +                               (dst_off + *len));
> +               if (ret < 0)
> +                       goto io_error;
> +       }
> +       inode_dio_wait(dst_inode);
> +
> +       /* Drop dst file cached pages for a conv zone*/
> +       if (dst_zi->i_ztype == ZONEFS_ZTYPE_CNV) {
> +               ret = invalidate_inode_pages2_range(dst_inode->i_mapping,
> +                               dst_off >> PAGE_SHIFT,
> +                               (dst_off + *len) >> PAGE_SHIFT);
> +               if (ret < 0)
> +                       goto io_error;
> +       }
> +
> +       ret = zonefs_is_file_copy_offset_ok(src_inode, dst_inode, src_off,
> +                       dst_off, len);
> +       if (ret < 0)
> +               return ret;
> +
> +       return *len;
> +
> +io_error:
> +       zonefs_io_error(dst_inode, true);
> +       return ret;
> +}
> +
> +static ssize_t zonefs_copy_file(struct file *src_file, loff_t src_off,
> +               struct file *dst_file, loff_t dst_off,
> +               size_t len, unsigned int flags)
> +{
> +       struct inode *src_inode = file_inode(src_file);
> +       struct inode *dst_inode = file_inode(dst_file);
> +       struct zonefs_inode_info *src_zi = ZONEFS_I(src_inode);
> +       struct zonefs_inode_info *dst_zi = ZONEFS_I(dst_inode);
> +       ssize_t ret = 0, bytes;
> +
> +       inode_lock(src_inode);
> +       inode_lock(dst_inode);
> +       bytes = zonefs_issue_copy(src_zi, src_off, dst_zi, dst_off, len);
> +       if (bytes < 0)
> +               goto unlock_exit;
> +
> +       ret += bytes;
> +
> +       file_update_time(dst_file);
> +       mutex_lock(&dst_zi->i_truncate_mutex);
> +       zonefs_update_stats(dst_inode, dst_off + bytes);
> +       zonefs_i_size_write(dst_inode, dst_off + bytes);
> +       dst_zi->i_wpoffset += bytes;
> +       mutex_unlock(&dst_zi->i_truncate_mutex);
> +       /* if we still have some bytes left, do splice copy */
> +       if (bytes && (bytes < len)) {
> +               bytes = do_splice_direct(src_file, &src_off, dst_file,
> +                                        &dst_off, len, flags);
> +               if (bytes > 0)
> +                       ret += bytes;
> +       }
> +unlock_exit:
> +       if (ret < 0)
> +               zonefs_io_error(dst_inode, true);
> +       inode_unlock(src_inode);
> +       inode_unlock(dst_inode);
> +       return ret;
> +}
> +
> +static ssize_t zonefs_copy_file_range(struct file *src_file, loff_t src_off,
> +                                     struct file *dst_file, loff_t dst_off,
> +                                     size_t len, unsigned int flags)
> +{
> +       ssize_t ret = -EIO;
> +
> +       ret = zonefs_copy_file_checks(src_file, src_off, dst_file, dst_off,
> +                                    &len, flags);
> +       if (ret > 0)
> +               ret = zonefs_copy_file(src_file, src_off, dst_file, dst_off,
> +                                    len, flags);
> +       else if (ret < 0 && ret == -EXDEV)

First of all, ret < 0 is redundant.

> +               ret = generic_copy_file_range(src_file, src_off, dst_file,
> +                                             dst_off, len, flags);

But more importantly, why do you want to fall back to
do_splice_direct() in zonefs copy_file_range?
How does it serve your patch set or the prospect consumers
of zonefs copy_file_range?

The reason I am asking is because commit 5dae222a5ff0
("vfs: allow copy_file_range to copy across devices")
turned out to be an API mistake that was later reverted by
868f9f2f8e00 ("vfs: fix copy_file_range() regression in cross-fs copies")

It is always better to return EXDEV to userspace which can
always fallback to splice itself, but maybe it has something
smarter to do.

The places where it made sense for kernel to fallback to
direct splice was for network servers server-side-copy, but that
is independent of any specific filesystem copy_file_range()
implementation.

Thanks,
Amir.

