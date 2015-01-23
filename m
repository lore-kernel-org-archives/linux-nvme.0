From: keith.busch@intel.com (Keith Busch)
Date: Fri, 23 Jan 2015 17:50:33 +0000 (UTC)
Subject: [PATCH 1/1] NVMe: Do not take nsid while a passthrough IO command
 is being issued via a block device file descriptor
In-Reply-To: <20150123172745.GA28005@infradead.org>
References: <1421971328-5065-1-git-send-email-yan@purestorage.com>
 <20150123075708.GA17232@infradead.org>
 <alpine.LNX.2.00.1501231451380.15481@localhost.lm.intel.com>
 <20150123172745.GA28005@infradead.org>
Message-ID: <alpine.LNX.2.00.1501231737070.15481@localhost.lm.intel.com>

On Fri, 23 Jan 2015, Christoph Hellwig wrote:
> On Fri, Jan 23, 2015@04:22:02PM +0000, Keith Busch wrote:
>> The namespace id should be enforced on block devices, but is there a
>> problem allowing arbitrary commands through the management char device?
>> I have a need for a pure passthrough, but the proposed patch requires
>> a matching namespace id all the time.
>>
>> I wrote and tested the one below to override nsid on block devices,
>> but doesn't require a visible namespace through the management device.
>
> Allowing requests to differetn namespaces through the admin interface
> doesn't sound too horrible in general, but I still don't like your patch
> below.  Instead of allocating another queue that allows arbitrary nsids
> we should simply look up the namespace when sent through the admin device,
> and still reject it if the namespace isn't valid.  If a namespaces
> is marked hidden we should still create a device for it in Linux,
> as that whole concept of hiding a namespace is silly.

No argument against removing the hidden attribute handling, but there
are unadvertised NSID's that have special meaning. Like NSID 0xffffffff
means to apply a command to all namespaces. Vendor specific commands
may have other special NSID meanings as well.
