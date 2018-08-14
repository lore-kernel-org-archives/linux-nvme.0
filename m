From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 14 Aug 2018 16:57:16 -0600
Subject: [PATCH] Bugfix for handling of shadow doorbell buffer.
In-Reply-To: <20180814221735.62804-1-wnukowski@google.com>
References: <20180814221735.62804-1-wnukowski@google.com>
Message-ID: <20180814225716.GA3224@localhost.localdomain>

On Tue, Aug 14, 2018@03:17:35PM -0700, Michal Wnukowski wrote:
>  /* Update dbbuf and return true if an MMIO is required */
>  static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
> -					      volatile u32 *dbbuf_ei)
> +					      u32 *dbbuf_ei)
>  {
>  	if (dbbuf_db) {
>  		u16 old_value;
> @@ -306,6 +306,12 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
>  		old_value = *dbbuf_db;
>  		*dbbuf_db = value;
>  
> +		/*
> +		 * Ensure that the doorbell is updated before reading
> +		 * the EventIdx from memory
> +		 */
> +		mb();
> +
>  		if (!nvme_dbbuf_need_event(*dbbuf_ei, value, old_value))
>  			return false;
>  	}

You just want to ensure the '*dbbuf_db = value' isn't reordered, right?
The order dependency might be more obvious if done as:

	WRITE_ONCE(*dbbuf_db, value);

  	if (!nvme_dbbuf_need_event(READ_ONCE(*dbbuf_ei), value, old_value))
  		return false;

And 'volatile' is again redundant.
