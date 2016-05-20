From: keith.busch@intel.com (Keith Busch)
Date: Fri, 20 May 2016 19:05:28 -0400
Subject: [PATCH] NVMe: fix deadlock on failure branch in
 nvme_get_ns_from_disk()
In-Reply-To: <1463783760-5851-1-git-send-email-khoroshilov@ispras.ru>
References: <1463783760-5851-1-git-send-email-khoroshilov@ispras.ru>
Message-ID: <20160520230527.GA2839@localhost.localdomain>

On Sat, May 21, 2016@01:36:00AM +0300, Alexey Khoroshilov wrote:
> kref_put(&ns->kref, nvme_free_ns) is called in nvme_get_ns_from_disk()
> under dev_list_lock spinlock, while nvme_free_ns() locks the spinlock
> by itself. This can lead to a deadlock.
> 
> The patch moves try_module_get() and its error handling
> out of spinlock section.

This is also fixed with this earlier posted patch:

  http://lists.infradead.org/pipermail/linux-nvme/2016-May/004530.html
