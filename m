From: snitzer@redhat.com (Mike Snitzer)
Date: Fri, 16 Nov 2018 09:12:29 -0500
Subject: nvme: allow ANA support to be independent of native multipathing
In-Reply-To: <20181116091458.GA17267@lst.de>
References: <2691abf6733f791fb16b86d96446440e4aaff99f.camel@suse.com>
 <20181112215323.GA7983@redhat.com>
 <20181113161838.GC9827@localhost.localdomain>
 <20181113180008.GA12513@redhat.com>
 <20181114053837.GA15086@redhat.com>
 <30cf7af7-8826-55bd-e39a-4f81ed032f6d@suse.de>
 <20181114174746.GA18526@redhat.com>
 <87c931e5-4ac9-1795-8d40-cc5541d3ebcf@suse.de>
 <20181115174605.GA19782@redhat.com> <20181116091458.GA17267@lst.de>
Message-ID: <20181116141229.GC28870@redhat.com>

On Fri, Nov 16 2018 at  4:14am -0500,
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Nov 15, 2018@12:46:05PM -0500, Mike Snitzer wrote:
> > Whether or not ANA is present is a choice of the target implementation;
> > the host (and whether it supports multipathing) has _zero_ influence on
> > this.  If the target declares a path as 'inaccessible' the path _is_
> > inaccessible to the host.  As such, ANA support should be functional
> > even if native multipathing is not.
> > 
> > Introduce ability to always re-read ANA log page as required due to ANA
> > error and make current ANA state available via sysfs -- even if native
> > multipathing is disabled on the host (e.g. nvme_core.multipath=N).
> 
> The first part I could see, but I still want to make it conditional
> in some way as nvme is going into deeply embedded setups, and I don't
> want to carry the weight of the ANA code around for everyone.

So disabling CONFIG_NVME_MULTIPATH isn't adequate?  You see a need for
enabling CONFIG_NVME_MULTIPATH but disallowing consideration of ANA
state management for these embedded cases?  That doesn't make much sense
in that ANA won't be enabled on the target, and if it is then shouldn't
the NVMe host enable ANA support?
 
> The second I fundamentally disagree with.  And even if you found agreement
> it would have to be in a separate patch as it is a separate feature.

In a later mail you clarified that by "second" you meant the sysfs
export.

nvme_ns_id_attrs_are_visible() calls nvme_ctrl_use_ana() to know whether
to export the ana state via sysfs.  Makes no sense to enable ANA to
work, independent of native multipathing, and then even though ANA is
active disallow exporting the associated ANA state.  We need
consistency.. if the sysfs file exists it means ANA state is being
managed.

All I can figure is that what you're suggesting is born out of
disallowing uses you fundamentally disagree with (e.g. multipath-tools
reading the ANA state from this sysfs file).

Mike
