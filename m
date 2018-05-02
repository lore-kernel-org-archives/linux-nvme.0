From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 2 May 2018 11:23:19 -0600
Subject: [PATCH v2] nvme: only reconfigure discard if necessary
In-Reply-To: <c926d596-b193-c592-3767-4d903ccb742d@kernel.dk>
References: <c926d596-b193-c592-3767-4d903ccb742d@kernel.dk>
Message-ID: <20180502172319.GK5938@localhost.localdomain>

On Wed, May 02, 2018@11:06:54AM -0600, Jens Axboe wrote:
> Currently nvme reconfigures discard for every disk revalidation. This
> is problematic because any O_WRONLY or O_RDWR open will trigger a
> partition scan through udev/systemd, and we will reconfigure discard.
> This blows away any user settings, like discard_max_bytes.
> 
> Only re-configure the user settable settings if we need to.
> 
> Signed-off-by: Jens Axboe <axboe at kernel.dk>

Thanks, applied to nvme-4.18 with a minor modification removing the
redundant QUEUE_FLAG_DISCARD flag set:
  
> +	/* If discard is already enabled, don't reset queue limits */
> +	if (blk_queue_flag_test_and_set(QUEUE_FLAG_DISCARD, queue))
> +		return;
> +
>  	blk_queue_max_discard_sectors(queue, UINT_MAX);
>  	blk_queue_max_discard_segments(queue, NVME_DSM_MAX_RANGES);
>  	blk_queue_flag_set(QUEUE_FLAG_DISCARD, queue);

-  	blk_queue_flag_set(QUEUE_FLAG_DISCARD, queue);
