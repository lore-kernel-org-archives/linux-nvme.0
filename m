From: paul.grabinar@ranbarg.com (Paul Grabinar)
Date: Wed, 15 Jul 2015 18:37:31 +0100
Subject: [PATCH] NVMe: Reread partitions on metadata formats
In-Reply-To: <55A559B5.2000303@fb.com>
References: <1436896668-27373-1-git-send-email-keith.busch@intel.com>
 <55A559B5.2000303@fb.com>
Message-ID: <55A69A5B.1050203@ranbarg.com>

On 14/07/15 19:49, Jens Axboe wrote:
> On 07/14/2015 11:57 AM, Keith Busch wrote:
>> This patch has the driver automatically reread partitions if a namespace
>> has a separate metadata format. Previously revalidating a disk was
>> sufficient to get the correct capacity set on such formatted drives,
>> but partitions that may exist would not have been surfaced.
>
> Looks sane to me. Paul, does this fix your issue?
>
>

Yes, I can confirm this fixes the issue. After loading the driver, the
devices for the partitions are now created are are usable.
Thank you.
