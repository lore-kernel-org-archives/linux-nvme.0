From: keith.busch@intel.com (Keith Busch)
Date: Thu, 1 Mar 2018 08:15:44 -0700
Subject: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
In-Reply-To: <66e4ad3e-4019-13ec-94c0-e168cc1d95b4@oracle.com>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de>
 <ddfc2ab4-1a51-c488-25e8-bc434edf8aba@grimberg.me>
 <66e4ad3e-4019-13ec-94c0-e168cc1d95b4@oracle.com>
Message-ID: <20180301151544.GA17676@localhost.localdomain>

On Thu, Mar 01, 2018@06:05:53PM +0800, jianchao.wang wrote:
> When the adminq is free, ioq0 irq completion path has to invoke nvme_irq twice, one for itself,
> one for adminq completion irq action.

Let's be a little more careful on the terminology when referring to spec
defined features: there is no such thing as "ioq0". The IO queues start
at 1. The admin queue is the '0' index queue.

> We are trying to save every cpu cycle across the nvme host path, why we waste nvme_irq cycles here.
> If we have enough vectors, we could allocate another irq vector for adminq to avoid this.

Please understand the _overwhelming_ majority of time spent for IRQ
handling is the context switches. There's a reason you're not able to
measure a perf difference between IOQ1 and IOQ2: the number of CPU cycles
to chain a second action is negligible.
