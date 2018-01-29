From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Jan 2018 22:01:23 +0200
Subject: Reconnect on RDMA device reset
In-Reply-To: <679C11A4-744C-4574-9F50-2D2C3B0F08B0@oracle.com>
References: <CADZhsQqDFc1NWmsihOwki8_2Zj0HuYKC_N_x0jMnCtU9Rww1UA@mail.gmail.com>
 <f0a14240-1566-1bae-1b9f-21880bc3f3a0@grimberg.me>
 <CADZhsQqvK0LMd9sfxzz+x_5qVnoi4FP0FCFMsTPjpeXyqfXKew@mail.gmail.com>
 <77cef33e-a563-97fc-7ba6-69f220f1be84@grimberg.me>
 <1516904022.27592.187.camel@redhat.com>
 <679C11A4-744C-4574-9F50-2D2C3B0F08B0@oracle.com>
Message-ID: <92367a43-4c2e-887f-35ff-38fa05d47c49@grimberg.me>

Hi Chuck,

> For NFS/RDMA, I think of the "failover" case where a device is
> removed, then a new one is plugged in (or an existing cold
> replacement is made available) with the same IP configuration.
> 
> On a "hard" NFS mount, we want the upper layers to wait for
> a new suitable device to be made available, and then to use
> it to resend any pending RPCs. The workload should continue
> after a new device is available.

Really? so the context is held forever (in case the device never
comes back)?
