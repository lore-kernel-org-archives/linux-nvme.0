From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 Jan 2018 16:04:01 +0100
Subject: [dm-devel] [LSF/MM TOPIC] update NVMe multipath to conditionally
 claim controllers
In-Reply-To: <20180129211722.GB5744@redhat.com>
References: <20180129211722.GB5744@redhat.com>
Message-ID: <8fd6e799-361b-01f2-2226-b5fe6fae0a5b@suse.de>

On 01/29/2018 10:17 PM, Mike Snitzer wrote:
> I'd like to have the same Linux kernel be able to use either NVMe's
> native multipath or DM multipath.
> 
> Should be relatively simple to filter which controllers can/cannot be
> claimed by NVMe multipathing (without having to resort to the big hammer
> of CONFIG_NVME_MULTIPATH).
> 
> I'd like to understand what is the preferred disposition of the filter
> list (black or white)?  I assume having a blacklist would be more
> inkeeping with Christoph's desire for NVMe to be the default for NVMe
> multipathing.  But that disposition aside, not sure if there are other
> issues that should influence implementing more flexible use of NVMe
> resources.
> 
+1

The discussion here is not so much about the technical merits but rather
about the customer/admin expectations.
Some customers have quite some elaborate tooling around provisioning
etc, so they will be putting up support calls with us if those fail to
work with NVMe.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
