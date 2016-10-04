From: hare@suse.de (Hannes Reinecke)
Date: Tue, 4 Oct 2016 09:37:26 +0200
Subject: [PATCH 4/7] nvme-fabrics: Updates to FC LLDD api
In-Reply-To: <57f34bb4.88wY2eZRXxyCcIzu%james.smart@broadcom.com>
References: <57f34bb4.88wY2eZRXxyCcIzu%james.smart@broadcom.com>
Message-ID: <80f3182f-7ae9-b252-dd4f-acc9dbe22b03@suse.de>

On 10/04/2016 08:27 AM, James Smart wrote:
> 
> Updated the FC-NVME LLDD api for the following:
> - removal of fabric name for nport qualifier. No longer necessary in T11
> - Added sqid to the initiator FCP request structure.
>   Useful to the LLDD when re-generating successful CQE payloads
>   which were not transferred due to protocol reasons.
> - Add poll_queue() callback to initiator template. Supports the blk-mq
>   polling interfaces to look for command completion.
> - Add callbacks for localport, remoteport, and targetport unregister
>   completions. Required after change for ref-counting.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  include/linux/nvme-fc-driver.h | 45 ++++++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 17 deletions(-)
> 
Same as with patch 2/7: please merge with the previous patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
