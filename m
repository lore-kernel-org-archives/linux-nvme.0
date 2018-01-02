From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 2 Jan 2018 11:01:48 +0800
Subject: [PATCH V2 2/6] blk-mq: support concurrent blk_mq_quiesce_queue()
In-Reply-To: <20171229095833.GB24507@lst.de>
References: <20171214023103.18272-1-ming.lei@redhat.com>
 <20171214023103.18272-3-ming.lei@redhat.com>
 <20171229095833.GB24507@lst.de>
Message-ID: <20180102030146.GA20428@ming.t460p>

On Fri, Dec 29, 2017@10:58:33AM +0100, Christoph Hellwig wrote:
> The quiesce count looks good to me.  But I'm really worried about
> the force unquiesce in nvme.  I'd feel much better if we could find

This patch doesn't change the behaviour wrt. force unquiesce in NVMe,
which has been done since commit 443bd90f2cca(nvme: host: unquiesce queue
in nvme_kill_queues()).

The reason is that NVMe's usage of blk_mq_quiesce_queue() is a bit complicated,
for example:

- nvme_dev_disable(false) may be called two times in reset_work()
- queue may never be started in nvme_fw_act_work()
...

But blk_cleanup_queue() can be triggered anytime.

> a way to move this into the core.

We can't move the force unquiesce into blk_set_queue_dying() or other
places in core before calling blk_cleanup_queue(), because that may
break SCSI which uses quiesce to implement device block.

thanks,
Ming
