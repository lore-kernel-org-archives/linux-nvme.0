From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 18 Jan 2018 15:32:07 +0100
Subject: Support needed with setting up multipath on NVMeoF
In-Reply-To: <CDAF3D5FC44D984DBB5AC42F738B4BA2589895F5@IRSMSX107.ger.corp.intel.com>
References: <CDAF3D5FC44D984DBB5AC42F738B4BA2589895F5@IRSMSX107.ger.corp.intel.com>
Message-ID: <20180118143207.kwmmxhkx6kyd3rcj@linux-x5ow.site>

On Thu, Jan 18, 2018@02:24:12PM +0000, Cybulski, PawelX wrote:
> Nvme list-subsys is displaying
> nvme-subsys0 - NQN=nvme-subsystem-TEST
> \
> +- nvme0 rdma traddr=100.0.0.90 trsvcid=1055
> nvme-subsys1 - NQN=nvme-subsystem-TEST2
> \
> +- nvme1 rdma traddr=100.0.50.90 trsvcid=1055
[...]
> Could you point me to documentation where I could find setup steps for nvme multipath (different options, fail over, round robin), or if there isn't any could you provide me with some steps to follow.

Here's what I usually do:
nvme connect -t rdma -a 100.0.50.90 -s 1055 -n nvme-subsystem-TEST2 -w <IP of 1st ifc>
nvme connect -t rdma -a 100.0.50.90 -s 1055 -n nvme-subsystem-TEST2 -w <IP of 2nd ifc>

This should give you two paths to nvme-subsystem-TEST2 (repeat for the other
one as well).

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
