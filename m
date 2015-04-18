From: m@bjorling.me (Matias Bjorling)
Date: Sat, 18 Apr 2015 08:45:19 +0200
Subject: [PATCH 1/5 v2] blk-mq: Add prep/unprep support
In-Reply-To: <20150417174630.GA10249@infradead.org>
References: <1429101284-19490-1-git-send-email-m@bjorling.me>
 <1429101284-19490-2-git-send-email-m@bjorling.me>
 <20150417063439.GB389@infradead.org> <5530C132.30107@bjorling.me>
 <20150417174630.GA10249@infradead.org>
Message-ID: <5531FD7F.8070809@bjorling.me>

Den 17-04-2015 kl. 19:46 skrev Christoph Hellwig:
> On Fri, Apr 17, 2015@10:15:46AM +0200, Matias Bj?rling wrote:
>> Just the prep/unprep, or other pieces as well?
>
> All of it - it's functionality that lies logically below the block
> layer, so that's where it should be handled.
>
> In fact it should probably work similar to the mtd subsystem - that is
> have it's own API for low level drivers, and just export a block driver
> as one consumer on the top side.

The low level drivers will be NVMe and vendor's own PCI-e drivers. It's 
very generic in their nature. Each driver would duplicate the same work. 
Both could have normal and open-channel drives attached.

I'll like to keep blk-mq in the loop. I don't think it will be pretty to 
have two data paths in the drivers. For blk-mq, bios are splitted/merged 
on the way down. Thus, the actual physical addresses needs aren't known 
before the IO is diced to the right size.

The reason it shouldn't be under the a single block device, is that a 
target should be able to provide a global address space. That allows the 
address space to grow/shrink dynamically with the disks. Allowing a 
continuously growing address space, where disks can be added/removed as 
requirements grow or flash ages. Not on a sector level, but on a flash 
block level.

>
>> In the future, applications can have an API to get/put flash block directly.
>> (using the blk_nvm_[get/put]_blk interface).
>
> s/application/filesystem/?
>

Applications. The goal is that key value stores, e.g. RocksDB, 
Aerospike, Ceph and similar have direct access to flash storage. There 
won't be a kernel file-system between.

The get/put interface can be seen as a space reservation interface for 
where a given process is allowed to access the storage media.

It can also be seen in the way that we provide a block allocator in the 
kernel, while applications implement the rest of "file-system" in 
user-space, specially optimized for their data structures. This makes a 
lot of sense for a small subset (LSM, Fractal trees, etc.) of database 
applications.
