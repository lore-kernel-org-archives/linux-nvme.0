From: hch@lst.de (Christoph Helwig)
Date: Thu, 19 Oct 2017 10:51:11 +0200
Subject: NVMe target log page offset not supported
In-Reply-To: <A5F28D4A728A7E41839CDC5C3B5A01E887295CEF@FMSMSX103.amr.corp.intel.com>
References: <A5F28D4A728A7E41839CDC5C3B5A01E887295CEF@FMSMSX103.amr.corp.intel.com>
Message-ID: <20171019085111.GB14227@lst.de>

On Wed, Oct 18, 2017@11:52:04PM +0000, Verkamp, Daniel wrote:
> Unfortunately, I don't have time right now to write and thoroughly test a patch for this, so I thought I'd at least make it known.  It's on my todo list...

Yes, implementing it should be fairly easy, but I'd like to start
wanting test coverage for things like this.

Chaitanya has a really nice test framework, I think it might be a good
fit for that.
