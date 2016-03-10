From: hch@lst.de (Christoph Hellwig)
Date: Thu, 10 Mar 2016 09:06:28 +0100
Subject: [PATCH] nvme: add a constant for the identify payload size
In-Reply-To: <20160309190731.GD2464@linux.intel.com>
References: <1457542477-25191-1-git-send-email-hch@lst.de>
 <20160309190731.GD2464@linux.intel.com>
Message-ID: <20160310080628.GB716@lst.de>

On Wed, Mar 09, 2016@02:07:31PM -0500, Matthew Wilcox wrote:
> On Wed, Mar 09, 2016@05:54:37PM +0100, Christoph Hellwig wrote:
> > The NVMe spec specifies a hardcoded payload length of 4k for all
> > types of Identify commands.  Use a constant instead of hardcoded
> > values that can be confused for the page size.
> 
> I think the problem here is that we don't have a struct for nvme_ns_list.

I think this structure is useful, but I'd still like to see a constant
for the identify payload - the spec clearly specifies it as a hardcoded
limit for all of identify.  E.g. from NVMe 1.2, section 5.11:

"5.11 Identify command The Identify command returns a data buffer that
 describes information about the NVM subsystem, the controller or the
 namespace(s). The data structure is 4096 bytes in size."
