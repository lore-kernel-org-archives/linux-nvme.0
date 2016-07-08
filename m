From: lhcwhu@gmail.com (Huaicheng Li)
Date: Fri, 8 Jul 2016 18:03:33 -0500
Subject: gain NVMe SQ in-flight entries #
Message-ID: <CANr0WEfCecCG4FKYtpdHxavj5AJGu+D2e2QsLwKe_77fKd-_yg@mail.gmail.com>

Hi all,

(1). When nvme_queue_rq() queues a new I/O to the SQ, why doesn't it
check whether the SQ is full or not?
Similarly, when nvme_process_rq() handles a CQE, it seems not checking
whether CQ is empty? Why is that?
(2). Why does nvme_queue_rq() need to call __nvme_process_cq()?? That
should be the job of interrupt handler or poll().
Anything missing here?
(3). Is there an easy way to figure out how many entries are in the
SQ? We can know where SQ_tail is in nvme_queue structure, how can the
host know where the queue's head is **immediately**?

Thanks.

Best,
Huaicheng
