From: hare@suse.de (Hannes Reinecke)
Date: Thu, 18 Jul 2019 07:52:31 +0200
Subject: [PATCH 05/10] nvme-cli: extend ctrl_list_item for connect
 attributes
In-Reply-To: <20190716211241.7650-6-jsmart2021@gmail.com>
References: <20190716211241.7650-1-jsmart2021@gmail.com>
 <20190716211241.7650-6-jsmart2021@gmail.com>
Message-ID: <9425d990-1c58-aa23-6822-a861c781b876@suse.de>

On 7/16/19 11:12 PM, James Smart wrote:
> In preparation for searching controllers to match with connect args:
> 
> Extend the ctrl_list_item with elements that can be compared against
> connect arguments. Extend the get_nvme_ctrl_info() routine to set
> the fields.
> 
> subsysnqn was added as the ctrl_list_item may now be used outside of
> a subsystem listing.
> 
> traddr, trsvid, and host_traddr are added. Their values come from
> the address attribute.  A new parsing routine was added that extracts
> the values from the address string.
> 
> The new parsing routine and supporting field names strings are
> declared as a global interface as a subsequent patch will call it
> from the fabrics routines.
> 
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> CC: Sagi Grimberg <sagi at grimberg.me>
> CC: Hannes Reinecke <hare at suse.com>
> ---
>  nvme.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  nvme.h | 10 ++++++++++
>  2 files changed, 82 insertions(+)
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
