From: keith.busch@intel.com (Keith Busch)
Date: Tue, 6 Feb 2018 09:29:04 -0700
Subject: coalescing in polling mode in 4.9
In-Reply-To: <7d378937-1859-0007-12b3-ca1722d2a5c3@samsung.com>
References: <20180202001028.fee27cf239e3e8a5ae6bd8a4@gmail.com>
 <CGME20180205145924epcas3p2f8156043ec00b51c135ac62c1fa177d7@epcas3p2.samsung.com>
 <20180205150253.GN24417@localhost.localdomain>
 <7d378937-1859-0007-12b3-ca1722d2a5c3@samsung.com>
Message-ID: <20180206162903.GF31110@localhost.localdomain>

On Mon, Feb 05, 2018@09:12:12PM +0530, Nitesh wrote:
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 4a181fc..d2eeedf 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -236,9 +236,13 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct
> iov_iter *iter,
>                 set_current_state(TASK_UNINTERRUPTIBLE);
>                 if (!READ_ONCE(bio.bi_private))
>                         break;
> -               if (!(iocb->ki_flags & IOCB_HIPRI) ||
> -                   !blk_poll(bdev_get_queue(bdev), qc))
> +               if (!(iocb->ki_flags & IOCB_HIPRI))
>                         io_schedule();
> +               else if (!blk_poll(bdev_get_queue(bdev), qc)) {
> +                       if(need_resched())
> +                               set_current_state(TASK_RUNNING);
> +                       io_schedule();
> +               }
>         }
>         __set_current_state(TASK_RUNNING);

Yah, I think this looks good. Do you want to send this as a proper patch
to linux-block mailing list for consideration?
