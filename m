From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 May 2018 19:45:17 +0200
Subject: [PATCH 09/14] nvmet: Add AEN configuration support
In-Reply-To: <A5F28D4A728A7E41839CDC5C3B5A01E8B74D35C6@FMSMSX103.amr.corp.intel.com>
References: <20180526102735.31404-1-hch@lst.de>
 <20180526102735.31404-10-hch@lst.de>
 <A5F28D4A728A7E41839CDC5C3B5A01E8B74D2557@FMSMSX103.amr.corp.intel.com>
 <20180529172936.GA1235@lst.de>
 <A5F28D4A728A7E41839CDC5C3B5A01E8B74D35C6@FMSMSX103.amr.corp.intel.com>
Message-ID: <20180529174517.GB1637@lst.de>

On Tue, May 29, 2018@05:35:12PM +0000, Verkamp, Daniel wrote:
> Sorry, I should have been clearer - I agree with your position here.  Only bits that are valid should be allowed, so for example it is fine to fail commands that set reserved bits, or optional bits that have a mechanism to indicate they are not supported, like Telemetry (which has an associated bit in Identify controller data - LPA).  My note above was really just about the health warning bits, which by my reading are not optional.

Yes, I think your reading is right and we should not fail those bits.
I'll fix it for the next version.
