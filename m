From: keith.busch@intel.com (Keith Busch)
Date: Mon, 18 Apr 2016 18:32:15 +0000
Subject: [PATCH] nvme: fix nvme_ns_remove() deadlock
In-Reply-To: <1461003703-18950-1-git-send-email-mlin@kernel.org>
References: <1461003703-18950-1-git-send-email-mlin@kernel.org>
Message-ID: <20160418183214.GC4640@localhost.localdomain>

On Mon, Apr 18, 2016@11:21:43AM -0700, Ming Lin wrote:
> From: Ming Lin <ming.l at ssi.samsung.com>
> 
> On receipt of a namespace attribute changed AER, we acquire the
> namespace mutex lock before proceeding to scan and validate the
> namespace list. In case of namespace detach/delete command,
> nvme_ns_remove function deadlocks trying to acquire the already held
> lock.
> 
> All callers, except nvme_remove_namespaces(), of nvme_ns_remove()
> already held namespaces_mutex. So we can simply fix the deadlock by
> not acquiring the mutex in nvme_ns_remove() and acquiring it in
> nvme_remove_namespaces().

This fixes one deadlock by introducing another.

The reason we don't hold the namespace lock during nvme_ns_remove is
because del_gendisk blocks until all IO is flushed. If the controller
fails during this, you'll deadlock nvme_dev_disable as it tries to
recover. 
