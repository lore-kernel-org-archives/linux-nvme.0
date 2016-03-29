From: judy.brock@ssi.samsung.com (Judy Brock-SSI)
Date: Tue, 29 Mar 2016 11:04:51 +0000
Subject: nvme device timeout
In-Reply-To: <20160329070328.GA8910@infradead.org>
References: <CAHOCc18wCgprYh1k0m0ow1FhU51J-1JN-X2Fj-8VKHDVi-Zo9Q@mail.gmail.com>
 <20160328172423.GA22481@localhost.localdomain>
 <36E8D38D6B771A4BBDB1C0D800158A51865EF73D@SSIEXCH-MB3.ssi.samsung.com>
 <20160328225411.GB27195@localhost.localdomain>
 <20160329070328.GA8910@infradead.org>
Message-ID: <36E8D38D6B771A4BBDB1C0D800158A51865EFB85@SSIEXCH-MB3.ssi.samsung.com>

>>  When it was originally proposed to remove polling, I mentioned we may possibly discover some controllers were unknowingly relying on it. I'm not sure yet if this report is such an issue vs something >> else entirely
> IFF we have to do this it should be a quirk flag for specific controllers that need a not spec compliant workaround.

I think controllers that need it won't know they need it (like Keith hypothesized, will have an unknowing reliance on polling for completions during probe) and so a quirk flag won't do a lot of good.
Seems like it makes sense to put it back in to avoid breaking HW that do need it if there is not a compelling functional reason not to do so. Since 4.6 is still in RC stage, maybe it could be put back into 4.6.


-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org] 
Sent: Tuesday, March 29, 2016 12:03 AM
To: Keith Busch
Cc: Judy Brock-SSI; Tim Mohlmann; linux-nvme at lists.infradead.org
Subject: Re: nvme device timeout

On Mon, Mar 28, 2016@10:54:11PM +0000, Keith Busch wrote:
> As far as bringing the driver initiated polling back, we can talk 
> about that. Do you have a real need for this feature?

IFF we have to do this it should be a quirk flag for specific controllers that need a not spec compliant workaround.
