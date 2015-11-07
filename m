From: guenther@tum.de (Stephan =?utf-8?Q?G=C3=BCnther?=)
Date: Sat, 7 Nov 2015 02:32:15 +0100
Subject: [PATCH 0/2] nvme: adding support for Apple's NVMe controller
In-Reply-To: <20151104142503.GB20776@infradead.org>
References: <33537e8a12dff1f96eaec9098724d01e@localhost>
 <20151104142503.GB20776@infradead.org>
Message-ID: <f2f93645dfc169a8b99d27df755e6fee@localhost>

On 2015/November/04 06:25, Christoph Hellwig wrote:
> Looks fine,
>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
>

So far I had 2 feedbacks regarding controller resets and data loss using
the patch while debootstrapping or using a partition as root file
system.

Might be that controller properties exported to userspace are
subject to the same issue with 64bit atomic operations like the NVMe
module itself.

We will further investigate those problems in our spare time, and of
course welcome any suggestions what might cause those issues.


Although I was not able to reproduce the problem so far (there is also a
firmware upgrade going on with OSX 10.11.2), I must point out more I did
before that using our Apple NVMe patch might cause data loss if being
used careless.
