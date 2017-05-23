From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 23 May 2017 00:29:24 -0700
Subject: [PATCH] Add a parameter for NVME_IOCTL_ID to get Namespaces ID
In-Reply-To: <70ccb746-2cad-69b3-be7a-9515129a7d29@huawei.com>
References: <1495081061-17660-1-git-send-email-zouming.zouming@huawei.com>
 <20170518063808.GA28607@infradead.org>
 <bfb905ee-27a4-d39c-8e4d-2511e66292b1@huawei.com>
 <20170521083410.GB20658@infradead.org>
 <70ccb746-2cad-69b3-be7a-9515129a7d29@huawei.com>
Message-ID: <20170523072924.GA23378@infradead.org>

On Mon, May 22, 2017@03:51:43PM +0800, Zouming (IT) wrote:
> Hi,Christoph
> 
>   Thank you for your detailed response to the fail scenario.
>   Using the ioctl method to get namespace id is easier than using the sysfs file method when only the nvme device's handle is available.
>   So I want to add a new ioctl name called NVME_IOCTL_NS_ID,Is that OK?

I'm still not sold too much on adding a new ioctl, but IFF we do it that
would be the way.
