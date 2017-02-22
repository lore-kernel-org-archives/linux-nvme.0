From: scott.bauer@intel.com (Scott Bauer)
Date: Wed, 22 Feb 2017 09:13:31 -0700
Subject: [PATCHv4 4/4] block/sed: Embed function data into the function
 sequence
In-Reply-To: <22a94611-3cbd-792f-8347-3b1c1f200944@fb.com>
References: <1487703556-19913-1-git-send-email-jonathan.derrick@intel.com>
 <1487703556-19913-5-git-send-email-jonathan.derrick@intel.com>
 <20170222071342.GA17472@lst.de>
 <22a94611-3cbd-792f-8347-3b1c1f200944@fb.com>
Message-ID: <20170222161331.GA2696@sbauer-Z170X-UD5>

On Wed, Feb 22, 2017@09:10:31AM -0700, Jens Axboe wrote:
> On 02/22/2017 12:13 AM, Christoph Hellwig wrote:
> >> +	if (!lock_held)
> >> +		mutex_lock(&dev->dev_lock);
> > 
> > No conditional locking, please.  I guess I causesd this by asking you
> > to remove __opal_lock_unlock, but it seems we'd either need to keep it
> > in the end.
> > 
> > Except for that the series looks fine to me.
> > 
> > Jens: given that 1-3 are the important fixes how about you pick those
> > up ASAP?  They all also had my Reviewed-by for previous postings.
> 
> I picked up 1-3, and re-added your reviewed by. #4 should be sorted
> before -rc1, though.
> 

#4 Is good to go as well. It was resent this morning under
[PATCH] block/sed: Embed function data into the function sequence
And contains the changes Christoph requested, I'll re-add my sign-off.
Once that gets In I can rebase mine and get them out today too.
