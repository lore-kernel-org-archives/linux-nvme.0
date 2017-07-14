From: mwilck@suse.com (Martin Wilck)
Date: Fri, 14 Jul 2017 11:58:16 +0200
Subject: [PATCH 3/3] nvme: wwid_show: copy hex string verbatim
In-Reply-To: <20170714075451.GD17877@lst.de>
References: <20170713222533.30794-1-mwilck@suse.com>
 <20170713222533.30794-4-mwilck@suse.com> <20170714075451.GD17877@lst.de>
Message-ID: <1500026296.4808.8.camel@suse.com>

On Fri, 2017-07-14@09:54 +0200, Christoph Hellwig wrote:
> On Fri, Jul 14, 2017@12:25:33AM +0200, Martin Wilck wrote:
> > If the serial number is a series of hex digits (as usual for the
> > Linux target), there's no need to encode it in hex once more.
> > This will improve the readability of NVME wwids for users.
> 
> NAK, this will break existing device identifiers.
> 

If this is what you think, you must also NAK my patch 2/3, because
stripping the 0-bytes also changes how the WWID is presented to user
space. For example

nvme.0000-3163653363666438366239656630386200-
4c696e75780000000000000000000000000000000000000000000000000000000000000
000000000-00000001

becomes after 2/3:

nvme.0000-31636533636664383662396566303862-4c696e7578-00000001

3/3 would change this again to

nvme.0000-1ce3cfd86b9ef08b-4c696e7578-00000001

and Keith's proposal would change it to

nvme.0000-1ce3cfd86b9ef08b-Linux-00000001

User space that relies on the string in the first format would break
already with 2/3. However, multipath, which is probably the main
consumer of the WWID for practical purposes, can't handle the overlong
format anyway (I'm preparing a patch series to fix that).

Therefore, please think twice. It may be worthwhile to accept an
exception to the API stability rule here. Some people will be bitten,
but we will have a saner WWID format in the future. Of course, if this
is to be changed, we'd better do it asap.

Note also that this identifier is volatile for Linux targets anyway,
as the serial number changes between target reboots (I'm aware of
Johannes' recent attempt to change this, but again this is going to be
a configuration that the storage admin must actively apply).

As I wrote in my other mail, if API stability prevails, let's introduce
a new attribute with cleaner format.

Martin
-- 
Dr. Martin Wilck <mwilck at suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
