From: snitzer@redhat.com (Mike Snitzer)
Date: Mon, 29 Jan 2018 16:17:23 -0500
Subject: [LSF/MM TOPIC] update NVMe multipath to conditionally claim
 controllers
Message-ID: <20180129211722.GB5744@redhat.com>

I'd like to have the same Linux kernel be able to use either NVMe's
native multipath or DM multipath.

Should be relatively simple to filter which controllers can/cannot be
claimed by NVMe multipathing (without having to resort to the big hammer
of CONFIG_NVME_MULTIPATH).

I'd like to understand what is the preferred disposition of the filter
list (black or white)?  I assume having a blacklist would be more
inkeeping with Christoph's desire for NVMe to be the default for NVMe
multipathing.  But that disposition aside, not sure if there are other
issues that should influence implementing more flexible use of NVMe
resources.

Thanks,
Mike
