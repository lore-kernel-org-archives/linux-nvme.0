From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 20 Jun 2017 14:34:41 +0200
Subject: [PATCH nvme-cli] fabrics: add hostid option to connect command
In-Reply-To: <20170620123102.GA25762@lst.de>
References: <20170620122556.10271-1-jthumshirn@suse.de>
 <20170620123102.GA25762@lst.de>
Message-ID: <20170620123441.GD3686@linux-x5ow.site>

On Tue, Jun 20, 2017@02:31:02PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 20, 2017@02:25:56PM +0200, Johannes Thumshirn wrote:
> > Add an option to pass in the hostid either via command line or a new config
> > file /etc/nvme/hostid.
> 
> Looks great!
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> 
> I think we should also add code to generate a default hostid somewhere.
> I guess we could just uuidgen(1) and drive it from the package?  Sagi
> added a call to genhostnqn to the specfile, so that should go into
> it as well.

sth like:

%postin
uuidgen > /etc/nvme/hostid

should do the trick methinks.

> (and it seems like Debian packaging isn't present at all in the
> package)

Aren't you a Debian user ;-)

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
