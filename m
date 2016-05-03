From: keith.busch@intel.com (Busch, Keith)
Date: Tue, 3 May 2016 14:19:28 +0000
Subject: [PATCH-4.7 1/3] NVMe: Return ENODEV error on invalid namespace
In-Reply-To: <20160503075821.GA31768@infradead.org>
References: <1462209128-12376-1-git-send-email-keith.busch@intel.com>
 <1462209128-12376-2-git-send-email-keith.busch@intel.com>
 <20160503075821.GA31768@infradead.org>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93D578C4F@fmsmsx104.amr.corp.intel.com>

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch at infradead.org]
> Sent: Tuesday, May 03, 2016 1:58 AM
> To: Busch, Keith
> Cc: Jens Axboe; Christoph Hellwig; linux-nvme at lists.infradead.org
> Subject: Re: [PATCH-4.7 1/3] NVMe: Return ENODEV error on invalid namespace
> 
> On Mon, May 02, 2016@11:12:06AM -0600, Keith Busch wrote:
> > If there is no namespace associated with the request, return an error
> > code that notifies the application the device isn't there.
> 
> I think we're heading in the wrong direction here.  I actually had some
> discussion with Jens and Marting on how we should get rid of overloading
> random errnos in the block layer and instead have block layer error
> codes.
> 
> What applications care?  And where are the meanings of these error
> codes documented?

This was added at the joint request from one OSV and IHV. I've no idea what they're software is doing with this, but they say it doesn't do the right thing with 'EIO'. ENODEV for invalid namespaces sounded like a reasonable error.
