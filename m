From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 22 Sep 2016 19:01:05 -0500
Subject: crash when connecting to targets using nr_io_queues < num cpus
In-Reply-To: <024201d2151d$28013b90$7803b2b0$@opengridcomputing.com>
References: <6082d700-a45c-b00a-3f09-ba6196cc3e5e@grimberg.me>
 <00ae01d2045a$a8516500$f8f42f00$@opengridcomputing.com>
 <01b401d20483$2da4fd20$88eef760$@opengridcomputing.com>
 <e31f7c2f-7b15-95f9-f882-4406c94eaedc@grimberg.me>
 <018701d20dca$22a02080$67e06180$@opengridcomputing.com>
 <20160913175223.GB13741@localhost.localdomain>
 <005101d21024$1f8913f0$5e9b3bd0$@opengridcomputing.com>
 <20160916142649.GA18798@infradead.org> <20160922210255.GA11015@infradead.org>
 <023c01d21519$b3cda450$1b68ecf0$@opengridcomputing.com>
 <20160922214800.GA16008@infradead.org>
 <024201d2151d$28013b90$7803b2b0$@opengridcomputing.com>
Message-ID: <022301d2152d$94c202e0$be4608a0$@opengridcomputing.com>

> > On Thu, Sep 22, 2016@04:38:48PM -0500, Steve Wise wrote:
> > > > Steve,
> > > >
> > > > can you test if the patch below properly fails the connect and
> avoids
> > > > the crash?
> > > >
> > >
> > > Is this the expected error?
> >
> > Yes.
> >
> 
> Ok then.  Tested-by: Steve Wise <swise at opengridcomputing.com>
> 
> I haven't tried ignoring this error when connecting yet...
> 
> Stevo

This patch seems to work:

@@ -639,6 +639,8 @@ static int nvme_rdma_connect_io_queues(struct
nvme_rdma_ctrl *ctrl)

        for (i = 1; i < ctrl->queue_count; i++) {
                ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
+               if (ret == -EXDEV)
+                       ret = 0;
                if (ret)
                        break;
        }

The fabrics module displays these errors.  But the 28 rdma connections still
get setup.  I'm not sure this is what we want, but it does avoid failing the
connect altogether...


[ 9438.483765] nvme nvme1: creating 28 I/O queues.
[ 9438.619877] nvme nvme1: Connect command failed, error wo/DNR bit: -16402
[ 9438.632542] nvme nvme1: Connect command failed, error wo/DNR bit: -16402
[ 9438.644857] nvme nvme1: Connect command failed, error wo/DNR bit: -16402
[ 9438.662090] nvme nvme1: Connect command failed, error wo/DNR bit: -16402
[ 9438.667138] nvme nvme1: Connect command failed, error wo/DNR bit: -16402
[ 9438.671875] nvme nvme1: Connect command failed, error wo/DNR bit: -16402
[ 9438.681345] nvme nvme1: Connect command failed, error wo/DNR bit: -16402
[ 9438.690364] nvme nvme1: Connect command failed, error wo/DNR bit: -16402
[ 9438.697611] nvme nvme1: Connect command failed, error wo/DNR bit: -16402
[ 9438.712055] nvme nvme1: Connect command failed, error wo/DNR bit: -16402
[ 9438.719229] nvme nvme1: Connect command failed, error wo/DNR bit: -16402
[ 9438.726399] nvme nvme1: Connect command failed, error wo/DNR bit: -16402
[ 9438.726406] nvme nvme1: new ctrl: NQN "test-ram0", addr 10.0.1.14:4420
