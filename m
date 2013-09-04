From: huhaiyan@huawei.com (Haiyan Hu)
Date: Wed, 4 Sep 2013 17:15:51 +0800
Subject: [PATCH] NVMe: Avoid caculate cq head doorbel in nvme_process_cq()
In-Reply-To: <20130903155316.GY4707@linux.intel.com>
References: <mailman.3257.1377730793.1059.linux-nvme@lists.infradead.org>
 <A103C806EC8D6E46A0D950DAA4D118D1400E0096@szxeml558-mbx.china.huawei.com>
 <20130903155316.GY4707@linux.intel.com>
Message-ID: <5226FA47.10205@huawei.com>

On 2013/9/3 23:53, Matthew Wilcox wrote:
> On Mon, Sep 02, 2013@06:49:34AM +0000, Huhaiyan (haiyan) wrote:
>> We use 2 pointers, one for sq tail doorbell, the other for cq head doorbell in struct nvme_queue, to avoid calculate cq head doorbell in nvme_process_cq(). 
>> This change can reduce latency for the admin/io command.
> 
> Have you been able to measure a difference?  If so, can you share
> relative numbers?
> 
Sorry for my inaccurate description.
Our test data shows that this patch does not change cmd process latency.
But I think it can improve code efficiency, maybe a little.

In addition, the format of the patch I sent is corrupted.
I will resend it later.

Thank you.
