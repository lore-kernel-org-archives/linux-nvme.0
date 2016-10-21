From: hch@lst.de (Christoph Hellwig)
Date: Fri, 21 Oct 2016 14:12:34 +0200
Subject: [PATCH RFC v2 1/3] rdma_cm: add rdma_reject_msg() helper function
In-Reply-To: <1360f08b7c25f3befcd6836b47af81e2ecb51b75.1477003235.git.swise@opengridcomputing.com>
References: <cover.1477003235.git.swise@opengridcomputing.com>
 <1360f08b7c25f3befcd6836b47af81e2ecb51b75.1477003235.git.swise@opengridcomputing.com>
Message-ID: <20161021121234.GA17028@lst.de>

> +const char *__attribute_const__ ib_reject_msg(int reason)
> +{
> +	size_t index = reason;
> +
> +	return (index < ARRAY_SIZE(ib_rej_reason_strs) &&
> +		ib_rej_reason_strs[index]) ?
> +		ib_rej_reason_strs[index] : "unrecognized reason";
> +}
> +EXPORT_SYMBOL(ib_reject_msg);

This looks a bit odd, why not something like:

const char *__attribute_const__ ib_reject_msg(int reason)
{
	if (reason >= ARRAY_SIZE(ib_rej_reason_strs) ||
	    !ib_rej_reason_strs[reason])
		return "unrecognized reason";
	return ib_rej_reason_strs[reason];
}

> +const char *__attribute_const__ iw_reject_msg(int reason)
> +{
> +	size_t index = -reason;
> +
> +	/* iWARP uses negative errnos */
> +	index = -index;
> +	return (index < ARRAY_SIZE(iw_rej_reason_strs) &&
> +		iw_rej_reason_strs[index]) ?
> +		iw_rej_reason_strs[index] : "unrecognized reason";
> +}
> +EXPORT_SYMBOL(iw_reject_msg);

Same here:

const char *__attribute_const__ iw_reject_msg(int reason)
{
	/* iWARP uses negative errnos */
	reason = -reason;

	if (reason >= ARRAY_SIZE(iw_rej_reason_strs) ||
	    !iw_rej_reason_strs[reason])
		return "unrecognized reason";
	return iw_rej_reason_strs[reason];
}

Otherwise this looks good and very useful to me.
