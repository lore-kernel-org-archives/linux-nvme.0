From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 9 Mar 2017 01:24:11 +0200
Subject: [RFC PATCH] nvmet: Back namespace with files
In-Reply-To: <1489008937-31043-1-git-send-email-keith.busch@intel.com>
References: <1489008937-31043-1-git-send-email-keith.busch@intel.com>
Message-ID: <a067f769-166a-a444-32e3-ff488dce748a@grimberg.me>

Keith,

> This RFC allows NVMeOF targets to be backed by files. Prior to this,
> only block device files were supported, but this patch will let you use
> any file, and continue working on block files if requested.

I don't think this is the way to go. I really don't.

> Backing with files has more flexibility on what a namespace can be,
> and it isn't difficult from here to add NVMe target support for caching,
> provisioning, namespace management, and all the features Linux filesystems
> provide.

As Christoph said, you need a *very* compelling justification why loop
doesn't give you everything you need.

> I only ported the loop target. The fc and rdma targets are a little more
> work, so this looked like a good stopping point to guage interest.

RDMA and FC is where sgls are actually important as they need dma
mapping, which means that the kvec handling is something that needs to
be pushed into the backend handling in io-cmd.c
