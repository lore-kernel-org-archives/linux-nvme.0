From: pickup112@gmail.com (=?UTF-8?B?5p2O5pil?=)
Date: Thu, 17 May 2018 15:50:31 +0800
Subject: can not load more than 51 nvme rdma device
In-Reply-To: <CAGpjB9JN-L0F=iYRzuSLKyz+0kAwUL=qn4Xp7hLsEO2RSUtSfw@mail.gmail.com>
References: <CAGpjB9J2F3VhGnPe+uXSmuu-H0dTfbQT+5fOem4j_vsBcwGfwQ@mail.gmail.com>
 <47711850-d805-d5b3-2b7b-ed9acbee514a@mellanox.com>
 <CAGpjB9JN-L0F=iYRzuSLKyz+0kAwUL=qn4Xp7hLsEO2RSUtSfw@mail.gmail.com>
Message-ID: <CAGpjB9++ehsb91nE+An2vg6n4E0HWxomA2zOTuwH4-yn=tD2Vg@mail.gmail.com>

another question?
And how can we get how many MRs left in the Infiniband CA.
?? <pickup112 at gmail.com> ?2018?5?17??? ??3:15???

> Thanks for you help.


> > Any reason for this type of 1:1 configuration ?
> > Can you expose all 100 disks using 1 subsystem or 10 disks per
subsystem ?
> > Do you understand the difference in resource allocation between both
> cases ?

> Our actual production environment will use IB switches for interconnect in
> a cluster. And in the actual production environment, we may also have
> hundreds of disks output to the same node.
> After we found this problem with io_queue, we recreated the problem in a
> test environment with two nodes directly connected.
> We know the difference you mentioned, but in the actual production
> environment, we do have more than 51 targets loaded. So want to understand
> thoroughly why this restriction occurs and whether there is a way to get
> around this limitation


> > try to use --queue-size=16 in your conect command.
> > You don't realy need so many resources (10 io queues with 128 queue-size
> > each) to saturate 56Gb wire.

> How can we turn the size of nr-io-queues or queue-size. Is there a best
> practice for our scenario?
> Increase or decrease the queue-size/nr-io-queues will impact what?
> so if nr-io-queues * queue-size * nvme_connect_number> max_mr, we will
meet
> the error.

> > This is because you try to allocate more MRs that the maximum support of
> > the device.
> > In NVNe/RDMA We create "queue-size" number of MRs per each created IO
> queue.

> How can we know the maximum MRs  support by the device?
> Do you mean that MR refers to Memory Region?

> > The max_mr for this adapter is much bigger.
> > If the above solutions are not enough, then we can dig-in more to low
> > level drivers...

> According to what you said above, max_mr is just the hardware attribute,
> not related to Linux, nvme, rdma, is't it?

> Whether max_mr is the attribute of a network card or a port on a network
> card? according to my test on this side, after a port of a network card
> reports an error on the dual port network card, another port can continue
> to load a new target.

> Can you suggest any information or document  which introduce relationship
> between queue-size, nr_io_queues and MRs.







> --
> pickup.lichun ??



-- 
pickup.lichun ??
