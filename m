From: keith.busch@intel.com (Keith Busch)
Date: Tue, 13 Oct 2015 19:31:57 +0000 (UTC)
Subject: [PATCH 7/8] nvme: move namespace scanning to common code
In-Reply-To: <1444633811-28319-8-git-send-email-hch@lst.de>
References: <1444633811-28319-1-git-send-email-hch@lst.de>
 <1444633811-28319-8-git-send-email-hch@lst.de>
Message-ID: <alpine.LNX.2.00.1510131918560.27742@localhost.lm.intel.com>

On Mon, 12 Oct 2015, Christoph Hellwig wrote:
> The namespace scanning code has been mostly generic already, we just
> need to store a pointer to the tagset in the nvme_ctrl structure, and
> add a method to check if a controller is I/O incapable.  The latter
> will hopefully be replaced by a proper controller state machine soon.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>

> +void __exit nvme_core_exit(void)
> +{
> +	unregister_blkdev(nvme_major, "nvme");
> +}

> @@ -2898,7 +2737,7 @@ static int __init nvme_init(void)
>  unregister_chrdev:
> 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
>  unregister_blkdev:
> -	unregister_blkdev(nvme_major, "nvme");
> +	nvme_core_exit();

The "__exit" section on nvme_core_exit causes a mismatch reference warning
since it's being called from an __init section. Just drop __exit from
the core function.

Other than that, this is series has gone very smoothly; initial sanity
testing hasn't hit any issues yet. I'll run tests on metadata formats
later today/early tomorrow and will let you know how that goes.
