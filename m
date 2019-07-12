From: hare@suse.de (Hannes Reinecke)
Date: Fri, 12 Jul 2019 08:25:49 +0200
Subject: [PATCH rfc v2 06/10] nvme-cli: Add routine to compare
 ctrl_list_item to connect args
In-Reply-To: <20190712003140.16221-7-jsmart2021@gmail.com>
References: <20190712003140.16221-1-jsmart2021@gmail.com>
 <20190712003140.16221-7-jsmart2021@gmail.com>
Message-ID: <da7269f9-e6c0-62a6-a2af-f65979e83bdc@suse.de>

On 7/12/19 2:31 AM, James Smart wrote:
> In preparation for searching controllers to match with connect args:
> 
> Create a new routine that receives a structure containing connect
> arguments and a device name. The routine will build and fill in a
> ctrl_list_item for the device and compare its attributes with the
> connect arguments. The routine returns true/false on whether they
> match.
> 
> Routine is defined as a global as a subsequent patch will use it
> from the fabrics routines.
> 
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> CC: Sagi Grimberg <sagi at grimberg.me>
> CC: Hannes Reinecke <hare at suse.com>
> ---
>  nvme.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  nvme.h |  9 +++++++++
>  2 files changed, 49 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
