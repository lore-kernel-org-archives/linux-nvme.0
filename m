From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 3 May 2016 00:58:21 -0700
Subject: [PATCH-4.7 1/3] NVMe: Return ENODEV error on invalid namespace
In-Reply-To: <1462209128-12376-2-git-send-email-keith.busch@intel.com>
References: <1462209128-12376-1-git-send-email-keith.busch@intel.com>
 <1462209128-12376-2-git-send-email-keith.busch@intel.com>
Message-ID: <20160503075821.GA31768@infradead.org>

On Mon, May 02, 2016@11:12:06AM -0600, Keith Busch wrote:
> If there is no namespace associated with the request, return an error
> code that notifies the application the device isn't there.

I think we're heading in the wrong direction here.  I actually had some
discussion with Jens and Marting on how we should get rid of overloading
random errnos in the block layer and instead have block layer error
codes.

What applications care?  And where are the meanings of these error
codes documented?
