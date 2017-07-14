From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Jul 2017 09:57:23 +0200
Subject: [PATCH 0/3] Improve readbility of NVME "wwid" attribute
In-Reply-To: <1500018852.4808.1.camel@suse.com>
References: <20170713222533.30794-1-mwilck@suse.com>
 <20170713225739.GE14716@localhost.localdomain>
 <1500018852.4808.1.camel@suse.com>
Message-ID: <20170714075723.GA18097@lst.de>

On Fri, Jul 14, 2017@09:54:12AM +0200, Martin Wilck wrote:
> That was my first approach to the issue. But then I realized that the
> term "WWID" is ususally associated with a hex string. 
> (https://en.wikipedia.org/wiki/World_Wide_Name), so allowing arbitrary
> ASCII might violate some people's assumptions of how a WWID should look
> like. (Not to mention that we don't have a vendor OUI...).

iSCSI device identifiers also use a string, and even worse it's utf8
and not just 7-bit ASCII.
