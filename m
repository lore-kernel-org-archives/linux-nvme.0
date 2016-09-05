From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 5 Sep 2016 06:11:27 -0700
Subject: [PATCH] admin-cmd: Added smart-log command support.
In-Reply-To: <ac203b28-39ed-4f2a-b0fc-f586e43c9346@grimberg.me>
References: <1472759103-16538-1-git-send-email-ckulkarnilinux@gmail.com>
 <ac203b28-39ed-4f2a-b0fc-f586e43c9346@grimberg.me>
Message-ID: <20160905131127.GA3176@infradead.org>

On Sun, Sep 04, 2016@11:41:09AM +0300, Sagi Grimberg wrote:
> Given that we don't own the namespaces, I'm wandering if this is the
> correct way to do this... I'm not at all convinced that having something
> else reading/writing to the blkdevs other than nvmf is a valid/useful
> use-case but in this situation we won't get correct log information
> (or at least the semantics is wrong).
> 
> Should we maintain these statistics in the target stack instead?

What's the problem with including possible local I/O?  Having to
maintain another set of counters, including atomics in the fast path
or complex per-cpu infrastructure is something I'd rather avoid.
