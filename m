From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 18 Jul 2019 09:03:30 +0200
Subject: [PATCH blktests v2 03/12] nvme: Add new test to verify the
 generation counter
In-Reply-To: <20190717171259.3311-4-logang@deltatee.com>
References: <20190717171259.3311-1-logang@deltatee.com>
 <20190717171259.3311-4-logang@deltatee.com>
Message-ID: <20190718070330.GC15760@x250.microfocus.com>

On Wed, Jul 17, 2019@11:12:50AM -0600, Logan Gunthorpe wrote:
[...]
> +_discovery_genctr() {
> +	nvme discover -t loop |
> +		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
> +}

Sorry for not having spotted this in v1, but do we really want to hard-core
the transport type in a library function?

Maybe sth like this:

_discovery_genctr() {
	local trtype=$1
	nvme discover -t ${trtype} |
		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
}

I think Omar can fix it up when applying.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
