From: hare@suse.de (Hannes Reinecke)
Date: Fri, 12 Jul 2019 08:28:21 +0200
Subject: [PATCH rfc v2 07/10] nvme-cli: Add routine to search for
 controller with specific attributes
In-Reply-To: <20190712003140.16221-8-jsmart2021@gmail.com>
References: <20190712003140.16221-1-jsmart2021@gmail.com>
 <20190712003140.16221-8-jsmart2021@gmail.com>
Message-ID: <03d14bc2-5564-e9db-8977-dccb27502a67@suse.de>

On 7/12/19 2:31 AM, James Smart wrote:
> In preparation for searching controllers to match with connect args:
> 
> Create a new routine find_ctrl_with_connectargs() that will search the
> controllers that exist in the system to find one that has attributes
> that match the connect arguments specified.  If found, the routine
> returns the controller name ("nvme?"). If not found, a NULL is returned.
> 
> Routine is defined as a global as a subsequent patch will use it
> from the fabrics routines.
> 
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> CC: Sagi Grimberg <sagi at grimberg.me>
> CC: Hannes Reinecke <hare at suse.com>
> ---
>  nvme.c | 37 +++++++++++++++++++++++++++++++++++++
>  nvme.h |  1 +
>  2 files changed, 38 insertions(+)
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
