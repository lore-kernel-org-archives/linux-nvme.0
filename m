From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 Feb 2015 22:28:11 +0000 (UTC)
Subject: [PATCH] NVME: Splitting large i/o in the ioctl path
In-Reply-To: <1648698662.233191424693005310.JavaMail.weblogic@epmlwas07b>
References: <1648698662.233191424693005310.JavaMail.weblogic@epmlwas07b>
Message-ID: <alpine.LNX.2.00.1502232211260.32385@localhost.lm.intel.com>

On Mon, 23 Feb 2015, Sathyavathi M wrote:
> On 02/20/2015 10:31 AM, Keith Busch wrote:
>> Anyway, I think we need to fix the driver's adding disks of this extended
>> type first. Right now I think we're corrupting data and memory if we
>> encounter such a device. I proposed setting the capacity to 0 so you
>> can still access the disk media through the ioctl, but not through the
>> standard block layer.
>
> Keith,
> Do you have any other comments on this patch.

This feature you're going for should be more successful if you write it
against 4.0-rc1. We got the initial meta-data handling merged upstream
over the weekend so we don't corrupt memory on these formats anymore.
