From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 29 Mar 2017 20:42:33 +0300
Subject: [PATCH 1/1] nvme: don't ignore tagset allocation failures
In-Reply-To: <20170329173241.GC20181@localhost.localdomain>
References: <1490778212-11007-1-git-send-email-maxg@mellanox.com>
 <a7db55a8-d40a-81e9-332e-2bd0306687bc@grimberg.me>
 <20170329173241.GC20181@localhost.localdomain>
Message-ID: <fb263c4e-0403-c39c-1c88-be47d846c2b6@grimberg.me>


> Not having a tagset doesn't mean we can't go live; it just means we can't
> do IO, but the admin handle is still up for device management.

So don't queue ns scanning...

> Also, nvme_queue_scan can be triggered from places outside nvme pci's control,
> so I think Max's patch is an appropriate place to check.

How is that not racy?
