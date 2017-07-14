From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Jul 2017 09:54:51 +0200
Subject: [PATCH 3/3] nvme: wwid_show: copy hex string verbatim
In-Reply-To: <20170713222533.30794-4-mwilck@suse.com>
References: <20170713222533.30794-1-mwilck@suse.com>
 <20170713222533.30794-4-mwilck@suse.com>
Message-ID: <20170714075451.GD17877@lst.de>

On Fri, Jul 14, 2017@12:25:33AM +0200, Martin Wilck wrote:
> If the serial number is a series of hex digits (as usual for the
> Linux target), there's no need to encode it in hex once more.
> This will improve the readability of NVME wwids for users.

NAK, this will break existing device identifiers.
