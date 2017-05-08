From: hare@suse.de (Hannes Reinecke)
Date: Mon, 8 May 2017 13:17:11 +0200
Subject: [PATCH 2/2] nvme_fc: add uevent for auto-connect
In-Reply-To: <20170505231335.31726-3-jsmart2021@gmail.com>
References: <20170505231335.31726-1-jsmart2021@gmail.com>
 <20170505231335.31726-3-jsmart2021@gmail.com>
Message-ID: <3fcdf302-ac8b-779b-9660-19ab80c00ce5@suse.de>

On 05/06/2017 01:13 AM, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> To support auto-connecting to FC-NVME devices upon their dynamic
> appearance, add a uevent that can kick off connection scripts.
> uevent is posted against the nvme_fc transport device.
> 
> Added checking to stop the "feature" of connecting to the same
> subsystem multiple times on FC devices.
> 
> Tested with the following rule to kick an nvme-cli connect-all for the
> FC initiator and FC target ports. This is just an example for testing
> and not intended for real life use.
> 
> ACTION=="change", SUBSYSTEM=="fc", ENV{NVMEFC_DISCVRY}=="*", \
> 	RUN+="/bin/sh -c '/usr/local/sbin/nvme connect-all --transport=fc $env{NVMEFC_DISCVRY} >> /tmp/nvme_fc.log'"
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/host/fc.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
Hmm.

I'm not sure if that will work for the proposed multipath extensions for
NVMe.

>From my understanding NVMe will drop all queues and do a full
reconnection upon failure, correct?

So if there is a multipath failure NVMe will have to drop all failed
paths and reconnect.
Which means that if we have an all paths down scenario _all_ paths are
down, and need to be reconnect.
Consequently the root-fs becomes inaccessible for a brief period of
time, and relying on things like udev to do a reconnect will probably
not work.

Also, any other driver (with the notable exception of S/390 ones)(ok,
and iSCSI) does an autoconnect.
And went into _soo_ many configuration problems due to that fact.
zfcp finally caved in and moved to autoconnect, too, precisely to avoid
all these configuration issues.

So what makes NVMe special that it cannot do autoconnect within the driver?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
