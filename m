From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Tue, 11 Aug 2015 14:23:07 -0700
Subject: [RESEND PATCH 2/2] NVMe: Add nvme subsystem reset IOCTL
In-Reply-To: <20150811181355.GA16410@infradead.org>
References: <1439241641-3444-1-git-send-email-keith.busch@intel.com>
 <1439241641-3444-2-git-send-email-keith.busch@intel.com>
 <1439309463.2790.3.camel@linux.intel.com>
 <20150811181355.GA16410@infradead.org>
Message-ID: <1439328187.6345.10.camel@linux.intel.com>

On Tue, 2015-08-11@11:13 -0700, Christoph Hellwig wrote:
> On Tue, Aug 11, 2015@09:11:03AM -0700, J Freyensee wrote:
> > I just took a Linux Foundation training class and one of the points 
> > the
> > Foundation made was the Linux community wanting to move off of 
> > IOCTLs
> > to other userspace-to-kernelspace mechanisms (like sysfs for 
> > example). 
> 
> That's incorrect, and I don't think Linux Foundation trainers should
> claim to speak for the community.  If that's their standard of 
> training
> I'd ask for a refund.


Well, from old email threads (like this one: 
http://yarchive.net/comp/linux/ioctl.html), it appears Linus had a
preference of not using ioctl's, so maybe the Foundation bases its info
off of those old emails.  But I understand, it totally depends on the
implementation solution.
