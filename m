From: Kwok.Kong@idt.com (Kong, Kwok)
Date: Wed, 23 Nov 2011 13:21:25 -0800
Subject: submission queue and completion queue allocation in NVMe
In-Reply-To: <20111123205052.GA14291@linux.intel.com>
References: <5AC4D6A45304E048A30F105EB302760902CBB066@CORPEXCH1.na.ads.idt.com>
 <20111123205052.GA14291@linux.intel.com>
Message-ID: <5AC4D6A45304E048A30F105EB302760902CBB193@CORPEXCH1.na.ads.idt.com>

Agreed. All you need to do is to change the call to be
nvme_admin_set_features instead of get feature.
Set features returns the number of queues that have been allocated. You
don't need to call get feature to find out what was set.

-Kwok


-----Original Message-----
From: Matthew Wilcox [mailto:willy@linux.intel.com] 
Sent: Wednesday, November 23, 2011 12:51 PM
To: Kong, Kwok
Cc: linux-nvme at lists.infradead.org
Subject: Re: submission queue and completion queue allocation in NVMe

On Wed, Nov 23, 2011@10:17:19AM -0800, Kong, Kwok wrote:
> Matthew,
> 
> In the current linux driver, you send a Get Feature with Feature ID = 
> 7 (Number of Queues) to allocate submission and completion queues from

> the controller.
> 
> My understanding is that you should use Set Feature with Feature ID = 
> 7 to allocate submission and completion queues from the controller.  
> The Get Feature with ID = 7 returns the number of queues that have 
> been allocated.
> 
> If you send a Get Feature with ID =7 without first sending a Set 
> Feature with ID =7, the Get feature should return 0 in Dword 0 as no 
> queues have been allocated.
> 
> Do you agree ?

That wasn't my understanding ... but 7.6.1 says I was incorrect.

If I just change the call to be nvme_admin_set_features instead of
get_features, that's sufficient, right?  I don't need to issue a Set
Features and then a Get Features to find out what was set.
