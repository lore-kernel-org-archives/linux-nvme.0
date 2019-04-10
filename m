From: james.smart@broadcom.com (James Smart)
Date: Wed, 10 Apr 2019 13:14:53 -0700
Subject: [PATCH RFC 0/6] nvme: introduce a new flag NVME_ADMIN_QID
In-Reply-To: <20190410080035.82529-1-yuyufen@huawei.com>
References: <20190410080035.82529-1-yuyufen@huawei.com>
Message-ID: <f364ac63-f58f-0f25-7317-713a974bc472@broadcom.com>

On 4/10/2019 1:00 AM, Yufen Yu wrote:
> Hi, all
>
> This patchset introduces a new flag NVME_ADMIN_QID for admin queue.
> Now that, all drivers in host or target are use index '0' as admin
> queues. Thus, we can use a flag NVME_ADMIN_QID instead of using '0',
> which can make code more easy to read and understand.
>

Does it really clarify things that much ??? If so, why isn't '1' 
replaced by FIRST_IO_QUEUE ??? And in some cases I think it actually 
makes it less clear - like the looping indexes.

in most of the cases, the surrounding context is very clear it's working 
on an admin queue, and the nvme standards are rather clear about queue 
id=0 and its meaning.

-- james
