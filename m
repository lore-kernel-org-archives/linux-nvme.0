From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 23 Nov 2011 15:50:52 -0500
Subject: submission queue and completion queue allocation in NVMe
In-Reply-To: <5AC4D6A45304E048A30F105EB302760902CBB066@CORPEXCH1.na.ads.idt.com>
References: <5AC4D6A45304E048A30F105EB302760902CBB066@CORPEXCH1.na.ads.idt.com>
Message-ID: <20111123205052.GA14291@linux.intel.com>

On Wed, Nov 23, 2011@10:17:19AM -0800, Kong, Kwok wrote:
> Matthew,
> 
> In the current linux driver, you send a Get Feature with Feature ID = 7
> (Number of Queues) to allocate submission and completion queues from the
> controller.
> 
> My understanding is that you should use Set Feature with Feature ID = 7
> to allocate submission and completion queues from the controller.  The
> Get Feature with ID = 7 returns the number of queues that have been
> allocated.
> 
> If you send a Get Feature with ID =7 without first sending a Set Feature
> with ID =7, the Get feature should return 0 in Dword 0 as no queues have
> been allocated.
> 
> Do you agree ?

That wasn't my understanding ... but 7.6.1 says I was incorrect.

If I just change the call to be nvme_admin_set_features instead of
get_features, that's sufficient, right?  I don't need to issue a Set
Features and then a Get Features to find out what was set.
