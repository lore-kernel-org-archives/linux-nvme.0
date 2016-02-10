From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 10 Feb 2016 10:36:27 -0800
Subject: [PATCH for-4.5 03/13] NVMe: Allow request merges
In-Reply-To: <1455128250-5984-4-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-4-git-send-email-keith.busch@intel.com>
Message-ID: <20160210183627.GA7512@infradead.org>

On Wed, Feb 10, 2016@11:17:20AM -0700, Keith Busch wrote:
> It is generally more efficient to submit larger IO.

In general it is, but it might be good to try to understand
why this flag was set in the first place, and why the argument
for that isn't true anymore, or never was.
