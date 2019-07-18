From: hare@suse.de (Hannes Reinecke)
Date: Thu, 18 Jul 2019 07:53:22 +0200
Subject: [PATCH 06/10] nvme-cli: Add routine to compare ctrl_list_item to
 connect args
In-Reply-To: <20190716211241.7650-7-jsmart2021@gmail.com>
References: <20190716211241.7650-1-jsmart2021@gmail.com>
 <20190716211241.7650-7-jsmart2021@gmail.com>
Message-ID: <9c69e6f0-79ee-80a5-4fec-2e5ef3debdf8@suse.de>

On 7/16/19 11:12 PM, James Smart wrote:
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
> 
> ---
> from rfc to actual posting:
>   moved SYS_NVME from fabrics.c to nvme.h
>   replaced nvme_ctrl_dir with SYS_NVME
> ---
>  fabrics.c |  1 -
>  nvme.c    | 38 ++++++++++++++++++++++++++++++++++++++
>  nvme.h    | 11 +++++++++++
>  3 files changed, 49 insertions(+), 1 deletion(-)
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
