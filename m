From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 10 Jun 2016 10:11:22 -0500
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <055801d1c29f$e164c000$a42e4000$@opengridcomputing.com>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <20160609132459.GA5105@infradead.org>
 <1290178000.33062227.1465486654766.JavaMail.zimbra@kalray.eu>
 <04d301d1c28d$183af7b0$48b0e710$@opengridcomputing.com>
 <CAF1ivSb2fvjEzCxWXnrxv_i74SRm2qxWZ-RiKpEaGOx-Dk3f1A@mail.gmail.com>
 <04e301d1c292$d6c34430$8449cc90$@opengridcomputing.com>
 <CAF1ivSYBtsuvm-UO6osPAVT-krpF7iXqWy_8LheyWDDoAdWL1A@mail.gmail.com>
 <055801d1c29f$e164c000$a42e4000$@opengridcomputing.com>
Message-ID: <01c601d1c32a$59576ec0$0c064c40$@opengridcomputing.com>

> > What's the step to reproduce?
> 
> Add the hack into iw_cxgb4 to force alloc_mr failures after 200 allocations
> (or whatever value you need to make it happen).  Then on the same machine,
> export a target device, load nvme-rdma and discover/connect to that target
> device with nvme.  It will crash.
> 
> Unfortunately, with the 4.7-rc2 base I'm using, I get no vmcore dump.  I'm
> not sure why...
> 

Previously I was using Doug's rdma rxe branch + sagi's rxe fixes + rebased on nvmf-all.2.   To simplify, I have now gone to just straight nvmf-all.2.  Also, I separated the host and target to different nodes and reproduced the problem.  It?s the host side that is crashing.  Same GPF with RIP:

RIP: 0010:[<ffffffff810d04c3>]  [<ffffffff810d04c3>] get_next_timer_interrupt+0x183/0x210

Steve.
