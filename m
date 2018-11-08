From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Nov 2018 09:48:13 +0100
Subject: [PATCH] nvme: make ANA support independent on native nvme
 multipath
In-Reply-To: <20181105154136.142597-1-hare@suse.de>
References: <20181105154136.142597-1-hare@suse.de>
Message-ID: <20181108084813.GA3637@lst.de>

On Mon, Nov 05, 2018@04:41:36PM +0100, Hannes Reinecke wrote:
> NVMe native multipathing is an implementation detail on the host,
> and ANA support is actually independent on that.
> So we shouldn't check for native NVMe multipathing when trying to
> evaluate whether ANA is supported; not doing so results in the
> ANA sysfs attributes not to be present when the 'multipath=false'
> module option is set.

No, we should not enable ANA support without multipathing, as we
don't want people to rely on any ANA related side effects if multipathing
is not enabled.
