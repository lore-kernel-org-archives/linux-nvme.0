From: keith.busch@intel.com (Keith Busch)
Date: Mon, 11 Mar 2013 16:32:56 -0600 (MDT)
Subject: [PATCH 3/4] NVMe: End-to-end data protection
In-Reply-To: <OF3535E1B1.74C282ED-ON86257B2B.0078E2F3-86257B2B.0079DD3B@hgst.com>
References: <OF3535E1B1.74C282ED-ON86257B2B.0078E2F3-86257B2B.0079DD3B@hgst.com>
Message-ID: <alpine.LRH.2.03.1303111611440.17928@localhost.localdom>

On Mon, 11 Mar 2013, David.Darrington@hgst.com wrote:

> Is this correct:
>> +/*
>> + * Valid formats must have either no meta-data, or meta-data equal to
> the DIF
>> + * size and formatted for protection information. The driver has no use
> for
>> + * meta-data for any other purpose.
>> + */
>
> This patch fails nvme_alloc_ns() if there is meta data, but data
> protection is not enabled.
>
> Are there valid use cases where the driver passes through the meta-data to
> and from the controller, without generating  or verifying? Is it possible
> for applications to provided there own meta-data?

Other than the integrity extensions, I don't think there is anything in
a bio request that a block driver can use to set the command meta-data
pointer, whether an application wants to provide it or otherwise. Please
let me know if I've missed something, though.
