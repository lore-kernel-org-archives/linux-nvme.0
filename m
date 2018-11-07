From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 6 Nov 2018 19:26:28 -0800
Subject: [RFC PATCH] nvme of: don't flush scan work inside reset context
In-Reply-To: <20181105115734.15515-1-ming.lei@redhat.com>
References: <20181105115734.15515-1-ming.lei@redhat.com>
Message-ID: <97aae455-fa74-b1aa-21f6-80c03732a573@grimberg.me>

Ming,

> When scan work is in-progress, any controller error may trigger
> reset, now fc, rdma and loop host tries to flush scan work
> inside reset context.
> 
> This way can cause deadlock easily because any IO during controler
> recovery(reset) can't be completed until the recovery is done.

Did you encounter this deadlock? or is it theoretical?

The point of nvme_stop_ctrl is to quiesce everything before
moving forward with tearing down the controller instead of
trying to handle concurrent incoming I/O.

I'm not sure I understand why you say that I/O can only be
completed when the reset is done? if the transport entered
a failed state either the inflight I/O is drain or one of
the scan work I/O operations times out.
