From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Jul 2019 09:13:15 -0700
Subject: [PATCH] nvme-rdma: fix possible use-after-free in connect error
 flow
In-Reply-To: <60bd61aa-2022-aac8-b6dd-da1319656da0@mellanox.com>
References: <20190726172949.1635-1-sagi@grimberg.me>
 <60bd61aa-2022-aac8-b6dd-da1319656da0@mellanox.com>
Message-ID: <e50b08b2-4b63-4a82-ed79-0b0e9ee3c89f@grimberg.me>


> looks good,
> 
> maybe we can add dev_dbg print for successful connection.

I don't see a strong reason why we should given that this
information is available to the user from both the default/read/poll
queues print and from sysfs.

> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>

Thanks Max.
