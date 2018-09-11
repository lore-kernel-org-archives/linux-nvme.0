From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 11 Sep 2018 00:23:17 -0700
Subject: Devices expected?
In-Reply-To: <20180907155524.GA857@localhost.localdomain>
References: <DE927C68B458BE418D582EC97927A9288003E585@ORSMSX113.amr.corp.intel.com>
 <20180906210508.GA31480@localhost.localdomain>
 <DE927C68B458BE418D582EC97927A9288003FD37@ORSMSX113.amr.corp.intel.com>
 <20180907155524.GA857@localhost.localdomain>
Message-ID: <20180911072317.GA17437@infradead.org>

On Fri, Sep 07, 2018@09:55:25AM -0600, Keith Busch wrote:
> > Does nvme2c1n1 represent one path for the nvme2n1 device to use?  If I connected a second path I would see something like nvme2c2n1 pop up as well?
> 
> Yes, that is what that those names represent.
> 
> In your example, the '2' in nvme2 is the subsystem instance, which
> is just a unique number software assigned to the subsystem. The '1'
> in nvme2c1 is the controller id that identify controller reports, so it
> may not necessarily start at 1 or increase sequentially.

Also note that we will only use the multipath code if the namespace
is marked as shared namespace in NMIC.  For private namespaces we
skip the multipath detection.
