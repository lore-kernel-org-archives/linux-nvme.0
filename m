From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 5 Sep 2013 15:28:42 -0400
Subject: [PATCH] NVMe: Avoid caculate cq head doorbel in nvme_process_cq()
In-Reply-To: <5228470F.2040206@huawei.com>
References: <mailman.3257.1377730793.1059.linux-nvme@lists.infradead.org>
 <A103C806EC8D6E46A0D950DAA4D118D1400E0096@szxeml558-mbx.china.huawei.com>
 <20130903155316.GY4707@linux.intel.com> <5226FA47.10205@huawei.com>
 <20130904165142.GA20931@linux.intel.com>
 <5228470F.2040206@huawei.com>
Message-ID: <20130905192842.GD20931@linux.intel.com>

On Thu, Sep 05, 2013@04:55:43PM +0800, Haiyan Hu wrote:
> Your analysis is more comprehensive. Of course, I'd like to send a new patch that
> you advised. Do you think the updated variable named "db_stride_shift"?

I think that might have been a better name for the old meaning :-)  I think
we should probabaly keep the name as-is, but change the usage.  Unless
someone can come up with a better name ... ?
