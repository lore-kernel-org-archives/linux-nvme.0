From: keith.busch@intel.com (Keith Busch)
Date: Thu, 1 Mar 2018 09:10:42 -0700
Subject: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
In-Reply-To: <20180301150329.GB6795@ming.t460p>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de> <20180301150329.GB6795@ming.t460p>
Message-ID: <20180301161042.GA14799@localhost.localdomain>

On Thu, Mar 01, 2018@11:03:30PM +0800, Ming Lei wrote:
> If all CPUs for the 1st IRQ vector of admin queue are offline, then I
> guess NVMe can't work any more.

Yikes, with respect to admin commands, it appears you're right if your
system allows offlining CPU0.

> So looks it is a good idea to make admin queue's IRQ vector assigned as
> non-managed IRQs.

It'd still be considered managed even if it's a 'pre_vector', though
it would get the default mask with all possible CPUs.
