From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 8 Oct 2018 03:13:23 -0700
Subject: Kernel v4.19-rc4 KASAN complaint
In-Reply-To: <20181008061152.GA18836@X58A-UD3R>
References: <20181006170915.GS2674@linux.ibm.com>
 <31b80bc0-afc6-6bd9-c722-302f538d3e5b@lge.com>
 <20181008061152.GA18836@X58A-UD3R>
Message-ID: <20181008101323.GA29380@infradead.org>

On Mon, Oct 08, 2018@03:11:52PM +0900, Byungchul Park wrote:
> Is it ok to call nvme_mpath_clear_current_path(ns) without holding
> any lock in nvme_failover_req(req)? No possible to race with other
> rcu_assign_pointer(ns->head->current_path, some_value)?

We can race with an assignment, but it should be harmless, as that
call is just an optimization to get everyone to stop using the
path ASAP.  If we actually free the namespace we always go through
nvme_ns_remove, which calls nvme_mpath_clear_current_path under
subsys->lock.
