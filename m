From: hch@lst.de (Christoph Hellwig)
Date: Fri, 25 May 2018 15:34:55 +0200
Subject: [PATCHv2 11/11] nvmet: ANA support
In-Reply-To: <c7e3cbcc-e372-8162-0d84-1fced2ccc3c2@suse.de>
References: <20180522091004.39620-1-hare@suse.de>
 <20180522091004.39620-12-hare@suse.de> <20180522100552.GC11894@lst.de>
 <c7e3cbcc-e372-8162-0d84-1fced2ccc3c2@suse.de>
Message-ID: <20180525133455.GA24759@lst.de>

On Tue, May 22, 2018@01:05:39PM +0200, Hannes Reinecke wrote:
> Primarily this is designed to be a testbed for the various ANA 
> configurations.

Well, hat isn't really what we need in mainline.

> Plus ANA support can be disabled, too :-)

Great.  That should be worth about 20 lines if we really need it,
not 370 lines of additional code over the initial 315.  And not
require iterating the list of all ANA groups in the ANA fast path.
And so on.
