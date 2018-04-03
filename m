From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 2 Apr 2018 21:21:27 -0600
Subject: [RFC PATCH 8/8] nvmet: add configfs interface for target passthru
In-Reply-To: <9CC85AAF-DFCD-4192-811D-E2472349786B@wdc.com>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
 <20180330065747.20962-9-chaitanya.kulkarni@wdc.com>
 <be832a05-3906-7087-30ed-f20784128272@deltatee.com>
 <9CC85AAF-DFCD-4192-811D-E2472349786B@wdc.com>
Message-ID: <53b87be0-d726-3c72-5bfa-3cad6ba6cdb9@deltatee.com>



On 02/04/18 06:13 PM, Chaitanya Kulkarni wrote:
> [CK] Actually pt directory is not identical to what subsystem
> is in following ways: -
> 
> 1. Configuration: -
> subsystem: - we use configfs namespaces directory structure to configure the ns.
> pt: - we use NVMe ns-mgmt commands which allows host to configure the ns.
> 2. Internal representation: -
> subsystem: - we create target ns object for each ns.
> pt: - we don't create target ns object for each ns.
> 3. NS-Management: -
> subsystem: - Namespaces are created and configured on the target side with
> only configfs interface.
> pt: - Namespaces are created from the host side (and optionally on the
> target side with tools before pt configuration) without going through configfs
> interface. 

So this is just a long winded way to say that pt subsystems don't need
to configure the namespaces. It's not really a justification to make
them their own first class entity.

> Also having different directories actually makes user aware about what is being
> configured.

Not really. You're making too large a distinction between pt and
subsystem. They are really the same thing and used in the same way. The
only difference is one has explicit namespaces and the other takes them
from the backing device. So why not just make them the same thing and
configure them slightly differently?

> [CK] We should only add configfs options to the pt interface if
> it is supported by the pt interface, if it is not supported by the
> pt interface then it we should avoid it in the configfs, current proposal
> provides developers flexibility to have only supported options for pt. In this way
> we keep the distinction clear about subsystem and pt.
> Also, we reuse most of the subsystem code for the attributes
> so even in future subsys gets a new attribute there shouldn't
> be much duplication of the code.

I suspect most new config attributes will be supported by both and, as I
said, it will be a burden to developers to have to put them in both
places. 'pt' already replicates many of the same options as subsystems.

> If we really don?t want have ?pt? parallel to ?subsystems? then please have a look at 3  rd
> approach of pt under subsystem, this way we will share the subsystems attributes, here
> as you mentioned we can prevent creation of the namespaces through configfs when
> ?attr_ctrl_path? is configured.
> For reference providing existing Subsystem (1) and pt (2) configuration.

I don't know what you are getting at here.

> /sys/kernel/config/
> ??? nvmet
>     ??? hosts
>     ??? ports
>     ?   ??? 1
>     ?       ??? referrals
>     ?       ??? subsystems
>     ?           ??? nvme0 -> ../../../../nvmet/pt/nvme0
>     ??? pt
>     ?   ??? nvme0

This is also confusing to the user: linking a pt under the subsystems
directory. This is more evidence that a pt is just a subsystem.
> [CK] That is exactly what I'd try to avoid since it will entangle the code of
> subsystem and pt. In case if everyone is okay with this approach, let?s do this.

Good, we want them entangled because they are the same thing.

> [CK] This imposes burden on the sysadmin to have a mandatory
> namespace. Since it is a ctrl pass-through we should avoid use of
> both pass-through-ns, configfs-namespaces directory and internal
> target ns structure as much as possible.

No, it imposes no additional burden on the sysadmin. With the pt
structure they require a single mandatory ns as well. The only
difference is where things are configured and your current scheme is
confusing, creates extra work for developers and unnecessarily
duplicates an existing concept. 'pt' is also a very poor name that's
completely meaningless to anyone that doesn't already understand what it
already means.

Logan
