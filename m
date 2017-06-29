From: hch@lst.de (Christoph Hellwig)
Date: Thu, 29 Jun 2017 15:31:59 +0200
Subject: nvme defintions not used in the kernel
In-Reply-To: <20170629083228.GE3808@linux-x5ow.site>
References: <20170628231129.GA20902@lst.de>
 <6503552c-afac-b740-5db6-31d4a7e34256@grimberg.me>
 <20170629083228.GE3808@linux-x5ow.site>
Message-ID: <20170629133159.GA10896@lst.de>

On Thu, Jun 29, 2017@10:32:28AM +0200, Johannes Thumshirn wrote:
> On Thu, Jun 29, 2017@08:44:04AM +0300, Sagi Grimberg wrote:
> > I agree with the latter, should we also move nvme.h to
> > uapi?
> 
> That was my first reaction as well. I'm all for it.

Absolutely not.  It's not a userspace API/ABI.  It's an internal header
that we want to be able to refactor if needed, e.g. if NVMe splits or
renames fields, or adds unions, etc.  It just happens that nvme-cli
needs the same defintions.
