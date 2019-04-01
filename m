From: kbusch@kernel.org (Keith Busch)
Date: Sun, 31 Mar 2019 23:17:32 -0600
Subject: [PATCH] nvme-multipath: avoid crash on invalid subsystem cntlid
 enumeration
In-Reply-To: <edde200c-dc35-8e40-6406-ce72f8aafe17@suse.de>
References: <20190329095754.109653-1-hare@suse.de>
 <20190329100244.GA28689@lst.de>
 <edde200c-dc35-8e40-6406-ce72f8aafe17@suse.de>
Message-ID: <20190401051732.GC16792@localhost.localdomain>

On Fri, Mar 29, 2019@03:23:18AM -0700, Hannes Reinecke wrote:
> On 3/29/19 11:02 AM, Christoph Hellwig wrote:
> > On Fri, Mar 29, 2019@10:57:54AM +0100, Hannes Reinecke wrote:
> >> The controller ID is supposed to be unique for each subsystem;
> >> however, if it _isn't_ we will crash when calling device_add_disk()
> >> for the namespaces.
> >> While this surely is an error on the subsystem side we really shouldn't
> >> crash. So simply use the 'instance' number when generating the disk
> >> name to avoid this issue.
> > 
> > I agree that we should not crash in that, but I'd rather print an
> > error message and reject using that controller with the duplicate
> > controller id than hacking around the issue.
> > 
> As it so happens, I have a patch for that, too, but thought this one an 
> easier solution :-)
> 
> Will be sending that patch, then.

We might want to use this patch anyway. It is possible some process
reference count is preventing the final release when we want to remove
a controller, and a subsequent discover, even if the cntlid is unqiue,
would create a duplicate disk name.
