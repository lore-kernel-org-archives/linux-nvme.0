From: kernel@jbeekman.nl (Jethro Beekman)
Date: Mon, 20 Jun 2016 20:50:33 -0700
Subject: [PATCH 0/3] nvme: Don't add namespaces for locked drives
In-Reply-To: <20160620225444.GB1448@localhost.localdomain>
References: <20160619230634.17229-1-kernel@jbeekman.nl>
 <20160620152639.GD12936@localhost.localdomain> <57683415.1060202@jbeekman.nl>
 <20160620225444.GB1448@localhost.localdomain>
Message-ID: <5768B989.3070407@jbeekman.nl>

On 20-06-16 15:54, Keith Busch wrote:
> On Mon, Jun 20, 2016@11:21:09AM -0700, Jethro Beekman wrote:
>> On 20-06-16 08:26, Keith Busch wrote:
>>
>> Would this just be a matter of setting req->retries and checking for it in
>> nvme_req_needs_retry? How does one keep track of the number of tries so far?
> 
> I just sent a patch out earlier today to use req->retries to track the
> retry count, and nvme module parameter to set the max retries. I think
> that would fix the long delays you're seeing, assuming the patch is okay.

Your patch "nvme: Limit command retries" works for me and obviates the need for
this patch.

>> You're right, I assumed that admin commands can't have namespace ids, but
>> looking at the spec, that's not the case. Turns out there's a problem with the
>> driver then: nvme_ioctl never includes the ns for NVME_IOCTL_ADMIN_CMD.
> 
> The NVME_IOCTL_ADMIN_CMD already takes any namespace identifier the user
> put in that field.

I see, the ns argument is just to specify the queue. I assume userspace is
supposed to obtain the ns using NVME_IOCTL_ID? This seems broken, if I have an
open block device handle I can send commands to any nvme namespace as well as
the controller? I think on the block devices you should only be able to send
commands with your nsid. There was some discussion on the security implications
of this about a year ago [1], and it was decided to fix this, but it doesn't
look like this was actually merged?

[1] http://lists.infradead.org/pipermail/linux-nvme/2015-January/001446.html

Jethro
