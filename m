From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 21 Oct 2016 09:07:05 -0500
Subject: [PATCH RFC v2 1/3] rdma_cm: add rdma_reject_msg() helper	function
In-Reply-To: <20161021121234.GA17028@lst.de>
References: <cover.1477003235.git.swise@opengridcomputing.com>
 <1360f08b7c25f3befcd6836b47af81e2ecb51b75.1477003235.git.swise@opengridcomputing.com>
 <20161021121234.GA17028@lst.de>
Message-ID: <005d01d22ba4$672effd0$358cff70$@opengridcomputing.com>

> 
> > +const char *__attribute_const__ ib_reject_msg(int reason)
> > +{
> > +	size_t index = reason;
> > +
> > +	return (index < ARRAY_SIZE(ib_rej_reason_strs) &&
> > +		ib_rej_reason_strs[index]) ?
> > +		ib_rej_reason_strs[index] : "unrecognized reason";
> > +}
> > +EXPORT_SYMBOL(ib_reject_msg);
> 
> This looks a bit odd, why not something like:
> 
> const char *__attribute_const__ ib_reject_msg(int reason)
> {
> 	if (reason >= ARRAY_SIZE(ib_rej_reason_strs) ||
> 	    !ib_rej_reason_strs[reason])
> 		return "unrecognized reason";
> 	return ib_rej_reason_strs[reason];
> }
>

I copy/pasted from rdma_event_msg().

 
> > +const char *__attribute_const__ iw_reject_msg(int reason)
> > +{
> > +	size_t index = -reason;
> > +
> > +	/* iWARP uses negative errnos */
> > +	index = -index;
> > +	return (index < ARRAY_SIZE(iw_rej_reason_strs) &&
> > +		iw_rej_reason_strs[index]) ?
> > +		iw_rej_reason_strs[index] : "unrecognized reason";
> > +}
> > +EXPORT_SYMBOL(iw_reject_msg);
> 
> Same here:
> 
> const char *__attribute_const__ iw_reject_msg(int reason)
> {
> 	/* iWARP uses negative errnos */
> 	reason = -reason;
> 
> 	if (reason >= ARRAY_SIZE(iw_rej_reason_strs) ||
> 	    !iw_rej_reason_strs[reason])
> 		return "unrecognized reason";
> 	return iw_rej_reason_strs[reason];
> }
> 
> Otherwise this looks good and very useful to me.

I will refactor as you suggest.  You proposed logic is slightly more readable to
me...

Thanks.
