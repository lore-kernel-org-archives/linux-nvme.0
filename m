From: keith.busch@intel.com (Keith Busch)
Date: Tue, 11 Aug 2015 17:21:38 +0000 (UTC)
Subject: [RESEND PATCH 2/2] NVMe: Add nvme subsystem reset IOCTL
In-Reply-To: <1439309463.2790.3.camel@linux.intel.com>
References: <1439241641-3444-1-git-send-email-keith.busch@intel.com>
 <1439241641-3444-2-git-send-email-keith.busch@intel.com>
 <1439309463.2790.3.camel@linux.intel.com>
Message-ID: <alpine.LNX.2.00.1508111617200.15930@localhost.lm.intel.com>

On Tue, 11 Aug 2015, J Freyensee wrote:
> On Mon, 2015-08-10@15:20 -0600, Keith Busch wrote:
>> From: Jon Derrick <jonathan.derrick at intel.com>
>>
>> Controllers can perform optional subsystem resets as introduced in NVMe
>> 1.1. This patch adds an IOCTL to trigger the subsystem reset by writing
>> "NVMe" to the NSSR register.
>
> I just took a Linux Foundation training class and one of the points the
> Foundation made was the Linux community wanting to move off of IOCTLs
> to other userspace-to-kernelspace mechanisms (like sysfs for example).
>
> I was wondering if it's a good thing to be continuing to add IOCTLs if
> it is true that the Linux community would like to move off the reliance
> of IOCTLs?

Maybe some developers have stronger opinions on adding ioctls. I don't
see a big problem with it. The proposed ioctl doesn't transfer data with
userspace, so we're not committing to maintain a new ABI.

We have sysfs and IOCTL for NVMe controller reset, so maybe we should
have both for subsystem resets too. I like sysfs for shell scripting,
but ioctl seems easier/cleaner to use within applications. I can add a
sysfs entry if this series gets applied.
