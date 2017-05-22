From: zouming.zouming@huawei.com (Zouming (IT))
Date: Mon, 22 May 2017 15:51:43 +0800
Subject: [PATCH] Add a parameter for NVME_IOCTL_ID to get Namespaces ID
In-Reply-To: <20170521083410.GB20658@infradead.org>
References: <1495081061-17660-1-git-send-email-zouming.zouming@huawei.com>
 <20170518063808.GA28607@infradead.org>
 <bfb905ee-27a4-d39c-8e4d-2511e66292b1@huawei.com>
 <20170521083410.GB20658@infradead.org>
Message-ID: <70ccb746-2cad-69b3-be7a-9515129a7d29@huawei.com>

Hi,Christoph

  Thank you for your detailed response to the fail scenario.
  Using the ioctl method to get namespace id is easier than using the sysfs file method when only the nvme device's handle is available.
  So I want to add a new ioctl name called NVME_IOCTL_NS_ID,Is that OK?

Best regards,
Zou Ming.

On 2017/5/21 16:34, Christoph Hellwig wrote:
> On Thu, May 18, 2017@03:14:23PM +0800, Zouming (IT) wrote:
>> The problem trying to solve is below:
>> 1?According to nvme spec, the possible range of Namespaces ID is form 1 to FFFFFFFe
>> 2?When use NVME_IOCTL_ID IOCTL cmd to get namespaces ID?if return error before function nvme_ioctl?
>> How can user distinguish the return value is valid namespaces ID or error value?
>>
>> Do you think this situation exsits or there will never fail when use NVME_IOCTL_ID cmd?
> 
> NVME_IOCTL_ID can't fail in the NVMe driver itself, but it can fail
> because the device isn't a NVMe device or a security module rejected it.
> 
> So you'd have to add a new ioctl additional ioctl that copies it out.
> Or just use the sysfs file..
> 
> .
> 
