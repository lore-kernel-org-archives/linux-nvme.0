From: zouming.zouming@huawei.com (Zouming (IT))
Date: Thu, 18 May 2017 15:14:23 +0800
Subject: [PATCH] Add a parameter for NVME_IOCTL_ID to get Namespaces ID
In-Reply-To: <20170518063808.GA28607@infradead.org>
References: <1495081061-17660-1-git-send-email-zouming.zouming@huawei.com>
 <20170518063808.GA28607@infradead.org>
Message-ID: <bfb905ee-27a4-d39c-8e4d-2511e66292b1@huawei.com>


> This break any existing user.  I also don't really understand the
> problem you're trying to solve..
> 
> .
> 
The problem trying to solve is below:
1?According to nvme spec, the possible range of Namespaces ID is form 1 to FFFFFFFe
2?When use NVME_IOCTL_ID IOCTL cmd to get namespaces ID?if return error before function nvme_ioctl?
How can user distinguish the return value is valid namespaces ID or error value?

Do you think this situation exsits or there will never fail when use NVME_IOCTL_ID cmd?
