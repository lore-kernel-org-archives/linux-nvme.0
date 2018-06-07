From: hare@suse.de (Hannes Reinecke)
Date: Thu, 7 Jun 2018 14:38:52 +0200
Subject: [PATCH nvmetcli] ANA configuration support
In-Reply-To: <20180607121245.GE11938@lst.de>
References: <20180607095709.26738-1-hare@suse.de>
 <20180607100035.cbtwtvttsen2wwm3@linux-x5ow.site>
 <20180607121245.GE11938@lst.de>
Message-ID: <20180607143852.1f0b9f9c@pentland.suse.de>

On Thu, 7 Jun 2018 14:12:45 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Jun 07, 2018@12:00:35PM +0200, Johannes Thumshirn wrote:
> > On Thu, Jun 07, 2018 at 11:57:09AM +0200, Hannes Reinecke wrote:  
> > > +class ANA_Group(CFSNode):  
> > 
> > Please use ANAGroup to be consistent with the rest and Python's PEP8
> > guidelines.  
> 
> Agreed.  Please run the code through pep8 and pylint in general.
> There are a few warnings, especially from the latter, but nothing
> crazy should be introduced.
> 
> Also we'll need to cover the ANA code in the unit tests.
> 

No problem. First time for me to send a substantial python patch, so I
guess I have still a learning curve here.

Cheers,

Hannes
