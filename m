From: jonathan.derrick@intel.com (Jon Derrick)
Date: Mon, 16 May 2016 11:31:06 -0600
Subject: [RFCv2 2/3] block: add helper for setting and clearing S_DAX on
 inode
In-Reply-To: <94D0CD8314A33A4D9D801C0FE68B4029639701CA@G4W3202.americas.hpqcorp.net>
References: <1463184168-3381-1-git-send-email-jonathan.derrick@intel.com>
 <1463184168-3381-3-git-send-email-jonathan.derrick@intel.com>
 <94D0CD8314A33A4D9D801C0FE68B4029639701CA@G4W3202.americas.hpqcorp.net>
Message-ID: <20160516173106.GA1769@localhost.localdomain>

On Sat, May 14, 2016@05:05:59AM +0000, Elliott, Robert (Persistent Memory) wrote:
> 
> 
> > -----Original Message-----
> > From: linux-block-owner at vger.kernel.org [mailto:linux-block-
> > owner at vger.kernel.org] On Behalf Of Jon Derrick
> > Sent: Friday, May 13, 2016 7:03 PM
> ...
> > Subject: [RFCv2 2/3] block: add helper for setting and clearing S_DAX on
> > inode
> > 
> > inode->i_flags locking rules suggest using the i_mutex lock. This patch
> > adds a helper to do the locking and setting of S_DAX on the block device
> > inode.
> ...
> > +static void bd_set_dax(struct block_device *bdev, bool enabled)
> > +{
> > +	struct inode *inode = bdev->bd_inode;
> > +
> > +	inode_lock(inode);
> > +	if (enabled)
> > +		inode->i_flags = S_DAX;
> > +	else
> > +		inode->i_flags &= ~S_DAX;
> > +	inode_unlock(inode);
> > +}
> 
> This is not symmetric - setting wipes out any other bits, but
> clearing only clears the S_DAX bit. That seems confusing for
> a helper function.
> 
> Using |= would be symmetric, but wouldn't replace what 
> __blkdev_get does (if what it does is appropriate).
> 
I'm under the impression that S_DAX is the only inode flag appropriate for a block device inode with direct-access, even though it does break the 'flag' semantic.

It does bring up an interesting question about the fate of the block device inode when S_DAX is set and then cleared later due to the two other conditions that can clear S_DAX.

I think the appropriate fix is to save the inode flags when setting DAX and restore them when we need to clear S_DAX.

> > @@ -1206,9 +1218,9 @@ static int __blkdev_get(struct block_device *bdev,
> > fmode_t mode, int for_part)
> >  		bdev->bd_queue = disk->queue;
> >  		bdev->bd_contains = bdev;
> >  		if (IS_ENABLED(CONFIG_BLK_DEV_DAX) && disk->fops-
> > >direct_access)
> > -			bdev->bd_inode->i_flags = S_DAX;
> > +			bd_set_dax(bdev, 1);
> >  		else
> > -			bdev->bd_inode->i_flags &= ~S_DAX;
> > +			bd_set_dax(bdev, 0);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
