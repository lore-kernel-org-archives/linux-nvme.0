From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Jul 2017 14:28:55 +0200
Subject: [PATCH 0/3] Improve readbility of NVME "wwid" attribute
In-Reply-To: <1500025297.4808.6.camel@suse.com>
References: <20170713222533.30794-1-mwilck@suse.com>
 <20170713225739.GE14716@localhost.localdomain>
 <20170714075612.GE17877@lst.de> <1500025297.4808.6.camel@suse.com>
Message-ID: <20170714122855.GB26187@lst.de>

On Fri, Jul 14, 2017@11:41:37AM +0200, Martin Wilck wrote:
> The "if provided" is the crucial point here. In real life currently
> many people struggle with ugly overlong identifiers because these IDs
> are _not_ provided by default.

NVMe has some pretty strong language in that regard since 1.2, which says
for the EUI64/NGUID fields:

"The controller shall specify a globally unique namespace identifier in this
 field or the EUI64 field when the namespace is created."

And with 1.3 the new mandatory Identify 03h.  So there really aren't
any excuses anymore.
