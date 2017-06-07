From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 7 Jun 2017 11:55:03 +0300
Subject: [PATCH v5 5/9] nvmet: implement namespace identify descriptor list
In-Reply-To: <20170606143617.32143-6-jthumshirn@suse.de>
References: <20170606143617.32143-1-jthumshirn@suse.de>
 <20170606143617.32143-6-jthumshirn@suse.de>
Message-ID: <fe328fa7-76a0-ef75-69fe-5e78e73ec493@mellanox.com>



On 6/6/2017 5:36 PM, Johannes Thumshirn wrote:
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
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> ---

Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
