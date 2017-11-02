From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 2 Nov 2017 11:22:34 -0700
Subject: [PATCH 16/17] nvme: implement multipath access to nvme subsystems
In-Reply-To: <70b681c5-5fae-ae40-2ff6-60cf75d52616@huawei.com>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-17-hch@lst.de>
 <70b681c5-5fae-ae40-2ff6-60cf75d52616@huawei.com>
Message-ID: <20171102182234.GB29558@infradead.org>

On Mon, Oct 30, 2017@11:37:55AM +0800, Guan Junxiong wrote:
> > +	head->disk->flags = GENHD_FL_EXT_DEVT;
> > +	sprintf(head->disk->disk_name, "nvme%dn%d",
> > +			ctrl->subsys->instance, nsid);
> 
> Is it okay to use head->instance instead of nsid for disk name nvme#n# ?
> Becuase _nsid_ sets are not continuous sometimes, so disk name is ugly in that case.

This actually was supposed to be the ns_head instance, that's why the
ns_ida moved to the subsystem.  I've fixed it up.
