From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 19 Jun 2018 08:43:17 -0700
Subject: [PATCH] nvme-cli: Implemented primary and secondary controller
In-Reply-To: <20180619154531.GC19922@localhost.localdomain>
References: <20180619152859.3686-1-revanth.rajashekar@intel.com>
 <20180619154531.GC19922@localhost.localdomain>
Message-ID: <20180619154317.GA1638@infradead.org>

On Tue, Jun 19, 2018@09:45:31AM -0600, Keith Busch wrote:
> On Tue, Jun 19, 2018@09:28:59AM -0600, Revanth Rajashekar wrote:
> > +int nvme_ctrl(int fd, __u32 cdw10, void *data)
> > +{
> > +	struct nvme_admin_cmd cmd = {
> > +		.opcode 	= nvme_admin_virtual_mgmt,
> 
> A pitfall from not having a capable device to test with: I'm sure you
> don't possibly mean to use the nvme_admin_virtual_mgmt opcode here.
> 
> Just use nvme_identify().

Btw, I'm really unconfortable with having this code around if it
hasn't actually been tested..
