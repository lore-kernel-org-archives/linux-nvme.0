From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Thu, 21 Sep 2017 20:47:10 +0800
Subject: [PATCH] nvme: make controller 'state' sysfs attribute pollable
In-Reply-To: <20170920145931.GA5208@lst.de>
References: <20170920104032.14014-1-jthumshirn@suse.de>
 <20170920145931.GA5208@lst.de>
Message-ID: <82f50ba2-a9c6-256f-5fd3-f515592c4fa7@huawei.com>



On 2017/9/20 22:59, Christoph Hellwig wrote:
> On Wed, Sep 20, 2017@12:40:32PM +0200, Johannes Thumshirn wrote:
>> Notify sysfs about changes of a nvme controller so user-space can watch the
>> file via poll() or select() in order to react to a state change.
> 
> Userspace has no business polling for the state.
> 

Please consider this patch. At least upstream multipath-tools is using the sysfs state now:
[1] https://git.opensvc.com/gitweb.cgi?p=multipath-tools/.git;a=commitdiff;h=29c3b0446c4d919859f9e87b291563d483aab594
[2] https://git.opensvc.com/gitweb.cgi?p=multipath-tools/.git;a=commitdiff;h=d2561442cc0b444e8a728bac2c1466468816ee9d

> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
> 
