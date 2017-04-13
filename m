From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Thu, 13 Apr 2017 19:58:13 +0000
Subject: [PATCH 01/25] remove the mg_disk driver
In-Reply-To: <20170406153944.10058-2-hch@lst.de>
References: <20170406153944.10058-1-hch@lst.de>
 <20170406153944.10058-2-hch@lst.de>
Message-ID: <1492113491.24345.7.camel@sandisk.com>

On Thu, 2017-04-06@17:39 +0200, Christoph Hellwig wrote:
> This drivers was added in 2008, but as far as a I can tell we never had a
> single platform that actually registered resources for the platform driver.
> 
> It's also been unmaintained for a long time and apparently has a ATA mode
> that can be driven using the IDE/libata subsystem.

Hello Christoph,

Should the person who submitted this driver be CC-ed for this patch (unsik
Kim <donari75 at gmail.com>)?

Bart.
