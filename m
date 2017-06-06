From: hare@suse.de (Hannes Reinecke)
Date: Tue, 6 Jun 2017 08:23:56 +0200
Subject: [PATCH v4 3/8] nvmet: implement namespace identify descriptor list
In-Reply-To: <20170604103649.22130-4-jthumshirn@suse.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
 <20170604103649.22130-4-jthumshirn@suse.de>
Message-ID: <7a956950-db5f-30ec-840a-f51b886104e3@suse.de>

On 06/04/2017 12:36 PM, Johannes Thumshirn wrote:
> A NVMe Identify NS command with a CNS value of '3' is expecting a list
> of Namespace Identification Descriptor structures to be returned to
> the host for the namespace requested in the namespace identify
> command.
> 
> This Namespace Identification Descriptor structure consists of the
> type of the namespace identifier, the length of the identifier and the
> actual identifier.
> 
> Valid types are NGUID and UUID which we have saved in our nvme_ns
> structure if they have been configured via configfs. If no value has
> been assigened to one of these we return an "invalid opcode" back to
> the host to maintain backward compatibiliy with older implementations
> without Namespace Identify Descriptor list support.
> 
> Also as the Namespace Identify Descriptor list is the only mandatory
> feature change between 1.2.1 and 1.3.0 we can bump the advertised
> version as well.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/target/admin-cmd.c | 53 +++++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/target/core.c      |  3 ++-
>  drivers/nvme/target/nvmet.h     |  1 +
>  3 files changed, 56 insertions(+), 1 deletion(-)
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
