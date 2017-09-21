From: hch@lst.de (Christoph Hellwig)
Date: Thu, 21 Sep 2017 16:50:02 +0200
Subject: nvme multipath support V2
In-Reply-To: <20170921052345.pj5ymmqsfmckas2b@linux-x5ow.site>
References: <20170918231453.27128-1-hch@lst.de>
 <20170920110959.hwvujtis6ywnbb5p@linux-x5ow.site>
 <20170920145546.GB4709@lst.de>
 <20170921052345.pj5ymmqsfmckas2b@linux-x5ow.site>
Message-ID: <20170921145002.GA18634@lst.de>

On Thu, Sep 21, 2017@07:23:45AM +0200, Johannes Thumshirn wrote:
> Ah OK, we maybe should update nvme-cli to recognize it as well then. I just
> looked at the output of nvme list and obviously didn't find it.

Overloading the new per-subsystem nodes into nvme list would be
very confusing I think.  We could add a new command to list subsystems
instead of controllers, if just doing a ls in /dev or sysfs is too hard.
