From: lina.lulina@huawei.com (Lulina (A))
Date: Mon, 7 Jan 2019 13:27:41 +0800
Subject: [PATCH v2] nvme-pci: fix dbbuf_sq_db point to freed memory
In-Reply-To: <20190104180710.GA4642@infradead.org>
References: <E5D59058E6941147BD3ACF9CB4AA49E3B3572EC2@DGGEMA505-MBX.china.huawei.com>
 <20190104180710.GA4642@infradead.org>
Message-ID: <5C32E34D.3030705@huawei.com>

Thanks for replying to my email, my description in the last email was not
clear enough, so here's a supplementary note.

The NVME device I used support DBBUF, but the nvme_admin_dbbuf request
returned a failure that eventually led to the kernel crash.

The problem occurs as follows:
1, Device support NVME_CTRL_OACS_DBBUF_SUPP?so reset worker alloc memory
   for dev->dbbuf_dbs?
2, In nvme_setup_io_queues process, the nvme_dbbuf_init function is called
   to assign values to pointers such as nvmeq->dbbuf_sq_db.
3, In nvme_dev_add function, the nvme_admin_dbbuf request is sent to the
   device, but the device returns failed, so the memory that dev->dbbuf_dbs
   points to is released.

Then, the driver issued IO requests, in the nvme_write_sq_db process,
nvme_dbbuf_update_and_check_event function judgment to Nvmeq->dbbuf_sq_db
pointer is not NULL, write to the memory it points to, causing memory
confusion and kernel crash.

On 2019/1/5 2:07, Christoph Hellwig wrote:
> On Fri, Dec 21, 2018@01:07:25AM +0000, Lulina (A) wrote:
>> The case is that nvme device support NVME_CTRL_OACS_DBBUF_SUPP, and
>> return failed when the driver sent nvme_admin_dbbuf. The nvmeq->dbbuf_sq_db
>> point to freed memory, as nvme_dbbuf_set is called after nvme_dbbuf_init.
> 
> But we never use those pointers in that state, do we?  Can you explain
> the problem in a little more detail?
> 
> 
