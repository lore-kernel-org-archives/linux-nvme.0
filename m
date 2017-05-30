From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 May 2017 10:24:12 +0200
Subject: [PATCH 5/7] nvmet: implement namespace identify descriptor list
In-Reply-To: <f18b0bd18d171e7ca824925ff3136b20f9bb132e.1496131397.git.jthumshirn@suse.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
 <f18b0bd18d171e7ca824925ff3136b20f9bb132e.1496131397.git.jthumshirn@suse.de>
Message-ID: <01e9be1b-b110-adf4-8c31-11b272bfe920@suse.de>

On 05/30/2017 10:08 AM, Johannes Thumshirn wrote:
> A NVMe Identify NS command with a CNS value of '3' is expecting a list
> of Namespace Identification Descriptor structures to be returned to
> the host for the namespace requested in the namespace identify
> command.
> 
> This Namespace Identification Descriptor structure consists of the
> type of the namespace identifier, the length of the identifier and the
> actual identifier.
> 
> Valid types are EUI-64, NGUID and UUID which we have saved in our
> nvme_ns structure if they have been configured via configfs. If no
> value has been assigened to one of these we return an "invalid opcode"
> back to the host to maintain backward compatibiliy with older
> implementations without Namespace Identify Descriptor list support.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/target/admin-cmd.c | 75 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/nvme.h            | 14 ++++++++
>  2 files changed, 89 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
