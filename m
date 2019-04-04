From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 Apr 2019 07:27:20 +0200
Subject: [PATCHv2] nvmet: make MDTS value configurable
In-Reply-To: <20190403230654.109698-1-hare@suse.de>
References: <20190403230654.109698-1-hare@suse.de>
Message-ID: <20190404052720.GB7497@lst.de>

On Thu, Apr 04, 2019@01:06:54AM +0200, Hannes Reinecke wrote:
> Some drivers and/or use-cases might need to set a smaller MDTS
> value, so add a per-port attribute to modify the MDTS value.

If the drivers need it they need to communicate that value up the
stack.  We should not require user inputs to make things work.
