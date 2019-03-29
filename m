From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Mar 2019 11:02:44 +0100
Subject: [PATCH] nvme-multipath: avoid crash on invalid subsystem
 cntlid enumeration
In-Reply-To: <20190329095754.109653-1-hare@suse.de>
References: <20190329095754.109653-1-hare@suse.de>
Message-ID: <20190329100244.GA28689@lst.de>

On Fri, Mar 29, 2019@10:57:54AM +0100, Hannes Reinecke wrote:
> The controller ID is supposed to be unique for each subsystem;
> however, if it _isn't_ we will crash when calling device_add_disk()
> for the namespaces.
> While this surely is an error on the subsystem side we really shouldn't
> crash. So simply use the 'instance' number when generating the disk
> name to avoid this issue.

I agree that we should not crash in that, but I'd rather print an
error message and reject using that controller with the duplicate
controller id than hacking around the issue.
