From: hare@suse.de (Hannes Reinecke)
Date: Thu, 26 Jul 2018 09:45:58 +0200
Subject: draft ANA support v5
In-Reply-To: <20180724115009.731-1-hch@lst.de>
References: <20180724115009.731-1-hch@lst.de>
Message-ID: <95670c36-713f-9f8d-d4db-13194edbe92e@suse.de>

On 07/24/2018 01:50 PM, Christoph Hellwig wrote:
> I think we are about ready to merge now, so please review carefully.
> 
> A git tree is available at:
> 
>     git://git.infradead.org/users/hch/block.git nvme-ana
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-ana
> 
With this patchset my ANA blktest fails horribly; ANATT triggering and
finally a stuck process:

[  764.545768] XFS (nvme0n1): Mounting V5 Filesystem
[  764.563869] XFS (nvme0n1): Ending clean mount
[  774.587667] block nvme0n1: no path available - requeuing I/O
[  774.587674] block nvme0n1: no path available - requeuing I/O
[  774.587944] nvme nvme0: ANA group 1: change.
[  774.587955] nvme nvme0: ANA group 2: inaccessible.
[  795.253331] nvme nvme0: ANATT timeout, resetting controller.
[  795.254028] block nvme0n1: no path available - requeuing I/O
[  795.276403] block nvme0n1: no path available - requeuing I/O
[  797.683763] nvmet: creating controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:ffca97aa-180e-4441-a24c-7439f1cef0d9.
[  797.712336] nvme nvme0: ANA group 1: inaccessible.
[  797.721982] nvme nvme0: ANA group 2: optimized.
[  797.731169] nvme nvme0: creating 128 I/O queues.
[  797.769481] block nvme0n1: no path available - requeuing I/O
[  797.780867] block nvme0n1: no path available - requeuing I/O
[  797.792248] block nvme0n1: no path available - requeuing I/O
[  797.803629] block nvme0n1: no path available - requeuing I/O
[  797.833640] nvme0c1n1: detected capacity change from 0 to 1073741824
[  797.885628] nvme0c1n2: detected capacity change from 0 to 1073741824
[ 1479.283345] INFO: task xfsaild/nvme0n1:5869 blocked for more than 480
seconds.

Might be the same issue Chaitanya is seeing; investigating further.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
