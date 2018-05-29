From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 May 2018 14:51:51 +0200
Subject: [PATCH 08/10] nvmet: Set nanagrpid correctly
In-Reply-To: <20180529101431.62271-9-hare@suse.de>
References: <20180529101431.62271-1-hare@suse.de>
 <20180529101431.62271-9-hare@suse.de>
Message-ID: <20180529125151.GH7376@lst.de>

On Tue, May 29, 2018@12:14:29PM +0200, Hannes Reinecke wrote:
> We should be returning the actual number of namespaces for nanagrpid.

"This field indicates the number
of ANA groups supported by this controller."

Nothing indicates this field is dynamic, especially as dynamic values
in Identify are very rare and avoided.
