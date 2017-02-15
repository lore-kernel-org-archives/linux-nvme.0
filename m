From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 15 Feb 2017 12:12:02 +0200
Subject: [PATCH v3 00/16] lpfc: Add NVME Fabrics support
In-Reply-To: <58a0d918.RXFImMqrhYsCnA/U%jsmart2021@gmail.com>
References: <58a0d918.RXFImMqrhYsCnA/U%jsmart2021@gmail.com>
Message-ID: <3440afa9-9449-3378-6e8f-7cbe8dbb52cf@grimberg.me>

Hi James,

> This patch set adds support for NVME over Fabrics FC transport
> to lpfc
>
> The internals of the driver are reworked to support being either:
>  a SCSI initiator;
>  a NVME intiator;
>  both a SCSI initiator and a NVME initiator;
>  or a NVME target.
>
> The driver effectively has parallel NVME and SCSI stacks that
> utilize their own set of resources. They intersect only at the
> hardware level, mainly in queue create layers and interrupt handling.
>
> A few new files are added to support the interfaces of the
> FC transport LLDD api for NVME fabrics.
>
> The patches were cut against 1/30 scsi.git tree, misc branch.
> ** THEY ARE INTENDED FOR THE SCSI.GIT TREE, MISC BRANCH **
>
> The lpfc version in the linux-block.git tree is rather old. I have a
> recipe for how to get it to a version that syncs with the
> scsi.git/misc tree so that these patches can apply there as well.
> Contact me if you would like it.

This set does not seem to apply cleanly on nvme-4.11 tree, looks
like patch 6 is failing.

Also, can you send your patchset threaded? It usually does so
when generating the patches with git format-patch, not sure
how this is not the case with your set... It would make my
life a bit easier.

Thanks.
