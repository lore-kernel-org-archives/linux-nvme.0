From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 19 Jun 2017 16:06:23 +0800
Subject: [PATCH rfc 28/30] nvme: update tagset nr_hw_queues when
 reallocating io queues
In-Reply-To: <20170619072148.GE13168@lst.de>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-29-git-send-email-sagi@grimberg.me>
 <20170619072148.GE13168@lst.de>
Message-ID: <20170619080622.GA396@ming.t460p>

On Mon, Jun 19, 2017@09:21:48AM +0200, Christoph Hellwig wrote:
> On Sun, Jun 18, 2017@06:22:02PM +0300, Sagi Grimberg wrote:
> > Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> 
> Could use a changelog.
> 
> Ming: does this solve your problem of not seeing the new queues
> after a qemu CPU hotplug + reset?

The issue I observed is that there isn't NVMe reset triggered after
CPU becomes online.

It may take a while since the test need to apply the whole patchset.
Or is it fine to figure out one fix on this issue? Sagi?

Once the test is done, I will update with you.

Thanks,
Ming
