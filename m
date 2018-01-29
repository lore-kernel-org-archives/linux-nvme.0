From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 29 Jan 2018 14:05:29 +0100
Subject: [LSF/MM TOPIC] NVMe over Fabrics auto-discovery in Linux
In-Reply-To: <64ee446d-118d-364a-e9bb-bcbf80b8135b@grimberg.me> (Sagi
 Grimberg's message of "Wed, 24 Jan 2018 20:42:18 +0200")
References: <20180123151132.wrbc7dcjjhpzcnba@linux-x5ow.site>
 <64ee446d-118d-364a-e9bb-bcbf80b8135b@grimberg.me>
Message-ID: <mqdk1w0lsrq.fsf@linux-x5ow.site>

Sagi Grimberg <sagi at grimberg.me> writes:
> Discovery enhancements is a subject the NVMe TWG will be working on in
> the near future, and "discovery of the  the discovery service" is indeed
> a sub-topic IIRC. I'm not sure LSF would be the appropriate forum for
> this.
>
> What we do need to have, is a way to support existing devices. I think
> its acceptable that FC and Ethernet based transports diverge in their
> implementations for this.
>
> For Ethernet based transports we could follow the open-iscsi model which
> has discoveryd service which periodically polls predefined addresses. As
> for updating initramfs, maybe we can live with this limitation for the
> time being?
>
> FC can keep doing its own thing...

Sure, general discovery enhancements are out of LSF's scope, but for the
implementing a nvme-discoveryd or something similar for Fabrics 1.0
based systems discussion LSF would be the right forum IMHO. This model
still needs /etc/nvme/discovery.conf updates mirrored into the initrd
etc...

Byte,
        Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
