From: oren.duer@gmail.com (Oren Duer)
Date: Thu, 25 Jan 2018 16:10:44 +0200
Subject: Reconnect on RDMA device reset
In-Reply-To: <77cef33e-a563-97fc-7ba6-69f220f1be84@grimberg.me>
References: <CADZhsQqDFc1NWmsihOwki8_2Zj0HuYKC_N_x0jMnCtU9Rww1UA@mail.gmail.com>
 <f0a14240-1566-1bae-1b9f-21880bc3f3a0@grimberg.me>
 <CADZhsQqvK0LMd9sfxzz+x_5qVnoi4FP0FCFMsTPjpeXyqfXKew@mail.gmail.com>
 <77cef33e-a563-97fc-7ba6-69f220f1be84@grimberg.me>
Message-ID: <CADZhsQpM8=MXRU=_015f3bo_EisM8N4vL=8XkO1a4c4yHwbC3w@mail.gmail.com>

>> Yes, it could be a userspace script/daemon job. But I was under the
>> impression
>> that this group tries to consolidate most (all?) of the functionality into
>> the
>> driver, and not rely on userspace daemons. Maybe a lesson learnt from
>> iSCSI?
>
>
> Indeed that is a guideline that was taken early on. But
> auto-connect/auto-discovery is not something I think we'd like to
> implement in the kernel...

So to summarize your view on this topic:
* Agreed that user experience should be such that after an RDMA device reset
  everything should continue as before without admin intervention.
* Both for host and target stacks.
* This should not be handled by the driver itself.
* A userspace daemon that listens on udev events should retry the reconnects
  or re-binds using configfs.
