From: kbusch@kernel.org (Keith Busch)
Date: Mon, 8 Apr 2019 13:46:09 -0600
Subject: [PATCH] nvmet: Fix discover log page when offsets are used
In-Reply-To: <20190408192932.563-1-keith.busch@intel.com>
References: <20190408192932.563-1-keith.busch@intel.com>
Message-ID: <20190408194609.GC32613@localhost.localdomain>

On Mon, Apr 08, 2019@01:29:32PM -0600, Keith Busch wrote:
> @@ -149,36 +168,33 @@ static void nvmet_execute_get_disc_log_page(struct nvmet_req *req)
>  	 * If host provided data len is less than the header size, only the
>  	 * number of bytes requested by host will be sent to host.
>  	 */
> -	hdr = kzalloc(alloc_len, GFP_KERNEL);
> -	if (!hdr) {
> +	down_read(&nvmet_config_sem);
> +	alloc_len = sizeof(*hdr) + entry_size * discovery_log_entries(req);
> +	buffer = kzalloc(alloc_len, GFP_KERNEL);
> +	if (!buffer) {
>  		status = NVME_SC_INTERNAL;
>  		goto out;
>  	}

There's an error here not unlocking the target control rw-semaphore on
allocation failure. Going to send a v2 in 5 seconds, so please disregard
this one.
