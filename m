From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Wed, 18 Apr 2018 22:24:28 +0800
Subject: PATCH V4 0/5 nvme-pci: fixes on nvme_timeout and nvme_dev_disable
In-Reply-To: <20180417151700.GC16286@ming.t460p>
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180417151700.GC16286@ming.t460p>
Message-ID: <a6e1de6d-6086-d467-d9ce-641bcd07b983@oracle.com>

Hi Ming

On 04/17/2018 11:17 PM, Ming Lei wrote:
> Looks blktest(block/011) can trigger IO hang easily on NVMe PCI device,
> and all are related with nvme_dev_disable():
> 
> 1) admin queue may be disabled by nvme_dev_disable() from timeout path
> during resetting, then reset can't move on
> 
> 2) the nvme_dev_disable() called from nvme_reset_work() may cause double
> completion on timed-out request 
> 
> So could you share us what your plan is about this patchset?

Regarding to this patchset, it is mainly to fix the dependency between
nvme_timeout and nvme_dev_disable, as your can see:
nvme_timeout will invoke nvme_dev_disable, and nvme_dev_disable have to
depend on nvme_timeout when controller no response. Till now, some parts
of the patchset looks bad and seem to have a lot of work need to be done.
:)

Thanks
Jianchao
