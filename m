From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 11 Jun 2015 03:40:33 -0700
Subject: [PATCH 2/3] NVMe: Don't use fake status on cancelled command
In-Reply-To: <1433779695-15866-3-git-send-email-keith.busch@intel.com>
References: <1433779695-15866-1-git-send-email-keith.busch@intel.com>
 <1433779695-15866-3-git-send-email-keith.busch@intel.com>
Message-ID: <20150611104033.GA21107@infradead.org>

On Mon, Jun 08, 2015@10:08:14AM -0600, Keith Busch wrote:
> Synchronized commands do different things for timed out commands
> vs. controller returned errors.

Can you explain this a bit more?  Can't find anything that checks for
the error value.  Let's hope the EINTR never leaks to userspace either
as it has a well defined and very different meaning there.
