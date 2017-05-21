From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 21 May 2017 01:34:10 -0700
Subject: [PATCH] Add a parameter for NVME_IOCTL_ID to get Namespaces ID
In-Reply-To: <bfb905ee-27a4-d39c-8e4d-2511e66292b1@huawei.com>
References: <1495081061-17660-1-git-send-email-zouming.zouming@huawei.com>
 <20170518063808.GA28607@infradead.org>
 <bfb905ee-27a4-d39c-8e4d-2511e66292b1@huawei.com>
Message-ID: <20170521083410.GB20658@infradead.org>

On Thu, May 18, 2017@03:14:23PM +0800, Zouming (IT) wrote:
> The problem trying to solve is below:
> 1?According to nvme spec, the possible range of Namespaces ID is form 1 to FFFFFFFe
> 2?When use NVME_IOCTL_ID IOCTL cmd to get namespaces ID?if return error before function nvme_ioctl?
> How can user distinguish the return value is valid namespaces ID or error value?
> 
> Do you think this situation exsits or there will never fail when use NVME_IOCTL_ID cmd?

NVME_IOCTL_ID can't fail in the NVMe driver itself, but it can fail
because the device isn't a NVMe device or a security module rejected it.

So you'd have to add a new ioctl additional ioctl that copies it out.
Or just use the sysfs file..
