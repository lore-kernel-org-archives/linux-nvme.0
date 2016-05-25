From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 25 May 2016 01:15:33 -0700
Subject: [PATCHv2] NVMe: Sync reset and scan work
In-Reply-To: <20160524213954.GD24347@localhost.localdomain>
References: <1464102370-11283-1-git-send-email-keith.busch@intel.com>
 <20160524155938.wzzsmje6bhlkghwk@c203.arch.suse.de>
 <20160524213954.GD24347@localhost.localdomain>
Message-ID: <20160525081533.GA14263@infradead.org>

On Tue, May 24, 2016@05:39:54PM -0400, Keith Busch wrote:
> The EPERM description sounded about right: "Operation not permitted". The
> user just attempted a reset at an impermissable time, but didn't give any
> illegal arguments. The exact same action could very well be successful
> a moment later. Maybe EBUSY or EAGAIN?

EBUSY.  EAGAIN has a special meaning due to non-blocking I/O.
