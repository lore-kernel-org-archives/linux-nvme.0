From: hch@lst.de (Christoph Hellwig)
Date: Sat, 18 Feb 2017 17:22:03 +0100
Subject: [PATCHv2 4/5] block/sed: Embed function data into the function
 sequence
In-Reply-To: <d6d1c65a-4422-97d7-8ee8-fef46159b143@eng.utah.edu>
References: <1487376029-22662-1-git-send-email-jonathan.derrick@intel.com>
 <1487376029-22662-5-git-send-email-jonathan.derrick@intel.com>
 <20170218083605.GB11798@lst.de>
 <d6d1c65a-4422-97d7-8ee8-fef46159b143@eng.utah.edu>
Message-ID: <20170218162203.GC17922@lst.de>

On Sat, Feb 18, 2017@08:52:19AM -0700, Scott Bauer wrote:
> >> +static int set_mbr_done(struct opal_dev *dev, void *data)
> >>  {
> >> -	u8 mbr_done_tf = *(u8 *)dev->func_data[dev->state];
> >> +	u8 mbr_done_tf = *(u8 *)data;
> > 
> > No need for casts when going from void * to any pointer type.  There are
> > a couple more instance below where the cast should be removed as well.
> 
> In this case he's actually casting & dereferencing the pointer, so it should be fine in this scenario?

Oh, right.  As-is we'll obviously need the casts.  But what we could
do instead is the following:

	u8 *mbr_done_tf = data;

	..

	add_token_u8(&err, dev, *mbr_done_tf); /* Done T or F */

or alternatively just pass the whole struct opal_mbr_data pointer
as the private data.
