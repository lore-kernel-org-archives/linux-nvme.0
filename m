From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue, 20 Dec 2016 15:07:46 -0700
Subject: [PATCH v3 2/5] lib: Add Sed-opal library
In-Reply-To: <20161220072847.GA11946@infradead.org>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-3-git-send-email-scott.bauer@intel.com>
 <20161220072847.GA11946@infradead.org>
Message-ID: <20161220220746.GA3939@localhost.localdomain>

On Mon, Dec 19, 2016@11:28:47PM -0800, Christoph Hellwig wrote:
[snip]
> > +	while (cpos < total) {
> > +		if (!(pos[0] & 0x80)) /* tiny atom */
> > +			token_length = response_parse_tiny(iter, pos);
> > +		else if (!(pos[0] & 0x40)) /* short atom */
> > +			token_length = response_parse_short(iter, pos);
> > +		else if (!(pos[0] & 0x20)) /* medium atom */
> > +			token_length = response_parse_medium(iter, pos);
> > +		else if (!(pos[0] & 0x10)) /* long atom */
> > +			token_length = response_parse_long(iter, pos);
> 
> Please add symbolic names for these constants to the protocol header.
> 
I get tripped up by this logic every time I look at it. I'd almost
rather see something like the following, which more closely follows the
TCG core spec and the optimizing compiler should turn it into something
similar to above anyways:

	if (pos[0] <= 0x7F)
		token_length = response_parse_tiny..
	else if (pos[0] <= 0xBF)
		token_length = response_parse_short..
	else if (pos[0] <= 0xDF)
		token_length = response_parse_medium..
	else if (pos[0] <= 0xE3)
		token_length = response_parse_long..

Then just add those 0x7F, 0xBF, 0xDF, and 0xE3 constants to proto
header. We could even add in a TCG reserved error for 0xE4-0xEF

Also instead of tracking cpos, we could subtract from total until
negative (if you make it signed). It's similar to how we do length in
nvme_setup_prps.

[snip]
> > --- /dev/null
> > +++ b/lib/sed-opal_internal.h
> 
> This pretty much seem to contain the OPAL protocol defintions, so why
> not opal_proto.h?
Since there might eventually be a whole class of opal-like sed
protocols, why does it make more sense to have opal_proto.h instead of
sed-opal.h or some variation? This is similar to how leds-*.h look to
me. Although I agree that sed-ATA.h would be dishonest since ATA
security doesn't imply a self-encrypting-disk.

[snip]
> > +int sed_save(struct sed_context *sed_ctx, struct sed_key *key)
> > +{
> > +	switch (key->sed_type) {
> > +	case OPAL_LOCK_UNLOCK:
> > +		return opal_save(sed_ctx, key);
> > +	}
> > +
> > +	return -EOPNOTSUPP;
> 
> It seems to me that we should skip this whole sed_type indirections
> and just specify the ioctls directly for OPAL (which would include
> opalite and pyrite as subsets).  The only other protocols of interest
> for Linux would be the ATA "security" plain text passwords, which can
> be handled differently, or enterprise SSC which we can hopefully avoid
> to implement entirely.
I'm on board with this if you think we won't have enough different, but
similar, SED protocols to justify the indirection. In that case you can
ignore the above comment as well.

> 
> > +
> > +int fdev_sed_ioctl(struct file *filep, unsigned int cmd,
> > +		   unsigned long arg)
> > +{
> > +	struct sed_key key;
> > +	struct sed_context *sed_ctx;
> > +
> > +	if (!capable(CAP_SYS_ADMIN))
> > +		return -EACCES;
> > +
> > +	if (!filep->f_sedctx || !filep->f_sedctx->ops || !filep->f_sedctx->dev)
> > +		return -ENODEV;
> 
> In the previous version this was called from the block driver which
> could pass in the context (and ops).  Why was this changed?
> 
