From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 13 Apr 2018 11:37:16 -0600
Subject: [RFC PATCH 8/8] nvmet: add configfs interface for target passthru
In-Reply-To: <20180413173004.GC23674@lst.de>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
 <20180330065747.20962-9-chaitanya.kulkarni@wdc.com>
 <be832a05-3906-7087-30ed-f20784128272@deltatee.com>
 <20180413173004.GC23674@lst.de>
Message-ID: <12238d4c-c01d-9590-2357-dbeabff23dfc@deltatee.com>



On 13/04/18 11:30 AM, Christoph Hellwig wrote:
> Maybe.  But how would you design it?  Have a passthrough filed under
> the subsystem that you can echo a controller name to?  And then make
> the exclusive vs creating namespaces?

Yes. It only really requires one field (the path to the nvme char
device) and making it exclusive to namespaces doesn't seem that
unintuitive. An error and appropriate dmesg if one is set before the
other would be pretty clear and quickly understood (compared to a whole
new top level directory named 'pt'). When I'm playing around with
sysfs/configfs/debugfs interfaces I rarely read the documentation and
just watch dmesg if I see an error returned. When I first played around
with this patchset the current interface required me to look at the code
to understand what was going on (there was no documentation).

> Ugg.  Hell no!  Way too much magic.

Fair point.

Logan
