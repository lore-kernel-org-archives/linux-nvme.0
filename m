From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 10 Mar 2016 09:30:18 -0500
Subject: [PATCH] nvme: add a constant for the identify payload size
In-Reply-To: <20160310080628.GB716@lst.de>
References: <1457542477-25191-1-git-send-email-hch@lst.de>
 <20160309190731.GD2464@linux.intel.com>
 <20160310080628.GB716@lst.de>
Message-ID: <20160310143018.GE2464@linux.intel.com>

On Thu, Mar 10, 2016@09:06:28AM +0100, Christoph Hellwig wrote:
> On Wed, Mar 09, 2016@02:07:31PM -0500, Matthew Wilcox wrote:
> > On Wed, Mar 09, 2016@05:54:37PM +0100, Christoph Hellwig wrote:
> > > The NVMe spec specifies a hardcoded payload length of 4k for all
> > > types of Identify commands.  Use a constant instead of hardcoded
> > > values that can be confused for the page size.
> > 
> > I think the problem here is that we don't have a struct for nvme_ns_list.
> 
> I think this structure is useful, but I'd still like to see a constant
> for the identify payload - the spec clearly specifies it as a hardcoded
> limit for all of identify.  E.g. from NVMe 1.2, section 5.11:

The spec clearly specifies a lot of things as hardcoded values, and our
reaction to that is to create structs that are that size, and assert
that they are that size (in case somebody mistakenly tweaks the struct).
This patch makes the ns_list be treated the same way as every other
structure, rather than treating the size of the data block returned from
identify as being special.
