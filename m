From: darrick.wong@oracle.com (Darrick J. Wong)
Date: Mon, 26 Jun 2017 09:09:46 -0700
Subject: [PATCH 1/9] fs: add fcntl() interface for setting/getting write
 life time hints
In-Reply-To: <91b3fd3b-18f5-cf8c-a1d7-c0637283ce14@kernel.dk>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-2-git-send-email-axboe@kernel.dk>
 <20170626095148.GB14057@infradead.org>
 <91b3fd3b-18f5-cf8c-a1d7-c0637283ce14@kernel.dk>
Message-ID: <20170626160946.GI3787@birch.djwong.org>

On Mon, Jun 26, 2017@07:55:27AM -0600, Jens Axboe wrote:
> On 06/26/2017 03:51 AM, Christoph Hellwig wrote:
> > Please document the userspace API (added linux-api and linux-man
> > to CC for sugestions), especially including the odd effects of the
> > per-inode settings.
> 
> Of course, I'll send in a diff for the fcntl(2) man page.
> 
> > Also I would highly recommend to use different fcntl commands
> > for the file vs inode hints to avoid any strange behavior.
> 
> OK, used to have that too... I can add specific _FILE versions.

While you're at it, can you also send in an xfstest or two to check the
basic functionality of the fcntl so that we know the code reflects the
userspace API ("I set this hint and now I can query it back" and "file
hint overrides inode hint") that we want?

--D

> 
> -- 
> Jens Axboe
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-api" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
