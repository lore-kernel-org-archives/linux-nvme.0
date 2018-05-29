From: hare@suse.de (Hannes Reinecke)
Date: Tue, 29 May 2018 15:04:14 +0200
Subject: [PATCH 08/10] nvmet: Set nanagrpid correctly
In-Reply-To: <20180529125151.GH7376@lst.de>
References: <20180529101431.62271-1-hare@suse.de>
 <20180529101431.62271-9-hare@suse.de>
 <20180529125151.GH7376@lst.de>
Message-ID: <20180529150414.44a1cb7e@pentland.suse.de>

On Tue, 29 May 2018 14:51:51 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, May 29, 2018@12:14:29PM +0200, Hannes Reinecke wrote:
> > We should be returning the actual number of namespaces for
> > nanagrpid.  
> 
> "This field indicates the number
> of ANA groups supported by this controller."
> 
> Nothing indicates this field is dynamic, especially as dynamic values
> in Identify are very rare and avoided.

Yes, but it also doesn't _forbid_ us to set it to the value which is
currently active.

Plus we already have dynamic fields in the identify output; the
'mnan' field is specifically for the number of allocated namespaces.
And I can easily create new namespaces while a controller is attached.

I do agree that we don't have a good method of signalling any
configuration change to the attached controllers; maybe we should be
dropping the connection and for the attached hosts to do a reset.
But this should be a separate discussion.

Cheers,

Hannes
