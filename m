From: Kwok.Kong@idt.com (Kong, Kwok)
Date: Wed, 23 Nov 2011 10:17:19 -0800
Subject: submission queue and completion queue allocation in NVMe
Message-ID: <5AC4D6A45304E048A30F105EB302760902CBB066@CORPEXCH1.na.ads.idt.com>

Matthew,

In the current linux driver, you send a Get Feature with Feature ID = 7
(Number of Queues) to allocate submission and completion queues from the
controller.

My understanding is that you should use Set Feature with Feature ID = 7
to allocate submission and completion queues from the controller.  The
Get Feature with ID = 7 returns the number of queues that have been
allocated.

If you send a Get Feature with ID =7 without first sending a Set Feature
with ID =7, the Get feature should return 0 in Dword 0 as no queues have
been allocated.

Do you agree ?

Thanks

-kwok 
