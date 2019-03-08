From: hch@lst.de (Christoph Hellwig)
Date: Fri, 8 Mar 2019 14:30:50 +0100
Subject: [PATCH] nvmet-file: clamp-down file namespace lba_shift
In-Reply-To: <20190305095548.14934-1-sagi@grimberg.me>
References: <20190305095548.14934-1-sagi@grimberg.me>
Message-ID: <20190308133050.GD18218@lst.de>

> -	ns->blksize_shift = file_inode(ns->file)->i_blkbits;
> +	ns->blksize_shift = min_t(u8, file_inode(ns->file)->i_blkbits, PAGE_SHIFT);

I think we want to limit to 4k as the universally acceptable upper
bound.  Also this should not use u8 for the case but probably an
unsigned int.

Last but not least this introduced a > 80 char line.
