From: hare@suse.de (Hannes Reinecke)
Date: Fri, 12 Jul 2019 08:20:37 +0200
Subject: [PATCH rfc v2 04/10] nvme-cli: Refactor to create a
 get_nvme_ctrl_info routine
In-Reply-To: <20190712003140.16221-5-jsmart2021@gmail.com>
References: <20190712003140.16221-1-jsmart2021@gmail.com>
 <20190712003140.16221-5-jsmart2021@gmail.com>
Message-ID: <e4e91783-a59b-8aa9-a1f2-d024ae5390ab@suse.de>

On 7/12/19 2:31 AM, James Smart wrote:
> In preparation for searching controllers to match with connect args:
> 
> Refactor the get_nvme_subsystem_info() routine to take the portion
> that creates a ctrl_list_item and sets its values and put it in a
> separate get_nvme_ctrl_info() routine.
> 
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> CC: Sagi Grimberg <sagi at grimberg.me>
> CC: Hannes Reinecke <hare at suse.com>
> ---
>  nvme.c | 77 ++++++++++++++++++++++++++++++++++++++----------------------------
>  1 file changed, 45 insertions(+), 32 deletions(-)
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
