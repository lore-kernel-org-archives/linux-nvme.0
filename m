From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 25 Jul 2016 10:44:24 +0200
Subject: [PATCH] nvme-fabrics: Patch host code in prep for FC transport
 support
In-Reply-To: <5792b916.P2ksarpXpcxZ+l9s%james.smart@broadcom.com>
References: <5792b916.P2ksarpXpcxZ+l9s%james.smart@broadcom.com>
Message-ID: <20160725084424.iik47jb647zjq465@c203.arch.suse.de>

On Fri, Jul 22, 2016@05:23:50PM -0700, James Smart wrote:
> 
> Patch nvme-fabrics host code in prep for FC transport support:
> - Add the host_traddr field to allow specification of the host-port
>   connection info for the transport. Will be used by FC transport.
> - Revise nvmf_get_address() string to account for not all options being
>   present.
> - Revise some of the comments so not so ethernet-network centric

This IMHO should at least be split into two patches, one for:

 - Add the host_traddr field to allow specification of the host-port
   connection info for the transport. Will be used by FC transport.

and one for:

 - Revise nvmf_get_address() string to account for not all options being
   present.

I'm not sure if the comment change needs to be split out or can be part of
one of these patches or should be split out.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
