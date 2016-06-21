From: keith.busch@intel.com (Keith Busch)
Date: Tue, 21 Jun 2016 18:43:53 -0400
Subject: [PATCH for-4.7] nvme: Remove RCU namespace protection
In-Reply-To: <1466548365-992-1-git-send-email-keith.busch@intel.com>
References: <1466548365-992-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160621224352.GE1448@localhost.localdomain>

BTW, this obsoletes this patch:

  [PATCH] NVMe: Fix possible scheduling while atomic error
  http://lists.infradead.org/pipermail/linux-nvme/2016-May/004634.html

No one liked that patch anyway ...

On Tue, Jun 21, 2016@04:32:45PM -0600, Keith Busch wrote:
> We can't sleep with RCU read lock held, but we need to do potentially
> blocking stuff to namespaces while traversing the list.
> 
> This patch removes the rcu read locking to make this work, and leverages
> how namespace list manipulation currently occurs in order to be safe. Only
> scan work, reset work, or device removal can manipulate the namespace
> list, and none of those can execute at the same time. So, this patch
> locks the namespace list mutex only when the list is being changed,
> or when iterating the list by a non-IO task, like controller reset. We
> can't hold the lock for IO because we won't be able to clean up IO
> if it fails, so all those paths rely on the state machine to prevent
> two tasks from corrupting the list.
