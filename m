From: keith.busch@intel.com (Keith Busch)
Date: Thu, 9 Jun 2016 12:38:55 -0400
Subject: general preparation for NVMe over Fabrics support
In-Reply-To: <1465248052-17811-1-git-send-email-hch@lst.de>
References: <1465248052-17811-1-git-send-email-hch@lst.de>
Message-ID: <20160609163854.GF1696@localhost.localdomain>

On Mon, Jun 06, 2016@11:20:42PM +0200, Christoph Hellwig wrote:
> This patch set adds some needed preparations for the upcoming NVMe over
> Fabrics support.
> 
> Contains:
> - Allow transfer size limitations for NVMe transports
> - Add the get_log_page command definition required by the NVMe target
> - more helpers in core code that can be used by various transports
> - add some missing constants and identify attributes

This series looks good.

Reviewed-by: Keith Busch <keith.busch at inte.com>

For patch ordering, I had thought there were no issues with these
I submitted:

  http://lists.infradead.org/pipermail/linux-nvme/2016-May/004704.html
  http://lists.infradead.org/pipermail/linux-nvme/2016-May/004709.html

It's the ones adding the SCHED_RESET state to fixup synchronizing
continuous user initiated resets, and think it should still go in for 4.7.
There will be a minor conflict with 10/10 in this set it does go first.

Anyway, moving on to the Fabrics library support set!
