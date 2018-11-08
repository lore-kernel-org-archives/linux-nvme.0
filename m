From: snitzer@redhat.com (Mike Snitzer)
Date: Thu, 8 Nov 2018 11:27:45 -0500
Subject: nvme: make ANA support independent on native nvme multipath
In-Reply-To: <20181108084813.GA3637@lst.de>
References: <20181105154136.142597-1-hare@suse.de>
 <20181108084813.GA3637@lst.de>
Message-ID: <20181108162745.GB28854@redhat.com>

On Thu, Nov 08 2018 at  3:48am -0500,
Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Nov 05, 2018@04:41:36PM +0100, Hannes Reinecke wrote:
> > NVMe native multipathing is an implementation detail on the host,
> > and ANA support is actually independent on that.
> > So we shouldn't check for native NVMe multipathing when trying to
> > evaluate whether ANA is supported; not doing so results in the
> > ANA sysfs attributes not to be present when the 'multipath=false'
> > module option is set.
> 
> No, we should not enable ANA support without multipathing, as we
> don't want people to rely on any ANA related side effects if multipathing
> is not enabled.

Could you be more specific?

Do you have an example side-effect that you hold to be problematic?

As you can imagine I've long hoped for ANA to be decoupled from
multipathing.  Would welcome your throughts on why this is "bad".

Mike
