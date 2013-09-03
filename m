From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 3 Sep 2013 11:53:16 -0400
Subject: [PATCH] NVMe: Avoid caculate cq head doorbel in nvme_process_cq()
In-Reply-To: <A103C806EC8D6E46A0D950DAA4D118D1400E0096@szxeml558-mbx.china.huawei.com>
References: <mailman.3257.1377730793.1059.linux-nvme@lists.infradead.org>
 <A103C806EC8D6E46A0D950DAA4D118D1400E0096@szxeml558-mbx.china.huawei.com>
Message-ID: <20130903155316.GY4707@linux.intel.com>

On Mon, Sep 02, 2013@06:49:34AM +0000, Huhaiyan (haiyan) wrote:
> We use 2 pointers, one for sq tail doorbell, the other for cq head doorbell in struct nvme_queue, to avoid calculate cq head doorbell in nvme_process_cq(). 
> This change can reduce latency for the admin/io command.

Have you been able to measure a difference?  If so, can you share
relative numbers?
