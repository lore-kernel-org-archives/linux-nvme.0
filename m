From: kbusch@kernel.org (Keith Busch)
Date: Wed, 10 Apr 2019 11:12:16 -0600
Subject: [PATCH RFC 0/6] nvme: introduce a new flag NVME_ADMIN_QID
In-Reply-To: <20190410080035.82529-1-yuyufen@huawei.com>
References: <20190410080035.82529-1-yuyufen@huawei.com>
Message-ID: <20190410171215.GD3714@localhost.localdomain>

On Wed, Apr 10, 2019@01:00:29AM -0700, Yufen Yu wrote:
> Hi, all
> 
> This patchset introduces a new flag NVME_ADMIN_QID for admin queue.
> Now that, all drivers in host or target are use index '0' as admin
> queues. Thus, we can use a flag NVME_ADMIN_QID instead of using '0',
> which can make code more easy to read and understand.
> 
> This patchset is RFC, and it just use NVME_ADMIN_QID for drivers in
> nvme host. I am not sure whether this patchset actually make sense. 
> Any suggestion is welcome and thanks in advance.

IMO, this makes it harder to read anything that's using the 0 index in a
loop.
