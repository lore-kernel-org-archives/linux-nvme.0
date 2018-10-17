From: hch@lst.de (Christoph Hellwig)
Date: Wed, 17 Oct 2018 09:11:19 +0200
Subject: [PATCH] nvmetcli: ANA configuration support
In-Reply-To: <570f1c05-1995-0eb9-7649-16aa0204e783@suse.com>
References: <20180727110859.4212-1-hare@suse.de> <20181006124353.GA8324@lst.de>
 <570f1c05-1995-0eb9-7649-16aa0204e783@suse.com>
Message-ID: <20181017071118.GA23258@lst.de>

On Sat, Oct 06, 2018@03:09:20PM +0200, Hannes Reinecke wrote:
> > The new ANA code will probably need similar exception handling as the
> > inline_data_size attribute.
> > 
> Okay, will be fixing it up.

Any chance to get a fixed version in the next days?  I'd like to cut
a new release with it not too long after the 4.19 release so that people
can easily use the ANA code.
