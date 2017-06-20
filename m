From: hch@lst.de (Christoph Hellwig)
Date: Tue, 20 Jun 2017 14:31:02 +0200
Subject: [PATCH nvme-cli] fabrics: add hostid option to connect command
In-Reply-To: <20170620122556.10271-1-jthumshirn@suse.de>
References: <20170620122556.10271-1-jthumshirn@suse.de>
Message-ID: <20170620123102.GA25762@lst.de>

On Tue, Jun 20, 2017@02:25:56PM +0200, Johannes Thumshirn wrote:
> Add an option to pass in the hostid either via command line or a new config
> file /etc/nvme/hostid.

Looks great!

Reviewed-by: Christoph Hellwig <hch at lst.de>

I think we should also add code to generate a default hostid somewhere.
I guess we could just uuidgen(1) and drive it from the package?  Sagi
added a call to genhostnqn to the specfile, so that should go into
it as well.

(and it seems like Debian packaging isn't present at all in the
package)
