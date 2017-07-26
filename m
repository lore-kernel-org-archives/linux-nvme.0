From: alon@vastdata.com (Alon Horev)
Date: Wed, 26 Jul 2017 12:33:00 +0300
Subject: nvmet panics during high load
Message-ID: <CAF9HSikTcqojqWOx7cjBsv9fLCvbkU_f6-1CgQ16Wpb1f5oQ4g@mail.gmail.com>

Hi All,

This is my first post on this mailing list. Let me know if this is the
wrong place or format to post bugs in.

We're running nvmef using RDMA on kernel 4.11.8.
We found a zero-dereference bug in nvmet during high load and
identified the root cause:
The location according to current linux master (fd2b2c57) is
drivers/nvme/target/rdma.c at function nvmet_rdma_get_rsp line 170.
list_first_entry is called on the list of free responses (free_rsps)
which is empty and obviously unexpected. I added an assert to validate
that and also tested a hack that enlarges the queue times 10 and it
seemed to solve it.
It's probably not a leak but a miscalculation of the size of the queue
(queue->recv_queue_size * 2). Can anyone explain the rationale behind
this calculation? Is the queue assumed to never be empty?

I'd happily submit a patch. Just want to make sure it's the right one.

Thanks, Alon Horev
