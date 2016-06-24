From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 24 Jun 2016 00:43:11 -0700
Subject: [PATCH 0/3] nvme: Don't add namespaces for locked drives
In-Reply-To: <5768B989.3070407@jbeekman.nl>
References: <20160619230634.17229-1-kernel@jbeekman.nl>
 <20160620152639.GD12936@localhost.localdomain>
 <57683415.1060202@jbeekman.nl>
 <20160620225444.GB1448@localhost.localdomain>
 <5768B989.3070407@jbeekman.nl>
Message-ID: <20160624074311.GB30277@infradead.org>

On Mon, Jun 20, 2016@08:50:33PM -0700, Jethro Beekman wrote:
> >> You're right, I assumed that admin commands can't have namespace ids, but
> >> looking at the spec, that's not the case. Turns out there's a problem with the
> >> driver then: nvme_ioctl never includes the ns for NVME_IOCTL_ADMIN_CMD.
> > 
> > The NVME_IOCTL_ADMIN_CMD already takes any namespace identifier the user
> > put in that field.
> 
> I see, the ns argument is just to specify the queue. I assume userspace is
> supposed to obtain the ns using NVME_IOCTL_ID? This seems broken, if I have an
> open block device handle I can send commands to any nvme namespace as well as
> the controller? I think on the block devices you should only be able to send
> commands with your nsid. There was some discussion on the security implications
> of this about a year ago [1], and it was decided to fix this, but it doesn't
> look like this was actually merged?
> 
> [1] http://lists.infradead.org/pipermail/linux-nvme/2015-January/001446.html

I think the real problem here is to allow NVME_IOCTL_ADMIN_CMD on a
block device node - admin command in general do not apply to a
namespace, they apply to the whole controller.  Even if you look at the
nsid it's usually used for something global (e.g. the offset in the
namespace list or the namespace to be created / deleted).

Any admin command that applies to a namespace is a nightmare, and we
should not make it easier to issue it on a block device node but instead
build a proper abstraction.  Besides your usage which I can't even find
a spec for they only cases where admin command apply to actual existing
namespaces and could be somewhat safely issued by users having access
only to the namespace are the per-ns smart log and the per-ns features.
