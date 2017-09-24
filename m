From: hch@lst.de (Christoph Hellwig)
Date: Sun, 24 Sep 2017 16:42:48 +0200
Subject: [PATCH 9/9] nvme: implement multipath access to nvme subsystems
In-Reply-To: <20170921211246.GB10713@localhost.localdomain>
References: <20170918231453.27128-1-hch@lst.de>
 <20170918231453.27128-10-hch@lst.de>
 <20170920225822.GE1379@localhost.localdomain> <20170920235250.GA28865@lst.de>
 <20170921211246.GB10713@localhost.localdomain>
Message-ID: <20170924144248.GB13681@lst.de>

On Thu, Sep 21, 2017@05:12:46PM -0400, Keith Busch wrote:
> BTW, considered persistent nameing rules to symlink these from
> /dev/disk/by-id/? May need to add an attribute to the multipath object
> to assist that.

Yes, we do.  I've just been trying to push out udev/systemd work
as long as possible in the hopes that someone else will do it,
as it always seems painful.

But I think we should also offer versions of our id attributes
on this device to make life easier.
