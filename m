From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 7 Oct 2016 00:31:11 -0700
Subject: Problem with new uapi header in Linux kernel 4.4+
In-Reply-To: <C17953214F1EE04D9E8A11E8F3E869F051C4F9@ORSMSX110.amr.corp.intel.com>
References: <37b9f516-a945-d41f-b21a-48728d7f9680@fu-berlin.de>
 <C17953214F1EE04D9E8A11E8F3E869F051C4F9@ORSMSX110.amr.corp.intel.com>
Message-ID: <20161007073111.GB1936@infradead.org>

Hi Scott,

> For what it is worth the kernel will soon have OPAL support built in 
> so you won't have to do this weird hack, and use a tool that is no
> longer maintained. 

What's the ETA for OPAL support?  We had a patch from Intel for it
half a year ago, but the submitter didn't follow up on the review
feedback.  (Same for the simple ATA security unlock scheme submitted
by someone else).
